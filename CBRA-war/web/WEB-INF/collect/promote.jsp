<%-- 
    Document： 收款推广
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
            <c:when test="${fundCollection.type=='EVENT'}">
                <%@include file="/WEB-INF/collect/z_promote_event.jsp" %>
            </c:when>
            <c:otherwise>
                <c:if test="${not empty collect_success}">
                    <div class="successMessage">
                        <div class="sucess_title"> 
                            <c:choose>
                                <c:when test="${fundCollection.type == 'DONATION'}">
                                    <span style="font-weight:100">
                                        <fmt:message key="COLLECT_SEND_MSG_捐款链接已发出" bundle="${bundle}"/>
                                    </span>
                                    &nbsp;&nbsp;&nbsp;<fmt:message key="COLLECT_SEND_LABEL_RECIPENT" bundle="${bundle}"/>：${validCount}<fmt:message key="COLLECT_DETAIL_LABEL_人" bundle="${bundle}"/>
                                </c:when>
                                <c:otherwise>
                                    <span style="font-weight:100">
                                        <fmt:message key="COLLECT_SEND_MSG_SUCCESS" bundle="${bundle}"/>
                                    </span> 
                                    &nbsp;&nbsp;&nbsp;<fmt:message key="COLLECT_EDIT_LABEL_AMOUNT" bundle="${bundle}"/>：
                                    <fmt:formatNumber value="${fundCollection.unitAmount}" type="currency"  pattern="¤#,##0.##" currencySymbol="${fundCollection.currencySign}" />
                                    &nbsp;&nbsp;&nbsp;<fmt:message key="COLLECT_SEND_LABEL_RECIPENT" bundle="${bundle}"/>：${validCount}<fmt:message key="COLLECT_DETAIL_LABEL_人" bundle="${bundle}"/>
                                    &nbsp;&nbsp;&nbsp;<fmt:message key="COLLECT_SEND_LABEL_TOTAL_AMOUNT" bundle="${bundle}"/>：
                                    <fmt:formatNumber value="${validCount * fundCollection.unitAmount}" type="currency"  pattern="¤#,##0.##" currencySymbol="${fundCollection.currencySign}" />
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </c:if> 
                <div id="detail_promote" >
                    <%--<p class="MarginTop10 TextAlignRight"><a href="javascript:;" onclick="sendMore.open()"><fmt:message key="COLLECT_DETAIL_TEXT_向未付款人发付款提醒" bundle="${bundle}"/></a></p>--%>
                    <div class="active_box PaddingTB20">

                        <dl class="send_link_dl">
                            <dt><img src="/images/collection/invite_link.png" alt="" /></dt>
                            <dd><span><fmt:message key='COLLECT_SEND_TEXT1' bundle='${bundle}'/></span>

                                <span class="send_link_span">https://yoopay.cn/${fundCollection.getFundCollectionPayLinkVal()}/${fundCollection.webId}</span>
                            </dd>
                            <div class="clear"></div>
                        </dl>
                        <dl class="send_link_dl">
                            <dt><img src="/images/collection/logo.gif" alt="友付logo" /></dt>
                            <dd><span><fmt:message key='COLLECT_SEND_TEXT2' bundle='${bundle}'/></span>                
                                <form action="/collect/promote/${fundCollection.webId}" method="POST" id="collect_send" autocomplete="off">
                                    <span class="send_link_span2">
                                        <label>
                                            <textarea name="rawTargetInput" id="send_email" onfocus="Collect.sendEmailFocus();" class="send_link_textarea"><fmt:message key='COLLECT_SEND_LABEL_EMAIL_FORMAT' bundle='${bundle}'/></textarea>
                                        </label>                      
                                    </span>
                                    <input type="hidden" name="a" value="send" />
                                    <input type="hidden" name="webId" value="${fundCollection.webId}" />
                                    <span id="send_email_button" class="TextAlignRight" style="display: <c:if test="${empty postResult.singleErrorMsg && empty postResult.singleSuccessMsg}">none</c:if>">
                                        <label>
                                            <div class="noticeMessage" style="display:none">
                                                <div class="successMessage" style="display:none"></div>
                                                <div class="wrongMessage" style="display:none"></div>
                                                <div class="loadingMessage" style="display:none"><fmt:message key="GLOBAL_MSG_LOADING" bundle="${bundle}"/><img alt="" src="/images/032.gif"></div>
                                            </div>
                                            <div id="send_email_notice"></div> <input value="<fmt:message key='COLLECT_SEND_BUTTON_发送' bundle='${bundle}'/>" class="send_link_button collection_button " type="button" name="Submit" onclick="Collect.validateCollectSend('${fundCollection.webId}');"/>
                                        </label>
                                        <a href="/collect/promote_index/${fundCollection.webId}"><fmt:message key="COLLECT_EDIT_MSG_返回" bundle="${bundle}"/></a>
                                        <%--<a href="javascript:;" onclick="Collect.sendEmailCancle();return false;"><fmt:message key='GLOBAL_取消' bundle='${bundle}'/></a>--%>
                                        <div class="clear"></div>
                                    </span>
                                </form>
                            </dd>
                            <div class="clear"></div>
                        </dl>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>
<div id="promote_event_confirm_send" style="display:none"></div>
<%--向未付款人发付款提醒Dialog --%>
<div id="sendMoreSuccess" style="display:none" >
    <div id="sendMoreSuccessMessage"></div>
    <input  id="send_confirm" class="collection_button FloatRight" type="button" value="<fmt:message key='GLOBAL_确定' bundle='${bundle}'/>" onclick="sendMore.successClose();"/>
</div>  
<div id="sendMoreNotice" style="display: none">
    <form id="collect_sendmore" action="/collect/send/${fundCollection.webId}" method="post" style=" width:366px;">
        <input type="hidden" name="a" value="send_more"/>
        <input type="hidden" name="webId" value="${fundCollection.webId}" />
        <fmt:message key="COLLECT_DETAIL_POP_向以下邮箱发付款提示" bundle="${bundle}"/><br/>
        <textarea class="textareaAddPop MarginBottom5"  id="pop_sendmore_email"  name="rawTargetInput"></textarea><br/>
        <div class="TextAlignRight">
            <input  id="send_confirm" class="collection_button FloatRight" type="button" value="<fmt:message key='GLOBAL_确定' bundle='${bundle}'/>" onclick="Collect.validateCollectSendMore();"/>
            <span class="cancel">
                <span id="need_emails" style="color:red"></span>
                <a href="javascript:sendMore.close(); ">
                    <fmt:message key="GLOBAL_取消" bundle="${bundle}"/>
                </a>
            </span>
        </div>
    </form>
</div>
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
<%@include file="/WEB-INF/public/z_footer_close.html" %> 
