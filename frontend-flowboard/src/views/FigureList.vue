<script setup lang="ts">
import { ref, computed, onMounted } from 'vue'
import { useFigureStore } from '@/stores/figureStore'

const figureStore = useFigureStore()
const selectedCategory = ref<string>('')

onMounted(() => {
  console.log('📡 Appel fetchFigures() au montage')
  figureStore.fetchFigures()
})

const uniqueCategories = computed(() => {
  const allCategories = figureStore.figures?.flatMap(figure => figure.category || [])
  return [...new Set(allCategories)]
})

const filteredFigures = computed(() => {
  if (!selectedCategory.value) return figureStore.figures
  return figureStore.figures.filter(figure => figure.category?.includes(selectedCategory.value))
})
</script>

<template>
  <div class="p-6">
    <h1 class="text-3xl mt-12 text-gray-600 font-bold text-center mb-6">Figures List</h1>

    <div class="mb-6 text-center">
      <label class="block text-gray-700 font-semibold mb-2">Filter by categories :</label>
      <select v-model="selectedCategory" class="border p-2 rounded text-gray-900">
        <option value="">All the categories</option>
        <option v-for="category in uniqueCategories" :key="category" :value="category">
          {{ category }}
        </option>
      </select>
    </div>

    <div v-if="figureStore.figures?.length === 0" class="text-center">Loading...</div>

    <ul v-else class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
      <li
        v-for="figure in filteredFigures"
        :key="figure.name"
        class="bg-white shadow-md p-4 rounded-lg"
      >
        <h2 class="text-xl text-gray-600 font-semibold">{{ figure.name }}</h2>
        <p class="text-gray-600">{{ figure.description }}</p>
        <p class="mt-2 text-gray-600 text-sm"><strong>Level :</strong> {{ figure.skill_level }}</p>
        <a :href="figure.video_url" target="_blank" class="text-blue-500 hover:underline mt-2 block"
          >Watch the video</a
        >
      </li>
    </ul>
  </div>
</template>

<style scoped>
select {
  width: 100%;
  max-width: 300px;
  padding: 8px;
  border-radius: 6px;
}
</style>
