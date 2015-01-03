<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : login
    Created on : May 17, 2011, 5:23:59 PM
    Author     : chenjianlin
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link href="/css/style_admin.css" rel="stylesheet" type="text/css" />
    </head>
    <body>

        <div id="admin">
            <div class="login">
                <h1>Support 登录 Welcome</h1>
                <span style="color: red">${postResult.singleErrorMsg}</span>
                <form action="/support/login" method="POST">
                    <input type="hidden" name="a" value="login"/>
                    账号：<input type="text" name="name" class="loginInput"/><br/>
                    密码：<input type="password" name="passwd" class="loginInput"/><br/>
                    <input type="submit" value="登录" class="InputButton"/>
                </form>
            </div>
        </div>

    </body>
</html>
