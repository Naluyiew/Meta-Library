# Meta-Library
## 介绍

Meta-Library 是一个图书管理系统，前台图书馆用于展示图书信息，后台管理中心用于维护用户信息和图书信息。

系统默认有四个角色：超级管理员，管理员，访客，游客。
1）超级管理员（admin/admin）：可以查看图书信息，访问管理中心，进行用户管理和内容管理；
2）管理员（editor/editor）：可以查看图书信息，访问管理中心，进行内容管理；
3）访客（visitor/visitor）：可以查看图书信息，访问管理中心；
4）游客：只可以访问图书馆，查看图书信息。

[在线预览](http://metalibrary.lliiooiill.cn)

## 部署

需要在本地安装 node 和 git，数据库用到 MySQL 和 Redis。

```bash
# 克隆项目到本地
git clone https://github.com/Naluyiew/Meta-Library.git
```

项目的 meta-library-vue 为前端部分，meta-library 为后端部分。

前端部分：

```bash
# 进入前端项目目录
cd Meta-Library\meta-library-vue

# 安装依赖
npm install

# 启动服务
npm run dev

# 浏览器访问 http://localhost:8080
```

后端部分：

```bash
# 在 MySQL 创建数据库 meta-library ，数据库脚本在 src\src\main\resources 目录下的 meta-library.sql 文件中

# 启动 Redis 服务，端口为6379（默认端口），密码为空

# 在 IDEA 点击 maven ，安装 pox.xml 的相关依赖，运行后端项目
```

## 支持

如果你觉得这个项目还不错，欢迎点击⭐Star支持一下。