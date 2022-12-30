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
      name: 'Index',
      component: () => import('../components/Home'),
      redirect: '/library',
      children: [
        {
          path: '/library',
          name: 'Library',
          component: () => import('../components/library/Library'),
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
      path: '/admin',
      name: 'Admin',
      component: () => import('../components/admin/AdminIndex'),
      redirect: '/admin/home',
      children: [
        {
          path: 'home',
          name: 'AdminHome',
          component: () => import('../components/admin/home/AdminHome'),
          meta: {
            requireAuth: true
          },
        },
      ]
    },
    {
      path: '*',
      component: () => import('../components/pages/NotFound')
    }
  ]
})


