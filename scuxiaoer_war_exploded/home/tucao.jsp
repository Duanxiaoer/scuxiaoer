<%@ page import="java.io.PrintWriter" %>
<%@ page import="scuxiaoer.DB" %><%--
  Created by IntelliJ IDEA.
  Tucao: duanqifeng
  Date: 2018/7/16
  Time: 15:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>submittucao</title>
</head>
<body>
</body>
<%
    DB db = new DB();
    db.connectToDB();
    PrintWriter writer = response.getWriter();
    request.setCharacterEncoding("utf-8");
    String lueluelue = request.getParameter("lueluelue");
    String name = request.getParameter("name");
    String email = "";

    if (session.getAttribute("email") !=null){
        email = session.getAttribute("email").toString();
    }else {
        writer.print("<script>alert('请先登录！');window.location='/login/login.html'</script>");
        return;
    }

    if (lueluelue.length()<1){
        writer.print("<script>alert('没有什么想说的吗？');window.history.back()</script>");
        return;
    }

    HttpSession httpSession =request.getSession();
    String svalue = (String) httpSession.getAttribute("email");
    boolean online = false;
    if (svalue!=null){
        online = true;
    }

    if (online){
        db.insertInfo(name,lueluelue,email);
        writer.print("<script>alert('知道啦！');window.location='guangchang.jsp'</script>");
    }else{
        writer.print("<script>alert('操作超时，请重新登录！');window.location='../login/login.html'</script>");
        return;
    }
%>
</html>
