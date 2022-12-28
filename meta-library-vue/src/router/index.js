import Vue from 'vue'
import Router from 'vue-router'
import Home from '@/components/Home'
import Library from '@/components/library/Library'
import Login from '@/components/Login'
import Register from '@/components/Register'
import NotFound from '@/components/pages/NotFound'

Vue.use(Router)

export default new Router({
  // 使用 History 模式
  mode: 'history',
  routes: [
    {
      path: '/',
      name: 'Home',
      component: Home,
      redirect: '/library',
    },
    {
      path: '/index',
      name: 'Home',
      component: Home,
      redirect: '/library',
      children: [
        {
          path: '/library',
          name: Library,
          component: Library,
          meta: {
            requireAuth: true
          },
        }
      ]
    },
    {
      path: '/login',
      name: 'Login',
      component: Login
    },
    {
      path: '/register',
      name: 'Register',
      component: Register
    },
    {
      path: '*',
      component: NotFound
    }
  ]
})
