<template>
  <div>
    <!-- 修改用户的弹出表单 -->
    <el-dialog title="修改用户信息" :visible.sync="dialogFormVisible">
      <el-form v-model="selectedUser" style="text-align: left" ref="dataForm">
        <el-form-item label="用户名" label-width="120px" prop="username">
          <label>{{ selectedUser.username }}</label>
        </el-form-item>
        <el-form-item label="密码" label-width="120px" prop="password">
          <el-button type="warning" @click="resetPassword(selectedUser.username)">重置密码</el-button>
        </el-form-item>
        <el-form-item label="角色分配" label-width="120px" prop="roles">
          <el-checkbox-group v-model="selectedRolesIds">
            <el-checkbox v-for="(role, i) in roles" :key="i" :label="role.id">{{ role.nameZh }}</el-checkbox>
          </el-checkbox-group>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogFormVisible = false">取 消</el-button>
        <el-button type="primary" @click="onSubmit(selectedUser)">确 定</el-button>
      </div>
    </el-dialog>
    <el-row style="margin: 18px">
      <el-breadcrumb separator-class="el-icon-arrow-right">
        <el-breadcrumb-item>管理中心</el-breadcrumb-item>
        <el-breadcrumb-item>用户管理</el-breadcrumb-item>
        <el-breadcrumb-item>用户信息</el-breadcrumb-item>
      </el-breadcrumb>
    </el-row>
    <!-- 添加用户 -->
    <BulkRegistration @onSubmit="loadUsers()" />
    <!-- 展示用户信息 -->
    <el-card style="margin:18px;width: 95%">
      <el-table :data="users" stripe :default-sort="{ prop: 'id', order: 'ascending' }" style="width: 100%"
        :height="tableHeight">
        <el-table-column type="index" width="80">
        </el-table-column>
        <el-table-column prop="username" label="用户名" fit>
        </el-table-column>
        <el-table-column label="状态" sortable width="100">
          <template slot-scope="scope">
            <el-switch v-model="scope.row.enabled" active-color="#13ce66" inactive-color="#ff4949"
              @change="(value) => changeStatus(value, scope.row)">
            </el-switch>
          </template>
        </el-table-column>
        <el-table-column label="操作" width="120">
          <template slot-scope="scope">
            <el-button @click="editUser(scope.row)" type="text" size="small">
              编辑
            </el-button>
          </template>
        </el-table-column>
        <template v-slot:empty>
          <h1>{{ tip }}</h1>
        </template>
      </el-table>
    </el-card>
  </div>
</template>

<script>
import BulkRegistration from '@/components/admin/user/BulkRegistration'
export default {
  name: 'UserProfile',
  components: { BulkRegistration },
  data() {
    return {
      dialogFormVisible: false,
      users: [],
      roles: [],
      selectedUser: [],
      selectedRolesIds: [],
      tableHeight: window.innerHeight - 320,
      tip: ''
    }
  },
  mounted() {
    this.loadUsers()
    this.loadRoles()
  },
  methods: {
    loadUsers() {
      this.$req.get("/admin/user").then(result => {
        this.users = result
      })
    },
    loadRoles() {
      this.$req.get('/admin/role').then(result => {
        this.roles = result
      })
    },
    changeStatus(value, user) {
      const { username } = user
      if (username !== 'admin') {
        this.$req.put('/admin/user/status', {
          enabled: value,
          username
        }).then(() => {
          this.$message(`用户 ${username} 已 ${value ? '启用' : '禁用'}`)
        })
      } else {
        user.enabled = true
        this.$alert('不能禁用超级管理员账户！')
      }
    },
    editUser(user) {
      this.dialogFormVisible = true
      this.selectedUser = user
      this.selectedRolesIds = user.roles.map(({ id }) => id)
    },
    resetPassword(username) {
      this.$req.put('/admin/user/password', { username })
        .then(() => {
          this.$alert('密码已重置为zd2xh4cl6')
        })
    },
    onSubmit(user) {
      // 根据视图绑定的角色 id 向后端传送角色信息
      const roles = []
      this.selectedRolesIds.forEach(item => {
        roles.push(...this.roles.filter(({ id }) => item === id))
      })
      this.$req.put('/admin/user', {
        username: user.username,
        roles
      }).then(() => {
        this.dialogFormVisible = false
        this.$message({
          type: 'success',
          message: '用户信息修改成功'
        })
        this.loadUsers()
      }).catch(message => {
        this.$alert(message)
      })
    }
  }
}
</script>

<style scoped>

</style>
