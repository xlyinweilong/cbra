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
                        <jsp:include page="/WEB-INF/account/z_left.jsp"><jsp:param name="page" value="1" /></jsp:include>
                        </td>
                        <td valign="top" class="fr-c">
                            <div class="top-xx">
                                <div class="img">
                                <c:choose>
                                    <c:when test="${empty user.headImageUrl}"><img src="/ls/ls-26.jpg"></c:when>
                                    <c:otherwise><img src="${user.headImageUrl}"></c:otherwise>
                                </c:choose>
                                </div>
                                <div class="hyxx">
                                    <div class="hy-tit">欢迎回来<span>${user.name}</span></div>
                                    <div class="hy-titxx">入会时间：<span><fmt:formatDate value="${user.createDate}" pattern="yyyy-MM-dd" type="date" dateStyle="long" /></span>　　　入会年限：<span>${user.createYear}</span> 年　　　已报名活动：<span>${user.enrolledCount}</span>　　　已参加活动：<span>${user.joinedCount}</span></div>
                                    <%--
                                    <div class="hy-titrz"><span class="rzimg-1">实名认证</span><span class="rzimg-2">营业执照认证</span><span class="rzimg-3">手机认证</span><span class="rzimg-4">邮箱认证</span></div>--%>
                                </div>
                            </div>
                            <table width="760" border="0" cellpadding="0" cellspacing="1" style="background:#ebebeb; margin-top:20px;">
                                <tr>
                                    <td class="hyzl-1">中文姓名</td>
                                    <td class="hyzl-2">${user.name}</td>
                                    <td class="hyzl-1">英文姓名</td>
                                    <td class="hyzl-2">${user.enName}</td>
                                </tr>
                                <tr>
                                    <td class="hyzl-1">手机</td>
                                    <td class="hyzl-2">${user.account}</td>
                                    <td class="hyzl-1">EMAIL</td>
                                    <td class="hyzl-2">${user.email}</td>
                                </tr>
                                <tr>
                                    <td class="hyzl-1">行业从业时间</td>
                                    <td class="hyzl-2">${user.workingYear}年</td>
                                    <td class="hyzl-1">目前就职公司</td>
                                    <td class="hyzl-2">${user.company}</td>
                                </tr>
                                <tr>
                                    <td class="hyzl-1">产业链位置</td>
                                    <td class="hyzl-2">${user.icPositionString}</td>
                                    <td class="hyzl-1">职务</td>
                                    <td class="hyzl-2">${user.positionString}</td>
                                </tr>
                                <tr>
                                    <td class="hyzl-1">邮寄地址</td>
                                    <td class="hyzl-2">${user.address}</td>
                                    <td class="hyzl-1">邮编</td>
                                    <td class="hyzl-2">${user.zipCode}</td>
                                </tr>
                            </table>
                            <table width="760" border="0" cellpadding="0" cellspacing="1" style="background:#ebebeb; margin-top:20px;">
                                <tr>
                                    <td class="hyzl-1">工作履历</td>
                                    <td class="hyzl-3">${user.workExperience}</td>
                                </tr>
                            </table>
                            <table width="760" border="0" cellpadding="0" cellspacing="1" style="background:#ebebeb; margin-top:20px;">
                                <tr>
                                    <td class="hyzl-1">项目经验</td>
                                    <td class="hyzl-3">${user.projectExperience}</td>
                                </tr>
                            </table>
                            <div style="text-align:center; margin:10px auto;"><input type="button" style=" width:130px; height:42px; line-height:42px; background:#52853d; color:#FFF; border:0; border-radius:5px; font-size:14px; cursor:pointer;" value="修改资料" onclick="location.href = '#'" ></div>
                        </td>
                    </tr>
                </table>
                <div style="clear:both;"></div>
            </div>
            <!-- 主体 end -->
        <jsp:include page="/WEB-INF/public/z_end.jsp"/>
    </body>
</html>
