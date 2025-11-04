<template>
  <div id="app" class="app">
    <nav class="navbar">
      <div class="nav-container">
        <div class="nav-brand">
          <span class="brand-emoji">🍽️</span>
          <h1 class="brand-text">Riyadh Restaurants</h1>
        </div>
        <div class="nav-links">
          <button
            @click="currentView = 'list'"
            :class="{ active: currentView === 'list' }"
            class="nav-button"
          >
            All Restaurants
          </button>
          <button
            @click="currentView = 'create'"
            :class="{ active: currentView === 'create' }"
            class="nav-button"
          >
            Add Restaurant
          </button>
        </div>
      </div>
    </nav>

    <main class="main-content">
      <RestaurantList
        v-if="currentView === 'list'"
        ref="restaurantListRef"
      />
      <CreateRestaurantForm
        v-if="currentView === 'create'"
        @restaurant-created="switchToList"
      />
    </main>

    <footer class="footer">
      <p>Vote for your favorite restaurants in Riyadh 🌟</p>
      <p class="footer-secondary">Each device can create 1 restaurant and vote for up to 5</p>
    </footer>
  </div>
</template>

<script>
import RestaurantList from './components/RestaurantList.vue';
import CreateRestaurantForm from './components/CreateRestaurantForm.vue';

export default {
  name: 'App',
  components: {
    RestaurantList,
    CreateRestaurantForm
  },
  data() {
    return {
      currentView: 'list'
    };
  },
  methods: {
    switchToList() {
      this.currentView = 'list';
      // Refresh the restaurant list
      if (this.$refs.restaurantListRef) {
        this.$refs.restaurantListRef.refreshRestaurants();
      }
    }
  }
};
</script>

<style scoped>
#app {
  min-height: 100vh;
  display: flex;
  flex-direction: column;
  background: #fafafa;
}

.navbar {
  background: white;
  border-bottom: 1px solid #e0e0e0;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
  position: sticky;
  top: 0;
  z-index: 100;
}

.nav-container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 16px 20px;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.nav-brand {
  display: flex;
  align-items: center;
  gap: 12px;
}

.brand-emoji {
  font-size: 28px;
}

.brand-text {
  margin: 0;
  color: #333;
  font-size: 20px;
  font-weight: 600;
}

.nav-links {
  display: flex;
  gap: 8px;
}

.nav-button {
  padding: 8px 16px;
  border: none;
  background: transparent;
  color: #666;
  font-size: 14px;
  font-weight: 500;
  cursor: pointer;
  border-radius: 4px;
  transition: all 0.2s ease;
}

.nav-button:hover {
  background: #f0f0f0;
  color: #333;
}

.nav-button.active {
  color: #4CAF50;
  background: #e8f5e9;
}

.main-content {
  flex: 1;
  padding: 40px 20px;
}

.footer {
  background: #333;
  color: white;
  text-align: center;
  padding: 32px 20px;
  margin-top: 40px;
}

.footer p {
  margin: 0;
  font-size: 14px;
}

.footer-secondary {
  margin-top: 8px;
  opacity: 0.8;
  font-size: 12px;
}
</style>

<style>
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

body {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Roboto', 'Oxygen',
    'Ubuntu', 'Cantarell', 'Fira Sans', 'Droid Sans', 'Helvetica Neue',
    sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  background: #fafafa;
}

html, body, #app {
  height: 100%;
}
</style>
