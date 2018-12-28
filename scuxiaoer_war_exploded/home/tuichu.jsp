<%@ page import="java.io.PrintWriter" %><%--
  Created by IntelliJ IDEA.
  Tucao: duanqifeng
  Date: 2018/7/17
  Time: 20:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>退出登录</title>
</head>
<body>
<%
    Cookie cookie = new Cookie("email",null);
    cookie.setMaxAge(0);
    cookie.setPath("/");
    response.addCookie(cookie);
    PrintWriter writer = response.getWriter();
    writer.print("<script>alert('记得回来哦！');window.location='../login/login.html'</script>");
%>
</body>
</html>
