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
        <jsp:include page="/WEB-INF/team/z_team_banner.jsp"><jsp:param name="page" value="3" /></jsp:include>
            <!-- 主体 -->
            <div class="two-main">
                <!-- 左侧导航 -->
            <jsp:include page="/WEB-INF/team/z_left.jsp"><jsp:param name="page" value="3" /></jsp:include>
                <!-- 左侧导航 end -->
                <!-- 右侧内容 -->
                <div class="fm-list">
                    <div class="title"><span><a href="#" id="title-span">会　　长</a></span><span><a href="#">常务理事</a></span><span><a href="#">理　　事</a></span></div>
                    <ul>
                    <c:forEach begin="1" end="5" step="1">
                        <li>
                            <div class="img"><a href="team-detailed.asp"><img src="ls/ls-23.jpg"><p>讲师：李天华</p></a></div>
                            <div class="con"><a href="team-detailed.asp">
                                    <p class="p1">11月22日筑誉联合会成立大会在陆家嘴圆满落下帷幕</p>
                                    <p class="p2">CBRA筑誉建筑联合会是由建筑行业专家学者，资深从业人员及相关企业自发组成的为会员和行业提供优质服务为宗旨的全产业链合作平台以构筑建筑行业信誉，推动中国建筑行业进步”为使命，致力于打造中国建筑行业最具公信力的专业平台是由建筑行业专家学者，资深从业人员及相关企业自发组成的为会员和行业提供优质服务为宗旨的全产业链合作平台以构筑建筑行业信誉，推动中国建筑行业进步”为使命，致力于打造中国建筑行业最具公信力的专业平台</p></a>
                                <p class="p2"><span class="span1">阿里巴巴认证课程</span></p>
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
