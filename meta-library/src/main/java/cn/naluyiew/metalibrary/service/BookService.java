package cn.naluyiew.metalibrary.service;

import cn.naluyiew.metalibrary.dao.BookDAO;
import cn.naluyiew.metalibrary.entity.Book;
import cn.naluyiew.metalibrary.entity.Category;
import cn.naluyiew.metalibrary.redis.RedisService;
import cn.naluyiew.metalibrary.util.CastUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BookService {
    @Autowired
    private BookDAO bookDAO;
    @Autowired
    private CategoryService categoryService;
    @Autowired
    private RedisService redisService;

    public List<Book> list() {
        List<Book> books;
        String key = "booklist";
        Object bookCache = redisService.get(key);

        if (bookCache == null) {
            Sort sort = Sort.by(Sort.Direction.DESC, "id");
            books = bookDAO.findAll(sort);
            redisService.set(key, books);
        } else {
            books = CastUtils.objectConvertToList(bookCache, Book.class);
        }
        return books;
    }

    public void addOrUpdate(Book book) {
        redisService.delete("booklist");
        bookDAO.save(book);
        try {
            Thread.sleep(500);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        redisService.delete("booklist");
    }

    public void deleteById(int id) {
        redisService.delete("booklist");
        bookDAO.deleteById(id);
        try {
            Thread.sleep(500);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        redisService.delete("booklist");
    }

    public List<Book> listByCategory(int cid) {
        Category category = categoryService.get(cid);
        return bookDAO.findAllByCategory(category);
    }

    public List<Book> Search(String keywords) {
        return bookDAO.findAllByTitleLikeOrAuthorLike('%' + keywords + '%', '%' + keywords + '%');
    }
}