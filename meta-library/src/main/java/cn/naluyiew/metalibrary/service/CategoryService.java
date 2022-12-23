package cn.naluyiew.metalibrary.service;

import cn.naluyiew.metalibrary.dao.CategoryDAO;
import cn.naluyiew.metalibrary.entity.Category;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CategoryService {
    @Autowired
    CategoryDAO categoryDAO;

    // 对查询的结果进行排序
    public List<Category> list() {
        Sort sort = Sort.by(Sort.Direction.DESC, "id");
        return categoryDAO.findAll(sort);
    }

    // 对查询的结果进行条件判断
    public Category get(int id) {
        Category c = categoryDAO.findById(id).orElse(null);
        return c;
    }
}