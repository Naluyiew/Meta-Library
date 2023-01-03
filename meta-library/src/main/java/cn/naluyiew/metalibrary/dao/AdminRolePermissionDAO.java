package cn.naluyiew.metalibrary.dao;

import cn.naluyiew.metalibrary.entity.AdminRolePermission;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface AdminRolePermissionDAO extends JpaRepository<AdminRolePermission, Integer> {
    List<AdminRolePermission> findAllByRid(int rid);

    List<AdminRolePermission> findAllByRidIn(List<Integer> rids);

    void deleteAllByRid(int rid);
}