package cn.naluyiew.metalibrary.dao;

import cn.naluyiew.metalibrary.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserDAO extends JpaRepository<User, Integer> {
    // 通过用户名查询
    User findByUsername(String username);

    // 通过用户名及密码查询
    User getByUsernameAndPassword(String username, String password);
}