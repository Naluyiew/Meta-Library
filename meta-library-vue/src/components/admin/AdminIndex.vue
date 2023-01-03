<template>
  <el-container id="admin-body">
    <el-header style="z-index: 1;height: 80px;margin-left: -20px">
      <AdminHeader style="position: absolute;width: 98%;" />
    </el-header>
    <el-container>
      <el-aside style="height: 112%;margin-top: -80px;width: 250px">
        <AdminMenu />
      </el-aside>
      <el-main>
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
#admin-body {
  height: 95vh;
}
</style>
