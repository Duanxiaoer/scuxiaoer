<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.sql.*" %>
<%@ page import="scuxiaoer.*" %>
<%@ page import="javax.jms.Session" %>
<%@ page import="java.net.URLDecoder" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.net.CookieHandler" %>
<%--
  Created by IntelliJ IDEA.
  Tucao: duanqifeng
  Date: 2018/6/28
  Time: 14:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>submitUserInfo</title>
</head>
<body>

<%
    PrintWriter writer=response.getWriter();
    request.setCharacterEncoding("utf-8");

    String email = request.getParameter("register-email");
    String name = request.getParameter("register-name");
    String pwd = request.getParameter("register-pwd");
    String pwd_check = request.getParameter("register-pwd-check");

    int status = 0;//0 未注册  1 已经注册过  2 密码不一样
    if (name.length()<1||email.length()<1||pwd.length()<1||pwd_check.length()<1){
        writer.print("<script>alert('请将信息填写完整！');window.history.back()</script>");
        return;
    }
    if (!pwd.equals(pwd_check)){
        status=2;
    }else{
        DB db = new DB();
        db.connectToDB();
        try{
            ResultSet resultSet = db.queryUserinfo();
            while(resultSet.next()){
                if (email.equals(resultSet.getString("email"))){
                    status=1;
                }
            }
            
            switch (status){
                case 0:
                    int one = (int) (Math.random()*10000);
                    int two = (int) (Math.random()*3000);
                    int three = (int) (Math.random()*400);
                    int four = (int) (Math.random()*70);
                    String code = String.valueOf(one+two+three+four);
                    SentEmail.sendEmail(email,code);

                    //保存cookie，五分钟有效

                    session.setAttribute("code", code);
                    session.setAttribute("name", name);
                    session.setAttribute("email", email);
                    session.setAttribute("pwd", pwd);

                    writer.print("<script>alert('验证码已经发送至您的邮箱！五分钟內输入有效');window.location='sentEmail.html'</script>");
            }
        }catch (Exception ignored){

        }
    }
    switch (status){
        case 1:
            writer.print("<script>alert('该邮箱已注册！');window.history.back()</script>");
            break;
        case 2:
            writer.print("<script>alert('两次输入密码不一样');window.history.back(-1)</script>");
            break;
    }
    writer.flush();
    writer.close();
%>

</body>

</html>
