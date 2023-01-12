<template>
  <div class="container" :style="{ backgroundImage: `url(${url})` }">
    <el-form class="login-container" ref="loginForm" :model="loginForm" :rules="rules">
      <h3 style="color: #3377aa;padding-bottom: 15px;">Meta Library</h3>
      <el-form-item prop="username">
        <el-input type="text" v-model="loginForm.username" auto-complete="off" placeholder="账号"></el-input>
      </el-form-item>
      <el-form-item prop="password">
        <el-input type="password" v-model="loginForm.password" auto-complete="off" placeholder="密码"></el-input>
      </el-form-item>
      <el-form-item>
        <el-button class="login-button" type="primary" @click="login">登录</el-button>
      </el-form-item>
      <div style="font-size:14px;">
        未有账号：<router-link replace to="register">立即注册</router-link>
      </div>
    </el-form>
  </div>
</template>

<script>
export default {
  name: 'Login',
  data() {
    return {
      rules: {
        username: [{ required: true, message: '用户名不能为空', trigger: 'blur' }],
        password: [{ required: true, message: '密码不能为空', trigger: 'blur' }]
      },
      loginForm: {
        username: '',
        password: ''
      },
      url: require('@/assets/login.jpg'),
    }
  },
  methods: {
    login() {
      this.$refs.loginForm.validate((valid) => {
        if (!valid) return
        this.$req.post('/login', { ...this.loginForm })
          .then(result => {
            this.$store.commit('login', result)
            this.$router.replace({ path: this.$route.query.redirect || '/admin/home' })
          }).catch(message => {
            this.$alert(message, '提示', {
              confirmButtonText: '确定'
            })
          })
      })
    }
  },
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

.login-container {
  width: 25%;
  min-width: 300px;
  margin: 8% auto;
  padding: 15px 35px 35px;
  border-radius: 20px;
  background: #fff;
  border: 1px solid #eaeaea;
  box-shadow: 0 0 20px #cac6c6;
}

.login-button {
  width: 100%;
  background: #3377aa;
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