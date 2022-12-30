<template>
  <el-menu :default-active="'/library'" router mode="horizontal">
    <el-menu-item v-for="(item, i) in navList" :key="i" :index="item.name">
      {{ item.navItem }}
    </el-menu-item>
    <span id="title">Meta Library - No end for learning</span>
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
}
</script>

<style scoped>
#title {
  position: absolute;
  padding-top: 20px;
  right: 35%;
  font-size: 20px;
  font-weight: bold;
  color: #3377aa;
}
</style>