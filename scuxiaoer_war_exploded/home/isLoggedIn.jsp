<%@ page import="org.apache.commons.lang.ObjectUtils" %>
<%@ page import="java.io.PrintWriter" %><%--
  Created by IntelliJ IDEA.
  User: duanqifeng
  Date: 2018/12/22
  Time: 5:00 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>登录了吗？</title>
</head>
<body>
<%
    PrintWriter writer = response.getWriter();
    HttpSession httpSession = request.getSession();
    String flag = (String) httpSession.getAttribute("email");

    if (flag != null){
        writer.print("<script>window.location='find.html'</script>");
    }else{
        writer.print("<script>alert('为保证信息的真实，请先登录一下吧 ~ ~');window.location='../login/login.html'</script>");
    }

%>>
</body>
</html>
