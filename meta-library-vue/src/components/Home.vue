<template>
  <div>
    <NavMenu />
    <router-view />
  </div>
</template>

<script>
import NavMenu from '@/components/common/NavMenu'
export default {
  name: 'Home',
  components: {
    NavMenu,
  }
}
</script>
<style>

</style>
