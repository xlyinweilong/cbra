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
 * 用户WEB层
 *
 * @author yin.weilong
 */
@WebServlet(name = "UserAccountServlet", urlPatterns = {"/account/*", "/v/*", "/user/*", "/company/*"})
public class AccountServlet extends BaseServlet {

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
            case Z_LOGIN_DIALOG:
            case Z_SIGNUP_DIALOG:
            case LOGIN:
            case SIGNUP:
            case SIGNUP_C:
            case FORGET_PASSWD:
            case RESET_PASSWD:
            case LOGOUT:
            case VERIFY:
            case LOAD_ACCOUNT_BY_AJAX:
            case Z_IFRAME_UPLOAD_PC:
            case SIGNUP_SUCCESS:
                setLoginLogoutBothAllowed(request);
                break;
            default:
                setLoginOnly(request);
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

        LOGIN_AJAX, SIGNUP_AJAX, LOGIN, LOGOUT, SIGNUP, SIGNUP_C, RESET_PASSWD, REGINFO, MODIFY_PASSWD, CHANGE_REGINFO, SEND_RESET_PASSWD,
        UPLOAD_PERSON_CARD, ACCOUNT_IS_EXIST, RESET_USER_INFO, SET_AGENT, PAYMENT_ORDER;
    }

    @Override
    boolean processAction(HttpServletRequest request, HttpServletResponse response) throws BadPostActionException, ServletException, IOException, NoSessionException, NotVerifiedException {
        ActionEnum action = (ActionEnum) request.getAttribute(REQUEST_ATTRIBUTE_ACTION_ENUM);
        switch (action) {
            case LOGOUT:
                return doLogout(request, response);
            case UPLOAD_PERSON_CARD:
                return doUploadPersonCard(request, response);
            case LOGIN:
                return doLogin(request, response);
            case SIGNUP:
                return doSignup(request, response);
            case SIGNUP_C:
                return doSignupC(request, response);
            case RESET_PASSWD:
                return doResetPasswd(request, response);
            case MODIFY_PASSWD:
                return doModifyPasswd(request, response);
            case CHANGE_REGINFO:
                return doChangeRegInfo(request, response);
            case SEND_RESET_PASSWD:
                return doSendResetPasswd(request, response);
            case ACCOUNT_IS_EXIST:
                return doAccountIsExist(request, response);
            case RESET_USER_INFO:
                return doResetAccountInfo(request, response);
            case SET_AGENT:
                return doSetAgent(request, response);
            case PAYMENT_ORDER:
                return doPaymentOrder(request, response);
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
            case VERIFY:
                return doVerifyEmail(request, response);
            case SEND_VERIFY_EMAIL:
                return doSendVerifyEmail(request, response);
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
    // *************** ACTION处理的相关函数，放在这下面
    // ************************************************************************
    /**
     * 登出
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     */
    private boolean doLogout(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        super.setSessionUser(request, null);
        return KEEP_GOING_WITH_ORIG_URL;
    }

    /**
     * 支付会费
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     */
    private boolean doPaymentOrder(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Account account = super.getUserFromSessionNoException(request);
        OrderCbraService orderCbraService = orderService.createOrderService(account);
        String paymentType = super.getRequestString(request, "payment_type");
        PaymentGatewayTypeEnum gateway = null;
        try {
            gateway = PaymentGatewayTypeEnum.valueOf(paymentType);
        } catch (Exception e) {
            forwardWithError(bundle.getString("GLOBAL_MSG_PARAM_INVALID"), "/public/error_page", request, response);
            return FORWARD_TO_ANOTHER_URL;
        }
        GatewayPayment gatewayPayment = gatewayService.createGatewayPayment(orderCbraService, GatewayPaymentSourceEnum.WEB, gateway);
        request.setAttribute("gatewayPayment", gatewayPayment);
        request.setAttribute("order", orderCbraService);
        String forwardUrl;
        switch (gateway) {
            case BANK_TRANSFER:
                forwardUrl = "/paygate/bank_transfer/";
                break;
            default:
                forwardWithError(bundle.getString("PAYMENT_SELECT_GATEWAY_INVALID_无效的选择"), "/public/error_page", request, response);
                return FORWARD_TO_ANOTHER_URL;
        }
        super.forward(forwardUrl, request, response);
        return FORWARD_TO_ANOTHER_URL;
    }

    /**
     * 上传身份证件
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     */
    private boolean doUploadPersonCard(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        FileUploadObj fileUploadObj = null;
        String type = super.getRequestString(request, "type");
        try {
            if ("bl".equalsIgnoreCase(type)) {
                fileUploadObj = super.uploadFile(request, 5.0, null, null, null);
            } else if ("qc".equalsIgnoreCase(type)) {
                fileUploadObj = super.uploadFile(request, 20.0, null, null, null);
            } else {
                fileUploadObj = super.uploadFile(request, 2.0, null, null, null);
            }
            List<FileUploadItem> list = fileUploadObj.getFileList();
            for (FileUploadItem item : list) {
                if ("reg_front_file".equals(item.getFieldName()) || "reg_back_file".equals(item.getFieldName()) || "reg_bl_file".equals(item.getFieldName()) || "reg_qc_file".equals(item.getFieldName())) {
                    super.setSuccessResult(type, accountService.setUploadFileToTemp(item), bundle.getString("GLOBAL_保存成功"), request);
                    return KEEP_GOING_WITH_ORIG_URL;
                }
            }
            setErrorResult(type, "", bundle.getString("GLOBAL_MSG_INPUT_NO_BLANK"), request);
            return KEEP_GOING_WITH_ORIG_URL;
        } catch (FileUploadException ex) {
            setErrorResult(type, "", ex.getMessage(), request);
            return KEEP_GOING_WITH_ORIG_URL;
        }
    }

    /**
     * 登录
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     */
    private boolean doLogin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String account = getRequestString(request, "account");
        String passwd = getRequestString(request, "passwd");
        if (!validateBlankParams(bundle.getString("GLOBAL_MSG_INPUT_NO_BLANK"), request, response, "account", "passwd")) {
            return KEEP_GOING_WITH_ORIG_URL;
        }
        request.setAttribute("account", account);
        request.setAttribute("p", getRequestString(request, "p"));
        Account user;
        try {
            user = accountService.getAccountForLogin(account, passwd);
        } catch (AccountNotExistException ex) {
            setErrorResult(bundle.getString("ACCOUNT_LOGIN_MSG_FAIL"), request);
            return KEEP_GOING_WITH_ORIG_URL;
        }
        if (user == null) {
            setErrorResult(bundle.getString("ACCOUNT_LOGIN_MSG_FAIL"), request);
            return KEEP_GOING_WITH_ORIG_URL;
        }
        if (!(user instanceof SubCompanyAccount) && user.getStatus().equals(AccountStatus.PENDING_FOR_APPROVAL)) {
            setErrorResult(bundle.getString("ACCOUNT_LOGIN_MSG_FAIL"), request);
            return KEEP_GOING_WITH_ORIG_URL;
        }
        // 设置user到session里，跳转到相应的登录后页面。
        return login(user, false, request, response);
    }

    private boolean doChangeRegInfo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, NoSessionException {
//        UserAccount user = getUserFromSession(request);
//        try {
//            FileUploadObj fileUploadObj = this.uploadFile(request, 10.0, "reginfo", null, null);
//            String name = null;
//            String company = null;
//            String phone = null;
//            String position = null;
//            name = fileUploadObj.getFormField("name");
//            if (user.isPermissionModified()) {
//                if (StringUtils.isBlank(name)) {
//                    setErrorResult(bundle.getString("ACCOUNT_REGINFO_MSG_请输入您的姓名"), request);
//                    return KEEP_GOING_WITH_ORIG_URL;
//                }
//            }
//            company = fileUploadObj.getFormField("company");
//            phone = fileUploadObj.getFormField("phone");
//            position = fileUploadObj.getFormField("position");
//            if (user.getAccountType().equals(UserAccountTypeEnum.COMPANY)) {
//                if (StringUtils.isBlank(position)) {
//                    setErrorResult(bundle.getString("ACCOUNT_REGINFO_MSG_职位不能为空"), request);
//                    return KEEP_GOING_WITH_ORIG_URL;
//                }
//            }
//            try {
//                accountService.updateUserRegInfo(user.getId(), name, position, company, phone, fileUploadObj.getFileField("logo"));
//            } catch (ImageConvertException ex) {
//                setErrorResult(bundle.getString("ACCOUNT_REGINFO_MSG_请上传正确的图片格式"), request);
//                return KEEP_GOING_WITH_ORIG_URL;
//            }
////            refreshSessionUser(request, accountService);
//            setSuccessResult(bundle.getString("ACCOUNT_REGINFO_MSG_修改成功"), request);
//            return KEEP_GOING_WITH_ORIG_URL;
//        } catch (FileUploadException ex) {
//            setErrorResult(ex.getMessage(), request);
//            return KEEP_GOING_WITH_ORIG_URL;
//        }
        return KEEP_GOING_WITH_ORIG_URL;
    }

    /**
     * 个人用户注册
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     */
    private boolean doSignup(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = getRequestEmail(request, "email");
        String mobile = getRequestString(request, "account");
        if (!validateBlankParams(bundle.getString("GLOBAL_MSG_INPUT_NO_BLANK"), request, response, "accountName", "accountEnName", "account", "email", "workingYear", "company", "address", "zipCode", "position", "front", "back", "workExperience", "projectExperience", "icPositions")) {
            return KEEP_GOING_WITH_ORIG_URL;
        }
        String name = getRequestString(request, "accountName");
        String enName = getRequestString(request, "accountEnName");
        String address = getRequestString(request, "address");
        String zipCode = getRequestString(request, "zipCode");
        String personCardFront = getRequestString(request, "front");
        String personCardBack = getRequestString(request, "back");
        String company = getRequestString(request, "company");
        String position = getRequestString(request, "position");
        String workExperience = getRequestString(request, "workExperience");
        String projectExperience = getRequestString(request, "projectExperience");
        String others = getRequestString(request, "others");
        Integer workingYear = super.getRequestInteger(request, "workingYear");
        if (email == null) {
            setErrorResult(bundle.getString("ACCOUNT_SIGNUP_MSG_注册失败邮件错误"), request);
            return KEEP_GOING_WITH_ORIG_URL;
        }
        if (mobile == null) {
            setErrorResult(bundle.getString("ACCOUNT_SIGNUP_MSG_注册失败手机错误"), request);
            return KEEP_GOING_WITH_ORIG_URL;
        }
        if (workingYear == null) {
            setErrorResult(bundle.getString("ACCOUNT_SIGNUP_MSG_注册失败手机错误"), request);
            return KEEP_GOING_WITH_ORIG_URL;
        }
        String[] icPositions = request.getParameterValues("icPositions");
        if (icPositions.length < 1) {
            setErrorResult(bundle.getString("ACCOUNT_SIGNUP_MSG_注册失败手机错误"), request);
            return KEEP_GOING_WITH_ORIG_URL;
        }
        UserPosition up = null;
        try {
            up = UserPosition.valueOf(position);
        } catch (Exception e) {
            up = null;
        }
        if (up == null && Tools.isBlank(others)) {
            setErrorResult(bundle.getString("ACCOUNT_SIGNUP_MSG_注册失败手机错误"), request);
            return KEEP_GOING_WITH_ORIG_URL;
        }
        String icPosition;
        StringBuilder sb = new StringBuilder();
        for (String ic : icPositions) {
            sb.append(ic);
            sb.append("_");
        }
        icPosition = sb.toString();
        UserAccount userAccount = null;
        try {
            userAccount = accountService.signupUser(mobile, name, email, super.getLanguage(request).getLanguage().toUpperCase(), address, zipCode, icPosition, enName, personCardFront, personCardBack, workingYear, company, up, others, workExperience, projectExperience);
        } catch (AccountAlreadyExistException ex) {
            setErrorResult(bundle.getString("ACCOUNT_SIGNUP_MSG_账户已经存在"), request);
        } catch (IOException ex) {
            setErrorResult(bundle.getString("ACCOUNT_SIGNUP_MSG_找不到图片"), request);
        }
        //return 注册成功
        forward("/account/signup_success", request, response);
        return FORWARD_TO_ANOTHER_URL;
    }

    private boolean doSignupC(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = getRequestEmail(request, "email");
        String account = getRequestString(request, "account");
        if (!validateBlankParams(bundle.getString("GLOBAL_MSG_INPUT_NO_BLANK"), request, response, "email", "account", "accountName", "companyCreateDate", "address",
                "zipCode", "enterpriseQalityGrading", "authenticationDate", "productionLicenseNumber", "productionLicenseValidDate", "field", "bl",
                "qc", "webSide", "companyNature", "legalPerson", "companyScale")) {
            return KEEP_GOING_WITH_ORIG_URL;
        }
        String name = getRequestString(request, "accountName");
        String companyCreateDate = getRequestString(request, "companyCreateDate");
        String address = getRequestString(request, "address");
        String zipCode = getRequestString(request, "zipCode");
        String enterpriseQalityGrading = getRequestString(request, "enterpriseQalityGrading");
        String authenticationDate = getRequestString(request, "authenticationDate");
        String productionLicenseNumber = getRequestString(request, "productionLicenseNumber");
        String productionLicenseValidDate = getRequestString(request, "productionLicenseValidDate");
        String field = getRequestString(request, "field");
        String bl = getRequestString(request, "bl");
        String qc = getRequestString(request, "qc");
        String webSide = getRequestString(request, "webSide");
        String companyNature = getRequestString(request, "companyNature");
        String companyScale = getRequestString(request, "companyScale");
        String natureOthers = getRequestString(request, "natureOthers");
        String legalPerson = super.getRequestString(request, "legalPerson");
        if (email == null) {
            setErrorResult(bundle.getString("ACCOUNT_SIGNUP_MSG_注册失败邮件错误"), request);
            return KEEP_GOING_WITH_ORIG_URL;
        }
        if (account == null) {
            setErrorResult(bundle.getString("ACCOUNT_SIGNUP_MSG_注册失败手机错误"), request);
            return KEEP_GOING_WITH_ORIG_URL;
        }
        String[] icPositions = request.getParameterValues("icPositions");
        if (icPositions.length < 1) {
            setErrorResult(bundle.getString("ACCOUNT_SIGNUP_MSG_注册失败手机错误"), request);
            return KEEP_GOING_WITH_ORIG_URL;
        }
        Date companyCreate = Tools.parseDate(companyCreateDate, "yyyy-MM-dd");
        Date authentication = Tools.parseDate(authenticationDate, "yyyy-MM-dd");
        Date productionLicenseValid = Tools.parseDate(productionLicenseValidDate, "yyyy-MM-dd");
        CompanyScaleEnum companyScaleEnum = null;
        try {
            companyScaleEnum = CompanyScaleEnum.valueOf(companyScale);
        } catch (Exception e) {
            companyScaleEnum = null;
        }
        CompanyNatureEnum companyNatureEnum = null;
        try {
            companyNatureEnum = CompanyNatureEnum.valueOf(companyNature);
        } catch (Exception e) {
            companyNatureEnum = null;
        }
        if (companyNatureEnum == null && Tools.isBlank(natureOthers)) {
            setErrorResult(bundle.getString("ACCOUNT_SIGNUP_MSG_注册失败手机错误"), request);
            return KEEP_GOING_WITH_ORIG_URL;
        }
        String icPosition;
        StringBuilder sb = new StringBuilder();
        for (String ic : icPositions) {
            sb.append(ic);
            sb.append("_");
        }
        icPosition = sb.toString();
        CompanyAccount companyAccount = null;
        try {
            companyAccount = accountService.signupCompany(account, name, email, super.getLanguage(request).getLanguage().toUpperCase(), address, zipCode, icPosition, legalPerson, companyCreate, companyNatureEnum, natureOthers, companyScaleEnum, webSide, enterpriseQalityGrading, authentication, productionLicenseNumber, productionLicenseValid, field, bl, qc);
        } catch (AccountAlreadyExistException ex) {
            setErrorResult(bundle.getString("ACCOUNT_SIGNUP_MSG_账户已经存在"), request);
        } catch (IOException ex) {
            setErrorResult(bundle.getString("ACCOUNT_SIGNUP_MSG_找不到图片"), request);
        }
        //return 注册成功
        forward("/account/signup_success", request, response);
        return FORWARD_TO_ANOTHER_URL;
    }

    /**
     * 发送找回密码连接
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     * @throws NoSessionException
     */
    private boolean doSendResetPasswd(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, NoSessionException {
        String email = getRequestEmail(request, "email");
        if (!validateBlankParams(bundle.getString("GLOBAL_MSG_INPUT_NO_BLANK"), request, response, "email", "account")) {
            return KEEP_GOING_WITH_ORIG_URL;
        }
        if (email == null) {
            setErrorResult(bundle.getString("ACCOUNT_SEND_RESET_PASSWD_请输入正确格式的email地址"), request);
            return KEEP_GOING_WITH_ORIG_URL;
        }
        String account = getRequestString(request, "account");
        Account user = accountService.findByAccount(account);
        if (user == null || !user.getEmail().equals(email) || AccountStatus.APPROVAL_REJECT.equals(user.getStatus()) || AccountStatus.PENDING_FOR_APPROVAL.equals(user.getStatus())) {
            setErrorResult(bundle.getString("ACCOUNT_SEND_RESET_PASSWD_该账号不存在，请重新输入"), request);
            return KEEP_GOING_WITH_ORIG_URL;
        }
        accountService.sendResetPasswdURLEmail(user, bundle.getLocale().getLanguage());
        request.setAttribute("success", true);
        return KEEP_GOING_WITH_ORIG_URL;
    }

    private boolean doResetPasswd(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (!validateBlankParams(bundle.getString("GLOBAL_MSG_INPUT_NO_BLANK"), request, response, "passwd", "key")) {
            return KEEP_GOING_WITH_ORIG_URL;
        }
        String key = getRequestString(request, "key");
        if (key == null) {
            setErrorResult(bundle.getString("GLOBAL_MSG_PARAM_INVALID"), request);
            return KEEP_GOING_WITH_ORIG_URL;
        }
        Account account = accountService.findByRepasswdUrl(key);
        if (account == null) {
            setErrorResult(bundle.getString("GLOBAL_MSG_PARAM_INVALID"), request);
            return KEEP_GOING_WITH_ORIG_URL;
        }
        String password = getRequestString(request, "passwd");
        if (password.length() < 6) {
            setErrorResult(bundle.getString("ACCOUNT_SIGNUP_MSG_密码长度至少6位,请选择新密码"), request);
            return KEEP_GOING_WITH_ORIG_URL;
        }
        accountService.resetPassword(account, password);
        setSuccessResult(bundle.getString("ACCOUNT_SEND_RESET_PASSWD_密码激活成功，请登录"), request);
        request.setAttribute("success", true);
        return KEEP_GOING_WITH_ORIG_URL;
    }

    /**
     * 修改密码
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     * @throws NoSessionException
     */
    private boolean doModifyPasswd(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, NoSessionException {
        if (!validateBlankParams(bundle.getString("GLOBAL_MSG_INPUT_NO_BLANK"), request, response, "oldpasswd", "newpasswd")) {
            return KEEP_GOING_WITH_ORIG_URL;
        }
        String oldpasswd = getRequestString(request, "oldpasswd");
        String newpasswd = getRequestString(request, "newpasswd");
        Account account = getUserFromSession(request);
        account = accountService.findById(account.getId());
        if (!account.getPasswd().equals(Tools.md5(oldpasswd))) {
            setErrorResult(bundle.getString("ACCOUNT_MODIFYPASSWD_MSG_原密码不正确"), request);
            return KEEP_GOING_WITH_ORIG_URL;
        }
        int length = oldpasswd.length();
        String reg = "^([A-Za-z]+[0-9]+[A-Za-z0-9]*|([0-9]+[A-Za-z]+[A-Za-z0-9]*))$";
        if (length < 6) {
            setErrorResult(bundle.getString("ACCOUNT_SIGNUP_MSG_密码长度至少6位,请选择新密码"), request);
            return KEEP_GOING_WITH_ORIG_URL;
        }
        accountService.changePasswd(account.getId(), newpasswd);
        setSuccessResult(bundle.getString("ACCOUNT_REGINFO_MSG_修改成功"), request);
        return KEEP_GOING_WITH_ORIG_URL;
    }

    private boolean doVerifyEmail(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        String verifyUrl = super.getPathInfoStringAt(request, 1);
//        UserAccount userAccount = accountService.findByVerifyUrl(verifyUrl);
//        if (userAccount == null || !userAccount.isEnabled()) {
//            forwardWithError(bundle.getString("GLOBAL_MSG_PARAM_INVALID"), "/public/error_page", request, response);
//            return FORWARD_TO_ANOTHER_URL;
//        }
//        if (userAccount.isVerified()) {
//            setErrorResult(bundle.getString("ACCOUNT_VERIFY_MSG_验证码无效,您的邮箱已通过验证"), request);
//            return KEEP_GOING_WITH_ORIG_URL;
//        }
//        UserAccount account = accountService.setVerified(userAccount.getId(), bundle.getLocale().getLanguage());
//        super.setSessionUser(request, account);
//        setSuccessResult(bundle.getString("ACCOUNT_VERIFY_MSG_您的邮箱地址已验证成功"), request);
        return KEEP_GOING_WITH_ORIG_URL;
    }

    private boolean doSendVerifyEmail(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        UserAccount user = null;
//        try {
//            user = getUserFromSession(request);
//        } catch (NoSessionException ex) {  // 需要对未登录做特殊处理
//            setErrorResult(bundle.getString("GLOBAL_MSG_NO_LOGIN"), request);
//        }
//        accountService.sendVerifiedEmail(user.getId());
//        setSuccessResult(bundle.getString("ACCOUNT_VERIFY_MSG_验证邮件发送成功，请检查您的邮箱"), request);
//        outputText(response, toJSON(request));
        return FORWARD_TO_ANOTHER_URL;
    }

    /**
     * 判断账户是否存在
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     */
    private boolean doAccountIsExist(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String accountName = super.getRequestString(request, "account");
        Account account = accountService.findByAccount(accountName);
        if (account == null) {
            return super.outputSuccessAjax(null, null, response);
        } else {
            return super.outputErrorAjax(bundle.getString("ACCOUNT_已经存在"), null, response);
        }
    }

    /**
     * 修改账户信息
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     */
    private boolean doResetAccountInfo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Account account = super.getUserFromSessionNoException(request);
        FileUploadObj fileUploadObj = null;
        String[] icPositions;
        String address, zipCode, scaleCompany, workExperience, projectExperience, position, others, company, enName;
        Integer workingYear;
        FileUploadItem item;
        try {
            fileUploadObj = super.uploadFile(request, 5.0, null, null, null);
            item = fileUploadObj.getFileField("headImage");
            icPositions = fileUploadObj.getFormFieldArray("icPositions");
            address = fileUploadObj.getFormField("address");
            zipCode = fileUploadObj.getFormField("zipCode");
            scaleCompany = fileUploadObj.getFormField("scaleCompany");
            workExperience = fileUploadObj.getFormField("workExperience");
            projectExperience = fileUploadObj.getFormField("projectExperience");
            position = fileUploadObj.getFormField("position");
            others = fileUploadObj.getFormField("others");
            company = fileUploadObj.getFormField("company");
            workingYear = fileUploadObj.getIntegerFormField("workingYear");
            enName = fileUploadObj.getFormField("enName");
        } catch (FileUploadException ex) {
            setErrorResult(ex.getMessage(), request);
            return KEEP_GOING_WITH_ORIG_URL;
        }
        if (icPositions.length < 1) {
            setErrorResult(bundle.getString("ACCOUNT_SIGNUP_MSG_注册失败手机错误"), request);
            return KEEP_GOING_WITH_ORIG_URL;
        }
        String icPosition;
        StringBuilder sb = new StringBuilder();
        for (String ic : icPositions) {
            sb.append(ic);
            sb.append("_");
        }
        icPosition = sb.toString();
        if (account instanceof CompanyAccount) {
            CompanyScaleEnum scale = null;
            try {
                scale = CompanyScaleEnum.valueOf(scaleCompany);
            } catch (Exception e) {
                scale = null;
            }
            account = accountService.updateCompanyAccount(account.getId(), item, scale, address, zipCode, icPosition);
        } else {
            UserPosition up = null;
            try {
                up = UserPosition.valueOf(position);
            } catch (Exception e) {
                up = null;
            }
            if (up == null && others == null) {
                setErrorResult(bundle.getString("ACCOUNT_SIGNUP_MSG_注册失败手机错误"), request);
                return KEEP_GOING_WITH_ORIG_URL;
            }
            if (workingYear == null) {
                setErrorResult(bundle.getString("ACCOUNT_SIGNUP_MSG_注册失败手机错误"), request);
                return KEEP_GOING_WITH_ORIG_URL;
            }
            account = accountService.updateUserAccount(account.getId(), item, enName, up, others, company, workingYear, workExperience, projectExperience, address, zipCode, icPosition);
        }
        super.setSessionUser(request, account);
        setSuccessResult(bundle.getString("ACCOUNT_REGINFO_MSG_修改成功"), request);
        return KEEP_GOING_WITH_ORIG_URL;
    }

    /**
     * 设置代理人
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     */
    private boolean doSetAgent(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Account account = super.getUserFromSessionNoException(request);
        Long id = super.getRequestLong(request, "id");
        String accountName = super.getRequestString(request, "account");
        String passwd = super.getRequestString(request, "passwd");
        try {
            accountService.setSubCompany(id, account.getId(), accountName, passwd);
        } catch (AccountAlreadyExistException ex) {
            setErrorResult(bundle.getString("ACCOUNT_SIGNUP_MSG_注册失败手机错误"), request);
            return KEEP_GOING_WITH_ORIG_URL;
        }
        setSuccessResult(bundle.getString("ACCOUNT_REGINFO_MSG_修改成功"), request);
        return KEEP_GOING_WITH_ORIG_URL;
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
