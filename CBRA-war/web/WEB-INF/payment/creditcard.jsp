<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : payment_gateway
    Created on : Apr 1, 2011, 10:13:41 PM
    Author     : HUXIAOFENG
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%-- 设置MenuSelection参数 --%>
<%
    request.setAttribute("mainMenuSelection", cn.yoopay.web.support.MenuSelectionEnum.FUNDPAYMENT);
    request.setAttribute("subMenuSelection", cn.yoopay.web.support.MenuSelectionEnum.ACCOUNT_CONTACTS);
%>
<%-- 设置MenuSelection参数结束 --%>

<jsp:include page="/WEB-INF/public/z_header.jsp"/>

<form method="POST" action="">
    <input type="hidden" name="a" value="CREDITCARD_PAYMENT" />
    <c:if test="${postResult.success}">
        <div class="OkMessage">OK Message</div>
    </c:if>
    <c:if test="${!empty postResult.singleErrorMsg}">
        <div class="WrongMessage">${postResult.singleErrorMsg}</div>
    </c:if>
    <div class="box">
        <div class="box-bg">
            <div class="fm-item">
                <label class="fm-label">金额</label>
                <span class="Text20"> ${fundCollection.unitAmount} </span>元
            </div>
            <div class="fm-item">
                <label class="fm-label">付款给</label>
                ${user.name}（${user.email}）</div>
            <div class="fm-item">
                <label class="fm-label">理由</label>${fundCollection.title}
            </div>
            <div class="aa-hline MarginBottom15"></div>
            <div class="fm-item">
                <label class="fm-label">信用卡信息</label>
                <div class="FloatLeft1" style="width:250px;">

                    <dl class="creditcard">
                        <dd>
                            <p>卡号<span class="ColorRed">*</span> <img src="images/visa.png" width="53" height="15" /></p>
                            <input type="text" class="inputinviteSend236" name="acct" id="acct">
                        </dd>
                        <dd style="width:160px;">
                            <p>有效期<span class="ColorRed">*</span></p>

                            <select name="expdate_month" id="expdate_month" class="inputinviteSend90" style="width:50px; height:26px;">
                            </select>
                            <select name="expdate_year" id="expdate_year" class="inputinviteSend90" style="width:80px; height:26px;">
                            </select>
                        </dd>
                        <dd style=" width:50px;float:right; text-align:right">
                            <p>验证码<span class="ColorGreen">*</span></p>
                            <input type="text"  class="inputinviteSend40" name="cvv2" id="cvv2" onfocus="CreditPayment.cvv2InfoShow();">

                        </dd>
                        <dd>
                            <p>姓名<span class="ColorRed">*</span> <span class="colorGray">必须和信用卡上的姓名相同</span></p>
                            <input type="text" class="inputinviteSend236" name="credit_name" id="credit_name"/>
                        </dd>
                        <dd style="width:120px;"></dd>
                    </dl>

                </div>
                <div class="FloatRight1" style="width:250px;">
                    <dl class="creditcard">
                        <dd><p>地址</p><input type="text"  class="inputinviteSend236" name="credit_addr" id="credit_addr"></dd>
                        <dd>
                            <p>邮编</p>
                            <input type="text" class="inputinviteSend236" name="credit_zip" id="credit_zip"/>
                        </dd>

                        <dd style="width:120px;"><p>城市</p>
                            <input type="text" class="inputinviteSend110" name="credit_city" id="credit_city"/>
                        </dd>
                        <dd style=" width:120px; float:right"><p>州/省</p><input type="text" class="inputinviteSend110" id="credit_state" name="credit_state"></dd>


                        <dd style=" text-align:right"><span class="ColorRed">*</span>为必填



                        </dd>
                    </dl>
                </div>

                <div class="clear"></div>
            </div>

            <div class="fm-item">
                <p class="OkMessage">你已成功向胡晓峰（huxiaofeng@hotm ail.com）支付了10元。</p>
            </div>
            <div class="fm-item TextAlignRight">
                <span class="MarginR10">交易ID: 89877896</span><a href="#">查看详情</a>
            </div>
        </div>
    </div>
    <div class="fm-item-button">
        <span class="btnGreen btnGreen-ok" onmouseover="this.className='btnGreen btnGreen-ok-hover';" onmouseout="this.className='btnGreen btnGreen-ok';">
            <input  type="submit" value="支付" />
        </span>

    </div>
</form>

<jsp:include page="/WEB-INF/public/z_footer.jsp"/> <%@include file="/WEB-INF/public/z_footer_close.html" %> 
