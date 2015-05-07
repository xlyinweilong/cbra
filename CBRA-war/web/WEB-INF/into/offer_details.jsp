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
        <jsp:include page="/WEB-INF/into/z_into_banner.jsp"><jsp:param name="page" value="8" /></jsp:include>
            <!-- 主体 -->
            <div class="two-main">
                <!-- 左侧导航 -->
            <c:if test="${offer.plate.id == 30}"><jsp:include page="/WEB-INF/into/z_left.jsp"><jsp:param name="page" value="7" /></jsp:include></c:if>
            <c:if test="${offer.plate.id == 31}"><jsp:include page="/WEB-INF/into/z_left.jsp"><jsp:param name="page" value="8" /></jsp:include></c:if>
                <!-- 左侧导航 end -->
                <!-- 右侧内容 -->
                <c:if test="${offer.plate.id == 30}">
                    <div class="fr-con">
                        <div class="title"><span><a id="title-span"><fmt:message key="GLOBAL_职位详细信息" bundle="${bundle}"/></a></span></div>
                        <div class="con-single">
                            <div style="padding-left:40px;">
                                <strong><fmt:message key="GLOBAL_职位名称" bundle="${bundle}"/>：</strong>&nbsp;&nbsp;${offer.position}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong><fmt:message key="GLOBAL_职位编码" bundle="${bundle}"/>：</strong>&nbsp;&nbsp;${offer.code}<br>	
                                <strong><fmt:message key="GLOBAL_部门" bundle="${bundle}"/>：</strong>&nbsp;&nbsp;${offer.depart}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong><fmt:message key="GLOBAL_发布日期" bundle="${bundle}"/>：</strong>&nbsp;&nbsp;<fmt:formatDate value='${offer.pushDate}' pattern='yyyy-MM-dd' type='date' dateStyle='long' /><br>	
                                <strong><fmt:message key="GLOBAL_工作地区" bundle="${bundle}"/>：</strong>&nbsp;&nbsp;${offer.city}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong><fmt:message key="GLOBAL_岗位类别" bundle="${bundle}"/>：</strong>&nbsp;&nbsp;${offer.station} <br>
                                <strong><fmt:message key="GLOBAL_招聘人数" bundle="${bundle}"/>：</strong>&nbsp;&nbsp;${offer.count}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong><fmt:message key="GLOBAL_月薪" bundle="${bundle}"/>：</strong>&nbsp;&nbsp;${offer.monthly}<br>
                                <strong><fmt:message key="GLOBAL_职位描述" bundle="${bundle}"/>：</strong><br>
                                ${offer.descriptionHtml}<br>
                                <strong><fmt:message key="GLOBAL_岗位职责" bundle="${bundle}"/>：</strong><br>
                                ${offer.dutyHtml}<br>
                                <strong><fmt:message key="GLOBAL_任职资格" bundle="${bundle}"/>：</strong><br>
                                ${offer.competenceHtml}<br>
                                <strong><fmt:message key="GLOBAL_职位要求" bundle="${bundle}"/>：</strong><br>
                                <strong><fmt:message key="GLOBAL_年龄" bundle="${bundle}"/>：</strong>&nbsp;&nbsp;${offer.age}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong>性别：</strong>&nbsp;&nbsp;${offer.gender}<br>
                                <strong><fmt:message key="GLOBAL_英语等级" bundle="${bundle}"/>：</strong>&nbsp;&nbsp;${offer.englishLevel}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong>学历：</strong>&nbsp;&nbsp;${offer.education}
                                <div class="fenxiang">
                                    <div class="bshare-custom "><a title="分享到QQ空间" class="bshare-qzone"></a><a title="分享到新浪微博" class="bshare-sinaminiblog"></a><a title="分享到人人网" class="bshare-renren"></a><a title="分享到腾讯微博" class="bshare-qqmb"></a><a title="分享到网易微博" class="bshare-neteasemb"></a><a title="更多平台" class="bshare-more bshare-more-icon more-style-addthis"></a><span class="BSHARE_COUNT bshare-share-count">0</span></div>
                                </div>
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
                                                <input type="hidden" name="offerId" value="${offer.id}" />
                                                <input type="hidden" name="plateId" value="${offer.plate.id}" />
                                                <input type="hidden" name="forwardUrl" value="/into/offer_details?id=${offer.id}" />
                                                <div class="review-k">
                                                    <textarea id="content" name="content" class="rev-k"></textarea>
                                                    <input type="button" id="message_button" class="rev-an" value="评论" />
                                                </div>
                                            </form>
                                        </c:if>
                                    </div>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </c:if>
                <c:if test="${offer.plate.id == 31}">
                    <div class="fr-con">
                        <div class="title"><span><a id="title-span"><fmt:message key="GLOBAL_人才简历" bundle="${bundle}"/></a></span></div>
                        <div class="con-single">
                            <div style="padding-left:40px;">
                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td width="100"><strong><fmt:message key="GLOBAL_中文姓名" bundle="${bundle}"/>：</strong></td>
                                        <td width="200">${offer.name}</td>
                                        <td width="100"><strong><fmt:message key="GLOBAL_英文名称" bundle="${bundle}"/>：</strong></td>
                                        <td>${offer.enName}</td>
                                    </tr>
                                    <tr>
                                        <td width="100"><strong><fmt:message key="GLOBAL_手机" bundle="${bundle}"/>：</strong></td>
                                        <td width="200">${offer.mobile}</td>
                                        <td width="100"><strong>E-MAIL：</strong></td>
                                        <td>${offer.email}</td>
                                    </tr>
                                    <tr>
                                        <td width="100"><strong><fmt:message key="GLOBAL_从业年限" bundle="${bundle}"/>：</strong></td>
                                        <td width="200">${offer.obtain}<fmt:message key="GLOBAL_年" bundle="${bundle}"/>年</td>
                                        <td width="100"><strong><fmt:message key="GLOBAL_目前就职公司" bundle="${bundle}"/></strong></td>
                                        <td>${offer.company}</td>
                                    </tr>
                                    <tr>
                                        <td width="100"><strong><fmt:message key="GLOBAL_居住地址" bundle="${bundle}"/>：</strong></td>
                                        <td width="200">${offer.address}</td>
                                        <td width="100"><strong><fmt:message key="GLOBAL_邮编" bundle="${bundle}"/>：</strong></td>
                                        <td>${offer.zipCode}</td>
                                    </tr>
                                    <tr>
                                        <td width="100"><strong><fmt:message key="GLOBAL_职务" bundle="${bundle}"/>：</strong></td>
                                        <td width="200">${offer.position}</td>
                                        <td width="100"></td>
                                        <td></td>
                                    </tr>
                                </table>
                                <strong><fmt:message key="GLOBAL_岗位职责" bundle="${bundle}"/>：</strong><br>
                                ${offer.dutyHtml}<br>
                                <strong><fmt:message key="GLOBAL_项目经验" bundle="${bundle}"/>：</strong><br>
                                ${offer.descriptionHtml}<br>
                                <strong><fmt:message key="GLOBAL_简历" bundle="${bundle}"/>：</strong><br>
                                ${offer.competenceHtml}<br>
                                <div class="fenxiang">
                                    <div class="bshare-custom "><a title="分享到QQ空间" class="bshare-qzone"></a><a title="分享到新浪微博" class="bshare-sinaminiblog"></a><a title="分享到人人网" class="bshare-renren"></a><a title="分享到腾讯微博" class="bshare-qqmb"></a><a title="分享到网易微博" class="bshare-neteasemb"></a><a title="更多平台" class="bshare-more bshare-more-icon more-style-addthis"></a><span class="BSHARE_COUNT bshare-share-count">0</span></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:if>
                <!-- 右侧内容 end -->
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
