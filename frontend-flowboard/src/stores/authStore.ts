import axios from 'axios'
import { useRouter } from 'vue-router'
import Swal from 'sweetalert2'
import { defineStore } from 'pinia'
import { ref } from 'vue'
import type { User, LoginPayload, SignupPayload } from '@/types/authTypes'

const API_FIGURES_URL = 'http://localhost:3000/backend'
const API_AUTH_URL = 'http://localhost:3000/api/v1/auth'
const API_URL = 'http://localhost:3000/api/v1/auth/login'

export function useAuth() {
  const router = useRouter()

  async function getFigures() {
    const token = localStorage.getItem('token')
    const response = await axios.get(`${API_FIGURES_URL}/figures`, {
      headers: { Authorization: `Bearer ${token}` }
    })
    return response.data
  }

  async function signup(
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

    Swal.fire({
      title: 'Welcome!',
      text: 'Your account has been successfully created.',
      icon: 'success',
      confirmButtonText: 'OK'
    }).then(() => {
      router.push('/dashboard')
    })

    return response.data
  }

  async function login(email: string, password: string) {
    try {
      const response = await axios.post(
        API_URL,
        { email, password },
        {
          headers: { 'Content-Type': 'application/json' }
        }
      )
      return response.data
    } catch (error) {
      console.error('Login error:', error)
      throw error
    }
  }

  function logout() {
    localStorage.removeItem('token')

    Swal.fire({
      title: 'Successful logout',
      text: "You've been logged out.",
      icon: 'info',
      confirmButtonText: 'OK'
    }).then(() => {
      router.push('/login')
    })
  }

  function isAuthenticated() {
    return !!localStorage.getItem('token')
  }

  return { getFigures, signup, login, logout, isAuthenticated }
}

export const useAuthStore = defineStore('auth', () => {
  const { login, logout, signup, isAuthenticated } = useAuth()
  const user = ref<User | null>(null)
  const token = ref<string>(localStorage.getItem('token') || '')
  const error = ref<string | null>(null)

  async function handleLogin(payload: LoginPayload) {
    try {
      const { user: loggedInUser, token: newToken } = await login(payload.email, payload.password)
      user.value = loggedInUser
      token.value = newToken
      localStorage.setItem('token', newToken)
    } catch (err) {
      error.value = 'Incorrect email or password'
    }
  }

  async function register(payload: SignupPayload) {
    try {
      const { user: newUser, token: newToken } = await signup(
        payload.email,
        payload.password,
        payload.level,
        payload.sessionDuration,
        payload.figuresMastered
      )
      user.value = newUser
      token.value = newToken
      localStorage.setItem('token', newToken)
    } catch (err) {
      error.value = 'Registration error'
    }
  }

  function handleLogout() {
    logout()
    user.value = null
    token.value = ''
    localStorage.removeItem('token')
  }

  return { user, token, error, handleLogin, register, handleLogout, isAuthenticated }
})
