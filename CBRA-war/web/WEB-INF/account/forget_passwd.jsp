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
                    <div class="tit"><fmt:message key="GLOBAL_忘记密码" bundle="${bundle}"/></div>
                    <form action="/account/forget_passwd" method="post" id="forget_fasswd_form">
                        <input type="hidden" name="a" value="SEND_RESET_PASSWD">
                        <table width="400" border="0" cellspacing="0" cellpadding="0">
                            <div id="wrongMessage" class="wrongMessage"><c:if test="${not empty postResult.singleErrorMsg}">${postResult.singleErrorMsg}</c:if></div>
                                <tr>
                                    <td width="100" height="44" align="right"><fmt:message key="GLOBAL_登录帐号" bundle="${bundle}"/>：</td>
                                    <td><input id="account" name="account" type="text" placeholder="<fmt:message key="GLOBAL_输入登录帐号" bundle="${bundle}"/>" class="shuru" /></td>
                                </tr>
                                <tr>
                                    <td height="44" align="right"><fmt:message key="GLOBAL_注册邮箱" bundle="${bundle}"/>：</td>
                                    <td><input id="email" name="email" type="text" class="shuru" placeholder="<fmt:message key="GLOBAL_输入注册邮箱" bundle="${bundle}"/>" /></td>
                                </tr>
                                <tr>
                                    <td height="44" align="right"></td>
                                    <td><input id="forget_fasswd" type="button" class="rev-an" value="<fmt:message key="GLOBAL_找回密码" bundle="${bundle}"/>"></td>
                                </tr>
                            </table>
                        </form>
                    </div>
                    <script type="text/javascript">
                        $(document).ready(function () {
                            $("#forget_fasswd").click(function () {
                                if (CBRAValid.checkFormValueNull($("#account"))) {
                                    CBRAMessage.showWrongMessageAndBorderEle($("#wrongMessage"), "<fmt:message key="GLOBAL_请输入会员号" bundle="${bundle}"/>", $("#account"));
                                    return;
                                }
                                if (CBRAValid.checkFormValueNull($("#email"))) {
                                    CBRAMessage.showWrongMessageAndBorderEle($("#wrongMessage"), "<fmt:message key="GLOBAL_请输入注册邮箱" bundle="${bundle}"/>", $("#email"));
                                    return;
                                }
                                $("#forget_fasswd_form").submit();
                            });
                        })
                    </script> 
            </c:when>
            <c:otherwise>
                <jsp:include page="/WEB-INF/public/z_top.jsp" />
                <div class="two-loc">
                    <div class="two-loc-c">
                        <fmt:message key="BANNER_当前位置" bundle="${bundle}"/>：<a href="/public/index"><fmt:message key="BANNER_筑誉首页" bundle="${bundle}"/></a> > <fmt:message key="GLOBAL_找回密码" bundle="${bundle}"/>
                    </div>
                </div>
                <!-- 主体 -->
                <div class="two-main">
                    <!-- 详细信息 -->
                    <div class="zfcg">
                        <p class="czcg"><fmt:message key="GLOBAL_一封邮件已经发送到您的邮箱，请注意查收" bundle="${bundle}"/></p>
                        <p class="czcg"><a href="/public/index"><fmt:message key="GLOBAL_返回首页" bundle="${bundle}"/></a></p>
                    </div>
                    <div style="clear:both;"></div>
                </div>
                <!-- 主体 end -->
                <jsp:include page="/WEB-INF/public/z_end.jsp"/>
            </c:otherwise>
        </c:choose>
    </body>
</html>
