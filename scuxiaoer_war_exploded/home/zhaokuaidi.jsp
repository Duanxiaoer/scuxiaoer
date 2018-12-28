<%@ page import="scuxiaoer.DB" %>
<%@ page import="scuxiaoer.SentEmail" %>
<%@ page import="java.io.PrintWriter" %><%--
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
    DB db = new DB();
    db.connectToDB();
    PrintWriter writer = response.getWriter();
    request.setCharacterEncoding("utf-8");
    String customerName = request.getParameter("customerName");
    String customerTel = request.getParameter("customerTel");
    String message = request.getParameter("message");
    String location = request.getParameter("location");
    String qkbc = request.getParameter("qkbc");
    String xiaoer = request.getParameter("xiaoer");
    String xiaoertel = request.getParameter("xiaoerTel");
    xiaoer="段其沣";
    xiaoertel="13072810205";

    if (customerName.length()<1||customerTel.length()<1||message.length()<1||location.length()<1){
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
        String kuaidiInfo = "\n用户名："+customerName+"\n用户电话："+customerTel+"\n短信："+message+"\n地址："+location+"" +
                "\n情况补充："+qkbc+"\n\n官方提醒，请尽快取件哦 ~  ~";
        db.insertKuaidi("kuaidi",customerName,customerTel,message,location,qkbc,xiaoer,xiaoertel,svalue);
        SentEmail.sendEmail_kuaidi("scuxiaoer@126.com",kuaidiInfo);
        writer.print("<script>alert('登记成功，小二正火速赶往快递街！');window.location='kuaidiinfo.jsp'</script>");
    }else{
        writer.print("<script>alert('操作超时，请重新登录！');window.location='../login/login.html'</script>");
    }
%>
</body>
</html>
