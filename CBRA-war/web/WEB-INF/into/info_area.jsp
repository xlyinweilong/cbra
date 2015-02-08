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
                        <div class="Title-3"><a href="into-rlzy.asp?id=16" id="fl-nav-hover">更多</a></div>
                    </div>
                    <ul>
                        <li><a href="into-rlzy-detailed.asp"><span class="span-1">制药企业总经理</span><span class="span-2">长春 全日制统招本科12年以上</span><span class="span-3">[2014-01-21]</span></a></li>
                        <li><a href="into-rlzy-detailed.asp"><span class="span-1">制药企业总经理</span><span class="span-2">长春 全日制统招本科12年以上</span><span class="span-3">[2014-01-21]</span></a></li>
                        <li><a href="into-rlzy-detailed.asp"><span class="span-1">制药企业总经理</span><span class="span-2">长春 全日制统招本科12年以上</span><span class="span-3">[2014-01-21]</span></a></li>
                        <li><a href="into-rlzy-detailed.asp"><span class="span-1">制药企业总经理</span><span class="span-2">长春 全日制统招本科12年以上</span><span class="span-3">[2014-01-21]</span></a></li>
                        <li><a href="into-rlzy-detailed.asp"><span class="span-1">制药企业总经理</span><span class="span-2">长春 全日制统招本科12年以上</span><span class="span-3">[2014-01-21]</span></a></li>
                    </ul>
                </div>
                <div class="info-fr">
                    <p><img src="pic/ad.jpg"></p>
                    <a href="into-zyrc.asp"><img src="/images/a-rck.jpg"></a>
                </div>
                <div style="clear:both;"></div>
            </div>
            <!-- 一排 end-->
            <!-- 广告 -->
            <div class="info-ad"><img src="/ls/ls-2.jpg"></div>
            <!-- 广告 end -->
            <!-- 资源信息 -->
            <div class="info-r">

                <div class="Title">
                    <div class="Title-1">资源信息</div>
                    <div class="Title-3"><a href="into-cggq.asp?id=18" id="fl-nav-hover">更多</a></div>
                </div>
                <div class="info">
                    <div class="info-mk"><a href="into-cggq.asp?id=18" id="fl-nav-hover"><img src="/images/info-mk-1.jpg"></a></div>
                    <div class="info-mk"><a href="into-hwgc.asp?id=19" id="fl-nav-hover"><img src="/images/info-mk-2.jpg"></a></div>
                    <div class="info-mk"><a href="into-jzcy.asp?id=20" id="fl-nav-hover"><img src="/images/info-mk-3.jpg"></a></div>
                    <div class="info-mk"><a href="into-yldc.asp?id=21" id="fl-nav-hover"><img src="images/info-mk-4.jpg"></a></div>
                    <div style="clear:both;"></div>
                </div>
            </div>
            <!-- 资源信息 -->
            <!-- 前沿领域 -->
            <div class="info-area">
                <div class="Title">
                    <div class="Title-1">前沿领域</div>
                    <div class="Title-3"><a href="into-xclxjs.asp?id=18" id="fl-nav-hover">更多</a></div>
                </div>
                <ul>
                    <li><a href="detailed.asp">我们本着构筑行业信誉，推动中国建筑行业进步的使命<span>[2015-01-20]</span></a></li>
                    <li><a href="detailed.asp">怀着成为建筑业最具公信力专业平台的协会愿景以及为了体现<span>[2015-01-20]</span></a></li>
                    <li><a href="detailed.asp">平等互助和透明规范的协会价值<span>[2015-01-20]</span></a></li>
                    <li><a href="detailed.asp">在21世纪全球聚焦中国迅速发展的今天成立我们的专业行业协会<span>[2015-01-20]</span></a></li>
                    <li><a href="detailed.asp">任重而道远回顾过去的建筑发展历程<span>[2015-01-20]</span></a></li>
                </ul>
            </div>
            <!-- 前沿领域 end -->
            <div style="clear:both;"></div>
        </div>
        <!-- 主体 end -->
        <jsp:include page="/WEB-INF/public/z_end.jsp"/>
    </body>
</html>