<template>
  <div class="group relative bg-white rounded-xl shadow-md overflow-hidden hover:shadow-2xl transition-all duration-300 hover:-translate-y-1">
    <!-- Rank Badge -->
    <div class="absolute top-3 left-3 z-10">
      <div :class="rankBadgeClass" class="w-10 h-10 rounded-full flex items-center justify-center font-bold text-sm shadow-lg backdrop-blur-sm">
        {{ rank }}
      </div>
    </div>

    <!-- Vote Count Badge -->
    <div class="absolute top-3 right-3 z-10">
      <div class="flex items-center gap-1 bg-white/90 backdrop-blur-sm px-3 py-1.5 rounded-full shadow-md">
        <StarIcon class="w-4 h-4 text-amber-500 fill-amber-500" />
        <span class="font-bold text-gray-900 text-sm">{{ restaurant.vote_count }}</span>
      </div>
    </div>

    <!-- Restaurant Image -->
    <div class="relative h-48 overflow-hidden bg-gray-200">
      <img
        :src="restaurant.image_url || 'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=800&q=80'"
        :alt="restaurant.name"
        class="w-full h-full object-cover group-hover:scale-110 transition-transform duration-500"
        @error="handleImageError"
      />
      <div class="absolute inset-0 bg-gradient-to-t from-black/60 via-black/0 to-black/0"></div>
    </div>

    <!-- Content -->
    <div class="p-4">
      <!-- Restaurant Name -->
      <h3 class="text-lg font-bold text-gray-900 mb-2 line-clamp-1 group-hover:text-primary-600 transition-colors">
        {{ restaurant.name }}
      </h3>

      <!-- Google Maps Link -->
      <a
        :href="restaurant.google_link"
        target="_blank"
        rel="noopener noreferrer"
        class="inline-flex items-center gap-1.5 text-sm text-blue-600 hover:text-blue-700 font-medium mb-3 group/link"
        @click.stop
      >
        <MapPinIcon class="w-4 h-4 group-hover/link:scale-110 transition-transform" />
        <span>View on Maps</span>
        <ExternalLinkIcon class="w-3 h-3 opacity-50" />
      </a>

      <!-- Vote Button -->
      <button
        @click="handleVote"
        :disabled="hasVoted || voteLimitReached || isLoading"
        :class="buttonClass"
        class="w-full py-2.5 px-4 rounded-lg font-semibold transition-all duration-200 flex items-center justify-center gap-2 text-sm shadow-sm"
      >
        <component :is="buttonIcon" class="w-4 h-4" :class="{ 'animate-spin': isLoading }" />
        <span>{{ buttonText }}</span>
      </button>

      <!-- Error Message -->
      <div v-if="error" class="mt-2 bg-red-50 border-l-2 border-red-500 p-2 rounded text-xs">
        <p class="text-red-800 font-medium">{{ error }}</p>
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
      error: null,
      imageError: false
    };
  },
  mounted() {
    console.log(`RestaurantCard mounted: #${this.rank} - ${this.restaurant.name} (${this.restaurant.vote_count} votes)`);
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
        return 'bg-white/90 backdrop-blur-sm text-gray-900 font-bold border-2 border-white shadow-md';
      }
    },
    buttonClass() {
      if (this.hasVoted) {
        return 'bg-primary-100 text-primary-700 border-2 border-primary-300 cursor-not-allowed';
      } else if (this.voteLimitReached) {
        return 'bg-gray-100 text-gray-500 border-2 border-gray-200 cursor-not-allowed';
      } else {
        return 'bg-gradient-to-r from-primary-600 to-primary-700 text-white hover:from-primary-700 hover:to-primary-800 active:scale-95 shadow-md hover:shadow-lg';
      }
    },
    buttonText() {
      if (this.isLoading) return 'Voting...';
      if (this.hasVoted) return 'Voted';
      if (this.voteLimitReached) return 'Limit Reached';
      return 'Vote';
    },
    buttonIcon() {
      if (this.isLoading) return Loader2Icon;
      if (this.hasVoted) return CheckCircleIcon;
      if (this.voteLimitReached) return LockIcon;
      return ThumbsUpIcon;
    }
  },
  methods: {
    handleImageError(event) {
      if (!this.imageError) {
        this.imageError = true;
        event.target.src = 'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=800&q=80';
      }
    },
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
