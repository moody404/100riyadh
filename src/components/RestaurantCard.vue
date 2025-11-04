<template>
  <div class="restaurant-card">
    <div class="card-header">
      <h3>{{ restaurant.name }}</h3>
      <div class="vote-count">{{ restaurant.vote_count }} votes</div>
    </div>

    <div class="card-body">
      <a :href="restaurant.google_link" target="_blank" rel="noopener noreferrer" class="google-link">
        View on Google Maps
      </a>
    </div>

    <div class="card-footer">
      <button
        @click="handleVote"
        :disabled="hasVoted || voteLimit"
        :class="{ voted: hasVoted, 'vote-limit': voteLimit }"
        class="vote-button"
      >
        <span v-if="hasVoted">✓ Voted</span>
        <span v-else-if="voteLimit">Vote Limit Reached</span>
        <span v-else>👍 Vote</span>
      </button>
    </div>

    <div v-if="error" class="error-message">
      {{ error }}
    </div>

    <div v-if="isLoading" class="loading">
      Voting...
    </div>
  </div>
</template>

<script>
import { recordVote, getUserVotedRestaurants, getUserVoteCount } from '../utils/restaurants';

export default {
  name: 'RestaurantCard',
  props: {
    restaurant: {
      type: Object,
      required: true
    }
  },
  data() {
    return {
      hasVoted: false,
      voteLimit: false,
      isLoading: false,
      error: null
    };
  },
  async mounted() {
    await this.checkVoteStatus();
  },
  methods: {
    async checkVoteStatus() {
      try {
        const votedRestaurants = await getUserVotedRestaurants();
        this.hasVoted = votedRestaurants.includes(this.restaurant.id);

        const voteCount = await getUserVoteCount();
        this.voteLimit = voteCount >= 5 && !this.hasVoted;
      } catch (err) {
        console.error('Error checking vote status:', err);
      }
    },
    async handleVote() {
      if (this.hasVoted || this.voteLimit || this.isLoading) return;

      this.isLoading = true;
      this.error = null;

      try {
        await recordVote(this.restaurant.id);
        this.hasVoted = true;

        // Emit event to parent to refresh restaurant list
        this.$emit('voted');

        // Update vote limit status
        const voteCount = await getUserVoteCount();
        this.voteLimit = voteCount >= 5;
      } catch (err) {
        this.error = err.message;
        console.error('Voting error:', err);
      } finally {
        this.isLoading = false;
      }
    }
  }
};
</script>

<style scoped>
.restaurant-card {
  background: white;
  border: 1px solid #e0e0e0;
  border-radius: 8px;
  padding: 16px;
  margin-bottom: 12px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
  transition: all 0.3s ease;
}

.restaurant-card:hover {
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
  border-color: #4CAF50;
}

.card-header {
  display: flex;
  justify-content: space-between;
  align-items: start;
  margin-bottom: 12px;
}

.card-header h3 {
  margin: 0;
  font-size: 18px;
  color: #333;
  flex: 1;
}

.vote-count {
  background: #4CAF50;
  color: white;
  padding: 4px 12px;
  border-radius: 20px;
  font-size: 12px;
  font-weight: bold;
  white-space: nowrap;
  margin-left: 12px;
}

.card-body {
  margin-bottom: 12px;
}

.google-link {
  display: inline-block;
  color: #1976D2;
  text-decoration: none;
  font-size: 14px;
  padding: 8px 0;
  border-bottom: 1px solid transparent;
  transition: all 0.2s ease;
}

.google-link:hover {
  border-bottom-color: #1976D2;
}

.card-footer {
  display: flex;
  gap: 8px;
}

.vote-button {
  flex: 1;
  padding: 8px 16px;
  background: #4CAF50;
  color: white;
  border: none;
  border-radius: 4px;
  font-size: 14px;
  font-weight: bold;
  cursor: pointer;
  transition: all 0.2s ease;
}

.vote-button:hover:not(:disabled) {
  background: #45a049;
  transform: translateY(-2px);
  box-shadow: 0 2px 6px rgba(76, 175, 80, 0.3);
}

.vote-button:disabled {
  opacity: 0.6;
  cursor: not-allowed;
}

.vote-button.voted {
  background: #95C695;
}

.vote-button.vote-limit {
  background: #FFA726;
}

.error-message {
  color: #d32f2f;
  font-size: 12px;
  margin-top: 8px;
  padding: 8px;
  background: #ffebee;
  border-radius: 4px;
}

.loading {
  color: #666;
  font-size: 12px;
  margin-top: 8px;
  text-align: center;
}
</style>
