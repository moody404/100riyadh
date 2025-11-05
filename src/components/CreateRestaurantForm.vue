<template>
  <div class="min-h-screen bg-gradient-to-br from-gray-50 to-gray-100 py-6 px-4 sm:px-6 lg:px-8">
    <div class="max-w-2xl mx-auto">
      <!-- Header -->
      <div class="text-center mb-8">
        <div class="inline-flex items-center justify-center w-16 h-16 bg-gradient-to-br from-primary-500 to-primary-600 rounded-full mb-4 shadow-lg">
          <PlusCircleIcon class="w-8 h-8 text-white" />
        </div>
        <h1 class="text-3xl font-bold text-gray-900 mb-2">Add New Restaurant</h1>
        <p class="text-gray-600">Help us discover the best restaurants in Riyadh</p>
      </div>

      <!-- Form Card -->
      <div class="card p-8">
        <!-- Creation Limit Warning -->
        <div v-if="cannotCreate" class="bg-amber-50 border-l-4 border-amber-500 p-4 rounded-lg mb-6">
          <div class="flex items-start gap-3">
            <AlertCircleIcon class="w-5 h-5 text-amber-600 flex-shrink-0 mt-0.5" />
            <div>
              <p class="text-amber-900 font-semibold">Restaurant Creation Limit Reached</p>
              <p class="text-amber-800 text-sm mt-1">You can only create one restaurant. You can still vote on existing restaurants!</p>
            </div>
          </div>
        </div>

        <form @submit.prevent="handleSubmit" class="space-y-6">
          <!-- Restaurant Name -->
          <div>
            <label for="name" class="block text-sm font-semibold text-gray-700 mb-2">
              <div class="flex items-center gap-2">
                <StoreIcon class="w-4 h-4 text-gray-500" />
                <span>Restaurant Name</span>
                <span class="text-red-500">*</span>
              </div>
            </label>
            <input
              id="name"
              v-model="formData.name"
              type="text"
              placeholder="e.g., Al Orjouan at The Ritz-Carlton"
              required
              maxlength="100"
              :disabled="cannotCreate"
              class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-transparent transition-all duration-200 disabled:bg-gray-100 disabled:cursor-not-allowed"
            />
            <p class="mt-2 text-sm text-gray-500 flex items-center gap-1">
              <InfoIcon class="w-3 h-3" />
              <span>{{ formData.name.length }}/100 characters</span>
            </p>
          </div>

          <!-- Google Maps Link -->
          <div>
            <label for="googleLink" class="block text-sm font-semibold text-gray-700 mb-2">
              <div class="flex items-center gap-2">
                <MapPinIcon class="w-4 h-4 text-gray-500" />
                <span>Google Maps Link</span>
                <span class="text-red-500">*</span>
              </div>
            </label>
            <input
              id="googleLink"
              v-model="formData.googleLink"
              type="url"
              placeholder="https://maps.google.com/..."
              required
              :disabled="cannotCreate"
              class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-transparent transition-all duration-200 disabled:bg-gray-100 disabled:cursor-not-allowed"
            />
            <p class="mt-2 text-sm text-gray-500 flex items-center gap-1">
              <InfoIcon class="w-3 h-3" />
              <span>Find the restaurant on Google Maps and paste the URL here</span>
            </p>
          </div>

          <!-- Image URL -->
          <div>
            <label for="imageUrl" class="block text-sm font-semibold text-gray-700 mb-2">
              <div class="flex items-center gap-2">
                <ImageIcon class="w-4 h-4 text-gray-500" />
                <span>Image URL</span>
                <span class="text-gray-400 text-xs font-normal">(optional)</span>
              </div>
            </label>
            <input
              id="imageUrl"
              v-model="formData.imageUrl"
              type="url"
              placeholder="https://images.unsplash.com/... or leave blank for default"
              :disabled="cannotCreate"
              class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-transparent transition-all duration-200 disabled:bg-gray-100 disabled:cursor-not-allowed"
            />
            <p class="mt-2 text-sm text-gray-500 flex items-center gap-1">
              <InfoIcon class="w-3 h-3" />
              <span>Add a photo URL from Unsplash, Google Images, or your own server</span>
            </p>
          </div>

          <!-- Success Message -->
          <div v-if="success" class="bg-green-50 border-l-4 border-green-500 p-4 rounded-lg">
            <div class="flex items-start gap-3">
              <CheckCircleIcon class="w-5 h-5 text-green-600 flex-shrink-0 mt-0.5" />
              <div>
                <p class="text-green-900 font-semibold">Restaurant Added Successfully!</p>
                <p class="text-green-800 text-sm mt-1">Your restaurant is now live. You can vote on other restaurants!</p>
              </div>
            </div>
          </div>

          <!-- Error Message -->
          <div v-if="error" class="bg-red-50 border-l-4 border-red-500 p-4 rounded-lg">
            <div class="flex items-start gap-3">
              <AlertCircleIcon class="w-5 h-5 text-red-600 flex-shrink-0 mt-0.5" />
              <p class="text-red-800 font-medium">{{ error }}</p>
            </div>
          </div>

          <!-- Submit Button -->
          <button
            type="submit"
            :disabled="isLoading || cannotCreate"
            class="w-full bg-gradient-to-r from-primary-600 to-primary-700 text-white font-bold py-4 px-6 rounded-lg hover:from-primary-700 hover:to-primary-800 active:scale-[0.98] transition-all duration-200 shadow-md hover:shadow-lg disabled:opacity-50 disabled:cursor-not-allowed disabled:transform-none flex items-center justify-center gap-2"
          >
            <component :is="buttonIcon" class="w-5 h-5" :class="{ 'animate-spin': isLoading }" />
            <span>{{ buttonText }}</span>
          </button>
        </form>

        <!-- Info Box -->
        <div class="mt-8 bg-blue-50 border border-blue-200 rounded-lg p-6">
          <div class="flex items-start gap-3">
            <LightbulbIcon class="w-5 h-5 text-blue-600 flex-shrink-0 mt-0.5" />
            <div>
              <p class="text-blue-900 font-semibold mb-3">How it works:</p>
              <ul class="space-y-2 text-sm text-blue-800">
                <li class="flex items-start gap-2">
                  <CheckCircleIcon class="w-4 h-4 text-blue-600 flex-shrink-0 mt-0.5" />
                  <span>You can create only <strong>one restaurant</strong> per device</span>
                </li>
                <li class="flex items-start gap-2">
                  <CheckCircleIcon class="w-4 h-4 text-blue-600 flex-shrink-0 mt-0.5" />
                  <span>Your vote is automatically counted when you create a restaurant</span>
                </li>
                <li class="flex items-start gap-2">
                  <CheckCircleIcon class="w-4 h-4 text-blue-600 flex-shrink-0 mt-0.5" />
                  <span>The restaurant appears immediately in the rankings</span>
                </li>
                <li class="flex items-start gap-2">
                  <CheckCircleIcon class="w-4 h-4 text-blue-600 flex-shrink-0 mt-0.5" />
                  <span>You can vote for up to <strong>5 restaurants</strong> in total (including your own)</span>
                </li>
              </ul>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { createRestaurant } from '../utils/restaurants';
import {
  PlusCircle as PlusCircleIcon,
  Store as StoreIcon,
  MapPin as MapPinIcon,
  Image as ImageIcon,
  Info as InfoIcon,
  CheckCircle as CheckCircleIcon,
  AlertCircle as AlertCircleIcon,
  Lightbulb as LightbulbIcon,
  Loader2 as Loader2Icon,
  Lock as LockIcon
} from 'lucide-vue-next';

export default {
  name: 'CreateRestaurantForm',
  components: {
    PlusCircleIcon,
    StoreIcon,
    MapPinIcon,
    ImageIcon,
    InfoIcon,
    CheckCircleIcon,
    AlertCircleIcon,
    LightbulbIcon,
    Loader2Icon,
    LockIcon
  },
  data() {
    return {
      formData: {
        name: '',
        googleLink: '',
        imageUrl: ''
      },
      isLoading: false,
      error: null,
      success: false,
      cannotCreate: false
    };
  },
  computed: {
    buttonText() {
      if (this.isLoading) return 'Adding Restaurant...';
      if (this.cannotCreate) return 'Already Created (Limit: 1)';
      return 'Add Restaurant';
    },
    buttonIcon() {
      if (this.isLoading) return Loader2Icon;
      if (this.cannotCreate) return LockIcon;
      return PlusCircleIcon;
    }
  },
  async mounted() {
    await this.checkCreationLimit();
  },
  methods: {
    async checkCreationLimit() {
      try {
        const { supabase } = await import('../supabaseClient');
        const { getDeviceId } = await import('../utils/deviceId');

        const deviceId = getDeviceId();
        const { count, error } = await supabase
          .from('restaurants')
          .select('*', { count: 'exact', head: true })
          .eq('created_by_device_id', deviceId);

        if (error) {
          console.error('Error checking creation limit:', error);
          return;
        }

        this.cannotCreate = count > 0;
      } catch (err) {
        console.error('Error checking creation limit:', err);
      }
    },
    async handleSubmit() {
      if (this.isLoading || this.cannotCreate) return;

      // Validate Google Maps URL
      if (!this.formData.googleLink.includes('google.com') && !this.formData.googleLink.includes('maps.google')) {
        this.error = 'Please provide a valid Google Maps link';
        return;
      }

      this.isLoading = true;
      this.error = null;
      this.success = false;

      try {
        await createRestaurant(this.formData.name, this.formData.googleLink, this.formData.imageUrl);

        this.success = true;
        this.formData = { name: '', googleLink: '', imageUrl: '' };
        this.cannotCreate = true;

        // Emit event to parent to refresh restaurant list
        this.$emit('restaurant-created');

        // Clear success message after 5 seconds
        setTimeout(() => {
          this.success = false;
        }, 5000);
      } catch (err) {
        this.error = err.message;
        console.error('Creating restaurant error:', err);
      } finally {
        this.isLoading = false;
      }
    }
  }
};
</script>
