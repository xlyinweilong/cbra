<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@include file="/WEB-INF/collect/z_collect_public_action.jsp" %>
<jsp:include page="/WEB-INF/public/z_header.jsp"/>
<div class="BlueBox">
    <div class="BlueBoxTitle">
        <jsp:include page="/WEB-INF/collect/z_collect_header.jsp"/>
    </div>
    <div class="BlueBoxContent826">
        <div class="DetailHeader">
            <jsp:include page="/WEB-INF/collect/z_collect_menu.jsp">
                <jsp:param name="menuType" value="PROMOTE_INDEX"/>
            </jsp:include>
        </div>
        <div style="color:#696a6b; font-size: 16px; padding-top:20px;"><fmt:message key='COLLECT_EDIT_MSG_通过短信或邮件的方式向您的用户发送邀请、通知及活动更新' bundle='${bundle}'/>
            <div class="BlueBox_Gray MarginTop10">
                <div class="promoteIndex">
                    <p><fmt:message key='PROMOTE_INDEX_LABEL_请选择您的推广方式' bundle='${bundle}'/></p>
                    <ul>
                        <a id="collect_promote_index_sms" href="/collect/short_message_promote/${fundCollection.webId}"><li><span><fmt:message key='COLLECT_EDIT_MSG_短信推广' bundle='${bundle}'/></span><br/><fmt:message key='COLLECT_EDIT_MSG_短信推广每条0.1元' bundle='${bundle}'/></li></a>
                        <a id="collect_promote_index_email" href="/collect/promote/${fundCollection.webId}"  class="right"><li><span><fmt:message key='COLLECT_EDIT_MSG_邮件推广' bundle='${bundle}'/></span><br/><fmt:message key='COLLECT_EDIT_MSG_邮件推广每封0.1元' bundle='${bundle}'/></li></a>
                    </ul>
                    <div class="clear"></div>

                </div>
            </div> 
        </div>           
    </div>

</div>
<jsp:include page="/WEB-INF/public/z_footer.jsp"/> 
<script type="text/javascript">
    $(document).ready(
    function(){
        // init
        CollectPromote.initCollectPromoteIndex();
    }
);
</script>
<%@include file="/WEB-INF/public/z_footer_close.html" %> 
