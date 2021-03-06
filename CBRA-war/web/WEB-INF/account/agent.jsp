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
                        <jsp:include page="/WEB-INF/account/z_left.jsp"><jsp:param name="page" value="4" /></jsp:include>
                        </td>
                        <td valign="top" class="fr-c-1">
                            <div class="tit-cz"><fmt:message key="GLOBAL_设置登录代表" bundle="${bundle}"/></div>
                            <div class="noticeMessage">
                                <div id="successMessage" class="successMessage"><c:if test="${not empty postResult.singleSuccessMsg}">${postResult.singleSuccessMsg}</c:if></div>
                            <div id="wrongMessage" class="wrongMessage"><c:if test="${not empty postResult.singleErrorMsg}">${postResult.singleErrorMsg}</c:if></div>
                            </div>
                            <div class="xiayy"><fmt:message key="GLOBAL_代理人" bundle="${bundle}"/>1</div>
                            <form id="form_agent_1" action="/account/agent" method="post">
                                <input type="hidden" name="a" value="set_agent" />
                                <input type="hidden" name="id" value="${id1}" />
                            <table width="760" border="0" cellspacing="0" cellpadding="0" style=" margin:20px auto;">
                                <tr>
                                    <td width="120" height="40"><fmt:message key="GLOBAL_手机" bundle="${bundle}"/></td>
                                    <td><input id="account1" type="text" name="account" value="${account1}" class="mmmmm"></td>
                                </tr>
                                <tr>
                                    <td width="120" height="40"><fmt:message key="GLOBAL_代表登录密码" bundle="${bundle}"/></td>
                                    <td><input id="passwd1" type="password" name="passwd" class="mmmmm"></td>
                                </tr>
                                <tr>
                                    <td width="120" height="40"><fmt:message key="GLOBAL_确认代表登录密码" bundle="${bundle}"/></td>
                                    <td><input id="repasswd1" type="password" name="repasswd" class="mmmmm"></td>
                                </tr>
                            </table>
                        </form>
                        <div class="xiayy"><input id="submitFormButton1" type="button" class="mmmmm-an" value="<fmt:message key="GLOBAL_提交" bundle="${bundle}"/>"></div>
                        <div class="xiayy"><fmt:message key="GLOBAL_代理人" bundle="${bundle}"/>2</div>
                        <form id="form_agent_2" action="/account/agent" method="post">
                            <input type="hidden" name="a" value="set_agent" />
                            <input type="hidden" name="id" value="${id2}" />
                            <table width="760" border="0" cellspacing="0" cellpadding="0" style=" margin:20px auto;">
                                <tr>
                                    <td width="120" height="40"><fmt:message key="GLOBAL_手机" bundle="${bundle}"/></td>
                                    <td><input id="account2" type="text" name="account" value="${account2}" class="mmmmm"></td>
                                </tr>
                                <tr>
                                    <td width="120" height="40"><fmt:message key="GLOBAL_代表登录密码" bundle="${bundle}"/></td>
                                    <td><input id="passwd2" type="password" name="passwd" class="mmmmm"></td>
                                </tr>
                                <tr>
                                    <td width="120" height="40"><fmt:message key="GLOBAL_确认代表登录密码" bundle="${bundle}"/></td>
                                    <td><input id="repasswd2" type="password" name="repasswd" class="mmmmm"></td>
                                </tr>
                            </table>
                        </form>
                        <div class="xiayy"><input id="submitFormButton2" type="button" class="mmmmm-an" value="<fmt:message key="GLOBAL_提交" bundle="${bundle}"/>"></div>
                    </td>
                </tr>
            </table>
            <div style="clear:both;"></div>
        </div>
        <!-- 主体 end -->
        <jsp:include page="/WEB-INF/public/z_end.jsp"/>
        <script type="text/javascript">
            $(document).ready(function () {
                $("#submitFormButton2").click(function () {
                    $("#successMessage").html("");
                    $("#wrongMessage").html("");
                    if (CBRAValid.checkFormValueNull($("#account2"))) {
                        CBRAMessage.showWrongMessageAndBorderEle($("#wrongMessage"), "<fmt:message key="GLOBAL_请输入账户" bundle="${bundle}"/>", $("#account2"));
                        return;
                    }
                    if (CBRAValid.checkFormValueNull($("#passwd2"))) {
                        CBRAMessage.showWrongMessageAndBorderEle($("#wrongMessage"), "<fmt:message key="GLOBAL_请输入密码" bundle="${bundle}"/>", $("#passwd2"));
                        return;
                    }
                    if ($("#passwd2").val().length < 6) {
                        CBRAMessage.showWrongMessageAndBorderEle($("#wrongMessage"), "<fmt:message key="GLOBAL_密码至少6位" bundle="${bundle}"/>", $("#passwd2"));
                        return;
                    }
                    if ($("#passwd2").val() !== $("#repasswd2").val()) {
                        CBRAMessage.showWrongMessageAndBorderEle($("#wrongMessage"), "<fmt:message key="GLOBAL_两次密码输入不一致" bundle="${bundle}"/>", $("#repasswd2"));
                        return;
                    }
                    $("#form_agent_2").submit();
                });
                $("#submitFormButton1").click(function () {
                    $("#successMessage").html("");
                    $("#wrongMessage").html("");
                    if (CBRAValid.checkFormValueNull($("#account1"))) {
                        CBRAMessage.showWrongMessageAndBorderEle($("#wrongMessage"), "<fmt:message key="GLOBAL_请输入账户" bundle="${bundle}"/>", $("#account1"));
                        return;
                    }
                    if (CBRAValid.checkFormValueNull($("#passwd1"))) {
                        CBRAMessage.showWrongMessageAndBorderEle($("#wrongMessage"), "<fmt:message key="GLOBAL_请输入密码" bundle="${bundle}"/>", $("#passwd1"));
                        return;
                    }
                    if ($("#passwd1").val().length < 6) {
                        CBRAMessage.showWrongMessageAndBorderEle($("#wrongMessage"), "<fmt:message key="GLOBAL_密码至少6位" bundle="${bundle}"/>", $("#passwd1"));
                        return;
                    }
                    if ($("#passwd1").val() !== $("#repasswd1").val()) {
                        CBRAMessage.showWrongMessageAndBorderEle($("#wrongMessage"), "<fmt:message key="GLOBAL_两次密码输入不一致" bundle="${bundle}"/>", $("#repasswd1"));
                        return;
                    }
                    $("#form_agent_1").submit();
                });
            });
        </script>
    </body>
</html>
