<template>
  <el-menu default-active="/library" router mode="horizontal">
    <el-menu-item v-for="(item, i) in navList" :key="i" :index="item.name">
      {{ item.navItem }}
    </el-menu-item>
    <h3 style="color: #3377aa;">Meta Library - No end for learning</h3>
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

</style>