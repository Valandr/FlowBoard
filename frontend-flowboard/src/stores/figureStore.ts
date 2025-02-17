import { defineStore } from 'pinia'
import axios from 'axios'

interface Figure {
  id: number
  name: string
  skill_level: string
  category: string[]
  duration: number
  video_url: string
}

export const useFigureStore = defineStore('figureStore', {
  state: () => ({
    figures: [] as Figure[],
    loading: false,
    error: null as string | null
  }),

  actions: {
    async fetchFigures() {
      this.loading = true
      this.error = null

      try {
        const response = await axios.get('http://localhost:3000/api/v1/figures')
        this.figures = response.data
      } catch (error) {
        this.error = 'Impossible de charger les figures.'
        console.error('Erreur lors du chargement des figures:', error)
      } finally {
        this.loading = false
      }
    }
  }
})
