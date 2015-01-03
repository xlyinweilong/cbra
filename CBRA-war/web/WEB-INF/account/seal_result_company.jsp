<%-- 
    Document   : company_seal_result
    Created on : May 27, 2011, 2:02:46 PM
    Author     : WangShuai
--%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%-- 设置MenuSelection参数 --%>
<%
    request.setAttribute("mainMenuSelection", cn.yoopay.web.support.MenuSelectionEnum.ACCOUNT);
    request.setAttribute("subMenuSelection", cn.yoopay.web.support.MenuSelectionEnum.ACCOUNT_SEAL);
%>
<%-- 设置MenuSelection参数结束 --%>
<jsp:include page="/WEB-INF/public/z_header.jsp"/>
<div class="BlueBox">
    <c:forEach var="sealResult" items="${sealResultList}" varStatus="status">
        <c:choose>
            <c:when test="${status.first}">
                <div class="noticeMessage">
                    <c:choose>
                        <c:when test="${sealResult.processStatus == 'PENDING'}">
                            <div class="successMessage"><fmt:message key="ACCOUNT_SEAL_RESULT_COMPANY_TEXT_认证申请已提交" bundle="${bundle}"/></div>
                        </c:when>
                        <c:when test="${sealResult.processStatus == 'APPROVE'}">
                            <div class="successMessage"><fmt:message key="ACCOUNT_SEAL_RESULT_COMPANY_TEXT_认证通过" bundle="${bundle}"/> <a href="/account/reseal" class="bold"><fmt:message key="ACCOUNT_SEAL_RESULT_COMPANY_LINK_重新认证" bundle="${bundle}"/></a></div>
                        </c:when>
                        <c:otherwise>
                            <div class="wrongMessage"><fmt:message key="ACCOUNT_SEAL_RESULT_COMPANY_TEXT_认证未通过" bundle="${bundle}"/><span style="color:#000">${sealResult.processMsg}</span> &nbsp;<a href="/account/reseal" class="bold"><fmt:message key="ACCOUNT_SEAL_RESULT_COMPANY_LINK_重新申请" bundle="${bundle}"/></a></div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </c:when>
            <c:otherwise>
                <div class="noticeMessage">
                    <c:choose>
                        <c:when test="${sealResult.processStatus == 'PENDING'}">
                            <div class="successMessage"><fmt:message key="ACCOUNT_SEAL_RESULT_COMPANY_LABEL_原认证信息" bundle="${bundle}"/></div>
                        </c:when>
                        <c:when test="${sealResult.processStatus == 'APPROVE'}">
                            <div class="successMessage"> <fmt:message key="ACCOUNT_SEAL_RESULT_COMPANY_LABEL_原认证信息" bundle="${bundle}"/></div>
                        </c:when>
                        <c:otherwise>
                            <div class="wrongMessage"><fmt:message key="ACCOUNT_SEAL_RESULT_COMPANY_LABEL_原认证信息" bundle="${bundle}"/></div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </c:otherwise>
        </c:choose>
        <div class="Padding30 PaddingLR100">
            <div class="FloatLeft BlueBoxLeft"><div class="photo"><img src="${sealResult.logoImageUrl}" width="80" alt="logo"/></div></div>
            <div class="FloatLeft BlueBoxContentSeal"> 
                <div class="sk-item TextAlignLeft bold"> 
                    <label class="sk-label"><fmt:message key="ACCOUNT_SIGNUPC_LABEL_公司团体名称" bundle="${bundle}"/>：</label>${sealResult.companyName}
                </div>
                <div class="sk-item TextAlignLeft bold">
                    <label class="sk-label"><fmt:message key="ACCOUNT_SEAL_COMPANY_LABEL_官方网址" bundle="${bundle}"/>：</label>
                    <a href="${sealResult.companyWeb}" target="_blank">${sealResult.companyWeb}</a>
                </div>
                <div class="sk-item TextAlignLeft bold">
                    <label class="sk-label"><fmt:message key="ACCOUNT_SEAL_COMPANY_LABEL_预计年收款额" bundle="${bundle}"/>：</label>
                    <c:choose>
                        <c:when test="${sealResult.companyCollectScale=='LT50'}">
                            <fmt:message key="ACCOUNT_SEAL_COMPANY_SELECT_小于50万" bundle="${bundle}"/>
                        </c:when>
                        <c:when test="${sealResult.companyCollectScale=='GE50LT100'}">
                           <fmt:message key="ACCOUNT_SEAL_COMPANY_SELECT_50万-200万" bundle="${bundle}"/>
                        </c:when>
                        <c:when test="${sealResult.companyCollectScale=='GE200'}">
                            <fmt:message key="ACCOUNT_SEAL_COMPANY_SELECT_200万以上" bundle="${bundle}"/>
                        </c:when>
                        <c:otherwise>
                            <fmt:message key="ACCOUNT_SEAL_RESULT_COMPANY_TEXT_未填" bundle="${bundle}"/>
                        </c:otherwise>
                    </c:choose>
                </div>
                <div class="sk-item TextAlignLeft bold">
                    <label class="sk-label"><fmt:message key="ACCOUNT_SEAL_COMPANY_LABEL_证件种类" bundle="${bundle}"/>：</label>
                    <c:choose>

                        <c:when test="${sealResult.certificateType == 'BUSINESS_LICENCE'}"><fmt:message key="ACCOUNT_SEAL_COMPANY_SELECT_营业执照" bundle="${bundle}"/></c:when>
                        <c:when test="${sealResult.certificateType == 'ORGANIZATION_LICENCE'}"><fmt:message key="ACCOUNT_SEAL_COMPANY_SELECT_组织机构代码证" bundle="${bundle}"/></c:when>
                        <c:when test="${sealResult.certificateType == 'ARTICLE_INCORPORATION'}">Article of Incorporation</c:when>
                        <c:otherwise><fmt:message key="ACCOUNT_SEAL_COMPANY_SELECT_其他" bundle="${bundle}"/></c:otherwise>
                    </c:choose>
                </div>
                <div class="sk-item TextAlignLeft bold">
                    <label class="sk-label"><fmt:message key="ACCOUNT_SEAL_COMPANY_LABEL_证件号码" bundle="${bundle}"/>：</label> 
                    ${sealResult.certificateNumber}
                </div>
                <div class="sk-item TextAlignLeft bold">
                    <label class="sk-label"><fmt:message key="ACCOUNT_SEAL_RESULT_COMPANY_LABEL_证件扫描件" bundle="${bundle}"/>：</label>
                    <fmt:message key="ACCOUNT_SEAL_RESULT_COMPANY_TEXT_已上传" bundle="${bundle}"/>
                </div>
                <div class="sk-item TextAlignLeft bold">
                    <label class="sk-label"><fmt:message key="PAYMENT_CREDITCARD_LABEL_地址" bundle="${bundle}"/>：</label>${sealResult.companyAddress}
                </div>
                <div class="sk-item TextAlignLeft bold">
                    <label class="sk-label"><fmt:message key="ACCOUNT_SEAL_COMPANY_LABEL_电话" bundle="${bundle}"/>：</label>${sealResult.companyPhone}
                </div>
                <div class="sk-item TextAlignLeft bold">
                    <label class="sk-label"><fmt:message key="ACCOUNT_SEAL_COMPANY_LABEL_传真" bundle="${bundle}"/>：</label>${sealResult.companyFax}
                </div>
                <c:if test="${not empty sealResult.additionNotes}">
                    <div class="sk-item TextAlignLeft bold">
                        <label class="sk-label"><fmt:message key="ACCOUNT_SEAL_COMPANY_LABEL_补充说明" bundle="${bundle}"/>
：</label>
                        ${sealResult.additionNotes}
                    </div>
                </c:if>
            </div>
            <c:if test="${sealResult.processStatus == 'APPROVE'}">
                <div class="FloatLeft"><img src="/images/yanzheng.gif"/></div>
                </c:if>
            <div class="clear"></div>
        </div>
    </c:forEach>
</div>
<jsp:include page="/WEB-INF/public/z_footer.jsp"/> 
<%@include file="/WEB-INF/public/z_footer_close.html" %> 
