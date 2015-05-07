<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html>
    <head>
        <jsp:include page="/WEB-INF/public/z_header.jsp"/>
    </head>
    <body>
        <jsp:include page="/WEB-INF/public/z_top.jsp" />
        <jsp:include page="/WEB-INF/account/z_account_banner.jsp" />
        <!-- 主体 -->
        <div class="mc-main">
            <table width="1000" border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td valign="top" class="fl-nav">
                        <jsp:include page="/WEB-INF/account/z_left.jsp"><jsp:param name="page" value="5" /></jsp:include>
                        </td>
                        <td valign="top" class="fr-c-1">
                            <div class="tit-cz">
                                <fmt:message key="GLOBAL_修改密码" bundle="${bundle}"/><c:if test="${sessionScope.user.type == 'COMPANY'}">(<fmt:message key="GLOBAL_此处修改的密码为营业执照注册号主账户密码" bundle="${bundle}"/>)</c:if>
                            </div>
                            <div class="noticeMessage">
                                <div id="successMessage" class="successMessage"><c:if test="${not empty postResult.singleSuccessMsg}">${postResult.singleSuccessMsg}</c:if></div>
                                <div id="wrongMessage" class="wrongMessage"><c:if test="${not empty postResult.singleErrorMsg}">${postResult.singleErrorMsg}</c:if></div>
                            </div>
                            <form id="modify_passwd_form" action="/account/modify_passwd" method="post">
                                <input type="hidden" name="a" value="MODIFY_PASSWD" />
                                <table width="760" border="0" cellspacing="0" cellpadding="0" style=" margin:20px auto;">
                                    <tr>
                                        <td width="120" height="40"><fmt:message key="GLOBAL_原密码" bundle="${bundle}"/></td>
                                        <td><input id="oldpasswd" name="oldpasswd" type="password" class="mmmmm"/></td>
                                    </tr>
                                    <tr>
                                        <td width="120" height="40"><fmt:message key="GLOBAL_新密码" bundle="${bundle}"/></td>
                                        <td><input id="newpasswd" name="newpasswd" type="password" class="mmmmm"/></td>
                                    </tr>
                                    <tr>
                                        <td width="120" height="40"><fmt:message key="GLOBAL_确认密码" bundle="${bundle}"/></td>
                                        <td><input id="repasswd" name="repasswd" type="password" class="mmmmm"/></td>
                                    </tr>
                                </table>
                            </form>
                            <div class="xiayy">
                                <input type="button" id="modify_passwd_button" class="mmmmm-an"  style="margin-left: 50px;" value="<fmt:message key="GLOBAL_提交" bundle="${bundle}"/>">
                            </div>
                        </td>
                    </tr>
                </table>
                <div style="clear:both;"></div>
            </div>
            <!-- 主体 end -->
        <jsp:include page="/WEB-INF/public/z_end.jsp"/>
        <script type="text/javascript">
            $(document).ready(function () {
                $("#modify_passwd_button").click(function () {
                    if (CBRAValid.checkFormValueNull($("#oldpasswd"))) {
                        CBRAMessage.showWrongMessageAndBorderEle($("#wrongMessage"), "<fmt:message key="GLOBAL_请输入原密码" bundle="${bundle}"/>", $("#oldpasswd"));
                        return;
                    }
                    if (CBRAValid.checkFormValueNull($("#newpasswd"))) {
                        CBRAMessage.showWrongMessageAndBorderEle($("#wrongMessage"), "<fmt:message key="GLOBAL_请输入新密码" bundle="${bundle}"/>", $("#newpasswd"));
                        return;
                    }
                    if ($("#oldpasswd").val().length < 6) {
                        CBRAMessage.showWrongMessageAndBorderEle($("#wrongMessage"), "<fmt:message key="GLOBAL_新密码长度必须大于6位" bundle="${bundle}"/>", $("#newpasswd"));
                        return;
                    }
                    if (CBRAValid.checkFormValueNull($("#repasswd"))) {
                        CBRAMessage.showWrongMessageAndBorderEle($("#wrongMessage"), "<fmt:message key="GLOBAL_请输入确认密码" bundle="${bundle}"/>", $("#repasswd"));
                        return;
                    }
                    if ($("#repasswd").val() !== $("#newpasswd").val()) {
                        CBRAMessage.showWrongMessageAndBorderEle($("#wrongMessage"), "<fmt:message key="GLOBAL_两次密码输入不一致" bundle="${bundle}"/>", $("#repasswd"));
                        return;
                    }
                    //submit
                    $("#modify_passwd_form").submit();
                });
            });
        </script>
    </body>
</html>