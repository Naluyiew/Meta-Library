<template>
  <div id="poster">
    <img src="../../assets/404.png" />
  </div>
</template>

<script>
export default {
  name: 'NotFound'
}
</script>

<style scoped>
#poster {
  background: url("../../assets/register.jpg") no-repeat;
  background-position: center;
  height: 100%;
  width: 100%;
  background-size: cover;
  position: fixed;
}

img {
  margin-top: 10%;
}
</style>
