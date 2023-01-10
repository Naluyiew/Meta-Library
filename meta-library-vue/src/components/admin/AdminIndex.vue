<template>
  <el-container style="height: 96vh;">
    <el-header style="height: 85px; margin-left:-20px;">
      <AdminHeader />
    </el-header>
    <el-container>
      <el-aside style="width:32%;max-width: 250px;">
        <AdminMenu />
      </el-aside>
      <el-main style="padding:10px 20px 0px;">
        <router-view />
      </el-main>
    </el-container>
  </el-container>
</template>

<script>
import AdminMenu from '@/components/admin/AdminMenu'
import AdminHeader from '@/components/admin/AdminHeader'

export default {
  name: 'AdminIndex',
  components: { AdminMenu, AdminHeader },
}
</script>

<style scoped>

</style>
