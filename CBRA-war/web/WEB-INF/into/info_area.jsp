<%@page import="com.cbra.Config"%>
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
        <jsp:include page="/WEB-INF/public/z_banner.jsp" />
        <jsp:include page="/WEB-INF/into/z_into_banner.jsp"><jsp:param name="page" value="0" /></jsp:include>
            <!-- 主体 -->
            <div class="two-main">
                <!-- 一排 -->
                <div class="info-a">
                    <div class="info-fl">
                        <div class="Title">
                            <div class="Title-1">人力资源</div>
                            <div class="Title-3"><a href="/into/three_party_offer">更多</a></div>
                        </div>
                        <ul>
                        <c:forEach var="offer" items="${offerList}">
                            <li><a href="/into/offer_details?id=${offer.id}"><span class="span-1">${offer.position}</span><span class="span-2">${offer.city} ${offer.education}</span><span class="span-3">[<fmt:formatDate value='${offer.pushDate}' pattern='yyyy-MM-dd' type='date' dateStyle='long' />]</span></a></li>
                                    </c:forEach> 
                    </ul>
                </div>
                <div class="info-fr">
                    <p><img src="/pic/ad.jpg"></p>
                    <a href="/into/our_offer"><img src="/images/a-rck.jpg"></a>
                </div>
                <div style="clear:both;"></div>
            </div>
            <!-- 一排 end-->
            <!-- 广告 -->
            <div class="info-ad"><img  style="width: 1000px;" src="<%=Config.homeAd.getPicUrl()%>"></div>
            <!-- 广告 end -->
            <!-- 资源信息 -->
            <div class="info-r">
                <div class="Title">
                    <div class="Title-1">资源信息</div>
                    <div class="Title-3"><a href="/into/purchase">更多</a></div>
                </div>
                <div class="info" style="height: 120px;">
                    <div class="info-mk"><a href="/into/purchase" id="fl-nav-hover"><img src="/images/info-mk-1.jpg"></a></div>
                    <div class="info-mk"><a href="/into/overseas" id="fl-nav-hover"><img src="/images/info-mk-2.jpg"></a></div>
                    <div class="info-mk"><a href="/into/building" id="fl-nav-hover"><img src="/images/info-mk-3.jpg"></a></div>
                    <div class="info-mk"><a href="/into/pension" id="fl-nav-hover"><img src="/images/info-mk-4.jpg"></a></div>
                    <div style="clear:both;"></div>
                </div>
            </div>
            <!-- 资源信息 -->
            <!-- 前沿领域 -->
            <div class="info-area">
                <div class="Title">
                    <div class="Title-1">前沿领域</div>
                    <div class="Title-3"><a href="/into/material">更多</a></div>
                </div>
                <ul>
                    <c:forEach var="plateInfo" items="${plateInfoList}">
                        <li><a href="/into/details?id=${plateInfo.id}">${plateInfo.title}<span>[<fmt:formatDate value='${plateInfo.pushDate}' pattern='yyyy-MM-dd' type='date' dateStyle='long' />]</span></a></li>
                        </c:forEach>
                </ul>
            </div>
            <!-- 前沿领域 end -->
            <div style="clear:both;"></div>
        </div>
        <!-- 主体 end -->
        <jsp:include page="/WEB-INF/public/z_end.jsp"/>
    </body>
</html>