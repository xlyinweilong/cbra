<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
        <title>无标题文档</title>
        <link rel="stylesheet" href="<%=path%>/background/css/style.css" type="text/css" />
        <link rel="stylesheet" href="<%=path%>/background/js/validate/tip-yellowsimple/tip-yellowsimple.css" type="text/css" />
        <link rel="stylesheet" href="<%=path%>/background/js/validate/tip-green/tip-green.css" type="text/css" />
        <script type="text/javascript" src="<%=path%>/background/js/jquery.js"></script>
        <script type="text/javascript" src="<%=path%>/background/js/validate/jquery.poshytip.js"></script>
        <script type="text/javascript" src="<%=path%>/background/js/validate/jquery.validate.js"></script>
        <script type="text/javascript" src="<%=path%>/background/js/common/common.js"></script>
    </head>
    <script type="text/javascript">
        $(function () {
            $.fn.initpage();
            $("#saveBtn").click(function () {
                var rules = {
                    "userName": {required: true},
                    "oldPasswd": {required: true},
                    "newPasswd": {required: true},
                    "renewPasswd": {required: true}
                };
                var messages = {
                    "userName": {required: "姓名必须填写！"},
                    "oldPasswd": {required: "原密码必须填写！"},
                    "newPasswd": {required: "新密码必须填写！"},
                    "renewPasswd": {required: "确认密码必须填写！"}
                };
                //初始化验证框架
                FormSave("form1", rules, messages);
                $("#form1").attr("target", "iframe1");
                $("#form1").attr("action", "/admin/organization/user_info");
                $("#form1").submit();
            });
            $.fn.goback();
        });
        /**
         * 保存
         */
        $.fn.save = function () {

        }
        /**
         * 返回
         */
        $.fn.goback = function () {
            $("#gobackBtn").click(function () {
                window.location.href = "/admin/right";
            });
        }
        /**
         * 初始化页面
         */
        $.fn.initpage = function () {
        }
    </script>
    <body>
        <div class="formbody">
            <div class="formtitle"><span>基本信息</span></div>
            <form id="form1" name="form1" method="post">
                <input type="hidden" name="a" value="REPASSWD" />
                <ul class="forminfo">
                    <li><label>姓名<b>*</b></label><input type="text" class="dfinput" style="width: 350px;" name="userName" value="${admin.name}" maxlength="50" /><i>必填项</i></li>
                    <li><label>原密码<b>*</b></label><input type="password" class="dfinput" style="width: 350px;" name="oldPasswd" value="" maxlength="50" /><i>必填项</i></li>
                    <li><label>新密码<b>*</b></label><input type="password" class="dfinput" style="width: 350px;" name="newPasswd" value="" maxlength="50" /><i>必填项</i></li>
                    <li><label>确认密码<b>*</b></label><input type="password" class="dfinput" style="width: 350px;" name="renewPasswd" value="" maxlength="50" /><i>必填项</i></li>
                    <li><label>&nbsp;</label>
                        <input id="saveBtn" name="saveBtn" type="button" class="btn" value="保存"/>
                        <input id="gobackBtn" name="gobackBtn" type="button" class="btn" value="返回"/>
                    </li>
                </ul>
            </form>
            <iframe name="iframe1" id="iframe1" width="1px" height="1px"></iframe>
        </div>
    </body>
</html>
