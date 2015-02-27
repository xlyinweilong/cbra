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
                    <div class="tit">忘记密码</div>
                    <form action="" method="post">
                        <table width="400" border="0" cellspacing="0" cellpadding="0">
                            <div id="wrongMessage" class="wrongMessage"><c:if test="${not empty postResult.singleErrorMsg}">${postResult.singleErrorMsg}</c:if></div>
                                <tr>
                                    <td width="100" height="44" align="right">会员号：</td>
                                    <td><input id="account" name="account" type="text" class="shuru" /></td>
                                </tr>
                                <tr>
                                    <td height="44" align="right">注册邮箱：</td>
                                    <td><input id="email" name="email" type="text" class="shuru" /></td>
                                </tr>
                                <tr>
                                    <td height="44" align="right"></td>
                                    <td><input type="button" class="rev-an" value="找回密码"></td>
                                </tr>
                            </table>
                        </form>
                    </div>
                    <script type="text/javascript">
                        $(document).ready(function () {
                            $("#login_button").click(function () {
                                if (CBRAValid.checkFormValueNull($("#account"))) {
                                    CBRAMessage.showWrongMessageAndBorderEle($("#wrongMessage"), "请输入会员号", $("#account"));
                                    return;
                                }
                                if (CBRAValid.checkFormValueNull($("#email"))) {
                                    CBRAMessage.showWrongMessageAndBorderEle($("#wrongMessage"), "请输入>注册邮箱", $("#email"));
                                    return;
                                }
                                $("#form_login").submit();
                            });
                        })
                    </script> 
            </c:when>
            <c:otherwise>
                <jsp:include page="/WEB-INF/public/z_top.jsp" />
                <jsp:include page="/WEB-INF/account/z_account_banner.jsp" />
                <div class="two-loc">
                    <div class="two-loc-c">当前位置：<a href="/public/index">筑誉首页</a> > 找回密码</div>
                </div>
                <!-- 主体 -->
                <div class="two-main">
                    <!-- 详细信息 -->
                    <div class="zfcg">
                        <p class="czcg"><img src="/images/zccg.png"></p>
                        <p class="czcg">一封邮件已经发送到您的邮箱，请注意查收。</p>
                        <p class="czcg"><a href="/public/index">返回首页</a></p>
                    </div>
                    <div style="clear:both;"></div>
                </div>
                <!-- 主体 end -->
                <jsp:include page="/WEB-INF/public/z_end.jsp"/>
            </c:otherwise>
        </c:choose>
    </body>
</html>
