<%@page import="com.cbra.Config"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!--top-->
<div class="top-top">
    <!--页眉-->
    <div class="Header">

        <div class="top-main">

            <!--微信/联系方式-->
            <div class="weix-lianx">
                <a class="ico-weixin weixin" onmouseout="showWeixinMenu(this)" onmouseover="showWeixinMenu(this, true)" href="javascript:void(0);"><fmt:message key="PAGE_官方微信" bundle="${bundle}"/></a>
                <a class="ico-weixin lianx" <c:if test="${bundle.locale.language == 'en'}">style="width:66px"</c:if>><fmt:message key="INDEX_联系我们" bundle="${bundle}"/></a>
                </div>
                <!--微信下拉二维码-->
                <div id="WeixinMenu" class="weixin-menu" style="display: none;">
                    <div class="weixin-bd">
                        <p><img src="/images/weixin.jpg"><span style="font-size:12px;"> <fmt:message key="PAGE_官方微信内容" bundle="${bundle}"/></span></p>
                </div>
            </div>
            <!--登录/注册/会员中心/中英文-->
            <div class="right-gn">
                <c:if test="${empty sessionScope.user}"><a href="/account/login"><fmt:message key="PAGE_会员登录" bundle="${bundle}"/></a>  |  <a href="/account/signup"><fmt:message key="PAGE_快速注册" bundle="${bundle}"/></a></c:if>
                <c:if test="${not empty sessionScope.user}">
                    <c:if test="${sessionScope.user.type == 'USER'}">
                        <a href="/account/overview" ><fmt:message key="GLOBAL_个人会员中心" bundle="${bundle}"/></a>
                    </c:if>
                    <c:if test="${sessionScope.user.type == 'COMPANY' || sessionScope.user.type == 'SUB_COMPANY'}">
                        <a href="/account/overview_c" >企业会员中心</a>
                    </c:if>
                    <c:choose>
                        <c:when test="${sessionScope.userStatus == 'ASSOCIATE_MEMBER'}">(<fmt:message key="GLOBAL_级别" bundle="${bundle}"/>：<a href="/account/membership_fee"><fmt:message key="GLOBAL_准会员" bundle="${bundle}"/></a>)</c:when>
                        <c:when test="${sessionScope.userStatus == 'MEMBER'}">(<fmt:message key="GLOBAL_级别" bundle="${bundle}"/>：会员)</c:when>
                    </c:choose>
                </c:if>
                &nbsp;&nbsp;<a href="javascript:language.doSetEnglish()">English</a>   |   <a href="javascript:language.doSetChinese()">中文</a>   
                <%--|   <a href="error-c.asp">报错页面连接，知道后程序去掉</a>--%>
            </div>

        </div>

    </div>
    <!--页眉 end-->
    <!--logo-->
    <div class="LOGO">
        <div class="LOGO-l"><a href="/public/index"><img src="/images/logo.png"></a></div>
        <div class="LOGO-r">
            <p><fmt:message key="PAGE_咨询热线" bundle="${bundle}"/>：021-61550302</p>
            <input type="text" id="search_text" value="${searchText}" onkeypress="mykeypress13(event);" class="Input-k"><input type="button" class="button-a" value="<fmt:message key="GLOBAL_搜索" bundle="${bundle}"/>" onclick="search($('#search_text').val())">
        </div>
        <div style=" clear:both;"></div>
    </div>
    <!--logo end-->

    <!--导航-->
    <div class="nav-wrap">
        <ul id="HJ_Nav" class="nav">
            <!--首页-->
            <li id="nav_item_1" class="nav-item"><a class="nav-txt" target="" onmouseover="M(this, 1)"  href="/public/index">
                    <fmt:message key="INDEX_筑誉首页" bundle="${bundle}"/>
                </a></li>
            <!--首页 end-->

            <!--走进筑誉-->
            <li id="nav_item_2" class="nav-item"><a class="nav-txt" target="" onmouseover="M(this, 2)" href="/into/idea">
                    <fmt:message key="INDEX_走进筑誉" bundle="${bundle}"/>
                </a>
                <div class="nav-menu clearfix" id="HJ_Menu_2" style="<c:choose><c:when test="${bundle.locale.language == 'en'}">width: 730px;</c:when><c:otherwise>width: 630px;</c:otherwise></c:choose> display: none;">
                            <ul class="fl nav-channel">
                                    <li><a href="/into/idea"><fmt:message key="INDEX_筑誉理念" bundle="${bundle}"/></a></li>
                        <li><a href="/into/pattern" ><fmt:message key="INDEX_业务格局" bundle="${bundle}"/></a></li>
                        <li><a href="/into/course" ><fmt:message key="INDEX_发展历程" bundle="${bundle}"/></a></li>
                        <li><a href="/into/speech" ><fmt:message key="INDEX_会长致辞" bundle="${bundle}"/></a></li>
                        <li><a href="/into/declaration" ><fmt:message key="INDEX_理事宣言" bundle="${bundle}"/></a></li>
                        <li><a href="/into/contact_us" ><fmt:message key="INDEX_联系我们" bundle="${bundle}"/></a></li>
                    </ul>
                    <span class="nav-menu-line" style="height:292px;margin-right:30px">&nbsp;</span>
                    <div class="<c:choose><c:when test="${bundle.locale.language == 'en'}">fr</c:when><c:otherwise>fl</c:otherwise></c:choose> hui" style="width:410px">
                        <p><img src="<%=Config.topInto.getPicUrl()%>" width="410" height="247" alt=""><br><%=Config.topInto.getIntroduction()%></p></div>
                </div>
            </li>
            <!--走进筑誉 end-->
            <!--新闻中心-->
            <li id="nav_item_3" class="nav-item"><a class="nav-txt" target="" onmouseover="M(this, 3)" href="/news/news_list">
                    <fmt:message key="INDEX_新闻中心" bundle="${bundle}"/>
                </a>
                <div class="nav-menu clearfix" id="HJ_Menu_3" style="<c:choose><c:when test="${bundle.locale.language == 'en'}">width: 680px;</c:when><c:otherwise>width: 560px;</c:otherwise></c:choose> display: none;">
                            <ul class="fl nav-channel" id="menu-news-switch" onmouseover="inittab( & #39; menu - news - switch & #39; , & #39; li & #39; , & #39; div & #39; )">
                                    <li><a href="/news/news_list"><fmt:message key="INDEX_筑誉新闻" bundle="${bundle}"/></a></li>
                        <li><a href="/news/industry_list"><fmt:message key="INDEX_行业新闻" bundle="${bundle}"/></a></li>
                    </ul>
                    <span class="nav-menu-line" style="height:202px"></span>
                    <div class="<c:choose><c:when test="${bundle.locale.language == 'en'}">fr</c:when><c:otherwise>fl</c:otherwise></c:choose>" id="menu-news-switch-body" style="width:380px">
                                <span class="blank10"></span>
                                <div>
                                        <h4><a href="/news/news_list"><fmt:message key="INDEX_筑誉新闻" bundle="${bundle}"/></a></h4>
                            <span class="blank10"></span>
                            <ul class="list list-f12-autoheight">
                                <c:forEach var="news1" items="<%=Config.newsList%>">
                                    <li><a href="/news/details?id=${news1.id}" target="_blank">${news1.title}</a></li>
                                    </c:forEach>
                            </ul>
                            <h4><a href="/news/industry_list"><fmt:message key="INDEX_行业新闻" bundle="${bundle}"/></a></h4>
                            <span class="blank10"></span>
                            <ul class="list list-f12-autoheight">
                                <c:forEach var="news" items="<%=Config.industryList%>">
                                    <li><a href="/news/details?id=${news.id}" target="_blank">${news.title}</a></li>
                                    </c:forEach>
                            </ul>
                            <span class="blank10"></span>
                            <span class="more fr"><a href="/news/news_list" target="_blank"><fmt:message key="GLOBAL_更多" bundle="${bundle}"/></a></span>
                        </div>
                    </div>
                </div>
            </li>
            <!--新闻中心 end-->
            <!--活动讲座-->
            <li id="nav_item_4" class="nav-item"><a class="nav-txt" target="" onmouseover="M(this, 4)" href="/event/near_future"><fmt:message key="INDEX_活动讲座" bundle="${bundle}"/></a>
                <div class="nav-menu clearfix" id="HJ_Menu_4" style="<c:choose><c:when test="${bundle.locale.language == 'en'}">min-height: inherit; width: 800px; left: -195px; display: none;</c:when><c:otherwise>min-height: inherit; width: 700px; left: -95px; display: none;</c:otherwise></c:choose>">
                            <ul class="fl nav-channel">
                                    <li><a href="/event/near_future"><fmt:message key="INDEX_近期活动" bundle="${bundle}"/></a></li>
                        <li><a href="/event/period"><fmt:message key="INDEX_往期活动" bundle="${bundle}"/></a></li>
                        <li><a href="/event/partners"><fmt:message key="INDEX_合作伙伴活动" bundle="${bundle}"/></a></li>
                    </ul>
                    <c:forEach var="info" items="<%=Config.topEvent%>">
                        <span class="nav-menu-line" style="height:240px;margin-right:40px"></span>
                        <div class="fl hui" style="width:200px;padding-top:10px;overflow:hidden">
                            <p><a target="_blank" href="${info.navUrl}"><img src="${info.picUrl}" style="width: 250px; height: 150px;"></a></p>
                            <p>&nbsp;</p><p>${info.title}</p>
                            <p>${info.introduction}</p>
                        </div>
                    </c:forEach>
                </div>
            </li>
            <!--活动讲座 end-->
            <!--专题培训-->
            <li id="nav_item_5" class="nav-item"><a class="nav-txt" target="" onmouseover="M(this, 5)" href="/train/idea_train"><fmt:message key="INDEX_专题培训" bundle="${bundle}"/></a>
                <div class="nav-menu clearfix" id="HJ_Menu_5" style="<c:choose><c:when test="${bundle.locale.language == 'en'}">left:-306px; width: 800px; display: none;</c:when><c:otherwise>left:-206px; width: 700px; display: none;</c:otherwise></c:choose>">
                            <ul class="fl nav-channel">
                                    <li><a href="/train/idea_train" ><fmt:message key="INDEX_培训理念" bundle="${bundle}"/></a></li>
                        <li><a href="/train/near_future_train" ><fmt:message key="INDEX_近期培训" bundle="${bundle}"/></a></li>
                        <li><a href="/train/period_train" ><fmt:message key="INDEX_往期培训" bundle="${bundle}"/></a></li>
                        <li><a href="/train/lecturers" ><fmt:message key="INDEX_讲师团队" bundle="${bundle}"/></a></li>
                    </ul>
                    <c:forEach var="info" items="<%=Config.topTrain%>">
                        <span class="nav-menu-line" style="height:240px;margin-right:40px"></span>
                        <div class="fl hui" style="width:220px;padding-top:10px;overflow:hidden">
                            <p><a href="${info.navUrl}" target="_blank"><img src="${info.picUrl}" style="width: 248px; height: 151px;"></a></p>
                            <p>&nbsp;</p>
                            <p><strong>${info.title}&nbsp;<br>
                                </strong>${info.introduction}</p>
                        </div>
                    </c:forEach>
                </div>
            </li>
            <!--专题培训 end-->
            <!--认证体系-->
            <li id="nav_item_9" class="nav-item"><a class="nav-txt" target="" onmouseover="M(this, 9)" href="/auth/design"><fmt:message key="INDEX_认证体系" bundle="${bundle}"/></a>
                <div class="nav-menu clearfix" id="HJ_Menu_9" style="<c:choose><c:when test="${bundle.locale.language == 'en'}">width:400px;</c:when><c:otherwise>width:300px;</c:otherwise></c:choose> left:3px; display: none;">
                    <div class="fl" style="<c:choose><c:when test="${bundle.locale.language == 'en'}">width:150px;</c:when><c:otherwise>width:100px;</c:otherwise></c:choose>">
                        <h4><fmt:message key="INDEX_个人认证" bundle="${bundle}"/></h4>
                        <span class="blank6"></span>
                        <ul class="nav-sub-channel">
                            <li><a href="/auth/design" ><fmt:message key="INDEX_设计" bundle="${bundle}"/></a></li>
                            <li><a href="/auth/construction" ><fmt:message key="INDEX_施工" bundle="${bundle}"/></a></li>
                            <li><a href="/auth/quality" ><fmt:message key="INDEX_质量" bundle="${bundle}"/></a></li>
                            <li><a href="/auth/safe" ><fmt:message key="INDEX_安全" bundle="${bundle}"/></a></li>
                        </ul>
                    </div>
                    <span class="nav-menu-line" style="margin-right:35px;margin-left:25px"></span>
                    <div class="fl" style="<c:choose><c:when test="${bundle.locale.language == 'en'}">width:150px;</c:when><c:otherwise>width:100px;</c:otherwise></c:choose>">
                        <h4><fmt:message key="INDEX_企业认证" bundle="${bundle}"/></h4>
                        <span class="blank6"></span>
                        <ul class="nav-sub-channel">
                            <li><a href="/auth/quality_auth" ><fmt:message key="INDEX_品质认证" bundle="${bundle}"/></a></li>
                            <li><a href="/auth/safe_auth" ><fmt:message key="INDEX_安全认证" bundle="${bundle}"/></a></li>
                        </ul>
                    </div>
                </div>
            </li>
            <!--认证体系 end-->
            <!--团队风采-->
            <li id="nav_item_6" class="nav-item"><a class="nav-txt" target="" onmouseover="M(this, 6)" href="/team/director" ><fmt:message key="INDEX_团队风采" bundle="${bundle}"/></a>
                <div class="nav-menu clearfix" id="HJ_Menu_6" style="<c:choose><c:when test="${bundle.locale.language == 'en'}">left: auto;  width: 510px; left: -127px;  display: none;</c:when><c:otherwise>left: auto;  width: 410px; left: -138px;  display: none;</c:otherwise></c:choose>">
                            <ul class="fl nav-channel">
                                    <li><a href="/team/director"><fmt:message key="INDEX_理事成员" bundle="${bundle}"/></a></li>
                            <%--<li><a href="/team/committee">委员会</a></li>--%>
                        <li><a href="/team/branch"><fmt:message key="INDEX_各地分会" bundle="${bundle}"/></a></li>
                        <li><a href="/team/expert"><fmt:message key="INDEX_专家顾问" bundle="${bundle}"/></a></li>
                        <li><a href="/team/style"><fmt:message key="INDEX_部分会员风采" bundle="${bundle}"/></a></li>
                    </ul>
                    <span class="nav-menu-line" style="height:240px;margin-right:40px"></span>
                    <div class="<c:choose><c:when test="${bundle.locale.language == 'en'}">fr</c:when><c:otherwise>fl</c:otherwise></c:choose> hui" style="width:220px;padding-top:10px;overflow:hidden">
                        <p><a href="#" target="_blank"><img style="height:131px;width:206px;" src="<%=Config.topStyle.getPicUrl()%>"></a></p>
                        <p><%=Config.topStyle.getIntroduction()%><br></p>
                    </div>
                </div>
            </li>
            <!--团队风采 end-->
            <!--资讯专区-->
            <li id="nav_item_7" class="nav-item"><a class="nav-txt" target="" onmouseover="M(this, 7)" href="/into/info_area"><fmt:message key="INDEX_资讯专区" bundle="${bundle}"/></a>
                <div class="nav-menu clearfix" id="HJ_Menu_7" style="<c:choose><c:when test="${bundle.locale.language == 'en'}">width:750px; left: -478px; display: none;</c:when><c:otherwise>width:450px; left: -289px; display: none;</c:otherwise></c:choose>">
                    <div class="fl" style="<c:choose><c:when test="${bundle.locale.language == 'en'}">width:150px;</c:when><c:otherwise>width:100px;</c:otherwise></c:choose>">
                        <h4><fmt:message key="INDEX_人力资源信息" bundle="${bundle}"/></h4>
                        <span class="blank6"></span>
                        <ul class="nav-sub-channel">
                            <li><a href="/into/three_party_offer"><fmt:message key="INDEX_企业人才需求" bundle="${bundle}"/></a></li>
                            <li><a href="/into/our_offer"><fmt:message key="INDEX_筑誉人才库" bundle="${bundle}"/></a></li>
                        </ul>
                    </div>
                    <span class="nav-menu-line" style="margin-right:35px;margin-left:25px"></span>
                    <div class="fl" style="<c:choose><c:when test="${bundle.locale.language == 'en'}">width:250px;</c:when><c:otherwise>width:100px;</c:otherwise></c:choose>">
                        <h4><fmt:message key="INDEX_资源信息" bundle="${bundle}"/></h4>
                        <span class="blank6"></span>
                        <ul class="nav-sub-channel">
                            <li><a href="/into/purchase"><fmt:message key="INDEX_采购供求信息" bundle="${bundle}"/></a></li>
                            <li><a href="/into/overseas"><fmt:message key="INDEX_海外工程合作" bundle="${bundle}"/></a></li>
                            <li><a href="/into/building"><fmt:message key="INDEX_建筑产业化合作" bundle="${bundle}"/></a></li>
                            <li><a href="/into/pension"><fmt:message key="INDEX_养老地产合作" bundle="${bundle}"/></a></li>
                        </ul>
                    </div>
                    <span class="nav-menu-line" style="margin-right:35px;margin-left:25px"></span>
                    <div class="fl" style="<c:choose><c:when test="${bundle.locale.language == 'en'}">width:200px;</c:when><c:otherwise>width:100px;</c:otherwise></c:choose>">
                        <h4><fmt:message key="INDEX_前沿领域信息" bundle="${bundle}"/></h4>
                        <span class="blank6"></span>
                        <ul class="nav-sub-channel">
                            <li><a href="/into/material"><fmt:message key="INDEX_新材料新技术" bundle="${bundle}"/></a></li>
                            <li><a href="/into/industrialization" ><fmt:message key="INDEX_建筑产业化" bundle="${bundle}"/></a></li>
                            <li><a href="/into/green" ><fmt:message key="INDEX_绿色建筑" bundle="${bundle}"/></a></li>
                            <li><a href="/into/bim" ><fmt:message key="INDEX_BIM技术" bundle="${bundle}"/></a></li>
                        </ul>
                    </div>
                </div>
            </li>
            <!--资讯专区 end-->
            <!--加入筑誉-->
            <li id="nav_item_8" class="nav-item"><a class="nav-txt" onmouseover="M(this, 8)" href="/join/membership_application" ><fmt:message key="INDEX_加入筑誉" bundle="${bundle}"/></a>
                <div class="nav-menu clearfix" id="HJ_Menu_8" style="<c:choose><c:when test="${bundle.locale.language == 'en'}">left: -649px; width: 810px; display: none;</c:when><c:otherwise>left: -670px; width: 720px; display: none;</c:otherwise></c:choose>">
                            <ul class="fl nav-channel">
                                    <li><a href="/join/membership_application" ><fmt:message key="INDEX_会员申请" bundle="${bundle}"/></a></li>
                        <li><a href="/join/quarters" ><fmt:message key="INDEX_筑誉岗位" bundle="${bundle}"/></a></li>
                        <li><a href="/join/recruit" ><fmt:message key="INDEX_专家招募" bundle="${bundle}"/></a></li>
                        <li><a href="/join/cooperation" ><fmt:message key="INDEX_合作伙伴招募" bundle="${bundle}"/></a></li>
                    </ul>
                    <c:forEach var="info" items="<%=Config.topJoin%>">
                        <span class="nav-menu-line" style="height:240px;margin-right:40px"></span>
                        <div class="fl hui" style="width:220px;padding-top:10px;overflow:hidden">
                            <p><a href="${info.navUrl}" target="_blank"><img src="${info.picUrl}" style="width: 249px; height: 151px;"></a></p>
                            <p><strong>${info.title}&nbsp;<br></strong>${info.introduction}</p>
                        </div>
                    </c:forEach>
                </div>
            </li>
            <!--加入筑誉 end-->
            <!--论坛-->
            <li id="nav_item_10" class="nav-item">
                <a class="nav-txt" onmouseover="M(this, 10)" target="_blank" href="http://bbs.cbra.com">
                    <fmt:message key="GLOBAL_论坛" bundle="${bundle}"/>
                </a>
            </li>
            <!--论坛 end-->
        </ul>
    </div>
    <!--导航 end-->
    <script type="text/javascript">
        function mykeypress13(event) {
            var e = event || window.event || arguments.callee.caller.arguments[0];
            if (e && e.keyCode == 13) {
                search($('#search_text').val())
            }
        }
    </script>
</div>