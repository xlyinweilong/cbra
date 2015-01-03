<%-- 
    手机短息推广
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@include file="/WEB-INF/collect/z_collect_public_action.jsp" %>

<jsp:include page="/WEB-INF/public/z_header.jsp"/>
<div class="BlueBox">
    <div class="BlueBoxTitle">
        <jsp:include page="/WEB-INF/collect/z_collect_header.jsp"/>
    </div>
    <div class="BlueBoxContent826">
        <div class="DetailHeader">
            <jsp:include page="/WEB-INF/collect/z_collect_menu.jsp">
                <jsp:param name="menuType" value="PROMOTE_INDEX"/>
            </jsp:include>
        </div>
        <c:choose>
            <c:when test="${not empty collect_success}">
                <%--发送成功页面--%>
                <div class="successMessage">
                    <div class="sucess_title"> 
                        <fmt:message key="COLLECT_EDIT_MSG_您的短信已经发送" bundle="${bundle}"/><br/>
                        <p class="Color333 text12 MarginTop10">
                        <fmt:message key="COLLECT_EDIT_MSG_您的X条推广短信已经发送请" bundle="${bundle}">
                            <fmt:param value="${validCount}"></fmt:param>
                        </fmt:message>
                        <a href="/collect/short_message_promote/${fundCollection.webId}"><fmt:message key="COLLECT_EDIT_MSG_返回" bundle="${bundle}"/></a>
                        </p>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <%--编辑页面--%>
                <dl class="dlEdit">
                    <dt>
                    <fmt:message key="COLLECT_EDIT_MSG_请编辑您的短信内容" bundle="${bundle}"/>
                    <div class="clear"></div>
                    </dt>
                </dl>
                <div  class="BlueBox_Gray">
                    <form id="short_message_promote" autocomplete="off" action="/collect/short_message_promote/${fundCollection.webId}" method="post">
                        <div class="promoteList"><input type="hidden" name="a" value="send_short_message" />
                            <input type="hidden" name="webId" value="${fundCollection.webId}" />
                            <input type="hidden" id="collect_promote_fund_collection_short_id" name="fundCollectionShortId" value="-1" />
                            <input type="hidden" id="collect_promote_fund_collection_short_test" <c:if test='${not empty fundCollectionPromotionShortMessage}'>value="-1"</c:if> <c:if test='${empty fundCollectionPromotionShortMessage}'>value="1"</c:if> />
                            <input type="hidden" id="collect_promote_fund_collection_short_phone" <c:if test='${not empty fundCollectionPromotionShortMessage}'>value="-1"</c:if> <c:if test='${empty fundCollectionPromotionShortMessage}'>value="1"</c:if> />
                            <div class="FloatLeft">
                                <span class="GreenColor"><fmt:message key="COLLECT_EDIT_MSG_请输入手机号码" bundle="${bundle}"/></span><br/>
                                <textarea name="mobilePhones" <c:if test="${empty fundCollectionPromotionShortMessage}">style="color:#999999;"</c:if> onfocus="CollectPromote.textareaOnfocus('promote_mobile_phones')"  id="promote_mobile_phones" class="textarea170_promote"><c:choose><c:when test="${not empty fundCollectionPromotionShortMessage}">${fundCollectionPromotionShortMessage.toList}</c:when><c:otherwise><fmt:message key="COLLECT_EDIT_MSG_输入手机号码,以逗号或换行分隔" bundle="${bundle}"/></c:otherwise></c:choose>
                                </textarea>
                            </div>

                            <div class="FloatRight">

                                <span class="GreenColor"><fmt:message key="COLLECT_EDIT_MSG_请编辑您的短信文字内容" bundle="${bundle}"/></span><br/>
                                <textarea name="shortMessageContent" onfocus="CollectPromote.textareaOnfocus('promote_short_message_content')" <c:if test="${empty fundCollectionPromotionShortMessage}">style="color:#999999;"</c:if> id="promote_short_message_content" class="textarea365_promote" onkeydown="CollectPromote.calculateShortMessageCount()" onchange="CollectPromote.calculateShortMessageCount()"><c:choose><c:when test="${not empty fundCollectionPromotionShortMessage}">${fundCollectionPromotionShortMessage.shotMessagelContent}</c:when><c:otherwise><fmt:message key="COLLECT_EDIT_MSG_输入短信内容" bundle="${bundle}"/></c:otherwise></c:choose>
                                </textarea><br/>
                                <span><strong id="short_message_count_promote"></strong><fmt:message key="COLLECT_EDIT_MSG_TEXT_文字内容后" bundle="${bundle}"/></span>
                            </div>
                            <div class="clear"></div>

                            <div  class="TextAlignRight LineHeight MarginTop20">
                                <a href="/collect/promote_index/${fundCollection.webId}"><fmt:message key="COLLECT_EDIT_MSG_返回" bundle="${bundle}"/></a>
                                <input type="button" onclick="CollectPromote.showConfirmSend('${fundCollection.webId}','mobile','confirm_send')" value="<fmt:message key='COLLECT_SEND_BUTTON_发送' bundle='${bundle}'/>" class="collection_button MarginL7 FloatRight"/>
                                <div class="noticeMessage FloatRight" style="display:none">
                                    <div class="successMessage" style="display:none"></div>
                                    <div class="wrongMessage" style="display:none"></div>
                                    <div class="loadingMessage" style="display:none"><fmt:message key="GLOBAL_MSG_LOADING" bundle="${bundle}"/><img alt="" src="/images/032.gif"></div>
                                </div>
                                <div class="clear"></div>
                            </div>
                        </div>
                    </form>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>
<div id="confirm_send" style="display:none"></div>
<jsp:include page="/WEB-INF/public/z_footer.jsp"/> 
<c:if test="${not empty postResult.singleErrorMsg}">
    <script type="text/javascript">   
        $(document).ready(function(){
            var wrongMessage='${postResult.singleErrorMsg}';
            if(wrongMessage!=''){
                MessageShow.showWrongMessage(wrongMessage);
            }
        });
    </script>
</c:if>
<script type="text/javascript">
    if($.trim($("#promote_short_message_content").val()) != ""){
        CollectPromote.calculateShortMessageCount();
    }
</script>       
<%@include file="/WEB-INF/public/z_footer_close.html" %> 