package cn.naluyiew.metalibrary.controller;

import cn.naluyiew.metalibrary.entity.*;
import cn.naluyiew.metalibrary.result.Result;
import cn.naluyiew.metalibrary.result.ResultFactory;
import cn.naluyiew.metalibrary.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
public class UserController {
    @Autowired
    UserService userService;
    @Autowired
    AdminUserRoleService adminUserRoleService;

    @PutMapping("/api/admin/user/status")
    public Result updateUserStatus(@RequestBody User requestUser) {
        userService.updateUserStatus(requestUser);
        return ResultFactory.buildSuccessResult("用户状态更新成功");
    }

    @PutMapping("/api/admin/user/password")
    public Result resetPassword(@RequestBody User requestUser) {
        userService.resetPassword(requestUser);
        return ResultFactory.buildSuccessResult("重置密码成功");
    }

    @PutMapping("/api/admin/user")
    public Result editUser(@RequestBody User requestUser) {
        userService.editUser(requestUser);
        return ResultFactory.buildSuccessResult("修改用户信息成功");
    }
}