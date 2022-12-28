<template>
  <div id="poster" :style="{ backgroundImage: 'url(' + url + ')' }">
    <el-form :model="loginForm" :rules="rules" class="login-container" label-position="left" label-width="0px"
      v-loading="loading">
      <h3 class="login-title">Meta Library</h3>
      <el-form-item prop="username">
        <el-input type="text" v-model="loginForm.username" auto-complete="off" placeholder="账号"></el-input>
      </el-form-item>
      <el-form-item prop="password">
        <el-input type="password" v-model="loginForm.password" auto-complete="off" placeholder="密码"></el-input>
      </el-form-item>
      <el-form-item style="width: 100%">
        <el-button type="primary" style="width: 100%;background: #3377aa;border: none" @click="login">登录</el-button>
        未有账号：<router-link replace to="register">立即注册</router-link>
      </el-form-item>
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
      loading: false,
      url: require('../assets/login.jpg'),
    }
  },
  methods: {
    login() {
      this.$axios.post('/login', {
        username: this.loginForm.username,
        password: this.loginForm.password,
      }).then(resp => {
        if (resp.data.code === 200) {
          let data = resp.data.result
          this.$store.commit('login', data)
          // 获取登录前页面的路径并跳转，如果该路径不存在，则跳转到首页
          let path = this.$route.query.redirect
          this.$router.replace({ path: path === '/' || path === undefined ? '/index' : path })
        } else {
          this.$alert(resp.data.message, '提示', {
            confirmButtonText: '确定'
          })
        }
      }).catch(err => { })
    }
  },
}
</script>

<style>
#poster {
  background-position: center;
  height: 100%;
  width: 100%;
  background-size: cover;
  position: fixed;
}

.login-container {
  border-radius: 15px;
  background-clip: padding-box;
  margin: 90px auto;
  width: 350px;
  padding: 35px 35px 15px 35px;
  background: #fff;
  border: 1px solid #eaeaea;
  box-shadow: 0 0 25px #cac6c6;
}

.login-title {
  margin: 0px auto 40px auto;
  text-align: center;
  color: #3377aa;
}

a {
  text-decoration: none;
}

a:link,
a:visited,
a:focus {
  color: #3377aa;
}
</style>