<template>
  <div class="min-h-screen bg-gradient-to-br from-gray-50 to-gray-100 py-6 px-4 sm:px-6 lg:px-8">
    <div class="max-w-6xl mx-auto">
      <!-- Header with Stats -->
      <div class="mb-8">
        <div class="text-center mb-6">
          <h1 class="text-4xl font-bold text-gray-900 mb-2 flex items-center justify-center gap-3">
            <TrophyIcon class="w-10 h-10 text-amber-500" />
            Best Restaurants in Riyadh
          </h1>
          <p class="text-gray-600">Vote for your favorite restaurants and help others discover great places!</p>
        </div>

        <!-- Stats Cards -->
        <div class="grid grid-cols-1 md:grid-cols-4 gap-4 mb-6">
          <div class="card p-6 hover:border-primary-500 transition-all">
            <div class="flex items-center gap-4">
              <div class="p-3 bg-primary-100 rounded-full">
                <StoreIcon class="w-6 h-6 text-primary-600" />
              </div>
              <div>
                <p class="text-sm text-gray-600 font-medium">Total Restaurants</p>
                <p class="text-2xl font-bold text-gray-900">{{ stats.totalRestaurants }}</p>
              </div>
            </div>
          </div>

          <div class="card p-6 hover:border-amber-500 transition-all">
            <div class="flex items-center gap-4">
              <div class="p-3 bg-amber-100 rounded-full">
                <StarIcon class="w-6 h-6 text-amber-600" />
              </div>
              <div>
                <p class="text-sm text-gray-600 font-medium">Total Votes</p>
                <p class="text-2xl font-bold text-gray-900">{{ stats.totalVotes }}</p>
              </div>
            </div>
          </div>

          <div class="card p-6 hover:border-blue-500 transition-all">
            <div class="flex items-center gap-4">
              <div class="p-3 bg-blue-100 rounded-full">
                <CheckCircleIcon class="w-6 h-6 text-blue-600" />
              </div>
              <div>
                <p class="text-sm text-gray-600 font-medium">Your Votes</p>
                <p class="text-2xl font-bold text-gray-900">{{ userVoteCount }}<span class="text-sm text-gray-500">/5</span></p>
              </div>
            </div>
          </div>

          <div class="card p-6 hover:border-purple-500 transition-all">
            <div class="flex items-center gap-4">
              <div class="p-3 bg-purple-100 rounded-full">
                <TrendingUpIcon class="w-6 h-6 text-purple-600" />
              </div>
              <div>
                <p class="text-sm text-gray-600 font-medium">Showing</p>
                <p class="text-2xl font-bold text-gray-900">{{ restaurants.length }}</p>
              </div>
            </div>
          </div>
        </div>

        <!-- Vote Limit Banner -->
        <div v-if="userVoteCount >= 5" class="bg-gradient-to-r from-blue-50 to-indigo-50 border-l-4 border-blue-500 p-4 rounded-lg mb-6">
          <div class="flex items-center gap-3">
            <InfoIcon class="w-5 h-5 text-blue-600 flex-shrink-0" />
            <p class="text-blue-900 font-medium">You've used all 5 votes! Thanks for participating. 🎉</p>
          </div>
        </div>
      </div>

      <!-- Loading State -->
      <div v-if="isLoading" class="flex flex-col items-center justify-center py-20">
        <div class="relative">
          <div class="w-16 h-16 border-4 border-gray-200 border-t-primary-600 rounded-full animate-spin"></div>
        </div>
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

      <!-- Restaurant List -->
      <div v-else class="space-y-4">
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
  Star as StarIcon,
  CheckCircle as CheckCircleIcon,
  TrendingUp as TrendingUpIcon,
  Info as InfoIcon
} from 'lucide-vue-next';

export default {
  name: 'RestaurantList',
  components: {
    RestaurantCard,
    TrophyIcon,
    StoreIcon,
    StarIcon,
    CheckCircleIcon,
    TrendingUpIcon,
    InfoIcon
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
        // Load all data in parallel - fixes N+1 query problem
        const [restaurants, votedIds, voteCount, stats] = await Promise.all([
          getTopRestaurants(1000),
          getUserVotedRestaurants(),
          getUserVoteCount(),
          getRestaurantStats()
        ]);

        this.restaurants = restaurants.sort((a, b) => b.vote_count - a.vote_count);
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
