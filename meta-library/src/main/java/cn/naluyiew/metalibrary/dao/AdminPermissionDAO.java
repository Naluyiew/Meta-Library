package cn.naluyiew.metalibrary.dao;

import cn.naluyiew.metalibrary.entity.AdminPermission;
import org.springframework.data.jpa.repository.JpaRepository;

public interface AdminPermissionDAO extends JpaRepository<AdminPermission, Integer> {
    AdminPermission findById(int id);
}
