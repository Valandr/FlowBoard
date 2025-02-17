<script setup lang="ts">
import { ref } from 'vue'
import { useAuthStore } from '@/stores/authStore'
import { useRouter } from 'vue-router'

const email = ref('')
const password = ref('')
const authStore = useAuthStore()
const router = useRouter()

const login = async () => {
  await authStore.handleLogin({ email: email.value, password: password.value })
  router.push('/dashboard')
}
</script>

<template>
  <div class="flex items-center justify-center min-h-screen bg-gray-100 px-4">
    <div class="w-full max-w-md bg-white shadow-lg rounded-lg p-6 text-gray-800">
      <h2 class="text-2xl font-bold text-center mb-6">Connexion</h2>

      <div class="flex flex-col">
        <input
          v-model="email"
          type="email"
          placeholder="Email"
          class="w-full p-3 border border-gray-300 rounded focus:ring-2 focus:ring-blue-500 mb-4"
        />
        <input
          v-model="password"
          type="password"
          placeholder="Password"
          class="w-full p-3 border border-gray-300 rounded focus:ring-2 focus:ring-blue-500 mb-4"
        />

        <button
          @click="login"
          class="w-full bg-blue-500 text-white py-3 rounded-lg hover:bg-blue-600 transition duration-300"
        >
          Login
        </button>
      </div>
    </div>
  </div>
</template>
