<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%-- 
    Document   : index
    Created on : Mar 29, 2011, 10:49:28 AM
    Author     : HUXIAOFENG
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/public/z_header.jsp"/>
<div class="BlueBox">
    <div class="BlueBoxContent826">
    <div class="noticeMessage" style="display:none">
        <div class="successMessage" style="display:none"></div>
        <div class="wrongMessage" style="display:none"></div>
        <div class="loadingMessage" style="display:none"><fmt:message key="GLOBAL_MSG_LOADING" bundle="${bundle}"/><img alt="" src="/images/032.gif"></div>
    </div>
    <div class="FloatLeft BlueBoxLeft" style="padding-top: 30px">
        <div class="photo">
            <c:choose>
                <c:when test="${not empty user.logoUrl}">
                    <img src="${user.logoUrl}" width="80"/>
                </c:when>
                <c:otherwise>
                    <c:choose>
                        <c:when test="${user.accountType=='COMPANY'}">
                            <img src="/images/company_logo.png" width="80"/>
                        </c:when>
                        <c:otherwise>
                            <img src="/images/photo.png" width="80"/>
                        </c:otherwise>
                    </c:choose>                    
                </c:otherwise>
            </c:choose>    
        </div></div>
    <div class="FloatLeft BlueBoxContent">       
        <form method="POST" action="/account/reginfo" enctype="multipart/form-data"  id="reginfo">
            <input type="hidden" name="a" value="CHANGE_REGINFO"/>
            <div class="sk-item MarginTop30">
                <label class="sk-label"><fmt:message key="COLLECT_DETAIL_LABEL_姓名" bundle="${bundle}"/></label>
                <input type="text" class="Input450" id="reginfo_name" name="name" <c:if test="${sessionScope.user.accountType=='USER'&&!sessionScope.user.permissionModified}">disabled="true"</c:if> value="${sessionScope.user.name}"/>
            </div>
            <div class="sk-item">
                <label class="sk-label">
                    <c:choose>
                        <c:when test="${user.accountType=='COMPANY'}">
                            <fmt:message key="ACCOUNT_REGINFO_LABEL_公司LOGO" bundle="${bundle}"/>
                        </c:when>
                        <c:otherwise>
                            <fmt:message key="ACCOUNT_REGINFO_LABEL_上传头像" bundle="${bundle}"/>
                        </c:otherwise>
                    </c:choose>
                </label>
                <input name="logo" type="file" class="Input450 Input461"id="user_logo" <c:if test="${!sessionScope.user.permissionModified}">disabled="true"</c:if>/>
                <div class="sk-explain"><fmt:message key="ACCOUNT_REGINFO_TEXT_最佳尺寸80x80像素" bundle="${bundle}"/></div>
            </div>
            <div class="sk-item">
                <label class="sk-label"><fmt:message key="ACCOUNT_REGINFO_LABEL_职位" bundle="${bundle}"/></label>
                <input type="text" class="Input450" id="reginfo_position" name="position" value="${sessionScope.user.position}"/>
            </div>
            <div class="sk-item">
                <label class="sk-label"><fmt:message key="COLLECT_DETAIL_LABEL_公司" bundle="${bundle}"/></label>
                <input type="text" class="Input450" id="reginfo_company" <c:if test="${sessionScope.user.accountType=='COMPANY'&&!sessionScope.user.permissionModified}">disabled="true"</c:if>name="company" value="${sessionScope.user.company}"/>
            </div>
            <div class="sk-item">
                <label class="sk-label"><fmt:message key="ACCOUNT_SIGNUPC_LABEL_邮箱地址" bundle="${bundle}"/></label>  
                <input type="text" class="Input450" disabled="true" value="${sessionScope.user.email}"/>
            </div>
            <div class="sk-item">
                <label class="sk-label"><fmt:message key="COLLECT_DETAIL_LABEL_手机" bundle="${bundle}"/></label>
                <input type="text" class="Input450" <c:if test="${not empty sessionScope.user.mobilePhone&&!sessionScope.user.permissionModified}">disabled="true"</c:if>name="phone" value="${sessionScope.user.mobilePhone}"/>
            </div>
            <div class="sk-item">
                <label class="sk-label"></label>
                <input type="button" name="Submit" value="<fmt:message key='GLOBAL_保存' bundle='${bundle}'/>" class="collection_button" onclick="UserUpdate.validateRegInfo('${sessionScope.user.accountType}');"/>
            </div>
        </form>
    </div>
            <div class="clear"></div> </div>
</div>
<jsp:include page="/WEB-INF/public/z_footer.jsp"/>
<c:if test="${not empty postResult.singleSuccessMsg}">
    <script>   
        $(document).ready(function(){
            var successMessage='${postResult.singleSuccessMsg}';
            if(successMessage!=''){
                MessageShow.showSuccessMessage(successMessage);
            }
        });
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
<%@include file="/WEB-INF/public/z_footer_close.html" %> 
