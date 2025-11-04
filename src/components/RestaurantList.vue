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
        const data = await getTopRestaurants(100);
        // Sort by vote count (highest first)
        this.restaurants = data.sort((a, b) => b.vote_count - a.vote_count);
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
      // Subscribe to changes in votes table (INSERT and UPDATE)
      supabase
        .channel('votes')
        .on(
          'postgres_changes',
          { event: '*', schema: 'public', table: 'votes' },
          () => {
            this.refreshRestaurants();
          }
        )
        .subscribe();

      // Subscribe to changes in restaurants table (INSERT and UPDATE)
      supabase
        .channel('restaurants')
        .on(
          'postgres_changes',
          { event: '*', schema: 'public', table: 'restaurants' },
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
/* Mobile-first responsive design */
.restaurant-list-container {
  width: 100%;
  margin: 0 auto;
  padding: 12px;
}

.header {
  margin-bottom: 20px;
  background: linear-gradient(135deg, #4CAF50 0%, #45a049 100%);
  padding: 16px;
  border-radius: 12px;
  color: white;
}

.header h1 {
  margin: 0 0 12px 0;
  color: white;
  font-size: 22px;
  font-weight: 700;
}

.stats {
  display: flex;
  gap: 16px;
  flex-wrap: wrap;
}

.stat {
  display: flex;
  flex-direction: column;
  gap: 4px;
  background: rgba(255, 255, 255, 0.2);
  padding: 10px 12px;
  border-radius: 8px;
  flex: 1;
  min-width: 140px;
}

.stat-label {
  color: rgba(255, 255, 255, 0.9);
  font-size: 11px;
  font-weight: 600;
  text-transform: uppercase;
  letter-spacing: 0.5px;
}

.stat-value {
  color: white;
  font-size: 22px;
  font-weight: 700;
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
  border: 4px solid #f0f0f0;
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
  background: white;
  border: 2px dashed #e0e0e0;
  border-radius: 12px;
  font-size: 15px;
}

.restaurants-grid {
  display: grid;
  gap: 8px;
}

.rank {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  background: linear-gradient(135deg, #4CAF50 0%, #45a049 100%);
  color: white;
  width: 32px;
  height: 32px;
  border-radius: 50%;
  font-size: 12px;
  font-weight: 700;
}

.vote-limit-banner {
  margin-top: 20px;
  padding: 14px 16px;
  background: linear-gradient(135deg, #e3f2fd 0%, #bbdefb 100%);
  border-left: 4px solid #1976D2;
  border-radius: 8px;
  color: #1565c0;
  font-size: 13px;
  font-weight: 500;
  text-align: center;
}

/* Tablet screens */
@media (min-width: 640px) {
  .restaurant-list-container {
    padding: 16px;
  }

  .header {
    padding: 20px;
    margin-bottom: 24px;
  }

  .header h1 {
    font-size: 26px;
  }

  .stat {
    min-width: 160px;
    padding: 12px 14px;
  }

  .restaurants-grid {
    gap: 10px;
  }
}

/* Desktop screens */
@media (min-width: 1024px) {
  .restaurant-list-container {
    max-width: 1000px;
    margin: 0 auto;
    padding: 20px;
  }

  .header {
    padding: 24px;
    margin-bottom: 32px;
  }

  .header h1 {
    font-size: 28px;
  }

  .stat {
    min-width: 180px;
  }

  .restaurants-grid {
    gap: 12px;
  }
}
</style>
