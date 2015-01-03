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
        <div class="successMessage">信息为什么要验证，验证后会发生什么事</div>
        <div class="wrongMessage" style="display:none">信息类</div>
        <div class="loadingMessage" style="display:none">请稍候...<img alt="" src="/images/032.gif"></div>
    </div>
    <div class="Padding30">
<div class="FloatLeft BlueBoxLeft"><img src="/images/photo.png" width="100" height="91" /></div>
            <div class="FloatLeft BlueBoxContent">
            <div class="sk-item">
                <label class="sk-label">上传头像</label>
              <input name="input" type="file" class="Input450 Input463"/>
            </div>

            <div class="sk-item">
                <label class="sk-label">证件种类</label>  
                <select name=""class="Input450 Select465"></select>
              
            </div>
            <div class="sk-item">
                <label class="sk-label">号码</label>
                <input type="text" class="Input450" />
            </div>
 <div class="sk-item">
                <label class="sk-label">上传证件扫描件</label>
              <input name="input" type="file" class="Input450 Input463"/>
            </div>
            <div class="sk-item">
                 <label class="sk-label"></label>
                 <input type="button" name="Submit" value="验证" class="collection_button"/>
            </div>
      
    </div> 
<div class="clear"></div></div>
</div>
<jsp:include page="/WEB-INF/public/z_footer.jsp"/> <%@include file="/WEB-INF/public/z_footer_close.html" %> 



