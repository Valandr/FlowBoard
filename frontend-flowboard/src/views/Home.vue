<script setup lang="ts">
import FigureList from '@/views/FigureList.vue'
import { useRouter } from 'vue-router'

const router = useRouter()

const goToFigures = () => {
  router.push('/figures')
}
</script>

<template>
  <div
    class="relative flex flex-col items-center justify-center min-h-screen bg-gray-100 px-4 py-6 space-y-8"
  >
    <h1 class="text-3xl md:text-4xl font-bold text-gray-900 text-center">Welcome</h1>

    <p class="text-gray-700 text-base md:text-lg text-center">
      Discover freestyle longboard tricks.
    </p>

    <button
      @click="goToFigures"
      class="bg-blue-600 text-white px-6 py-2 rounded-lg hover:bg-blue-700 transition duration-300 text-sm md:text-base mt-8"
    >
      Show figures
    </button>

    <div
      class="w-full max-w-6xl mt-8 transition-all duration-500"
      :class="{ 'opacity-100': showFigures, 'opacity-0': !showFigures }"
    >
      <FigureList v-if="showFigures" />
    </div>
  </div>
</template>
