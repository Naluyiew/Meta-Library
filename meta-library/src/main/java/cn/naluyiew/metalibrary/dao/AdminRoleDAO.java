package cn.naluyiew.metalibrary.dao;

import cn.naluyiew.metalibrary.entity.AdminRole;
import org.springframework.data.jpa.repository.JpaRepository;

public interface AdminRoleDAO extends JpaRepository<AdminRole, Integer> {
    AdminRole findById(int id);
}