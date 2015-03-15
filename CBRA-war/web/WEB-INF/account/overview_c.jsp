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

        <div class="two-loc">
            <div class="two-loc-c">当前位置：<a href="/public/index">筑誉首页</a> > 个人会员中心</div>
        </div>

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
                                    <c:when test="${empty company.headImageUrl}"><img src="/ls/ls-26.jpg"></c:when>
                                    <c:otherwise><img style="width: 100px; height: 100px;" src="${company.headImageUrl}"></c:otherwise>
                                </c:choose>
                            </div>
                            <div class="hyxx">
                                <div class="hy-tit">欢迎回来<span>${company.name}</span></div>
                                <div class="hy-titxx">入会时间：<span><fmt:formatDate value="${company.createDate}" pattern="yyyy-MM-dd" type="date" dateStyle="long" /></span>　　　入会年限：<span>${company.createYear}</span> 年　　　已报名活动：<span>${company.enrolledCount}</span>　　　已参加活动：<span>${company.joinedCount}</span></div>
                                <%--<div class="hy-titrz"><span class="rzimg-1">实名认证</span><span class="rzimg-2">营业执照认证</span><span class="rzimg-3">手机认证</span><span class="rzimg-4">邮箱认证</span></div>--%>
                            </div>
                        </div>

                        <table width="760" border="0" cellpadding="0" cellspacing="1" style="background:#ebebeb; margin-top:20px;">
                            <tr>
                                <td class="hyzl-1">企业全称</td>
                                <td class="hyzl-2">${company.name}</td>
                                <td class="hyzl-1">营业执照注册号</td>
                                <td class="hyzl-2">${company.account}</td>
                            </tr>
                            <tr>
                                <td class="hyzl-1">企业邮箱</td>
                                <td class="hyzl-2">${company.email}</td>
                                <td class="hyzl-1">创立时间</td>
                                <td class="hyzl-2"><fmt:formatDate value="${company.companyCreateDate}" pattern="yyyy-MM-dd" type="date" dateStyle="long" /></td>
                            </tr>
                            <tr>
                                <td class="hyzl-1">企业法人</td>
                                <td class="hyzl-2">${company.legalPerson}</td>
                                <td class="hyzl-1">企业性质</td>
                                <td class="hyzl-2">${company.natureString}</td>
                            </tr>
                            <tr>
                                <td class="hyzl-1">企业人数</td>
                                <td class="hyzl-2">${company.scale.mean}</td>
                                <td class="hyzl-1">产业链位置</td>
                                <td class="hyzl-2">${company.icPositionString}</td>
                            </tr>
                            <tr>
                                <td class="hyzl-1">企业地址</td>
                                <td class="hyzl-2">${company.address}</td>
                                <td class="hyzl-1">邮编</td>
                                <td class="hyzl-2">${company.zipCode}</td>
                            </tr>
                        </table>
                        <c:if test="${not empty subCompanyAccountList}">
                            <table width="760" border="0" cellpadding="0" cellspacing="1" style="background:#ebebeb; margin-top:20px;">
                                <c:forEach var="subCompanyAccount" items="${subCompanyAccountList}">
                                    <tr>
                                        <td class="hyzl-1">登录代表信息</td>
                                        <td class="hyzl-3">登录代表帐号：${subCompanyAccount.account}<br></td>
                                    </tr>
                                </c:forEach>
                            </table>
                        </c:if>
                        <c:if test="${sessionScope.user.type == 'COMPANY'}">
                            <div style="text-align:center; margin:10px auto;"><input type="button" style=" width:130px; height:42px; line-height:42px; background:#52853d; color:#FFF; border:0; border-radius:5px; font-size:14px; cursor:pointer;" value="修改资料" onclick="location.href = '/account/reset_user_info'" ></div>
                            </c:if>
                    </td>

                </tr>
            </table>



            <div style="clear:both;"></div>
        </div>
        <!-- 主体 end -->

        <jsp:include page="/WEB-INF/public/z_end.jsp"/>

    </body>
</html>

