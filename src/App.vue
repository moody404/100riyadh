<template>
  <div id="app" class="min-h-screen flex flex-col bg-gray-50">
    <!-- Navigation Bar -->
    <nav class="bg-white border-b border-gray-200 shadow-sm sticky top-0 z-50">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="flex items-center justify-between h-16">
          <!-- Brand -->
          <div class="flex items-center gap-3">
            <div class="flex items-center justify-center w-10 h-10 bg-gradient-to-br from-primary-500 to-primary-600 rounded-lg shadow-md">
              <UtensilsIcon class="w-6 h-6 text-white" />
            </div>
            <div>
              <h1 class="text-xl font-bold text-gray-900">Riyadh Restaurants</h1>
              <p class="text-xs text-gray-500 hidden sm:block">Find the best places to eat</p>
            </div>
          </div>

          <!-- Navigation Links -->
          <div class="flex items-center gap-2">
            <button
              @click="currentView = 'list'"
              :class="currentView === 'list' ? activeButtonClass : inactiveButtonClass"
              class="flex items-center gap-2 px-4 py-2 rounded-lg font-semibold transition-all duration-200"
            >
              <ListIcon class="w-4 h-4" />
              <span class="hidden sm:inline">All Restaurants</span>
              <span class="sm:hidden">List</span>
            </button>
            <button
              @click="currentView = 'create'"
              :class="currentView === 'create' ? activeButtonClass : inactiveButtonClass"
              class="flex items-center gap-2 px-4 py-2 rounded-lg font-semibold transition-all duration-200"
            >
              <PlusCircleIcon class="w-4 h-4" />
              <span class="hidden sm:inline">Add Restaurant</span>
              <span class="sm:hidden">Add</span>
            </button>
          </div>
        </div>
      </div>
    </nav>

    <!-- Main Content -->
    <main class="flex-1">
      <Transition name="fade" mode="out-in">
        <RestaurantList
          v-if="currentView === 'list'"
          key="list"
          ref="restaurantListRef"
        />
        <CreateRestaurantForm
          v-else
          key="create"
          @restaurant-created="handleRestaurantCreated"
        />
      </Transition>
    </main>

    <!-- Footer -->
    <footer class="bg-gradient-to-r from-gray-800 to-gray-900 text-white">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <div class="text-center">
          <div class="flex items-center justify-center gap-2 mb-2">
            <StarIcon class="w-5 h-5 text-amber-400 fill-amber-400" />
            <p class="text-lg font-semibold">Vote for your favorite restaurants in Riyadh</p>
          </div>
          <p class="text-sm text-gray-400">Each device can create 1 restaurant and vote for up to 5</p>
          <div class="mt-4 flex items-center justify-center gap-4 text-xs text-gray-500">
            <div class="flex items-center gap-1">
              <InfoIcon class="w-3 h-3" />
              <span>Real-time voting</span>
            </div>
            <div class="flex items-center gap-1">
              <ShieldCheckIcon class="w-3 h-3" />
              <span>Fair & transparent</span>
            </div>
          </div>
        </div>
      </div>
    </footer>
  </div>
</template>

<script>
import RestaurantList from './components/RestaurantList.vue';
import CreateRestaurantForm from './components/CreateRestaurantForm.vue';
import {
  Utensils as UtensilsIcon,
  List as ListIcon,
  PlusCircle as PlusCircleIcon,
  Star as StarIcon,
  Info as InfoIcon,
  ShieldCheck as ShieldCheckIcon
} from 'lucide-vue-next';

export default {
  name: 'App',
  components: {
    RestaurantList,
    CreateRestaurantForm,
    UtensilsIcon,
    ListIcon,
    PlusCircleIcon,
    StarIcon,
    InfoIcon,
    ShieldCheckIcon
  },
  data() {
    return {
      currentView: 'list'
    };
  },
  computed: {
    activeButtonClass() {
      return 'bg-gradient-to-r from-primary-600 to-primary-700 text-white shadow-md hover:from-primary-700 hover:to-primary-800';
    },
    inactiveButtonClass() {
      return 'bg-gray-100 text-gray-700 hover:bg-gray-200';
    }
  },
  methods: {
    handleRestaurantCreated() {
      // Switch to list view after creating a restaurant
      this.currentView = 'list';

      // Refresh the restaurant list if it exists
      this.$nextTick(() => {
        if (this.$refs.restaurantListRef && this.$refs.restaurantListRef.loadData) {
          this.$refs.restaurantListRef.loadData();
        }
      });
    }
  }
};
</script>

<style scoped>
/* Fade transition for view changes */
.fade-enter-active,
.fade-leave-active {
  transition: opacity 0.2s ease;
}

.fade-enter-from,
.fade-leave-to {
  opacity: 0;
}
</style>
