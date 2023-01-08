import store from '../store'
import router from '../router'
import axios from 'axios'

// 设置反向代理
axios.defaults.baseURL = 'http://localhost:8443/api'
// 允许跨域请求携带cookie信息
axios.defaults.withCredentials = true
// 添加响应拦截器
axios.interceptors.response.use(
  response => response,
  error => {
    if (error) {
      store.commit('logout')
      router.replace('/login')
    }
    return Promise.reject(error)
  })

const Req = {
  install(Vue) {
    const handler = (resp = {}) => {
      return new Promise((resolve, reject) => {
        const { data: { code, result, message } = {} } = resp
        if (code === 200) {
          resolve(result)
        } else {
          reject(message)
        }
      })
    }
    Vue.prototype.$req = {
      get(url, params = {}) {
        return axios.get(url, { params }).then(resp => handler(resp))
      },
      post(url, data = {}) {
        return axios.post(url, data).then(resp => handler(resp))
      },
      put(url, data = {}) {
        return axios.put(url, data).then(resp => handler(resp))
      }
    }
  }
}

export default Req