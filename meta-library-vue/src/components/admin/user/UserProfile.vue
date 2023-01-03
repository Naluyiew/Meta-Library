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
    <!-- 批量添加用户 -->
    <BulkRegistration @onSubmit="listUsers()" />
    <!-- 展示用户信息 -->
    <el-card style="margin:18px;width: 95%">
      <el-table :data="users" stripe :default-sort="{ prop: 'id', order: 'ascending' }" style="width: 100%"
        :max-height="tableHeight">
        <el-table-column type="index" width="50">
        </el-table-column>
        <el-table-column prop="username" label="用户名" fit>
        </el-table-column>
        <el-table-column label="状态" sortable width="100">
          <template slot-scope="scope">
            <el-switch v-model="scope.row.enabled" active-color="#13ce66" inactive-color="#ff4949"
              @change="(value) => commitStatusChange(value, scope.row)">
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
      users: [],
      roles: [],
      dialogFormVisible: false,
      selectedUser: [],
      selectedRolesIds: []
    }
  },
  mounted() {
    this.listUsers()
    this.listRoles()
  },
  computed: {
    tableHeight() {
      return window.innerHeight - 320
    }
  },
  methods: {
    listUsers() {
      this.$axios.get('/admin/user').then(resp => {
        if (resp && resp.data.code === 200) {
          this.users = resp.data.result
        }
      })
    },
    listRoles() {
      this.$axios.get('/admin/role').then(resp => {
        if (resp && resp.data.code === 200) {
          this.roles = resp.data.result
        }
      })
    },
    commitStatusChange(value, user) {
      if (user.username !== 'admin') {
        this.$axios.put('/admin/user/status', {
          enabled: value,
          username: user.username
        }).then(resp => {
          if (resp && resp.data.code === 200) {
            if (value) {
              this.$message('用户 [' + user.username + '] 已启用')
            } else {
              this.$message('用户 [' + user.username + '] 已禁用')
            }
          }
        })
      } else {
        user.enabled = true
        this.$alert('不能禁用管理员账户')
      }
    },
    onSubmit(user) {
      // 根据视图绑定的角色 id 向后端传送角色信息
      let roles = []
      for (let i = 0; i < this.selectedRolesIds.length; i++) {
        for (let j = 0; j < this.roles.length; j++) {
          if (this.selectedRolesIds[i] === this.roles[j].id) {
            roles.push(this.roles[j])
          }
        }
      }
      this.$axios.put('/admin/user', {
        username: user.username,
        roles: roles
      }).then(resp => {
        if (resp && resp.data.code === 200) {
          this.$alert('用户信息修改成功')
          this.dialogFormVisible = false
          // 修改角色后重新请求用户信息，实现视图更新
          this.listUsers()
        } else {
          this.$alert(resp.data.message)
        }
      })
    },
    editUser(user) {
      this.dialogFormVisible = true
      this.selectedUser = user
      let roleIds = []
      for (let i = 0; i < user.roles.length; i++) {
        roleIds.push(user.roles[i].id)
      }
      this.selectedRolesIds = roleIds
    },
    resetPassword(username) {
      this.$axios.put('/admin/user/password', {
        username: username
      }).then(resp => {
        if (resp && resp.data.code === 200) {
          this.$alert('密码已重置为1az2sx3dc')
        }
      })
    }
  }
}
</script>

<style scoped>

</style>
