<%-- 
    Document   : 创建收款
    Created on : Mar 27, 2012, 4:33:00 PM
    Author     : Swang
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%--Set Menu --%>
<%@include file="/WEB-INF/collect/z_collect_public_action.jsp" %>
<jsp:include page="/WEB-INF/public/z_header.jsp"/>
<div class="BlueBox">
    <div class="BlueBoxContent826">
        <div id="detail_edit" >
            <%@include file="/WEB-INF/collect/z_collect_create_or_edit.jsp" %>
        </div>
    </div>  
</div>
        
<script type="text/javascript">
    $(document).ready(
    function(){
        setInterval ( "keepSession()", 20*60*1000 );
    }); 
</script>
<jsp:include page="/WEB-INF/public/z_footer.jsp"/>      
<%@include file="/WEB-INF/public/z_footer_close.html" %> 

