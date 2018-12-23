<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<!-- 网页使用的语言 -->
<html lang="zh-CN">
    <head>
    <!-- 指定字符集 -->
    <meta charset="utf-8">
    <!-- 使用Edge最新的浏览器的渲染方式 -->
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <!-- viewport视口：网页可以根据设置的宽度自动进行适配，在浏览器的内部虚拟一个容器，容器的宽度与设备的宽度相同。
    width: 默认宽度与设备的宽度相同
    initial-scale: 初始的缩放比，为1:1 -->
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <title>用户信息管理系统</title>

    <!-- 1. 导入CSS的全局样式 -->
    <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
    <!-- 2. jQuery导入，建议使用1.9以上的版本 -->
    <script src="${pageContext.request.contextPath}/js/jquery-2.1.0.min.js"></script>
    <!-- 3. 导入bootstrap的js文件 -->
    <script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
    <style type="text/css">
        td, th {
            text-align: center;
        }
    </style>
</head>
<script>
    function deleteUser(id) {
        if(confirm("你确定删除选项吗?")){
            location.href="${pageContext.request.contextPath}/user/deleteUser?id="+id;
        }
    }
    $(function () {

        document.getElementById("deleteSelected").onclick=function (ev) {
            var flag=false;
            var ids = document.getElementsByName("id");
            for(var i=0;i<ids.length;i++){
                if(ids[i].checked){
                    flag=true;
                    break;
                }
            }
            if(flag){
                if(confirm("确定删除选定条目吗")){
                     document.getElementById("form").submit();
                }
            }


        }

        document.getElementById("firstCb").onclick=function () {
            var cbs = document.getElementsByName("id");
            for(var i=0;i<cbs.length;i++){
                cbs[i].checked=this.checked;
            }
        }

    })

</script>
<body>
<div class="container">
    <h3 style="text-align: center">用户信息列表</h3>
    <div style="float: left;">

        <form class="form-inline" action="${pageContext.request.contextPath}/user/findAll?currentPage=1&rows=5" method="post">
            <div class="form-group">
                <label for="exampleInputName2">姓名</label>
                <input type="text" name="user.username" value="${pageBean.user.username}" class="form-control" id="exampleInputName2" >
            </div>
            <div class="form-group">
                <label for="exampleInputName3">籍贯</label>
                <input type="text" name="user.address" value="${pageBean.user.address}" class="form-control" id="exampleInputName3" >
            </div>

            <div class="form-group">
                <label for="exampleInputEmail2">邮箱</label>
                <input type="text" name="user.email" value="${pageBean.user.email}" class="form-control" id="exampleInputEmail2"  >
            </div>
            <button type="submit" class="btn btn-default">查询</button>
        </form>

    </div>
    <div style="float: right;/*margin-right: 5px*/"  >
        <a class="btn btn-primary" href="javascript:void(0)" id="deleteSelected">删除选中</a>
        <a class="btn btn-primary" href="${pageContext.request.contextPath}/page/add.jsp">添加联系人</a>

    </div>
    <form id="form" action="${pageContext.request.contextPath}/user/deleteSelected">
    <table border="1" class="table table-bordered table-hover">
            <tr class="success">
            <th><input type="checkbox" id="firstCb"/></th>
            <th>编号</th>
            <th>姓名</th>
            <th>性别</th>
            <th>年龄</th>
            <th>地址</th>
            <th>操作</th>
        </tr>
        <c:forEach items="${pageBean.userList}" var="user">
            <tr>
                <td><input type="checkbox" name="id" value="${user.id}"></td>
                <td>${user.id}</td>
                <td>${user.username}</td>
                <td>${user.sex}</td>
                <td>${user.age}</td>
                <td>${user.address}</td>
                <td><a class="btn btn-default btn-sm" href="${pageContext.request.contextPath}/user/findUserById?id=${user.id}">修改</a>&nbsp;<a id="delete" class="btn btn-default btn-sm" href="javascript:deleteUser(${user.id});">删除</a></td>
            </tr>
        </c:forEach>
    </table>
        <nav aria-label="Page navigation">
            <ul class="pagination">
                <li>
                    <a href="${pageContext.request.contextPath}/user/findAll?currentPage=${pageBean.currentPage-1}&rows=5&user.username=${pageBean.user.username}&user.address=${pageBean.user.address}&user.email=${pageBean.user.email}" aria-label="Previous">
                        <span aria-hidden="true">&laquo;</span>
                    </a>
                </li>
                <c:forEach begin="1" end="${pageBean.totalPage}"  var="i">
                <li><a href="${pageContext.request.contextPath}/user/findAll?currentPage=${i}&rows=5&user.username=${pageBean.user.username}&user.address=${pageBean.user.address}&user.email=${pageBean.user.email}">${i}</a></li>
                </c:forEach>
                <li>
                    <a href="${pageContext.request.contextPath}/user/findAll?currentPage=${pageBean.currentPage+1}&rows=5&user.username=${pageBean.user.username}&user.address=${pageBean.user.address}&user.email=${pageBean.user.email}" aria-label="Next">
                        <span aria-hidden="true">&raquo;</span>
                    </a>
                </li>
            </ul>
        </nav>
        <div>共${pageBean.totalCount}条记录,共${pageBean.totalPage}页</div>
    </form>
</div>
</body>
</html>
