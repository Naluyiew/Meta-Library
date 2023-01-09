<template>
  <el-card class="admin-header" :body-style="{ padding: '5px 20px 5px' }">
    <el-menu default-active="1-1" mode="horizontal" active-text-color="#3377aa" style="border:none;">
      <el-submenu index="1" style="float:right;padding-top: 10px;">
        <template slot="title">{{ greet }}，{{ username }}</template>
        <el-menu-item index="1-1" @click="logout">退出登录</el-menu-item>
        <el-menu-item index="1-2" @click="backToLibrary">回到图书馆</el-menu-item>
      </el-submenu>
      <h2 style="color: #1e2b36;">Meta Library - No end for learning</h2>
    </el-menu>
  </el-card>
</template>

<script>
import { resetRouter } from '@/router'
export default {
  name: 'AdminHeader',
  data() {
    return {
      hours: new Date().getHours(),
      username: JSON.parse(window.localStorage.getItem('username'))
    }
  },
  computed: {
    greet() {
      const hours = this.hours
      return hours < 9
        ? '早上好'
        : hours < 12
          ? '上午好'
          : hours < 15
            ? '中午好'
            : hours < 19
              ? '下午好'
              : '晚上好'
    }
  },
  methods: {
    backToLibrary() {
      this.$router.replace('/library')
    },
    logout() {
      this.$req.get('/logout').then(() => {
        // 清除登录信息
        this.$store.commit('logout')
        this.$router.replace('/library')
        // 清空路由，防止路由重复加载
        resetRouter()
      })
    }
  }
}
</script>

<style scoped>
.admin-header {
  height: 100%;
  opacity: 0.85;
  box-sizing: border-box;
}
</style>
