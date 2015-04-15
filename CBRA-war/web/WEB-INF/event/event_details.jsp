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
            <!-- 主体 -->
            <div class="two-main">
                <!-- 详细信息 -->
                <div class="hd-detailed">
                    <!-- 标题 -->
                    <h1>${fundCollection.title}</h1>
                    <p id="juhong"><strong>活动状态：</strong>${fundCollection.status}</p>
                    <p><strong>活动时间：</strong><fmt:formatDate value='${fundCollection.eventBeginDate}' pattern='yyyy-MM-dd HH:mm' type='date' dateStyle='long' /> -- <fmt:formatDate value='${fundCollection.eventEndDate}' pattern='yyyy-MM-dd HH:mm' type='date' dateStyle='long' /></p>
                    <p><strong>签到时间：</strong><fmt:formatDate value='${fundCollection.checkinDate}' pattern='yyyy-MM-dd HH:mm' type='date' dateStyle='long' /></p>
                    <p><strong>活动地点：</strong>${fundCollection.eventLocation}</p>
                    <p><strong>活动人员：</strong>${fundCollection.allowAttendee.mean}</p>
                    <p><strong>活动费用：</strong>企业会员：<c:if test="${fundCollection.eachCompanyFreeCount > 0}">免费${fundCollection.eachCompanyFreeCount}人 , </c:if>${fundCollection.companyPrice}元/人　　个人会员：每人${fundCollection.userPrice}元/人　　非会员：${fundCollection.touristPrice}元/人</p>
                    <c:if test="${isSignUpEvent  && fundCollection.status=='报名中'}">
                    <p><input style="margin-left: 550px;" type="button" class="rev-an" id="sign_up_button" value="报名" onclick="location.href = '/order/sign_up_event?id=${fundCollection.id}'"></p>
                    </c:if>
                    <p><strong>活动内容介绍：</strong></p>
                    <p style=" line-height:32px; color:#666;">
                        ${fundCollection.detailDescHtml}
                    </p>
                    <!-- 分享 -->
                    <div class="bshare-custom Share"><a title="分享到QQ空间" class="bshare-qzone"></a><a title="分享到新浪微博" class="bshare-sinaminiblog"></a><a title="分享到人人网" class="bshare-renren"></a><a title="分享到腾讯微博" class="bshare-qqmb"></a><a title="分享到网易微博" class="bshare-neteasemb"></a><a title="更多平台" class="bshare-more bshare-more-icon more-style-addthis"></a><span class="BSHARE_COUNT bshare-share-count">0</span></div>
                    <!-- 评论 -->
                <c:if test="${plateAuth == 'ONLY_VIEW' || plateAuth == 'VIEW_AND_REPAY'}">
                    <div class="review">
                        <p class="p1">最新评论 (共${messageList.size()}条)</p>
                        <!-- 评论内容 -->
                        <c:forEach var="message" items="${messageList}">
                            <div class="review-xx">
                                <div class="img"><img src="<c:choose><c:when test="${message.account == null}">/ls/ls-21.jpg</c:when><c:otherwise>${message.account.headImageUrlWithDefault}</c:otherwise></c:choose>"></div>
                                        <div class="con">
                                                <p class="p2"><span class="span-1">${message.userName}</span><span class="span-2"><fmt:formatDate value='${message.createDate}' pattern='yyyy-MM-dd HH:mm:ss' type='date' dateStyle='long' /></span></p><div style="clear:both;"></div>
                                    <p class="p3">
                                        ${message.content}
                                    </p>
                                    <c:forEach var="sub" items="${message.messageList}">
                                        <div class="review-xx-hf">
                                            <div class="img"><img src="/ls/ls-22.jpg"></div>
                                            <div class="con">
                                                <p class="p2"><span class="span-1">管理员</span><span class="span-2"><fmt:formatDate value='${sub.createDate}' pattern='yyyy-MM-dd HH:mm:ss' type='date' dateStyle='long' /></span></p><div style="clear:both;"></div>
                                                <p class="p3">${sub.content}</p>
                                            </div>
                                            <div style="clear:both;"></div>
                                        </div>
                                        <p class="p4">回复</p>
                                    </c:forEach>
                                </div>
                                <div style="clear:both;"></div>
                            </div>
                        </c:forEach>
                        <!-- 评论内容 end -->
                        <c:if test="${plateAuth == 'VIEW_AND_REPAY'}">
                            <form id="message_form" action="/message/send_message" method="post">
                                <input type="hidden" name="a" value="SEND_MESSAGE" />
                                <input type="hidden" name="fundCollectionId" value="${fundCollection.id}" />
                                <input type="hidden" name="plateId" value="${fundCollection.plate.id}" />
                                <input type="hidden" name="forwardUrl" value="/event/event_details?id=${fundCollection.id}" />
                                <div class="review-k">
                                    <textarea id="content" name="content" class="rev-k"></textarea>
                                    <input type="button" id="message_button" class="rev-an" value="评论" />
                                </div>
                            </form>
                        </c:if>
                    </div>
                </c:if>
            </div>
            <div class="news-fr">
                <div class="ad-fr"><img src="/ls/ls-20.jpg"></div>
                <h1><fmt:message key="GLOBAL_热门点击" bundle="${bundle}"/></h1>
                <div class="top-hits">
                    <ul>
                            <c:forEach var="event" items="${hotEventList}">
                            <li><a target="_blank" href="/event/event_details?id=${event.id}">${event.titleIndexStr3}</a></li>
                            </c:forEach>
                    </ul>
                </div>
            </div>
            <div style="clear:both;"></div>
        </div>
        <!-- 主体 end -->
        <jsp:include page="/WEB-INF/public/z_end.jsp"/>
        <script type="text/javascript" charset="utf-8" src="http://static.bshare.cn/b/buttonLite.js#style=-1&amp;uuid=&amp;pophcol=2&amp;lang=zh"></script>
        <script type="text/javascript" charset="utf-8" src="http://static.bshare.cn/b/bshareC0.js"></script>
        <script type="text/javascript">
            $(document).ready(function () {
                $("#message_button").click(function () {
                    if (CBRAValid.checkFormValueNull($("#content"))) {
                        alert("请输入评论内容");
                        return;
                    }
                    $("#message_form").submit();
                });
            })
        </script>
    </body>
</html>
