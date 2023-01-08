import Vue from 'vue'
import Router from 'vue-router'
import store from '../store'
import axios from 'axios'

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

router.beforeEach((to, _, next) => {
  const { state: { username } } = store
  const { path, meta, fullPath } = to
  // 已登录状态下访问 admin 页面，初始化菜单
  if (username && path.startsWith('/admin')) {
    initAdminMenu(router, store)
  }
  // 已登录状态下访问 login 页面，跳转到管理中心
  if (username && path.startsWith('/login')) {
    next('/admin/home')
  }
  if (meta.requireAuth) {
    // 如果前端有登录信息
    if (username) {
      axios.get('/authentication').then(resp => {
        if (resp.data === '身份认证成功') next()
      })
      // 如果前端没有登录信息，直接拦截
    } else {
      next({
        path: '/login',
        query: { redirect: fullPath }
      })
    }
  } else {
    next()
  }
})

const initAdminMenu = (router, store) => {
  // 防止重复触发加载菜单操作
  if (store.state.adminMenus.length !== 0) return
  axios.get('/menu').then((resp = {}) => {
    const { data: { code, result } = {} } = resp
    if (code === 200) {
      // 清空路由，防止重复添加路由
      resetRouter()
      // 调用格式化方法
      const fmtRoutes = formatRoutes(result)
      // 向路由表中添加信息
      router.addRoutes(fmtRoutes)
      store.commit('initAdminMenu', fmtRoutes)
    }
  })
}

// 后台传来的数据转换为路由能够识别的格式
const formatRoutes = (routes) => {
  const fmtRoutes = []
  routes.forEach(route => {
    const { children, path, component, name, nameZh, iconCls } = route
    if (children) {
      route.children = formatRoutes(children)
    }
    const fmtRoute = {
      path,
      component: () =>
        import(`@/components/admin/${component}`)
      ,
      name,
      nameZh,
      iconCls,
      meta: {
        requireAuth: true
      },
      children: route.children
    }
    fmtRoutes.push(fmtRoute)
  })
  return fmtRoutes
}

// 清空路由，防止路由重复加载
export function resetRouter() {
  const newRouter = createRouter()
  router.matcher = newRouter.matcher
}

export default router