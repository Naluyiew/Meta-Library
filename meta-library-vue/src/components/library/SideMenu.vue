<template>
  <el-menu :default-active="0" class="categories">
    <el-menu-item v-for="(item, i) in sideItem" :key="i" :index="i">
      <i class="el-icon-menu"></i>
      <span slot="title">{{ item }}</span>
    </el-menu-item>
  </el-menu>
</template>

<script>
export default {
  name: 'SideMenu',
  data() {
    return {
      sideItem: ['全部', '教育', '语言', '文学', '艺术', '航天', '科技']
    }
  }
}
</script>

<style scoped>
.categories {
  position: fixed;
  top: 100px;
  width: 150px;
}
</style>