<template>
  <el-menu class="menu-admin" :default-active="currentPath" router mode="vertical" background-color="#1e2b36"
    text-color="#fff" active-text-color="#ffd04b">
    <el-submenu v-for="(item, i) in adminMenus" :key="item.path" :index="String(i)" style="text-align:left;">
      <span slot="title" style="font-size:16px;">
        <i :class="item.iconCls"></i>
        {{ item.nameZh }}
      </span>
      <el-menu-item v-for="child in item.children" :key="child.path" :index="child.path">
        <i :class="child.icon"></i>
        {{ child.nameZh }}
      </el-menu-item>
    </el-submenu>
  </el-menu>
</template>

<script>
export default {
  name: 'AdminMenu',
  computed: {
    adminMenus() {
      return this.$store.state.adminMenus
    },
    currentPath() {
      return this.$route.path
    }
  }
}
</script>

<style scoped>
.menu-admin {
  height: 100%;
  border-bottom-right-radius: 5px;
  overflow: hidden;
}
</style>
