<%@page import="java.util.Locale"%>
<%@page import="java.util.ResourceBundle"%>
<%@page import="com.cbra.entity.PlateInformation"%>
<%@page import="com.cbra.Config"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html>
    <head>
        <jsp:include page="/WEB-INF/public/z_header.jsp"/>
        <script>
            (function (d, D, v) {
                d.fn.responsiveSlides = function (h) {
                    var b = d.extend({auto: !0, speed: 1E3, timeout: 7E3, pager: !1, nav: !1, random: !1, pause: !1, pauseControls: !1, prevText: " ", nextText: " ", maxwidth: "", controls: "", namespace: "rslides", before: function () {
                        }, after: function () {
                        }}, h);
                    return this.each(function () {
                        v++;
                        var e = d(this), n, p, i, k, l, m = 0, f = e.children(), w = f.size(), q = parseFloat(b.speed), x = parseFloat(b.timeout), r = parseFloat(b.maxwidth), c = b.namespace, g = c + v, y = c + "_nav " + g + "_nav", s = c + "_here", j = g + "_on", z = g + "_s",
                            o = d("<ul class='" + c + "_tabs " + g + "_tabs' />"), A = {"float": "left", position: "relative"}, E = {"float": "none", position: "absolute"}, t = function (a) {
                            b.before();
                            f.stop().fadeOut(q, function () {
                                d(this).removeClass(j).css(E)
                            }).eq(a).fadeIn(q, function () {
                                d(this).addClass(j).css(A);
                                b.after();
                                m = a
                            })
                        };
                        b.random && (f.sort(function () {
                            return Math.round(Math.random()) - 0.5
                        }), e.empty().append(f));
                        f.each(function (a) {
                            this.id = z + a
                        });
                        e.addClass(c + " " + g);
                        h && h.maxwidth && e.css("max-width", r);
                        f.hide().eq(0).addClass(j).css(A).show();
                        if (1 <
                            f.size()) {
                            if (x < q + 100)
                                return;
                            if (b.pager) {
                                var u = [];
                                f.each(function (a) {
                                    a = a + 1;
                                    u = u + ("<li><a href='#' class='" + z + a + "'>" + a + "</a></li>")
                                });
                                o.append(u);
                                l = o.find("a");
                                h.controls ? d(b.controls).append(o) : e.after(o);
                                n = function (a) {
                                    l.closest("li").removeClass(s).eq(a).addClass(s)
                                }
                            }
                            b.auto && (p = function () {
                                k = setInterval(function () {
                                    var a = m + 1 < w ? m + 1 : 0;
                                    b.pager && n(a);
                                    t(a)
                                }, x)
                            }, p());
                            i = function () {
                                if (b.auto) {
                                    clearInterval(k);
                                    p()
                                }
                            };
                            b.pause && e.hover(function () {
                                clearInterval(k)
                            }, function () {
                                i()
                            });
                            b.pager && (l.bind("click", function (a) {
                                a.preventDefault();
                                b.pauseControls || i();
                                a = l.index(this);
                                if (!(m === a || d("." + j + ":animated").length)) {
                                    n(a);
                                    t(a)
                                }
                            }).eq(0).closest("li").addClass(s), b.pauseControls && l.hover(function () {
                                clearInterval(k)
                            }, function () {
                                i()
                            }));
                            if (b.nav) {
                                c = "<a href='javascript:' class='" + y + " prev'>" + b.prevText + "</a><a href='javascript:' class='" + y + " next'>" + b.nextText + "</a>";
                                h.controls ? d(b.controls).append(c) : e.after(c);
                                var c = d("." + g + "_nav"), B = d("." + g + "_nav.prev");
                                c.bind("click", function (a) {
                                    a.preventDefault();
                                    if (!d("." + j + ":animated").length) {
                                        var c = f.index(d("." + j)),
                                            a = c - 1, c = c + 1 < w ? m + 1 : 0;
                                        t(d(this)[0] === B[0] ? a : c);
                                        b.pager && n(d(this)[0] === B[0] ? a : c);
                                        b.pauseControls || i()
                                    }
                                });
                                b.pauseControls && c.hover(function () {
                                    clearInterval(k)
                                }, function () {
                                    i()
                                })
                            }
                        }
                        if ("undefined" === typeof document.body.style.maxWidth && h.maxwidth) {
                            var C = function () {
                                e.css("width", "100%");
                                e.width() > r && e.css("width", r)
                            };
                            C();
                            d(D).bind("resize", function () {
                                C()
                            })
                        }
                    })
                }
            })(jQuery, this, 0);
            $(function () {
                $(".f426x240").responsiveSlides({
                    auto: true,
                    pager: true,
                    nav: true,
                    speed: 700
                });
                $(".f160x160").responsiveSlides({
                    auto: true,
                    pager: true,
                    speed: 700
                });
            });
        </script><!--banner -->
        <style>
            div, ul, li, dl, dt, dd, table, td, input {
                font-size: 12px;
            }
            * {
                margin: 0;
                padding: 0;
            }
            div {
                margin: 0 auto;
            }
            .mod_qr {
                display: inline;
                float:right;
                position: relative;
                margin-right: 20px;
                margin-top:20px;
            }
            .mod_qr .mod_qr_bd {
                position: relative;
                cursor: pointer;
                display: block;
                text-align: center;
                width: 194px;
                height: 232px;
                color: #6c6c6c;
                border: 1px solid #e8e8e8;
                overflow: hidden;
                text-decoration: none;
            }
            .mod_qr .mod_qr_bd span {
                display: block;
                height: 20px;
                line-height: 20px;
                overflow: hidden;
                margin: 4px auto 0;
                width: 148px;
                color: #333!important;
                cursor: pointer;
                text-align: center;
            }
            .mod_qr .mod_qr_bd img {
                display: block;
                margin-left: 8px;
                width: 180px;
                height: 180px;
                vertical-align: bottom;
            }
            .mod_qr .fixed_qr_close {
                position: absolute;
                top: 0;
                left: -19px;
                display: block;
                width: 18px;
                height: 18px;
                border: 1px solid #e8e8e8;
            }
            .mod_qr .fixed_qr_close s {
                width: 11px;
                height: 11px;
                margin-left: 4px;
                margin-top: 4px;
            }
            .qricon {
                display: -moz-inline-stack;
                display: inline-block;
                vertical-align: middle;
                zoom: 1;
                text-indent: -3000px;
                _text-indent: 0;
                _font-size: 0;
            }
            .s_s_close {
                background: url(/images/TB1FEpXGXXXXXa4XXXXyTkXLpXX-500-444.png);
                background-position: -154px -364px;
            }
            *html .mod_qr {
                _top:expression(eval(document.documentElement.scrollTop+document.documentElement.clientHeight-this.offsetHeight-(parseInt(this.currentStyle.marginTop,10)||0)-(parseInt(this.currentStyle.marginBottom,100)||0)-40));
                _bottom:auto;
                _position:absolute;
            }
        </style>
    </head>

    <body>
        <jsp:include page="/WEB-INF/public/z_top.jsp"></jsp:include>
        <div class="mod_qr" style="position:fixed;top:500px;right:0px;z-index: 99999;background-color: white">
                <a href="#" class="mod_qr_bd">
                    <span style="font-size: 18px">扫描下载APP</span>
                    <img src="/images/app.png" alt="筑誉建筑联合会">
                    <span style="font-size: 18px">筑誉联合会客户端</span>
                </a><a href="javascript:void(0);" id="close" class="fixed_qr_close"><s class="qricon s_s_close"></s></a>
            </div>
            <!-- banner -->
            <div class="ly_bac">
                <div class="content-ba">
                    <div class="new_banner">
                        <ul class="rslides f426x240">
                        <%
                            Locale locale = (Locale) session.getAttribute("SESSION_ATTRIBUTE_LOCALE");
                            for (PlateInformation info : !locale.equals(Locale.ENGLISH) ? Config.homeSAD : Config.homeSADEn) {
                        %>
                        <li><a href="<%=info.getNavUrl()%>"><img src="<%=info.getPicUrl()%>" width="1423" height="320" /></a></li>
                                <%
                                    }
                                %>
                    </ul>
                </div>
            </div>
        </div>
        <!-- bannerend -->
        <!-- 主体 -->
        <div class="main">
            <!-- 一 排 -->
            <div class="One-Row">
                <!-- 关于筑誉 -->
                <div class="One-Row-fl">
                    <div class="Title">
                        <div class="Title-1"><fmt:message key="INDEX_关于筑誉" bundle="${bundle}"/></div>
                        <div class="Title-2"><a href="/account/signup"><fmt:message key="INDEX_申请入会" bundle="${bundle}"/></a></div>
                        <div class="Title-3"><a href="/into/idea"><fmt:message key="INDEX_更多" bundle="${bundle}"/></a></div>
                    </div>
                    <div class="Content">
                        <div class="img"><img style="width: 250px; height: 142px;" src="<%=!locale.equals(Locale.ENGLISH) ? Config.homeAbout.getPicUrl() : Config.homeAboutEn.getPicUrl()%>"></div>
                        <p><%=!locale.equals(Locale.ENGLISH) ? Config.homeAbout.getIntroduction() : Config.homeAboutEn.getIntroduction()%></p>
                    </div>
                </div>
                <!-- 近期活动 -->
                <div class="One-Row-fr">
                    <div class="Title">
                        <div class="Title-1"><fmt:message key="INDEX_近期活动" bundle="${bundle}"/></div>
                        <div class="Title-3"><a href="/event/near_future"><fmt:message key="INDEX_更多" bundle="${bundle}"/></a></div>
                    </div>
                    <ul>
                        <c:forEach var="event" items="<%=!locale.equals(Locale.ENGLISH) ? Config.eventListIndex : Config.eventListIndexEn%>">
                            <li><a href="/event/event_details?id=${event.id}">[${event.eventBeginDateIndexString}]${event.titleIndex}</a><c:if test="${event.statusBoolean}"><img src="/images/ico-bmz.png"></c:if></li>
                            </c:forEach>
                    </ul>
                </div>
                <div style=" clear:both;"></div>
            </div>
            <!-- 一 排 end -->

            <!-- 广告条 -->
            <div class="ad-sx"><img  style="width: 1000px;" src="<%=!locale.equals(Locale.ENGLISH) ? Config.homeAd.getPicUrl() : Config.homeAdEn.getPicUrl()%>"></div>
            <!-- 广告条 end-->

            <!-- 二 排 -->
            <div class="Two-Row">

                <div class="Two-Row-fl">
                    <div class="Title">
                        <div class="Title-1"><fmt:message key="INDEX_前沿领域资讯" bundle="${bundle}"/></div>
                        <div class="Title-3"><a href="/into/material"><fmt:message key="INDEX_更多" bundle="${bundle}"/></a></div>
                    </div>

                    <div class="Content">
                        <div class="Modules">
                            <div class="img"><img src="/ls/ls-3.jpg"></div>
                            <div class="xxys">
                                <h1><fmt:message key="INDEX_新材料新技术" bundle="${bundle}"/></h1>
                                <ul>
                                    <c:forEach var="info" items="<%=!locale.equals(Locale.ENGLISH) ? Config.materialListIndex : Config.materialListIndexEn%>">
                                        <li><a href="/into/details?id=${info.id}">${info.titleIndexStr2}</a></li>
                                        </c:forEach>
                                </ul>
                            </div>
                        </div>
                        <div class="Modules">
                            <div class="img"><img src="/ls/ls-4.jpg"></div>
                            <div class="xxys">
                                <h1><fmt:message key="INDEX_建筑产业化" bundle="${bundle}"/></h1>
                                <ul>
                                    <c:forEach var="info" items="<%=!locale.equals(Locale.ENGLISH) ? Config.industrializationListIndex : Config.industrializationListIndexEn%>">
                                        <li><a href="/into/details?id=${info.id}">${info.titleIndexStr}</a></li>
                                        </c:forEach>
                                </ul>
                            </div>
                        </div>
                        <div class="Modules">
                            <div class="img"><img src="/ls/ls-5.jpg"></div>
                            <div class="xxys">
                                <h1><fmt:message key="INDEX_绿色建筑" bundle="${bundle}"/></h1>
                                <ul>
                                    <c:forEach var="info" items="<%=!locale.equals(Locale.ENGLISH) ? Config.greenListIndex : Config.greenListIndexEn%>">
                                        <li><a href="/into/details?id=${info.id}">${info.titleIndexStr}</a></li>
                                        </c:forEach>
                                </ul>
                            </div>
                        </div>
                        <div class="Modules">
                            <div class="img"><img src="/ls/ls-6.jpg"></div>
                            <div class="xxys">
                                <h1><fmt:message key="INDEX_BIM技术" bundle="${bundle}"/></h1>
                                <ul>
                                    <c:forEach var="info" items="<%=!locale.equals(Locale.ENGLISH) ? Config.bimListIndex : Config.bimListIndexEn%>">
                                        <li><a href="/into/details?id=${info.id}">${info.titleIndexStr}</a></li>
                                        </c:forEach>
                                </ul>
                            </div>
                        </div>
                        <div style=" clear:both;"></div>
                    </div>
                </div>

                <div class="Two-Row-fr">
                    <div class="Title">
                        <div class="Title-1"><fmt:message key="INDEX_专家顾问" bundle="${bundle}"/></div>
                        <div class="Title-3"><a href="/team/expert"><fmt:message key="INDEX_更多" bundle="${bundle}"/></a></div>
                    </div>
                    <ul>
                        <%
                            int i = 0;
                            for (PlateInformation info : !locale.equals(Locale.ENGLISH) ? Config.homeExpert : Config.homeExpertEn) {
                                i++;
                        %>
                        <li <%if (i == 2 || i == 5) {%>class="m-lr"<%}%>><a  href="<%=info.getNavUrl()%>"><img src="<%=info.getPicUrl()%>" width="88" height="88" /></a></li>
                                <%
                                    }
                                %>
                    </ul>
                </div>
                <div style=" clear:both;"></div>
            </div>
            <!-- 二 排 end -->

            <!-- 三 排 -->
            <div class="One-Row">
                <!-- 热点新闻 -->
                <div class="One-Row-fl">
                    <div class="Title">
                        <div class="Title-1"><fmt:message key="INDEX_热点新闻" bundle="${bundle}"/></div>
                        <div class="Title-3"><a href="/news/news_list"><fmt:message key="INDEX_更多" bundle="${bundle}"/></a></div>
                    </div>
                    <div class="Content">
                        <div class="img"><img src="<%=!locale.equals(Locale.ENGLISH) ? Config.homeNews.getPicUrl() : Config.homeNewsEn.getPicUrl()%>"  style="width: 250px;"></div>
                        <ul>
                            <c:forEach var="news" items="<%=!locale.equals(Locale.ENGLISH) ? Config.newsList5 : Config.newsList5En%>">
                                <li><a href="/news/details?id=${news.id}" class="fl">[<fmt:formatDate value='${news.pushDate}' pattern='yyyy-MM-dd' type='date' dateStyle='long' />]${news.titleIndexStr}</a><c:if test="${news.isNewPushDate()}"><img style="float:left; margin-top:8px;" src="/images/ico-new.jpg"></c:if></li>
                                </c:forEach>
                        </ul>
                    </div>
                </div>
                <!-- 企业人才需求 -->
                <div class="One-Row-fr">
                    <div class="Title">
                        <div class="Title-1"><fmt:message key="INDEX_企业人才需求" bundle="${bundle}"/></div>
                        <div class="Title-3"><a href="/into/three_party_offer"><fmt:message key="INDEX_更多" bundle="${bundle}"/></a></div>
                    </div>
                    <ul>
                        <c:forEach var="offer" items="<%=!locale.equals(Locale.ENGLISH) ? Config.offerListIndex : Config.offerListIndexEn%>">
                            <li><a href="/into/offer_details?id=${offer.id}" class="fl">[<fmt:formatDate value='${offer.pushDate}' pattern='yyyy-MM-dd' type='date' dateStyle='long' />]${offer.positionIndexStr}[${offer.city}]</a><c:if test="${news.isNewPushDate()}"><img style="float:left; margin-top:8px;" src="/images/ico-new.jpg"></c:if></li>
                            </c:forEach> 
                    </ul>
                </div>
                <div style=" clear:both;"></div>
            </div>
            <!-- 三 排 end -->
            <!-- 四 排 -->
            <div class="Four-Row">
                <div class="Title">
                    <div class="Title-1"><fmt:message key="INDEX_活动风采" bundle="${bundle}"/></div>
                    <div class="Title-3"><a href="/team/style"><fmt:message key="INDEX_更多" bundle="${bundle}"/></a></div>
                </div>

                <!-- 产品滚动 -->
                <div class="rollBox">
                    <div class="Cont" id="ISL_Cont">
                        <div class="ScrCont">
                            <div id="List1">
                                <!-- 图片列表 begin -->
                                <%
                                    for (PlateInformation info : !locale.equals(Locale.ENGLISH) ? Config.homeStyle : Config.homeStyleEn) {
                                %>
                                <div class="pic"><a href="<%=info.getNavUrl()%>" target="_blank"><img src="<%=info.getPicUrl()%>" width="220" height="150"  /></a></div> 
                                        <%
                                            }
                                        %>
                                <!-- 图片列表 end -->
                            </div>
                            <div id="List2"></div>
                        </div>
                    </div>
                </div>
                <!-- 产品滚动 结束 -->        
            </div>
            <!-- 四 排 end -->
            <!-- 五 排 -->
            <div class="Five-Row" style="height: 174px;">
                <div class="Title"><img src="/images/partner.jpg"></div>
                <ul>
                    <li><img src="/ls/ls-11.jpg"><p><fmt:message key="INDEX_英国伯明翰大学土木工程学院" bundle="${bundle}"/></p></li>
                    <li><img src="/ls/ls-12.jpg"><p><fmt:message key="INDEX_上海交大" bundle="${bundle}"/></p></li>
                    <li><img src="/ls/ls-13.jpg"><p><fmt:message key="INDEX_北方交通大学" bundle="${bundle}"/></p></li>
                    <li><img src="/ls/ls-14.jpg"><p><fmt:message key="INDEX_同济大学经管学院" bundle="${bundle}"/></p></li>
                    <li><img src="/ls/ls-15.jpg"><p><fmt:message key="INDEX_重庆大学建规学院" bundle="${bundle}"/></p></li>
                    <li><img src="/ls/ls-16.jpg"><p><fmt:message key="INDEX_东南大学" bundle="${bundle}"/></p></li>
                    <li><img src="/ls/ls-17.jpg"><p><fmt:message key="INDEX_上海建科院" bundle="${bundle}"/></p></li>
                    <li><img src="/ls/ls-18.jpg"><p><fmt:message key="INDEX_精尚慧" bundle="${bundle}"/></p></li>
                </ul>
                <div style=" clear:both;"></div>
            </div>
        </div>
        <!-- 主体 end -->

        <jsp:include page="/WEB-INF/public/z_end.jsp"/>
        <script type="text/javascript">
            var contents = document.getElementsByClassName('content');
            var toggles = document.getElementsByClassName('title');

            var myAccordion = new fx.Accordion(
                toggles, contents, {opacity: true, duration: 400}
            );
            myAccordion.showThisHideOpen(contents[0]);
        </script>

        <script language="javascript" type="text/javascript">
            <!--//--><![CDATA[//><!--
        //图片滚动列表 5icool.org
            var Speed = 8; //速度(毫秒)
            var Space = 2; //每次移动(px)
            var PageWidth = 260; //翻页宽度
            var fill = 0; //整体移位
            var MoveLock = false;
            var MoveTimeObj;
            var Comp = 0;
            var AutoPlayObj = null;
            GetObj("List2").innerHTML = GetObj("List1").innerHTML;
            GetObj('ISL_Cont').scrollLeft = fill;
            GetObj("ISL_Cont").onmouseover = function () {
                clearInterval(AutoPlayObj);
            }
            GetObj("ISL_Cont").onmouseout = function () {
                AutoPlay();
            }
            AutoPlay();
            function GetObj(objName) {
                if (document.getElementById) {
                    return eval('document.getElementById("' + objName + '")')
                } else {
                    return eval('document.all.' + objName)
                }
            }
            function AutoPlay() { //自动滚动
                clearInterval(AutoPlayObj);
                AutoPlayObj = setInterval('ISL_GoDown();ISL_StopDown();', 3000); //间隔时间
            }
            function ISL_GoUp() { //上翻开始
                if (MoveLock)
                    return;
                clearInterval(AutoPlayObj);
                MoveLock = true;
                MoveTimeObj = setInterval('ISL_ScrUp();', Speed);
            }
            function ISL_StopUp() { //上翻停止
                clearInterval(MoveTimeObj);
                if (GetObj('ISL_Cont').scrollLeft % PageWidth - fill != 0) {
                    Comp = fill - (GetObj('ISL_Cont').scrollLeft % PageWidth);
                    CompScr();
                } else {
                    MoveLock = false;
                }
                AutoPlay();
            }
            function ISL_ScrUp() { //上翻动作
                if (GetObj('ISL_Cont').scrollLeft <= 0) {
                    GetObj('ISL_Cont').scrollLeft = GetObj('ISL_Cont').scrollLeft + GetObj('List1').offsetWidth
                }
                GetObj('ISL_Cont').scrollLeft -= Space;
            }
            function ISL_GoDown() { //下翻
                clearInterval(MoveTimeObj);
                if (MoveLock)
                    return;
                clearInterval(AutoPlayObj);
                MoveLock = true;
                ISL_ScrDown();
                MoveTimeObj = setInterval('ISL_ScrDown()', Speed);
            }
            function ISL_StopDown() { //下翻停止
                clearInterval(MoveTimeObj);
                if (GetObj('ISL_Cont').scrollLeft % PageWidth - fill != 0) {
                    Comp = PageWidth - GetObj('ISL_Cont').scrollLeft % PageWidth + fill;
                    CompScr();
                } else {
                    MoveLock = false;
                }
                AutoPlay();
            }
            function ISL_ScrDown() { //下翻动作
                if (GetObj('ISL_Cont').scrollLeft >= GetObj('List1').scrollWidth) {
                    GetObj('ISL_Cont').scrollLeft = GetObj('ISL_Cont').scrollLeft - GetObj('List1').scrollWidth;
                }
                GetObj('ISL_Cont').scrollLeft += Space;
            }
            function CompScr() {
                var num;
                if (Comp == 0) {
                    MoveLock = false;
                    return;
                }
                if (Comp < 0) { //上翻
                    if (Comp < -Space) {
                        Comp += Space;
                        num = Space;
                    } else {
                        num = -Comp;
                        Comp = 0;
                    }
                    GetObj('ISL_Cont').scrollLeft -= num;
                    setTimeout('CompScr()', Speed);
                } else { //下翻
                    if (Comp > Space) {
                        Comp -= Space;
                        num = Space;
                    } else {
                        num = Comp;
                        Comp = 0;
                    }
                    GetObj('ISL_Cont').scrollLeft += num;
                    setTimeout('CompScr()', Speed);
                }
            }
            //--><!]]>
        </script>
        <script>
            $(function () {
                $(".fixed_qr_close").click(function () {
                    $(".mod_qr").hide();
                })
            })
        </script>
    </body>
</html>
