<%-- 
    Document   : newjsp
    Created on : May 23, 2011, 4:42:20 PM
    Author     : HUXIAOFENG
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<jsp:include page="/WEB-INF/public/z_header.jsp"/>
<div class="login_box">
    <div class="LoginLeft">

                <p class="text24 ColorBlue bold">一个链接，轻松收款</p>
                <div class="LoginLeftText Height192">友付帮助用户轻松完成各种收款及转款需求，支持网银、支付宝、信用卡等多种支付方式，并提供方便的款项记录、查询、管理功能。</div>
            </div>
    <div id="main3" style="float:right">
                <h3 style="padding-right:28px; padding-left:28px;"><a href="#" class="FloatLeft">个人用户注册</a><a href="/account/login" class="FloatRight">友付用户请登录</a><br clear="clear"/></h3> 
                <div class="noticeMessage">
                    <div class="wrongMessage" style="margin-left:30px;margin-right:25px;" id="signup_wrong_msg_div">

                         
                    </div>
                    <div class="loadingMessage" style="display: none" id="signup_loading_div">
                       注册中请稍候<img src="/images/032.gif" alt="" />
                    </div>
                </div>
                <p><span>公司团体名称</span></p>
                <h5><label><input type="text" class="pop_input3"/></label><em>*</em><div class="clear"></div></h5>
                <p><span>联系人姓名</span><em>管理此账户人的姓名</em></p>
                <h5><label><input type="text" class="pop_input3"/></label><em>*</em><div class="clear"></div></h5>
                <p><span>联系人职务</span><em>管理此账户人的职务</em></p>
                <h5><label><input type="text" class="pop_input3"/></label><em>*</em><div class="clear"></div></h5>
                <p><span>邮箱地址</span></p>
                <h5><label><input type="text" class="pop_input3"/></label><em>*</em><div class="clear"></div></h5>
                <p><span>密码</span></p>
                <h5><label><input type="password" class="pop_input3"/></label><em>*</em><div class="clear"></div></h5>
                <p><span>重复密码</span></p>
                <h5><label><input type="password" class="pop_input3"/></label><em>*</em><div class="clear"></div></h5>
                <h6><label><input type="submit" value="注册" class="pop_button4 collection_button"/></label><div class="clear"></div></h6>						
            </div>
    <div class="clear"></div>
</div>
<jsp:include page="/WEB-INF/public/z_footer.jsp"/> <%@include file="/WEB-INF/public/z_footer_close.html" %> 