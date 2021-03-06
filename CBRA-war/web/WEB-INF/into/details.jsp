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
        <jsp:include page="/WEB-INF/into/z_into_banner.jsp"><jsp:param name="page" value="17" /></jsp:include>
            <!-- 主体 -->
            <div class="two-main">
                <!-- 详细信息 -->
                <div class="detailed">
                    <!-- 标题 -->
                    <div class="title">
                        <h1>${plateInfo.title}</h1>
                    <p><fmt:formatDate value='${plateInfo.pushDate}' pattern='yyyy-MM-dd HH:mm:ss' type='date' dateStyle='long' /><span>${plateInfo.visitCount}</span>人次浏览</p>
                </div>
                <!-- 信息 -->
                <div class="con-single">${plateInfo.plateInformationContent.content}</div>
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
                                <input type="hidden" name="plateInfoId" value="${plateInfo.id}" />
                                <input type="hidden" name="plateId" value="${plateInfo.plate.id}" />
                                <input type="hidden" name="forwardUrl" value="/into/details?id=${plateInfo.id}" />
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

