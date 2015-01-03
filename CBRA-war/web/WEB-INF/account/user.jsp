<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%-- 
    Document   : cyanzheng
    Created on : May 23, 2011, 6:05:01 PM
    Author     : lining
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<jsp:include page="/WEB-INF/public/z_header.jsp"/>
<div class="BlueBox">
    <div class="Padding30 PaddingLR100">
        <div class="FloatLeft BlueBoxLeft">
            <div class="photo"><img src="${seal.logoImageUrl}" width="80" alt="logo"/></div>
        </div>
        <div class="FloatLeft BlueBoxContentSeal"> 
            <c:choose>
                <c:when test="${seal.user.accountType=='USER'}">
                    <div class="sk-item TextAlignLeft bold"> 
                        <label class="sk-label"><fmt:message key="COLLECT_DETAIL_LABEL_姓名" bundle="${bundle}"/>：</label>  
                        ${seal.userName}
                    </div>
                    <div class="sk-item TextAlignLeft bold"> 
                        <label class="sk-label"><fmt:message key="ACCOUNT_SEAL_COMPANY_LABEL_证件种类" bundle="${bundle}"/>：</label>  
                        <c:choose>
                            <c:when test="${seal.certificateType == 'IDENTITY_CARD'}"><fmt:message key="ACCOUNT_SEAL_USER_TEXT_身份证" bundle="${bundle}"/></c:when>
                            <c:when test="${seal.certificateType == 'PASSPORT'}"><fmt:message key="ACCOUNT_SEAL_USER_TEXT_护照" bundle="${bundle}"/></c:when>
                            <c:when test="${seal.certificateType == 'GAT_TWT'}"><fmt:message key="ACCOUNT_SEAL_USER_TEXT_港澳台居民大陆通行证" bundle="${bundle}"/></c:when>
                            <c:when test="${seal.certificateType == 'SOLDIER_IDENTITY_CARD'}"><fmt:message key="ACCOUNT_SEAL_USER_TEXT_军官证" bundle="${bundle}"/></c:when>
                            <c:otherwise>
                                ${seal.certificateType}
                            </c:otherwise>
                        </c:choose>                       
                        (<fmt:message key="ACCOUNT_USER_TEXT_已认证" bundle="${bundle}"/>)
                    </div>
                    <div class="sk-item TextAlignLeft bold"> 
                        <label class="sk-label"><fmt:message key="ACCOUNT_SEAL_USER_TEXT_邮箱" bundle="${bundle}"/>：</label>  
                        <fmt:message key="ACCOUNT_USER_TEXT_已认证" bundle="${bundle}"/>
                    </div>
                    <div class="sk-item TextAlignLeft bold"> 
                        <label class="sk-label"><fmt:message key="COLLECT_DETAIL_LABEL_手机" bundle="${bundle}"/>：</label>  
                        <fmt:message key="ACCOUNT_USER_TEXT_已认证" bundle="${bundle}"/>
                    </div>
                </c:when>
                <c:when test="${seal.user.accountType=='COMPANY'}">                    
                    <div class="sk-item TextAlignLeft bold"> 
                        <label class="sk-label"><fmt:message key="ACCOUNT_SIGNUPC_LABEL_公司团体名称" bundle="${bundle}"/>：</label>  
                        ${seal.companyName}
                    </div>
                    <div class="sk-item TextAlignLeft bold">
                        <label class="sk-label"><fmt:message key="ACCOUNT_SEAL_COMPANY_LABEL_官方网址" bundle="${bundle}"/>：</label>
                        <a href="${seal.companyWeb}" target="_blank">${seal.companyWeb}</a>
                    </div>
                    <div class="sk-item TextAlignLeft bold"> 
                        <label class="sk-label"><fmt:message key="ACCOUNT_SEAL_COMPANY_LABEL_证件种类" bundle="${bundle}"/>：</label>
                        <c:choose>
                            <c:when test="${seal.certificateType == 'BUSINESS_LICENCE'}"><fmt:message key="ACCOUNT_SEAL_COMPANY_SELECT_营业执照" bundle="${bundle}"/></c:when>
                            <c:when test="${seal.certificateType == 'ORGANIZATION_LICENCE'}"><fmt:message key="ACCOUNT_SEAL_COMPANY_SELECT_组织机构代码证" bundle="${bundle}"/></c:when>
                            <c:when test="${seal.certificateType == 'ARTICLE_INCORPORATION'}">Article of Incorporation</c:when>
                            <c:otherwise><fmt:message key="ACCOUNT_SEAL_COMPANY_SELECT_其他" bundle="${bundle}"/></c:otherwise>
                        </c:choose>
                    </div> 
                    <div class="sk-item TextAlignLeft bold">
                        <label class="sk-label"><fmt:message key="ACCOUNT_SEAL_COMPANY_LABEL_证件号码" bundle="${bundle}"/>：</label>
                        <fmt:message key="ACCOUNT_USER_TEXT_已认证" bundle="${bundle}"/>                    
                    </div>
                    <div class="sk-item TextAlignLeft bold">
                        <label class="sk-label"><fmt:message key="PAYMENT_CREDITCARD_LABEL_地址" bundle="${bundle}"/>：</label>
                        ${seal.companyAddress}
                    </div> 

                    <div class="sk-item TextAlignLeft bold">
                        <label class="sk-label"><fmt:message key="ACCOUNT_SEAL_COMPANY_LABEL_电话" bundle="${bundle}"/>：</label>
                        ${seal.companyPhone}
                    </div>
                    <div class="sk-item TextAlignLeft bold">
                        <label class="sk-label"><fmt:message key="ACCOUNT_SEAL_COMPANY_LABEL_传真" bundle="${bundle}"/>：</label>
                        ${seal.companyFax}
                    </div>
                </c:when>
            </c:choose>
        </div>
        <div class="FloatLeft"><img src="/images/yanzheng.gif"/></div>
        <div class="clear"></div>
    </div>
</div>
<jsp:include page="/WEB-INF/public/z_footer.jsp"/> <%@include file="/WEB-INF/public/z_footer_close.html" %> 



