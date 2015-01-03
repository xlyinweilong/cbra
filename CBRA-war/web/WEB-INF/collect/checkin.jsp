<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%-- 
    Document   : checkin
    Created on : Nov 13, 2012, 6:16:12 PM
    Author     : Yin.Weilong
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="cn.yoopay.entity.*"%>
<%@include file="/WEB-INF/collect/z_collect_public_action.jsp" %>
<jsp:include page="/WEB-INF/public/z_header.jsp">
    <jsp:param name="current_page" value="checkin"></jsp:param>
</jsp:include>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">

<div class="BlueBox">
    <div class="BlueBoxTitle">
        <jsp:include page="/WEB-INF/collect/z_collect_header.jsp"/>
    </div>


    <div class="BlueBoxContent826">
        <div class="DetailHeader">
            <jsp:include page="/WEB-INF/collect/z_collect_menu.jsp">
                <jsp:param name="menuType" value="CHECKIN"/>
            </jsp:include> 
        </div>
        <c:choose>
            <c:when test="${serviceStatus.checkinEnabled}">
                <%--有checkin权限的显示内容--%>
                <div class="BlueBox_Gray CollectCheckin">
                    <dl>
                        <dt><span><fmt:message key='COLLECT_CHECKIN_LABEL_第一步' bundle='${bundle}'/>：</span><fmt:message key='COLLECT_CHECKIN_LABEL_设置签到密码' bundle='${bundle}'/></dt>
                        <dd>
                        <input id="checkin_passwd1" class="CollectCheckinInput" <c:choose><c:when test="${empty fundCollection.checkinPasswd}">type="text" onfocus="Checkin.fouceCheckinPassword('checkin_passwd1')" value="<fmt:message key='COLLECT_CHECKIN_LABEL_密码' bundle='${bundle}'/>" style="color:#999999;"</c:when><c:otherwise>type="password" value="*****" disabled="disabled"</c:otherwise></c:choose> />
                        <input id="checkin_passwd2" class="CollectCheckinInput" <c:choose><c:when test="${empty fundCollection.checkinPasswd}">type="text" onfocus="Checkin.fouceCheckinPassword('checkin_passwd2')" value="<fmt:message key='COLLECT_CHECKIN_LABEL_重复' bundle='${bundle}'/>" style="color:#999999;"</c:when><c:otherwise>type="password" value="*****" style="display:none"</c:otherwise></c:choose> />
                        <input id="checkin_passwd_button" type="button" <c:if test="${not empty fundCollection.checkinPasswd}">style="display:none"</c:if> id="checkin_passwd_button" class="collection_button" onclick="Checkin.setCheckinPassword('${fundCollection.webId}')" value="<fmt:message key='COLLECT_CHECKIN_LABEL_保存' bundle='${bundle}'/>" />
                        <a id="checkin_passwd_link" <c:if test="${empty fundCollection.checkinPasswd}">style="display:none"</c:if> href="javascript:Checkin.resetCheckinPassword()" ><fmt:message key='COLLECT_CHECKIN_LABEL_重置密码' bundle='${bundle}'/></a>
                        <a id="checkin_passwd_link_cancel" href="javascript:Checkin.cancelResetCheckinPassword()" style="display:none" onclick=""><fmt:message key='COLLECT_CHECKIN_LABEL_取消' bundle='${bundle}'/></a>
                        </dd>
                    </dl>
                    <dl id="checkin_set2" <c:if test="${empty fundCollection.checkinPasswd}">style="display:none"</c:if> >
                        <dt><span><fmt:message key='COLLECT_CHECKIN_LABEL_第二步' bundle='${bundle}'/>：</span><fmt:message key='COLLECT_CHECKIN_LABEL_开启签到系统' bundle='${bundle}'/></dt>
                        <dd>
                        <input id="checkin_enable_off" name="checkin_enable" onclick="Checkin.showCheckinModel('checkin_system_off');return false;" type="radio" value="CHECKIN_ENABLED" <c:if test="${!fundCollection.checkinEnabled}">checked="true"</c:if> /><fmt:message key="COLLECT_CHECKIN_LABEL_关闭" bundle="${bundle}"/>　　　　<input id="checkin_enable_on" name="checkin_enable" onclick="Checkin.showCheckinModel('checkin_system_on');return false;" type="radio" value="CHECKIN_ENABLED" <c:if test="${fundCollection.checkinEnabled}">checked="true"</c:if> /><fmt:message key="COLLECT_CHECKIN_LABEL_开启" bundle="${bundle}"/>
                        </dd>
                    </dl>
                    <dl id="checkin_set3" <c:if test="${empty fundCollection.checkinPasswd || !fundCollection.checkinEnabled}">style="display:none"</c:if>>
                        <dt> <span><fmt:message key='COLLECT_CHECKIN_LABEL_第三步' bundle='${bundle}'/>：</span><fmt:message key='COLLECT_CHECKIN_LABEL_请使用以下链接，登录到签到系统' bundle='${bundle}'/></br>
                        </dt>
                        <dd> <input type="text" class="CollectCheckinInputLink" id="checkin_copy_text" value="https://yoopay.cn/checkin/e/${fundCollection.webId}" size="50" /><input type="button" class="collection_button" id="checkin_copy_link" name="" value="<fmt:message key='COLLECT_CHECKIN_LABEL_复制' bundle='${bundle}'/>" />
                        </dd>
                    </dl>
                </div>
            </c:when>
            <c:otherwise>
                <%--没有checkin权限的显示内容--%>
                <div class="BlueBox_Gray MarginTop10 ">
                    <fmt:message key='COLLECT_CHECKIN_TEXT_签到默认文字' bundle='${bundle}'/>
                </div>
            </c:otherwise>
        </c:choose>
        <div class="clear"></div>
    </div>
</div>
<%--JavaScript HTML模版 --%>
<div id="checkin_html_templates" style="display:none">
    <%--开启本活动的签到系统--%>
    <div class="" id="checkin_system_on" style="display:none;">
        <span class="hidden_input_container">
            <div style="width: 620px; margin: auto">
                <fmt:message key='COLLECT_CHECKIN_LABEL_开启本活动的签到系统' bundle='${bundle}'/>
                <p class="MarginTop10 TextAlignRight">
                    <a href="javascript:Checkin.closeCheckinModel('checkin_system_on')"><fmt:message key='GLOBAL_取消' bundle='${bundle}'/></a>&nbsp;&nbsp;
                    <input type="button" class="collection_button" onclick="Checkin.setCheckinEnabled('${fundCollection.webId}', 'on','checkin_enable_on')" value="<fmt:message key='COLLECT_CHECKIN_HTML_开启' bundle='${bundle}'/>"/>
                </p>
            </div>
        </span>
    </div>
    <%--关闭本活动的签到系统--%>
    <div class="" id="checkin_system_off" style="display:none;">
        <span class="hidden_input_container">
            <div style="width: 620px; margin: auto">
                <fmt:message key='COLLECT_CHECKIN_LABEL_关闭本活动的签到系统' bundle='${bundle}'/>
                <p class="MarginTop10 TextAlignRight">
                    <a href="javascript:Checkin.closeCheckinModel('checkin_system_off')"><fmt:message key='GLOBAL_取消' bundle='${bundle}'/></a>&nbsp;&nbsp;
                    <input type="button" class="collection_button" onclick="Checkin.setCheckinEnabled('${fundCollection.webId}', 'off','checkin_enable_off')" value="<fmt:message key='COLLECT_CHECKIN_HTML_关闭' bundle='${bundle}'/>"/>
                </p>
            </div>
        </span>
    </div>
</div>
<%--<c:if test="${!serviceStatus.checkinEnabled}">onclick="Checkin.openServiceDialog();return false;"</c:if>--%>
<%--<div id="chekin_service_dialog" style="display:none;">  
    <div>
        <div class="MarginTop10">
            <fmt:message key='COLLECT_CHECKIN_LABEL_签到系统只对专业版用户开放' bundle='${bundle}'>
                <fmt:param value="/ypservice/pay/professional"></fmt:param>
            </fmt:message>
        </div>
        <div class="TextAlignRight MarginTop10"><a href="javascript:void(0);" onclick="Checkin.closeServiceDialog();"><fmt:message key='GLOBAL_取消' bundle='${bundle}'/></a><input type="button" value="<fmt:message key='COLLECT_EDIT_DIALOG_BUTTON_马上升级' bundle='${bundle}'/>" class="collection_button MarginL7" onclick="window.open('/ypservice/pay/professional')"/></div>
    </div>
</div>--%>
<script type="text/javascript">
    $(document).ready(function(){
        Checkin.initTextCopy();
    });
</script>
<jsp:include page="/WEB-INF/public/z_footer.jsp"/> 
<%@include file="/WEB-INF/public/z_footer_close.html" %>
