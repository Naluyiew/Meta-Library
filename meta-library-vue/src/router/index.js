import Vue from 'vue'
import Router from 'vue-router'

Vue.use(Router)

export default new Router({
  // 使用 History 模式
  mode: 'history',
  routes: [
    {
      path: '/',
      name: 'Home',
      component: () => import('../components/Home'),
      redirect: '/library',
    },
    {
      path: '/index',
      name: 'Home',
      component: () => import('../components/Home'),
      redirect: '/library',
      children: [
        {
          path: '/library',
          name: 'Library',
          component: () => import('../components/library/Library'),
          meta: {
            requireAuth: true
          },
        },
      ]
    },
    {
      path: '/login',
      name: 'Login',
      component: () => import('../components/Login'),
    },
    {
      path: '/register',
      name: 'Register',
      component: () => import('../components/Register'),
    },
    {
      path: '*',
      component: () => import('../components/pages/NotFound')
    }
  ]
})
