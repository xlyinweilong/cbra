<%-- 
    Document   : widget
    Created on : Jan 16, 2013, 3:02:29 PM
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
<jsp:include page="/WEB-INF/public/z_header.jsp">
    <jsp:param name="current_page" value="calendar_widget"></jsp:param>
</jsp:include>
<div class="BlueBox">
    <div class="BlueBoxTitle">
        <fmt:message key='COLLECT_CALENDAR_TEXT_活动日历' bundle='${bundle}'/>
    </div>
    <div class="BlueBoxContent826">
        <div class="DetailHeader">
            <jsp:include page="/WEB-INF/calendar/z_calendar_menu.jsp">
                <jsp:param name="menuType" value="WIDGET"/>
            </jsp:include> 
        </div>
        <div id="detail_edit">
            <div class=" bold MarginTop20"> <fmt:message key="COLLECT_CALENDAR_TEXT_我的活动日历说明" bundle="${bundle}"/></div>
            <div class="BlueBox_Gray MarginTop10 ">
                <div class="PaddingRL20">
                    <div style="color:#4FB039; margin-top: 10px;"> 
                        <fmt:message key="COLLECT_WIDGET_TEXT_请把以下HTML代码添加到您的网站上" bundle="${bundle}"/> 
                        <input type="button" id="calendar_widget_copy_link" value="<fmt:message key='COLLECT_WIDGET_TEXT_复制到剪切板' bundle='${bundle}'/>">
                    </div>
                    <div class="MarginTop10">
                        <textarea rows="6" readonly="true" style="width:100%;font-size: 12px" id="calendar_widget_code_container">
<script type="text/javascript" src="<%=Config.HTTP_WIDGET_URL_BASE%>/scripts/easyXDM.min.js"></script> <script type="text/javascript"> var REMOTE = "<%=Config.HTTP_WIDGET_URL_BASE%>"; var transport = new easyXDM.Socket(/** The configuration */{ remote: REMOTE + "/proxy.html?url=/calendar/event_agenda%3Fowner_email%3D${user.email}", swf: REMOTE + "/scripts/easyxdm.swf", container: "embedded", onMessage: function(message, origin){ this.container.getElementsByTagName("iframe")[0].style.width = "100%"; this.container.getElementsByTagName("iframe")[0].style.height = parseInt(message)  + 40 + "px"; } }); </script> <div id="embedded"></div>
                        </textarea>
                    </div>
                    <div style="color:#4FB039; margin-top: 20px;">
                        <fmt:message key="COLLECT_WIDGET_TEXT_预览" bundle="${bundle}"/>
                        <span style="float:right" id="calendar_message_link"><img style="margin-right: 2px" src="/images/calendar_icon.png" /><a href="#"><fmt:message key='COLLECT_WIDGET_TEXT_显示其他主办方的活动' bundle='${bundle}'/></a></span>
                        <div class="Lboxcontent Padding15" style="display:none">
                            <p class="text16 ColorBlue MarginR10 bold" id="calendar_message_link_title"><fmt:message key='COLLECT_WIDGET_TEXT_TITLE_显示其他主办方的活动' bundle='${bundle}'/></p><p class="text12" id="calendar_message_link_contents"><fmt:message key='COLLECT_WIDGET_TEXT_CONTENTS_显示其他主办方的活动' bundle='${bundle}'/></p> 
                        </div>
                    </div>
                    <div id="calendar_preview_container">
                    </div>
                </div>
            </div>
        </div>
    </div> 
</div>
<jsp:include page="/WEB-INF/public/z_footer.jsp"/>
<script type="text/javascript">
    $(document).ready(
    function(){
        CalendarWidget.initWidgetTips();
        CalendarWidget.initWidgetCopyToClipBoard();
        CalendarWidget.initWidgetPreview();
    }
);
</script>
<%@include file="/WEB-INF/public/z_footer_close.html" %>
