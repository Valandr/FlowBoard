import axios from 'axios'

const API_URL = 'http://localhost:3000/api/v1'

export async function getRecommendations() {
  const token = localStorage.getItem('token')
  if (!token) {
    console.warn('Please login first')
    return []
  }

  try {
    const response = await axios.get(`${API_URL}/recommendations`, {
      headers: { Authorization: `Bearer ${token}` }
    })
    return response.data
  } catch (error) {
    console.error('Error retrieving recommendations', error)
    return []
  }
}
