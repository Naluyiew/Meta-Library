<template>
  <el-menu :default-active="'/index'" router mode="horizontal" style="min-width: 1500px">
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
  }
}
</script>

<style scoped>
#title {
  position: absolute;
  padding-top: 20px;
  right: 40%;
  font-size: 20px;
  font-weight: bold;
}
</style>