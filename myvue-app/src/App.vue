<template>
  <div class="container">
    <header-comp></header-comp>
    <nav-comp></nav-comp>
    <div class="row">
      <login-comp></login-comp>
      <div class="col-md-9">
        <transition name="fade">
          <router-view></router-view>
        </transition>
      </div>
    </div>
  </div>
</template>

<script>
import Header from './components/Header.vue'
import Nav from './components/Nav.vue'
import Login from './components/user/Login.vue'


  export default {
    data () {
      return {
        msg: 'Hello VueJS'
      }
    },
    components: {
      'header-comp': Header,
      'nav-comp': Nav,
      'login-comp': Login
    }
  }
</script>

<style lang="scss" scoped>
  .fade-enter-active, .fade-leave-active {
    transition: all 0.5s;
  }
  .fade-enter, .fade-leave-to {
    opacity: 0;
  }
  .fade-enter-to, fade-leave {
    opacity: 1;
  }
</style>