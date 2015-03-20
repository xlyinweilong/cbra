
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
%>
<!doctype html>
<html>
    <head>
        <jsp:include page="/WEB-INF/public/z_header.jsp"/>
    </head>
    <body>
        <%
            ////////////////////////////////////请求参数//////////////////////////////////////
            //支付类型
            String payment_type = "1";
                //必填，不能修改
            //服务器异步通知页面路径
            //需http://格式的完整路径，不能加?id=123这类自定义参数
            //页面跳转同步通知页面路径
            //需http://格式的完整路径，不能加?id=123这类自定义参数，不能写成http://localhost/
            //商户订单号
            String out_trade_no = get_order;//请与贵网站订单系统中的唯一订单号匹配
            //商户网站订单系统中唯一订单号，必填
            //订单名称
            String subject = itemSubject;
            //必填
            //付款金额
            String total_fee = String.valueOf(payment.getGatewayAmount()); //订单总金额，显示在支付宝收银台里的“应付总额”里
            //必填
            //订单描述
            String body = itemBody;
            //默认支付方式
            String paymethod = "bankPay";
            //必填
            //默认网银
            String defaultbank = "CMB";
                //必填，银行简码请参考接口技术文档
            //商品展示地址
            //需以http://开头的完整路径，例如：http://www.商户网址.com/myorder.html
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
            sParaTemp.put("paymethod", paymethod);
            sParaTemp.put("defaultbank", defaultbank);
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
