<%-- 
    Document   : calendar_widget
    Created on : Jan 14, 2013, 3:16:09 PM
    Author     : Yin.Weilong
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page import="cn.yoopay.Config"%>
<%
    request.setAttribute("mainMenuSelection", cn.yoopay.web.support.MenuSelectionEnum.FUNDCOLLECT_EVENT);
    request.setAttribute("subMenuSelection", cn.yoopay.web.support.MenuSelectionEnum.FUNDCOLLECT_EVENT_CALENDAR);
%>
<jsp:include page="/WEB-INF/public/z_header.jsp"/>

<div class="BlueBox">
    <div class="BlueBoxTitle">
        <fmt:message key='COLLECT_CALENDAR_TEXT_活动日历' bundle='${bundle}'/>
    </div>
    <div class="BlueBoxContent826">
        <div class="DetailHeader">
            <jsp:include page="/WEB-INF/calendar/z_calendar_menu.jsp">
                <jsp:param name="menuType" value="EDIT"/>
            </jsp:include> 
        </div>
        <div id="detail_edit">
            <div class="MarginTop10 ">
                <form action="/calendar/edit" method="post" id="calendar_edit_form">
                    <div class="MarginTop20">
                        <span><fmt:message key='COLLECT_CALENDAR_TEXT_日历引用说明' bundle='${bundle}'/></span>
                        <span class="FloatRight" style="margin-top: -10px">
                            <c:if test="${empty afterSearch || empty userAccountList}">
                                <input type="text" style="width: 300px;color: rgb(153, 153, 153);" class="Input200" name="keywords" id="calendar_edit_input_email" />
                                <input type="button" class="collection_button" style="height: 34px;" value="<fmt:message key='COLLECT_CALENDAR_TEXT_搜索' bundle='${bundle}'/>" id="calendar_edit_button"/>
                            </c:if>
                        </span>
                    </div>
                    <input type="hidden" name="a" value="SEARCH_USERS" />
                    <%--提示信息--%>
                    <div class="MarginTop10">
                        <div class="noticeMessage" style="display:none">
                            <div class="loadingMessage" style="display:none"><fmt:message key="GLOBAL_MSG_LOADING" bundle="${bundle}"/><img alt="" src="/images/032.gif"></div>
                        </div>
                        <c:if test="${!empty postResult.singleSuccessMsg}"> 
                            <div class="noticeMessage">
                                <div class="successMessage">${postResult.singleSuccessMsg}</div>
                            </div>
                        </c:if>
                        <div class="wrongMessage" id="calendar_edit_wrong_message">${postResult.singleErrorMsg}</div>
                    </div>
                    <table <c:if test='${not empty afterSearch && afterSearch}'>style="display: none"</c:if> width="100%" border="0"  cellpadding="0" cellspacing="0" class="payment_list_table ">
                        <thead>   
                            <tr>
                                <td style="text-align: center"><fmt:message key='COLLECT_CALENDAR_LABEL_日期' bundle='${bundle}'/></td> 
                        <td style="text-align: center"><fmt:message key='COLLECT_CALENDAR_LABEL_账户姓名' bundle='${bundle}'/></td> 
                        <td style="text-align: center"><fmt:message key='COLLECT_CALENDAR_LABEL_公司组织' bundle='${bundle}'/></td> 
                        <td style="text-align: center"><fmt:message key='COLLECT_CALENDAR_LABEL_活动数量' bundle='${bundle}'/></td> 
                        <td style="text-align: center"><fmt:message key='COLLECT_CALENDAR_LABEL_操作' bundle='${bundle}'/></td>
                        </tr> 
                        </thead>
                        <tbody>
                        <c:choose>
                            <c:when test="${not empty userCalendarList}">
                                <c:forEach var="userCalendar" items="${userCalendarList}" varStatus="status">
                                    <tr <c:if test="${status.count%2!=0}">class="white"</c:if>>
                                    <td style="text-align: center"><fmt:formatDate value='${userCalendar.createDate}'type='date' pattern='yyyy.MM.dd'/></td>
                                    <td style="text-align: center">${userCalendar.targetUser.name}</td>
                                    <td style="text-align: center">${userCalendar.targetUser.company}</td>
                                    <td style="text-align: center">${userCalendar.targetUser.getEventList().size()}</td>
                                    <td style="text-align: center"><a href="javascript:Calendar.deleteUserCalendar('${userCalendar.targetUser.email}')" ><fmt:message key='COLLECT_CALENDAR_BUTTON_删除' bundle='${bundle}'/></a></td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr class="white">
                                    <td colspan="5"><div class="nolist" style="margin: 25px 25px 40px 25px"><fmt:message key='COLLECT_CALENDAR_TEXT_暂无记录' bundle='${bundle}'/></div></td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                        </tbody>
                    </table>
                </form>
                <form action="/calendar/edit" method="post" id="calendar_edit_after_search_form">
                    <input type="hidden" name="a" value="ADD_USER_CALENDAR" />
                    <c:if test="${afterSearch && not empty userAccountList}"><span class="FloatRight" style="margin-top: -35px "><a href="/calendar/edit"><fmt:message key='COLLECT_CALENDAR_BUTTON_取消' bundle='${bundle}'/></a>&nbsp;<input type="button" onclick="Calendar.addUserCalendars()" class="collection_button" style="line-height: 30px;height: 28px;padding:0px 10px 0px 10px" value="<fmt:message key='COLLECT_CALENDAR_BUTTON_添加' bundle='${bundle}'/>" /></span></c:if>
                    <c:if test="${not empty afterSearch && afterSearch}">
                        <table width="100%" border="0"  cellpadding="0" cellspacing="0" class="payment_list_table ">
                            <thead>   
                                <tr>
                                    <td style="text-align: center"><fmt:message key='COLLECT_CALENDAR_LABEL_日期' bundle='${bundle}'/></td> 
                            <td style="text-align: center"><fmt:message key='COLLECT_CALENDAR_LABEL_账户姓名' bundle='${bundle}'/></td> 
                            <td style="text-align: center"><fmt:message key='COLLECT_CALENDAR_LABEL_公司组织' bundle='${bundle}'/></td> 
                            <td style="text-align: center"><fmt:message key='COLLECT_CALENDAR_LABEL_活动数量' bundle='${bundle}'/></td>
                            <td style="text-align: center"><input id="detail_edit_check_all" type="checkbox" /></td>
                            </tr> 
                            </thead>
                            <tbody>
                            <c:choose>
                                <c:when test="${not empty userAccountList}">
                                    <c:forEach var="userAccount" items="${userAccountList}" varStatus="status">
                                        <tr <c:if test="${status.count%2!=0}">class="white"</c:if>>
                                        <td style="text-align: center"><fmt:formatDate value='${userAccount.createDate}'type='date' pattern='yyyy.MM.dd'/></td>
                                        <td style="text-align: center">${userAccount.name}</td>
                                        <td style="text-align: center">${userAccount.company}</td>
                                        <td style="text-align: center">${userAccount.getEventList().size()}</td>
                                        <td style="text-align: center"><input type="checkbox" name="user_email_${userAccount.email}" value="${userAccount.email}" /></td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr class="white">
                                        <td colspan="5"><div class="nolist" style="margin: 25px 25px 40px 25px"><fmt:message key='COLLECT_CALENDAR_TEXT_无结果' bundle='${bundle}'/></div></td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                            </tbody>
                        </table>
                    </c:if>
                </form>
            </div>
        </div>
    </div> 
</div>
<jsp:include page="/WEB-INF/public/z_footer.jsp"/>
<script type="text/javascript">
    $(document).ready(
    function(){
        Calendar.initCalendar();
    }
);
</script>

<%@include file="/WEB-INF/public/z_footer_close.html" %>
