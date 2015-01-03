<%-- 
    Document   : z_footer_widget
    Created on : Feb 6, 2012, 2:40:09 PM
    Author     : Swang
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<script type="text/javascript">
    window.onload = function(){
        resizeIframeHeight();
    };
            
    function resizeIframeHeight() {
        parent.socket.postMessage(document.body.clientHeight || document.body.offsetHeight || document.body.scrollHeight);
        window.setTimeout("resizeIframeHeight()", 250);
    }
</script>
</body>
</html>
