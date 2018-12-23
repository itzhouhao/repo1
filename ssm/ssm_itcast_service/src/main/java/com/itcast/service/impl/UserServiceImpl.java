package com.itcast.service.impl;

import com.itcast.domain.PageBean;
import com.itcast.domain.User;
import com.itcast.mapper.UserMapper;
import com.itcast.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class UserServiceImpl implements UserService {
    @Autowired
    private UserMapper mapper;

    public PageBean findAll(PageBean pageBean) {
            Integer rows=5;
        if(pageBean.getRows()==null){
            pageBean.setRows(rows);
        }

        /*计算总页数*/
        Integer totalCount = mapper.findTotalCount(pageBean);
        pageBean.setTotalCount(totalCount);
        int countPage=(totalCount%rows==0)?totalCount/rows:(totalCount/rows+1);
        pageBean.setTotalPage(countPage);

        /*首先计算开始页*/

        if(pageBean.getCurrentPage()<=1||pageBean.getCurrentPage()==null){
            pageBean.setCurrentPage(1);
        }
        if(pageBean.getCurrentPage()>=countPage||pageBean.getCurrentPage()==null){
            pageBean.setCurrentPage(countPage);
        }
        int start=(pageBean.getCurrentPage()-1)*rows;
        pageBean.setStartPage(start);

        System.out.println(pageBean);
        List<User> list = mapper.findAll(pageBean);
        pageBean.setUserList(list);
        return pageBean;
}

    @Override
    public User findUser(User user) {
        return mapper.findUser(user);
    }

    @Override
    public void saveUser(User user) {
        mapper.saveUser(user);
    }

    @Override
    public void deleteUser(User user) {
        mapper.deleteUser(user);
    }

    @Override
    public User findUserById(User user) {
        return mapper.findUserById(user);
    }

    @Override
    public void updateUser(User user1) {
        mapper.updateUser(user1);
    }

    @Override
    public void deleteSelected(List<Integer> list) {
        for(int i=0;i<list.size();i++){
            mapper.deleteById(list.get(i));
        }
    }
}
