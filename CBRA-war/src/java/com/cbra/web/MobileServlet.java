/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cbra.web;

import cn.yoopay.support.exception.ImageConvertException;
import cn.yoopay.support.exception.NotVerifiedException;
import com.cbra.entity.Account;
import com.cbra.entity.CompanyAccount;
import com.cbra.entity.FundCollection;
import com.cbra.entity.GatewayPayment;
import com.cbra.entity.OrderCbraService;
import com.cbra.entity.OrderCollection;
import com.cbra.entity.SubCompanyAccount;
import com.cbra.entity.UserAccount;
import com.cbra.service.AccountService;
import com.cbra.service.CbraService;
import com.cbra.service.GatewayService;
import com.cbra.service.OrderService;
import com.cbra.support.FileUploadItem;
import com.cbra.support.FileUploadObj;
import com.cbra.support.NoPermException;
import com.cbra.support.ResultList;
import com.cbra.support.Tools;
import com.cbra.support.enums.AccountIcPosition;
import com.cbra.support.enums.AccountStatus;
import com.cbra.support.enums.CompanyNatureEnum;
import com.cbra.support.enums.CompanyScaleEnum;
import com.cbra.support.enums.GatewayPaymentSourceEnum;
import com.cbra.support.enums.LanguageType;
import com.cbra.support.enums.PaymentGatewayTypeEnum;
import com.cbra.support.enums.UserPosition;
import com.cbra.support.exception.AccountAlreadyExistException;
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
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import jdk.nashorn.internal.runtime.regexp.joni.Config;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.lang.StringUtils;
import org.json.simple.JSONObject;

/**
 * 手机接口
 *
 * @author yin.weilong
 */
@WebServlet(name = "MobileServlet", urlPatterns = {"/mobile/*"})
public class MobileServlet extends BaseServlet {

    @EJB
    private AccountService accountService;
    @EJB
    private OrderService orderService;
    @EJB
    private GatewayService gatewayService;
    @EJB
    private CbraService cbraService;
    // <editor-fold defaultstate="collapsed" desc="重要但不常修改的函数. Click on the + sign on the left to edit the code.">

    @Override
    public boolean processUrlReWrite(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String servletPath = request.getServletPath();
        String pathInfo = request.getPathInfo();
        // 处理特殊化的link，交给正常的处理页面去处理。
        if (servletPath.equalsIgnoreCase("/v")) {
            String url = String.format("/account/verify%s", pathInfo);
            forward(url, request, response);

            return FORWARD_TO_ANOTHER_URL;
        }
        // PROCESS ROOT PAGE.
        if (pathInfo == null || pathInfo.equals("/")) {
            forward("/account/overview", request, response);
            return FORWARD_TO_ANOTHER_URL;
        }

        String[] pathArray = StringUtils.split(pathInfo, "/");
        PageEnum page = PageEnum.OVERVIEW;
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

        Z_LOGIN_DIALOG, Z_SIGNUP_DIALOG, LOGIN, LOGOUT, SIGNUP, SIGNUP_C, OVERVIEW, OVERVIEW_C, VERIFY, SEND_VERIFY_EMAIL, LOAD_ACCOUNT_BY_AJAX,
        MY_EVENT, MEMBERSHIP_FEE, MODIFY_PASSWD, RESET_PASSWD, Z_IFRAME_UPLOAD_PC, RESET_USER_INFO, AGENT, SIGNUP_SUCCESS, FORGET_PASSWD, PAY_MEMBERSHIP, RESULT;
    }

    @Override
    boolean processPage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, NoSessionException, BadPageException, NoPermException {
        PageEnum page = (PageEnum) request.getAttribute(REQUEST_ATTRIBUTE_PAGE_ENUM);
        switch (page) {
            case Z_LOGIN_DIALOG:
            case Z_SIGNUP_DIALOG:
            case LOGIN:
                return loadLogin(request, response);
            case LOGOUT:
            case SIGNUP:
                return loadSignup(request, response);
            case SIGNUP_C:
                return loadSignupCompany(request, response);
            case OVERVIEW:
                return loadOverview(request, response);
            case OVERVIEW_C:
                return loadOverviewCompany(request, response);
            case RESET_USER_INFO:
                return loadResetUserInfo(request, response);
            case MODIFY_PASSWD:
                return KEEP_GOING_WITH_ORIG_URL;
            case RESET_PASSWD:
                return loadResetPassword(request, response);
            case FORGET_PASSWD:
                return KEEP_GOING_WITH_ORIG_URL;
            case MEMBERSHIP_FEE:
                return loadMembershipFee(request, response);
            case MY_EVENT:
                return loadMyEventList(request, response);
            case AGENT:
                return loadAgent(request, response);
            case PAY_MEMBERSHIP:
                return loadPayMembership(request, response);
            case RESULT:
                return loadResult(request, response);
            case Z_IFRAME_UPLOAD_PC:
            case SIGNUP_SUCCESS:
                return KEEP_GOING_WITH_ORIG_URL;
            default:
                throw new BadPageException();
        }
    }

    // ************************************************************************
    // *************** PAGE RANDER处理的相关函数，放在这下面
    // ************************************************************************
    /**
     * 会员费
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     */
    private boolean loadMembershipFee(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Account account = super.getUserFromSessionNoException(request);
        Account user = account;
        if (account instanceof SubCompanyAccount) {
            user = ((SubCompanyAccount) account).getCompanyAccount();
        }
        Integer pageIndex = super.getRequestInteger(request, "page");
        if (pageIndex == null) {
            pageIndex = 1;
        }
        int maxPerPage = 15;
        ResultList<OrderCbraService> resultList = orderService.findOrderCbraServiceList(user, pageIndex, maxPerPage);
        request.setAttribute("resultList", resultList);
        request.setAttribute("user", account);
        return KEEP_GOING_WITH_ORIG_URL;
    }

    /**
     * 参与的活动
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     */
    private boolean loadMyEventList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Account account = super.getUserFromSessionNoException(request);
        Account user = account;
        if (account instanceof SubCompanyAccount) {
            user = ((SubCompanyAccount) account).getCompanyAccount();
        }
        Integer pageIndex = super.getRequestInteger(request, "page");
        if (pageIndex == null) {
            pageIndex = 1;
        }
        int maxPerPage = 15;
        Map<String, Object> map = new HashMap<>();
        map.put("owner", user);
        ResultList<OrderCollection> resultList = orderService.findOrderCollectionList(map, pageIndex, maxPerPage, null, true);
        request.setAttribute("resultList", resultList);
        return KEEP_GOING_WITH_ORIG_URL;
    }

    /**
     * 加载代理人页面
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     */
    private boolean loadAgent(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Account account = super.getUserFromSessionNoException(request);
        Account user = account;
        if (account instanceof SubCompanyAccount) {
            user = ((SubCompanyAccount) account).getCompanyAccount();
        }
        List<SubCompanyAccount> list = accountService.getSubCompanyAccountList((CompanyAccount) accountService.findById(user.getId()));
        int i = 0;
        for (SubCompanyAccount sub : list) {
            i++;
            request.setAttribute("id" + i, sub.getId());
            request.setAttribute("account" + i, sub.getAccount());
        }
        return KEEP_GOING_WITH_ORIG_URL;
    }

    /**
     *
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     */
    private boolean loadPayMembership(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Account account = super.getUserFromSessionNoException(request);
        if (!account.getStatus().equals(AccountStatus.ASSOCIATE_MEMBER)) {
            forwardWithError(bundle.getString("GLOBAL_MSG_PARAM_INVALID"), "/public/error_page", request, response);
            return FORWARD_TO_ANOTHER_URL;
        }
        if (account instanceof UserAccount) {
            request.setAttribute("membership_fee", com.cbra.Config.MEMBERSHIP_FEE);
        } else {
            request.setAttribute("membership_fee", com.cbra.Config.MEMBERSHIP_FEE_COMPANY);
        }

        return KEEP_GOING_WITH_ORIG_URL;
    }

    /**
     * 订单支付结果
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     */
    private boolean loadResult(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String serialId = super.getPathInfoStringAt(request, 1);
        OrderCbraService order = orderService.findOrderCbraServiceSerialId(serialId);
        request.setAttribute("order", order);
        return KEEP_GOING_WITH_ORIG_URL;
    }

    /**
     * 个人用户首页
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     */
    private boolean loadOverview(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Account account = super.getUserFromSessionNoException(request);
        request.setAttribute("user", account);
        return KEEP_GOING_WITH_ORIG_URL;
    }

    /**
     * 公司用户首页
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     */
    private boolean loadOverviewCompany(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Account account = super.getUserFromSessionNoException(request);
        Account user = account;
        if (account instanceof SubCompanyAccount) {
            user = ((SubCompanyAccount) account).getCompanyAccount();
        }
        request.setAttribute("subCompanyAccountList", accountService.getSubCompanyAccountList(((CompanyAccount) user)));
        request.setAttribute("company", user);
        return KEEP_GOING_WITH_ORIG_URL;
    }

    /**
     * 修改个人信息页
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     */
    private boolean loadResetUserInfo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Account account = super.getUserFromSessionNoException(request);
        account = accountService.findById(account.getId());
        if (account instanceof CompanyAccount) {
            request.setAttribute("subCompanyAccountList", accountService.getSubCompanyAccountList(((CompanyAccount) account)));
        }
        request.setAttribute("user", account);
        request.setAttribute("positions", UserPosition.values());
        request.setAttribute("icPositions", AccountIcPosition.values());
        request.setAttribute("companyNatureEnums", CompanyNatureEnum.values());
        request.setAttribute("companyScaleEnums", CompanyScaleEnum.values());
        request.setAttribute("positionList", Arrays.asList(account.getIcPosition().split("_")));
        return KEEP_GOING_WITH_ORIG_URL;
    }

    /**
     * 加载重置密码页
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     */
    private boolean loadResetPassword(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String key = super.getRequestString(request, "key");
        if (key == null) {
            forwardWithError(bundle.getString("GLOBAL_MSG_PARAM_INVALID"), "/public/error_page", request, response);
            return FORWARD_TO_ANOTHER_URL;
        }
        if (key == null) {
            key = (String) request.getAttribute("key");
        }
        request.setAttribute("key", key);
        Account account = accountService.findByRepasswdUrl(key);
        if (account == null) {
            forwardWithError(bundle.getString("GLOBAL_MSG_PARAM_INVALID"), "/public/error_page", request, response);
            return FORWARD_TO_ANOTHER_URL;
        }
        if (Tools.addHour(account.getRepasswdDate(), 1).before(new Date())) {
            setErrorResult(bundle.getString("ACCOUNT_SIGNUP_MSG_注册失败手机错误"), request);
            return KEEP_GOING_WITH_ORIG_URL;
        }
        return KEEP_GOING_WITH_ORIG_URL;
    }

    /**
     * 登录页
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     */
    private boolean loadLogin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("p", super.getRequestString(request, "p"));
        return KEEP_GOING_WITH_ORIG_URL;
    }

    /**
     * 普通用户注册页
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     */
    private boolean loadSignup(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("positions", UserPosition.values());
        request.setAttribute("icPositions", AccountIcPosition.values());
        return KEEP_GOING_WITH_ORIG_URL;
    }

    /**
     * 公司用户注册页
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     */
    private boolean loadSignupCompany(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("positions", UserPosition.values());
        request.setAttribute("icPositions", AccountIcPosition.values());
        request.setAttribute("companyNatureEnums", CompanyNatureEnum.values());
        request.setAttribute("companyScaleEnums", CompanyScaleEnum.values());
        return KEEP_GOING_WITH_ORIG_URL;
    }

    // ************************************************************************
    // *************** 支持性函数、共用函数等非直接功能函数，放在这下面
    // ************************************************************************
    /**
     * 登录
     *
     * @param account
     * @param formSignup
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     */
    private boolean login(Account account, boolean formSignup, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //Save language
        if (account.getUserLanguage() == null) {
            account = accountService.setLanguage(account.getId(), bundle.getLocale().getLanguage());
        }
        HttpSession session = request.getSession();
        // bundle是JSTL用到的session数据，用来在JSP中显示不同语言，
        // 在Login时去掉这个bundle，然后会在z_heander中被重新生成，这样可以实现登录之后使用用户自定义的语言的功能。
        session.removeAttribute("bundle");
        // 设置user到session里，这是登录与否的标志
        session.setAttribute(SESSION_ATTRIBUTE_USER, account);
        if (account.getUserLanguage() != null) {
            super.setLanguage(account.getUserLanguage().toString(), request, response);
        }
        // ******************************************************************
        // 这个url是login之后跳转的页面，缺省是overview
        String jump = "/account/overview";
        if (account instanceof CompanyAccount || account instanceof SubCompanyAccount) {
            jump = "/account/overview_c";
        }
        String url = (String) request.getParameter("urlUserWantToAccess");
        if (!StringUtils.isBlank(url)) {
            jump = url;
        } else if (formSignup) {
            //check cookie get the redirect url
            String curl = getCookieValue(request, response, COOKIE_LOGIN_URL_REDIRECT);
            if (Tools.isNotBlank(curl)) {
                jump = curl;
                //delete COOKIE_LOGIN_URL_REDIRECT cookie
                removeCookie(request, response, COOKIE_LOGIN_URL_REDIRECT);
            }
        }
        log("Login Success, Redirect to: " + jump);
        redirect(jump, request, response);
        return REDIRECT_TO_ANOTHER_URL;
    }
}
