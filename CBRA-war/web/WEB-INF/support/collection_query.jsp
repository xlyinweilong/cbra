<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%
    request.setAttribute("mainMenuSelection", "EVENT_COLLECTION");
    request.setAttribute("subMenuSelection", "");
%>

<%@include file="/WEB-INF/support/z_header.jsp"%>

<form action="collection_query" method="post">
    <input type="hidden" name="a" value="collection_query"/>
    <div class="search">
        <div class="searchHeader">活动/收款创建时间：<input type="text" class="Input200" id="startDate"name="start" value="<fmt:formatDate value='${startDate}'type='date' pattern='yyyy-MM-dd'/>"/>   到 <input type="text" id="endDate"name="end" class="Input200" value="<fmt:formatDate value='${endDate}'type='date' pattern='yyyy-MM-dd'/>"/></div>
        <div class="searchContent">
            <div class="FloatLeft searchContentList"><p><span>WEB_ID</span><input type="text" name="webId" value="${webId}"></p>
                <p><span>活动/收款名称</span><input type="text" name="title" value="${title}"></p>
                <p><span>活动地点</span><input type="text" name="eventLocation" value="${eventLocation}"></p>
                <p><span>活动主办方</span><input type="text" name="eventHost" value="${eventHost}"></p></div>

            <div class="FloatLeft searchContentList"><p><span>账户姓名</span><input type="text" name="accountName" value="${accountName}"></p>
                <p><span>账户公司</span><input type="text" name="accountCompany" value="${accountCompany}"></p>
                <p><span>账户电话</span><input type="text" name="accountMobilePhone" value="${accountMobilePhone}"></p>
                <p><span>账户邮箱</span><input type="text" name="accountEmail" value="${accountEmail}"></p>
            </div>
            <div class="clear"></div>
            <input type="submit" value="确定" class="button"/>
        </div>
        
    </div> 
</form>
<form id="search_form" action="collection_query" method="POST">
    <input type="hidden" id="page_num" name="page" value="1"/>
    <input type="hidden" id="a" name="a" value="collection_query"/>
    <input type="hidden" id="start" name="start" value="<fmt:formatDate value='${startDate}'type='date' pattern='yyyy-MM-dd'/>"/>
    <input type="hidden" id="end" name="end" value="<fmt:formatDate value='${endDate}'type='date' pattern='yyyy-MM-dd'/>"/>
    <input type="hidden" name="webId" value="${webId}"/>
    <input type="hidden" name="title" value="${title}"/>
    <input type="hidden" name="eventLocation" value="${eventLocation}"/>
    <input type="hidden" name="eventHost" value="${eventHost}"/>
    <input type="hidden" name="accountName" value="${accountName}"/>
    <input type="hidden" name="accountCompany" value="${accountCompany}"/>
    <input type="hidden" name="accountMobilePhone" value="${accountMobilePhone}"/>
    <input type="hidden" name="accountEmail" value="${accountEmail}"/>
</form>
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
        <c:when test="${not empty requestScope.foundCollectionList}">
            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="history_table">
                <thead>
                    <tr>
                        <td>活动/收款名称</td>
                        <td>WEB_ID</td>
                        <td>活动地点</td>
                        <td>活动主办方</td>
                        <td>账户姓名</td>
                        <td>账户公司</td>
                        <td>账户电话</td>
                        <td>账户邮箱</td>
                    </tr>
                </thead>
                <tbody>
                <c:forEach var="list" items="${requestScope.foundCollectionList}" varStatus="status">
                    <tr <c:if test="${status.count%2!=0}">class="white"</c:if> >
                    <td><a href="<c:choose><c:when test='${list.type == "MEMBER"}'>/membership/${list.webId}</c:when><c:otherwise>/${list.type}/${list.webId}</c:otherwise></c:choose>">${list.title}</a></td>
                    <td>${list.webId}</td>
                    <td>${list.eventLocation}</td>
                    <td>${list.eventHost}</td>
                    <td><c:if test="${supportAccountPermit.accountDetailPermit}"><a href="/support/user_information/${list.ownerUser.id}"></c:if>${list.ownerUser.name}<c:if test="${supportAccountPermit.accountDetailPermit}"></a></c:if></td>
                    <td>${list.ownerUser.company}</td>
                    <td>${list.ownerUser.mobilePhone}</td>
                    <td>${list.ownerUser.email}</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            <div class="vPagging">
                <jsp:include page="/WEB-INF/support/z_paging.jsp">
                    <jsp:param name="totalCount" value="${requestScope.foundCollectionList.getTotalCount()}" />
                    <jsp:param name="maxPerPage" value="${requestScope.foundCollectionList.getMaxPerPage()}" />
                    <jsp:param name="pageIndex" value="${requestScope.foundCollectionList.getPageIndex()}" />
                </jsp:include>
            </div>
            <br/>
        </c:when>
        <c:otherwise>
            ${requestScope.noResult}
        </c:otherwise>
    </c:choose>
</div>
<jsp:include page="/WEB-INF/support/z_footer.jsp"/>
