import axios from 'axios'

const API_URL = 'http://localhost:3000/api/v1'

export async function getUsers() {
  const response = await axios.get(`${API_URL}/admin/users`, {
    headers: { Authorization: `Bearer ${localStorage.getItem('token')}` }
  })
  return response.data
}
