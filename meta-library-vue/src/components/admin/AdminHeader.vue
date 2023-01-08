<template>
  <div>
    <el-card class="admin-header">
      <span id="title">Meta Library - No end for learning</span>
    </el-card>
    <el-menu class="el-menu-demo" default-active="1-1" mode="horizontal" active-text-color="#3377aa">
      <el-submenu index="1">
        <template slot="title">{{ greet }}，{{ username }}</template>
        <el-menu-item index="1-1" @click="logout">退出登录</el-menu-item>
        <el-menu-item index="1-2" @click="backToLibrary">回到图书馆</el-menu-item>
      </el-submenu>
    </el-menu>
  </div>
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
  height: 80px;
  opacity: 0.85;
  line-height: 20px;
  min-width: 900px;
}

#title {
  position: absolute;
  padding-top: 20px;
  left: 40%;
  font-size: 25px;
  font-weight: bold;
  color: #1e2b36;
}

.el-menu-demo {
  position: absolute;
  top: 25%;
  right: 5%;
}
</style>
