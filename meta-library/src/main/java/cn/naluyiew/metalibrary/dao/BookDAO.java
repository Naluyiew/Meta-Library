package cn.naluyiew.metalibrary.dao;

import cn.naluyiew.metalibrary.entity.Book;
import cn.naluyiew.metalibrary.entity.Category;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface BookDAO extends JpaRepository<Book, Integer> {
    List<Book> findAllByCategory(Category category);

    List<Book> findAllByTitleLikeOrAuthorLike(String keyword1, String keyword2);
}