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
                        <div class="title"><span><a id="title-span">职位详细信息</a></span></div>
                        <div class="con-single">
                            <div style="padding-left:40px;">
                                <strong>职位名称：</strong>&nbsp;&nbsp;${offer.position}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong>职位编码：</strong>&nbsp;&nbsp;${offer.code}<br>	
                                <strong>部门：</strong>&nbsp;&nbsp;${offer.depart}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong>发布日期：</strong>&nbsp;&nbsp;<fmt:formatDate value='${offer.pushDate}' pattern='yyyy-MM-dd' type='date' dateStyle='long' /><br>	
                                <strong>工作地区：</strong>&nbsp;&nbsp;${offer.city}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong>岗位类别：</strong>&nbsp;&nbsp;${offer.station} <br>
                                <strong>招聘人数：</strong>&nbsp;&nbsp;${offer.count}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong>月薪：</strong>&nbsp;&nbsp;${offer.monthly}<br>
                                <strong>职位描述：</strong><br>
                                ${offer.descriptionHtml}<br>
                                <strong>岗位职责：</strong><br>
                                ${offer.dutyHtml}<br>
                                <strong>任职资格：</strong><br>
                                ${offer.competenceHtml}<br>
                                <strong>职位要求：</strong><br>
                                <strong>年龄：</strong>&nbsp;&nbsp;${offer.age}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong>性别：</strong>&nbsp;&nbsp;${offer.gender}<br>
                                <strong>英语等级：</strong>&nbsp;&nbsp;${offer.englishLevel}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong>学历：</strong>&nbsp;&nbsp;${offer.education}
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
                        <div class="title"><span><a id="title-span">人才简历</a></span></div>
                        <div class="con-single">
                            <div style="padding-left:40px;">
                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td width="100"><strong>中文姓名：</strong></td>
                                        <td width="200">${offer.name}</td>
                                        <td width="100"><strong>英文名称：</strong></td>
                                        <td>${offer.enName}</td>
                                    </tr>
                                    <tr>
                                        <td width="100"><strong>手机：</strong></td>
                                        <td width="200">${offer.mobile}</td>
                                        <td width="100"><strong>E-MAIL：</strong></td>
                                        <td>${offer.email}</td>
                                    </tr>
                                    <tr>
                                        <td width="100"><strong>从来年限：</strong></td>
                                        <td width="200">${offer.obtain}年</td>
                                        <td width="100"><strong>目前就职公司</strong></td>
                                        <td>${offer.company}</td>
                                    </tr>
                                    <tr>
                                        <td width="100"><strong>居住地址：</strong></td>
                                        <td width="200">${offer.address}</td>
                                        <td width="100"><strong>邮编：</strong></td>
                                        <td>${offer.zipCode}</td>
                                    </tr>
                                    <tr>
                                        <td width="100"><strong>职务：</strong></td>
                                        <td width="200">${offer.position}</td>
                                        <td width="100"></td>
                                        <td></td>
                                    </tr>
                                </table>
                                <strong>岗位职责：</strong><br>
                                ${offer.dutyHtml}<br>
                                <strong>项目经验：</strong><br>
                                ${offer.descriptionHtml}<br>
                                <strong>简历：</strong><br>
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
