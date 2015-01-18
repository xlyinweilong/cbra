<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
        <script type="text/javascript" src="<%=path%>/background/js/My97DatePicker/WdatePicker.js"></script>
        <script type="text/javascript" src="<%=path%>/background/js/common/common.js"></script>
    </head>
    <script type="text/javascript">
        $(function () {
            $("#saveBtn").click(function () {
                $("#form1").attr("target", "iframe1");
                $("#form1").attr("action", "/admin/plate/plate_auth_info");
                $("#form1").submit();
            });
        });
    </script>
    <body>
        <div class="formbody">
            <div class="formtitle"><span>${plate.name}</span></div>
            <form id="form1" name="form1" method="post">
                <input type="hidden" name="a" value="PLATE_AUTH_CREATE_OR_UPDATE" />
                <input type="hidden" name="id" value="${plate.id}" />
                <ul class="forminfo">
                    <li><label>游客权力<b>*</b></label>
                        <select name="touristAuth" class="dfinput" style="width: 354px;">
                            <c:forEach var="auth" items="${plateAuthEnumList}">
                                <option value="${languageType.name()}" <c:if test="${auth == plate.touristAuth}">selected="selected"</c:if>>
                                    ${auth.authMean}
                                </option>
                            </c:forEach>
                        </select>
                    </li>
                    <li><label>个人会员权力<b>*</b></label>
                        <select name="userAuth" class="dfinput" style="width: 354px;">
                            <c:forEach var="auth" items="${plateAuthEnumList}">
                                <option value="${languageType.name()}" <c:if test="${auth == plate.userAuth}">selected="selected"</c:if>>
                                    ${auth.authMean}
                                </option>
                            </c:forEach>
                        </select>
                    </li>
                    <li><label>企业会员权力<b>*</b></label>
                        <select name="companyAuth" class="dfinput" style="width: 354px;">
                            <c:forEach var="auth" items="${plateAuthEnumList}">
                                <option value="${auth.name()}" <c:if test="${auth == plate.companyAuth}">selected="selected"</c:if>>
                                    ${auth.authMean}
                                </option>
                            </c:forEach>
                        </select>
                    </li>
                    <li><label>&nbsp;</label>
                        <input id="saveBtn" name="saveBtn" type="button" class="btn" value="保存"/>
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
