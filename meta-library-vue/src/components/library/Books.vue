<template>
  <div>
    <!-- 搜索框 -->
    <SearchBar @onSearch="onSearch" ref="searchBar" style="margin-bottom: 20px;" />
    <div class="book-list">
      <!-- 显示图书信息 -->
      <el-tooltip placement="right" v-for="item in books.slice((currentPage - 1) * pagesize, currentPage * pagesize)"
        :key="item.id">
        <!-- 图书详情 -->
        <p slot="content" style="font-size: 14px;">{{ item.title }}</p>
        <p slot="content" style="font-size: 13px;">
          <span>{{ item.author }}</span> /
          <span>{{ item.press }}</span> /
          <span>{{ item.date }}</span>
        </p>
        <p slot="content" class="abstract">{{ item.abs }}</p>
        <!-- 图书简要信息 -->
        <el-card class="book" :body-style="{ padding: '10px' }" shadow="hover">
          <div class="cover">
            <img :src="item.cover" alt="封面">
          </div>
          <div class="title">
            {{ item.title }}
          </div>
          <div class="author">
            {{ item.author }}
          </div>
        </el-card>
      </el-tooltip>
    </div>
    <!-- 分页 -->
    <el-pagination @current-change="handleCurrentChange" :current-page="currentPage" :page-size="pagesize"
      :total="books.length" :hide-on-single-page="onSinglePage" style="white-space:normal;margin-top:10px;">
    </el-pagination>
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
  computed: {
    onSinglePage() {
      return this.books.length <= 18
    }
  },
  methods: {
    loadBooks() {
      this.$req.get('/books').then(result => {
        this.books = result
      })
    },
    handleCurrentChange(currentPage) {
      this.currentPage = currentPage
    },
    onSearch() {
      this.$req.get('/search', { keywords: this.$refs.searchBar.keywords })
        .then(result => {
          this.books = result
        })
    },
  }
}
</script>

<style scoped>
.book-list {
  display: flex;
  justify-content: center;
  flex-wrap: wrap;
}

.abstract {
  width: 300px;
  line-height: 18px;
}

.book {
  width: 135px;
  height: 250px;
  margin: 10px;
}

.cover {
  width: 115px;
  height: 175px;
  margin-bottom: 6px;
}

img {
  width: 115px;
  height: 175px;
}

.title {
  font-size: 14px;
  color: #3377aa;
  text-align: left;
}

.author {
  font-size: 13px;
  color: #333;
  text-align: left;
}
</style>