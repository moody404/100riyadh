<template>
  <div class="restaurant-list-container">
    <div class="header">
      <h1>Top 100 Restaurants in Riyadh</h1>
      <div class="stats">
        <div class="stat">
          <span class="stat-label">Total Restaurants</span>
          <span class="stat-value">{{ restaurants.length }}</span>
        </div>
        <div class="stat">
          <span class="stat-label">Your Votes</span>
          <span class="stat-value">{{ userVoteCount }}/5</span>
        </div>
      </div>
    </div>

    <div v-if="isLoading" class="loading-state">
      <div class="spinner"></div>
      <p>Loading restaurants...</p>
    </div>

    <div v-else-if="restaurants.length === 0" class="empty-state">
      <p>No restaurants yet. Be the first to add one!</p>
    </div>

    <div v-else class="restaurants-grid">
      <RestaurantCard
        v-for="(restaurant, index) in restaurants"
        :key="restaurant.id"
        :restaurant="restaurant"
        @voted="refreshRestaurants"
      >
        <template #header>
          <span class="rank">#{{ index + 1 }}</span>
        </template>
      </RestaurantCard>
    </div>

    <div v-if="userVoteCount >= 5" class="vote-limit-banner">
      You've used all 5 votes! Thanks for voting.
    </div>
  </div>
</template>

<script>
import RestaurantCard from './RestaurantCard.vue';
import { getTopRestaurants, getUserVoteCount } from '../utils/restaurants';
import { supabase } from '../supabaseClient';

export default {
  name: 'RestaurantList',
  components: {
    RestaurantCard
  },
  data() {
    return {
      restaurants: [],
      userVoteCount: 0,
      isLoading: true
    };
  },
  async mounted() {
    await this.loadRestaurants();
    await this.loadUserVoteCount();
    this.setupRealtimeListener();
  },
  methods: {
    async loadRestaurants() {
      this.isLoading = true;
      try {
        this.restaurants = await getTopRestaurants(100);
      } catch (err) {
        console.error('Error loading restaurants:', err);
      } finally {
        this.isLoading = false;
      }
    },
    async loadUserVoteCount() {
      try {
        this.userVoteCount = await getUserVoteCount();
      } catch (err) {
        console.error('Error loading user vote count:', err);
      }
    },
    async refreshRestaurants() {
      await this.loadRestaurants();
      await this.loadUserVoteCount();
    },
    setupRealtimeListener() {
      // Subscribe to changes in votes table
      supabase
        .channel('votes')
        .on(
          'postgres_changes',
          { event: 'INSERT', schema: 'public', table: 'votes' },
          () => {
            this.refreshRestaurants();
          }
        )
        .subscribe();

      // Subscribe to changes in restaurants table
      supabase
        .channel('restaurants')
        .on(
          'postgres_changes',
          { event: 'INSERT', schema: 'public', table: 'restaurants' },
          () => {
            this.refreshRestaurants();
          }
        )
        .subscribe();
    }
  },
  beforeUnmount() {
    // Clean up subscriptions
    supabase.removeAllChannels();
  }
};
</script>

<style scoped>
.restaurant-list-container {
  max-width: 1000px;
  margin: 0 auto;
  padding: 20px;
}

.header {
  margin-bottom: 32px;
}

.header h1 {
  margin: 0 0 16px 0;
  color: #333;
  font-size: 28px;
}

.stats {
  display: flex;
  gap: 24px;
}

.stat {
  display: flex;
  flex-direction: column;
  gap: 4px;
}

.stat-label {
  color: #666;
  font-size: 12px;
  font-weight: 600;
  text-transform: uppercase;
  letter-spacing: 0.5px;
}

.stat-value {
  color: #4CAF50;
  font-size: 24px;
  font-weight: bold;
}

.loading-state {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: 60px 20px;
  color: #666;
}

.spinner {
  width: 40px;
  height: 40px;
  border: 4px solid #f3f3f3;
  border-top: 4px solid #4CAF50;
  border-radius: 50%;
  animation: spin 1s linear infinite;
  margin-bottom: 16px;
}

@keyframes spin {
  0% { transform: rotate(0deg); }
  100% { transform: rotate(360deg); }
}

.empty-state {
  text-align: center;
  padding: 60px 20px;
  color: #999;
  background: #f9f9f9;
  border-radius: 8px;
}

.restaurants-grid {
  display: grid;
  gap: 12px;
}

.rank {
  display: inline-block;
  background: #4CAF50;
  color: white;
  padding: 4px 12px;
  border-radius: 20px;
  font-size: 12px;
  font-weight: bold;
  margin-right: 8px;
}

.vote-limit-banner {
  margin-top: 32px;
  padding: 16px;
  background: #e3f2fd;
  border-left: 4px solid #1976D2;
  border-radius: 4px;
  color: #1565c0;
  font-size: 14px;
  text-align: center;
}
</style>
