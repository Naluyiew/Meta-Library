<template>
  <el-container>
    <el-aside>
      <SideMenu />
    </el-aside>
  </el-container>
</template>

<script>
import SideMenu from '@/components/library/SideMenu'
export default {
  name: 'Library',
  components: {
    SideMenu
  }
}
</script>

<style>

</style>