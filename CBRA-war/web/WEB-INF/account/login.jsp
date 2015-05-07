<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html>
    <head>
        <jsp:include page="/WEB-INF/public/z_header.jsp"/>
    </head>
    <body style="background:url(/images/Reg-bac.jpg) no-repeat top center">
        <div class="reg">
            <div class="logo"><a href="/public/index"><img src="/images/logo-r.png"></a></div>
            <form action="/account/login" method="post" id="form_login">
                <input type="hidden" name="a" value="LOGIN" />
                <input type="hidden" name="p" value="${p}" />
                <div class="bac">
                    <div class="bac-k">
                        <div class="xianz">
                            <a href="/account/login" <c:if test="${p != 'hy'}">id="xianzzz"</c:if>><fmt:message key="GLOBAL_个人会员" bundle="${bundle}"/></a>
                            <a href="/account/login?p=hy" <c:if test="${p == 'hy'}">id="xianzzz"</c:if>><fmt:message key="GLOBAL_企业会员" bundle="${bundle}"/></a>
                        </div>
                        <div class="denglu">
                            <div id="login_msg_1" class="wrongMessage"><c:if test="${not empty postResult.singleErrorMsg}">${postResult.singleErrorMsg}</c:if></div>
                        <input type="text" id="login_account" name="account" value="${account}" class="shuk"
                             <c:if test="${p != 'hy'}">  placeholder="<fmt:message key="GLOBAL_输入注册手机号" bundle="${bundle}"/>" </c:if>
                             <c:if test="${p == 'hy'}">  placeholder="<fmt:message key="GLOBAL_营业执照注册号或企业代表手机号" bundle="${bundle}"/>" </c:if>
                               onkeypress="mykeypress(event);" />
                            <div id="login_msg_2" class="wrongMessage"></div><br/>
                            <input type="password" id="login_passwd" name="passwd" class="shuk-1" placeholder="<fmt:message key="GLOBAL_输入密码" bundle="${bundle}"/>" onkeypress="mykeypress(event);" />
                            <p style="height:36px; line-height:36px; padding:0 5px;margin-top: 15px;"><span class="fl"><%--<input type="checkbox" class="jzmm">记住我　|　--%><a href="/account/forget_passwd"><fmt:message key="GLOBAL_忘记密码" bundle="${bundle}"/>？</a></span><span class="fr"><input type="button" id="login_button" class="anniu" value="<fmt:message key="GLOBAL_登录" bundle="${bundle}"/>"></span></p>
                        </div>
                    </div>
                </div>
            </form>
        </div>
        <script type="text/javascript">
            $(document).ready(function () {
                $("#login_button").click(function () {
                    login();
                });
            });
            function mykeypress(event) {
                var e = event || window.event || arguments.callee.caller.arguments[0];
                if (e && e.keyCode == 13) {
                    login();
                }
            }
            function login() {
                if (CBRAValid.checkFormValueNull($("#login_account"))) {
                        CBRAMessage.showWrongMessageAndBorderEle($("#login_msg_1"),"<fmt:message key="GLOBAL_请输入登录帐号" bundle="${bundle}"/>",$("#login_account"));
                        return;
                    }
                    if (CBRAValid.checkFormValueNull($("#login_passwd"))) {
                        CBRAMessage.showWrongMessageAndBorderEle($("#login_msg_2"),"<fmt:message key="GLOBAL_输入密码" bundle="${bundle}"/>",$("#login_passwd"));
                        return;
                    }
                    $("#form_login").submit();
            }
        </script>             
    </body>
</html>
