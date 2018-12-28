<%@ page import="java.io.PrintWriter" %>
<%@ page import="scuxiaoer.DB" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.sql.SQLException" %><%--
  Created by IntelliJ IDEA.
  Tucao: duanqifeng
  Date: 2018/7/16
  Time: 16:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>信息展示</title>
    <link rel="stylesheet" media="screen" href="css/css.css"/>

    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="Free HTML5 Template by FreeHTML5.co"/>
    <meta name="keywords" content="free html5, free template, free bootstrap, html5, css3, mobile first, responsive"/>

    <!-- Facebook and Twitter integration -->
    <meta property="og:title" content=""/>
    <meta property="og:image" content=""/>
    <meta property="og:url" content=""/>
    <meta property="og:site_name" content=""/>
    <meta property="og:description" content=""/>
    <meta name="twitter:title" content=""/>
    <meta name="twitter:image" content=""/>
    <meta name="twitter:url" content=""/>
    <meta name="twitter:card" content=""/>
</head>
<body>


<form accept-charset="UTF-8" action="" method="post" id="msform" style="background-color: #eeeeee">
    <!-- progressbar -->
    <ul class="fs-title" style="align-content: center;font-size: xx-large">
        <li class="active">人民广场</li>
    </ul>
    <!-- fieldsets -->
    <fieldset style="background-color: #eeeeee">
        <div style="display:none;width: 100%;padding: 0px" id="end">

        </div>
        <%
            DB db = new DB();
            db.connectToDB();


//            //每次显示的消息数
//            int showNum = 10;
//            //总消息数
//            int totalNum = 0;
//            //已经显示了的消息数
//            int infoShowNum = 0;
//            if (request.getParameter("infoShowNum") != null){
//                infoShowNum = Integer.parseInt(request.getParameter("infoShowNum"));
//            }

            String content = "";
            String name = "";
            String support = "";
            String oppose = "";
            String myemail = "null";
            String supportcolor = "#000";
            String opposecolor = "#000";

            //当前用户和info的关系
            ResultSet rs_lnfoAboutMe = null;

            if (session.getAttribute("email") != null) {
                myemail = session.getAttribute("email").toString();
                rs_lnfoAboutMe = db.queryInfoAboutMe(myemail);
            }


            ResultSet rs_info = db.queryInfo();
            try {
//                //获取总消息数
//                rs_info.last();
//                totalNum = rs_info.getRow();

                //rs_info指向第一条记录
                rs_info.first();


                //每次追加showNum条消息
//                for (int i = 0; i < infoShowNum+showNum && !rs_info.isAfterLast(); ++i) {
                for (int i = 0; i < 100 && !rs_info.isAfterLast(); ++i) {
                    name = rs_info.getString("name");
                    content = rs_info.getString("content");
                    support = Integer.toString(rs_info.getInt("support"));
                    oppose = Integer.toString(rs_info.getInt("oppose"));
                    String info_id_show = rs_info.getString("id");

                    //将当前用户点赞和不支持信息显示
                    if (rs_lnfoAboutMe != null) {
                        while (rs_lnfoAboutMe.next()) {

                            //
                            String info_id_about_me = rs_lnfoAboutMe.getString("infoid");
                            String type = rs_lnfoAboutMe.getString("type");

                            if (info_id_about_me.equals(info_id_show)){

                                if(type.equals("support")){
                                    supportcolor = "#F00";
                                }else if (type.equals("oppose")){
                                    opposecolor = "#F00";
                                }
                                System.out.println("s: "+supportcolor+" o:"+opposecolor);
                                break;
                            }

                        }
                    }

                    if (Integer.parseInt(support)<1)
                        support = "";
                    if (Integer.parseInt(oppose)<1)
                        oppose = "";
        %>
        <div style="background-color: #ffffff;margin-bottom: 20px;">
            <div style="height: auto">
                <div style="display: flex; justify-content: space-between; align-items: center;">
                    <div style="display: flex; align-items: center;">
                        <div style="padding-left: 10px;padding-top: 10px"><img src="/log.ico"
                                                                               style="height: 42px; width: 42px; margin-right: 15px; border-top-left-radius: 50%; border-top-right-radius: 50%; border-bottom-right-radius: 50%; border-bottom-left-radius: 50%;">
                        </div>
                        <div style="margin-left: 5px;font-size: 17px;"><span></span></div>
                    </div>
                    <div style="padding-right: 10px;color: rgb(153, 153, 153); letter-spacing: 0.8px;">
                        <span> <%=name%></span></div>
                </div>
            </div>
            <div style="height: 60%;margin-top: 10px;padding-left: 20px;padding-right: 20px">
                <span style="align-content: center;font-size: larger;border: aqua;" disabled><%=content%></span>
            </div>

            <div style="height: 20%;margin-top: 10px;">
                <div style="display: flex; justify-content: space-between; align-items: center; border-top-width: 0.03em; border-top-style: solid; border-top-color: rgb(203, 202, 206); padding: 4px 0px 5px; font-size: 25px; color: rgb(153, 153, 153);">

                    <div style="float: left;padding-left: 5px"
                         onclick="act('<%=myemail%>','oppose',<%=rs_info.getString("id")%>)"
                         id=<%="oppose" + rs_info.getString("id")%>>
                        <svg class="icon" width="1.5em" height="1.5em" viewBox="0 0 1024 1024" version="1.1"
                             xmlns="http://www.w3.org/2000/svg">
                            <path d="M496 853.12a84.32 84.32 0 0 0 125.6-76 400 400 0 0 0-20-156 5.12 5.12 0 0 1 4.8-6.72h157.28a98.24 98.24 0 0 0 72.64-33.44 104.8 104.8 0 0 0 14.56-91.84C832 405.12 797.28 288 787.04 254.24v-1.6A85.12 85.12 0 0 0 704 186.88H182.88v396.16h118.88c128.96 0 150.08 176 152 196.96A84.32 84.32 0 0 0 496 853.12zM308.16 525.6a5.12 5.12 0 0 1-5.12 5.12H240a5.12 5.12 0 0 1-5.12-5.12V244.16a5.12 5.12 0 0 1 5.12-5.12h62.56a5.12 5.12 0 0 1 5.12 5.12z m55.36 16a5.12 5.12 0 0 1-3.36-4.8V244.16a5.12 5.12 0 0 1 5.12-5.12h337.6A33.44 33.44 0 0 1 736 266.08l1.44 4.96c28.48 94.56 50.88 176 62.88 228.64a60.64 60.64 0 0 1-3.68 48l-0.96 1.28a48 48 0 0 1-32 13.6H548.48a26.08 26.08 0 0 0-16 46.88c37.92 29.28 39.84 132.8 37.44 165.92a34.08 34.08 0 0 1-32 37.28 33.28 33.28 0 0 1-32-34.24c-5.44-70.24-41.92-198.24-142.4-236.32z"
                                  fill=<%=opposecolor%> id=<%="opposeImg" + rs_info.getString("id")%> >

                            </path>
                        </svg>
                        <span id=<%="opposeNum" + rs_info.getString("id")%>> <%=oppose%> </span>
                    </div>

                    <div style="float: right;padding-right: 5px"
                         onclick="act('<%=myemail%>','support',<%=rs_info.getString("id")%>)"
                         id=<%="support" + rs_info.getString("id")%>>
                        <span id=<%="supportNum" + rs_info.getString("id")%>><%=support%></span>
                        <svg class="icon" width="1.5em" height="1.5em" viewBox="0 0 1024 1024" version="1.1"
                             xmlns="http://www.w3.org/2000/svg">
                            <path d="M436.8 236.48c-2.08 20.8-23.04 196.96-152 196.96h-118.88v396.16h520.32a85.12 85.12 0 0 0 83.2-65.76v-1.6c10.4-33.92 45.44-151.04 64-234.4a104.8 104.8 0 0 0-14.56-91.84 98.24 98.24 0 0 0-72.64-33.44h-156.16a5.12 5.12 0 0 1-4.8-6.72A400 400 0 0 0 605.28 240a84.32 84.32 0 1 0-168.48-2.88z m-145.6 535.68a5.12 5.12 0 0 1-5.12 5.12H224a5.12 5.12 0 0 1-5.12-5.12V490.72a5.12 5.12 0 0 1 5.12-5.12h62.56a5.12 5.12 0 0 1 5.12 5.12z m197.76-533.6a33.28 33.28 0 0 1 32-34.24 34.08 34.08 0 0 1 32 37.28c2.4 33.12 0 136.64-37.44 165.92a26.08 26.08 0 0 0 16 46.88h216a48 48 0 0 1 32 13.6l0.96 1.28a60.64 60.64 0 0 1 3.68 48c-12 52.64-34.4 134.08-62.88 228.64l-1.44 4.96a33.44 33.44 0 0 1-32.96 27.04H348.32a5.12 5.12 0 0 1-5.12-5.12V479.04a5.12 5.12 0 0 1 3.36-4.8c101.44-38.08 136.96-166.08 142.4-235.68z"
                                  fill=<%=supportcolor%> id=<%="supportImg" + rs_info.getString("id")%> ></path>
                        </svg>
                    </div>
                </div>
            </div>
        </div>
        <br>

        <%

                    rs_info.next();
                    //颜色恢复
                    supportcolor = "#000";
                    opposecolor = "#000";

                }
//                //更新已经显示的消息数目
//                infoShowNum += showNum;
//
//                if (infoShowNum>totalNum){
//                    infoShowNum = totalNum;
//                }

            } catch (Exception e) {
                System.out.println("数据库出错了。。。" + e.getMessage());
            }
        %>
        <div onclick="alert('没有啦，没有啦  ~  ~ ~')"
             style="display: flex; justify-content: center; color: rgba(0, 0, 0, 0.701961); margin-bottom: 36px; padding: 15px; border-bottom-width: 12px; border-bottom-style: solid; border-bottom-color: white;">
            <div style="color: rgb(66, 185, 131); font-size: 17px;"><!-- react-text: 2191 -->查看更多<!-- /react-text -->
                <svg fill="currentColor" preserveAspectRatio="xMidYMid meet" height="1em" width="1em"
                     viewBox="0 0 40 40"
                     style="vertical-align: middle; font-size: 24px; margin-left: 2px; margin-top: -6px;">
                    <g>
                        <path d="m31 16.4q0 0.3-0.2 0.5l-10.4 10.4q-0.3 0.3-0.5 0.3t-0.6-0.3l-10.4-10.4q-0.2-0.2-0.2-0.5t0.2-0.5l1.2-1.1q0.2-0.2 0.5-0.2t0.5 0.2l8.8 8.8 8.7-8.8q0.3-0.2 0.5-0.2t0.6 0.2l1.1 1.1q0.2 0.2 0.2 0.5z"></path>
                    </g>
                </svg>
            </div>
            <div><!-- react-text: 488 --> <!-- /react-text --></div>
        </div>

        <div style="position: fixed; width: 100%; display: flex; flex: 0 1 50px; left: 0px; bottom: 0px; align-items: center; text-align: center; border-top-width: 0.05em; border-top-style: solid; border-top-color: rgb(203, 202, 206); box-shadow: rgba(255, 255, 255, 0.0980392) 0.5px 0.5px 0.5px 0.5px; background-color: rgb(255, 255, 255); padding: 9px 0px;">
            <div style="flex: 1 1 0%; display: flex; align-items: center; justify-content: center; text-decoration: none;">
                <div style="position: relative; display: inline;">
                    <svg onclick="window.location='home_menu.html'" fill="currentColor"
                         preserveAspectRatio="xMidYMid meet" height="1em" width="1em" viewBox="0 0 40 40"
                         style="vertical-align: middle; color: rgb(170, 170, 170); font-size: 32px;">
                        <g>
                            <path d="m20 5s-10.3 8.9-16.1 13.7c-0.3 0.3-0.6 0.8-0.6 1.3 0 0.9 0.8 1.7 1.7 1.7h3.3v11.6c0 1 0.8 1.7 1.7 1.7h5c0.9 0 1.7-0.7 1.7-1.7v-6.6h6.6v6.6c0 1 0.8 1.7 1.7 1.7h5c0.9 0 1.7-0.7 1.7-1.7v-11.6h3.3c0.9 0 1.7-0.8 1.7-1.7 0-0.5-0.3-1-0.7-1.3-5.7-4.8-16-13.7-16-13.7z"></path>
                        </g>
                    </svg>
                </div>
            </div>
            <div style="flex: 1 1 0%; display: flex; align-items: center; justify-content: center; text-decoration: none;">
                <div style="position: relative; display: inline;">
                    <svg onclick="goTotucao('<%=myemail%>')" fill="currentColor" preserveAspectRatio="xMidYMid meet"
                         height="1em" width="1em" viewBox="0 0 40 40"
                         style="vertical-align: middle; color: rgb(170, 170, 170); font-size: 32px;">
                        <g>
                            <path d="m28.4 21.6v-3.2h-6.8v-6.8h-3.2v6.8h-6.8v3.2h6.8v6.8h3.2v-6.8h6.8z m-8.4-18.2c9.2 0 16.6 7.4 16.6 16.6s-7.4 16.6-16.6 16.6-16.6-7.4-16.6-16.6 7.4-16.6 16.6-16.6z"></path>
                        </g>
                    </svg>
                </div>
            </div>
            <div style="flex: 1 1 0%; display: flex; align-items: center; justify-content: center; text-decoration: none;">
                <div style="position: relative; display: inline;">
                    <a href="myself.html">
                        <svg fill="currentColor" preserveAspectRatio="xMidYMid meet" height="1em" width="1em"
                         viewBox="0 0 40 40"
                         style="vertical-align: middle; color: rgb(170, 170, 170); font-size: 32px;">
                        <g>
                            <path d="m20 32c4.1 0 7.8-2.2 10-5.4-0.1-3.2-6.7-5.1-10-5.1-3.4 0-9.9 1.9-10 5.1 2.2 3.2 5.9 5.4 10 5.4z m0-23.6c-2.7 0-5 2.2-5 5s2.3 5 5 5 5-2.3 5-5-2.3-5-5-5z m0-5c9.2 0 16.6 7.4 16.6 16.6s-7.4 16.6-16.6 16.6-16.6-7.4-16.6-16.6 7.4-16.6 16.6-16.6z"></path>
                        </g>
                    </svg>
                    </a>
                </div>
            </div>

        </div>
    </fieldset>
</form>

<script src="js/jquery-1.9.1.min.js" type="text/javascript"></script>
<script src="js/jquery-1.11.3.min.js"></script>
<script src="js/jquery.easing.min.js" type="text/javascript"></script>
<script src="js/jQuery.time.js" type="text/javascript"></script>
<br><br><br><br><br><br><br><br><br><br>
<br><br><br><br><br><br><br><br><br><br>

<script>

    function goTotucao(myemail) {
        if (myemail === "null") {
            alert("请先登录！");
            window.location = "/login/login.html";
        } else {
            window.location = "/home/tucao.html";
        }
    }

    function act(myemail, supportOrOppose, infoId) {

        if (myemail === "null") {
            alert("请先登录！");
            window.location = "/login/login.html"
        }

        var btn = document.getElementById(supportOrOppose + infoId);
        var img = document.getElementById(supportOrOppose + "Img" + infoId);
        var num = document.getElementById(supportOrOppose + "Num" + infoId);

        var another_img,another_num;

        if (supportOrOppose === "support"){
            another_img = document.getElementById("oppose" + "Img" + infoId);
            another_num = document.getElementById("oppose" + "Num" + infoId);
        } else {
            another_img = document.getElementById("support" + "Img" + infoId)
            another_num = document.getElementById("support" + "Num" + infoId);
        }

        btn.onclick = function () {
            if (img.getAttribute("fill") === "#000" && another_img.getAttribute("fill") === "#000") {
                inc(img, another_img,num, another_num, myemail, "inc", supportOrOppose, infoId,0)
            }else if (img.getAttribute("fill") === "#000" && another_img.getAttribute("fill") === "#F00"){
                inc(img, another_img, num, another_num, myemail, "inc", supportOrOppose, infoId,1)
            }else if (img.getAttribute("fill") === "#F00") {
                dec(img,num,myemail,"dec",supportOrOppose,infoId)
            }
        }
    }

    function inc(img, another_img, num, another_num, myemail, type, supportOrOppose, infoId, del) {
        another_img.setAttribute("fill","#000");
        if (del === 1) {
            if (another_num.innerText <= 1) {
                another_num.innerText = "";
            } else {
                another_num.innerText = parseInt(another_num.innerText) - 1;
            }
        }
        img.setAttribute("fill", "#F00");
        if (num.innerText < 1) {
            num.innerText = 1;
        } else {
            num.innerText = parseInt(num.innerText) + 1;
        }
        test(myemail, type, supportOrOppose, infoId, del);
    }

    function dec(img, num, myemail, type, supportOrOppose, infoId) {
        img.setAttribute("fill", "#000");
        num.innerText = parseInt(num.innerText) - 1;
        if (num.innerText < 1){
            num.innerText = "";
        }
        test(myemail, type, supportOrOppose, infoId, 0);
    }

    function test(myemail, type, supportOrOppose, infoId, del) {
        $.ajax(
            {
                url: "test.jsp",
                type: "POST",
                data: {type: type, supportOrOppose: supportOrOppose, infoId: infoId, myemail: myemail,del:del},
                // success: function () {
                //     alert("success");
                // }
            }
        );
    }

</script>
</body>
</html>


