<template>
  <div class="container" :style="{ backgroundImage: `url(${url})` }">
    <el-form class="register-container" ref="registerForm" :model="registerForm" :rules="rules">
      <h3 style="color: #1e2b36;padding-bottom: 15px;">Meta Library</h3>
      <el-form-item prop="username">
        <el-input type="text" v-model="registerForm.username" auto-complete="off" placeholder="账号"></el-input>
      </el-form-item>
      <el-form-item prop="password">
        <el-input type="password" v-model="registerForm.password" auto-complete="off" placeholder="密码"></el-input>
      </el-form-item>
      <el-form-item>
        <el-button class="register-button" type="primary" @click="register">注册</el-button>
      </el-form-item>
      <div style="font-size:14px;">
        已有账号：<router-link replace to="login">直接登录</router-link>
      </div>
    </el-form>
  </div>
</template>

<script>
export default {
  name: 'Register',
  data() {
    return {
      rules: {
        username: [{ required: true, message: '用户名不能为空', trigger: 'blur' }],
        password: [{ required: true, message: '密码不能为空', trigger: 'blur' }]
      },
      registerForm: {
        username: '',
        password: ''
      },
      url: require('@/assets/register.jpg'),
    }
  },
  methods: {
    register() {
      this.$refs.registerForm.validate((valid) => {
        if (!valid) return
        this.$req.post('/register', { ...this.registerForm })
          .then(() => {
            this.$alert('注册成功', '提示', {
              confirmButtonText: '确定'
            })
            this.$router.replace('/login')
          }).catch(message => {
            this.$alert(message, '提示', {
              confirmButtonText: '确定'
            })
          })
      })
    }
  }
}
</script>

<style scoped>
.container {
  height: 100%;
  width: 100%;
  position: absolute;
  background-size: cover;
  background-position: center;
}

.register-container {
  width: 25%;
  min-width: 300px;
  max-width: 400px;
  margin: 8% auto;
  padding: 15px 35px 35px;
  border-radius: 20px;
  background: #fff;
  border: 1px solid #eaeaea;
  box-shadow: 0 0 20px #cac6c6;
}

.register-button {
  width: 100%;
  background: #1e2b36;
  border: none;
}

/* router-link标签 */
a {
  text-decoration: none;
}

a:link,
a:visited,
a:focus {
  color: #3377aa;
}
</style>