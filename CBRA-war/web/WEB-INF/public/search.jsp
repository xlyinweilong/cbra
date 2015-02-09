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
        <div class="two-loc">
            <div class="two-loc-c">当前位置：<a href="index.asp">筑誉首页</a> > 团队风采 > 理事成员</div>
        </div>

        <!-- 主体 -->
        <div class="two-main">
            <!-- 左侧导航 -->
            <div class="fl-nav">
                <h1>搜　索</h1>
                <ul>
                    <li><a href="team-lscy.asp?id=11" id="fl-nav-hover">全　站</a></li>
                    <li><a href="team-wyh.asp?id=12" id="fl-nav-hover">新　闻</a></li>
                    <li><a href="team-gdfh.asp?id=13" id="fl-nav-hover">活　动</a></li>
                    <li><a href="team-lyzj.asp?id=14" id="fl-nav-hover">培　训</a></li>
                    <li><a href="team-bffh.asp?id=15" id="fl-nav-hover">资　讯</a></li>
                </ul>
            </div>
            <!-- 左侧导航 end -->
            <!-- 右侧内容 -->
            <div class="fm-list">
                <div class="title"><span><a href="#" id="title-span">搜索结果</a></span>
                    <div class="search"><input type="text" class="sousuok"><input type="button" value="搜索" class="sousuoan"></div></div>
                <ul>
                    <c:forEach begin="1" end="5">
                        <li>
                            <div class="con-1"><a href="detailed.asp">
                                    <p class="pp1">11月22日筑誉联合会成立大会在陆家嘴圆满落下帷幕</p>
                                    <p class="pp2">CBRA筑誉建筑联合会是由建筑行业专家学者，资深从业人员及相关企业自发组成的为会员和行业提供优质服务为宗旨的全产业链合作平台以构筑建筑行业信誉，推动中国建筑行业进步”为使命，致力于打造中国建筑行业最具公信力的专业平台是由建筑行业专家学者，资深从业人员及相关企业自发组成的为会员和行业提供优质服务为宗旨的全产业链合作平台以构筑建筑行业信誉，推动中国建筑行业进步”为使命，致力于打造中国建筑行业最具公信力的专业平台</p></a>
                                <p class="pp2"><span class="span1">阿里巴巴认证课程</span></p>
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

