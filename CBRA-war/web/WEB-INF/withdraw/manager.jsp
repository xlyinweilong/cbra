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
    <jsp:param name="menu_highlight" value="manager"/>
</jsp:include>
<div class="BlueBox">
    <div class="noticeMessage" style="display:none">
        <div class="successMessage" style="display:none"></div>
        <div class="wrongMessage" style="display:none"></div>
        <div class="loadingMessage" style="display:none"><fmt:message key="GLOBAL_MSG_LOADING" bundle="${bundle}"/><img alt="" src="/images/032.gif"></div>
    </div>
    <div class="BlueBoxContent">
        <form action="/withdraw/manager" method="POST" id="withdraw_account_create">
            <input type="hidden" name="a" value="create_withdraw_account"/>
            <input type="hidden" name="accountId" value="${withdrawAccount.id}"/>
            <div class="sk-item MarginTop30 TextAlignLeft ">
                <label class="sk-label fontgreen"><fmt:message key="WITHDRAW_ACCOUNT_LABEL_类别" bundle="${bundle}"/></label>
                <select name="type" id="withdraw_account_type" class="create_select  shortInput">    
                    <option value="BANK" <c:if test="${type=='BANK'||empty type}">selected="selected"</c:if>><fmt:message key="WITHDRAW_ACCOUNT_LABEL_银行账户" bundle="${bundle}"/></option>
                    <option value="INT_BANK" <c:if test="${type=='INT_BANK'}">selected="selected"</c:if>><fmt:message key="WITHDRAW_ACCOUNT_LABEL_国外银行" bundle="${bundle}"/></option>  
                    <option value="ALIPAY" <c:if test="${type=='ALIPAY'}">selected="selected"</c:if>><fmt:message key="WITHDRAW_ACCOUNT_LABEL_支付宝账户" bundle="${bundle}"/></option>
                    <option value="CREDITCARD"<c:if test="${type=='CREDITCARD'}">selected="selected"</c:if>><fmt:message key="WITHDRAW_ACCOUNT_LABEL_信用卡账户" bundle="${bundle}"/></option>
                    <option value="PAYPAL"<c:if test="${type=='PAYPAL'}">selected="selected"</c:if>><fmt:message key="WITHDRAW_ACCOUNT_LABEL_Paypal账户" bundle="${bundle}"/></option>
                </select> 
            </div>
            <div class="sk-item">
                <label class="sk-label fontgreen"><fmt:message key="WITHDRAW_ACCOUNT_LABEL_名称" bundle="${bundle}"/></label>
                <input type="text" name="name" class="Input450" id="name"
                       <c:choose>
                           <c:when test="${not empty withdrawAccount}">value="${withdrawAccount.name}"</c:when>
                           <c:otherwise>value="<fmt:message key='WITHDRAW_ACCOUNT_MSG_请给这个账户加个标签' bundle='${bundle}'/>" onfocus="$(this).val('')"</c:otherwise>
                       </c:choose>/>
            </div>
            <div id="bank_div" style="display:none">
                <div class="sk-item">
                    <label class="sk-label fontgreen"><fmt:message key="WITHDRAW_ACCOUNT_LABEL_姓名" bundle="${bundle}"/></label>
                    <input type="text" name="bank_user_name" class="Input450" id="bank_holder_name" value="${withdrawAccount.bankUserName}"/><em>${postResult.errorMsgs['bank_user_name']}</em>
                </div>
                <div class="sk-item">
                    <label class="sk-label fontgreen"><fmt:message key="WITHDRAW_ACCOUNT_LABEL_银行名称" bundle="${bundle}"/></label>
                    <input type="text" name="bank_name" class="Input450" value="${withdrawAccount.bankName}"/><em>${postResult.errorMsgs['bank_name']}</em>
                </div>
                <div class="sk-item">
                    <label class="sk-label fontgreen"><fmt:message key="WITHDRAW_ACCOUNT_LABEL_支行名称" bundle="${bundle}"/></label>
                    <input type="text" name="bank_branch" class="Input450" value="${withdrawAccount.bankBranch}"/><em>${postResult.errorMsgs['bank_branch']}</em>
                </div>
                <div class="sk-item">
                    <label class="sk-label fontgreen"><fmt:message key="WITHDRAW_ACCOUNT_LABEL_银行账号" bundle="${bundle}"/></label>
                    <input type="text" name="bank_account_number" name="bank_account_number" class="Input450" value="${withdrawAccount.bankAccountNumber}"/><em>${postResult.errorMsgs['bank_account_number']}</em>
                </div> 
            </div>
            <div id="int_bank_div" style="display:none">
                <div class="sk-item">
                    <label class="sk-label fontgreen"><fmt:message key="WITHDRAW_ACCOUNT_LABEL_INT_BANK_账户名称" bundle="${bundle}"/></label>
                    <input type="text" name="int_bank_user_name" class="Input450" id="bank_holder_name" value="${withdrawAccount.intBankUserName}"/><em>${postResult.errorMsgs['bank_user_name']}</em>
                </div>
                <div class="sk-item">
                    <label class="sk-label fontgreen"><fmt:message key="WITHDRAW_ACCOUNT_LABEL_INT_BANK_开户人地址" bundle="${bundle}"/></label>
                    <input type="text" name="int_bank_user_address" class="Input450" value="${withdrawAccount.intBankUserAddress}"/><em>${postResult.errorMsgs['bank_name']}</em>
                </div>
                <div class="sk-item">
                    <label class="sk-label fontgreen"><fmt:message key="WITHDRAW_ACCOUNT_LABEL_INT_BANK_开户行" bundle="${bundle}"/></label>
                    <input type="text" name="int_bank_name" class="Input450" value="${withdrawAccount.intBankName}"/><em>${postResult.errorMsgs['bank_branch']}</em>
                </div>
                <div class="sk-item">
                    <label class="sk-label fontgreen"><fmt:message key="WITHDRAW_ACCOUNT_LABEL_INT_BANK_账户号码" bundle="${bundle}"/></label>
                    <input type="text" name="int_bank_account_number" name="bank_account_number" class="Input450" value="${withdrawAccount.intBankAccountNumber}"/><em>${postResult.errorMsgs['bank_account_number']}</em>
                </div> 
                <div class="sk-item">
                    <label class="sk-label fontgreen"><fmt:message key="WITHDRAW_ACCOUNT_LABEL_INT_BANK_开户行地址" bundle="${bundle}"/></label>
                    <input type="text" name="int_bank_address"  class="Input450" value="${withdrawAccount.intBankAddress}"/><em>${postResult.errorMsgs['bank_account_number']}</em>
                </div> 
                <div class="sk-item">
                    <label class="sk-label fontgreen"><fmt:message key="WITHDRAW_ACCOUNT_LABEL_INT_BANK_TransitNumber" bundle="${bundle}"/></label>
                    <input type="text" name="int_bank_transit_number" class="Input450" value="${withdrawAccount.intBankTransitNumber}"/><em>${postResult.errorMsgs['bank_account_number']}</em>
                </div> 
                <div class="sk-item">
                    <label class="sk-label fontgreen"><fmt:message key="WITHDRAW_ACCOUNT_LABEL_INT_BANK_SWIFT_code" bundle="${bundle}"/></label>
                    <input type="text" name="int_bank_swift_code" name="int_bank_swift_code" class="Input450" value="${withdrawAccount.intBankSwiftCode}"/><em>${postResult.errorMsgs['bank_account_number']}</em>
                </div> 
            </div>
            <div id="credit_card_div" style="display:none">
                <%--
                <div class="sk-item">
                    <label class="sk-label fontgreen"><fmt:message key="WITHDRAW_ACCOUNT_LABEL_类别" bundle="${bundle}"/></label>
                    <select name="credit_card_type" class="create_select FloatLeft" style=" margin-left:8px">
                        <option value="VISA"<c:if test="${withdrawAccount.creditCardType=='VISA'||empty creditCardType}">selected="selected"</c:if>>VISA</option>
                        <option value="MASTERCARD" <c:if test="${withdrawAccount.creditCardType=='MASTERCARD'}">selected="selected"</c:if>>MASTERCARD</option>                                    
                        </select>
                        <div class="clear"></div>
                    </div>
                --%>
                <div class="sk-item">
                    <label class="sk-label fontgreen"><fmt:message key="WITHDRAW_ACCOUNT_LABEL_CREDIT_CARD_卡上姓名" bundle="${bundle}"/></label>
                    <input type="text" name="credit_card_holder_name" class="Input450" value="${withdrawAccount.creditCardHolder}"/>
                </div>
                <div class="sk-item">
                    <label class="sk-label fontgreen"><fmt:message key="WITHDRAW_ACCOUNT_LABEL_CREDIT_CARD_开户行名称" bundle="${bundle}"/></label>
                    <input type="text" name="credit_card_bank_name" class="Input450" value="${withdrawAccount.creditCardBankName}"/>
                </div>
                <div class="sk-item">
                    <label class="sk-label fontgreen"><fmt:message key="WITHDRAW_ACCOUNT_LABEL_CREDIT_CARD_支行名称" bundle="${bundle}"/></label>
                    <input type="text" name="credit_card_bank_branch" class="Input450" value="${withdrawAccount.creditCardBankBranch}"/>
                </div>
                <div class="sk-item">
                    <label class="sk-label fontgreen"><fmt:message key="WITHDRAW_ACCOUNT_LABEL_卡号" bundle="${bundle}"/></label>
                    <input type="text" name="credit_card_number" class="Input450" value="${withdrawAccount.creditCardNumber}"/>
                </div>               
            </div>
            <div id="alipay_div" style="display:none">
                <div class="sk-item">
                    <label class="sk-label fontgreen"><fmt:message key="WITHDRAW_ACCOUNT_LABEL_支付宝账户" bundle="${bundle}"/></label>
                    <input type="text" name="email" class="Input450" value="${withdrawAccount.alipayAccount}"/>
                </div>               
            </div>
            <div id="paypal_div" style="display:none">
                <div class="sk-item">
                    <label class="sk-label fontgreen"><fmt:message key="WITHDRAW_ACCOUNT_LABEL_Paypal账户" bundle="${bundle}"/></label>
                    <input type="text" name="paypal" class="Input450" value="${withdrawAccount.payPalAccount}"/>
                </div>
            </div>
            <%-- <div class="edit_div">             

                <span class="growlink">
                    <label>
                        <input type="button" name="Submit"  value="保存"  class="collection_button" onclick="Withdraw.validateWithdrawAccountCreate();"/>
                    </label>
                </span>
                <div class="clear"></div>           
            </div>--%>
            <div class="sk-item">
                <label class="sk-label"></label>
                <input type="button" name="Submit"  value="<fmt:message key='WITHDRAW_ACCOUNT_BUTTON_保存' bundle='${bundle}'/>"  class="collection_button" onclick="Withdraw.validateWithdrawAccountCreate();"/>
            </div>
        </form>
    </div>
</div>	

<jsp:include page="/WEB-INF/public/z_footer.jsp"/> 

<script>       
    $(document).ready(function(){
        Withdraw.showWithdrawTypeByCreditCardType();
    });    
</script>
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
<%@include file="/WEB-INF/public/z_footer_close.html" %> 