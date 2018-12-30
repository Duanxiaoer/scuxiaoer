<%@ page import="scuxiaoer.SentEmail" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="scuxiaoer.DB" %>
<%@ page import="java.sql.ResultSet" %>
<%--
  Created by IntelliJ IDEA.
  User: duanqifeng
  Date: 2018/12/22
  Time: 5:51 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/log.ico" >
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
            background-color: #FFFFFF;
            width: 100%;
        }
        td,th{
            border: solid grey 1px;
            margin: 0 0 0 0;
            padding: 2px 2px 2px 2px
        }
        .c1 {
            width:auto
        }
        .c2 {
            width:auto
        }
        .c3 {
            width:auto
        }
        .c4 {
            width:auto
        }
        .c5 {
            width:auto
        }

        a:link,a:visited {
            color:blue
        }

        .container{
            margin:0 auto;
            width:80%;
            text-align:center;
        }

    </style>

</head>
<body>

    <div style="width: 100%" class="container">
        <h1 style="align-content: center">浏览名单</h1>

        <br>
        <br>
        <form action="home.jsp" method="get">
            <div style="padding-left: 5px"><input name="keywords" style="float: left" type="text" placeholder="姓名查询"><input style="float: left;margin-left: 10px;border-style: hidden;color: #4cae4c" type="submit" value="查询"><a href="home_menu.html"><input type="button" style="position: center" value="主页"></a></div>
        </form>
        <br>
        <br>
        <div style="padding-right: 5px;padding-left: 5px">
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
                    request.setCharacterEncoding("utf-8");
                    String red = "#ff4d37";
                    String keywords = "";//网页传过来的查询关键字
                    String pgno = "";  //网址中传递的页面数据
                    String pgcnt = ""; //网址传递的每页最大显示数目

                    int RowAmount = 0; //数据库中总的行数
                    int PageAmount = 0; //数据库所有页面可以组成多少个页面
                    int PageSize; //每页最大显示数目
                    int PageNow;  //当前页面
                    ResultSet rs;
                    if (request.getParameter("keywords") !=null){//获取网址传递的查询数据
                        keywords = request.getParameter("keywords");
                    }
                    if(request.getParameter("pgno")!=null){  //获取从网址传递的数据
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
                        pgcnt = "66";
                    }
                    PageSize = java.lang.Integer.parseInt(pgcnt); //转换为int类型

                    //**连接数据库**
                    try{
                        DB db = new DB();
                        db.connectToDB();
                        if (!keywords.equals("")){
                            rs = db.likeQueryCards("name",keywords);
                        }else {
                            rs = db.queryCards();
                        }
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
                            if (Integer.parseInt(rs.getString("id"))%2==0){
                                red = "#FFF";
                            }else{
                                red = "#ff4d37";
                            }
                %>
                <tr>
                    <td><%=rs.getString("id")%></td>
                    <td style="background-color: <%=red %>"><%=rs.getString("name") %></td>
                    <td><%=rs.getString("stuNo") %></td>
                    <td><%=rs.getString("school") %></td>
                    <td><%=rs.getString("location") %></td>
                    <td><%=rs.getString("tel") %></td>
                </tr>
                <%
                            rs.next();
                        }
                        rs.close();
                    }catch (Exception e){
                        e.printStackTrace();
                    }
                %>
            </table>
        </div>

        <br>

        <div style="padding-right: 20px;padding-left: 20px">
            <div style="float: left;width: 20px">
                <a href="isLoggedIn.jsp"><input style="color: #ff4828" type="submit" value="我也捡到了卡" class="btn btn-primary"></a>
            </div>
            <div style="float: right">
                <a href="home.jsp?pgno=<%=PageNow-1 %>&pgcnt=66" class="action-button"><input style="color: #4cae4c" type="submit" value="上一页" class="btn btn-primary"></a>
            </div>
            <div style="float: right;margin-right: 5px">
                <a href="home.jsp?pgno=<%=PageNow+1 %>&pgcnt=66"><input style="color: #4cae4c" type="submit" value="下一页" class="btn btn-primary"></a>
            </div>
        </div>

        <br><br>
        <br><br>

        <p>页数:<%=PageAmount %>/<%=PageNow%>&nbsp;&nbsp;&nbsp;总卡数:<%=RowAmount %></p>


    </div>


    <script src="js/jquery-1.9.1.min.js" type="text/javascript"></script>
    <script src="js/jquery.easing.min.js" type="text/javascript"></script>
    <script src="js/jQuery.time.js" type="text/javascript"></script>
</body>
</html>
