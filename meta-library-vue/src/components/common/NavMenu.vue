<template>
  <el-menu :default-active="'/library'" router mode="horizontal" style="min-width: 1500px">
    <el-menu-item v-for="(item, i) in navList" :key="i" :index="item.name">
      {{ item.navItem }}
    </el-menu-item>
    <span id="title">Meta Library - No end for learning</span>
    <el-button type="primary" round @click="logout" style="position: absolute;right: 5%;top: 10px;">退出登录</el-button>
  </el-menu>
</template>

<script>
export default {
  name: 'NavMenu',
  data() {
    return {
      navList: [
        { name: '/library', navItem: '图书馆' },
        { name: '/admin', navItem: '管理中心' }
      ]
    }
  },
  methods: {
    logout() {
      this.$axios.get('/logout').then(resp => {
        if (resp.data.code === 200) {
          // 前后端状态保持一致
          this.$store.commit('logout')
          this.$router.replace('/login')
        }
      })
    }
  }
}
</script>

<style scoped>
#title {
  position: absolute;
  padding-top: 20px;
  right: 35%;
  font-size: 20px;
  font-weight: bold;
}
</style>