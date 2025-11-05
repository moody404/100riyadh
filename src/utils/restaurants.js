import { supabase } from '../supabaseClient';
import { getDeviceId } from './deviceId';

/**
 * Get all restaurants sorted by vote count (removed limit for better display)
 */
export async function getTopRestaurants(limit = 1000) {
  const { data, error } = await supabase
    .from('restaurants')
    .select('*')
    .order('vote_count', { ascending: false })
    .limit(limit);

  if (error) {
    console.error('Error fetching restaurants:', error);
    throw error;
  }

  return data || [];
}

/**
 * Get restaurant statistics
 */
export async function getRestaurantStats() {
  try {
    // Get total restaurants
    const { count: totalRestaurants, error: restaurantError } = await supabase
      .from('restaurants')
      .select('*', { count: 'exact', head: true });

    if (restaurantError) throw restaurantError;

    // Get total votes
    const { count: totalVotes, error: voteError } = await supabase
      .from('votes')
      .select('*', { count: 'exact', head: true });

    if (voteError) throw voteError;

    return {
      totalRestaurants: totalRestaurants || 0,
      totalVotes: totalVotes || 0
    };
  } catch (error) {
    console.error('Error fetching stats:', error);
    return {
      totalRestaurants: 0,
      totalVotes: 0
    };
  }
}

/**
 * Create a new restaurant
 */
export async function createRestaurant(name, googleLink, imageUrl = null) {
  const deviceId = getDeviceId();

  // Check if user already created a restaurant
  const { count, error: countError } = await supabase
    .from('restaurants')
    .select('*', { count: 'exact', head: true })
    .eq('created_by_device_id', deviceId);

  if (countError) {
    console.error('Error checking restaurant limit:', countError);
    throw countError;
  }

  if (count > 0) {
    throw new Error('You can only create one restaurant. Please vote on existing ones instead!');
  }

  // Create the restaurant with image URL
  const restaurantData = {
    name,
    google_link: googleLink,
    vote_count: 0, // Will be auto-incremented to 1 by trigger when creator votes
    created_by_device_id: deviceId,
    status: 'approved'
  };

  // Add image URL if provided, otherwise use default
  if (imageUrl && imageUrl.trim() !== '') {
    restaurantData.image_url = imageUrl.trim();
  }

  const { data, error } = await supabase
    .from('restaurants')
    .insert([restaurantData])
    .select();

  if (error) {
    console.error('Error creating restaurant:', error);
    throw error;
  }

  // Record the creator's vote
  if (data && data.length > 0) {
    await recordVote(data[0].id);
  }

  return data ? data[0] : null;
}

/**
 * Get user's vote count
 */
export async function getUserVoteCount() {
  const deviceId = getDeviceId();

  const { data, error } = await supabase
    .from('votes')
    .select('*')
    .eq('device_id', deviceId);

  if (error) {
    console.error('Error fetching vote count:', error);
    throw error;
  }

  return data ? data.length : 0;
}

/**
 * Get restaurants the user has voted on
 */
export async function getUserVotedRestaurants() {
  const deviceId = getDeviceId();

  const { data, error } = await supabase
    .from('votes')
    .select('restaurant_id')
    .eq('device_id', deviceId);

  if (error) {
    console.error('Error fetching user votes:', error);
    throw error;
  }

  return data ? data.map(v => v.restaurant_id) : [];
}

/**
 * Record a vote for a restaurant
 */
export async function recordVote(restaurantId) {
  const deviceId = getDeviceId();

  // Check if user has already voted for this restaurant
  const { data: existingVotes, error: checkError } = await supabase
    .from('votes')
    .select('*')
    .eq('restaurant_id', restaurantId)
    .eq('device_id', deviceId);

  if (checkError) {
    console.error('Error checking vote:', checkError);
    throw checkError;
  }

  if (existingVotes && existingVotes.length > 0) {
    throw new Error('You have already voted for this restaurant!');
  }

  // Check if user has reached vote limit (5)
  const voteCount = await getUserVoteCount();
  if (voteCount >= 5) {
    throw new Error('You have reached your voting limit (5 votes). You cannot vote for more restaurants.');
  }

  // Record the vote (database trigger will automatically update vote_count)
  const { data, error } = await supabase
    .from('votes')
    .insert([
      {
        restaurant_id: restaurantId,
        device_id: deviceId
      }
    ])
    .select();

  if (error) {
    console.error('Error recording vote:', error);
    throw error;
  }

  // Note: vote_count is now automatically updated by database trigger
  // No need to manually increment it anymore!

  return data ? data[0] : null;
}
