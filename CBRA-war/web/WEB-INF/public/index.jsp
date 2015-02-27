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

    </head>

    <body>
        <jsp:include page="/WEB-INF/public/z_top.jsp"></jsp:include>
            <!-- banner -->
            <div class="ly_bac">
                <div class="content-ba">
                    <div class="new_banner">
                        <ul class="rslides f426x240">
                        <%
                            for (PlateInformation info : Config.homeSAD) {
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
                        <div class="Title-1">关于筑誉</div>
                        <div class="Title-2"><a href="/account/signup">申请入会</a></div>
                        <div class="Title-3"><a href="/into/idea">更多</a></div>
                    </div>
                    <div class="Content">
                        <div class="img"><img style="width: 250px; height: 142px;" src="<%=Config.homeAbout.getPicUrl()%>"></div>
                        <p><%=Config.homeAbout.getIntroduction()%></p>
                    </div>
                </div>
                <!-- 近期活动 -->
                <div class="One-Row-fr">
                    <div class="Title">
                        <div class="Title-1">近期活动</div>
                        <div class="Title-3"><a href="#">更多</a></div>
                    </div>
                    <ul>
                        <li><a href="#">[01-02]筑誉联合会成立大会在陆家圆</a><img src="images/ico-bmz.png"></li>
                        <li><a href="#">[01-02]筑誉建筑联合会成立大会</a><img src="images/ico-bmz.png"></li>
                        <li><a href="#">[01-02]筑誉建筑联合会第二届理事会</a><img src="images/ico-bmz.png"></li>
                        <li><a href="#">[01-02]筑誉联合会成立大会在陆家嘴</a></li>
                        <li><a href="#">[01-02]筑誉建筑联合会成立大会...</a></li>
                    </ul>
                </div>
                <div style=" clear:both;"></div>
            </div>
            <!-- 一 排 end -->

            <!-- 广告条 -->
            <div class="ad-sx"><img  style="width: 1000px;" src="<%=Config.homeAd.getPicUrl()%>"></div>
            <!-- 广告条 end-->

            <!-- 二 排 -->
            <div class="Two-Row">

                <div class="Two-Row-fl">
                    <div class="Title">
                        <div class="Title-1">前沿领域资讯</div>
                        <div class="Title-3"><a href="/into/material">更多</a></div>
                    </div>

                    <div class="Content">
                        <div class="Modules">
                            <div class="img"><img src="/ls/ls-3.jpg"></div>
                            <div class="xxys">
                                <h1>新材料新技术</h1>
                                <ul>
                                    <c:forEach var="info" items="<%=Config.industryList%>">
                                        <li><a href="/into/details?id=${info.id}">${info.titleIndexStr}</a></li>
                                    </c:forEach>
                                </ul>
                            </div>
                        </div>
                        <div class="Modules">
                            <div class="img"><img src="/ls/ls-4.jpg"></div>
                            <div class="xxys">
                                <h1>建筑产业化</h1>
                                <ul>
                                    <c:forEach var="info" items="<%=Config.industrializationListIndex%>">
                                        <li><a href="/into/details?id=${info.id}">${info.titleIndexStr}</a></li>
                                    </c:forEach>
                                </ul>
                            </div>
                        </div>
                        <div class="Modules">
                            <div class="img"><img src="/ls/ls-5.jpg"></div>
                            <div class="xxys">
                                <h1>绿色建筑</h1>
                                <ul>
                                    <c:forEach var="info" items="<%=Config.greenListIndex%>">
                                        <li><a href="/into/details?id=${info.id}">${info.titleIndexStr}</a></li>
                                    </c:forEach>
                                </ul>
                            </div>
                        </div>
                        <div class="Modules">
                            <div class="img"><img src="/ls/ls-6.jpg"></div>
                            <div class="xxys">
                                <h1>BIM技术</h1>
                                <ul>
                                    <c:forEach var="info" items="<%=Config.bimListIndex%>">
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
                        <div class="Title-1">专家顾问</div>
                        <div class="Title-3"><a href="/train/lecturers">更多</a></div>
                    </div>
                    <ul>
                        <%
                            int i = 0;
                            for (PlateInformation info : Config.homeExpert) {
                                i++;
                                %>
                                <li <%if(i==2 || i == 5){%>class="m-lr"<%}%>><a  href="<%=info.getNavUrl()%>"><img src="<%=info.getPicUrl()%>" width="88" height="88" /></a></li>
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
                        <div class="Title-1">热点新闻</div>
                        <div class="Title-3"><a href="/news/news_list">更多</a></div>
                    </div>
                    <div class="Content">
                        <div class="img"><img src="/ls/ls-1.jpg"></div>
                        <ul>
                            <c:forEach var="news" items="<%=Config.newsList5%>">
                                <li><a href="/news/news_list?id=${news.id}" class="fl">[<fmt:formatDate value='${news.pushDate}' pattern='yyyy-MM-dd' type='date' dateStyle='long' />]${news.titleIndexStr}</a><c:if test="${news.isNewPushDate()}"><img style="float:left; margin-top:8px;" src="/images/ico-new.jpg"></c:if></li>
                            </c:forEach>
                        </ul>
                    </div>
                </div>
                <!-- 企业人才需求 -->
                <div class="One-Row-fr">
                    <div class="Title">
                        <div class="Title-1">企业人才需求</div>
                        <div class="Title-3"><a href="/into/three_party_offer">更多</a></div>
                    </div>
                    <ul>
                        <c:forEach var="offer" items="<%=Config.offerListIndex%>">
                            <li><a href="/into/offer_details?id=${offer.id}" class="fl">[<fmt:formatDate value='${offer.pushDate}' pattern='yyyy-MM-dd' type='date' dateStyle='long' />]${offer.positionIndexStr}</a><c:if test="${news.isNewPushDate()}"><img style="float:left; margin-top:8px;" src="/images/ico-new.jpg"></c:if></li>
                        </c:forEach> 
                    </ul>
                </div>
                <div style=" clear:both;"></div>
            </div>
            <!-- 三 排 end -->
            <!-- 四 排 -->
            <div class="Four-Row">
                <div class="Title">
                    <div class="Title-1">会员风采</div>
                    <div class="Title-3"><a href="/team/style">更多</a></div>
                </div>

                <!-- 产品滚动 -->
                <div class="rollBox">
                    <div class="Cont" id="ISL_Cont">
                        <div class="ScrCont">
                            <div id="List1">
                                <!-- 图片列表 begin -->
                                <%
                                     for (PlateInformation info : Config.homeExpert) {
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
            <div class="Five-Row">
                <div class="Title"><img src="/images/partner.jpg"></div>
                <ul>
                    <li><img src="/ls/ls-11.jpg"><p>英国伯明翰大学<br>土木工程学院</p></li>
                    <li><img src="/ls/ls-12.jpg"><p>上海交大</p></li>
                    <li><img src="/ls/ls-13.jpg"><p>北方交通大学</p></li>
                    <li><img src="/ls/ls-14.jpg"><p>同济大学经管学院</p></li>
                    <li><img src="/ls/ls-15.jpg"><p>重庆大学建规学院</p></li>
                    <li><img src="/ls/ls-16.jpg"><p>东南大学</p></li>
                    <li><img src="/ls/ls-17.jpg"><p>上海建科院</p></li>
                    <li><img src="/ls/ls-18.jpg"><p>精尚慧</p></li>
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
            var Speed = 5; //速度(毫秒)
            var Space = 5; //每次移动(px)
            var PageWidth = 1040; //翻页宽度
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
    </body>
</html>
