<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%-- 
    Document   : login
    Created on : Nov 13, 2012, 5:14:08 PM
    Author     : Yin.Weilong
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script type="text/javascript" src="/scripts/yoopay.js"></script>
        <script type="text/javascript" src="/scripts/jquery-1.8.2.min.js"></script>
        <script type="text/javascript" src="/scripts/jquery-ui-1.9.1.custom.min.js"></script>
        <link href="/css/style_checkin.css" rel="stylesheet" type="text/css" />
        <title>签到系统</title>
    </head>
    <body>
        <div class="head">
            <div class="head_inner ">
                <div class="logo" style="cursor: pointer" onclick="document.location.href='/account/overview'"></div>
                <div style="float: left; font-size: 18px; margin-top:48px;">做活动，更轻松</div>
                <div class="HeaderRight" style="color:#21a1dc; font-size:32px; margin-top:35px; font-weight: 100; letter-spacing: 5px">友付签到系统</div>
            </div>
        </div>
        <div class="content">
            <div>  
                <div class="EventName"> ${fundCollection.title} </div>
                <div class="EventTime"><c:if test="${not empty fundCollection.eventBeginDate}">时间：<fmt:formatDate value="${fundCollection.eventBeginDate}" type="date" pattern="yyyy.MM.dd "/></c:if>&nbsp;&nbsp;<c:if test="${not empty fundCollection.eventLocation}">地点：${fundCollection.eventLocation}</c:if></div>
                <div>

                    <div class="login">
                        <c:if test="${not empty postResult}">
                            <div class="wrongMesseg">${postResult.singleErrorMsg}</div>
                        </c:if>
                        <div class="loginBg">   
                            <form id="checkin_login_form" action="/checkin/login/${fundCollection.webId}" method="post" onsubmit="verifyPasswd()">
                                <input type="hidden" name="a" value="LOGIN" />
                                <input type="hidden" name="webId" value="${fundCollection.webId}" />
                                <input type="password" value="" name="passwd" id="checkin_passwd"class="loginInput" /><input type="submit" value="登录" class="loginButton"/>
                            </form></div></div>
                </div>
            </div>

            <script type="text/javascript">
                function verifyPasswd(){
                    var passwd = $.trim($('#checkin_passwd').val());
                    if(passwd == ""){
                        alert("密码不能为空");
                        return false;
                    }
                }
            </script></div>
    </body>
</html>
