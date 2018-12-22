<%@ page import="scuxiaoer.DB" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.net.URLDecoder" %><%--
  Created by IntelliJ IDEA.
  Tucao: duanqifeng
  Date: 2018/7/10
  Time: 11:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>重置密码</title>
</head>
<body>
<%
    request.setCharacterEncoding("utf-8");
    PrintWriter writer = response.getWriter();
    String pwd = request.getParameter("pwd");
    String pwd_check = request.getParameter("pwd_check");
    if (!pwd.equals(pwd_check)){
        writer.print("<script>alert('两次输入密码不一样！');window.history.back()</script>");
    }else {
        String email = session.getAttribute("email").toString();
        if (email!=null){
            DB db = new DB();
            db.connectToDB();
            db.updateUserpwd(email,pwd);
            writer.print("<script>alert('密码已重置！');window.location='login.html'</script>");
        }else {
            writer.print("<script>alert('操作超时！');window.location='login.html'</script>");
        }
    }

%>
</body>
</html>
