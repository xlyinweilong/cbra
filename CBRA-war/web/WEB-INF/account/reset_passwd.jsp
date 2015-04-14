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
                    <div class="tit">重置密码</div>
                    <form action="/account/reset_passwd/" method="post" id="reset_passwd_form">
                        <input type="hidden" name="a" value="RESET_PASSWD" />
                        <input type="hidden" name="key" value="${key}">
                        <table width="400" border="0" cellspacing="0" cellpadding="0">
                            <div id="wrongMessage" class="wrongMessage"><c:if test="${not empty postResult.singleErrorMsg}">${postResult.singleErrorMsg}</c:if></div>
                                <tr>
                                    <td width="100" height="44" align="right">新密码：</td>
                                    <td><input id="passwd" name="passwd" type="password" class="shuru" /></td>
                                </tr>
                                <tr>
                                    <td height="44" align="right">重复密码：</td>
                                    <td><input id="repasswd" name="repasswd" type="password" class="shuru" /></td>
                                </tr>
                                <tr>
                                    <td height="44" align="right"></td>
                                    <td><input id="reset_passwd" type="button" class="rev-an" value="确定"></td>
                                </tr>
                            </table>
                        </form>
                    </div>
                    <script type="text/javascript">
                        $(document).ready(function () {
                            $("#reset_passwd").click(function () {
                                if (CBRAValid.checkFormValueNull($("#passwd"))) {
                                    CBRAMessage.showWrongMessageAndBorderEle($("#wrongMessage"), "请输入密码", $("#passwd"));
                                    return;
                                }
                                if ($("#passwd").val().length < 6) {
                                    CBRAMessage.showWrongMessageAndBorderEle($("#wrongMessage"), "密码必须至少6位", $("#passwd"));
                                    return;
                                }
                                if (CBRAValid.checkFormValueNull($("#repasswd"))) {
                                    CBRAMessage.showWrongMessageAndBorderEle($("#wrongMessage"), "请输入重复密码", $("#repasswd"));
                                    return;
                                }
                                if ($("#passwd").val() != $("#repasswd").val()) {
                                    CBRAMessage.showWrongMessageAndBorderEle($("#wrongMessage"), "两次密码不一致", $("#repasswd"));
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
                        <p class="czcg">密码已经重置成功！</p>
                        <p class="czcg"><a href="/account/login">去登录</a></p>
                    </div>
                    <div style="clear:both;"></div>
                </div>
                <!-- 主体 end -->
                <jsp:include page="/WEB-INF/public/z_end.jsp"/>
            </c:otherwise>
        </c:choose>
    </body>
</html>
