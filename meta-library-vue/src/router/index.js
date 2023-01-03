import Vue from 'vue'
import Router from 'vue-router'

Vue.use(Router)

// 创建实例
const createRouter = () => new Router({
  // 使用 History 模式
  mode: 'history',
  // 默认路由
  routes: [
    {
      path: '/',
      component: () => import('@/components/Home'),
      redirect: '/library',
    },
    {
      path: '/index',
      component: () => import('@/components/Home'),
      redirect: '/library',
      children: [
        {
          path: '/library',
          component: () => import('@/components/library/Library'),
        },
      ]
    },
    {
      path: '/login',
      component: () => import('@/components/Login'),
    },
    {
      path: '/register',
      component: () => import('@/components/Register'),
    },
    {
      path: '/admin',
      component: () => import('@/components/admin/AdminIndex'),
      redirect: '/admin/home',
      children: [
        {
          path: 'home',
          component: () => import('@/components/admin/home/AdminHome'),
          meta: {
            requireAuth: true
          },
        },
      ]
    }
  ]
})
const router = createRouter()

// 清空路由，防止路由重复加载
export function resetRouter() {
  const newRouter = createRouter()
  router.matcher = newRouter.matcher
}

export default router