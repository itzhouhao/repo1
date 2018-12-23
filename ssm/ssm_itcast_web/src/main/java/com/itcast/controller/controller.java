package com.itcast.controller;

import com.itcast.domain.PageBean;
import com.itcast.domain.User;
import com.itcast.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import java.util.Enumeration;
import java.util.LinkedList;
import java.util.List;

@Controller
@RequestMapping("/user")
public class controller {
    @Autowired
    private UserService service;

    @RequestMapping("/findAll")
    public String findAll(PageBean pageBean1,Model model){

        System.out.println("aaaa"+pageBean1);

        PageBean pageBean = service.findAll(pageBean1);
        System.out.println("bbb"+pageBean);
        model.addAttribute("pageBean",pageBean);
        return "list";
    }

    @RequestMapping("/login")
    public String login(User user,String ck){
        User user1=service.findUser(user);

        Cookie cookieName=new Cookie("username",user.getUsername());
        Cookie cookiePwd=new Cookie("password",user.getPassword());

        System.out.println(user1);
        if (user1==null){
            return "loginError";
        }
        return "index1";
    }

    @RequestMapping("/saveUser")
    public String saveUser(User user){
        service.saveUser(user);
        System.out.println(user);
        return "redirect:/user/findAll?currentPage=1&rows=5";
    }

    @RequestMapping("/deleteUser")
    public String deleteUser(User user){
        service.deleteUser(user);

        return "redirect:/user/findAll?currentPage=1&rows=5";
    }

    @RequestMapping("/findUserById")
    public String findUserById(User user1,Model model){
        User user=service.findUserById(user1);
        model.addAttribute("user",user);
        return "update";
    }

    @RequestMapping("/updateUser")
    public String updateUser(User user){
        service.updateUser(user);
        System.out.println(user);
        return "redirect:/user/findAll?currentPage=1&rows=5";
    }


    @RequestMapping("/deleteSelected")
    public String deleteSelected(HttpServletRequest request){
        String[] ids = request.getParameterValues("id");
        List<Integer> list=new LinkedList<>();
        for (String id : ids) {
            list.add(Integer.parseInt(id));
        }

        service.deleteSelected(list);
        return "redirect:/user/findAll?currentPage=1&rows=5";
    }

}
