<%@ page import="scuxiaoer.DB" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.net.URLDecoder" %>
<%@ page import="java.net.URLEncoder" %><%--
  Created by IntelliJ IDEA.
  Tucao: duanqifeng
  Date: 2018/7/10
  Time: 11:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>提交验证码</title>
</head>
<body>
<%
    request.setCharacterEncoding("utf-8");
    PrintWriter writer = response.getWriter();
    String code_input = request.getParameter("code");
    String code_email=null,name=null,email=null,pwd=null;
    DB db = new DB();

    code_email = session.getAttribute("code").toString();
    name = session.getAttribute("name").toString();
    email = session.getAttribute("email").toString();
    pwd = session.getAttribute("pwd").toString();



    if (code_input !=null){
        if (code_email != null){
            if (code_email.equals(code_input)){
                db.connectToDB();
                db.insertUserInfo("userinfo",email,pwd,name);
                writer.print("<script>alert('注册成功！');window.location='login.html'</script>");
            }else if (code_input.equals("")){
                writer.print("<script>alert('验证码错误🙅！');window.history.back()</script>");
                return;
            }
        }else{
            writer.print("<script>alert('操作超时，请重新注册！');window.location='signup.html'</script>");
        }
    }else {
        writer.print("<script>alert('请输入验证码！');window.history.back()</script>");
        return;
    }
%>
</body>
</html>
