<%-- 
    Document   : alipay_submit
    Created on : Sep 3, 2010, 11:01:35 AM
    Author     : Neo Hu

--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.alipay.config.*"%>
<%@ page import="com.alipay.util.*"%>
<%@ page import="cn.yoopay.entity.*" %>
<%@ page import="cn.yoopay.*" %>

<%
    GatewayPayment payment = (GatewayPayment) request.getAttribute("gatewayPayment");
    String itemSubject = (String) request.getAttribute("itemSubject");
    String itemBody = (String) request.getAttribute("itemBody");
    String buyerEmail = (String) request.getAttribute("buyerEmail");
    String show_url = (String) request.getAttribute("showUrl");
    String notify_url = Config.PAYGATE_ALIPAY_NOTIFY_URL;
    String return_url = Config.PAYGATE_ALIPAY_RETURN_URL;
    String gatewayPaymentSource = payment.getSource().toString();
    pageContext.setAttribute("gatewayPaymentSource", gatewayPaymentSource);
    //System.err.println("return_url="+return_url);
%>

<%

    String get_order = payment.getId().toString();

    String paygateway = "https://www.alipay.com/cooperate/gateway.do?"; //支付接口（不可以修改）
    String service = "create_direct_pay_by_user";//快速付款交易服务（不可以修改）
    String payment_type = "1";//支付宝类型.1代表商品购买（目前填写1即可，不可以修改）
    //AlipyConfig.java中配置信息（不可以修改）
    String input_charset = AlipayConfig.CharSet;
    String sign_type = AlipayConfig.sign_type;
    String seller_email = AlipayConfig.sellerEmail;
    String partner = AlipayConfig.partnerID;
    String key = AlipayConfig.key;

    //订单支付信息
    //以下参数是需要通过支付订单时的订单数据传入进来获得
    //必填参数
    String out_trade_no = get_order;//请与贵网站订单系统中的唯一订单号匹配
    String subject = itemSubject; //订单名称，显示在支付宝收银台里的“商品名称”里，显示在支付宝的交易管理的“商品名称”的列表里。
    String body = itemBody; //订单描述、订单详细、订单备注，显示在支付宝收银台里的“商品描述”里
    String total_fee = String.valueOf(payment.getCNYGatewayAmount()); //订单总金额，显示在支付宝收银台里的“应付总额”里
    /*
     * 以下两个参数paymethod和defaultbank可以选择不使用，如果不使用需要注销，并在Payment类的方法中也要注销
     */
    //扩展功能参数——网银提前
    String paymethod = "directPay"; //默认支付方式，四个值可选：bankPay(网银); cartoon(卡通); directPay(余额); CASH(网点支付)
    String defaultbank = "CMB"; //默认网银代号，代号列表见http://club.alipay.com/read.php?tid=8681379
    //买家支付宝账号- 在跳转后将会填写到登录账号输入框中
    String buyer_email = buyerEmail == null ? "" : buyerEmail.trim();
    String buyer_account_name = buyer_email;
    //System.out.println("buyer_account_name : " + buyer_account_name);
    //POST方式提交支付请求 
    String sign = AlipayService.createPostUrl(paygateway, service,
            sign_type, out_trade_no, input_charset, partner, key,
            show_url, body, total_fee, payment_type, seller_email,
            subject, notify_url, return_url, paymethod, defaultbank, null, buyer_account_name);
    subject = subject.replaceAll("\"","&quot;");
    System.out.println(subject);
%>
<c:choose>
    <c:when test="${not empty gatewayPaymentSource && gatewayPaymentSource eq 'SOURCE_WIDGET'}">
        <jsp:include page="/WEB-INF/public/z_header_widget.jsp"/>
    </c:when>
    <c:otherwise>
        <jsp:include page="/WEB-INF/public/z_header.jsp"/>
    </c:otherwise>
</c:choose>

<form id="alipay_submit_form" method="post" 
      action="https://www.alipay.com/cooperate/gateway.do?_input_charset=<%=AlipayConfig.CharSet%>" <c:if test="${not empty requestFromPage && requestFromPage eq 'widget'}">target="_top"</c:if>>
    <input type=hidden name="body" value="<%=body%>">
    <input type=hidden name="notify_url" value="<%=notify_url%>">
    <input type=hidden name="out_trade_no" value="<%=out_trade_no%>">
    <input type=hidden name="partner" value="<%=partner%>">
    <input type=hidden name="payment_type" value="<%=payment_type%>">
    <input type=hidden name="seller_email" value="<%=seller_email%>">
    <input type=hidden name="service" value="<%=service%>">
    <input type=hidden name="sign" value="<%=sign%>">
    <input type=hidden name="sign_type" value="MD5">
    <input type=hidden name="subject" value="<%=subject%>">
    <input type=hidden name="total_fee" value="<%=total_fee%>">
    <input type=hidden name="show_url" value="<%=show_url%>">
    <input type=hidden name="return_url" value="<%=return_url%>">
    <input type=hidden name="paymethod" value="<%=paymethod%>">
    <input type=hidden name="defaultbank" value="<%=defaultbank%>">
    <% if (buyer_account_name != null && !buyer_account_name.equals("")) {%>
    <input type=hidden name="buyer_account_name" value="<%=buyer_account_name%>">
    <% }%>
</form>
<div style="text-align: center"><fmt:message key="GLOBAL_MSG_LOADING" bundle="${bundle}"/> <img src="/images/032.gif" width="100" height="9" /> </div>
    <c:choose>
        <c:when  test="${not empty gatewayPaymentSource && gatewayPaymentSource eq 'SOURCE_WIDGET'}">
            <jsp:include page="/WEB-INF/public/z_footer_widget.jsp"/>
        <script type="text/javascript">
            window.onload = function(){
                document.getElementById("alipay_submit_form").submit();
                resizeIframeHeight();
            }
        </script>
    </c:when>
    <c:otherwise>
        <jsp:include page="/WEB-INF/public/z_footer.jsp"/> 
        <script type="text/javascript">
            window.onload = function(){
                document.getElementById("alipay_submit_form").submit();
            }
        </script>
        <%@include file="/WEB-INF/public/z_footer_close.html" %> 
    </c:otherwise>
</c:choose>


