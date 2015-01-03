<%-- 
    Document   : user_seal_result
    Created on : May 27, 2011, 2:01:55 PM
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
                            <div class="successMessage"><fmt:message key="ACCOUNT_SEAL_RESULT_COMPANY_TEXT_认证通过" bundle="${bundle}"/> <a href="/account/reseal" class="bold">重新认证</a></div>
                        </c:when>
                        <c:otherwise>
                            <div class="wrongMessage"><fmt:message key="ACCOUNT_SEAL_RESULT_COMPANY_TEXT_认证未通过" bundle="${bundle}"/><span style="color:#000">${sealResult.processMsg}</span> &nbsp;<a href="/account/reseal" class="bold">重新申请</a></div>
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
                            <div class="successMessage"><fmt:message key="ACCOUNT_SEAL_RESULT_COMPANY_LABEL_原认证信息" bundle="${bundle}"/></div>
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
                    <label class="sk-label"><fmt:message key="COLLECT_DETAIL_LABEL_姓名" bundle="${bundle}"/>：</label>
                    ${sealResult.userName}
                </div>
                <div class="sk-item TextAlignLeft bold"> 
                    <label class="sk-label"><fmt:message key="ACCOUNT_SEAL_COMPANY_LABEL_证件种类" bundle="${bundle}"/>：</label>  
                    <c:choose>
                        <c:when test="${sealResult.certificateType == 'IDENTITY_CARD'}"><fmt:message key="ACCOUNT_SEAL_USER_TEXT_身份证" bundle="${bundle}"/></c:when>
                        <c:when test="${sealResult.certificateType == 'PASSPORT'}"><fmt:message key="ACCOUNT_SEAL_USER_TEXT_护照" bundle="${bundle}"/></c:when>
                        <c:when test="${sealResult.certificateType == 'GAT_TWT'}"><fmt:message key="ACCOUNT_SEAL_USER_TEXT_港澳台居民大陆通行证" bundle="${bundle}"/></c:when>
                        <c:when test="${sealResult.certificateType == 'SOLDIER_IDENTITY_CARD'}"><fmt:message key="ACCOUNT_SEAL_USER_TEXT_军官证" bundle="${bundle}"/></c:when>
                        <c:otherwise></c:otherwise>
                    </c:choose>
                </div>
                <div class="sk-item TextAlignLeft bold">
                    <label class="sk-label"><fmt:message key="ACCOUNT_SEAL_COMPANY_LABEL_证件号码" bundle="${bundle}"/>：</label>
                    ${sealResult.certificateNumber}
                </div>

                <div class="sk-item TextAlignLeft bold">
                    <label class="sk-label"><fmt:message key="ACCOUNT_SEAL_RESULT_COMPANY_LABEL_证件扫描件" bundle="${bundle}"/>：</label>
                    已上传
                </div>
                <div class="sk-item TextAlignLeft bold">
                    <label class="sk-label"><fmt:message key="COLLECT_DETAIL_LABEL_手机" bundle="${bundle}"/>：</label>
                    <c:choose>
                        <c:when test="${not empty sealResult.userMobile}">
                            ${sealResult.userMobile}
                        </c:when>
                        <c:otherwise>
                            &nbsp;
                        </c:otherwise>
                    </c:choose>
                </div>
                <div class="sk-item TextAlignLeft bold">
                    <label class="sk-label"><fmt:message key="ACCOUNT_SEAL_USER_TEXT_邮箱" bundle="${bundle}"/>：</label>
                    <c:choose>
                        <c:when test="${not empty sealResult.userMobile}">
                            ${sealResult.userEmail}
                        </c:when>
                        <c:otherwise>
                            &nbsp;
                        </c:otherwise>
                    </c:choose>
                </div>
                <c:if test="${not empty sealResult.additionNotes}">
                    <div class="sk-item TextAlignLeft bold">
                        <label class="sk-label"><fmt:message key="ACCOUNT_SEAL_COMPANY_LABEL_补充说明" bundle="${bundle}"/>：</label>
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
