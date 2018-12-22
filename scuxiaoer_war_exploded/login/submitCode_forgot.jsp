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
    <title>提交验证码</title>
</head>
<body>
<%
    request.setCharacterEncoding("utf-8");
    PrintWriter writer = response.getWriter();
    String code_input = request.getParameter("code");

    String code_email=session.getAttribute("code_forgot").toString();


    if (!code_input.equals("")){
        if (code_email!=null){
            if (code_email.equals(code_input)){
                writer.print("<script>alert('请重置您的密码！');window.location='resetPwd.html'</script>");
            }else{
                writer.print("<script>alert('验证码错误🙅！');window.history.back()</script>");
                return;
            }
        }else{
            writer.print("<script>alert('操作超时，重来！');window.location='sentEmail_forgot.html'</script>");
        }
    }else {
        writer.print("<script>alert('请输入验证码！');window.history.back()</script>");
        return;
    }
%>
</body>
</html>
