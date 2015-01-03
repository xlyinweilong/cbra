<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%-- 
    Document   : 编辑收款
    Created on : Apr 10, 2011, 8:01:10 PM
    Author     : HUXIAOFENG
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/collect/z_collect_public_action.jsp" %>
<jsp:include page="/WEB-INF/public/z_header.jsp"/>
<div class="BlueBox">
    <div class="BlueBoxTitle">
        <jsp:include page="/WEB-INF/collect/z_collect_header.jsp"/>
    </div>
    <div class="BlueBoxContent826">
        <div class="DetailHeader">
            <jsp:include page="/WEB-INF/collect/z_collect_menu.jsp">
                <jsp:param name="menuType" value="EDIT"/>
            </jsp:include>
        </div>
        <div id="detail_edit" >
            <%@include file="/WEB-INF/collect/z_collect_create_or_edit.jsp" %>
        </div>
    </div>            
</div>
<script type="text/javascript">
    $(document).ready(
    function(){
        window.setInterval ( "keepSession()", 20*60*1000 );
    }); 
</script>
<jsp:include page="/WEB-INF/public/z_footer.jsp"/>      
<%@include file="/WEB-INF/public/z_footer_close.html" %> 
