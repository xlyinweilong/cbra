<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
</div><%-- 结束Content Div --%>

<div class="footer">
    <div class="footer_inner">
        <li><span class="footer_span"><fmt:message key="PULIC_Z_FOOTER_TEXT_版权所有" bundle="${bundle}"/><em><fmt:message key="PULIC_Z_FOOTER_TEXT_京公网安备" bundle="${bundle}"/></em><fmt:message key="PULIC_Z_FOOTER_TEXT_京ICP备" bundle="${bundle}"/></span>
        </li>
        <a href="/" ><li class="RightLogo"> </li></a>
        <li class="RightText"><fmt:message key="PULIC_Z_EVENT_FOOTER_TEXT_LEFT" bundle="${bundle}"/>            
        </li>
        
        
    </div>
</div>
 
</div> <%-- 结束container Div --%>

<%-- 未登录时附加内容 --%>
<c:if test="${user == null}">
    <div id="loginDialog" style="display:none">
        <jsp:include page="/WEB-INF/account/z_login_dialog.jsp"/>
    </div>
    <div id="signupDialog" style="display:none">
        <jsp:include page="/WEB-INF/account/z_signup_dialog.jsp"/>
    </div>
</c:if>
<c:if test="${user != null}">
    <div id="verifyDialog" style="display:none;line-height: 2;padding-left: 10px;padding-right: 10px">
        <div id="send_verify_email_msg">
            <div class="TextAlignCenter bold"><img src="/images/collection/notice.gif" alt="" class="MarginR10" style=" margin-bottom:-10px;"/><fmt:message key="PULIC_Z_FOOTER_TEXT_在此操作前请验证邮箱" bundle="${bundle}"/></div>
            <div class="MarginTop10"><fmt:message key="PULIC_Z_FOOTER_TEXT_友付已经发送了确认" bundle="${bundle}"/></div>
            <div><fmt:message key="PULIC_Z_FOOTER_TEXT_如果您还没有收到" bundle="${bundle}"/> <a href="javascript:void(0)" onclick="verifyDialog.doVerify();"><fmt:message key="PULIC_Z_FOOTER_TEXT_点击这里" bundle="${bundle}"/></a>，<fmt:message key="PULIC_Z_FOOTER_TEXT_重新发送确认邮件" bundle="${bundle}"/>；</div>
            <div class="TextAlignRight"><input type="submit" name="Submit" value="<fmt:message key='GLOBAL_关闭' bundle='${bundle}'/>" class="collection_button" onclick="verifyDialog.close();"/></div>
        </div>
        <div id="send_verify_email_success" style="display: none;">
            <fmt:message key="PULIC_Z_FOOTER_TEXT_确认邮件已发出" bundle="${bundle}"/> 
            <fmt:message key="PULIC_Z_FOOTER_TEXT_如果您还没有收到确认邮件" bundle="${bundle}"/>
        </div>
    </div>
    <c:if test="${user.accountType=='USER'}">
        <div id="signup_company_account_tip_dialog" style="display:none;line-height: 2;padding-left: 10px;padding-right: 10px">
            <div id="send_verify_email_msg">
                <div class="MarginTop10"><fmt:message key="PULIC_Z_HEADER_怎样注册企业账户" bundle="${bundle}"/></div>
                <div class="TextAlignRight"><input type="submit" name="Submit" value="<fmt:message key='GLOBAL_关闭' bundle='${bundle}'/>" class="collection_button" onclick="SignupCompanyAccountTipDialog.close();"/></div>
            </div>
        </div> 
    </c:if>
    <div id="sendFeedback" style="display:none">        
        <jsp:include page="/WEB-INF/account/z_feedback_dialog.jsp"/>
    </div>
    <div id="sendFeedbackSuccess" style="display:none">
        <div class="TextAlignCenter MarginTop20"><span class="MarginR10"><fmt:message key="PULIC_Z_FOOTER_TEXT_谢谢您的反馈" bundle="${bundle}"/></span>
            <input type="button" name="Submit" value="<fmt:message key='GLOBAL_关闭' bundle='${bundle}'/>" class="collection_button" onclick="FeedbackSuccess.close();"/>
        </div>
    </div>
    <div style="position:fixed; right:0px; top:50%; margin-top:-75px; _position:absolute;z-index:10">
        <a href="javascript:Feedback.open();"><img src="<fmt:message key='PUBLIC_FOOTER_IMG_BUTTON_建议' bundle='${bundle}'/>"></a>
    </div>
</c:if>
<c:if test="${sessionScope.user != null}">
    <script type="text/javascript">
        $(document).ready(
        function(){
            YoopayLink.initHeaderTips();
        });   
    </script>
</c:if>
<script type="text/javascript">
    $(document).ready(
    function(){
        function getMainVersion(version) {
            var array = version.split(".");
            return parseInt(array[0]);
        }
        function addOldVersionWarn(text) {
            var message = Lang.get("GLOBAL_浏览器版本过低");
            var div = $("<div></div>");
            var cssObj = {
                'background-color' : 'yellow',
                'height' : "20px",
                'width' : "100%",
                'text-align' : "center",
                'font-size' : '14px',
                'z-index': '10',
                'position':'absolute',
                'top' : '40px',
                'id' : 'browser_warn_div'
            }
            div.css(cssObj);
            div.html(message);
            $("body").append(div);
        }
        //Browser check
        var Sys = {};
        var ua = navigator.userAgent.toLowerCase();
        var s;
        (s = ua.match(/msie ([\d.]+)/)) ? Sys.ie = s[1] :
            (s = ua.match(/firefox\/([\d.]+)/)) ? Sys.firefox = s[1] :
            (s = ua.match(/chrome\/([\d.]+)/)) ? Sys.chrome = s[1] :
            (s = ua.match(/opera.([\d.]+)/)) ? Sys.opera = s[1] :
            (s = ua.match(/version\/([\d.]+).*safari/)) ? Sys.safari = s[1] : 0;
            
        if (Sys.ie) {
            var version = getMainVersion(Sys.ie);
            if(version <= 5) {
                addOldVersionWarn();
            }
        } else if (Sys.firefox) {
            var version = getMainVersion(Sys.firefox);
            if(version <= 3) {
                addOldVersionWarn();
            }
        } else if (Sys.chrome) {
            var version = getMainVersion(Sys.chrome);
             if(version <= 5) {
                addOldVersionWarn();
            }
        } else if (Sys.opera) {
            var version = getMainVersion(Sys.opera);
            if(version <= 5) {
                addOldVersionWarn();
            }
        } else if (Sys.safari) {
            var version = getMainVersion(Sys.safari);
            if(version <= 1) {
                addOldVersionWarn();
            }
        }
    })
</script>