import axios from 'axios'

const API_URL = 'http://localhost:3000/api/v1'

export default class FigureService {
  static async getFigures() {
    try {
      const response = await axios.get(`${API_URL}/figures`)
      console.log('Complete server response :', response)
      return response.data
    } catch (error) {
      console.error('Error when retrieving figures :', error)
      return []
    }
  }
}
