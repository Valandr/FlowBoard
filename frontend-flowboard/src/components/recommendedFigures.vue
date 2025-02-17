<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { getRecommendations } from '@/services/recommandationService'
import { useAuthStore } from '@/stores/authStore'

const authStore = useAuthStore()
const recommendedFigures = ref<{ id: number; name: string }[]>([])

onMounted(async () => {
  if (!authStore.token) {
    console.warn('User not authenticated, no recommendations displayeds.')
    return
  }

  try {
    recommendedFigures.value = await getRecommendations()
    console.log('Recommendations received :', recommendedFigures.value)
  } catch (error) {
    console.error('Recommendation retrieval error', error)
  }
})
</script>

<template>
  <div class="p-6">
    <h1 class="text-2xl font-bold text-gray-800 mb-4">Recommended figures</h1>

    <p v-if="!authStore.token" class="text-gray-500">
      Log in to see your personalized recommendations.
    </p>

    <ul v-else-if="recommendedFigures.length > 0" class="grid grid-cols-1 md:grid-cols-2 gap-4">
      <li
        v-for="figure in recommendedFigures"
        :key="figure.id"
        class="p-4 border border-gray-300 rounded-md shadow-md bg-white"
      >
        <h2 class="text-lg font-semibold text-gray-800">{{ figure.name }}</h2>
      </li>
    </ul>

    <p v-else class="text-gray-500">No recommendation at this time.</p>
  </div>
</template>
