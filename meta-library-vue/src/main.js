import Vue from 'vue'
import App from './App'
import router from './router'
import store from './store'
import req from './plugins/req'
import ElementUI from 'element-ui'
import 'element-ui/lib/theme-chalk/index.css'

Vue.config.productionTip = false

Vue.use(ElementUI)
Vue.use(req)

new Vue({
  el: '#app',
  router,
  store,
  components: { App },
  template: '<App/>'
})