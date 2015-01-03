<%-- 
    Document   : chinabank_creditcard
    Created on : Aug 11, 2011, 5:50:52 PM
    Author     : WangShuai
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*, java.text.*,cc.hengzhi.paygate.*,cn.yoopay.Config,cn.yoopay.support.Tools,cn.yoopay.entity.GatewayPayment"%> 
<jsp:useBean id="MD5" scope="request" class="beartool.MD5"/>
<%
    GatewayPayment payment = (GatewayPayment) request.getAttribute("gatewayPayment");
    //定义必须传递的参数变量
    String v_mid, key, v_url, v_oid, v_amount, v_moneytype, v_md5info;

    // 商户号，这里为测试商户号1001，替换为自己的商户号即可
    v_mid = ChinabankCreditCardConfig.mid;
    // 商户自定义返回接收支付结果的页面
    v_url = (String) request.getAttribute("returnUrl");
    // MD5密钥
    key = ChinabankCreditCardConfig.key;
    // 币种
    v_moneytype = "CNY";
    // 订单金额
    v_amount = String.valueOf(payment.getCNYAmount());

    //Order ID 
    v_oid = String.valueOf(payment.getId());

    //MD5
    // 对拼凑串MD5私钥加密后的值
    v_md5info = "";
    String text = v_amount + v_moneytype + v_oid + v_mid + v_url + key;   // 拼凑加密串
    v_md5info = MD5.getMD5ofStr(text);

    //************以下几项与网上支付货款无关，建议不用**************
    String v_rcvname, v_rcvaddr, v_rcvtel, v_rcvpost, v_rcvemail, v_rcvmobile;  //定义非必需参数

    v_rcvname = request.getParameter("v_rcvname");     // 收货人
    v_rcvaddr = request.getParameter("v_rcvaddr");     // 收货地址
    v_rcvtel = request.getParameter("v_rcvtel");      // 收货人电话
    v_rcvpost = request.getParameter("v_rcvpost");     // 收货人邮编
    v_rcvemail = request.getParameter("v_rcvemail");    // 收货人邮件
    v_rcvmobile = request.getParameter("v_rcvmobile");   // 收货人手机号

    String v_ordername, v_orderaddr, v_ordertel, v_orderpost, v_orderemail, v_ordermobile;

    v_ordername = request.getParameter("v_ordername");   // 订货人姓名
    v_orderaddr = request.getParameter("v_orderaddr");   // 订货人地址
    v_ordertel = request.getParameter("v_ordertel");    // 订货人电话
    v_orderpost = request.getParameter("v_orderpost");   // 订货人邮编
    v_orderemail = "securepayment@yoopay.cn";  // 订货人邮件
    v_ordermobile = request.getParameter("v_ordermobile"); // 订货人手机号

    String remark1, remark2;

    remark1 = (String) request.getAttribute("remark1");     //备注字段1
    remark2 = (String) request.getAttribute("remark2");    //备注字段2
%>
<jsp:include page="/WEB-INF/public/z_header.jsp"/>

<form action="https://pay3.chinabank.com.cn/PayGate" method="POST" id="chinabank_submit_form">
    <!--以下几项为网上支付重要信息，信息必须正确无误，信息会影响支付进行！-->
    <input type="hidden" name="v_md5info"    value="<%=v_md5info%>" size="100">
    <input type="hidden" name="v_mid"        value="<%=v_mid%>">
    <input type="hidden" name="v_oid"        value="<%=v_oid%>">
    <input type="hidden" name="v_amount"     value="<%=v_amount%>">
    <input type="hidden" name="v_moneytype"  value="<%=v_moneytype%>">
    <input type="hidden" name="v_url"        value="<%=v_url%>">

    <input type=hidden name="card_id" value="1">
    <%--仅显示信用卡支付页面 --%>
    <input type=hidden name="bankid" value="3D" />

    <!--以下几项项为网上支付完成后，随支付反馈信息一同传给信息接收页，在传输过程中内容不会改变,如：Receive.asp -->
    <input type="hidden"  name="remark1" value="<%=remark1%>">
    <input type="hidden"  name="remark2" value="<%=remark2%>">

    <!--以下几项与网上支付货款无关，只是用来记录客户信息，可以不用，使用和不使用都不影响支付 -->
    <input type="hidden"  name="v_rcvname"      value="<%=v_rcvname%>">
    <input type="hidden"  name="v_rcvaddr"      value="<%=v_rcvaddr%>">
    <input type="hidden"  name="v_rcvtel"       value="<%=v_rcvtel%>">
    <input type="hidden"  name="v_rcvpost"      value="<%=v_rcvpost%>">
    <input type="hidden"  name="v_rcvemail"     value="<%=v_rcvemail%>">
    <input type="hidden"  name="v_rcvmobile"    value="<%=v_rcvmobile%>">

    <input type="hidden"  name="v_ordername"    value="<%=v_ordername%>">
    <input type="hidden"  name="v_orderaddr"    value="<%=v_orderaddr%>">
    <input type="hidden"  name="v_ordertel"     value="<%=v_ordertel%>">
    <input type="hidden"  name="v_orderpost"    value="<%=v_orderpost%>">
    <input type="hidden"  name="v_orderemail"   value="<%=v_orderemail%>">
    <input type="hidden"  name="v_ordermobile"  value="<%=v_ordermobile%>">
</form>

<div style="text-align: center"><fmt:message key="GLOBAL_MSG_LOADING" bundle="${bundle}"/>  <img src="/images/032.gif" width="100" height="9" /></div>

<jsp:include page="/WEB-INF/public/z_footer.jsp"/> 
<script type="text/javascript">
    window.onload = function(){
        document.getElementById("chinabank_submit_form").submit();
    }
</script>
<%@include file="/WEB-INF/public/z_footer_close.html" %> 

