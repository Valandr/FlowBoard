<script setup lang="ts">
import { ref, computed } from 'vue'
import { useAuthStore } from '@/stores/authStore'
import { useRouter } from 'vue-router'

const authStore = useAuthStore()
const router = useRouter()
const isMenuOpen = ref(false)

const isAuthenticated = computed(() => !!authStore.token)

const logout = () => {
  authStore.handleLogout()
  router.push('/login')
}
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
</template>
