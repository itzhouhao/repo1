package com.itcast.mapper;

import com.itcast.domain.PageBean;
import com.itcast.domain.User;

import java.util.List;

public interface UserMapper {
    List<User> findAll(PageBean pageBean);

    User findUser(User user);

    void saveUser(User user);

    void deleteUser(User user);

    User findUserById(User user);

    void updateUser(User user);

    void deleteById(Integer id);

    Integer findTotalCount(PageBean pageBean);

}
