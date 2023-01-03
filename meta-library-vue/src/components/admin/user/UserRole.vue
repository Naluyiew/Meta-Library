<template>
  <div>
    <!-- 修改角色的弹出表单 -->
    <el-dialog title="修改角色信息" :visible.sync="dialogFormVisible">
      <el-form v-model="selectedRole" style="text-align: left" ref="dataForm">
        <el-form-item label="角色名" label-width="120px" prop="username">
          <el-input v-model="selectedRole.name" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="角色描述" label-width="120px" prop="name">
          <el-input v-model="selectedRole.nameZh" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="功能配置" label-width="120px" prop="perms">
          <el-checkbox-group v-model="selectedPermsIds">
            <el-checkbox v-for="(perm, i) in perms" :key="i" :label="perm.id">{{ perm.desc_ }}</el-checkbox>
          </el-checkbox-group>
        </el-form-item>
        <el-form-item label="菜单配置" label-width="120px" prop="menus">
          <el-tree :data="menus" :props="props" show-checkbox :default-checked-keys="selectedMenusIds" node-key="id"
            ref="tree">
          </el-tree>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogFormVisible = false">取 消</el-button>
        <el-button type="primary" @click="onSubmit(selectedRole)">确 定</el-button>
      </div>
    </el-dialog>
    <el-row style="margin: 18px">
      <el-breadcrumb separator-class="el-icon-arrow-right">
        <el-breadcrumb-item>管理中心</el-breadcrumb-item>
        <el-breadcrumb-item>用户管理</el-breadcrumb-item>
        <el-breadcrumb-item>角色配置</el-breadcrumb-item>
      </el-breadcrumb>
    </el-row>
    <!-- 添加角色的弹出表单 -->
    <RoleCreate @onSubmit="listRoles()" />
    <!-- 展示角色信息 -->
    <el-card style="margin:18px;width: 95%">
      <el-table :data="roles" stripe style="width: 100%" :max-height="tableHeight">
        <el-table-column type="index" width="50">
        </el-table-column>
        <el-table-column prop="name" label="角色名" fit>
        </el-table-column>
        <el-table-column prop="nameZh" label="角色描述" fit>
        </el-table-column>
        <el-table-column label="状态" width="100">
          <template slot-scope="scope">
            <el-switch v-model="scope.row.enabled" active-color="#13ce66" inactive-color="#ff4949"
              @change="(value) => commitStatusChange(value, scope.row)">
            </el-switch>
          </template>
        </el-table-column>
        <el-table-column label="操作" width="120">
          <template slot-scope="scope">
            <el-button type="text" size="small" @click="editRole(scope.row)">
              编辑
            </el-button>
          </template>
        </el-table-column>
      </el-table>
    </el-card>
  </div>
</template>

<script>
import RoleCreate from '@/components/admin/user/RoleCreate'
export default {
  name: 'UserRole',
  components: { RoleCreate },
  data() {
    return {
      dialogFormVisible: false,
      roles: [],
      perms: [],
      menus: [],
      selectedRole: [],
      selectedPermsIds: [],
      selectedMenusIds: [],
      props: {
        id: 'id',
        label: 'nameZh',
        children: 'children'
      }
    }
  },
  mounted() {
    this.listRoles()
    this.listPerms()
    this.listMenus()
  },
  computed: {
    tableHeight() {
      return window.innerHeight - 320
    }
  },
  methods: {
    listRoles() {
      this.$axios.get('/admin/role').then(resp => {
        if (resp && resp.status === 200) {
          this.roles = resp.data.result
        }
      })
    },
    listPerms() {
      this.$axios.get('/admin/role/perm').then(resp => {
        if (resp && resp.data.code === 200) {
          this.perms = resp.data.result
        }
      })
    },
    listMenus() {
      this.$axios.get('/admin/role/menu').then(resp => {
        if (resp && resp.data.code === 200) {
          this.menus = resp.data.result
        }
      })
    },
    commitStatusChange(value, role) {
      if (role.id !== 1) {
        this.$confirm('是否修改角色状态？', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(() => {
          this.$axios.put('/admin/role/status', {
            enabled: value,
            id: role.id
          }).then(resp => {
            if (resp && resp.data.code === 200) {
              if (value) {
                this.$message('角色 [' + role.nameZh + '] 已启用')
              } else {
                this.$message('角色 [' + role.nameZh + '] 已禁用')
              }
            }
          })
        }).catch(() => {
          role.enabled = !role.enabled
          this.$message({
            type: 'info',
            message: '取消修改'
          })
        })
      } else {
        role.enabled = true
        this.$alert('无法禁用系统管理员！')
      }
    },
    editRole(role) {
      this.dialogFormVisible = true
      this.selectedRole = role
      let permIds = []
      for (let i = 0; i < role.perms.length; i++) {
        permIds.push(role.perms[i].id)
      }
      this.selectedPermsIds = permIds
      let menuIds = []
      for (let i = 0; i < role.menus.length; i++) {
        menuIds.push(role.menus[i].id)
        for (let j = 0; j < role.menus[i].children.length; j++) {
          menuIds.push(role.menus[i].children[j].id)
        }
      }
      this.selectedMenusIds = menuIds
      // 判断树是否已经加载，第一次打开对话框前树不存在会报错，所以需要设置 default-checked
      if (this.$refs.tree) {
        this.$refs.tree.setCheckedKeys(menuIds)
      }
    },
    onSubmit(role) {
      // 根据视图绑定的角色 id 向后端传送角色信息
      let perms = []
      for (let i = 0; i < this.selectedPermsIds.length; i++) {
        for (let j = 0; j < this.perms.length; j++) {
          if (this.selectedPermsIds[i] === this.perms[j].id) {
            perms.push(this.perms[j])
          }
        }
      }
      this.$axios.put('/admin/role', {
        id: role.id,
        name: role.name,
        nameZh: role.nameZh,
        enabled: role.enabled,
        perms: perms
      }).then(resp => {
        if (resp && resp.data.code === 200) {
          this.$alert(resp.data.result)
          this.dialogFormVisible = false
          this.listRoles()
        }
      })
      this.$axios.put('/admin/role/menu?rid=' + role.id, {
        menusIds: this.$refs.tree.getCheckedKeys()
      }).then(resp => {
        if (resp && resp.data.code === 200) {
          console.log(resp.data.result)
        }
      })
    }
  }
}
</script>

<style scoped>
.add-button {
  float: left;
  margin: 18px 0 18px 10px;
}
</style>
