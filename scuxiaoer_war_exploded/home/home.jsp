<%--
  Created by IntelliJ IDEA.
  User: duanqifeng
  Date: 2018/12/22
  Time: 5:51 PM
  To change this template use File | Settings | File Templates.
--%>
<%@page import="java.sql.Connection,java.sql.Statement,java.util.Scanner,java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>带它回家</title>
    <link rel="stylesheet" media="screen" href="css/css.css" />

    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="Free HTML5 Template by FreeHTML5.co" />
    <meta name="keywords" content="free html5, free template, free bootstrap, html5, css3, mobile first, responsive" />

    <!-- Facebook and Twitter integration -->
    <meta property="og:title" content=""/>
    <meta property="og:image" content=""/>
    <meta property="og:url" content=""/>
    <meta property="og:site_name" content=""/>
    <meta property="og:description" content=""/>
    <meta name="twitter:title" content="" />
    <meta name="twitter:image" content="" />
    <meta name="twitter:url" content="" />
    <meta name="twitter:card" content="" />
    <style>
        table{
            border-collapse: collapse;
            border: none;
            width: 700px;
        }
        td,th{
            border: solid grey 1px;
            margin: 0 0 0 0;
            padding: 5px 5px 5px 5px
        }
        .c1 {
            width:100px
        }
        .c2 {
            width:200px
        }
        .c3 {
            width:100px
        }
        .c4 {
            width:100px
        }
        .c5 {
            width:100px
        }
        .c6 {
            width:100px
        }
        a:link,a:visited {
            color:blue
        }

        .container{
            margin:0 auto;
            width:700px;
            text-align:center;
        }

    </style>

    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Insert title here</title>
</head>
<body>
<fieldset>
    <div class="container">
        <h1>浏览学生名单</h1>
        <table>
            <tr>
                <th class='c1'>序号</th>
                <th class='c1'>姓名</th>
                <th class='c2'>学号</th>
                <th class='c3'>学院</th>
                <th class='c4'>领取地址</th>
                <th class='c5'>电话</th>
            </tr>

            <%
                String pgno = "";  //网址中传递的页面数据
                String pgcnt = ""; //网址传递的每页最大显示数目
                int RowAmount = 0; //数据库中总的行数
                int PageAmount = 0; //数据库所有页面可以组成多少个页面
                int PageSize; //每页最大显示数目
                int PageNow;  //当前页面
                ResultSet rs;
                if(request.getParameter("pgno")!=null){  //获取网址从传递的数据
                    pgno = request.getParameter("pgno");
                }else{
                    pgno = "1";  //赋给初始值防止没有传入数据时崩溃
                }
                PageNow = java.lang.Integer.parseInt(pgno);
                if(PageNow <= 0){
                    PageNow = 1;
                }

                if(request.getParameter("pgcnt")!=null){
                    pgcnt = request.getParameter("pgcnt");
                }else{
                    pgcnt = "10";
                }
                PageSize = java.lang.Integer.parseInt(pgcnt); //转换为int类型

                //**连接数据库**
                try{
                    String connectString = "jdbc:mysql://localhost/scuxiaoer"
                            + "?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8";
                    String user = "root";
                    String pwd = "dqf009.";
                    String sql = "select *from cards;";
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection conn = DriverManager.getConnection(connectString, user, pwd);

                    Statement state = conn.createStatement();
                    rs = state.executeQuery(sql);
//            获取数据库行数
                    rs.last();
                    RowAmount = rs.getRow();
//            计算数据库中数据最大页面数
                    PageAmount = (RowAmount + PageSize - 1 )/ PageSize;
                    if(PageNow > PageAmount){
                        PageNow = PageAmount;
                    }
//            将当前的rs指针指向要显示的页面首条数据
                    if(PageAmount > 0){
                        rs.absolute((PageNow - 1)*PageSize + 1);
                    }
//            循环获取数据
                    for(int i = 0 ; i < PageSize && !rs.isAfterLast(); i++){
            %>
            <tr>
                <td><%=rs.getString("id")%></td>
                <td><%=rs.getString("name") %></td>
                <td><%=rs.getString("stuNo") %></td>
                <td><%=rs.getString("school") %></td>
                <td><%=rs.getString("location") %></td>
                <td><%=rs.getString("tel") %></td>
            </tr>
            <%
                        rs.next();
                    }
                    rs.close();
                    state.close();
                    conn.close();
                }catch (Exception e){
                    e.printStackTrace();
                }
            %>
        </table>
        <br><br>
        <div style="float:left">
            <a href="isLoggedIn.jsp">新增</a>
        </div>
        <div style="float:right">
            <a href="home.jsp?pgno=<%=PageNow-1 %>&pgcnt=10">
                上一页</a>    &nbsp;
            <a href="home.jsp?pgno=<%=PageNow+1 %>&pgcnt=10">
                下一页</a>
        </div>
        <br><br>
        <br><br>

        <p>总页数:<%=PageAmount %> 总卡数:<%=RowAmount %></p>
        <p>当前是第<%=PageNow%>页</p>

    </div>
</fieldset>

</body>
</html>
