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
        <jsp:include page="/WEB-INF/news/z_news_banner.jsp"><jsp:param name="page" value="1" /></jsp:include>
        <!-- 主体 -->
        <div class="two-main">
            <div class="news-list">
                <div class="title"><span><a href="/news/news_list" id="title-span">筑誉新闻</a></span><span><a href="/news/industry_list">行业新闻</a></span></div>
                <ul>
                <c:forEach begin="1" end="5" step="1">
                    <li>
                        <div class="img"><a href="details" target="_blank"><img src="/ls/ls-19.jpg"></a></div>
                        <div class="con"><a href="/news/details" target="_blank">
                                <p class="p1">11月22日筑誉联合会成立大会在陆家嘴圆满落下帷幕</p>
                                <p class="p2">CBRA筑誉建筑联合会是由建筑行业专家学者，资深从业人员及相关企业自发组成的为会员和行业提供优质服务为宗旨的全产业链合作平台以构筑建筑行业信誉，推动中国建筑行业进步”为使命</p></a>
                            <p class="p2"><span class="span1"><a href="#">[筑誉动态]</a></span><span>2014-11-22 17:08:15</span><span class="span2"><a href="/news/details">[阅读全文]</a></span></p>
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
            <div class="news-fr">
                <div class="ad-fr"><img src="/ls/ls-20.jpg"></div>
                <h1>热门点击</h1>
                <div class="top-hits">
                    <ul>
                        <li><a href="/news/details" target="_blank">CBRA筑誉建筑联合会是由建筑行业</a></li>
                        <li><a href="/news/details" target="_blank">专家学者资深从业人员及相关企业自</a></li>
                        <li><a href="/news/details" target="_blank">发组成的为会员和行业提供优</a></li>
                        <li><a href="/news/details" target="_blank">质服务为宗旨的全产业链合作</a></li>
                        <li><a href="/news/details" target="_blank">平台以构筑建筑行业信誉</a></li>
                    </ul>
                </div>
            </div>
            <div style="clear:both;"></div>
        </div>
        <!-- 主体 end -->
        <jsp:include page="/WEB-INF/public/z_end.jsp"/>
    </body>
</html>