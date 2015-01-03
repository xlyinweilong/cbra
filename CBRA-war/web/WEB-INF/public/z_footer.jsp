<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%-- 
    Document   : footer_login
    Created on : Mar 31, 2011, 6:03:55 PM
    Author     : HUXIAOFENG
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
</div><%-- 结束Content Div --%>

<c:choose>
    <c:when test="${not empty  eventPaymentPage}">
        <%@include file="/WEB-INF/public/z_event_footer.jsp" %> 
    </c:when>
    <c:otherwise>
        <div class="footer">
            <div class="footer_inner">
                <span><a href="/public/about" title=""><fmt:message key="PULIC_Z_FOOTER_LINK_关于友付" bundle="${bundle}"/></a><em>|</em><a href="/public/user" title=""><fmt:message key="PULIC_Z_FOOTER_TEXT_用户评价" bundle="${bundle}"/></a><em>|</em><a href="/public/alliance"><fmt:message key="PULIC_Z_FOOTER_LINK_活动云平台" bundle="${bundle}"/></a><em>|</em><a href="/public/widget"><fmt:message key="PULIC_Z_FOOTER_LINK_友付微件" bundle="${bundle}"/></a><em>|</em><a href="/public/api"><fmt:message key="PULIC_Z_FOOTER_LINK_友付API" bundle="${bundle}"/></a><em>|</em><a href="/public/faq" title=""><fmt:message key="PULIC_Z_FOOTER_LINK_常见问题" bundle="${bundle}"/></a><em>|</em><a href="/public/campaign" title=""><fmt:message key="PULIC_Z_FOOTER_LINK_支付方式" bundle="${bundle}"/></a><em>|</em><a href="/public/verification" title=""><fmt:message key="GLOBAL_MENU_ACCOUNT_SEAL" bundle="${bundle}"/></a><em>|</em><a href="/public/rates" title=""><fmt:message key="PULIC_Z_FOOTER_LINK_友付费率" bundle="${bundle}"/></a><em>|</em><a href="/public/legal"><fmt:message key="PULIC_Z_FOOTER_LINK_法律声明" bundle="${bundle}"/></a><em>|</em><a href="/public/contact#" title=""><fmt:message key="PULIC_Z_FOOTER_LINK_联系友付" bundle="${bundle}"/></a></span>
                <span class="footer_span"><fmt:message key="PULIC_Z_FOOTER_TEXT_版权所有" bundle="${bundle}"/><em><fmt:message key="PULIC_Z_FOOTER_TEXT_京公网安备" bundle="${bundle}"/></em><fmt:message key="PULIC_Z_FOOTER_TEXT_京ICP备" bundle="${bundle}"/></span>

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
                <div class="TextAlignRight"><input type="submit" name="Submit" value="<fmt:message key='GLOBAL_关闭' bundle='${bundle}'/>" class="collection_button" onclick="verifyDialog.close();" id="verify_dialog_close_btn"/></div>
            </div>
            <div id="send_verify_email_success" style="display: none;">
                <fmt:message key="PULIC_Z_FOOTER_TEXT_确认邮件已发出" bundle="${bundle}"/> 
                <fmt:message key="PULIC_Z_FOOTER_TEXT_如果您还没有收到确认邮件" bundle="${bundle}"/>
            </div>
        </div>
        <c:if test="${user.accountType=='USER'}">
            <div id="signup_company_account_tip_dialog" style="display:none;line-height: 2;padding-left: 10px;padding-right: 10px">
                <div>
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
                var isEmailValid = ${sessionScope.user.verified};
                if(!isEmailValid){
                    $("input,textarea,select").click(function(event){
                        var ele = $(event.target);
                        if(ele.attr("id")=="verify_dialog_close_btn"){
                            return;
                        }
                        verifyDialog.open();
                        event.stopPropagation();
                        event.preventDefault();
                    }) 
                }
            });   
        </script>
    </c:if>
    <%-- 
    所有页面内Javascript内容都在页面末尾，但是在</body>结束之前。
    这个footer文件中没有</body>等结束标签，这些结束标签是在footer_close文件中。 
    所以，页面内Javascript都放在include footer.jsp之后，最后再include footer_close.jsp来结束<body>和<html>。
    --%>
</c:otherwise>
</c:choose>

