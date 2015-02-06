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
            <div class="logo"><a href="index.asp"><img src="/images/logo-r.png"></a></div>
            <div class="bac">
                <div class="bac-k">
                    <div class="xianz">
                        <a href="/account/login" <c:if test="${p != 'hy'}">id="xianzzz"</c:if>>个人会员</a>
                        <a href="/account/login?p=hy" <c:if test="${p == 'hy'}">id="xianzzz"</c:if>>企业会员</a>
                    </div>
                    <div class="denglu">
                        <input type="text" class="shuk" placeholder="输入帐号">
                        <input type="password" class="shuk-1" placeholder="输入密码">
                        <p style="height:36px; line-height:36px; padding:0 5px;"><span class="fl"><input type="checkbox" class="jzmm">记住我　|　<a href="#">忘记密码</a></span><span class="fr"><input type="button" class="anniu" value="登  录"></span></p>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
