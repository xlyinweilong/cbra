/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cbra.web;

import cn.yoopay.support.exception.ImageConvertException;
import cn.yoopay.support.exception.NotVerifiedException;
import com.cbra.entity.Account;
import com.cbra.entity.CompanyAccount;
import com.cbra.entity.UserAccount;
import com.cbra.service.AccountService;
import com.cbra.support.FileUploadItem;
import com.cbra.support.FileUploadObj;
import com.cbra.support.NoPermException;
import com.cbra.support.Tools;
import com.cbra.support.enums.AccountIcPosition;
import com.cbra.support.enums.AccountStatus;
import com.cbra.support.enums.CompanyNatureEnum;
import com.cbra.support.enums.CompanyScaleEnum;
import com.cbra.support.enums.LanguageType;
import com.cbra.support.enums.UserPosition;
import com.cbra.support.exception.AccountAlreadyExistException;
import com.cbra.support.exception.AccountNotExistException;
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
                setLogoutOnly(request);
                break;
            case LOGOUT:
            case VERIFY:
            case RESET_PASSWD:
            case SEND_RESET_PASSWD:
            case LOAD_ACCOUNT_BY_AJAX:
            case Z_IFRAME_UPLOAD_PC:
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
        UPLOAD_PERSON_CARD, ACCOUNT_IS_EXIST;
    }

    @Override
    boolean processAction(HttpServletRequest request, HttpServletResponse response) throws BadPostActionException, ServletException, IOException, NoSessionException, NotVerifiedException {
        ActionEnum action = (ActionEnum) request.getAttribute(REQUEST_ATTRIBUTE_ACTION_ENUM);
        switch (action) {
            case LOGOUT:
                return doLogout(request, response);
            case LOGIN_AJAX:
                return doLoginAjax(request, response);
            case SIGNUP_AJAX:
                return doSignupAjax(request, response);
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
            default:
                throw new BadPostActionException();
        }
    }

    private enum PageEnum {

        Z_LOGIN_DIALOG, Z_SIGNUP_DIALOG, LOGIN, LOGOUT, REGINFO, SIGNUP, SIGNUP_C, OVERVIEW, VERIFY, SEND_VERIFY_EMAIL, SEND_RESET_PASSWD, LOAD_ACCOUNT_BY_AJAX,
        MY_EVENT, MEMBERSHIP_FEE, MODIFY_PASSWD, RESET_PASSWD, Z_IFRAME_UPLOAD_PC;
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
            case MODIFY_PASSWD:
                return KEEP_GOING_WITH_ORIG_URL;
            case REGINFO:
                return loadRegInfo(request, response);
            case VERIFY:
                return doVerifyEmail(request, response);
            case SEND_VERIFY_EMAIL:
                return doSendVerifyEmail(request, response);
            case RESET_PASSWD:
                return loadResetPassword(request, response);
            case SEND_RESET_PASSWD:
                return KEEP_GOING_WITH_ORIG_URL;
            case LOAD_ACCOUNT_BY_AJAX:
                return loadAccountByAjax(request, response);
            case MEMBERSHIP_FEE:
                return loadMembershipFee(request, response);
            case MY_EVENT:
                return loadMyEventList(request, response);
            case Z_IFRAME_UPLOAD_PC:
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

    private boolean doLoginAjax(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = getRequestString(request, "email");
        if (!validateBlankParams(bundle.getString("GLOBAL_MSG_INPUT_NO_BLANK"), request, response, "email", "passwd")) {
            return super.outputAjax(request, response);
        }
        String passwd = getRequestString(request, "passwd");

        // ******************************************************************
//        Account user = accountService.getUserForLogin(email, passwd);
//        if (user == null) {
//            return super.outputErrorAjax(bundle.getString("ACCOUNT_LOGIN_MSG_FAIL"), null, response);
//        }
//
//        super.setLogRequestUser(logRequest, user);
        // ******************************************************************
        // 设置user到session里，并设置显示数据。
//        return loginAjax(user, request, response);
        return FORWARD_TO_ANOTHER_URL;
    }

    private boolean doSignupAjax(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = getRequestEmail(request, "signupEmail");
        String mobilePhone = getRequestString(request, "signupMobilePhone");
//        if (!validateBlankParams(bundle.getString("GLOBAL_MSG_INPUT_NO_BLANK"), request, response, "name", "signupEmail", "passwd1", "passwd2")) {
//            return KEEP_GOING_WITH_ORIG_URL;
//        }
//        String name = getRequestString(request, "name");
//
//        if (email == null) {
//            setErrorResult(bundle.getString("ACCOUNT_SIGNUP_MSG_注册失败邮件错误"), request);
//            return KEEP_GOING_WITH_ORIG_URL;
//        }
//        if (mobilePhone == null) {
//            setErrorResult(bundle.getString("ACCOUNT_SIGNUP_MSG_注册失败手机错误"), request);
//            return KEEP_GOING_WITH_ORIG_URL;
//        }
//        String passwd1 = getRequestString(request, "passwd1");
//        String passwd2 = getRequestString(request, "passwd2");
//
//        // ******************************************************************
//        if (!passwd1.equals(passwd2)) {
//            setErrorResult(bundle.getString("ACCOUNT_SIGNUP_MSG_两次密码不一致"), request);
//            return KEEP_GOING_WITH_ORIG_URL;
//        }
//        if (passwd1.length() < 6) {
//            setErrorResult(bundle.getString("ACCOUNT_SIGNUP_MSG_密码长度至少6位,请选择新密码"), request);
//            return KEEP_GOING_WITH_ORIG_URL;
//        }
//        UserAccount user = null;
//        try {
//            user = accountService.signup(name, email, mobilePhone, passwd2, bundle.getLocale().getLanguage());
//            Long paymentId = super.getRequestLong(request, "pop_signup_payid");
//            if (paymentId != null && paymentId != -1) {
//                FundPayment payment = fundService.findPayment(paymentId);
//                if (email.equalsIgnoreCase(payment.getOwnerUser().getEmail())) {
//                    user = accountService.setVerified(user.getId(), bundle.getLocale().getLanguage());
//                }
//            }
//        } catch (UserExistException ex) {
//            setErrorResult(MessageFormat.format(bundle.getString("ACCOUNT_SIGNUP_MSG_已注册,请登录"), email), request);
//            return KEEP_GOING_WITH_ORIG_URL;
//        }

        // ******************************************************************
        // 注册成功后直接登录进来。
//        return loginAjax(user, request, response);
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
        if (user.getStatus().equals(AccountStatus.PENDING_FOR_APPROVAL)) {
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
        return login(userAccount, true, request, response);
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
        return login(companyAccount, true, request, response);
        //return KEEP_GOING_WITH_ORIG_URL;
    }

    private boolean doSendResetPasswd(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, NoSessionException {
//        String email = getRequestEmail(request, "email");
//        if (!validateBlankParams(bundle.getString("GLOBAL_MSG_INPUT_NO_BLANK"), request, response, "email", "verifycode")) {
//            return KEEP_GOING_WITH_ORIG_URL;
//        }
//
//        if (email == null) {
//            setErrorResult(bundle.getString("ACCOUNT_SEND_RESET_PASSWD_请输入正确格式的email地址"), request);
//            return KEEP_GOING_WITH_ORIG_URL;
//        }
//        String verifycode = getRequestString(request, "verifycode");
//        String sessionVerifycode = (String) request.getSession().getAttribute("imageverifycode");
//        if (sessionVerifycode == null || !sessionVerifycode.equals(verifycode)) {
//            setErrorResult(bundle.getString("ACCOUNT_SEND_RESET_PASSWD_验证码输入错误"), request);
//            request.setAttribute("email", email);
//            return KEEP_GOING_WITH_ORIG_URL;
//        }
//        UserAccount user = accountService.findByEmail(email);
//        if (user == null) {
//            setErrorResult(bundle.getString("ACCOUNT_SEND_RESET_PASSWD_该账号不存在，请重新输入"), request);
//            return KEEP_GOING_WITH_ORIG_URL;
//        }
//        accountService.sendResetPasswdURLEmail(user, bundle.getLocale().getLanguage());
//        setSuccessResult(bundle.getString("ACCOUNT_SEND_RESET_PASSWD_发送成功，请查看您的邮箱"), request);
        return KEEP_GOING_WITH_ORIG_URL;
    }

    private boolean doResetPasswd(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        if (!validateBlankParams(bundle.getString("GLOBAL_MSG_INPUT_NO_BLANK"), request, response, "password", "password1")) {
//            return KEEP_GOING_WITH_ORIG_URL;
//        }
//        String webUrl = getRequestString(request, "webUrl");
//        if (webUrl == null) {
//            setErrorResult(bundle.getString("GLOBAL_MSG_PARAM_INVALID"), request);
//            return KEEP_GOING_WITH_ORIG_URL;
//        }
//        UserPasswdReset reset = accountService.findUserPasswdResetByWebUrl(webUrl);
//        if (reset == null) {
//            setErrorResult(bundle.getString("GLOBAL_MSG_PARAM_INVALID"), request);
//            return KEEP_GOING_WITH_ORIG_URL;
//        }
//        String password = getRequestString(request, "password");
//        String password1 = getRequestString(request, "password1");
//        if (password.length() < 6) {
//            setErrorResult(bundle.getString("ACCOUNT_SIGNUP_MSG_密码长度至少6位,请选择新密码"), request);
//            return KEEP_GOING_WITH_ORIG_URL;
//        }
//        if (!password.equals(password1)) {
//            setErrorResult(bundle.getString("ACCOUNT_SIGNUP_MSG_两次密码不一致"), request);
//            return KEEP_GOING_WITH_ORIG_URL;
//        }
//        accountService.resetPassword(reset.getUser().getId(), reset, password);
//        request.setAttribute("email", reset.getUser().getEmail());
//        setSuccessResult(bundle.getString("ACCOUNT_SEND_RESET_PASSWD_密码激活成功，请登录"), request);

        return KEEP_GOING_WITH_ORIG_URL;
    }

    private boolean doModifyPasswd(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, NoSessionException {
//        if (!validateBlankParams(bundle.getString("GLOBAL_MSG_INPUT_NO_BLANK"), request, response, "password", "password1", "password2")) {
//            return KEEP_GOING_WITH_ORIG_URL;
//        }
//        String password = getRequestString(request, "password").trim();
//        String password1 = getRequestString(request, "password1").trim();
//        String password2 = getRequestString(request, "password2").trim();
//        UserAccount user = getUserFromSession(request);
//        user = accountService.findById(user.getId());
//        if (!user.getPasswd().equals(Tools.md5(password))) {
//            setErrorResult(bundle.getString("ACCOUNT_MODIFYPASSWD_MSG_原密码不正确"), request);
//            return KEEP_GOING_WITH_ORIG_URL;
//        }
//        int length = password1.length();
//        String reg = "^([A-Za-z]+[0-9]+[A-Za-z0-9]*|([0-9]+[A-Za-z]+[A-Za-z0-9]*))$";
//        if (length < 6) {
//            setErrorResult(bundle.getString("ACCOUNT_SIGNUP_MSG_密码长度至少6位,请选择新密码"), request);
//            return KEEP_GOING_WITH_ORIG_URL;
//        }
//        if (!password1.equals(password2)) {
//            setErrorResult(bundle.getString("ACCOUNT_SIGNUP_MSG_两次密码不一致"), request);
//            return KEEP_GOING_WITH_ORIG_URL;
//        }
//        accountService.changePasswd(user.getId(), password1);
//        setSuccessResult(bundle.getString("ACCOUNT_REGINFO_MSG_修改成功"), request);
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

    // ************************************************************************
    // *************** PAGE RANDER处理的相关函数，放在这下面
    // ************************************************************************
    private boolean loadAccountByAjax(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = getRequestString(request, "email");
        if (validateBlankParams(bundle.getString("GLOBAL_MSG_INPUT_NO_BLANK"), request, response, "email", "password")) {
            String password = getRequestString(request, "password");
//            Account user = accountService.getUserForLogin(email, password);
//            if (user == null) {
//                setErrorResult(bundle.getString("ACCOUNT_LOGIN_MSG_FAIL"), request);
//            } else {
//                setSuccessResult(toJSON(user), request);
//            }
        }
        super.outputText(response, toJSON(request));
        return FORWARD_TO_ANOTHER_URL;
    }

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
        return KEEP_GOING_WITH_ORIG_URL;
    }

    private boolean loadRegInfo(HttpServletRequest request, HttpServletResponse response) throws NoSessionException {
        return KEEP_GOING_WITH_ORIG_URL;
    }

    private boolean loadOverview(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        return KEEP_GOING_WITH_ORIG_URL;
    }

    private boolean loadResetPassword(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        String webUrl = getPathInfoStringAt(request, 1);
//        request.setAttribute("webUrl", webUrl);
//        UserPasswdReset reset = accountService.findUserPasswdResetByWebUrl(webUrl);
//        if (reset == null) {
//            forwardWithError(bundle.getString("GLOBAL_MSG_PARAM_INVALID"), "/public/error_page", request, response);
//            return FORWARD_TO_ANOTHER_URL;
//        }
        return KEEP_GOING_WITH_ORIG_URL;
    }

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
//    private boolean loginAjax(UserAccount user, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        //Save language
//        if (user.getLanguage() == null) {
//            user = accountService.setLanguage(user.getId(), bundle.getLocale().getLanguage());
//        }
//        //Save yplinkId, only for old yoopay user
//        if (user.getYpLinkId() == null) {
//            user = accountService.setYpLink(user.getId());
//        }
//        HttpSession session = request.getSession();
//        // bundle是JSTL用到的session数据，用来在JSP中显示不同语言，
//        // 在Login时去掉这个bundle，然后会在z_heander中被重新生成，这样可以实现登录之后使用用户自定义的语言的功能。
//        session.removeAttribute("bundle");
//        // 设置user到session里，这是登录与否的标志，很重要哦！！
//        session.setAttribute(SESSION_ATTRIBUTE_USER, user);
//        UserServiceStatus uss = accountService.getUserServiceStatus(user.getId());
//        if (uss.getServiceType() == null) {
//            session.setAttribute("USER_YPSERVICE_TYPE", "FREE");
//        } else if (uss.getServiceType().equals(YpServiceTypeEnum.STANDARD)) {
//            session.setAttribute("USER_YPSERVICE_TYPE", "STANDARD");
//        } else if (uss.getServiceType().equals(YpServiceTypeEnum.PROFESSIONAL)) {
//            session.setAttribute("USER_YPSERVICE_TYPE", "PROFESSIONAL");
//        }
//        if (user.getLanguage() != null) {
//            super.setLanguage(user.getLanguage(), request, response);
//        }
//        //Get User Invoice 
//        UserInvoice invoice = fundService.findUserInvoiceByUserId(user.getId());
//
//        Map<String, Object> result = new HashMap<String, Object>();
//        result.put("success", true);
//        result.put("user", user);
//        if (invoice != null) {
//            result.put("invoice", invoice);
//        }
//        JSONSerializer serializer = new JSONSerializer();
//        serializer.include("success", "user.email", "user.name", "user.position", "user.company", "user.mobilePhone", "invoice.invoiceTitle", "invoice.recipientPostcode", "invoice.recipientProvince", "invoice.recipientAddress", "invoice.recipientPhone", "invoice.recipientName");
//        serializer.exclude("*");
//        String serialize = serializer.serialize(result);
//        super.outputText(response, serialize);
//        return FORWARD_TO_ANOTHER_URL;
//    }
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
        if (account instanceof CompanyAccount) {
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
