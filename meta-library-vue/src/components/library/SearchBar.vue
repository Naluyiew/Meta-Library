<template>
  <div style="display: flex;justify-content: center;align-items: center;">
    <el-input @keyup.enter.native="searchClick" placeholder="输入书名 / 作者" prefix-icon="el-icon-search" size="small"
      v-model="keywords" style="width: 400px;margin-right: 10px">
    </el-input>
    <el-button size="small" type="primary" icon="el-icon-search" @click="searchClick">搜索</el-button>
  </div>
</template>

<script>
export default {
  name: 'SearchBar',
  data() {
    return {
      keywords: '',
    }
  },
  methods: {
    searchClick() {
      this.$emit('onSearch')
    }
  }
}
</script>

<style scoped>

</style>