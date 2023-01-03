<template>
  <el-container>
    <el-aside style="width: 200px;margin-top: 20px">
      <SideMenu @indexSelect="listByCategory" ref="sideMenu" />
    </el-aside>
    <el-main>
      <Books class="books-area" ref="booksArea" />
    </el-main>
  </el-container>
</template>

<script>
import SideMenu from '@/components/library/SideMenu'
import Books from '@/components/library/Books'
export default {
  name: 'Library',
  components: {
    SideMenu,
    Books,
  },
  methods: {
    listByCategory() {
      let cid = this.$refs.sideMenu.cid
      let url = 'categories/' + cid + '/books'
      this.$axios.get(url).then(resp => {
        if (resp && resp.status === 200) {
          this.$refs.booksArea.books = resp.data.result
          this.$refs.booksArea.currentPage = 1
        }
      })
    }
  }
}
</script>

<style scoped>
.books-area {
  width: 990px;
  margin-left: auto;
  margin-right: auto;
}
</style>