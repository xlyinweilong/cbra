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
import com.cbra.support.enums.AccountStatus;
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
@WebServlet(name = "OrderServlet", urlPatterns = {"/order/*"})
public class OrderServlet extends BaseServlet {

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

        CREATE_ORDER, PAYMENT_ORDER;
    }

    @Override
    boolean processAction(HttpServletRequest request, HttpServletResponse response) throws BadPostActionException, ServletException, IOException, NoSessionException, NotVerifiedException {
        ActionEnum action = (ActionEnum) request.getAttribute(REQUEST_ATTRIBUTE_ACTION_ENUM);
        switch (action) {
            case CREATE_ORDER:
                return doCreateOrder(request, response);
            case PAYMENT_ORDER:
                return doPaymentOrder(request, response);
            default:
                throw new BadPostActionException();
        }
    }

    private enum PageEnum {

        SIGN_UP_EVENT, CREATE_EVENT_ORDER_SUCCESS, PAYMENT_ORDER, RESULT;
    }

    @Override
    boolean processPage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, NoSessionException, BadPageException, NoPermException {
        PageEnum page = (PageEnum) request.getAttribute(REQUEST_ATTRIBUTE_PAGE_ENUM);
        switch (page) {
            case CREATE_EVENT_ORDER_SUCCESS:
                return loadCreateOrderSuccess(request, response);
            case SIGN_UP_EVENT:
                return loadSignUpEvent(request, response);
            case PAYMENT_ORDER:
                return loadPaymentOrder(request, response);
            case RESULT:
                return loadResult(request, response);
            default:
                throw new BadPageException();
        }
    }

    // ************************************************************************
    // *************** ACTION处理的相关函数，放在这下面
    // ************************************************************************
    /**
     * 下订单
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     */
    private boolean doCreateOrder(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Long collectionId = super.getRequestLong(request, "collection_id");
        FundCollection fundCollection = adminService.findCollectionById(collectionId);
        Account user = super.getUserFromSessionNoException(request);
        //查看用户权限
        boolean isSignUpEvent = cbraService.getAccountCanSignUpEvent(fundCollection, user);
        if (!isSignUpEvent) {
            super.forward("/public/no_authorization", request, response);
            return FORWARD_TO_ANOTHER_URL;
        }
        Map<String, String[]> paramMap = request.getParameterMap();
        Map<String, Object> attendeeeObjs = null;
        Locale locale = super.getLanguage(request);
        try {
            attendeeeObjs = super.getFormFieldListMap(paramMap, "attendee", null, null, locale, false);
        } catch (Exception ex) {
        }
        OrderCollection oc = orderService.createOrderCollection(user, fundCollection, attendeeeObjs);
        super.forward("/order/create_event_order_success?serialId=" + oc.getSerialId(), request, response);
        return FORWARD_TO_ANOTHER_URL;
    }

    /**
     * 支付订单
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     */
    private boolean doPaymentOrder(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String serialId = super.getPathInfoStringAt(request, 1);
        OrderCollection order = orderService.findOrderCollectionSerialId(serialId);
        if (order == null || !(order.getStatus().equals(OrderStatusEnum.PENDING_PAYMENT)) || order.getStatus().equals(OrderStatusEnum.PAYMENT_TIMEOUT)) {
            forwardWithError(bundle.getString("GLOBAL_MSG_PARAM_INVALID"), "/public/error_page", request, response);
            return FORWARD_TO_ANOTHER_URL;
        }
        String paymentType = super.getRequestString(request, "payment_type");
        PaymentGatewayTypeEnum gateway = null;
        try {
            gateway = PaymentGatewayTypeEnum.valueOf(paymentType);
        } catch (Exception e) {
            forwardWithError(bundle.getString("GLOBAL_MSG_PARAM_INVALID"), "/public/error_page", request, response);
            return FORWARD_TO_ANOTHER_URL;
        }
        GatewayPayment gatewayPayment = gatewayService.createGatewayPayment(order, GatewayPaymentSourceEnum.WEB, gateway);
        request.setAttribute("gatewayPayment", gatewayPayment);
        request.setAttribute("order", order);
        String forwardUrl;
        switch (gateway) {
            case BANK_TRANSFER:
                forwardUrl = "/paygate/bank_transfer/";
                break;
            case ALIPAY_BANK:
                forwardUrl = "/paygate/alipay_bank/";
                break;
            case ALIPAY:
                forwardUrl = "/paygate/alipay/";
                break;
            default:
                forwardWithError(bundle.getString("PAYMENT_SELECT_GATEWAY_INVALID_无效的选择"), "/public/error_page", request, response);
                return FORWARD_TO_ANOTHER_URL;
        }
        super.forward(forwardUrl, request, response);
        return FORWARD_TO_ANOTHER_URL;
    }

    // ************************************************************************
    // *************** PAGE RANDER处理的相关函数，放在这下面
    // ************************************************************************
    /**
     * 加载申请页
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     */
    private boolean loadSignUpEvent(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ServletContext application = this.getServletContext();
        List<Plate> list = (List<Plate>) application.getAttribute("menuPlates");
        for (Plate plate : list) {
            if ("pariners".equalsIgnoreCase(plate.getPage())) {
                request.setAttribute("hotEventList", cbraService.getFundCollectionList4Web(plate, 10));
            }
        }
        Long id = super.getRequestLong(request, "id");
        FundCollection fundCollection = adminService.findCollectionById(id);
        request.setAttribute("fundCollection", fundCollection);
        Account user = super.getUserFromSessionNoException(request);
        PlateAuthEnum auth = cbraService.getPlateAuthEnum(fundCollection, user);
        if (PlateAuthEnum.NO_VIEW.equals(auth)) {
            super.forward("/public/no_authorization", request, response);
            return FORWARD_TO_ANOTHER_URL;
        }
        boolean isSignUpEvent = cbraService.getAccountCanSignUpEvent(fundCollection, user);
        request.setAttribute("isSignUpEvent", isSignUpEvent);
        if (!isSignUpEvent) {
            super.forward("/public/no_authorization", request, response);
            return FORWARD_TO_ANOTHER_URL;
        }
        request.setAttribute("user", user);
        if (user != null && user instanceof SubCompanyAccount) {
            user = ((SubCompanyAccount) user).getCompanyAccount();
        }
        if (user == null || (!user.getStatus().equals(AccountStatus.MEMBER))) {
            request.setAttribute("userType", 0);
        } else if (user instanceof UserAccount) {
            request.setAttribute("userType", 1);
        } else if (user instanceof CompanyAccount) {
            request.setAttribute("userType", 2);
        } else {
            request.setAttribute("userType", 0);
        }

        return KEEP_GOING_WITH_ORIG_URL;
    }

    /**
     * 加载成功页
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     */
    private boolean loadCreateOrderSuccess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("serialId", super.getRequestString(request, "serialId"));
        return KEEP_GOING_WITH_ORIG_URL;
    }

    /**
     * 加载待支付的订单
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     */
    private boolean loadPaymentOrder(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String serialId = super.getPathInfoStringAt(request, 1);
        OrderCollection order = orderService.findOrderCollectionSerialId(serialId);
        if (order == null || !(order.getStatus().equals(OrderStatusEnum.PENDING_PAYMENT)) || order.getStatus().equals(OrderStatusEnum.PAYMENT_TIMEOUT) || order.getStatus().equals(OrderStatusEnum.FAILURE)) {
            super.forward("/public/no_authorization", request, response);
            return FORWARD_TO_ANOTHER_URL;
        }
        ServletContext application = this.getServletContext();
        List<Plate> list = (List<Plate>) application.getAttribute("menuPlates");
        for (Plate plate : list) {
            if ("pariners".equalsIgnoreCase(plate.getPage())) {
                request.setAttribute("hotEventList", cbraService.getFundCollectionList4Web(plate, 10));
            }
        }
        request.setAttribute("order", order);
        return KEEP_GOING_WITH_ORIG_URL;
    }

    /**
     * 支付结果页
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     */
    private boolean loadResult(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String serialId = super.getPathInfoStringAt(request, 1);
        OrderCollection order = orderService.findOrderCollectionSerialId(serialId);
        request.setAttribute("order", order);
        return KEEP_GOING_WITH_ORIG_URL;
    }

}
