package cn.naluyiew.metalibrary.dao;

import cn.naluyiew.metalibrary.entity.Category;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CategoryDAO extends JpaRepository<Category, Integer> {
    // 不需要额外构造的方法，JPA 提供的默认方法够用
}