<template>
  <div class="min-h-screen bg-gray-50 py-8 px-4 sm:px-6 lg:px-8">
    <div class="max-w-7xl mx-auto">
      <!-- Simple Header -->
      <div class="text-center mb-8">
        <h1 class="text-4xl font-bold text-gray-900 mb-2 flex items-center justify-center gap-3">
          <TrophyIcon class="w-10 h-10 text-amber-500" />
          Best Restaurants in Riyadh
        </h1>
        <p class="text-gray-600 text-lg">
          {{ restaurants.length }} restaurants • {{ stats.totalVotes }} total votes • Your votes: {{ userVoteCount }}/5
        </p>
      </div>

      <!-- Vote Limit Banner -->
      <div v-if="userVoteCount >= 5" class="max-w-2xl mx-auto bg-gradient-to-r from-blue-50 to-indigo-50 border border-blue-200 p-4 rounded-lg mb-8">
        <div class="flex items-center justify-center gap-2">
          <CheckCircleIcon class="w-5 h-5 text-blue-600" />
          <p class="text-blue-900 font-medium">You've used all 5 votes! Thanks for participating. 🎉</p>
        </div>
      </div>

      <!-- Loading State -->
      <div v-if="isLoading" class="flex flex-col items-center justify-center py-20">
        <div class="w-16 h-16 border-4 border-gray-200 border-t-primary-600 rounded-full animate-spin"></div>
        <p class="mt-4 text-gray-600 font-medium">Loading restaurants...</p>
      </div>

      <!-- Empty State -->
      <div v-else-if="restaurants.length === 0" class="text-center py-20">
        <div class="inline-flex items-center justify-center w-20 h-20 bg-gray-100 rounded-full mb-4">
          <StoreIcon class="w-10 h-10 text-gray-400" />
        </div>
        <h3 class="text-xl font-semibold text-gray-900 mb-2">No restaurants yet</h3>
        <p class="text-gray-600 mb-6">Be the first to add a restaurant to the list!</p>
      </div>

      <!-- Restaurant Grid -->
      <div v-else class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-6">
        <RestaurantCard
          v-for="(restaurant, index) in restaurants"
          :key="restaurant.id"
          :restaurant="restaurant"
          :rank="index + 1"
          :has-voted="votedRestaurantIds.includes(restaurant.id)"
          :vote-limit-reached="userVoteCount >= 5 && !votedRestaurantIds.includes(restaurant.id)"
          @voted="handleVoted"
        />
      </div>

      <!-- Debug Info (remove after testing) -->
      <div v-if="!isLoading" class="mt-8 p-4 bg-yellow-50 border border-yellow-200 rounded-lg text-sm space-y-2">
        <p class="font-semibold text-yellow-900">Debug Info:</p>
        <p class="text-yellow-800">Restaurants loaded: {{ restaurants.length }}</p>
        <p class="text-yellow-800">Total restaurants in DB: {{ stats.totalRestaurants }}</p>
        <p class="text-yellow-800">Total votes in DB: {{ stats.totalVotes }}</p>
        <p class="text-yellow-800">Your voted restaurants: {{ votedRestaurantIds.length }}</p>
        <details class="mt-2">
          <summary class="cursor-pointer text-yellow-900 font-semibold hover:underline">Show all restaurant names</summary>
          <ul class="mt-2 pl-4 space-y-1">
            <li v-for="(r, idx) in restaurants" :key="r.id" class="text-yellow-800 text-xs">
              {{ idx + 1 }}. {{ r.name }} - {{ r.vote_count }} votes (ID: {{ r.id ? 'exists' : 'MISSING' }})
            </li>
          </ul>
        </details>
      </div>
    </div>
  </div>
</template>

<script>
import RestaurantCard from './RestaurantCard.vue';
import { getTopRestaurants, getUserVoteCount, getUserVotedRestaurants, getRestaurantStats } from '../utils/restaurants';
import { supabase } from '../supabaseClient';
import {
  Trophy as TrophyIcon,
  Store as StoreIcon,
  CheckCircle as CheckCircleIcon
} from 'lucide-vue-next';

export default {
  name: 'RestaurantList',
  components: {
    RestaurantCard,
    TrophyIcon,
    StoreIcon,
    CheckCircleIcon
  },
  data() {
    return {
      restaurants: [],
      votedRestaurantIds: [],
      userVoteCount: 0,
      stats: {
        totalRestaurants: 0,
        totalVotes: 0
      },
      isLoading: true
    };
  },
  async mounted() {
    await this.loadData();
    this.setupRealtimeListener();
  },
  methods: {
    async loadData() {
      this.isLoading = true;
      try {
        console.log('Loading restaurants...');

        // Load all data in parallel
        const [restaurants, votedIds, voteCount, stats] = await Promise.all([
          getTopRestaurants(1000),
          getUserVotedRestaurants(),
          getUserVoteCount(),
          getRestaurantStats()
        ]);

        console.log('Restaurants loaded:', restaurants.length);
        console.log('Stats:', stats);
        console.log('Full restaurant data:', restaurants);

        // Check for missing fields
        restaurants.forEach((r, index) => {
          if (!r.id) console.error(`Restaurant ${index} missing ID:`, r);
          if (!r.name) console.error(`Restaurant ${index} missing name:`, r);
          if (!r.google_link) console.error(`Restaurant ${index} missing google_link:`, r);
          if (r.vote_count === undefined || r.vote_count === null) {
            console.warn(`Restaurant "${r.name}" has invalid vote_count:`, r.vote_count);
          }
        });

        this.restaurants = restaurants.sort((a, b) => b.vote_count - a.vote_count);

        console.log('Restaurants after sorting:', this.restaurants.length);
        console.log('First 5 restaurants:', this.restaurants.slice(0, 5));
        this.votedRestaurantIds = votedIds;
        this.userVoteCount = voteCount;
        this.stats = stats;
      } catch (err) {
        console.error('Error loading data:', err);
      } finally {
        this.isLoading = false;
      }
    },
    async handleVoted() {
      await this.loadData();
    },
    setupRealtimeListener() {
      // Subscribe to changes in votes table
      supabase
        .channel('votes')
        .on(
          'postgres_changes',
          { event: '*', schema: 'public', table: 'votes' },
          () => {
            console.log('Vote change detected, reloading...');
            this.loadData();
          }
        )
        .subscribe();

      // Subscribe to changes in restaurants table
      supabase
        .channel('restaurants')
        .on(
          'postgres_changes',
          { event: '*', schema: 'public', table: 'restaurants' },
          () => {
            console.log('Restaurant change detected, reloading...');
            this.loadData();
          }
        )
        .subscribe();
    }
  },
  beforeUnmount() {
    supabase.removeAllChannels();
  }
};
</script>
