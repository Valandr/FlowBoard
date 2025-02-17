<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { getFigures, signup, logout } from '@/services/authService'
import { useAuthStore } from '@/stores/authStore'
import Swal from 'sweetalert2'

const authStore = useAuthStore()
const router = useRouter()

const email = ref('')
const password = ref('')
const level = ref('beginner')
const sessionDuration = ref(30)
const figures = ref<{ id: number; name: string }[]>([])
const figuresMastered = ref<number[]>([])
const isDropdownOpen = ref(false)

onMounted(async () => {
  try {
    figures.value = await getFigures()
  } catch (error) {
    console.error('Figure recovery error', error)
  }
})

const toggleDropdown = () => {
  isDropdownOpen.value = !isDropdownOpen.value
}

const handleSelection = (figureId: number) => {
  if (figuresMastered.value.includes(figureId)) {
    figuresMastered.value = figuresMastered.value.filter(id => id !== figureId)
  } else {
    figuresMastered.value.push(figureId)
  }
}

const handleSignup = async () => {
  try {
    console.log('Sending data:', {
      email: email.value,
      password: password.value,
      level: level.value,
      sessionDuration: sessionDuration.value,
      figuresMastered: figuresMastered.value
    })

    const response = await signup(
      email.value,
      password.value,
      level.value,
      sessionDuration.value,
      figuresMastered.value
    )

    authStore.token = response.token
    localStorage.setItem('token', response.token)

    Swal.fire({
      title: 'Successful registration!',
      text: 'Welcome to your dashboard',
      icon: 'success',
      confirmButtonText: 'OK',
      showCloseButton: true
    }).then(() => {
      router.push('/dashboard')
    })
  } catch (error: any) {
    Swal.fire({
      title: 'Error',
      text: 'Error during registration, please try again later',
      icon: 'error',
      confirmButtonText: 'OK',
      showCloseButton: true
    })
  }
}
</script>

<template>
  <form
    @submit.prevent="handleSignup"
    class="p-6 mt-8 bg-white shadow-md rounded-md max-w-lg mx-auto md:max-w-2xl lg:max-w-3xl w-full"
  >
    <h2 class="text-xl font-bold text-gray-900 mb-4 text-center">Login</h2>

    <div class="mb-4">
      <label class="block text-gray-800">Email</label>
      <input
        v-model="email"
        type="email"
        required
        class="w-full border p-2 rounded text-gray-900"
      />
    </div>

    <div class="mb-4">
      <label class="block text-gray-800">Password</label>
      <input
        v-model="password"
        type="password"
        required
        class="w-full border p-2 rounded text-gray-900"
      />
    </div>

    <div class="mb-4">
      <label class="block text-gray-800">Level</label>
      <select v-model="level" class="w-full border p-2 rounded text-gray-900">
        <option value="beginner">Beginner</option>
        <option value="intermediate">Intermediate</option>
        <option value="advanced">Avanced</option>
      </select>
    </div>

    <div class="mb-4">
      <label class="block text-gray-800">Session duration (minutes)</label>
      <input
        v-model="sessionDuration"
        type="number"
        class="w-full border p-2 rounded text-gray-900"
      />
    </div>

    <div class="mb-4 relative">
      <label class="block text-gray-800">Figures mastered</label>
      <div
        class="w-full border p-2 rounded text-gray-900 bg-white cursor-pointer flex justify-between items-center"
        @click="toggleDropdown"
      >
        <span>
          {{
            figuresMastered.length > 0
              ? figures
                  .filter(f => figuresMastered.includes(f.id))
                  .map(f => f.name)
                  .join(', ')
              : 'Select figures'
          }}
        </span>
        <span class="text-gray-500">▼</span>
      </div>

      <div
        v-if="isDropdownOpen"
        class="absolute z-10 mt-1 w-full bg-white border border-gray-300 shadow-md rounded-md max-h-48 overflow-y-auto"
      >
        <div
          v-for="figure in figures"
          :key="figure.id"
          class="flex items-center p-2 hover:bg-gray-100 cursor-pointer"
          @click="handleSelection(figure.id)"
        >
          <input type="checkbox" :checked="figuresMastered.includes(figure.id)" class="mr-2" />
          <span class="text-gray-800">{{ figure.name }}</span>
        </div>
      </div>
    </div>

    <button type="submit" class="bg-blue-500 text-white p-2 rounded w-full hover:bg-blue-600">
      Register
    </button>
  </form>
</template>

<style scoped>
form {
  margin-top: 10rem;
}
select {
  width: 100%;
  max-width: 300px;
  padding: 8px;
  border-radius: 6px;
}

input[type='checkbox'] {
  width: 16px;
  height: 16px;
  border: 2px solid black;
}
</style>
