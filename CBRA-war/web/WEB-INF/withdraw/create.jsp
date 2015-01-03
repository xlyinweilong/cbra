<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%-- 
    Document   : payment_due_list
    Created on : Apr 10, 2011, 8:18:10 PM
    Author     : HUXIAOFENG
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    request.setAttribute("mainMenuSelection", cn.yoopay.web.support.MenuSelectionEnum.ACCOUNT);
    request.setAttribute("subMenuSelection", cn.yoopay.web.support.MenuSelectionEnum.FUNDWITHDRAW);
%>

<jsp:include page="/WEB-INF/public/z_header.jsp"/>
<jsp:include page="/WEB-INF/withdraw/z_tab_menu.jsp">
    <jsp:param name="menu_highlight" value="create"/>
</jsp:include>
<div class="BlueBox">  
    <div class="noticeMessage" style="display:none">
        <div class="successMessage" style="display:none"></div>
        <div class="wrongMessage" style="display:none" id="withdraw_wrong_msg_container"></div>
        <div class="loadingMessage" style="display:none"><fmt:message key="GLOBAL_MSG_LOADING" bundle="${bundle}"/><img alt="" src="/images/032.gif"></div>
    </div>
    <c:if test="${postResult.success||not empty noticeMsg}">
        <div class="successMessage Padding1020">
            <c:choose>
                <c:when test="${postResult.success}">
                    <fmt:message key="WITHDRAW_CREATE_MSG_提款请求已提交" bundle="${bundle}">
                        <fmt:param value="￥${orderWithdraw.amount}"/>
                        <fmt:param value="${orderWithdraw.withdrawAccount.name}"/>
                    </fmt:message>  
                </c:when>
                <c:when test="${not empty noticeMsg}">
                    ${noticeMsg}
                </c:when>
            </c:choose>
        </div>
    </c:if>

    <form action="/withdraw/create" method="POST" id="withdraw_edit">
        <input type="hidden" name="webId"value="${fundCollection.webId}" />
        <input type="hidden" name="a" value="create"/>
        <div class="BlueBoxContent">
            <%--Withdraw amount --%>
            <div class="sk-item MarginTop30 TextAlignLeft">
                <label class="sk-label"><fmt:message key="WITHDRAW_CREATE_LABEL_提款金额" bundle="${bundle}"/></label>
                <input type="text" name="amount" id="amount" class="Input200" onblur="Withdraw.validateWithdrawAmount();"/> <fmt:message key="WITHDRAW_CREATE_LABEL_元/人民币" bundle="${bundle}"/>
            </div>
            <%--Withdraw fee--%>
            <div id="service_fee_div" style="display:none">
                <div class="sk-item TextAlignLeft bold"><label class="sk-label"><fmt:message key="WITHDRAW_CREATE_LABEL_手续费" bundle="${bundle}"/></label>
                    <span class="MarginL7"><span id="service_fee_span">-￥<font id="service_fee"></font>&nbsp;</span>
                        <div id="upload_logo_tips" style="display: none;">
                            <div class="TextAlignRight"><img src="/images/collection/pop_06.gif" width="16" height="16" class="popclose"/></div>   
                            <div class="MarginTB5">
                                <fmt:message key="WITHDRAW_超出免费额度部分收X服务费，最低X元" bundle="${bundle}">
                                    <fmt:param value="${user.getWithdrawRatePercent()}"/>
                                    <fmt:param value="${minServiceFee}"/>
                                </fmt:message><br/>
                                <a href="/withdraw/rate" class="bold"><fmt:message key="WITHDRAW_MORE_DISCOUNT_更多优惠" bundle="${bundle}"/></a>
                            </div>                            
                        </div>
                    </span>
                </div>
                <div class="sk-item TextAlignLeft bold"><label class="sk-label"><fmt:message key="WITHDRAW_CREATE_LABEL_实际提款额" bundle="${bundle}"/></label><span class="MarginL7">￥<font id="actualAmount"></font></span></div>
            </div>
            <%--Withdraw account --%>
            <div class="sk-item TextAlignLeft">
                <label class="sk-label"><fmt:message key="WITHDRAW_CREATE_LABEL_提款到账户" bundle="${bundle}"/></label>
                <select name="withdrawAccount" id="withdrawAccount"class="Input450 create_select  FloatLeft"> 
                    <option value="-1"><fmt:message key="WITHDRAW_CREATE_LABEL_请选择" bundle="${bundle}"/></option>
                    <c:forEach var="withdrawAccount" items="${withdrawAccounts}">
                        <option value="${withdrawAccount.id}">${withdrawAccount.name}</option>
                    </c:forEach>
                </select>
                <span class="FloatRight TextAlignRight" style="width: 120px;"><a href="/withdraw/manager" title="">+<fmt:message key="WITHDRAW_CREATE_LINK_添加提款账户" bundle="${bundle}"/></a></span>
                <div class="clear"></div>
            </div>
            <div class="sk-item">  
                <c:choose>  
                    <c:when test="${user.verified}"> 
                        <input type="button" name="Submit" value="<fmt:message key='WITHDRAW_CREATE_BUTTON_提款' bundle='${bundle}'/>" class="collection_button" onclick="Withdraw.validateWithdrawCreate()"/>
                    </c:when>
                    <c:otherwise>
                        <input type="button" name="Submit" value="<fmt:message key='WITHDRAW_CREATE_BUTTON_提款' bundle='${bundle}'/>" class="collection_button" onclick="verifyDialog.open();"/>
                    </c:otherwise>
                </c:choose>                       
            </div>
        </div>
    </form> 
</div>	
<jsp:include page="/WEB-INF/public/z_footer.jsp"/>
<c:if test="${!user.verified}">
    <script type="text/javascript">
        window.onload = function() {
            verifyDialog.open();
        }
    </script>
</c:if>
<c:if test="${not empty postResult.singleErrorMsg}">
    <script>   
        $(document).ready(function(){
            var wrongMessage='${postResult.singleErrorMsg}';
            if(wrongMessage!=''){
                MessageShow.showWrongMessage(wrongMessage);
            }
        });
    </script>
</c:if>
<script type="text/javascript">
    $(document).ready(
    function(){
        //upload logo tooltip
        Withdraw.initToolTips();
    });   
</script>
<%@include file="/WEB-INF/public/z_footer_close.html" %> 
