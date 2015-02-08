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
        <jsp:include page="/WEB-INF/into/z_into_banner.jsp"><jsp:param name="page" value="16" /></jsp:include>
            <!-- 主体 -->
            <div class="two-main">
                <!-- 左侧导航 -->
            <jsp:include page="/WEB-INF/into/z_left.jsp"><jsp:param name="page" value="16" /></jsp:include>
                <!-- 左侧导航 end -->
                <!-- 右侧内容 -->
                <div class="fm-list">
                    <div class="title"><span><a id="title-span">BIM技术</a></span></div>
                    <ul>
                    <c:forEach begin="1" end="5" step="1">
                    <li>
                        <div class="img"><a href="detailed.asp"><img src="/ls/ls-19.jpg"></a></div>
                        <div class="con"><a href="detailed.asp">
                                <p class="p1">我们认为，目前国内建筑市场，随着市场经济的快速发展</p>
                                <p class="p2">我们主张要加大行业管理力度，企业信誉评估体系，创造公平竞争环境，规范市场经营行为，加强行业自律，不断提高标准化、工厂化、部品化、装配化水平，采用新工艺、新材料、新设备、新理念，提高企业核心竞争力。</p></a>
                            <p class="p2"><span>2014-11-22 17:08:15</span><span class="span2"><a href="detailed.asp">[阅读全文]</a></span></p>
                        </div>
                        <div style="clear:both;"></div>
                    </li>
                    </c:forEach>
                </ul>
                <div style="clear:both;"></div>
                <div class="Page">
                    <span>上一页</span>
                    <span id="Page-b">1</span>
                    <span>2</span>
                    <span>3</span>
                    <span>4</span>
                    ...
                    <span>10</span>
                    <span>下一页</span>
                </div>
            </div>
            <!-- 右侧内容 end -->
            <div style="clear:both;"></div>
        </div>
        <!-- 主体 end -->
        <jsp:include page="/WEB-INF/public/z_end.jsp"/>
    </body>
</html>
