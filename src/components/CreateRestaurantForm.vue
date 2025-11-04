<template>
  <div class="create-form-container">
    <div class="form-card">
      <h2>Add New Restaurant</h2>
      <p class="subtitle">Help us find the best restaurants in Riyadh</p>

      <form @submit.prevent="handleSubmit">
        <div class="form-group">
          <label for="name">Restaurant Name *</label>
          <input
            id="name"
            v-model="formData.name"
            type="text"
            placeholder="Enter restaurant name"
            required
            maxlength="100"
          />
        </div>

        <div class="form-group">
          <label for="googleLink">Google Maps Link *</label>
          <input
            id="googleLink"
            v-model="formData.googleLink"
            type="url"
            placeholder="https://maps.google.com/..."
            required
          />
          <small>Paste the Google Maps link to the restaurant</small>
        </div>

        <div v-if="error" class="error-message">
          {{ error }}
        </div>

        <div v-if="success" class="success-message">
          ✓ Restaurant added successfully! You can now vote on other restaurants.
        </div>

        <button
          type="submit"
          :disabled="isLoading || cannotCreate"
          class="submit-button"
        >
          <span v-if="isLoading">Adding...</span>
          <span v-else-if="cannotCreate">Already Created (Max 1)</span>
          <span v-else>Add Restaurant</span>
        </button>
      </form>

      <div class="info-box">
        <p><strong>Rules:</strong></p>
        <ul>
          <li>You can create only 1 restaurant</li>
          <li>Creator's vote counts toward the total</li>
          <li>Restaurant is immediately visible in the list</li>
        </ul>
      </div>
    </div>
  </div>
</template>

<script>
import { createRestaurant } from '../utils/restaurants';

export default {
  name: 'CreateRestaurantForm',
  data() {
    return {
      formData: {
        name: '',
        googleLink: ''
      },
      isLoading: false,
      error: null,
      success: false,
      cannotCreate: false
    };
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
        await createRestaurant(this.formData.name, this.formData.googleLink);

        this.success = true;
        this.formData = { name: '', googleLink: '' };
        this.cannotCreate = true;

        // Emit event to parent to refresh restaurant list
        this.$emit('restaurant-created');

        // Clear success message after 3 seconds
        setTimeout(() => {
          this.success = false;
        }, 3000);
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

<style scoped>
.create-form-container {
  max-width: 500px;
  margin: 0 auto;
  padding: 20px;
}

.form-card {
  background: white;
  border-radius: 8px;
  padding: 32px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
}

.form-card h2 {
  margin: 0 0 8px 0;
  color: #333;
  font-size: 24px;
}

.subtitle {
  color: #666;
  margin: 0 0 24px 0;
  font-size: 14px;
}

.form-group {
  margin-bottom: 20px;
}

.form-group label {
  display: block;
  margin-bottom: 8px;
  color: #333;
  font-weight: 500;
  font-size: 14px;
}

.form-group input {
  width: 100%;
  padding: 10px 12px;
  border: 1px solid #ddd;
  border-radius: 4px;
  font-size: 14px;
  font-family: inherit;
  transition: border-color 0.2s ease;
  box-sizing: border-box;
}

.form-group input:focus {
  outline: none;
  border-color: #4CAF50;
  box-shadow: 0 0 0 2px rgba(76, 175, 80, 0.1);
}

.form-group small {
  display: block;
  margin-top: 4px;
  color: #999;
  font-size: 12px;
}

.error-message {
  color: #d32f2f;
  background: #ffebee;
  padding: 12px;
  border-radius: 4px;
  margin-bottom: 16px;
  font-size: 14px;
}

.success-message {
  color: #2e7d32;
  background: #e8f5e9;
  padding: 12px;
  border-radius: 4px;
  margin-bottom: 16px;
  font-size: 14px;
}

.submit-button {
  width: 100%;
  padding: 12px 16px;
  background: #4CAF50;
  color: white;
  border: none;
  border-radius: 4px;
  font-size: 16px;
  font-weight: bold;
  cursor: pointer;
  transition: all 0.2s ease;
  margin-bottom: 20px;
}

.submit-button:hover:not(:disabled) {
  background: #45a049;
  transform: translateY(-2px);
  box-shadow: 0 2px 6px rgba(76, 175, 80, 0.3);
}

.submit-button:disabled {
  opacity: 0.6;
  cursor: not-allowed;
}

.info-box {
  background: #f5f5f5;
  padding: 16px;
  border-radius: 4px;
  border-left: 4px solid #4CAF50;
}

.info-box p {
  margin: 0 0 8px 0;
  color: #333;
  font-size: 14px;
  font-weight: bold;
}

.info-box ul {
  margin: 0;
  padding-left: 20px;
  color: #666;
  font-size: 13px;
}

.info-box li {
  margin-bottom: 4px;
}
</style>
