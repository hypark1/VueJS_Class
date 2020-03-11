import Vue from 'vue'
import App from './AppVuex.vue'
import 'bootstrap'
import 'bootstrap/dist/css/bootstrap.min.css'
import router from './router'
import store from './store/index.js'

Vue.config.productionTip = false

new Vue({
  render: h => h(App),
  //router: router
  router,
  store
}).$mount('#app')
