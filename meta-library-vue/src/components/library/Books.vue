<template>
  <div>
    <el-row style="height: 900px;">
      <!-- 搜索框 -->
      <SearchBar @onSearch="searchResult" ref="searchBar" />
      <!-- 显示所有图书 -->
      <el-tooltip effect="dark" placement="right"
        v-for="item in books.slice((currentPage - 1) * pagesize, currentPage * pagesize)" :key="item.id">
        <!-- 图书详情 -->
        <p slot="content" style="font-size: 14px;margin-bottom: 6px;">{{ item.title }}</p>
        <p slot="content" style="font-size: 13px;margin-bottom: 6px">
          <span>{{ item.author }}</span> /
          <span>{{ item.press }}</span> /
          <span>{{ item.date }}</span>
        </p>
        <p slot="content" style="width: 300px" class="abstract">{{ item.abs }}</p>
        <!-- 图书简要 -->
        <el-card style="width: 135px;margin-bottom: 20px;height: 250px;float: left;margin-right: 15px" class="book"
          bodyStyle="padding:10px" shadow="hover">
          <!-- 封面 -->
          <div class="cover">
            <img :src="item.cover" alt="封面">
          </div>
          <!-- 书名 -->
          <div class="title">
            <a href="">{{ item.title }}</a>
          </div>
          <!-- 作者 -->
          <div class="author">{{ item.author }}</div>
        </el-card>
      </el-tooltip>
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
export default {
  name: 'Books',
  components: {
    SearchBar,
  },
  data() {
    return {
      books: [],
      currentPage: 1,
      pagesize: 18
    }
  },
  mounted: function () {
    this.loadBooks()
  },
  methods: {
    // 加载图书
    loadBooks() {
      this.$axios.get('/books').then(resp => {
        if (resp && resp.data.code === 200) {
          this.books = resp.data.result
        }
      })
    },
    handleCurrentChange: function (currentPage) {
      this.currentPage = currentPage
    },
    searchResult() {
      this.$axios
        .get('/search?keywords=' + this.$refs.searchBar.keywords, {
        }).then(resp => {
          if (resp && resp.data.code === 200) {
            this.books = resp.data.result
          }
        })
    },
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

.switch {
  display: flex;
  position: absolute;
  left: 780px;
  top: 25px;
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