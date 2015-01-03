<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<!DOCTYPE html>
<%
    request.setAttribute("mainMenuSelection", "ACCOUNT");
    request.setAttribute("subMenuSelection", "ACCOUNT_QUERY");
%>

<%@include file="/WEB-INF/support/z_header.jsp"%>

<div id="admin">
    <form action="account_query" method="post">
        <input type="hidden" name="a" value="account_query"/>
        <div class="search">
           <div class="searchHeader">创建日期<input type="text" id="startDate" class="Input200" name="start" value="<fmt:formatDate value='${startDate}'type='date' pattern='yyyy-MM-dd'/>"/>   到 <input type="text" id="endDate"name="end" class="Input200" value="<fmt:formatDate value='${endDate}'type='date' pattern='yyyy-MM-dd'/>"/></div>
 <div class="searchContent">
<div class="FloatLeft searchContentList">
        <p><span>姓名</span><input type="text" name="accountName" value="${accountName}"></p>
        <p><span>公司</span><input type="text" name="accountCompany" value="${accountCompany}"></p></div>
       <div class="FloatLeft searchContentList"> <p><span>电话</span><input type="text" name="accountMobilePhone" value="${accountMobilePhone}"></p>
        <p><span>邮件</span><input type="text" name="accountEmail" value="${accountEmail}"></p></div>
        <input type="submit" value="确定" class="button"/></div><div class="clear"></div></div>
    </form>
    <form id="search_form" action="account_query" method="POST">
        <input type="hidden" id="page_num" name="page" value="1"/>
        <input type="hidden" id="a" name="a" value="account_query"/>
        <input type="hidden" id="start" name="start" value="<fmt:formatDate value='${startDate}'type='date' pattern='yyyy-MM-dd'/>"/>
        <input type="hidden" id="end" name="end" value="<fmt:formatDate value='${endDate}'type='date' pattern='yyyy-MM-dd'/>"/>
        <input type="hidden" name="accountName" value="${accountName}"/>
        <input type="hidden" name="accountCompany" value="${accountCompany}"/>
        <input type="hidden" name="accountMobilePhone" value="${accountMobilePhone}"/>
        <input type="hidden" name="accountEmail" value="${accountEmail}"/>
    </form></div>
<script>
    $( "#startDate" ).datepicker();
    $( "#startDate" ).datepicker("option", "dateFormat", "yy-mm-dd");
    $( "#endDate" ).datepicker();
    $( "#endDate" ).datepicker("option", "dateFormat", "yy-mm-dd");
    $( "#startDate" ).val($('#start').val());
    $( "#endDate" ).val($('#end').val());
</script>
<div class="admin-content">
    <c:choose>
        <c:when test="${not empty requestScope.userAccountList}">
            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="history_table">
                <thead>
                    <tr>
                        <td>姓名</td>
                        <td>公司</td>
                        <td>电话</td>
                        <td>邮件</td>
                        <td>Email_verified</td>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="list" items="${requestScope.userAccountList}" varStatus="status">
                        <tr <c:if test="${status.count%2!=0}">class="white"</c:if> >
                            <td><c:if test="${supportAccountPermit.accountDetailPermit}"><a href="/support/user_information/${list.id}"></c:if>${list.name}<c:if test="${supportAccountPermit.accountDetailPermit}"></a></c:if></td>
                            <td>${list.company}</td>
                            <td>${list.mobilePhone}</td>
                            <td>${list.email}</td>
                            <td>${list.verified}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            <div class="vPagging">
                <jsp:include page="/WEB-INF/support/z_paging.jsp">
                    <jsp:param name="totalCount" value="${requestScope.userAccountList.getTotalCount()}" />
                    <jsp:param name="maxPerPage" value="${requestScope.userAccountList.getMaxPerPage()}" />
                    <jsp:param name="pageIndex" value="${requestScope.userAccountList.getPageIndex()}" />
                </jsp:include>
            </div>
            </br>
        </c:when>
        <c:otherwise>
            ${requestScope.noResult}
        </c:otherwise>
    </c:choose>
</div>

<jsp:include page="/WEB-INF/support/z_footer.jsp"/>