<%-- 
    Document   : 2
    Created on : Jun 27, 2011, 10:06:15 AM
    Author     : lining
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<jsp:include page="/WEB-INF/public/z_header.jsp"/>
<div class="BlueBox">
  <div class="BlueBox_Gray">
    
    <div class="BlueBoxContent826">
    <div class="FloatLeft BlueBoxLeft">

        <div class="photo">
            
                
                    <img src="/logo/seal_f189e629c50e0aad3a0bf2b8c2deaeaf.jpg"/>
                
                
                
        </div>

        <div style="float: right;width: 86px;text-align: center">
            
                
                    
                    <a href="/user/77954355"><img src="/images/yanzheng_s.gif" /></a>
                    
                    
                 
            
        </div>
    </div>
    <div class="FloatLeft BlueBoxContent">
                <div>
                    <span class="FloatLeft text24 bold" style="width:470px;">ss</span>
                    <span class="FloatRight ColorGreen bold"><a title="" href="#">编辑</a></span>
                    <div class="clear"></div>
                </div>  
                <div class="text16">
                <div class="sk-item3 TextAlignLeft">
                 <label class="sk-label3">时间：</label>2011年12月22日</div> 
                 <div class="sk-item3 TextAlignLeft">
                 <label class="sk-label3 ">地点：</label>北京</div> 
                 <div class="sk-item3 TextAlignLeft">
                 <label class="sk-label3">主办方：</label>北京某某公司</div> 
                 
                
                 
                </div>
                <div id="collection_detail_table" class="DetailBorderTop" style="display: none">
                    &#20013;&#38388;&#20215;&#26684;&#20013;&#38388;&#20215;&#26684;&#20013;&#38388;&#20215;&#26684;&#20013;&#38388;&#20215;&#26684;&#20013;&#38388;&#20215;&#26684;&#20013;&#38388;&#20215;&#26684;&#20013;&#38388;&#20215;&#26684;&#20013;&#38388;&#20215;&#26684;&#20013;&#38388;&#20215;&#26684;&#20013;&#38388;&#20215;&#26684;&#20013;&#38388;&#20215;&#26684;&#20013;&#38388;&#20215;&#26684;
                </div>

                <div id="viewDiscountCode" style="display:none">
                    注意折扣码不会随收款链接发出。<br></br>
                    
                        九折:101111&nbsp;折扣10%<br></br>
                    
                        <input type="button" onclick="viewDiscountCode.close();" value="关闭"/>
                </div>
            
            
        

    </div>
    <div class="clear"></div>
</div>
</div> 
    
    <div class="BlueBoxContent826">
        <div class="active_box">
    <div class="money_sail">费用说明</div>
    <div class="BlueBoxContent">
        <dl class="active_dl">
            <dd><span>普通会员</span><span class="TextAlignCenter">￥2000</span><span class="TextAlignRight "><label><select name="select" id="select"><option>2</option></select></label></span><div class="clear"></div></dd>
            <dd><span>VIP会员</span><span class="TextAlignCenter">￥2000</span><span class="TextAlignRight"><label><select name="select" id="select"><option>2</option></select></label></span><div class="clear"></div></dd>
        </dl> 
        <div class="MarginBottom20 MarginTop10 ">
            <div class="FloatLeft count_left">
                <a href="#" title="">我有折扣码</a>
                <span class="MarginR10"><input name="" type="text" /></span><a href="#" title="">使用</a>
                <span class="MarginR10">长城会员折扣	减20%</span><a href="#" title="">编辑</a>
            </div>
            <div class="FloatRight TextAlignRight count_right">
                <P><span>小计：</span>￥5888</p>
                <P><span>折扣：</span>-￥1880</p>
                <div class="acount_line"></div>
                <P><span>总计：</span>￥4000</p>
            </div>
            <div class="clear"></div>
            
        </div>
    </div>
    
    
    
   
    <div  class='BlueBox_Gray'>
        <div class="BlueBoxContent">
                
                
                    
                        <div class="noticeMessage">
                            <div class="wrongMessage" id="payment_wrong_msg_div">
                            
                            </div>
                            <div class="loadingMessage" style="display: none" id="payment_loading_div">
                                连接中请稍候<img src="/images/032.gif" alt="" />
                            </div>

                        </div>
                        <div class="MarginTop10 link_box"><span class="MarginR10">姓名</span><span>手机</span><div class="clear"></div></div>
                        <div class="FloatLeft"><input type="text" name="name"  disabled="true" value="xxx"class="Input450 Input300 MarginR10"/></div>
                    <div class="FloatRight"><input type="text" name="phone"  disabled="true" value="12365478998" class="Input450 Input300" /></div>        
                        <div class="clear"></div>
                        <div class="link_box"><span class="MarginR10">职务</span><span>公司</span><div class="clear"></div></div>
                        <div class="FloatLeft"><input type="text" name="position"   value=""class="Input450 Input300 MarginR10"/></div>    
                    <div class="FloatRight"><input type="text" name="company"   value=""class="Input450 Input300"/></div>

                        <div class="clear"></div>
                        <div>
                        
                            <textarea  class="TextareaPaymentMessage" id="payer_msg" name="payer_msg" onblur="Effects.toogleFocus('payer_msg', 'blurs','给发起人留言...','', '#909ea4');" onfocus="Effects.toogleFocus('payer_msg','focus','给发起人留言...', '', 'black');">给发起人留言...</textarea>
                            
                        
                    </div>
                        <div style=" line-height:32px;height:32px;" class="MarginTop20"><span class="FloatLeft">选择支付方式</span></div>
        </div>
                    



        
    </div>
    
    
</div>
        
        <div class="active_box">
    <div class="money_sail">活动详情</div>
    <div class="Padding1020">
        雅虎体育讯 国奥1比3负阿曼，奥预赛之路戛然而止。这场败仗之后，相信关于到底该使用谁的争论会立刻展开，因为和前几年国奥相比，老布这次倾向上海队员的思维相当严重，不过更多理智的球迷会确信这样一个结论：中国国奥，无论用谁都差别不大，我们的青训成材率远远落后于日本韩国，更不要说对比职业足球体系更为完善的欧洲列国了。我们出材的也只能叫矬子里拔高个。而更重要的是，投身到我们青训系统的中国小孩
            
        </div>
    </div>
  </div>
        
    </div>
    </div>
</div>
<jsp:include page="/WEB-INF/public/z_footer.jsp"/> <%@include file="/WEB-INF/public/z_footer_close.html" %> 



