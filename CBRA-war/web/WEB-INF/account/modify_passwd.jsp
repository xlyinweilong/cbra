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

                        <div class="tit-cz">参与的活动</div>

                        <table width="760" border="0" cellspacing="0" cellpadding="0" style=" margin:20px auto;">
                            <tr>
                                <td width="120" height="40">原密码</td>
                                <td><input type="password" class="mmmmm"></td>
                            </tr>
                            <tr>
                                <td width="120" height="40">新密码</td>
                                <td><input type="password" class="mmmmm"></td>
                            </tr>
                            <tr>
                                <td width="120" height="40">确认原密码</td>
                                <td><input type="password" class="mmmmm"></td>
                            </tr>
                        </table>
                        <div class="xiayy"><input type="button" class="mmmmm-an" value="提交修改"></div>


                    </td>

                </tr>
            </table>



            <div style="clear:both;"></div>
        </div>
        <!-- 主体 end -->

        <jsp:include page="/WEB-INF/public/z_end.jsp"/>

    </body>
</html>