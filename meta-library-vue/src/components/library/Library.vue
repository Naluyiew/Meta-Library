<template>
  <el-container>
    <el-aside style="width:180px;">
      <SideMenu @indexSelect="loadBooksByCategory" ref="sideMenu" />
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
    loadBooksByCategory() {
      const cid = this.$refs.sideMenu.cid
      this.$req.get(`/categories/${cid}/books`)
        .then(result => {
          this.$refs.booksArea.books = result
          this.$refs.booksArea.currentPage = 1
        })
    }
  }
}
</script>

<style scoped>
.books-area {
  max-width: 950px;
  margin-left: auto;
  margin-right: auto;
}
</style>