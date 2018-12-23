package com.itcast.service;

import com.itcast.domain.PageBean;
import com.itcast.domain.User;

import java.util.List;

public interface UserService {
    PageBean findAll(PageBean pageBean);

    User findUser(User user);

    void saveUser(User user);

    void deleteUser(User user);

    User findUserById(User user);

    void updateUser(User user1);

    void deleteSelected(List<Integer> list);
}
