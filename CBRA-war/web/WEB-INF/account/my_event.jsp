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

                        <jsp:include page="/WEB-INF/account/z_left.jsp"><jsp:param name="page" value="3" /></jsp:include>

                    </td>

                    <td valign="top" class="fr-c-1">

                        <div class="tit-cz">参与的活动</div>

                        <table width="760" border="0" cellspacing="1" cellpadding="0" class="biaog" >
                            <tr>
                                <td width="120" height="42" bgcolor="efefef" class="biaog-bt"><strong>活动主题</strong></td>
                                <td bgcolor="efefef" class="biaog-bt"><strong>活动日期</strong></td>
                                <td bgcolor="efefef" class="biaog-bt"><strong>地点</strong></td>
                                <td bgcolor="efefef" class="biaog-bt"><strong>费用</strong></td>
                                <td bgcolor="efefef" class="biaog-bt"><strong>报名状态</strong></td>
                                <td width="200" bgcolor="efefef" class="biaog-bt"><strong>活动状态</strong></td>
                            </tr>
                            <c:forEach begin="1" end="7" step="1">
                            <tr>
                                <td height="30" bgcolor="#FFFFFF" class="biaog-bt">唱响未来</td>
                                <td bgcolor="#FFFFFF" class="biaog-bt">2015-02-04</td>
                                <td bgcolor="#FFFFFF" class="biaog-bt">上海市浦东区</td>
                                <td bgcolor="#FFFFFF" class="biaog-bt">1820.00</td>
                                <td bgcolor="#FFFFFF" class="biaog-bt">已支付</td>
                                <td bgcolor="#FFFFFF" class="biaog-bt"><span class="luz">即将开始</span></td>
                            </tr>
                            <tr>
                                <td height="30" bgcolor="#f8f8f8" class="biaog-bt">唱响未来</td>
                                <td bgcolor="#f8f8f8" class="biaog-bt">2015-02-04</td>
                                <td bgcolor="#f8f8f8" class="biaog-bt">上海市浦东区</td>
                                <td bgcolor="#f8f8f8" class="biaog-bt">1820.00</td>
                                <td bgcolor="#f8f8f8" class="biaog-bt">已报名</td>
                                <td bgcolor="#f8f8f8" class="biaog-bt"><span class="chengz">已结束</span></td>
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
