<template>
  <div>
    <el-row style="height: 840px;">
      <!-- 搜索框 -->
      <SearchBar @onSearch="searchResult" ref="searchBar" />
      <!-- 显示所有图书 -->
      <el-tooltip effect="dark" placement="right"
        v-for="item in books.slice((currentPage - 1) * pagesize, currentPage * pagesize)" :key="item.id">
        <!-- 图书详情 -->
        <p slot="content" style="font-size: 14px;margin-bottom: 6px;">{{ item.title }}</p>
        <p slot="content" style="font-size: 13px;margin-bottom: 6px">
          <span>{{ item.author }}</span> /
          <span>{{ item.date }}</span> /
          <span>{{ item.press }}</span>
        </p>
        <p slot="content" style="width: 300px" class="abstract">{{ item.abs }}</p>
        <!-- 图书简要 -->
        <el-card style="width: 135px;margin-bottom: 20px;height: 250px;float: left;margin-right: 15px" class="book"
          bodyStyle="padding:10px" shadow="hover">
          <!-- 封面 -->
          <div class="cover" @click="editBook(item)">
            <img :src="item.cover" alt="封面">
          </div>
          <div class="info">
            <!-- 书名 -->
            <div class="title">
              <a href="">{{ item.title }}</a>
            </div>
            <!-- 删除按钮 -->
            <i class="el-icon-delete" @click="deleteBook(item.id)"></i>
          </div>
          <!-- 作者 -->
          <div class="author">{{ item.author }}</div>
        </el-card>
      </el-tooltip>
      <!-- 添加/修改图书的弹出表单 -->
      <EditForm @onSubmit="loadBooks()" ref="edit" />
    </el-row>
    <el-row>
      <!-- 分页 -->
      <el-pagination @current-change="handleCurrentChange" :current-page="currentPage" :page-size="pagesize"
        :total="books.length">
      </el-pagination>
    </el-row>
  </div>
</template>

<script>
import SearchBar from '@/components/library/SearchBar'
import EditForm from '@/components/library/EditForm'
export default {
  name: 'Books',
  components: {
    SearchBar,
    EditForm
  },
  data() {
    return {
      books: [],
      currentPage: 1,
      pagesize: 17
    }
  },
  mounted: function () {
    this.loadBooks()
  },
  methods: {
    // 加载图书
    loadBooks() {
      this.$axios.get('/books').then(resp => {
        if (resp && resp.status === 200) {
          this.books = resp.data
        }
      })
    },
    handleCurrentChange(currentPage) {
      this.currentPage = currentPage
    },
    searchResult() {
      this.$axios.get('/search?keywords=' + this.$refs.searchBar.keywords, {
      }).then(resp => {
        if (resp && resp.status === 200) {
          this.books = resp.data
        }
      })
    },
    deleteBook(id) {
      this.$confirm('将永久删除该书籍，是否继续？', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        this.$axios.post('/delete', {
          id: id
        }).then(resp => {
          if (resp && resp.status === 200) {
            this.loadBooks()
          }
        })
      }
      ).catch(() => {
        this.$message({
          type: 'info',
          message: '取消删除'
        })
      })
    },
    // 弹出修改表单并渲染数据
    editBook(item) {
      this.$refs.edit.dialogFormVisible = true
      this.$refs.edit.form = {
        id: item.id,
        cover: item.cover,
        title: item.title,
        author: item.author,
        date: item.date,
        press: item.press,
        abs: item.abs,
        category: {
          id: item.category.id.toString(),
          name: item.category.name
        }
      }
    }
  }
}
</script>

<style scoped>
.cover {
  width: 115px;
  height: 172px;
  margin-bottom: 7px;
  overflow: hidden;
  cursor: pointer;
}

img {
  width: 115px;
  height: 172px;
  /*margin: 0 auto;*/
}

.title {
  font-size: 14px;
  text-align: left;
}

.author {
  color: #333;
  width: 102px;
  font-size: 13px;
  margin-bottom: 6px;
  text-align: left;
}

.abstract {
  display: block;
  line-height: 17px;
}

.el-icon-delete {
  cursor: pointer;
  float: right;
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