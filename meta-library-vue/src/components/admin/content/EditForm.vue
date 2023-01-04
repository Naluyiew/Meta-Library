<template>
  <div style="text-align: left">
    <el-button class="add-button" type="primary" @click="dialogFormVisible = true">添加图书</el-button>
    <el-dialog title="添加/修改图书" :visible.sync="dialogFormVisible" @close="clear" :close-on-click-modal="false">
      <el-form v-model="form" style="text-align: left" ref="dataForm" :model="form" :rules="rules">
        <el-form-item label="书名" :label-width="formLabelWidth" prop="title">
          <el-input v-model="form.title" autocomplete="off" placeholder="例：元图书馆的发展史"></el-input>
        </el-form-item>
        <el-form-item label="作者" :label-width="formLabelWidth" prop="author">
          <el-input v-model="form.author" autocomplete="off" placeholder="例：栏仔"></el-input>
        </el-form-item>
        <el-form-item label="出版社" :label-width="formLabelWidth" prop="press">
          <el-input v-model="form.press" autocomplete="off" placeholder="例：人民出版社"></el-input>
        </el-form-item>
        <el-form-item label="出版日期" :label-width="formLabelWidth" prop="date">
          <el-input v-model="form.date" autocomplete="off" placeholder="例：2022-12-20"></el-input>
        </el-form-item>
        <el-form-item label="封面" :label-width="formLabelWidth" prop="cover">
          <el-input v-model="form.cover" autocomplete="off" placeholder="图片保存地址"></el-input>
          <ImgUpload @onUpload="uploadImg" ref="imgUpload" />
        </el-form-item>
        <el-form-item label="简介" :label-width="formLabelWidth" prop="abs">
          <el-input type="textarea" v-model="form.abs" autocomplete="off"
            placeholder="例：《元图书馆的发展史》是一部惊天地泣鬼神的著作。"></el-input>
        </el-form-item>
        <el-form-item label="分类" :label-width="formLabelWidth" prop="cid">
          <el-select v-model="form.cid" placeholder="请选择分类">
            <el-option label="文学" value="1"></el-option>
            <el-option label="流行" value="2"></el-option>
            <el-option label="文化" value="3"></el-option>
            <el-option label="生活" value="4"></el-option>
            <el-option label="经管" value="5"></el-option>
            <el-option label="科技" value="6"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item prop="id" style="height: 0">
          <el-input type="hidden" v-model="form.id" autocomplete="off"></el-input>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogFormVisible = false">取 消</el-button>
        <el-button type="primary" @click="onSubmit">确 定</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import ImgUpload from '@/components/admin/content/ImgUpload'
export default {
  name: 'EditForm',
  components: {
    ImgUpload
  },
  data() {
    return {
      dialogFormVisible: false,
      rules: {
        title: [{ required: true, message: '书名不能为空', trigger: 'blur' }],
        author: [{ required: true, message: '作者不能为空', trigger: 'blur' }],
        cid: [{ required: true, message: '请选择分类', trigger: 'blur' }]
      },
      form: {
        id: '',
        title: '',
        author: '',
        date: '',
        press: '',
        cover: '',
        abs: '',
        cid: ''
      },
      formLabelWidth: '120px'
    }
  },
  watch: {
    dialogFormVisible(newVal) {
      // 关闭弹出框时，newVal为false，清除校验信息
      if (!newVal) {
        this.$refs.dataForm.clearValidate()
      }
    }
  },
  methods: {
    clear() {
      this.$refs.imgUpload.clear()
      this.$refs.dataForm.resetFields()
    },
    onSubmit() {
      this.$refs.dataForm.validate((valid) => {
        // 通过验证，发送请求
        if (valid) {
          this.$axios
            .post('/admin/content/books', {
              id: this.form.id,
              cover: this.form.cover,
              title: this.form.title,
              author: this.form.author,
              date: this.form.date,
              press: this.form.press,
              abs: this.form.abs,
              category: { id: this.form.cid }
            }).then(resp => {
              if (resp && resp.status === 200) {
                this.dialogFormVisible = false
                this.$emit('onSubmit')
              }
            })
            .catch(failResponse => { })
        } else {
          return false;
        }
      });
    },
    uploadImg() {
      this.form.cover = this.$refs.imgUpload.url
    }
  }
}
</script>

<style scoped>
.add-button {
  margin: 0px 18px;
}
</style>