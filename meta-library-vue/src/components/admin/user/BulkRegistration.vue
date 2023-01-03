<template>
  <div style="text-align: left">
    <el-button class="add-button" type="primary" @click="dialogFormVisible = true">添加用户</el-button>
    <el-dialog title="添加用户" :visible.sync="dialogFormVisible" @close="clear" width="25%">
      <el-form ref="userForm" :model="userForm" :rules="rules" label-position="left" label-width="0px">
        <el-form-item prop="username">
          <el-input type="text" v-model="userForm.username" auto-complete="off" placeholder="账号"></el-input>
        </el-form-item>
        <el-form-item prop="password">
          <el-input type="password" v-model="userForm.password" auto-complete="off" placeholder="密码"></el-input>
        </el-form-item>
        <el-form-item style="width: 100%">
          <el-button type="success" style="width: 40%;border: none" v-on:click="register">添加</el-button>
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
      this.userForm = {
        username: '',
        password: ''
      }
    },
    register() {
      this.$refs.userForm.validate((valid) => {
        // 通过验证，发送请求
        if (valid) {
          this.$axios
            .post('/register', {
              username: this.userForm.username,
              password: this.userForm.password,
            })
            .then(resp => {
              if (resp.data.code === 200) {
                this.$alert('注册成功', '提示', {
                  confirmButtonText: '确定'
                })
                this.clear()
                this.$emit('onSubmit')
                this.dialogFormVisible = false
              } else {
                this.$alert(resp.data.message, '提示', {
                  confirmButtonText: '确定'
                })
              }
            })
            .catch(failResponse => { })
        } else {
          return false;
        }
      });
    }
  }
}
</script>

<style scoped>
.add-button {
  margin: 0px 18px;
}
</style>
