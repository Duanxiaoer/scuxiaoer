<%@ page import="scuxiaoer.DB" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.net.URLEncoder" %><%--
  Created by IntelliJ IDEA.
  Tucao: duanqifeng
  Date: 2018/7/14
  Time: 12:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>快递</title>
</head>
<body>
<%
    request.setCharacterEncoding("utf-8");
    PrintWriter writer = response.getWriter();

    DB db = new DB();
    db.connectToDB();

    String name = request.getParameter("name");
    String stuNo = request.getParameter("stuNo");
    String school = request.getParameter("school");
    String location = request.getParameter("location");
    String tel = request.getParameter("tel");

    if (name.length()<1||stuNo.length()<1||school.length()<1||location.length()<1||tel.length()<1){
        writer.print("<script>alert('请将信息填写完整！');window.history.back()</script>");
        return;
    }

    HttpSession httpSession =request.getSession();
    String svalue = (String) httpSession.getAttribute("email");

    boolean online = false;
    if (svalue!=null){
        online = true;
    }
    if (online){
        db.insertCards("cards",name,stuNo,school,location,tel,svalue);
        writer.print("<script>alert('登记成功，小二正火速赶往快递街！');window.location='home.jsp'</script>");
    }else{
        writer.print("<script>alert('为了信息真实，请先登录一下吧！');window.location='../login/login.html'</script>");
    }
%>
</body>
</html>
