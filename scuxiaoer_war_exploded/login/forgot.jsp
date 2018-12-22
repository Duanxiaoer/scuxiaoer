<%@ page import="scuxiaoer.SentEmail" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="scuxiaoer.DB" %>
<%@ page import="java.sql.ResultSet" %><%--
  Created by IntelliJ IDEA.
  Tucao: duanqifeng
  Date: 2018/7/17
  Time: 21:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>获取验证码</title>
</head>
<body>
<%
    PrintWriter writer=response.getWriter();
    DB db = new DB();
    db.connectToDB();
    ResultSet resultSet = db.queryUserinfo();
    String email = request.getParameter("email");
    if (email.equals("")){
        writer.print("<script>alert('嘿嘿嘿，邮箱不填麦！');window.location='forgot.html'</script>");
    }
    boolean signed=false;
    try{
        while (resultSet.next()){
            if (email.equals(resultSet.getString("email"))){
                signed = true;
            }
        }
    }catch (Exception e){
        e.printStackTrace();
    }

    if (signed){
        int one = (int) (Math.random()*10000);
        int two = (int) (Math.random()*3000);
        int three = (int) (Math.random()*400);
        int four = (int) (Math.random()*70);
        String code = String.valueOf(one+two+three+four);

        session.setAttribute("code_forgot",code);
        session.setAttribute("email",email);

        SentEmail.sendEmail_resetPwd(email,code);
        writer.print("<script>alert('验证码已发送至您的邮箱，五分钟内输入有效！');window.location='sentEmail_forgot.html'</script>");
    }else {
        writer.print("<script>alert('该邮箱还未注册！');window.history.back()</script>");
        return;
    }

%>
</body>
</html>
