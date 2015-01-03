<%-- 
    Document   : widget
    Created on : Feb 7, 2012, 10:24:56 AM
    Author     : Swang
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page import="cn.yoopay.Config"%>
<%@include file="/WEB-INF/collect/z_collect_public_action.jsp" %>
<jsp:include page="/WEB-INF/public/z_header.jsp">
    <jsp:param name="current_page" value="payment_widget"></jsp:param>
</jsp:include>
<div class="BlueBox">
    <div class="BlueBoxTitle">
        <jsp:include page="/WEB-INF/collect/z_collect_header.jsp"/>
    </div>

    <div class="BlueBoxContent826">
        <div class="DetailHeader">
            <jsp:include page="/WEB-INF/collect/z_collect_menu.jsp">
                <jsp:param name="menuType" value="WIDGET"/>
            </jsp:include> 
        </div>
        <div id="detail_edit">
            <div class=" bold MarginTop20"> <fmt:message key="COLLECT_WIDGET_TEXT_友付活动页面整合到您自己的网站上" bundle="${bundle}"/></div>
            <div class="BlueBox_Gray MarginTop10 ">
                <div class="PaddingRL20">
                    <div>
                        <fmt:message key="COLLECT_WIDGET_TEXT_选择宽度" bundle="${bundle}"/><input type="radio" value="small" name="widget_width" onclick="FundPaymentWidget.changeWidthCode(this,'${fundCollection.webId}');"/><fmt:message key="COLLECT_WIDGET_TEXT_小" bundle="${bundle}"/><input type="radio" name="widget_width" value="big" checked="checked" onclick="FundPaymentWidget.changeWidthCode(this,'${fundCollection.webId}');"/><fmt:message key="COLLECT_WIDGET_TEXT_大" bundle="${bundle}"/>
                        &nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" id="widget_attendee_list" value="show" onclick="FundPaymentWidget.changeAttendeeListCode(this,'${fundCollection.webId}');" /><fmt:message key="COLLECT_WIDGET_TEXT_显示参加者列表" bundle="${bundle}"/>
                    </div>
                    <div style="color:#4FB039; margin-top: 10px;"> 
                        <fmt:message key="COLLECT_WIDGET_TEXT_请把以下HTML代码添加到您的网站上" bundle="${bundle}"/> 
                        <input type="button" id="widget_copy_link" value="<fmt:message key='COLLECT_WIDGET_TEXT_复制到剪切板' bundle='${bundle}'/>">
                    </div>
                    <div class="MarginTop10">
                        <textarea rows="6" readonly="true" style="width:100%;font-size: 12px" id="widget_code_container">
<script type="text/javascript" src="<%=Config.HTTP_WIDGET_URL_BASE%>/scripts/easyXDM.min.js"></script> <script type="text/javascript"> var REMOTE = "<%=Config.HTTP_WIDGET_URL_BASE%>"; var transport = new easyXDM.Socket(/** The configuration */{ remote: REMOTE + "/proxy.html?url=/payment/payment_widget/${fundCollection.webId}%3Fwidth%3Dbig%26attendeeList%3Dhideen", swf: REMOTE + "/scripts/easyxdm.swf", container: "embedded", onMessage: function(message, origin){ this.container.getElementsByTagName("iframe")[0].style.width = "100%"; this.container.getElementsByTagName("iframe")[0].style.height = parseInt(message)  + 20 + "px"; } }); </script> <div id="embedded"></div>
                        </textarea>
                    </div>
                    <div style="color:#4FB039; margin-top: 20px;"><fmt:message key="COLLECT_WIDGET_TEXT_预览" bundle="${bundle}"/></div>
                    <div id="preview_container">
                    </div>
                </div>
            </div>
        </div>
    </div>            
</div>
<jsp:include page="/WEB-INF/public/z_footer.jsp"/>
<script type="text/javascript">
    $(document).ready(function(){
        var cid = "${fundCollection.webId}";
        FundPaymentWidget.initWidgetCopyToClipBoard();
        FundPaymentWidget.initWidgetSize(cid);
    });
</script>
<%@include file="/WEB-INF/public/z_footer_close.html" %> 
