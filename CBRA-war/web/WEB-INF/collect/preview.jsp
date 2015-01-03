<%-- 
    Document   : 付款预览
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/collect/z_collect_public_action.jsp" %>
<jsp:include page="/WEB-INF/public/z_header.jsp"/>
<c:choose>
    <c:when test="${fundCollection.type=='EVENT'}">
    </c:when>
    <c:otherwise>
        <div class="BlueBox">
            <div class="BlueBoxTitle">
                <jsp:include page="/WEB-INF/collect/z_collect_header.jsp"/>
                <div id="collect_link_tips" style="display:none">
                    <div class="TextAlignRight"><img src="/images/collection/pop_06.gif" width="16" height="16" class="popclose" onclick="Collect.closeCollectLinkTips();"/></div>   
                        <fmt:message key='COLLECT_SEND_提示信息' bundle='${bundle}'>
                            <fmt:param value="${fundCollection.webId}"/>
                        </fmt:message>
                </div>        
            </div>
            <div class="BlueBoxContent826">
                <div class="DetailHeader">
                    <jsp:include page="/WEB-INF/collect/z_collect_menu.jsp">
                        <jsp:param name="menuType" value="PREVIEW"/>
                    </jsp:include>
                </div>
            
            <jsp:include page="/WEB-INF/payment/z_payment.jsp">
                <jsp:param name="fromPage" value="PREVIEW" />
            </jsp:include></div>
        </div>

    </c:otherwise>
</c:choose>
<jsp:include page="/WEB-INF/public/z_footer.jsp"/> 
<script type="text/javascript">
    $(document).ready(
    function(){
        var isInitCollectLinkTips = YpCookie.getCookie("init_collect_link_tips");
        if(isInitCollectLinkTips == "true") {
            Collect.initCollectLinkTips();
            $("#collect_link").trigger("mouseover");
            YpCookie.removeCookie("init_collect_link_tips", "/");
        }
        
    });   
</script>
<%@include file="/WEB-INF/public/z_footer_close.html" %> 
