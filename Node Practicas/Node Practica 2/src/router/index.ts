import { createRouter, createWebHistory } from 'vue-router'


const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/suma',
      name: 'suma',
      component: () => import ('../components/suma.vue')
    },
    {
      path: '/resta',
      name: 'resta',
      component: () => import ('../components/resta.vue')
    },
    {
      path: '/multiplicacion',
      name: 'multiplicacion',
      component: () => import ('../components/multiplicacion.vue')
    },
    {
      path: '/division',
      name: 'division',
      component: () => import ('../components/division.vue')
    },
    {
      path: '/slider',
      name: 'slider',
      component: () => import ('../components/slider.vue')
    }, 
    {
      path: '/mosaico',
      name: 'mosaico',
      component: () => import ('../components/mosaico.vue')
    },
  ],
})

export default router
