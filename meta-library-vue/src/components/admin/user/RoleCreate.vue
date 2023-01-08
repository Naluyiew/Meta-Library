<template>
  <div style="text-align: left">
    <el-button class="add-button" type="primary" @click="dialogFormVisible = true">添加角色</el-button>
    <el-dialog title="添加角色" :visible.sync="dialogFormVisible" @close="clear" width="25%">
      <el-form ref="roleForm" :model="roleForm" :rules="rules" label-position="left" label-width="0px">
        <el-form-item prop="name">
          <el-input type="text" v-model="roleForm.name" auto-complete="off" placeholder="角色名"></el-input>
        </el-form-item>
        <el-form-item prop="nameZh">
          <el-input type="text" v-model="roleForm.nameZh" auto-complete="off" placeholder="角色描述"></el-input>
        </el-form-item>
        <el-form-item style="width: 100%">
          <el-button type="success" style="width: 40%;border: none" v-on:click="createRole">添加</el-button>
        </el-form-item>
        <el-form-item prop="username">
          <el-tag>初始权限：无</el-tag>
        </el-form-item>
      </el-form>
    </el-dialog>
  </div>
</template>

<script>
export default {
  name: 'RoleCreate',
  data() {
    return {
      dialogFormVisible: false,
      rules: {
        name: [{ required: true, message: '角色名不能为空', trigger: 'blur' }],
        nameZh: [{ required: true, message: '角色描述不能为空', trigger: 'blur' }]
      },
      roleForm: {
        name: '',
        nameZh: ''
      },
    }
  },
  watch: {
    dialogFormVisible(newVal) {
      if (!newVal) {
        this.$refs.roleForm.clearValidate()
      }
    }
  },
  methods: {
    clear() {
      this.$refs.roleForm.resetFields()
    },
    createRole() {
      this.$refs.roleForm.validate((valid) => {
        if (!valid) return
        this.$req.post('/admin/role', { ...this.roleForm })
          .then(_, () => {
            this.$emit('onSubmit')
            this.clear()
            this.dialogFormVisible = false
            this.$message({
              type: 'success',
              message: '角色添加成功'
            })
          })
      })
    }
  }
}
</script>

<style scoped>
.add-button {
  margin: 0px 18px;
}
</style>
