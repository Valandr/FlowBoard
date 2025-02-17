<script setup lang="ts">
import { ref, computed, onMounted } from 'vue'
import { useAuthStore } from '@/stores/authStore'
import { useRouter } from 'vue-router'
import { getFigures } from '@/services/authService'
import RecommendedFigures from '@/components/recommendedFigures.vue'

const authStore = useAuthStore()
const router = useRouter()
const isMenuOpen = ref(false)
const figures = ref<{ id: number; name: string }[]>([])
const errorMessage = ref('')

const isAuthenticated = computed(() => !!authStore.token)

const logout = () => {
  authStore.handleLogout()
  router.push('/login')
}

onMounted(async () => {
  try {
    figures.value = await getFigures()
  } catch (error) {
    console.error('Figure retrieval error', error)
    errorMessage.value = 'Unable to retrieve figures.'
  }
})
</script>

<template>
  <nav
    class="fixed top-0 left-0 w-full bg-gray-900 text-white py-4 px-6 flex justify-between items-center z-50"
  >
    <router-link to="/" class="text-lg font-bold hover:text-gray-300">FlowBoard 🛹</router-link>

    <button @click="isMenuOpen = !isMenuOpen" class="md:hidden text-white focus:outline-none">
      ☰
    </button>

    <div class="hidden md:flex space-x-6">
      <router-link v-if="!isAuthenticated" to="/login" class="py-2 hover:text-gray-300">
        Login
      </router-link>
      <router-link
        v-if="!isAuthenticated"
        to="/signup"
        class="ml-4 bg-blue-600 text-white px-4 py-2 rounded-lg hover:bg-blue-700 transition duration-300"
      >
        Register
      </router-link>
      <button v-if="isAuthenticated" @click="logout" class="hover:text-red-400">Logout</button>
    </div>

    <div
      v-if="isMenuOpen"
      class="absolute top-16 left-0 w-full bg-gray-900 text-white flex flex-col items-center space-y-4 py-4 shadow-lg md:hidden"
    >
      <router-link
        v-if="!isAuthenticated"
        to="/login"
        class="hover:text-gray-300"
        @click="isMenuOpen = false"
      >
        Login
      </router-link>
      <router-link
        v-if="!isAuthenticated"
        to="/signup"
        class="bg-blue-600 text-white px-4 py-2 rounded-lg hover:bg-blue-700 transition duration-300"
        @click="isMenuOpen = false"
      >
        Register
      </router-link>
      <button v-if="isAuthenticated" @click="logout" class="hover:text-red-400">Logout</button>
    </div>
  </nav>

  <div class="p-6">
    <h2 class="text-2xl mt-12 font-bold text-gray-900">Figures available</h2>
    <p v-if="errorMessage" class="text-red-500">{{ errorMessage }}</p>
    <ul v-if="figures.length" class="mt-4 grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
      <li v-for="figure in figures" :key="figure.id" class="bg-white shadow-md p-4 rounded-lg">
        <h3 class="text-lg text-gray-900 font-semibold">{{ figure.name }}</h3>
      </li>
    </ul>
  </div>
  <section class="mt-6">
    <RecommendedFigures />
  </section>
</template>

<style>
@media (max-width: 768px) {
  .grid {
    grid-template-columns: 1fr;
  }
}
</style>
