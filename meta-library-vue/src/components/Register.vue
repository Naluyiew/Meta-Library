<template>
  <body id="poster" :style="{ backgroundImage: 'url(' + url + ')' }">
    <el-form class="register-container" label-position="left" label-width="0px">
      <h3 class="register-title">Meta Library</h3>
      <el-form-item>
        <el-input type="text" v-model="registerForm.username" auto-complete="off" placeholder="账号"></el-input>
      </el-form-item>
      <el-form-item>
        <el-input type="password" v-model="registerForm.password" auto-complete="off" placeholder="密码"></el-input>
      </el-form-item>
      <el-form-item style="width: 100%">
        <el-button type="primary" style="width: 100%;background: #1e2b36;border: none" @click="register">注册</el-button>
        已有账号：<router-link replace to="login">直接登录</router-link>
      </el-form-item>
    </el-form>
  </body>
</template>

<script>
export default {
  name: 'Register',
  data() {
    return {
      registerForm: {
        username: '',
        password: '',
      },
      url: require('../assets/register.jpg'),
    }
  },
  methods: {
    register() {
      this.$axios.post('/register', {
        username: this.registerForm.username,
        password: this.registerForm.password
      }).then(resp => {
        if (resp.data.code === 200) {
          this.$alert('注册成功', '提示', {
            confirmButtonText: '确定'
          })
          this.$router.replace('/login')
        } else {
          this.$alert(resp.data.message, '提示', {
            confirmButtonText: '确定'
          })
        }
      })
        .catch(err => {alert(err) })
    }
  },
}
</script>

<style>
.register-container {
  border-radius: 15px;
  background-clip: padding-box;
  margin: 90px auto;
  width: 350px;
  padding: 35px 35px 15px 35px;
  background: #fff;
  border: 1px solid #eaeaea;
  box-shadow: 0 0 25px #cac6c6;
}

.register-title {
  margin: 0px auto 40px auto;
  text-align: center;
  color: #1e2b36;
}

#poster {
  background-position: center;
  height: 100%;
  width: 100%;
  background-size: cover;
  position: fixed;
}

body {
  margin: 0;
  padding: 0;
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