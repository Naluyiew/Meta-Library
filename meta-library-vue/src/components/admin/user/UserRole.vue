<template>
  <div style="padding:10px;">
    <!-- 添加角色 -->
    <RoleCreate @onSubmit="loadRoles()" />
    <!-- 展示角色信息 -->
    <el-card style="width: 95%; margin-top:20px;">
      <el-table :data="roles" stripe :height="tableHeight">
        <el-table-column type="index" width="80">
        </el-table-column>
        <el-table-column prop="name" label="角色名" fit>
        </el-table-column>
        <el-table-column prop="nameZh" label="角色描述" fit>
        </el-table-column>
        <el-table-column label="状态" width="100">
          <template slot-scope="scope">
            <el-switch v-model="scope.row.enabled" active-color="#13ce66" inactive-color="#ff4949"
              @change="(value) => changeStatus(value, scope.row)">
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
        <template v-slot:empty>
          <h1>{{ tip }}</h1>
        </template>
      </el-table>
    </el-card>
    <!-- 修改角色信息 -->
    <el-dialog title="修改角色信息" :visible.sync="dialogFormVisible">
      <el-form v-model="selectedRole" style="text-align: left" ref="dataForm">
        <el-form-item label="角色名" label-width="100px" prop="username">
          <el-input v-model="selectedRole.name" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="角色描述" label-width="100px" prop="name">
          <el-input v-model="selectedRole.nameZh" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="功能配置" label-width="100px" prop="perms">
          <el-checkbox-group v-model="selectedPermsIds">
            <el-checkbox v-for="(perm, i) in perms" :key="i" :label="perm.id">{{ perm.desc_ }}</el-checkbox>
          </el-checkbox-group>
        </el-form-item>
        <el-form-item label="菜单配置" label-width="100px" prop="menus">
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
      },
      tableHeight: window.innerHeight - 280,
      tip: ''
    }
  },
  mounted() {
    this.loadRoles()
    this.loadPerms()
    this.loadMenus()
  },
  methods: {
    loadRoles() {
      this.$req.get('/admin/role').then(result => {
        this.roles = result
      })
    },
    loadPerms() {
      this.$req.get('/admin/role/perm').then(result => {
        this.perms = result
      })
    },
    loadMenus() {
      this.$req.get('/admin/role/menu').then(result => {
        this.menus = result
      })
    },
    changeStatus(value, role) {
      const { id, name, nameZh } = role
      if (name !== 'sysAdmin') {
        this.$req.put('/admin/role/status', {
          enabled: value,
          id
        }).then(() => {
          this.$message(`角色 ${nameZh} 已 ${value ? '启用' : '禁用'}`)
        })
      } else {
        role.enabled = true
        this.$alert('无法禁用系统管理员！')
      }
    },
    editRole(role) {
      this.dialogFormVisible = true
      this.selectedRole = role
      const { perms, menus } = role
      this.selectedPermsIds = perms.map(({ id }) => id)
      this.selectedMenusIds = menus.reduce((acc, { id, children }) => {
        acc.push(id)
        acc.push(...children.map(({ id }) => id))
        return acc
      }, [])
    },
    onSubmit(role) {
      const { id, name, nameZh, enabled } = role
      const perms = []
      this.selectedPermsIds.forEach(item => {
        perms.push(...this.perms.filter(({ id }) => item === id))
      })
      this.$req.put('/admin/role', {
        id,
        name,
        nameZh,
        enabled,
        perms
      }).then(() => {
        this.dialogFormVisible = false
        this.$message({
          type: 'success',
          message: '角色信息修改成功'
        })
        this.loadRoles()
      })
      this.$req.put(`/admin/role/menu?rid=${id}`, {
        menusIds: this.$refs.tree.getCheckedKeys()
      })
    }
  }
}
</script>

<style scoped>

</style>
