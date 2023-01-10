<template>
  <div style="text-align: left">
    <el-button type="primary" @click="dialogFormVisible = true">添加用户</el-button>
    <el-dialog title="添加用户" :visible.sync="dialogFormVisible" @close="clear" width="25%" style="min-width:600px;">
      <el-form ref="userForm" :model="userForm" :rules="rules" label-position="left">
        <el-form-item prop="username">
          <el-input type="text" v-model="userForm.username" auto-complete="off" placeholder="账号"></el-input>
        </el-form-item>
        <el-form-item prop="password">
          <el-input type="password" v-model="userForm.password" auto-complete="off" placeholder="密码"></el-input>
        </el-form-item>
        <el-form-item>
          <el-button type="success" style="width: 80%;max-width:120px;border: none;"
            v-on:click="register">添加</el-button>
        </el-form-item>
      </el-form>
    </el-dialog>
  </div>
</template>

<script>
export default {
  name: 'BulkRegistration',
  data() {
    return {
      dialogFormVisible: false,
      rules: {
        username: [{ required: true, message: '用户名不能为空', trigger: 'blur' }],
        password: [{ required: true, message: '密码不能为空', trigger: 'blur' }]
      },
      userForm: {
        username: '',
        password: ''
      }
    }
  },
  methods: {
    clear() {
      this.$refs.userForm.resetFields()
    },
    register() {
      this.$refs.userForm.validate((valid) => {
        if (!valid) return
        this.$req.post('/register', { ...this.userForm })
          .then(() => {
            this.$emit('onSubmit')
            this.clear()
            this.dialogFormVisible = false
            this.$message({
              type: 'success',
              message: '用户添加成功'
            })
          }).catch(message => {
            this.$message({
              type: 'error',
              message
            })
          })
      })
    }
  }
}
</script>

<style scoped>

</style>
