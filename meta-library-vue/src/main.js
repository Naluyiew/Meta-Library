import Vue from 'vue'
import App from './App'
import router, { resetRouter } from './router'
import store from './store'
import ElementUI from 'element-ui'
import 'element-ui/lib/theme-chalk/index.css'
import 'default-passive-events'

// 设置反向代理，前端请求默认发送到 http://localhost:8443/api
const axios = require('axios')
axios.defaults.baseURL = 'http://localhost:8443/api'
// 请求带上凭证信息
axios.defaults.withCredentials = true

// 全局注册，在其他组件中可以通过 this.$axios 发送数据
Vue.prototype.$axios = axios
Vue.config.productionTip = false

Vue.use(ElementUI)

router.beforeEach((to, from, next) => {
  // 已登录状态下访问 admin 页面，初始化菜单
  if (store.state.username && to.path.startsWith('/admin')) {
    initAdminMenu(router, store)
  }
  // 已登录状态下访问 login 页面，直接跳转到管理中心
  if (store.state.username && to.path.startsWith('/login')) {
    next({
      path: '/admin/home'
    })
  }
  if (to.meta.requireAuth) {
    // 如果前端有登录信息，判断后端是否正常登录
    if (store.state.username) {
      axios.get('/authentication').then(resp => {
        if (resp) {
          next()
        }
      })
      // 如果前端没有登录信息，直接拦截
    } else {
      next({
        path: 'login',
        query: { redirect: to.fullPath }
      })
    }
  } else {
    next()
  }
}
)

const initAdminMenu = (router, store) => {
  // 防止重复触发加载菜单操作
  if (store.state.adminMenus.length > 0) {
    return
  }
  axios.get('/menu').then(resp => {
    if (resp && resp.status === 200) {
      // 清空路由，防止重复添加路由
      resetRouter()
      // 调用格式化方法并向路由表中添加信息
      let fmtRoutes = formatRoutes(resp.data.result)
      router.addRoutes(fmtRoutes)
      store.commit('initAdminMenu', fmtRoutes)
    }
  })
}

// 后台传来的数据转换为路由能够识别的格式
const formatRoutes = (routes) => {
  let fmtRoutes = []
  routes.forEach(route => {
    if (route.children) {
      route.children = formatRoutes(route.children)
    }

    let fmtRoute = {
      path: route.path,
      component: resolve => {
        require(['./components/admin/' + route.component + '.vue'], resolve)
      },
      name: route.name,
      nameZh: route.nameZh,
      iconCls: route.iconCls,
      meta: {
        requireAuth: true
      },
      children: route.children
    }
    fmtRoutes.push(fmtRoute)
  })
  return fmtRoutes
}

// http response 拦截器
axios.interceptors.response.use(
  response => {
    return response
  },
  error => {
    if (error) {
      store.commit('logout')
      router.replace('/login')
    }
    // 返回接口返回的错误信息
    return Promise.reject(error)
  })

new Vue({
  el: '#app',
  router,
  store,
  components: { App },
  template: '<App/>'
})