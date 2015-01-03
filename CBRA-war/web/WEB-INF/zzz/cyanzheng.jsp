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
        <div class="wrongMessage" style="display:none"></div>
        <div class="loadingMessage" style="display:none">请稍候...<img alt="" src="/images/032.gif"></div>
    </div>
    <div class="Padding30">
        <div class="FloatLeft BlueBoxLeft"><img src="/images/company_logo.png" width="100" height="91" /></div>
        <div class="FloatLeft BlueBoxContent">
       
            <div class="creditcard" style=" width:552px;">
                <dl><dd style=" width:552px; text-align:left">
                                <p>上传logo</p>
              <input name="input" type="file" class="Input450 Input463"/>
            </dd>
           </dl>
            </div>
            <div class="creditcard FloatLeft">
            <dl>
                            <dd>
                                <p>公司团体名称</p>
                                <input type="text" class="Input450 Input240" >
                            </dd>
                            <dd>
                                <p>证件种类</p>
                                <div class="card_kinds">
                                  <select name="select"  class="Input450 Input240 select240" >
                                    <option>身份证</option>
                                    <option>驾照</option>
                                  </select>
                                </div>
                            </dd>
                            <dd>
                                <p>证件号码</p>
                                <input type="text" class="Input450 Input240" >
                            </dd>
                            <dd>
                                <p>上传证件</p>
                                <input  type="file" class="Input450 Input240" >
                            </dd>
                            </dl>
                            
                            </div>
                             <div class="creditcard FloatRight">
                           <dl> 
                           <dd>
                                <p>官方网址</p>
                                <input type="text" class="Input450 Input240" >
                            </dd>
                            <dd>
                                <p>地址</p>
                                <input type="text" class="Input450 Input240" >
                            </dd>
                            <dd>
                                <p>电话</p>
                                <input type="text" class="Input450 Input240" >
                            </dd>
                            <dd>
                                <p>传真</p>
                                <input type="text" class="Input450 Input240" >
                            </dd>
                            <dd><input type="button" name="Submit" value="验证" class="collection_button"/></dd>
                            </dl>
                            
                            
                            </div>
                            <div class="clear"></div>

        </div> 
        <div class="clear"></div>
        
    </div>
</div>
<jsp:include page="/WEB-INF/public/z_footer.jsp"/> <%@include file="/WEB-INF/public/z_footer_close.html" %> 



