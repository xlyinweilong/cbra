<%-- 
    Document   : creginfo
    Created on : May 23, 2011, 5:48:47 PM
    Author     : lining
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<jsp:include page="/WEB-INF/public/z_header.jsp"/>
<div class="BlueBox">
    <div class="noticeMessage">
        <div class="successMessage">各类信息</div>
        <div class="wrongMessage" style="display:none"></div>
        <div class="loadingMessage" style="display:none">请稍候...<img alt="" src="/images/032.gif"></div>
    </div>

    <div class="BlueBoxContent">
                
            <div class="sk-item MarginTop30">
                <label class="sk-label">姓名</label>
                <input type="text" class="Input450"/>
            </div>
            <div class="sk-item">
                <label class="sk-label">职务</label>
                <input type="text" class="Input450"/>
            </div>
            <div class="sk-item">
                <label class="sk-label">公司</label>
                <input type="text" class="Input450"/>
            </div>

            <div class="sk-item">
                <label class="sk-label">邮箱地址</label>  
                <input type="text" class="Input450" />
            </div>
            <div class="sk-item">
                <label class="sk-label">手机号</label>
                <input type="text" class="Input450"/>
            </div>

            <div class="sk-item">
                 <label class="sk-label"></label>
                 <input type="button" name="Submit" value="保存" class="collection_button"/>
            </div>
       
    </div>
</div>
<jsp:include page="/WEB-INF/public/z_footer.jsp"/> <%@include file="/WEB-INF/public/z_footer_close.html" %> 