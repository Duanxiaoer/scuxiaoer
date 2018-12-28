<%@ page import="java.io.PrintWriter" %>
<%@ page import="scuxiaoer.DB" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.sql.SQLException" %><%--
<%--
  Created by IntelliJ IDEA.
  User: duanqifeng
  Date: 2018/12/27
  Time: 12:22 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
<%
    String type=request.getParameter("type");
    String so=request.getParameter("supportOrOppose");
    String id=request.getParameter("infoId");
    String email=request.getParameter("myemail");
    int del=Integer.parseInt(request.getParameter("del"));//删除之前的点赞或踩

    DB db = new DB();
    db.connectToDB();

    if (type.equals("inc")){
        if (so.equals("support")){
            db.incSupport(id);
        }else{
            db.incOppose(id);
        }
        //添加到与我相关的消息中
        db.addInfoAboutMe(so,email,id,del);
    }else{
        if (so.equals("support")){
            db.decSupport(id);
        }else{
            db.decOppose(id);
        }
        //添加到与我相关的消息中
        db.delInfoAboutMe(so,email,id);
    }

%>
</head>
<body>

</body>
<script>
    window.location.href="guangchang.jsp";
</script>
</html>
