<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<c:if test="${not empty collect_success}">
    <div class="successMessage">
        <div class="sucess_title"> 
            <span style="font-weight:100">
                <fmt:message key="COLLECT_EVENT_PROMOTE_MSG_SUCCESS" bundle="${bundle}"/>
            </span> 
        </div>
    </div>
</c:if> 
<div id="detail_promote" >
    <dl class="dlEdit">
        <dt>
        <fmt:message key="COLLECT_EVENT_EDIT_LABEL_通过友付发送邀请函" bundle="${bundle}"/>
        <%--span style="position: absolute; right: 0" ><a href="javascript:;" onclick="sendMore.open()"><fmt:message key="COLLECT_DETAIL_TEXT_向未付款人发付款提醒" bundle="${bundle}"/></a></span--%>
        <div class="clear"></div>

        </dt></dl>
    <div class="BlueBox_Gray">
        <form action="/collect/promote/${fundCollection.webId}" method="POST" id="collect_send" autocomplete="off">
            <div class="Padding1020">
                <div class="promote">
                    <label class="promoteLabel"><fmt:message key="COLLECT_EVENT_EDIT_LABEL_发件人" bundle="${bundle}"/></label><input type="text"name="fromName"id="fromName"value="<c:choose><c:when test="${empty fundCollectionPromotion}">${fundCollection.ownerUser.getDisplayName()}</c:when><c:otherwise>${fundCollectionPromotion.fromName}</c:otherwise></c:choose>"></div>
                <div class="promote">
                    <label class="promoteLabel"><fmt:message key="COLLECT_EVENT_EDIT_LABEL_回复邮箱" bundle="${bundle}"/></label><input type="text" name="replyToEmail"id="replyToEmail" value="<c:choose><c:when test="${empty fundCollectionPromotion}">${fundCollection.ownerUser.email}</c:when><c:otherwise>${fundCollectionPromotion.replyToEmail}</c:otherwise></c:choose>"></div>
                <div class="promote">
                    <label class="promoteLabel"><fmt:message key="COLLECT_EVENT_EDIT_LABEL_收件人" bundle="${bundle}"/></label> <span class="send_link_span2">
                        <label>
                            <textarea name="rawTargetInput" id="send_email" onfocus="Collect.sendEmailFocus();" class="send_link_textarea"><c:choose><c:when test="${not empty fundCollectionPromotion}">${fundCollectionPromotion.toList}</c:when><c:otherwise><fmt:message key='COLLECT_SEND_LABEL_EMAIL_FORMAT' bundle='${bundle}'/></c:otherwise></c:choose></textarea>
                        </label>                      
                    </span>
                </div>
                <div class="promote">
                    <label class="promoteLabel"><fmt:message key="COLLECT_EVENT_EDIT_LABEL_主题" bundle="${bundle}"/></label>
                    <input name="subject" id="subject"type="text" 
                           value="<c:choose><c:when test='${empty fundCollectionPromotion}'><fmt:message key='COLLECT_EVENT_EDIT_LABEL_主题开头' bundle='${bundle}'/>${eventStartDateYmdOnly}, ${fundCollection.title}</c:when><c:otherwise>${fundCollectionPromotion.subject}</c:otherwise></c:choose>"/>
                </div>

                <div class="promote">
                    <label class="promoteLabel"> <fmt:message key="COLLECT_EVENT_EDIT_LABEL_邮件内容" bundle="${bundle}"/></label>
                    <span id="email_save_span" style="display: none">
                        <a href="javascript:;" onclick="Collect.savePromoteEmail()"><fmt:message key="GLOBAL_保存" bundle="${bundle}"/></a>　
                        <a href="javascript:;" onclick="Collect.canclePromoteEmailSave()"><fmt:message key="GLOBAL_取消" bundle="${bundle}"/></a>
                    </span>
                    <span id="email_edit_span"><a href="javascript:;" onclick="Collect.showPromoteEmailEdit()"><fmt:message key="GLOBAL_编辑" bundle="${bundle}"/></a>
                    </span>
                </div>
                <div class="detail">
                    <h2>${fundCollection.title}</h2>
                    <div>
                        <div class="FloatLeft" style="width: 500px">
                            <p><fmt:message key="COLLECT_EVENT_EDIT_LABEL_时间" bundle="${bundle}"/>:&nbsp;&nbsp;${eventDateDesc}</p>
                            <p><fmt:message key="COLLECT_EVENT_EDIT_LABEL_地点" bundle="${bundle}"/>:
                            <c:choose>
                                <c:when test="${not empty fundCollection.eventLocation}">
                                    &nbsp;${fundCollection.eventLocation}
                                </c:when>
                                <c:otherwise>
                                    &nbsp;
                                </c:otherwise>
                            </c:choose>
                            </p>
                            <p><fmt:message key="PAYMENT_DETAIL_LABEL_主办方" bundle="${bundle}"/>:&nbsp;
                            <c:choose>
                                <c:when test="${fundCollection.eventHost != null}">
                                    ${fundCollection.eventHost}
                                </c:when>
                                <c:otherwise>
                                    ${fundCollection.ownerUser.getDisplayName()}
                                </c:otherwise>
                            </c:choose>
                            </p>
                        </div>
                        <div class="FloatRight" style="width: 80px">
                            <c:choose>
                                <c:when test="${not empty fundCollection.ownerUser.logoUrl}">
                                    <img src="${fundCollection.ownerUser.logoUrl}" width="80"/>
                                </c:when>
                            </c:choose>
                        </div>
                    </div>
                    <div class="clear"></div>
                </div>
                <div style="display: none" id="email_edit_div">
                    <textarea name="emailContent" id="email_content" style="width:782px;height: 300px" >
                        <c:choose>
                            <c:when test="${empty fundCollectionPromotion}">
                                ${fundCollection.detailDescHtml}
                            </c:when>
                            <c:otherwise>${fundCollectionPromotion.emailContent}</c:otherwise>
                        </c:choose>
                    </textarea>
                    <div class="clear"></div>
                </div>
                <div id="email_save_div" class="TextareaHtml detail"<c:if test="${empty fundCollection.detailDescHtml && empty fundCollectionPromotion.emailContent }">style="display: none"</c:if>>
                    <c:choose>
                        <c:when test="${empty fundCollectionPromotion}">${fundCollection.detailDescHtml}</c:when>
                        <c:otherwise>${fundCollectionPromotion.emailContent}</c:otherwise>
                    </c:choose>
                </div>
                <input type="hidden" name="a" value="send" />
                <input type="hidden" name="webId" id="webId" value="${fundCollection.webId}" />
                <input type="hidden" name="justSave" id="justSave" value=""/>
                <div id="send_email_button">

                    <div id="send_email_notice"></div> 
                    <div  class="TextAlignRight LineHeight MarginTop20">
                        <a href="/collect/promote_index/${fundCollection.webId}"><fmt:message key="COLLECT_EDIT_MSG_返回" bundle="${bundle}"/></a>
                        <input value="<fmt:message key='COLLECT_SEND_BUTTON_发送' bundle='${bundle}'/>" class="collection_button MarginL7 FloatRight" type="button" name="Submit" onclick="Collect.validateEventCollectSend('${fundCollection.webId}');"/>
                        <div class="noticeMessage FloatRight" style="display:none">
                            <div class="successMessage" style="display:none"></div>
                            <div class="wrongMessage" style="display:none"></div>
                            <div class="loadingMessage" style="display:none"><fmt:message key="GLOBAL_MSG_LOADING" bundle="${bundle}"/><img alt="" src="/images/032.gif"></div>
                        </div>
                        <div class="clear"></div>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>
<script>
    $(document).ready(function() {
        $.cleditor.defaultOptions.controls =//设置要显示的按钮
        "bold italic underline | size " +
            "style | color highlight | bullets numbering | " +
            " alignleft center alignright justify | " +
            " link unlink ";
        $.cleditor.defaultOptions.width=$("#email_content").width();
        $.cleditor.defaultOptions.height=$("#email_content").height();
        $("#email_content").cleditor();
    });
</script>