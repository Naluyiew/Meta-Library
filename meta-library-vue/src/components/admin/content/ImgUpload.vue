<template>
  <el-upload ref="upload" action="http://localhost:8443/api/admin/content/books/covers" with-credentials
    :before-remove="beforeRemove" :on-success="handleSuccess" multiple :limit="1" :on-exceed="handleExceed"
    :file-list="fileList">
    <el-button size="small" type="primary">点击上传</el-button>
    <div slot="tip" class="el-upload__tip">只能上传JPG/PNG文件，且不超过500KB</div>
  </el-upload>
</template>

<script>
export default {
  name: 'ImgUpload',
  data() {
    return {
      fileList: [],
      url: ''
    }
  },
  methods: {
    handleExceed(files, fileList) {
      this.$message.warning(`限制选择 1 个文件，已选择了 ${files.length} 个文件，共选择了 ${files.length + fileList.length} 个文件`)
    },
    beforeRemove(file) {
      return this.$confirm(`确定移除 ${file.name}？`)
    },
    handleSuccess(response) {
      this.url = response
      this.$emit('onUpload')
      this.$message.warning('上传成功')
    },
    clear() {
      this.$refs.upload.clearFiles()
    }
  }
}
</script>

<style scoped>

</style>