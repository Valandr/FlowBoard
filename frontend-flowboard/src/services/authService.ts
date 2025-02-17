import axios from 'axios'

const API_AUTH_URL = 'http://localhost:3000/api/v1/auth'
const API_FIGURES_URL = 'http://localhost:3000/api/v1/figures'
const API_RECOMMENDATIONS_URL = 'http://localhost:3000/api/v1/recommendations'

export async function login(email: string, password: string) {
  const response = await axios.post(`${API_FIGURES_URL}/login`, {
    user: { email, password }
  })
  return response.data
}

export async function signup(
  email: string,
  password: string,
  level: string,
  sessionDuration: number,
  figuresMastered: number[]
) {
  const response = await axios.post(`${API_AUTH_URL}/signup`, {
    user: {
      email,
      password,
      level,
      session_duration: sessionDuration,
      figures_mastered: figuresMastered
    }
  })
  return response.data
}

export function logout() {
  localStorage.removeItem('token')
  window.location.href = '/'
}

export function isAuthenticated(): boolean {
  return !!localStorage.getItem('token')
}

export const getFigures = async () => {
  try {
    const response = await axios.get('http://localhost:3000/api/v1/figures')
    return response.data
  } catch (error) {
    console.error('Error during figure retrieval:', error)
    throw error
  }
}

export async function getRecommendations(userLevel: string, masteredFigures: number[]) {
  const token = localStorage.getItem('token')
  if (!token) {
    throw new Error('User not authenticated')
  }
  const response = await axios.post(
    API_RECOMMENDATIONS_URL,
    {
      level: userLevel,
      figures_mastered: masteredFigures
    },
    {
      headers: { Authorization: `Bearer ${token}` }
    }
  )
  return response.data
}

export function authGuard(to: any, from: any, next: any) {
  if (!isAuthenticated()) {
    next('/login')
  } else {
    next()
  }
}
