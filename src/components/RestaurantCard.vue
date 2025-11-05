<template>
  <div class="card p-6 hover:shadow-lg hover:scale-[1.01] transition-all duration-200 group">
    <div class="flex items-start gap-4">
      <!-- Rank Badge -->
      <div class="flex-shrink-0">
        <div :class="rankBadgeClass" class="w-12 h-12 rounded-full flex items-center justify-center font-bold text-lg shadow-md">
          {{ rank }}
        </div>
      </div>

      <!-- Restaurant Info -->
      <div class="flex-1 min-w-0">
        <div class="flex items-start justify-between gap-4 mb-3">
          <h3 class="text-xl font-bold text-gray-900 group-hover:text-primary-600 transition-colors">
            {{ restaurant.name }}
          </h3>

          <!-- Vote Count Badge -->
          <div class="flex items-center gap-2 bg-gradient-to-r from-amber-50 to-yellow-50 px-4 py-2 rounded-full border border-amber-200 shadow-sm flex-shrink-0">
            <StarIcon class="w-5 h-5 text-amber-500 fill-amber-500" />
            <span class="font-bold text-gray-900">{{ restaurant.vote_count }}</span>
            <span class="text-xs text-gray-600">{{ restaurant.vote_count === 1 ? 'vote' : 'votes' }}</span>
          </div>
        </div>

        <!-- Google Maps Link -->
        <a
          :href="restaurant.google_link"
          target="_blank"
          rel="noopener noreferrer"
          class="inline-flex items-center gap-2 text-blue-600 hover:text-blue-700 font-medium mb-4 group/link"
        >
          <MapPinIcon class="w-4 h-4 group-hover/link:scale-110 transition-transform" />
          <span class="underline decoration-blue-300 group-hover/link:decoration-blue-600">View on Google Maps</span>
          <ExternalLinkIcon class="w-3 h-3 opacity-50" />
        </a>

        <!-- Vote Button -->
        <div class="flex items-center gap-3">
          <button
            @click="handleVote"
            :disabled="hasVoted || voteLimitReached || isLoading"
            :class="buttonClass"
            class="flex-1 sm:flex-initial px-6 py-3 rounded-lg font-semibold transition-all duration-200 flex items-center justify-center gap-2 shadow-md hover:shadow-lg disabled:shadow-sm"
          >
            <component :is="buttonIcon" class="w-5 h-5" :class="buttonIconClass" />
            <span>{{ buttonText }}</span>
            <Loader2Icon v-if="isLoading" class="w-4 h-4 animate-spin ml-1" />
          </button>

          <!-- Vote Status Indicator -->
          <div v-if="hasVoted" class="hidden sm:flex items-center gap-2 text-primary-600 font-medium">
            <CheckCircleIcon class="w-5 h-5" />
            <span class="text-sm">You voted!</span>
          </div>
        </div>

        <!-- Error Message -->
        <div v-if="error" class="mt-3 bg-red-50 border-l-4 border-red-500 p-3 rounded">
          <div class="flex items-start gap-2">
            <AlertCircleIcon class="w-5 h-5 text-red-600 flex-shrink-0 mt-0.5" />
            <p class="text-sm text-red-800 font-medium">{{ error }}</p>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { recordVote } from '../utils/restaurants';
import {
  Star as StarIcon,
  MapPin as MapPinIcon,
  ExternalLink as ExternalLinkIcon,
  ThumbsUp as ThumbsUpIcon,
  CheckCircle as CheckCircleIcon,
  AlertCircle as AlertCircleIcon,
  Loader2 as Loader2Icon,
  Lock as LockIcon
} from 'lucide-vue-next';

export default {
  name: 'RestaurantCard',
  components: {
    StarIcon,
    MapPinIcon,
    ExternalLinkIcon,
    ThumbsUpIcon,
    CheckCircleIcon,
    AlertCircleIcon,
    Loader2Icon,
    LockIcon
  },
  props: {
    restaurant: {
      type: Object,
      required: true
    },
    rank: {
      type: Number,
      required: true
    },
    hasVoted: {
      type: Boolean,
      default: false
    },
    voteLimitReached: {
      type: Boolean,
      default: false
    }
  },
  data() {
    return {
      isLoading: false,
      error: null
    };
  },
  computed: {
    rankBadgeClass() {
      if (this.rank === 1) {
        return 'bg-gradient-to-br from-yellow-400 to-amber-500 text-white border-2 border-yellow-300';
      } else if (this.rank === 2) {
        return 'bg-gradient-to-br from-gray-300 to-gray-400 text-white border-2 border-gray-200';
      } else if (this.rank === 3) {
        return 'bg-gradient-to-br from-orange-400 to-orange-600 text-white border-2 border-orange-300';
      } else {
        return 'bg-gradient-to-br from-primary-500 to-primary-600 text-white';
      }
    },
    buttonClass() {
      if (this.hasVoted) {
        return 'bg-gradient-to-r from-primary-100 to-primary-200 text-primary-800 border-2 border-primary-300 cursor-not-allowed';
      } else if (this.voteLimitReached) {
        return 'bg-gradient-to-r from-gray-100 to-gray-200 text-gray-600 border-2 border-gray-300 cursor-not-allowed';
      } else {
        return 'bg-gradient-to-r from-primary-600 to-primary-700 text-white hover:from-primary-700 hover:to-primary-800 active:scale-95';
      }
    },
    buttonText() {
      if (this.isLoading) return 'Voting...';
      if (this.hasVoted) return 'Voted';
      if (this.voteLimitReached) return 'Vote Limit Reached';
      return 'Vote';
    },
    buttonIcon() {
      if (this.hasVoted) return CheckCircleIcon;
      if (this.voteLimitReached) return LockIcon;
      return ThumbsUpIcon;
    },
    buttonIconClass() {
      if (this.hasVoted) return 'fill-primary-600';
      if (this.voteLimitReached) return '';
      return '';
    }
  },
  methods: {
    async handleVote() {
      if (this.hasVoted || this.voteLimitReached || this.isLoading) return;

      this.isLoading = true;
      this.error = null;

      try {
        await recordVote(this.restaurant.id);
        this.$emit('voted');
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
