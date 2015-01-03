<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%-- 
    Document   : index
    Created on : May 17, 2011, 5:23:59 PM
    Author     : chenjianlin
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    request.setAttribute("mainMenuSelection", "WITHDRAW");
    request.setAttribute("subMenuSelection", "WITHDRAW_UN_PROCESSED");
%>

<%@include file="/WEB-INF/support/z_header.jsp"%>

<jsp:include page="/WEB-INF/support/z_date_form.jsp">
    <jsp:param name="action" value="/support/un_processed_withdraw" />
    <jsp:param name="title" value="未处理提款记录：" />
</jsp:include>

<div class="admin-content">
    <c:choose>
        <c:when test="${not empty withdrawList}">  
            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="history_table">
                <thead>
                    <tr><td colspan="10" align="left">未理提款总额：${withdrawUnProcessedAmount}</td></tr>
                    <tr>
                        <td width="10%">时间</td>
                        <td width="10%">姓名</td>
                        <td width="10%">Email</td>
                        <td width="10%">金额</td>
                        <td width="10%">账户名称</td>
                        <td width="25%">账户信息</td>
                        <td width="15%">操作</td>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="withdraw" items="${withdrawList}" varStatus="status">
                        <tr <c:if test="${status.count%2!=0}">class="white"</c:if>>
                            <td><fmt:formatDate value='${withdraw.createDate}'type='date' pattern='yyyy.MM.dd'/></td>
                            <td><c:if test="${supportAccountPermit.accountDetailPermit}"><a href="/support/user_information/${withdraw.owner.id}"></c:if>${withdraw.owner.name}<c:if test="${supportAccountPermit.accountDetailPermit}"></a></c:if></td>
                            <td>${withdraw.owner.email}</td>
                            <td>${withdraw.amount}</td>
                            
                            <td>${withdraw.withdrawAccount.name}</td>
                            <td>
                                <c:if test="${withdraw.withdrawAccount.type=='ALIPAY'}">
                                    支付宝账号：${withdraw.withdrawAccount.alipayAccount}
                                </c:if>
                                <c:if test="${withdraw.withdrawAccount.type=='CREDITCARD'}">
                                    类别：国内信用卡<br/>
                                    姓名：${withdraw.withdrawAccount.creditCardHolder}<br/>
                                    开户行名称：${withdraw.withdrawAccount.creditCardBankName}<br/>
                                    支行名称：${withdraw.withdrawAccount.creditCardBankBranch}<br/>
                                    卡号：${withdraw.withdrawAccount.creditCardNumber}
                                </c:if>
                                <c:if test="${withdraw.withdrawAccount.type=='BANK'}">
                                    类型：国内银行
                                    姓名：${withdraw.withdrawAccount.bankUserName}
                                    银行名称：${withdraw.withdrawAccount.bankName}
                                    支行名称：${withdraw.withdrawAccount.bankBranch}
                                    银行卡号：${withdraw.withdrawAccount.bankAccountNumber}
                                </c:if>
                                <c:if test="${withdraw.withdrawAccount.type=='PAYPAL'}">
                                    PALPAY账号：${withdraw.withdrawAccount.payPalAccount}
                                </c:if>
                                <c:if test="${withdraw.withdrawAccount.type=='INT_BANK'}">
                                    类型：国外银行
                                    姓名：${withdraw.withdrawAccount.intBankUserName}
                                    开户人地址：${withdraw.withdrawAccount.intBankUserAddress}
                                    开户行：${withdraw.withdrawAccount.intBankName}
                                    账户号码：${withdraw.withdrawAccount.intBankAccountNumber}
                                    开户行地址：${withdraw.withdrawAccount.intBankAddress}
                                    TransitNumber：${withdraw.withdrawAccount.intBankTransitNumber}
                                    SwiftCode：${withdraw.withdrawAccount.intBankSwiftCode}
                                </c:if>
                            </td>
                            <td>
                                <span id="ok${withdraw.id}">
                                    <input type="checkbox" name="send_mail" id="send_mail${withdraw.id}" value="0" checked="checked">发送邮件通知
                                    <input type="text" name="msg" id="msg${withdraw.id}">
                                    <input type="button" onclick="process(${withdraw.id});"value="处理">
                                </span>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            <div class="vPagging">
                <jsp:include page="/WEB-INF/support/z_paging.jsp">
                    <jsp:param name="totalCount" value="${withdrawList.getTotalCount()}" />
                    <jsp:param name="maxPerPage" value="${withdrawList.getMaxPerPage()}" />
                    <jsp:param name="pageIndex" value="${withdrawList.getPageIndex()}" />
                </jsp:include>
            </div>
        </c:when>
        <c:otherwise>
            <h3 class="nolist">列表为空</h3>
        </c:otherwise>
    </c:choose>
</div>

<script>
    function process(id){
        $.ajax({
            url: '/support/process',
            type: 'POST',
            data: 'a=process&withdrawId='+id+'&msg='+$('#msg'+id).val()+'&send_mail='+$('#send_mail'+id)[0].checked,
            dataType: 'text',
            error: function(xhr) { alert('error')},
            success: function(msg){
                if($.trim(msg)=='ok'){
                    $('#ok'+id).html('已处理');
                    $('#ok'+id).css('color','red');
                }else{
                    alert('error：请先登录');
                }
            }
        });
    }
        
</script>

<jsp:include page="/WEB-INF/support/z_footer.jsp"/>
