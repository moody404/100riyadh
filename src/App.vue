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
/* Mobile-first design */
#app {
  min-height: 100vh;
  display: flex;
  flex-direction: column;
  background: #fafafa;
}

.navbar {
  background: white;
  border-bottom: 1px solid #e0e0e0;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.08);
  position: sticky;
  top: 0;
  z-index: 100;
}

.nav-container {
  width: 100%;
  margin: 0 auto;
  padding: 12px 16px;
  display: flex;
  justify-content: space-between;
  align-items: center;
  gap: 12px;
  flex-wrap: wrap;
}

.nav-brand {
  display: flex;
  align-items: center;
  gap: 8px;
  flex: 1;
  min-width: auto;
}

.brand-emoji {
  font-size: 24px;
}

.brand-text {
  margin: 0;
  color: #1a1a1a;
  font-size: 16px;
  font-weight: 700;
}

.nav-links {
  display: flex;
  gap: 4px;
}

.nav-button {
  padding: 8px 12px;
  border: none;
  background: transparent;
  color: #666;
  font-size: 12px;
  font-weight: 600;
  cursor: pointer;
  border-radius: 6px;
  transition: all 0.2s ease;
  white-space: nowrap;
}

.nav-button:hover {
  background: #f0f0f0;
  color: #333;
}

.nav-button.active {
  color: white;
  background: #4CAF50;
  font-weight: 700;
}

.main-content {
  flex: 1;
  padding: 0;
  background: #fafafa;
}

.footer {
  background: linear-gradient(135deg, #1a1a1a 0%, #2d2d2d 100%);
  color: white;
  text-align: center;
  padding: 24px 16px;
  margin-top: auto;
}

.footer p {
  margin: 0;
  font-size: 13px;
  line-height: 1.6;
}

.footer-secondary {
  margin-top: 6px;
  opacity: 0.85;
  font-size: 11px;
  font-weight: 500;
}

/* Tablet screens */
@media (min-width: 640px) {
  .nav-container {
    padding: 14px 20px;
    gap: 16px;
  }

  .brand-emoji {
    font-size: 26px;
  }

  .brand-text {
    font-size: 18px;
  }

  .nav-button {
    padding: 8px 14px;
    font-size: 13px;
  }

  .main-content {
    padding: 20px 0;
  }

  .footer {
    padding: 28px 20px;
  }
}

/* Desktop screens */
@media (min-width: 1024px) {
  .nav-container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 16px 20px;
    flex-wrap: nowrap;
    gap: 32px;
  }

  .brand-emoji {
    font-size: 28px;
  }

  .brand-text {
    font-size: 20px;
  }

  .nav-button {
    padding: 8px 16px;
    font-size: 14px;
  }

  .main-content {
    padding: 40px 20px;
  }

  .footer {
    padding: 32px 20px;
  }
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
