/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cbra.web;

import cn.yoopay.support.exception.NotVerifiedException;
import com.alipay.config.AlipayConfig;
import com.alipay.util.AlipayNotify;
import com.cbra.entity.Account;
import com.cbra.entity.CompanyAccount;
import com.cbra.entity.FundCollection;
import com.cbra.entity.GatewayPayment;
import com.cbra.entity.Offer;
import com.cbra.entity.OrderCbraService;
import com.cbra.entity.OrderCollection;
import com.cbra.entity.Plate;
import com.cbra.entity.PlateInformation;
import com.cbra.entity.SubCompanyAccount;
import com.cbra.entity.UserAccount;
import com.cbra.service.AccountService;
import com.cbra.service.AdminService;
import com.cbra.service.CbraService;
import com.cbra.service.GatewayService;
import com.cbra.service.OrderService;
import com.cbra.support.NoPermException;
import com.cbra.support.ResultList;
import com.cbra.support.Tools;
import com.cbra.support.UnionpayTools;
import static com.cbra.support.UnionpayTools.createHtml;
import com.cbra.support.enums.GatewayPaymentSourceEnum;
import com.cbra.support.enums.LanguageType;
import com.cbra.support.enums.MessageTypeEnum;
import com.cbra.support.enums.OrderStatusEnum;
import com.cbra.support.enums.PaymentGatewayTypeEnum;
import com.cbra.support.enums.PlateAuthEnum;
import com.cbra.support.exception.AccountNotExistException;
import static com.cbra.web.BaseServlet.FORWARD_TO_ANOTHER_URL;
import static com.cbra.web.BaseServlet.KEEP_GOING_WITH_ORIG_URL;
import static com.cbra.web.BaseServlet.SESSION_ATTRIBUTE_USER_STATUS;
import com.cbra.web.support.BadPageException;
import com.cbra.web.support.BadPostActionException;
import com.cbra.web.support.NoSessionException;
import com.unionpay.acp.sdk.SDKConfig;
import com.unionpay.acp.sdk.SDKUtil;
import flexjson.JSONSerializer;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.MessageFormat;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.ejb.EJB;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.fileupload.FileUploadException;
import com.unionpay.acp.sdk.SDKConfig;
import java.math.BigDecimal;
import java.math.MathContext;
import java.util.Map.Entry;
import org.apache.commons.lang.StringUtils;

/**
 * 支付网关WEB层
 *
 * @author yin.weilong
 */
@WebServlet(name = "GatewayServlet", urlPatterns = {"/paygate/*"})
public class GatewayServlet extends BaseServlet {

    @EJB
    private AccountService accountService;
    @EJB
    private AdminService adminService;
    @EJB
    private CbraService cbraService;
    @EJB
    private OrderService orderService;
    @EJB
    private GatewayService gatewayService;
    // <editor-fold defaultstate="collapsed" desc="重要但不常修改的函数. Click on the + sign on the left to edit the code.">

    @Override
    public boolean processUrlReWrite(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String servletPath = request.getServletPath();
        String pathInfo = request.getPathInfo();
        // PROCESS ROOT PAGE.
        if (pathInfo == null || pathInfo.equals("/")) {
            forward("/account/overview", request, response);
            return FORWARD_TO_ANOTHER_URL;
        }
        String[] pathArray = StringUtils.split(pathInfo, "/");
        PageEnum page = null;
        try {
            page = PageEnum.valueOf(pathArray[0].toUpperCase());
        } catch (Exception ex) {
            // PROCESS ACCESS CAN NOT PARSE TO A PAGE NAME.
            // 阻止像这样的URL得到处理：用户瞎写的URL：/account/ksjdlfskjfd;as
            redirectToFileNotFound(request, response);
            return FORWARD_TO_ANOTHER_URL;
        }

        // 设置这个参数很重要，后续要用。
        request.setAttribute(REQUEST_ATTRIBUTE_PAGE_ENUM, page);
        request.setAttribute(REQUEST_ATTRIBUTE_PATHINFO_ARRAY, pathArray);
        return KEEP_GOING_WITH_ORIG_URL;
    }

    @Override
    public boolean processLoginControl(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, NoSessionException {
        PageEnum page = (PageEnum) request.getAttribute(REQUEST_ATTRIBUTE_PAGE_ENUM);
        switch (page) {
            //setLogoutOnly(request);
            //setLoginLogoutBothAllowed(request);
            default:
                setLoginLogoutBothAllowed(request);
        }

        return KEEP_GOING_WITH_ORIG_URL;
    }

    @Override
    boolean processActionEnum(String actionString, HttpServletRequest request, HttpServletResponse response) throws BadPostActionException, ServletException, IOException {
        ActionEnum action = null;
        try {
            action = ActionEnum.valueOf(actionString);
        } catch (Exception ex) {
            throw new BadPostActionException();
        }
        // 设置这个参数很重要，后续要用到。Even it's null.
        request.setAttribute(REQUEST_ATTRIBUTE_ACTION_ENUM, action);
        return KEEP_GOING_WITH_ORIG_URL;
    }// </editor-fold>

    enum ActionEnum {

    }

    @Override
    boolean processAction(HttpServletRequest request, HttpServletResponse response) throws BadPostActionException, ServletException, IOException, NoSessionException, NotVerifiedException {
        ActionEnum action = (ActionEnum) request.getAttribute(REQUEST_ATTRIBUTE_ACTION_ENUM);
        switch (action) {
            default:
                throw new BadPostActionException();
        }
    }

    private enum PageEnum {

        BANK_TRANSFER, ALIPAY, ALIPAY_BANK, ALIPAY_RETURN, ALIPAY_NOTIFY, UNIONPAY, UNIONPAY_RETURN, NIONPAY_NOTIFY;
    }

    @Override
    boolean processPage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, NoSessionException, BadPageException, NoPermException {
        PageEnum page = (PageEnum) request.getAttribute(REQUEST_ATTRIBUTE_PAGE_ENUM);
        switch (page) {
            case ALIPAY:
                return loadAlipay(request, response);
            case ALIPAY_BANK:
                return loadAlipayBank(request, response);
            case ALIPAY_RETURN:
                return loadAlipayReturn(request, response);
            case ALIPAY_NOTIFY:
                return loadAlipayNotify(request, response);
            case BANK_TRANSFER:
                return doSetBankTransfer(request, response);
            case UNIONPAY:
                return loadUnionPay(request, response);
            case UNIONPAY_RETURN:
                return loadloadUnionPayReturn(request, response);
            case NIONPAY_NOTIFY:
                return loadloadUnionPayNotify(request, response);
            default:
                throw new BadPageException();
        }
    }

    // ************************************************************************
    // *************** ACTION处理的相关函数，放在这下面
    // ************************************************************************
    /**
     * 银行转账
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     */
    private boolean doSetBankTransfer(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        GatewayPayment gatewayPayment = this.getGatewayPayment(request);
        if (gatewayPayment == null) {
            forwardWithError("Param Invalid", "/public/error_page", request, response);
            return FORWARD_TO_ANOTHER_URL;
        }
        PaymentGatewayTypeEnum gType = gatewayPayment.getGatewayType();
        if (gType.equals(PaymentGatewayTypeEnum.BANK_TRANSFER)) {
            //保存银行转账信息 
            gatewayService.createBankTransfer(gatewayPayment);
        }
        this.redirectResult(gatewayPayment, request, response);
        return FORWARD_TO_ANOTHER_URL;
    }

    private boolean loadAlipay(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        GatewayPayment gatewayPayment = this.getGatewayPayment(request);
        if (gatewayPayment == null) {
            forwardWithError("Param Invalid", "/public/error_page", request, response);
            return FORWARD_TO_ANOTHER_URL;
        }
        request.setAttribute("gatewayPayment", gatewayPayment);
        String itemSubject = null;
        String itemBody = null;
        String showUrl = "http://www.cbra.com";
        if (gatewayPayment.getOrderCollection() != null) {
            FundCollection fundCollection = gatewayPayment.getOrderCollection().getFundCollection();
            itemSubject = fundCollection.getTitle();
//            showUrl = "http://www.cbra.com/" + "/" + fundCollection.getWebId();
            itemBody = "筑誉建筑联合会";
        } else if (gatewayPayment.getOrderCbraService() != null) {
            itemSubject = "会员费";
            showUrl = "http://www.cbra.com/account/membership_fee";
            itemBody = "筑誉建筑联合会";
        }
        request.setAttribute("showUrl", showUrl);
        request.setAttribute("itemSubject", itemSubject);
        request.setAttribute("itemBody", itemBody);
        return KEEP_GOING_WITH_ORIG_URL;
    }

    private boolean loadAlipayBank(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        GatewayPayment gatewayPayment = this.getGatewayPayment(request);
        if (gatewayPayment == null) {
            forwardWithError("Param Invalid", "/public/error_page", request, response);
            return FORWARD_TO_ANOTHER_URL;
        }
        request.setAttribute("gatewayPayment", gatewayPayment);
        String itemSubject = null;
        String itemBody = null;
        String showUrl = "http://www.cbra.com";
        if (gatewayPayment.getOrderCollection() != null) {
            FundCollection fundCollection = gatewayPayment.getOrderCollection().getFundCollection();
            itemSubject = Tools.getEscapedHtml(fundCollection.getTitle());
//            showUrl = "http://www.cbra.com/" + "/" + fundCollection.getWebId();
            itemBody = "筑誉建筑联合会";
        } else if (gatewayPayment.getOrderCbraService() != null) {
            itemSubject = "会员费";
//            showUrl = "http://www.cbra.com";
            itemBody = "筑誉建筑联合会";
        }
        request.setAttribute("showUrl", showUrl);
        request.setAttribute("itemSubject", itemSubject);
        request.setAttribute("itemBody", itemBody);
        return KEEP_GOING_WITH_ORIG_URL;
    }

    private boolean loadAlipayReturn(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        GatewayPayment setPaymentResult = null;
        //**********************************************************************************
        Map<String, String> params = new HashMap<>();
        Map requestParams = request.getParameterMap();
        for (Iterator iter = requestParams.keySet().iterator(); iter.hasNext();) {
            String name = (String) iter.next();
            String[] values = (String[]) requestParams.get(name);
            String valueStr = "";
            for (int i = 0; i < values.length; i++) {
                valueStr = (i == values.length - 1) ? valueStr + values[i]
                        : valueStr + values[i] + ",";
            }
            //乱码解决，这段代码在出现乱码时使用。如果mysign和sign不相等也可以使用这段代码转化
//            valueStr = new String(valueStr.getBytes("ISO-8859-1"), "utf-8");
            params.put(name, valueStr);
        }

        //获取支付宝的通知返回参数，可参考技术文档中页面跳转同步通知参数列表(以下仅供参考)//
        //商户订单号
        String out_trade_no = new String(request.getParameter("out_trade_no").getBytes("ISO-8859-1"), "UTF-8");

        //支付宝交易号
        String trade_no = new String(request.getParameter("trade_no").getBytes("ISO-8859-1"), "UTF-8");

        //交易状态
        String trade_status = new String(request.getParameter("trade_status").getBytes("ISO-8859-1"), "UTF-8");

        //获取支付宝的通知返回参数，可参考技术文档中页面跳转同步通知参数列表(以上仅供参考)//
        //计算得出通知验证结果
        boolean verify_result = AlipayNotify.verify(params);
        if (verify_result) {//验证成功
            //////////////////////////////////////////////////////////////////////////////////////////
            //请在这里加上商户的业务逻辑程序代码

            //——请根据您的业务逻辑来编写程序（以下代码仅作参考）——
            if (trade_status.equals("TRADE_FINISHED") || trade_status.equals("TRADE_SUCCESS")) {
                //判断该笔订单是否在商户网站中已经做过处理
                //如果没有做过处理，根据订单号（out_trade_no）在商户网站的订单系统中查到该笔订单的详细，并执行商户的业务程序
                //如果有做过处理，不执行商户的业务程序
            }

            //该页面可做页面美工编辑
            setPaymentResult = gatewayService.setPaymentResult(out_trade_no, true, "支付宝支付成功");
            //——请根据您的业务逻辑来编写程序（以上代码仅作参考）——
            //////////////////////////////////////////////////////////////////////////////////////////
        } else {
            //该页面可做页面美工编辑
            String msg = "数据校验错误，支付失败。";
            setPaymentResult = gatewayService.setPaymentResult(out_trade_no, false, msg);
        }
        //**********************************************************************************
        //**********************************************************************************
        redirectResult(setPaymentResult, request, response);
        return FORWARD_TO_ANOTHER_URL;
    }

    private boolean loadAlipayNotify(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("***************alipay_notify*************");
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        GatewayPayment setPaymentResult = null;
        try {
            //**********************************************************************************
            //获取支付宝POST过来反馈信息
            Map<String, String> params = new HashMap<String, String>();
            Map requestParams = request.getParameterMap();
            for (Iterator iter = requestParams.keySet().iterator(); iter.hasNext();) {
                String name = (String) iter.next();
                String[] values = (String[]) requestParams.get(name);
                String valueStr = "";
                for (int i = 0; i < values.length; i++) {
                    valueStr = (i == values.length - 1) ? valueStr + values[i]
                            : valueStr + values[i] + ",";
                }
                //乱码解决，这段代码在出现乱码时使用。如果mysign和sign不相等也可以使用这段代码转化
                //valueStr = new String(valueStr.getBytes("ISO-8859-1"), "gbk");
                params.put(name, valueStr);
            }

            //获取支付宝的通知返回参数，可参考技术文档中页面跳转同步通知参数列表(以下仅供参考)//
            //商户订单号
            String out_trade_no = request.getParameter("out_trade_no");
            System.out.println("out_trade_no=" + out_trade_no);
            //支付宝交易号
            String trade_no = request.getParameter("trade_no");

            //交易状态
            String trade_status = request.getParameter("trade_status");
            System.out.println("trade_status=" + trade_status);
            //获取支付宝的通知返回参数，可参考技术文档中页面跳转同步通知参数列表(以上仅供参考)//
            if (AlipayNotify.verify(params)) {//验证成功
                //////////////////////////////////////////////////////////////////////////////////////////
                //请在这里加上商户的业务逻辑程序代码

                //——请根据您的业务逻辑来编写程序（以下代码仅作参考）——
                if (trade_status.equals("TRADE_FINISHED")) {
			//判断该笔订单是否在商户网站中已经做过处理
                    //如果没有做过处理，根据订单号（out_trade_no）在商户网站的订单系统中查到该笔订单的详细，并执行商户的业务程序
                    //如果有做过处理，不执行商户的业务程序

                    //注意：
                    //退款日期超过可退款期限后（如三个月可退款），支付宝系统发送该交易状态通知
                } else if (trade_status.equals("TRADE_SUCCESS")) {
			//判断该笔订单是否在商户网站中已经做过处理
                    //如果没有做过处理，根据订单号（out_trade_no）在商户网站的订单系统中查到该笔订单的详细，并执行商户的业务程序
                    //如果有做过处理，不执行商户的业务程序

                    //注意：
                    //付款完成后，支付宝系统发送该交易状态通知
                }

                //——请根据您的业务逻辑来编写程序（以上代码仅作参考）——
                setPaymentResult = gatewayService.setPaymentResult(out_trade_no, true, "支付宝支付成功");
                out.println("success");	//请不要修改或删除

                //////////////////////////////////////////////////////////////////////////////////////////
            } else {//验证失败
                System.out.println("*********sign_fail*************");
                out.println("fail");
            }
        } catch (Exception x) {
            out.println("fail");
        } finally {
            out.close();
        }
        return FORWARD_TO_ANOTHER_URL;
    }

    /**
     * 银联在线
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     */
    private boolean loadUnionPay(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        GatewayPayment gatewayPayment = this.getGatewayPayment(request);
        if (gatewayPayment == null) {
            forwardWithError("Param Invalid", "/public/error_page", request, response);
            return FORWARD_TO_ANOTHER_URL;
        }
        /**
         * 组装请求报文
         */
        Map<String, String> data = new HashMap<String, String>();
        // 版本号
        data.put("version", UnionpayTools.version);
        // 字符集编码 默认"UTF-8"
        String encoding = UnionpayTools.encoding;
        data.put("encoding", encoding);
        // 签名方法 01 RSA
        data.put("signMethod", "01");
        // 交易类型 01-消费
        data.put("txnType", "01");
        // 交易子类型 01:自助消费 02:订购 03:分期付款
        data.put("txnSubType", "01");
        // 业务类型 000201 B2C网关支付
        data.put("bizType", "000201");
        // 渠道类型 07-互联网渠道
        data.put("channelType", "07");
        // 商户/收单前台接收地址 选送
        //后台服务对应的写法参照 com.unionpay.acp.sdksample.notice.FrontRcvResponse.java
        data.put("frontUrl", UnionpayTools.frontUrl);
        // 商户/收单后台接收地址 必送
        //后台服务对应的写法参照 com.unionpay.acp.sdksample.notice.BackRcvResponse.java
        data.put("backUrl", UnionpayTools.backUrl);
        // 接入类型:商户接入填0 0- 商户 ， 1： 收单， 2：平台商户
        data.put("accessType", "0");
        // 商户号码
        data.put("merId", UnionpayTools.merId);
        // 订单号 商户根据自己规则定义生成，每订单日期内不重复
        data.put("orderId", "7777777" + gatewayPayment.getId().toString());
        // 订单发送时间 格式： YYYYMMDDhhmmss 商户发送交易时间，根据自己系统或平台生成
        data.put("txnTime", new SimpleDateFormat("yyyyMMddHHmmss").format(new Date()));
//        data.put("txnAmt", "1");
        data.put("txnAmt", gatewayPayment.getGatewayAmount().multiply(new BigDecimal("100")).toBigInteger().toString());
        // 交易币种
        data.put("currencyCode", "156");
        data.put("issInsCode", "ICBC");
        data.put("orderDesc", gatewayPayment.getId().toString());
        Map<String, String> requestMap = new HashMap<String, String>();
        requestMap.putAll(data);
        Set<String> set = data.keySet();
        Iterator<String> iterator = set.iterator();
        while (iterator.hasNext()) {
            String key = (String) iterator.next();
            if (null == data.get(key) || "".equals(data.get(key))) {
                requestMap.remove(key);
            }
        }
        /**
         * 签名
         */
        SDKUtil.sign(requestMap, encoding);
        /**
         * 创建表单
         */
        String requestFrontUrl = SDKConfig.getConfig().getFrontRequestUrl();
        String html = UnionpayTools.createHtml(requestFrontUrl, requestMap);
        System.out.println(html);
        response.getOutputStream().print(html);
        return FORWARD_TO_ANOTHER_URL;
    }

    /**
     * 银联在线return
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     */
    private boolean loadloadUnionPayReturn(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        GatewayPayment setPaymentResult = null;
        request.setCharacterEncoding("ISO-8859-1");
        String encoding = request.getParameter("encoding");
        // 获取请求参数中所有的信息
        Map<String, String> reqParam = UnionpayTools.getAllRequestParam(request);
        Map<String, String> valideData = null;
        if (null != reqParam && !reqParam.isEmpty()) {
            Iterator<Entry<String, String>> it = reqParam.entrySet().iterator();
            valideData = new HashMap<String, String>(reqParam.size());
            while (it.hasNext()) {
                Entry<String, String> e = it.next();
                String key = (String) e.getKey();
                String value = (String) e.getValue();
                value = new String(value.getBytes("ISO-8859-1"), encoding);
                valideData.put(key, value);
            }
        }
        // 验证签名
        if (!SDKUtil.validate(valideData, encoding)) {
            String orderId = valideData.get("orderId");
            orderId = orderId.substring(7);
            setPaymentResult = gatewayService.setPaymentResult(orderId, false, "银联在线验证签名");
        } else {
            String orderId = valideData.get("orderId");
            orderId = orderId.substring(7);
            setPaymentResult = gatewayService.setPaymentResult(orderId, true, "银联在线支付成功");
        }
        redirectResult(setPaymentResult, request, response);
        return FORWARD_TO_ANOTHER_URL;
    }

    /**
     * 银联在线notify
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     */
    private boolean loadloadUnionPayNotify(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        GatewayPayment setPaymentResult = null;
        request.setCharacterEncoding("ISO-8859-1");
        String encoding = request.getParameter("encoding");
        // 获取请求参数中所有的信息
        Map<String, String> reqParam = UnionpayTools.getAllRequestParam(request);
        Map<String, String> valideData = null;
        if (null != reqParam && !reqParam.isEmpty()) {
            Iterator<Entry<String, String>> it = reqParam.entrySet().iterator();
            valideData = new HashMap<String, String>(reqParam.size());
            while (it.hasNext()) {
                Entry<String, String> e = it.next();
                String key = (String) e.getKey();
                String value = (String) e.getValue();
                value = new String(value.getBytes("ISO-8859-1"), encoding);
                valideData.put(key, value);
            }
        }
        // 验证签名
        String orderId = valideData.get("orderId");
        orderId = orderId.substring(7);
        if (!SDKUtil.validate(valideData, encoding)) {
            setPaymentResult = gatewayService.setPaymentResult(orderId, false, "银联在线验证签名");
        } else {
            setPaymentResult = gatewayService.setPaymentResult(orderId, true, "银联在线支付成功");
        }
        return FORWARD_TO_ANOTHER_URL;
    }

    // ************************************************************************
    // ***************PRIVATE处理的相关函数，放在这下面
    // ************************************************************************
    /**
     * 获取支付网关
     *
     * @param request
     * @return
     * @throws ServletException
     * @throws IOException
     */
    private GatewayPayment getGatewayPayment(HttpServletRequest request) throws ServletException, IOException {
        GatewayPayment gatewayPayment = (GatewayPayment) request.getAttribute("gatewayPayment");
        if (null == gatewayPayment) {
            Long gatewayPaymentId = super.getPathInfoLongAt(request, 1);
            gatewayPayment = gatewayService.findGatewayPaymentById(gatewayPaymentId);
        }
        return gatewayPayment;
    }

    /**
     * 转发结果
     *
     * @param gatewayPayment
     * @param request
     * @param response
     * @throws IOException
     * @throws ServletException
     */
    private void redirectResult(GatewayPayment gatewayPayment, HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        PaymentGatewayTypeEnum gatewayType = gatewayPayment.getGatewayType();
        String url = null;
        if (gatewayPayment.getOrderCollection() != null) {
            //收款支付
            String baseUrl = "/order/result/";
            GatewayPaymentSourceEnum source = gatewayPayment.getSource();
            if (gatewayPayment.isSuccess()) {
                super.removeCookie(request, response, COOKIE_PAYMENT_REF_URL);
            }
            OrderCollection orderCollection = gatewayPayment.getOrderCollection();
            url = baseUrl + orderCollection.getSerialId();
            redirect(url, request, response);
        } else if (gatewayPayment.getOrderCbraService() != null) {
            String baseUrl = "/account/result/";
            url = baseUrl + gatewayPayment.getOrderCbraService().getSerialId();
            //刷新用户状态
            Account account = gatewayPayment.getOrderCbraService().getOwner();
            request.getSession().setAttribute(SESSION_ATTRIBUTE_USER_STATUS, account.getStatus());
            redirect(url, request, response);
        }
    }

}
