<template>
  <div style="padding:10px 10px 0px;">
    <!-- 添加/修改图书 -->
    <EditForm @onSubmit="loadBooks()" ref="edit" />
    <!-- 展示图书信息 -->
    <el-card v-loading="loading" element-loading-text="加载中" element-loading-spinner="el-icon-loading"
      style="width: 95%; margin-top:20px;">
      <el-table :data="books.slice((currentPage - 1) * pagesize, currentPage * pagesize)" stripe :height="tableHeight">
        <el-table-column type="index" width="50">
        </el-table-column>
        <el-table-column type="expand">
          <template slot-scope="props">
            <el-form label-position="left" inline>
              <el-form-item>
                <span>{{ props.row.abs }}</span>
              </el-form-item>
            </el-form>
          </template>
        </el-table-column>
        <el-table-column prop="title" label="书名（展开查看简介）" fit>
        </el-table-column>
        <el-table-column prop="author" label="作者" fit>
        </el-table-column>
        <el-table-column prop="press" label="出版社" fit>
        </el-table-column>
        <el-table-column prop="date" label="出版日期" width="120">
        </el-table-column>
        <el-table-column prop="category.name" label="分类" width="100">
        </el-table-column>
        <el-table-column fixed="right" label="操作" width="120">
          <template slot-scope="scope">
            <el-button @click.native.prevent="editBook(scope.row)" type="text" size="small">
              编辑
            </el-button>
            <el-button @click.native.prevent="deleteBook(scope.row.id)" type="text" size="small">
              移除
            </el-button>
          </template>
        </el-table-column>
        <template v-slot:empty>
          <h1>{{ tip }}</h1>
        </template>
      </el-table>
      <!-- 分页 -->
      <el-pagination @current-change="handleCurrentChange" :current-page="currentPage" :page-size="pagesize"
        :total="books.length" :hide-on-single-page="onSinglePage" style="white-space:normal;margin-top:10px">
      </el-pagination>
    </el-card>
  </div>
</template>

<script>
import EditForm from '@/components/admin/content/EditForm'
export default {
  name: 'BookManagement',
  components: { EditForm },
  data() {
    return {
      books: [],
      loading: true,
      tableHeight: window.innerHeight - 280,
      tip: '',
      currentPage: 1,
      pagesize: 10
    }
  },
  mounted() {
    this.loadBooks()
  },
  computed: {
    onSinglePage() {
      return this.books.length <= 10
    }
  },
  methods: {
    editBook(item) {
      this.$refs.edit.dialogFormVisible = true
      const { id, title, author, press, date, cover, abs, category } = item
      // 数据回显
      this.$nextTick(() => {
        this.$refs.edit.form = {
          id,
          title,
          author,
          press,
          date,
          cover,
          abs,
          cid: String(category.id)
        }
      })
    },
    loadBooks() {
      this.$req.get('/books').then(result => {
        this.books = result
        this.loading = false
      })
    },
    deleteBook(id) {
      this.$confirm('将永久删除该书籍, 是否继续?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        return this.$req.post('/admin/content/books/delete', { id })
      }).then(() => {
        this.loadBooks()
        this.$message({
          type: 'success',
          message: '成功删除'
        })
      }).catch(() => {
        this.$message({
          type: 'info',
          message: '取消删除'
        })
      })
    },
    handleCurrentChange(currentPage) {
      this.currentPage = currentPage
    },
  }
}
</script>

<style scoped>

</style>