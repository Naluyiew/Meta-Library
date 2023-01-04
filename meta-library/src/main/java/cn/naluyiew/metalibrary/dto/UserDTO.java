package cn.naluyiew.metalibrary.dto;

import cn.naluyiew.metalibrary.dto.base.OutputConverter;
import cn.naluyiew.metalibrary.entity.AdminRole;
import cn.naluyiew.metalibrary.entity.User;
import lombok.Data;
import lombok.ToString;

import java.util.List;

@Data
@ToString
public class UserDTO implements OutputConverter<UserDTO, User> {
    private int id;
    private String username;
    private boolean enabled;
    private List<AdminRole> roles;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public boolean isEnabled() {
        return enabled;
    }

    public void setEnabled(boolean enabled) {
        this.enabled = enabled;
    }

    public List<AdminRole> getRoles() {
        return roles;
    }

    public void setRoles(List<AdminRole> roles) {
        this.roles = roles;
    }
}