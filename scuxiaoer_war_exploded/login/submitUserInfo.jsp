<%--
  Created by IntelliJ IDEA.
  User: duanqifeng
  Date: 2018/6/27
  Time: 11:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.sql.*" %>
<%@ page import="scuxiaoer.DB" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.net.URLDecoder" %>
<html>
<head>
    <title>submitUsersInfo</title>
</head>
<body>
<%
    DB db = new DB();
    db.connectToDB();
    PrintWriter writer = response.getWriter();
    String email=request.getParameter("email");
    String pwd = request.getParameter("password");
    //存储当前用户名，周期为一小时,以及对cookies的访问权限
    HttpSession httpSession = request.getSession();
    httpSession.setAttribute("email",email);

    //将数据库信息字符串连接成为一个完整的url（也可以直接写成url，分开写是明了可维护性强）

    if (email.length()<1||pwd.length()<1){
        writer.print("<script>alert('账号和密码不能为空！');window.history.back()</script>");
        return;
    }
    int status = 0;//0 未注册  1 注册密码不对  2 登录成功
    try {
        ResultSet rs = db.queryUserinfo();
        while(rs.next()){
            if (email.equals(rs.getString("email"))){
                status = 1;
                if (pwd.equals(rs.getString("password"))){
                    status =2;
                    String em = URLDecoder.decode(rs.getString("email"),"utf-8");
                    String name = URLDecoder.decode(rs.getString("name"),"utf-8");
                    System.out.println(name);
                    Cookie cookie_email = new Cookie("email",em);
                    Cookie cookie_name = new Cookie("name",name);
                    cookie_email.setMaxAge(60*60);
                    cookie_name.setMaxAge(60*60);
                    cookie_email.setPath("/");
                    cookie_name.setPath("/");
                    response.addCookie(cookie_email);
                    response.addCookie(cookie_name);
                }
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    }

    response.setCharacterEncoding("utf-8");

    switch (status){
        case 0:
            writer.print("<script>alert('您还未注册！');window.history.back()</script>");
            break;
        case 1:
            writer.print("<script>alert('密码错误！');window.history.back()</script>");
            break;
        case 2:
            writer.print("<script>window.location='../home/home_menu.html'</script>");
            break;
    }
    writer.flush();
    writer.close();
%>
</body>
</html>