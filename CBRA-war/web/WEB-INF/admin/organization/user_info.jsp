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
                    "user.username": {required: true},
                    "user.userName": {required: true},
                    "user.password": {required: true},
                    "user.roleId": {required: true}
                };
                var messages = {
                    "user.username": {required: "登录用户名必须填写！"},
                    "user.userName": {required: "中文姓名必须填写！"},
                    "user.password": {required: "登录密码必须填写！"},
                    "user.roleId": {required: "角色必须选择！"}
                };
                //初始化验证框架
                FormSave("form1", rules, messages);
                $("#form1").attr("target", "iframe1");
                $("#form1").attr("action", "saveOrUpdateUserAction.action");
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
                window.location.href = "./userAction!showUserList.action?deptId=" + $("#deptId").val();
            });
        }
        /**
         * 初始化页面
         */
        $.fn.initpage = function () {
            $("#txt_username").focus();
        }
    </script>
    <body>
        <div class="formbody">
            <div class="formtitle"><span>基本信息</span></div>
            <form id="form1" name="form1" method="post">
                <input type="hidden" name="id" value="${id}" />
                <ul class="forminfo">
                    <li><label>帐号<b>*</b></label><s:textfield id="txt_username" name="user.username" cssClass="dfinput" cssStyle="width: 350px;" maxlength="25"></s:textfield><i>用户名不能超过20个字符，必填项</i></li>
                    <li><label>密码<s:if test='null==user.id||user.id == ""'>
                                <b>*</b>
                            </s:if></label>
                        <s:textfield id="txt_password" name="user.password" cssClass="dfinput" 
                                     value="" cssStyle="width: 350px;" maxlength="16"></s:textfield><i>如果密码为空，则不修改原密码</i>
                        <a  href='#' onclick='javascript:$("#txt_password").val("<s:property value="defaultPassword"/>");'><font color='red'>[默认密码:111111]</font></a>
                    </li>
                    <li><label>姓名<b>*</b></label><s:textfield name="user.userName" cssClass="dfinput" cssStyle="width: 350px;" maxlength="10"></s:textfield><i>中文姓名不能超过10个汉字，必填项</i></li>
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
