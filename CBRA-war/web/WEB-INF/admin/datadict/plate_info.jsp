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
            //$.fn.initpage();
            $("#saveBtn").click(function () {
                var rules = {
                    "plateName": {required: true},
                    "plateEnName": {required: true}
                };
                var messages = {
                    "plateName": {required: "栏目中文名称必须填写！"},
                    "plateEnName": {required: "栏目英文名称必须填写！"}
                };
                //初始化验证框架
                FormSave("form1", rules, messages);
                $("#form1").attr("target", "iframe1");
                $("#form1").attr("action", "/admin/datadict/plate_info");
                $("#form1").submit();
            });
            //$.fn.save();
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
                window.location.href = "/admin/datadict/plate_list?id=${pid}";
            });
        }
        /**
         * 初始化页面
         */
        $.fn.initpage = function () {
            $("#txt_roleName").focus();
        }
    </script>
    <body>
        <div class="formbody">
            <div class="formtitle"><span>基本信息</span></div>
            <form id="form1" name="form1" method="post">
                <input type="hidden" name="a" value="PLATE_CREATE_OR_UPDATE" />
                <input type="hidden" name="id" value="${id}" />
                <input type="hidden" name="pid" value="${pid}" />
                <ul class="forminfo">
                    <li><label>栏目中文名称<b>*</b></label><input type="text" class="dfinput" style="width: 350px;" name="plateName" value="${plate.name}" maxlength="25" /><i>栏目名称不能超过25个汉字，必填项</i></li>
                    <li><label>栏目英文名称<b>*</b></label><input type="text" class="dfinput" style="width: 350px;" name="plateEnName" value="${plate.enName}" maxlength="200" /><i>栏目名称不能超过200个字符，必填项</i></li>
                    <li><label>栏目关键字</label>
                        <select name="plateKey" class="dfinput" style="width: 354px;">
                            <c:forEach var="plateKey" items="${plateKeyEnumList}">
                                <option value="${plateKey.name()}" <c:if test="${plateKey == plate.plateKey}">selected="selected"</c:if>>
                                    ${plateKey.name()}
                                </option>
                            </c:forEach>
                        </select></li>
                    <li><label>栏目类型</label>
                        <select name="plateType" class="dfinput" style="width: 354px;">
                            <c:forEach var="plateType" items="${plateTypeEnumList}">
                                <option value="${plateType.name()}" <c:if test="${plateType == plate.plateType}">selected="selected"</c:if>>
                                    ${plateType.name()}
                                </option>
                            </c:forEach>
                        </select></li>
                    <li><label>页面名称</label><input type="text" class="dfinput" style="width: 350px;" name="platePage" value="${plate.page}" maxlength="200" /><i></i></li>
                        <li><label>&nbsp;</label>
                            <input id="saveBtn" name="saveBtn" type="button" class="btn" value="保存"/>
                            <input id="gobackBtn" name="gobackBtn" type="button" class="btn" value="返回"/>
                        </li>
                </ul>
            </form>
        </div>
        <iframe name="iframe1" id="iframe1" width="1px" height="1px"></iframe>
    </body>
</html>
