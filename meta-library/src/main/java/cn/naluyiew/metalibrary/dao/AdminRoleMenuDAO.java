package cn.naluyiew.metalibrary.dao;

import cn.naluyiew.metalibrary.entity.AdminRoleMenu;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface AdminRoleMenuDAO extends JpaRepository<AdminRoleMenu, Integer> {
    List<AdminRoleMenu> findAllByRid(int rid);

    List<AdminRoleMenu> findAllByRidIn(List<Integer> rids);

    void deleteAllByRid(int rid);
}