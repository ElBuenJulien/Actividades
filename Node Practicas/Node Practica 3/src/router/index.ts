import { createRouter, createWebHistory } from 'vue-router'


const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/datos',
      name: 'datos',
      component: () => import ('../components/datos.vue')
    },
  ],
})

export default router
