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
            $("#saveBtn").click(function () {
                var rules = {
                    "content": {required: true}
                };
                var messages = {
                    "content": {required: "回复内容必须填写！"}
                };
                //初始化验证框架
                FormSave("form1", rules, messages);
                $("#form1").attr("action", "/admin/message/message_info");
                $("#form1").submit();
            });
            $.fn.goback();
        });
        /**
         * 返回
         */
        $.fn.goback = function () {
            $("#gobackBtn").click(function () {
                window.location.href = "/admin/message/message_list";
            });
        }
    </script>
    <body>
        <div class="formbody">
            <div class="formtitle"><span>回复信息</span></div>
            <form id="form1" name="form1" method="post">
                <input type="hidden" name="a" value="MESSAGE_CREATE_OR_UPDATE" />
                <input type="hidden" name="id" value="${id}" />
                <input type="hidden" name="mid" value="${mid}" />
                <ul class="forminfo">
                    <li><label>回复内容<b>*</b></label>
                        <textarea name="content" class="dfinput"  style="width: 350px;height: 150px">${message.content}</textarea>
                    </li>
                    <li><label>信息等级<b>*</b></label>
                        <select name="languageType" class="dfinput" style="width: 354px;">
                            <c:forEach var="secretLevel" items="${secretLevelList}">
                                <option value="${secretLevel.name()}" <c:if test="${secretLevel == message.secretLevel}">selected="selected"</c:if>>
                                    ${secretLevel.mean}
                                </option>
                            </c:forEach>
                        </select>
                    </li>
                    <li><label>&nbsp;</label>
                        <input id="saveBtn" name="saveBtn" type="button" class="btn" value="保存"/>
                        <input id="gobackBtn" name="gobackBtn" type="button" class="btn" value="返回"/>
                    </li>
                </ul>
            </form>
        </div>
        <iframe name="iframe1" id="iframe1" width="1px" height="1px"></iframe>
        <script type="text/javascript">
            $(document).ready(function () {
                <c:if test="${postResult.singleSuccessMsg != null}">alert("${postResult.singleSuccessMsg}");</c:if>
                <c:if test="${postResult.singleErrorMsg != null}">alert("${postResult.singleErrorMsg}");</c:if>
            });
        </script>
    </body>
</html>
