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
                            <a href="/account/login" <c:if test="${p != 'hy'}">id="xianzzz"</c:if>>个人会员</a>
                            <a href="/account/login?p=hy" <c:if test="${p == 'hy'}">id="xianzzz"</c:if>>企业会员</a>
                        </div>
                        <div class="denglu">
                            <div id="login_msg_1" class="wrongMessage"><c:if test="${not empty postResult.singleErrorMsg}">${postResult.singleErrorMsg}</c:if></div>
                        <input type="text" id="login_account" name="account" value="${account}" class="shuk" placeholder="输入帐号" />
                            <div id="login_msg_2" class="wrongMessage"></div>
                            <input type="password" id="login_passwd" name="passwd" class="shuk-1" placeholder="输入密码" />
                            <p style="height:36px; line-height:36px; padding:0 5px;"><span class="fl"><%--<input type="checkbox" class="jzmm">记住我　|　--%><a href="/account/forget_passwd">忘记密码？</a></span><span class="fr"><input type="button" id="login_button" class="anniu" value="登  录"></span></p>
                        </div>
                    </div>
                </div>
            </form>
        </div>
        <script type="text/javascript">
            $(document).ready(function () {
                $("#login_button").click(function () {
                    if (CBRAValid.checkFormValueNull($("#login_account"))) {
                        CBRAMessage.showWrongMessageAndBorderEle($("#login_msg_1"),"请输入帐号",$("#login_account"));
                        return;
                    }
                    if (CBRAValid.checkFormValueNull($("#login_passwd"))) {
                        CBRAMessage.showWrongMessageAndBorderEle($("#login_msg_2"),"请输入密码",$("#login_passwd"));
                        return;
                    }
                    $("#form_login").submit();
                });
            })
        </script>             
    </body>
</html>
