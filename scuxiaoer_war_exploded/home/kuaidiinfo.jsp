<%@ page import="scuxiaoer.DB" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.io.PrintWriter" %>
<%--
  Created by IntelliJ IDEA.
  Tucao: duanqifeng
  Date: 2018/7/11
  Time: 14:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>快递信息</title>
</head>
<body>
<%
    PrintWriter writer = response.getWriter();
    boolean online = false;
    HttpSession httpSession = request.getSession();
    String svalue = (String) httpSession.getAttribute("email");
    if (svalue!=null){
        online = true;
    }
    if (!online){
        writer.print("<script>alert('操作超时，请重新登录！');window.location='../login/login.html'</script>");
    }

    DB db = new DB();
    db.connectToDB();
    ResultSet resultSet = db.queryKuaidi();
    if (resultSet!=null){
        try{
            int count=1;
            while(resultSet.next()){
                request.setCharacterEncoding("utf-8");
                String cName = resultSet.getString("customerName");
                String cTel = resultSet.getString("customerTel");
                String mesg = resultSet.getString("message");
                String location = resultSet.getString("location");
                String qkbc = resultSet.getString("qkbc");
                String xiaoer = resultSet.getString("xiaoer");
                String xiaoTel = resultSet.getString("xiaoerTel");
                String id = resultSet.getString("id_kuaidi");
                String email[] = id.split("#");
                String info = cName+"䵆"+cTel+"䵆"+mesg+"䵆"+location+"䵆"+qkbc+"䵆"+xiaoer+"䵆"+xiaoTel+"䵆"+id;
                info = URLEncoder.encode(info,"utf-8");//有中文，用utf-8编码
                if (svalue.equals(email[1])){
                    Cookie cookie = new Cookie("kuaidi"+count,info);
                    ++count;
                    cookie.setMaxAge(60*3);
                    cookie.setPath("/");
                    response.addCookie(cookie);
                    writer.print("<script>window.location='kuaidiinfo.html'</script>");
                }
            }

            if (count == 1){
                writer.print("<script>window.location='kuaidiinfo.html'</script>");
            }

        }catch (SQLException e){
            e.printStackTrace();
        }
    }else{
        writer.print("<script>window.location='kuaidiinfo.html'</script>");
    }
%>
</body>
</html>
