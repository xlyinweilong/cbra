<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html>
    <head>
        <meta charset="utf-8">
        <jsp:include page="/WEB-INF/public/z_header.jsp"/>
    </head>
    <c:choose>
        <c:when test="${empty success}">
            <body style="background:url(/images/Reg-bac.jpg) no-repeat top center">
                <div class="xgmm">
                    <div class="tit"><fmt:message key="GLOBAL_重置密码" bundle="${bundle}"/></div>
                    <form action="/account/reset_passwd/" method="post" id="reset_passwd_form">
                        <input type="hidden" name="a" value="RESET_PASSWD" />
                        <input type="hidden" name="key" value="${key}">
                        <table width="400" border="0" cellspacing="0" cellpadding="0">
                            <div id="wrongMessage" class="wrongMessage"><c:if test="${not empty postResult.singleErrorMsg}">${postResult.singleErrorMsg}</c:if></div>
                                <tr>
                                    <td width="100" height="44" align="right"><fmt:message key="GLOBAL_新密码" bundle="${bundle}"/>：</td>
                                    <td><input id="passwd" name="passwd" type="password" class="shuru" /></td>
                                </tr>
                                <tr>
                                    <td height="44" align="right"><fmt:message key="GLOBAL_确认密码" bundle="${bundle}"/>：</td>
                                    <td><input id="repasswd" name="repasswd" type="password" class="shuru" /></td>
                                </tr>
                                <tr>
                                    <td height="44" align="right"></td>
                                    <td><input id="reset_passwd" type="button" class="rev-an" value="<fmt:message key="GLOBAL_确定" bundle="${bundle}"/>"></td>
                                </tr>
                            </table>
                        </form>
                    </div>
                    <script type="text/javascript">
                        $(document).ready(function () {
                            $("#reset_passwd").click(function () {
                                if (CBRAValid.checkFormValueNull($("#passwd"))) {
                                    CBRAMessage.showWrongMessageAndBorderEle($("#wrongMessage"), "<fmt:message key="GLOBAL_请输入密码" bundle="${bundle}"/>", $("#passwd"));
                                    return;
                                }
                                if ($("#passwd").val().length < 6) {
                                    CBRAMessage.showWrongMessageAndBorderEle($("#wrongMessage"), "<fmt:message key="GLOBAL_密码必须至少6位" bundle="${bundle}"/>", $("#passwd"));
                                    return;
                                }
                                if (CBRAValid.checkFormValueNull($("#repasswd"))) {
                                    CBRAMessage.showWrongMessageAndBorderEle($("#wrongMessage"), "<fmt:message key="GLOBAL_请输入确认密码" bundle="${bundle}"/>", $("#repasswd"));
                                    return;
                                }
                                if ($("#passwd").val() != $("#repasswd").val()) {
                                    CBRAMessage.showWrongMessageAndBorderEle($("#wrongMessage"), "<fmt:message key="GLOBAL_两次密码输入不一致" bundle="${bundle}"/>", $("#repasswd"));
                                    return;
                                }
                                $("#reset_passwd_form").submit();
                            });
                        })
                    </script> 
            </c:when>
            <c:otherwise>
                <jsp:include page="/WEB-INF/public/z_top.jsp" />
                <jsp:include page="/WEB-INF/account/z_account_banner.jsp" />
                <div class="two-loc">
                    <div class="two-loc-c"><fmt:message key="BANNER_当前位置" bundle="${bundle}"/>：<a href="/public/index"><fmt:message key="BANNER_筑誉首页" bundle="${bundle}"/></a> > 重置密码</div>
                </div>
                <!-- 主体 -->
                <div class="two-main">
                    <!-- 详细信息 -->
                    <div class="zfcg">
                        <p class="czcg"><fmt:message key="GLOBAL_密码已经重置成功" bundle="${bundle}"/></p>
                        <p class="czcg"><a href="/account/login"><fmt:message key="GLOBAL_去登录" bundle="${bundle}"/></a></p>
                    </div>
                    <div style="clear:both;"></div>
                </div>
                <!-- 主体 end -->
                <jsp:include page="/WEB-INF/public/z_end.jsp"/>
            </c:otherwise>
        </c:choose>
    </body>
</html>
