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
            <div class="BlueBoxContent">
            <div class="sk-item">
                <label class="sk-label fontgreen">收款类型</label>  
                <select name=""class="Input450 Select465"></select>              
            </div>
            <div class="sk-item">
                <label class="sk-label fontgreen">活动名称</label>
                <input type="text" class="Input450" />
            </div>
            <div class="sk-item">
                <label class="sk-label fontgreen">时间</label>
                <input type="text" class="Input450" />
            </div>
            <div class="sk-item">
                <label class="sk-label fontgreen">地点</label>
                <input type="text" class="Input450" />
            </div>           
            <div name="checkbox_div" style="display:none"><input type="checkbox" checked="checked" name="price_checkbox" value="0"></div>
            <div class="sk-item TextAlignLeft ">
                <label class="sk-label fontgreen">票价 </label>                
                <span class="FloatLeft MarginR20"><input type="text" value="" name="unitAmount" class="Input144 shortInput" id="collect_amount" /> 元/人民币</span>
                <span class="FloatLeft">名称</span>
                <input type="text" value="" name="unitAmount" class="Input194 shortInput FloatRight" id="collect_amount" />                
                <div class="clear"></div>
                <div class="add" name="add_price"><a id="href_add_price" onclick="" href="javascript:;">+添加新票价</a></div>
                <div class="sk-explain">例如:    188元/人民币    普通</div>                
            </div>
            <div class="sk-item  TextAlignLeft"> 
                <label class="sk-label fontgreen">折扣价</label>
                <span class="FloatLeft MarginR20"><input type="text" value="" name="unitAmount" class="Input144 shortInput" id="collect_amount" />
                <input type="text" value="" name="unitAmount" class="Input40 shortInput" id="collect_amount" />%</span>
                <span class="FloatLeft">名称</span>
                <input type="text" value="" name="unitAmount" class="Input194 shortInput FloatRight" />
                <div class="clear"></div>
                <div class="add"><a onclick="" id="href_add_discount" href="javascript:;">+添加新折扣码</a></div>
                <div class="sk-explain">例如:    ABCDE　减20%　会员折扣</div>
            </div>
            <div class="sk-item">
                 <label class="sk-label"></label>
                 <input type="button" name="Submit" value="生成链接" class="collection_button"/>
            </div>
            <div class="sk-item TextAlignLeft MarginTop20">
                <label class="sk-label fontgreen">票价 </label>
                <input type="text" value="" name="unitAmount" class="Input144 shortInput" id="collect_amount" /> 元/人民币 
                  <label>名称</label>
                <input type="text" value="" name="unitAmount" class="Input194 shortInput " id="collect_amount" />    
            </div>
            <div class="sk-item TextAlignLeft">
                <label class="sk-label fontgreen">票价 </label>
                <input type="text" value="" name="unitAmount" class="Input144 shortInput" id="collect_amount" /> 元/人民币 
                  <label>名称</label>
                <input type="text" value="" name="unitAmount" class="Input194 shortInput " id="collect_amount" />    
            </div>
    </div> 
<div class="clear"></div></div>
<div class="active_box">
    <div class="money_sail">费用说明</div>
    <div class="BlueBoxContent">
        <dl class="active_dl">
            <dd><span>普通会员</span><span class="TextAlignCenter">￥2000</span><span class="TextAlignRight "><label><select name="select" id="select"><option>2</option></select></label></span><div class="clear"></div></dd>
            <dd><span>VIP会员</span><span class="TextAlignCenter">￥2000</span><span class="TextAlignRight"><label><select name="select" id="select"><option>2</option></select></label></span><div class="clear"></div></dd>
        </dl> 
        <div class="MarginBottom20 MarginTop10 ">
            <div class="FloatLeft count_left">
                <span class="MarginR10">长城会员折扣	减20%</span><a href="#" title="">编辑</a>
            </div>
            <div class="FloatRight TextAlignRight count_right">
                <P><span>小计：</span>  ￥5888</p>
                <P><span>折扣：</span> -￥1880</p>
                <div class="acount_line"></div>
                <P><span>总计：</span>  ￥4000</p>
            </div>
            <div class="clear"></div>
        </div>
    </div>
    <div class="small_bank">        
        <span><a href="#" title=""><img src="/images/collection/charge_21a.gif" /></a></span><span><a href="#" title=""><img src="/images/collection/charge_19a.gif" /></a></span><span><a href="#" title=""><img src="/images/collection/charge_17a.gif" /></a></span><span><a href="#" title=""><img src="/images/collection/charge_15a.gif" /></a></span><span><a href="#" title=""><img src="/images/collection/charge_13a.gif" /></a></span><span><a href="#" title=""><img src="/images/collection/charge_11a.gif" /></a></span><input type="button" name="Submit" value="付款" class="account_input" /> 
    </div>
</div>
</div>
<jsp:include page="/WEB-INF/public/z_footer.jsp"/> <%@include file="/WEB-INF/public/z_footer_close.html" %> 



