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
        <jsp:include page="/WEB-INF/public/z_account_banner.jsp" />
        <!-- 主体 -->
        <div class="mc-main">
            <table width="1000" border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td valign="top" class="fl-nav">

                        <jsp:include page="/WEB-INF/account/z_left.jsp"><jsp:param name="page" value="2" /></jsp:include>

                        </td>

                        <td valign="top" class="fr-c-1">

                            <div class="tit-cz">会　费<input type="button" class="anniu" value="缴纳会费" onclick="location.href = 'gr-hfcz.asp'" ></div>

                            <table width="760" border="0" cellspacing="1" cellpadding="0" class="biaog" >
                                <tr>
                                    <td width="120" height="42" bgcolor="efefef" class="biaog-bt"><strong>日期</strong></td>
                                    <td bgcolor="efefef" class="biaog-bt"><strong>缴纳方式</strong></td>
                                    <td width="200" bgcolor="efefef" class="biaog-bt"><strong>筑誉确认</strong></td>
                                </tr>
                            <c:forEach begin="1" end="3" step="1">
                                <tr>
                                    <td height="30" bgcolor="#FFFFFF" class="biaog-bt">2015-02-04</td>
                                    <td bgcolor="#FFFFFF" class="biaog-bt">现金</td>
                                    <td bgcolor="#FFFFFF" class="biaog-bt"><span class="chengz">待确认</span></td>
                                </tr>
                                <tr>
                                    <td height="30" bgcolor="#FFFFFF" class="biaog-bt">2015-02-03</td>
                                    <td bgcolor="#FFFFFF" class="biaog-bt">个人网银转账</td>
                                    <td bgcolor="#FFFFFF" class="biaog-bt"><span class="luz">已到帐</span></td>
                                </tr>
                                <tr>
                                    <td height="30" bgcolor="#FFFFFF" class="biaog-bt">2015-02-02</td>
                                    <td bgcolor="#FFFFFF" class="biaog-bt">公司网银转账</td>
                                    <td bgcolor="#FFFFFF" class="biaog-bt"><span class="chengz">确认中</span></td>
                                </tr>
                                <tr>
                                    <td height="30" bgcolor="#FFFFFF" class="biaog-bt">2015-02-01</td>
                                    <td bgcolor="#FFFFFF" class="biaog-bt">在线支付</td>
                                    <td bgcolor="#FFFFFF" class="biaog-bt"><span class="hongz">失败</span></td>
                                </tr>
                            </c:forEach>
                        </table>
                    </td>
                </tr>
            </table>
            <jsp:include page="/WEB-INF/public/z_paging.jsp">
                <jsp:param name="totalCount" value="200" />
                <jsp:param name="maxPerPage" value="15" />
                <jsp:param name="pageIndex" value="1" />
            </jsp:include>
            <div style="clear:both;"></div>
        </div>
        <!-- 主体 end -->

        <jsp:include page="/WEB-INF/public/z_end.jsp"/>

    </body>
</html>
