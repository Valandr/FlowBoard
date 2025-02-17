export interface User {
  id: number
  email: string
  level: string
  session_duration: number
  role: string
  figuresMastered?: number[]
  created_at: string
}

export interface LoginPayload {
  email: string
  password: string
}

export interface SignupPayload {
  email: string
  password: string
  password_confirmation: string
  level: string
  sessionDuration: number
  figuresMastered: number[]
}
