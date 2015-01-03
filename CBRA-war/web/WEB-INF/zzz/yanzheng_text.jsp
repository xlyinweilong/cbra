<%-- 
    Document   : cyanzheng
    Created on : May 23, 2011, 6:05:01 PM
    Author     : lining
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<jsp:include page="/WEB-INF/public/z_header.jsp"/>
<div class="BlueBox">
   
<div class="noticeMessage">
        <div class="successMessage">1.验证中 2.验证通过，如需重新验证请点击 <a href="#" class="bold">重新验证</a></div>
        <div class="wrongMessage">验证没有通过，照片不符，如需重新验证请点击 <a href="#" class="bold">重新验证</a></div>
        <div class="loadingMessage" style="display:none">请稍候...<img alt="" src="/images/032.gif"></div>
    </div>
     <div class="Padding30">
<div class="FloatLeft BlueBoxLeft"><img src="/images/photo.png" width="100" height="91" /></div>
            <div class="FloatLeft BlueBoxContent"> 
           
            <div class="sk-item TextAlignLeft bold"> 
                <label class="sk-label">证件种类:</label>  
                身份证
              
            </div>
            <div class="sk-item TextAlignLeft bold">
                <label class="sk-label">号码:</label>
                123456789654123587
            </div>

            <div class="sk-item TextAlignLeft bold">
                <label class="sk-label">证件扫描件:</label>
              已上传
            </div>
      
    </div>
<div class="FloatLeft"><img src="/images/yanzheng.gif"/></div>
<div class="clear"></div>
    </div>
</div>
<jsp:include page="/WEB-INF/public/z_footer.jsp"/> <%@include file="/WEB-INF/public/z_footer_close.html" %> 



