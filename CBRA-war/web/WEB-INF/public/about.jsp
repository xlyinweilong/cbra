<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%-- 
    Document   : about
    Created on : Apr 29, 2011, 2:14:21 PM
    Author     : WangShuai
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/public/z_header.jsp"/>
<jsp:include page="/WEB-INF/public/z_about_navi.jsp"/>
<div class="aboutus_right">
    <p class="aboutus_p"><fmt:message key="PUBLIC_ABOUT_TEXT" bundle="${bundle}"/></p>
    <p class="aboutus_p"><fmt:message key="PUBLIC_ABOUT_PRODUCT_INTRO_DOWNLOAD" bundle="${bundle}"/></p>
    <a  
        href="/flash/yoopay_flash.flv"
        style="display:block;width:754px;height:416px"  
        id="player" > 
</a> </div>
<div class="clear"></div>
<jsp:include page="/WEB-INF/public/z_footer.jsp"/> 
<script type="text/javascript" src="/scripts/flowplayer-3.2.6.min.js"></script>
<script type="text/javascript">
    flowplayer("player", "/flash/flowplayer.commercial-3.2.7.swf",{
        clip : {			
            autoPlay: false,
            autoBuffering: true
        },
        plugins: {			// load one or more plugins
            controls: {
                
                scrubber: true,  //时间进度条
                url: '/flash/flowplayer.controls-3.2.5.swf',	// always: where to find the Flash object
                backgroundColor: '#aedaff',
                tooltips: {				// this plugin object exposes a 'tooltips' object
                    buttons: true,
                    fullscreen: 'Enter Fullscreen mode'
                }
            }
        },
        key: '#$8a2c37636727adbb8db'
    });
</script>
<%@include file="/WEB-INF/public/z_footer_close.html" %> 
