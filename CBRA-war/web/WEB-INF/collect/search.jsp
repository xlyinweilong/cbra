<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="cn.yoopay.entity.*,cn.yoopay.support.Tools,java.util.*"%>

<%
    String collectionType = (String) request.getAttribute("collectionType");
    if ("EVENT".equals(collectionType)) {
        request.setAttribute("mainMenuSelection", cn.yoopay.web.support.MenuSelectionEnum.FUNDCOLLECT_EVENT);
        request.setAttribute("subMenuSelection", cn.yoopay.web.support.MenuSelectionEnum.FUNDCOLLECT_EVENT_LIST);
    } else if ("DONATION".equals(collectionType)) {
        request.setAttribute("mainMenuSelection", cn.yoopay.web.support.MenuSelectionEnum.FUNDCOLLECT_DONATION);
        request.setAttribute("subMenuSelection", cn.yoopay.web.support.MenuSelectionEnum.FUNDCOLLECT_DONATION_LIST);
    } else if ("SERVICE".equals(collectionType)) {
        request.setAttribute("mainMenuSelection", cn.yoopay.web.support.MenuSelectionEnum.FUNDCOLLECT_SERVICE);
        request.setAttribute("subMenuSelection", cn.yoopay.web.support.MenuSelectionEnum.FUNDCOLLECT_SERVICE_LIST);
    } else if ("PRODUCT".equals(collectionType)) {
        request.setAttribute("mainMenuSelection", cn.yoopay.web.support.MenuSelectionEnum.FUNDCOLLECT_PRODUCT);
        request.setAttribute("subMenuSelection", cn.yoopay.web.support.MenuSelectionEnum.FUNDCOLLECT_PRODUCT_LIST);
    } else if ("MEMBER".equals(collectionType)) {
        request.setAttribute("mainMenuSelection", cn.yoopay.web.support.MenuSelectionEnum.FUNDCOLLECT_MEMBER);
        request.setAttribute("subMenuSelection", cn.yoopay.web.support.MenuSelectionEnum.FUNDCOLLECT_MEMBER_LIST);
    } else {
        request.setAttribute("mainMenuSelection", cn.yoopay.web.support.MenuSelectionEnum.FUNDCOLLECT_EVENT);
        request.setAttribute("subMenuSelection", cn.yoopay.web.support.MenuSelectionEnum.FUNDCOLLECT_EVENT_LIST);
    }
%>
<jsp:include page="/WEB-INF/public/z_header.jsp"/>
<div style="margin-bottom: 20px" >
    <form action="/collect/search/${fn:toLowerCase(collectionType)}/1" method="POST" onsubmit="return FundCollectionSearch.search('<fmt:message key='COLLECT_SEARCH_可按活动的名称搜索' bundle="${bundle}"/>');">
        <div class="FloatLeft"><input type="text" id="keyword" name="keyword" <c:choose><c:when test="${not empty keyword}">value="${keyword}"</c:when><c:otherwise>value="<fmt:message key='COLLECT_SEARCH_可按活动的名称搜索' bundle='${bundle}'/>" style="color:#999999"</c:otherwise></c:choose> class="SearchInput" 
                                      onfocus="YpEffects.toggleFocus4Ele(this, 'focus', '<fmt:message key='COLLECT_SEARCH_可按活动的名称搜索' bundle="${bundle}"/>', '', 'black')" 
                                      onblur="YpEffects.toggleFocus4Ele(this, 'blur', '<fmt:message key='COLLECT_SEARCH_可按活动的名称搜索' bundle="${bundle}"/>', '', '#999999')"/>
            <input type="submit" value="<fmt:message key='GLOBAL_搜索' bundle="${bundle}"/>" class="collection_button"/>
        </div><div class="noticeMessage FloatLeft" style="margin-left:10px;">
            <div class="successMessage" style="display:none"></div>
            <div class="wrongMessage" style="display:none"></div>
            <div class="loadingMessage" style="display:none"><fmt:message key="GLOBAL_MSG_LOADING" bundle="${bundle}"/><img alt="" src="/images/032.gif"></div>
        </div>
        <div class="clear"></div>
    </form>

</div>
<c:choose>
    <c:when test="${empty fundCollectionList}">
        <h3 class="nolist">${postResult.singleErrorMsg}</h3>
    </c:when>
    <c:otherwise>
        <div class="SearchList">
            <c:forEach var="fundCollection" items="${fundCollectionList}" varStatus="status">
                <ul <c:if test="${status.count%2!=0}">class="white"</c:if>>
                    <li class="one"> 
                        <div class="Calendar">
                            <p class="Month"><fmt:formatDate value="${fundCollection.eventBeginDate}" type="date" pattern="${eventMonthDayParseStyle}"/></p>
                            <p class="Day">
                                <%
                                    Locale locale = (Locale) request.getAttribute("locale");
                                    FundCollection fundCollection = (FundCollection) pageContext.getAttribute("fundCollection");
                                    String eventDateDesc = fundCollection.getEventDate(locale);
                                %>
                                <%=Tools.formatWeekday(fundCollection.getEventBeginDate(), locale)%>
                            </p>
                        </div> 
                    </li>
                    <li class="two"><p><a href="/event/${fundCollection.webId}">${fundCollection.title}</a></p>
                        <p><fmt:message key="COLLECT_EDIT_TEXT_主办方" bundle="${bundle}"/> : ${fundCollection.eventHost}</p>
                        <p><fmt:message key="COLLECT_EDIT_TEXT_活动时间" bundle="${bundle}"/> : <%=eventDateDesc%></p>
                        <p><fmt:message key="COLLECT_EDIT_TEXT_活动地点" bundle="${bundle}"/> : ${fundCollection.eventLocation}</p>
                    </li>
                    <li class="three">${fundCollection.detailDesc}</li>
                    <div class="clear"></div>
                </ul>

            </c:forEach>
        </div><div class="clear"></div>   
        <%--Set page jump base url --%>
        <div> 
            <c:set value="/collect/search/${fn:toLowerCase(collectionType)}" var="pageBaseUrl" scope="page"/>
            <jsp:include page="/WEB-INF/public/z_paging.jsp">
                <jsp:param name="baseUrl" value="${pageBaseUrl}" />
                <jsp:param name="keyword" value="${keyword}" />
                <jsp:param name="totalCount" value="${fundCollectionList.getTotalCount()}" />
                <jsp:param name="maxPerPage" value="${fundCollectionList.getMaxPerPage()}" />
                <jsp:param name="pageIndex" value="${fundCollectionList.getPageIndex()}" />
            </jsp:include>
        </div>
    </c:otherwise>
</c:choose>
<jsp:include page="/WEB-INF/public/z_footer.jsp"/> <%@include file="/WEB-INF/public/z_footer_close.html" %> 
