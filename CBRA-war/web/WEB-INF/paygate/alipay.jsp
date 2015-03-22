
<%@page import="com.cbra.Config"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Map"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.alipay.config.*"%>
<%@ page import="com.alipay.util.*"%>
<%@page import="com.cbra.entity.GatewayPayment"%>

<%
    GatewayPayment payment = (GatewayPayment) request.getAttribute("gatewayPayment");
    String itemSubject = (String) request.getAttribute("itemSubject");
    String itemBody = (String) request.getAttribute("itemBody");
    String buyerEmail = (String) request.getAttribute("buyerEmail");
    String show_url = (String) request.getAttribute("showUrl");
    String notify_url = Config.PAYGATE_ALIPAY_NOTIFY_URL;
    String return_url = Config.PAYGATE_ALIPAY_RETURN_URL;

    //System.err.println("return_url="+return_url);
%>

<%    String get_order = payment.getId().toString();

    String paygateway = "https://www.alipay.com/cooperate/gateway.do?"; //支付接口（不可以修改）
    String service = "create_direct_pay_by_user";//快速付款交易服务（不可以修改）
    String payment_type = "1";//支付宝类型.1代表商品购买（目前填写1即可，不可以修改）
    //AlipyConfig.java中配置信息（不可以修改）
    String input_charset = AlipayConfig.input_charset;
    String sign_type = AlipayConfig.sign_type;
    String seller_email = AlipayConfig.seller_email;
    String partner = AlipayConfig.partner;
    String key = AlipayConfig.key;

    //订单支付信息
    //以下参数是需要通过支付订单时的订单数据传入进来获得
    //必填参数
    String out_trade_no = get_order;//请与贵网站订单系统中的唯一订单号匹配
    String subject = itemSubject; //订单名称，显示在支付宝收银台里的“商品名称”里，显示在支付宝的交易管理的“商品名称”的列表里。
    String body = itemBody; //订单描述、订单详细、订单备注，显示在支付宝收银台里的“商品描述”里
    String total_fee = String.valueOf(payment.getGatewayAmount()); //订单总金额，显示在支付宝收银台里的“应付总额”里
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
    subject = subject.replaceAll("\"", "&quot;");
%>
<!doctype html>
<html>
    <head>
        <jsp:include page="/WEB-INF/public/z_header.jsp"/>
    </head>
    <body>
        <%
            ////////////////////////////////////请求参数//////////////////////////////////////
            //防钓鱼时间戳
            String anti_phishing_key = "";
            //若要使用请调用类文件submit中的query_timestamp函数
            //客户端的IP地址
            String exter_invoke_ip = "";
                        //非局域网的外网IP地址，如：221.0.0.1

            //////////////////////////////////////////////////////////////////////////////////
            //把请求参数打包成数组
            Map<String, String> sParaTemp = new HashMap<String, String>();
            sParaTemp.put("service", "create_direct_pay_by_user");
            sParaTemp.put("partner", AlipayConfig.partner);
            sParaTemp.put("seller_email", AlipayConfig.seller_email);
            sParaTemp.put("_input_charset", AlipayConfig.input_charset);
            sParaTemp.put("payment_type", payment_type);
            sParaTemp.put("notify_url", notify_url);
            sParaTemp.put("return_url", return_url);
            sParaTemp.put("out_trade_no", out_trade_no);
            sParaTemp.put("subject", subject);
            sParaTemp.put("total_fee", total_fee);
            sParaTemp.put("body", body);
            sParaTemp.put("show_url", show_url);
            sParaTemp.put("anti_phishing_key", anti_phishing_key);
            sParaTemp.put("exter_invoke_ip", exter_invoke_ip);
            //建立请求
            String sHtmlText = AlipaySubmit.buildRequest(sParaTemp, "get", "确认");
            out.println(sHtmlText);
        %>
        <div style="text-align: center"><fmt:message key="GLOBAL_MSG_LOADING" bundle="${bundle}"/> <img src="/images/032.gif" width="100" height="9" /> </div>
        <script type="text/javascript">
            window.onload = function () {
                document.getElementById("alipay_submit_form").submit();
            }
        </script>
    </body>
</html>
