<template>
  <div class="restaurant-card">
    <div class="card-header">
      <div class="header-left">
        <h3>{{ restaurant.name }}</h3>
      </div>
      <div class="vote-count">
        <span class="vote-icon">⭐</span>
        {{ restaurant.vote_count }}
      </div>
    </div>

    <div class="card-body">
      <a :href="restaurant.google_link" target="_blank" rel="noopener noreferrer" class="google-link">
        <span class="map-icon">📍</span>
        View on Maps
      </a>
    </div>

    <div class="card-footer">
      <button
        @click="handleVote"
        :disabled="hasVoted || voteLimit"
        :class="{ voted: hasVoted, 'vote-limit': voteLimit }"
        class="vote-button"
      >
        <span class="button-icon" v-if="hasVoted">✓</span>
        <span class="button-icon" v-else-if="voteLimit">⚠️</span>
        <span class="button-icon" v-else>👍</span>
        <span class="button-text">
          <span v-if="hasVoted">Voted</span>
          <span v-else-if="voteLimit">Limit</span>
          <span v-else>Vote</span>
        </span>
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
/* Mobile-first responsive design */
.restaurant-card {
  background: white;
  border: 1px solid #e0e0e0;
  border-radius: 12px;
  padding: 12px;
  margin-bottom: 8px;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.08);
  transition: all 0.3s ease;
}

.restaurant-card:hover {
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.12);
  border-color: #4CAF50;
}

.card-header {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  gap: 8px;
  margin-bottom: 10px;
}

.header-left {
  flex: 1;
  min-width: 0;
}

.card-header h3 {
  margin: 0;
  font-size: 16px;
  color: #1a1a1a;
  font-weight: 600;
  word-wrap: break-word;
}

.vote-count {
  background: linear-gradient(135deg, #4CAF50 0%, #45a049 100%);
  color: white;
  padding: 6px 10px;
  border-radius: 20px;
  font-size: 13px;
  font-weight: 700;
  white-space: nowrap;
  display: flex;
  align-items: center;
  gap: 4px;
  flex-shrink: 0;
}

.vote-icon {
  font-size: 14px;
}

.card-body {
  margin-bottom: 10px;
}

.google-link {
  display: inline-flex;
  align-items: center;
  gap: 6px;
  color: #1976D2;
  text-decoration: none;
  font-size: 13px;
  padding: 6px 8px;
  border-radius: 6px;
  transition: all 0.2s ease;
  background: #e3f2fd;
}

.google-link:hover {
  background: #bbdefb;
  color: #0d47a1;
}

.map-icon {
  font-size: 16px;
}

.card-footer {
  display: flex;
  gap: 6px;
}

.vote-button {
  flex: 1;
  padding: 10px 12px;
  background: #4CAF50;
  color: white;
  border: none;
  border-radius: 8px;
  font-size: 13px;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.2s ease;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 6px;
  min-height: 40px;
}

.button-icon {
  font-size: 16px;
}

.button-text {
  flex: 1;
  text-align: center;
}

.vote-button:hover:not(:disabled) {
  background: #45a049;
  transform: translateY(-2px);
  box-shadow: 0 4px 8px rgba(76, 175, 80, 0.3);
}

.vote-button:active:not(:disabled) {
  transform: translateY(0);
}

.vote-button:disabled {
  opacity: 0.65;
  cursor: not-allowed;
}

.vote-button.voted {
  background: linear-gradient(135deg, #81C784 0%, #66BB6A 100%);
}

.vote-button.vote-limit {
  background: linear-gradient(135deg, #FFA726 0%, #FF9800 100%);
}

.error-message {
  color: #c62828;
  font-size: 12px;
  margin-top: 8px;
  padding: 8px 10px;
  background: #ffebee;
  border-radius: 6px;
  border-left: 3px solid #c62828;
}

.loading {
  color: #666;
  font-size: 12px;
  margin-top: 8px;
  text-align: center;
  animation: pulse 1.5s ease-in-out infinite;
}

@keyframes pulse {
  0%, 100% { opacity: 1; }
  50% { opacity: 0.6; }
}

/* Tablet and larger screens */
@media (min-width: 640px) {
  .restaurant-card {
    padding: 16px;
    margin-bottom: 12px;
    border-radius: 12px;
  }

  .card-header h3 {
    font-size: 18px;
  }

  .vote-button {
    padding: 10px 16px;
    font-size: 14px;
  }

  .button-text {
    display: inline;
  }
}

/* Desktop screens */
@media (min-width: 1024px) {
  .restaurant-card {
    padding: 18px;
  }

  .card-header h3 {
    font-size: 20px;
  }

  .google-link {
    font-size: 14px;
  }
}
</style>
