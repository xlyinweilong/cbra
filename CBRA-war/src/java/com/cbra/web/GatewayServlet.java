/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cbra.web;

import cn.yoopay.support.exception.NotVerifiedException;
import com.cbra.entity.Account;
import com.cbra.entity.CompanyAccount;
import com.cbra.entity.FundCollection;
import com.cbra.entity.GatewayPayment;
import com.cbra.entity.Offer;
import com.cbra.entity.OrderCollection;
import com.cbra.entity.Plate;
import com.cbra.entity.PlateInformation;
import com.cbra.entity.UserAccount;
import com.cbra.service.AccountService;
import com.cbra.service.AdminService;
import com.cbra.service.CbraService;
import com.cbra.service.GatewayService;
import com.cbra.service.OrderService;
import com.cbra.support.NoPermException;
import com.cbra.support.ResultList;
import com.cbra.support.Tools;
import com.cbra.support.enums.GatewayPaymentSourceEnum;
import com.cbra.support.enums.LanguageType;
import com.cbra.support.enums.MessageTypeEnum;
import com.cbra.support.enums.OrderStatusEnum;
import com.cbra.support.enums.PaymentGatewayTypeEnum;
import com.cbra.support.enums.PlateAuthEnum;
import com.cbra.support.exception.AccountNotExistException;
import static com.cbra.web.BaseServlet.FORWARD_TO_ANOTHER_URL;
import static com.cbra.web.BaseServlet.KEEP_GOING_WITH_ORIG_URL;
import com.cbra.web.support.BadPageException;
import com.cbra.web.support.BadPostActionException;
import com.cbra.web.support.NoSessionException;
import flexjson.JSONSerializer;
import java.io.IOException;
import java.math.BigDecimal;
import java.text.MessageFormat;
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
import org.apache.commons.lang.StringUtils;

/**
 * 订单WEB层
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

        BANK_TRANSFER, LIPAY, ALIPAY_RETURN, ALIPAY_NOTIFY;
    }

    @Override
    boolean processPage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, NoSessionException, BadPageException, NoPermException {
        PageEnum page = (PageEnum) request.getAttribute(REQUEST_ATTRIBUTE_PAGE_ENUM);
        switch (page) {
            case BANK_TRANSFER:
                return doSetBankTransfer(request, response);
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
        }else if(gatewayPayment.getOrderCbraService() != null){
            String baseUrl = "/account/result/";
            url = baseUrl + gatewayPayment.getOrderCbraService().getSerialId();
            redirect(url, request, response);
        }
        if (!gatewayType.equals(PaymentGatewayTypeEnum.ALIPAY)) {
            //Output json
            super.outputSuccessAjax("Redirect success result page...", url, response);
        } else {
            redirect(url, request, response);
        }
    }

}
