<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
    response.addHeader("Cache-Control", "no-store,no-cache,must-revalidate");
    response.addHeader("Cache-Control", "post-check=0,pre-check=0");
    response.addHeader("Expires", "0");
    response.addHeader("Pragma", "no-cache");
    response.setCharacterEncoding("utf-8");
    String path = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>欢迎登录云端房产网信息管理平台</title>
        <link href="/background/css/style.css" rel="stylesheet" type="text/css" />
        <script src="/background/js/jquery.js"></script>
        <script src="/background/js/cloud.js"></script>
        <style type="text/css">
            .errorblock {
                color: #ff0000;
                background-color: #ffEEEE;
                border: 3px solid #ff0000;
                padding: 8px;
                margin: 16;
                width:50%;
            }
        </style>
        <script language="javascript">
            //手机号点击记数器
            var usernameClickCount = 0;
            if (self.window.location.href != top.window.location.href) {
                //如果由于权限不足显示了登录页，则浏览器地址重置为登陆页
                //top.window.location.href = "/logoutAction.action";
            }
            $(function () {
                $('.loginbox').css({'position': 'absolute', 'left': ($(window).width() - 692) / 2});
                $(window).resize(function () {
                    $('.loginbox').css({'position': 'absolute', 'left': ($(window).width() - 692) / 2});
                })
            });
            function refreshCaptcha() {
                document.getElementById("imageF").src = '/jcaptcha' + '?' + Math.floor(Math.random() * 100);
            }
        </script>
        <script type="text/javascript">
            $(document).ready(function () {
                $("#username").focus();
            });
            function logon() {
                if ($.trim($("#username").val()) == "") {
                    alert("请输入用户名！");
                    $("#username").focus();
                    return false;
                }
                if ($("#password").val() == "") {
                    alert("请输入密码！");
                    $("#password").focus();
                    return false;
                }
                form1.action = "/admin";
                form1.submit();
            }
            function mykeypress() {
                if (event.keyCode == 13) {
                    logon();
                }
            }
        </script>
    </head>

    <body style="background-color: #1c77ac; background-image: url(<%=path%>/admin/images/light.png); background-repeat: no-repeat; background-position: center top; overflow: hidden;">
        <form id="form1" name="form1" method="post">
            <input type="hidden" name="a" value="login"/>
            <div id="mainBody">
                <div id="cloud1" class="cloud"></div>
                <div id="cloud2" class="cloud"></div>
            </div>
            <div class="logintop">
                <span>欢迎登录云端房产网信息管理平台</span>
                <ul>
                    <li>
                        <a href="<%=path%>">网站首页</a>
                    </li>
                    <li>
                        <a href="#">帮助</a>
                    </li>
                    <li>
                        <a href="#">关于</a>
                    </li>
                </ul>
            </div>

            <div class="loginbody">

                <span class="systemlogo"></span>

                <div class="loginbox">

                    <ul>
                        <li>
                            <input name="username" id="username" type="text" class="loginuser" value="" onclick="JavaScript:if (usernameClickCount == 0) {
                                        this.value = '';
                                        usernameClickCount = 1;
                                    }" onkeypress="mykeypress();" />
                        </li>
                        <li>
                            <input name="password" id="password" type="password" class="loginpwd" value=""  onkeypress="mykeypress();"/>
                        </li>
                        <li>
                            <input name="loginbtn" type="button" class="loginbtn" value="登录" onclick="logon();"/>
                            <label>
                                <input name="resetbtn" type="button" class="loginbtn" value="重填" onclick="$('#username').val('');
                                        $('#password').val('');"/>
                            </label>
                        </li>
                    </ul>
                </div>
            </div>

            <div class="loginbm">
                版权所有 2014 云端房产网 吉ICP备14002652号-1 技术支持 长春博岸信息科技有限责任公司
            </div>
        </form>
    </body>
    <iframe width="1px" height="1px" id="ifram1" name="iframe1"></iframe>
</html>
