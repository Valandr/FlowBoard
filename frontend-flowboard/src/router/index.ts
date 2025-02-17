import { createRouter, createWebHistory } from 'vue-router'
import Home from '@/views/Home.vue'
import Login from '@/views/Login.vue'
import Signup from '@/views/Signup.vue'
import AdminDashboard from '@/views/AdminDashboard.vue'
import FigureList from '@/views/FigureList.vue'
import { authGuard } from '@/services/authService'

const routes = [
  { path: '/', component: Home },
  { path: '/login', component: Login },
  { path: '/signup', component: Signup },
  { path: '/figures', component: FigureList },
  {
    path: '/dashboard',
    component: AdminDashboard,
    beforeEnter: authGuard
  }
]

const router = createRouter({
  history: createWebHistory(),
  routes
})

export default router

router.beforeEach((to, from, next) => {
  console.log(`Navigation vers : ${to.path}`)
  next()
})
