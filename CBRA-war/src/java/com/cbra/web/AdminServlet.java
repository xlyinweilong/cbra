/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cbra.web;

import cn.yoopay.support.exception.ImageConvertException;
import cn.yoopay.support.exception.NotVerifiedException;
import com.cbra.Config;
import com.cbra.entity.Account;
import com.cbra.entity.Attendee;
import com.cbra.entity.CompanyAccount;
import com.cbra.entity.FundCollection;
import com.cbra.entity.GatewayManualBankTransfer;
import com.cbra.entity.Message;
import com.cbra.entity.Offer;
import com.cbra.entity.OrderCbraService;
import com.cbra.entity.OrderCollection;
import com.cbra.entity.Plate;
import com.cbra.entity.PlateInformation;
import com.cbra.entity.ReplyMessage;
import com.cbra.entity.SysMenu;
import com.cbra.entity.SysRole;
import com.cbra.entity.SysUser;
import com.cbra.entity.UserAccount;
import com.cbra.service.AccountService;
import com.cbra.service.AdminService;
import com.cbra.service.CbraService;
import com.cbra.service.ConfigService;
import com.cbra.service.GatewayService;
import com.cbra.service.OrderService;
import com.cbra.support.FileUploadItem;
import com.cbra.support.FileUploadObj;
import com.cbra.support.ResultList;
import com.cbra.support.Tools;
import com.cbra.support.enums.AccountIcPosition;
import com.cbra.support.enums.AccountStatus;
import com.cbra.support.enums.CompanyNatureEnum;
import com.cbra.support.enums.CompanyScaleEnum;
import com.cbra.support.enums.FundCollectionAllowAttendeeEnum;
import com.cbra.support.enums.FundCollectionLanaguageEnum;
import com.cbra.support.enums.LanguageType;
import com.cbra.support.enums.MessageSecretLevelEnum;
import com.cbra.support.enums.OrderStatusEnum;
import com.cbra.support.enums.PlateAuthEnum;
import com.cbra.support.enums.PlateKeyEnum;
import com.cbra.support.enums.PlateTypeEnum;
import com.cbra.support.enums.SysMenuPopedomEnum;
import com.cbra.support.enums.SysUserTypeEnum;
import com.cbra.support.enums.UserPosition;
import com.cbra.support.exception.AccountAlreadyExistException;
import com.cbra.support.exception.AccountNotExistException;
import com.cbra.support.exception.EjbMessageException;
import com.cbra.web.support.BadPageException;
import com.cbra.web.support.BadPostActionException;
import com.cbra.web.support.NoSessionException;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
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
 * 后台管理WEB层
 *
 * @author yin
 */
@WebServlet(name = "AdminServlet", urlPatterns = {"/admin/order/*", "/admin/message/*", "/admin/account/*", "/admin/auth/*", "/admin/plate/*", "/admin/datadict/*", "/admin/common/*", "/admin/organization/*", "/admin/*"})
public class AdminServlet extends BaseServlet {

    @EJB
    private AdminService adminService;
    @EJB
    private AccountService accountService;
    @EJB
    private OrderService orderService;
    @EJB
    private GatewayService gatewayService;
    @EJB
    private CbraService cbraService;

    /// <editor-fold defaultstate="collapsed" desc="重要但不常修改的函数. Click on the + sign on the left to edit the code.">
    @Override
    public boolean processUrlReWrite(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        // PROCESS ROOT PAGE.
        if (pathInfo == null || pathInfo.equals("/")) {
            forward("/admin/login", request, response);
            return FORWARD_TO_ANOTHER_URL;
        }

        String[] pathArray = StringUtils.split(pathInfo, "/");
        AdminServlet.PageEnum page = null;
        try {
            page = AdminServlet.PageEnum.valueOf(pathArray[0].toUpperCase());
        } catch (Exception ex) {
            // PROCESS ACCESS CAN NOT PARSE TO A PAGE NAME.
            String url = String.format("/admin/login");
            forward(url, request, response);
            return FORWARD_TO_ANOTHER_URL;
        }

        // 设置这个参数很重要，后续要用。
        request.setAttribute(REQUEST_ATTRIBUTE_PAGE_ENUM, page);
        request.setAttribute(REQUEST_ATTRIBUTE_PATHINFO_ARRAY, pathArray);
        return KEEP_GOING_WITH_ORIG_URL;
    }

    @Override
    public boolean processLoginControl(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, NoSessionException {
        AdminServlet.PageEnum page = (AdminServlet.PageEnum) request.getAttribute(REQUEST_ATTRIBUTE_PAGE_ENUM);
        switch (page) {
            case LOGIN:
                setLogoutOnly(request);
                break;
            default:
                setLoginOnly(request);
        }
        return KEEP_GOING_WITH_ORIG_URL;
    }

    @Override
    boolean processActionEnum(String actionString, HttpServletRequest request, HttpServletResponse response) throws BadPostActionException, ServletException, IOException {
        AdminServlet.ActionEnum action = null;
        try {
            action = AdminServlet.ActionEnum.valueOf(actionString);
        } catch (Exception ex) {
            throw new BadPostActionException();
        }
        // 设置这个参数很重要，后续要用到。Even it's null.
        request.setAttribute(REQUEST_ATTRIBUTE_ACTION_ENUM, action);
        return KEEP_GOING_WITH_ORIG_URL;
    }
    // </editor-fold>

    public static enum ActionEnum {

        LOGIN, LOGOUT, REPASSWD, RELOAD_CONFIG,
        MENU_DELETE, MENU_SORT, MENU_CREATE_OR_UPDATE,
        ROLE_DELETE, ROLE_SORT, ROLE_CREATE_OR_UPDATE,
        USER_DELETE, USER_CREATE_OR_UPDATE,
        POPEDOM_DELETE, CHOOSE_ROLE,
        PLATE_DELETE, PLATE_SORT, PLATE_CREATE_OR_UPDATE,
        PLATE_INFO_DELETE, PLATE_INFO_CREATE_OR_UPDATE, OFFER_DELETE, OFFER_CREATE_OR_UPDATE, EVENT_DELETE, EVENT_CREATE_OR_UPDATE,
        PLATE_AUTH_CREATE_OR_UPDATE,
        MESSAGE_DELETE, MESSAGE_CREATE_OR_UPDATE,
        ACCOUNT_APPROVAL, ACCOUNT_DELETE,
        UPDATE_USER_ACCOUNT, UPDATE_COMPANY_ACCOUNT,
        ORDER_APPROVAL, BANK_TRANSFER_CONFIRM, BANK_TRANSFER_DELETE, BANK_TRANSFER_SERVICE_CONFIRM
    }

    @Override
    boolean loginControlForward(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Boolean pageViewLoginAllowed = (Boolean) request.getAttribute("pageViewLoginAllowed");
        Boolean pageViewLogoutAllowed = (Boolean) request.getAttribute("pageViewLogoutAllowed");
        String requestURI = request.getRequestURI();
        HttpSession session = request.getSession();
        Object admin = session.getAttribute("admin");
        boolean adminLogin = false;
        if (admin != null) {
            adminLogin = true;
        }
        if (!adminLogin && pageViewLoginAllowed && !pageViewLogoutAllowed) {
            response.sendRedirect("/admin/login");
            response.flushBuffer();
            return FORWARD_TO_ANOTHER_URL;

        } else if (adminLogin && !pageViewLoginAllowed && pageViewLogoutAllowed) {
            response.sendRedirect("/admin/main");
            response.flushBuffer();
            if (debug) {
                log("Access logout only page, redirect to home from: " + requestURI);
            }
            return FORWARD_TO_ANOTHER_URL;
        } else {
            return KEEP_GOING_WITH_ORIG_URL;
        }
    }

    @Override
    boolean processAction(HttpServletRequest request, HttpServletResponse response) throws BadPostActionException, ServletException, IOException, NoSessionException, NotVerifiedException {
        AdminServlet.ActionEnum action = (AdminServlet.ActionEnum) request.getAttribute(REQUEST_ATTRIBUTE_ACTION_ENUM);
        switch (action) {
            case LOGIN:
                return doLogin(request, response);
            case LOGOUT:
                return doLogout(request, response);
            case RELOAD_CONFIG:
                return reloadConfig(request, response);
            case MENU_DELETE:
                return doDeleteMenu(request, response);
            case MENU_SORT:
                return doSortMenu(request, response);
            case MENU_CREATE_OR_UPDATE:
                return doCreateOrUpdateMenu(request, response);
            case ROLE_DELETE:
                return doDeleteRole(request, response);
            case ROLE_SORT:
                return doSortRole(request, response);
            case ROLE_CREATE_OR_UPDATE:
                return doCreateOrUpdateRole(request, response);
            case USER_DELETE:
                return doDeleteUser(request, response);
            case USER_CREATE_OR_UPDATE:
                return doCreateOrUpdateUser(request, response);
            case REPASSWD:
                return doRepasswd(request, response);
            case POPEDOM_DELETE:
                return doDeletePopedom(request, response);
            case CHOOSE_ROLE:
                return doChooseRole(request, response);
            case PLATE_DELETE:
                return doDeletePlate(request, response);
            case PLATE_CREATE_OR_UPDATE:
                return doCreateOrUpdatePlate(request, response);
            case PLATE_SORT:
                return doSortPlate(request, response);
            case PLATE_INFO_DELETE:
                return doDeletePlateInfo(request, response);
            case PLATE_INFO_CREATE_OR_UPDATE:
                return doCreateOrUpdatePlateInfo(request, response);
            case OFFER_CREATE_OR_UPDATE:
                return doCreateOrUpdateOffer(request, response);
            case EVENT_CREATE_OR_UPDATE:
                return doCreateOrUpdateEvent(request, response);
            case EVENT_DELETE:
                return doDeleteEvent(request, response);
            case PLATE_AUTH_CREATE_OR_UPDATE:
                return doCreateOrUpdateAuthInfo(request, response);
            case OFFER_DELETE:
                return doDeleteOffer(request, response);
            case ACCOUNT_APPROVAL:
                return doAccountApproval(request, response);
            case MESSAGE_DELETE:
                return doDeleteMessage(request, response);
            case MESSAGE_CREATE_OR_UPDATE:
                return doCreateOrUpdateMessage(request, response);
            case ACCOUNT_DELETE:
                return doAccountDelete(request, response);
            case UPDATE_USER_ACCOUNT:
                return doUpdateUserAccount(request, response);
            case UPDATE_COMPANY_ACCOUNT:
                return doUpdateCompanyAccount(request, response);
            case ORDER_APPROVAL:
                return doOrderApproval(request, response);
            case BANK_TRANSFER_DELETE:
                return doBankTransferDelete(request, response);
            case BANK_TRANSFER_CONFIRM:
                return doBankTransferConfirm(request, response);
            case BANK_TRANSFER_SERVICE_CONFIRM:
                return doBankTransferServiceConfirm(request, response);
            default:
                throw new BadPostActionException();
        }
    }

    public static enum PageEnum {

        JUMPBACK, JUMPNOBACK, KE_UPLOAD, KE_MANAGER, KE_DEL,
        LOGIN, MAIN, TOP, LEFT, RIGHT,
        USER_MANAGE, USER_LIST, USER_INFO, MY_INFO,
        MENU_MANAGE, MENU_LIST, MENU_INFO, MENU_TREE, MENU_SORT_LIST,
        ROLE_LIST, ROLE_INFO, ROLE_SORT_LIST,
        POPEDOM_MANAGE, POPEDOM_MENU, POPEDOM_LIST, POPEDOM_CHOOSE_ROLE,
        PLATE_MANAGE, PLATE_LIST, PLATE_INFO, PLATE_TREE, PLATE_SORT_LIST,
        PLATE_INFO_MANAGE, PLATE_INFO_LIST, PLATE_INFO_INFO, PLATE_INFO_TREE, OFFER_INFO, OFFER_LIST, EVENT_INFO, EVENT_LIST,
        PLATE_AUTH_MANAGE, PLATE_AUTH_INFO, PLATE_AUTH_TREE,
        MESSAGE_INFO, MESSAGE_LIST,
        C_USER_LIST, C_USER_INFO,
        O_USER_LIST, O_USER_INFO,
        ORDER_LIST, ORDER_INFO, USER_ORDER_LIST,
        BANK_TRANSFER_LIST, BANK_TRANSFER_SERVICE_LIST,
        LOAD_CONFIG,
        DOWNLOAD;

    }

    @Override
    boolean processPage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, NoSessionException, BadPageException {
        AdminServlet.PageEnum page = (AdminServlet.PageEnum) request.getAttribute(REQUEST_ATTRIBUTE_PAGE_ENUM);
        switch (page) {
            case LOGIN:
            case MAIN:
            case JUMPBACK:
            case JUMPNOBACK:
            case USER_MANAGE:
            case MENU_MANAGE:
            case POPEDOM_MANAGE:
            case PLATE_MANAGE:
            case PLATE_INFO_MANAGE:
            case PLATE_AUTH_MANAGE:
            case MY_INFO:
            case LOAD_CONFIG:
                return KEEP_GOING_WITH_ORIG_URL;
            case TOP:
                return loadTopPage(request, response);
            case LEFT:
                return loadLeftPage(request, response);
            case RIGHT:
                return loadRightPage(request, response);
            case MENU_TREE:
                return loadMenuTree(request, response);
            case MENU_LIST:
                return loadMenuList(request, response);
            case MENU_SORT_LIST:
                return loadMenuSortList(request, response);
            case MENU_INFO:
                return loadMenuInfo(request, response);
            case ROLE_LIST:
                return loadRoleList(request, response);
            case ROLE_SORT_LIST:
                return loadRoleSortList(request, response);
            case ROLE_INFO:
                return loadRoleInfo(request, response);
            case USER_LIST:
                return loadUserList(request, response);
            case USER_INFO:
                return loadUserInfo(request, response);
            case POPEDOM_MENU:
                return loadPopedomMenu(request, response);
            case POPEDOM_LIST:
                return loadPopedomList(request, response);
            case POPEDOM_CHOOSE_ROLE:
                return loadPopedomChooseRole(request, response);
            case PLATE_LIST:
                return loadPlateList(request, response);
            case PLATE_INFO:
                return loadPlateInfo(request, response);
            case PLATE_TREE:
                return loadPlateTree(request, response);
            case PLATE_SORT_LIST:
                return loadPlateSortList(request, response);
            case PLATE_INFO_LIST:
                return loadPlateInfoList(request, response);
            case OFFER_LIST:
                return loadOfferList(request, response);
            case PLATE_INFO_INFO:
                return loadPlateInfoInfo(request, response);
            case OFFER_INFO:
                return loadOfferInfo(request, response);
            case PLATE_INFO_TREE:
                return loadPlateInfoTree(request, response);
            case PLATE_AUTH_INFO:
                return loadPlateAuthInfo(request, response);
            case PLATE_AUTH_TREE:
                return loadPlateAuthTree(request, response);
            case MESSAGE_INFO:
                return loadMessageInfo(request, response);
            case MESSAGE_LIST:
                return loadMessageList(request, response);
            case C_USER_LIST:
                return loadCUserList(request, response);
            case C_USER_INFO:
                return loadCUserInfo(request, response);
            case O_USER_LIST:
                return loadOUserList(request, response);
            case O_USER_INFO:
                return loadOUserInfo(request, response);
            case KE_UPLOAD:
                return loadKeUpload(request, response);
            case KE_MANAGER:
                return loadKeManager(request, response);
            case KE_DEL:
                return loadKeDel(request, response);
            case EVENT_INFO:
                return loadEventInfo(request, response);
            case EVENT_LIST:
                return loadEventList(request, response);
            case ORDER_LIST:
                return loadOrderList(request, response);
            case ORDER_INFO:
                return loadOrderInfo(request, response);
            case BANK_TRANSFER_LIST:
                return loadBankTransferList(request, response);
            case BANK_TRANSFER_SERVICE_LIST:
                return loadBankTransferServiceList(request, response);
            case DOWNLOAD:
                return loadDownload(request, response);
            case USER_ORDER_LIST:
                return loadUserOrderList(request, response);
            default:
                throw new BadPageException();
        }
    }
    // ************************************************************************
    // *************** ACTION处理的相关函数，放在这下面
    // ************************************************************************

    /**
     * 登出账户
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     */
    private boolean doLogout(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getSession().removeAttribute(SESSION_ATTRIBUTE_ADMIN);
        redirect("/admin", request, response);
        return REDIRECT_TO_ANOTHER_URL;
    }

    /**
     * 重载配置文件
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     */
    private boolean reloadConfig(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        cbraService.loadConfig();
        super.setSuccessResult("重置成功！", request);
        return KEEP_GOING_WITH_ORIG_URL;
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
        SysUser su = null;
        try {
            su = adminService.login(account, passwd);
        } catch (AccountNotExistException | EjbMessageException ex) {
            setErrorResult(ex.getMessage(), request);
            request.setAttribute("account", account);
            request.setAttribute("passwd", passwd);
            return KEEP_GOING_WITH_ORIG_URL;
        }
        request.getSession().setAttribute(SESSION_ATTRIBUTE_ADMIN, su);
        redirect("/admin/main", request, response);
        return REDIRECT_TO_ANOTHER_URL;
    }

    /**
     * 删除菜单
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     */
    private boolean doDeleteMenu(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String[] ids = request.getParameterValues("ids");
        adminService.deleteSysMenuById(ids);
        return KEEP_GOING_WITH_ORIG_URL;
    }

    /**
     * 菜单排序
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     */
    private boolean doSortMenu(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String[] ids = request.getParameterValues("ids");
        adminService.sortSysMenuById(ids);
        String id = super.getRequestString(request, "pid");
        if (id != null) {
            setSuccessResult("保存成功！", request);
            forward("/admin/organization/menu_sort_list?id=" + id, request, response);
            return FORWARD_TO_ANOTHER_URL;
        }
        setSuccessResult("保存成功！", request);
        return KEEP_GOING_WITH_ORIG_URL;
    }

    /**
     * 创建或者更新菜单
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     */
    private boolean doCreateOrUpdateMenu(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Long id = super.getRequestLong(request, "id");
        String menuName = super.getRequestString(request, "menuName");
        String menuUrl = super.getRequestString(request, "menuUrl");
        String menuPopedom = super.getRequestString(request, "menuPopedom");
        Long pid = super.getRequestLong(request, "pid");
        if (menuName == null) {
            setErrorResult("保存失败！参数无效！", request);
            forward("/admin/common/jumpnoback", request, response);
            return FORWARD_TO_ANOTHER_URL;
        }
        SysMenuPopedomEnum popedom = null;
        try {
            popedom = SysMenuPopedomEnum.valueOf(menuPopedom);
        } catch (Exception e) {
            popedom = SysMenuPopedomEnum.COMMON;
        }
        SysMenu sm = adminService.createOrUpdateSysMenu(id, pid, menuName, menuUrl, popedom);
        request.setAttribute("sysMenu", sm);
        request.setAttribute("reflashTreeFrameUrl", "/admin/organization/menu_tree");
        setSuccessResult("保存成功！", "/admin/organization/menu_list?id=" + pid, request);
        forward("/admin/common/jumpback", request, response);
        return FORWARD_TO_ANOTHER_URL;
    }

    /**
     * 删除角色
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     */
    private boolean doDeleteRole(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String[] ids = request.getParameterValues("ids");
        adminService.deleteSysRoleById(ids);
        return KEEP_GOING_WITH_ORIG_URL;
    }

    /**
     * 角色排序
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     */
    private boolean doSortRole(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String[] ids = request.getParameterValues("ids");
        adminService.sortSysMenuById(ids);
        String id = super.getRequestString(request, "pid");
        if (id != null) {
            setSuccessResult("保存成功！", request);
            forward("/admin/organization/menu_sort_list?id=" + id, request, response);
            return FORWARD_TO_ANOTHER_URL;
        }
        setSuccessResult("保存成功！", request);
        return KEEP_GOING_WITH_ORIG_URL;
    }

    /**
     * 创建或者更新角色
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     */
    private boolean doCreateOrUpdateRole(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Long id = super.getRequestLong(request, "id");
        String roleName = super.getRequestString(request, "roleName");
        SysRole sr = adminService.createOrUpdateSysRole(id, roleName);
        request.setAttribute("sysRole", sr);
        setSuccessResult("保存成功！", "/admin/organization/role_list", request);
        forward("/admin/common/jumpback", request, response);
        return FORWARD_TO_ANOTHER_URL;
    }

    /**
     * 删除用户
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     */
    private boolean doDeleteUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String[] ids = request.getParameterValues("ids");
        adminService.deleteSysUser(ids);
        return KEEP_GOING_WITH_ORIG_URL;
    }

    /**
     * 创建用户
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     */
    private boolean doCreateOrUpdateUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Long id = super.getRequestLong(request, "id");
        String userName = super.getRequestString(request, "userName");
        String userPasswd = super.getRequestString(request, "userPasswd");
        String userAccount = super.getRequestString(request, "userAccount");
        Long userRoleId = super.getRequestLong(request, "userRoleId");
        if (userAccount == null || userName == null || userRoleId == null) {
            setErrorResult("保存失败！参数无效！", request);
            forward("/admin/common/jumpnoback", request, response);
            return FORWARD_TO_ANOTHER_URL;
        }
        SysUser su = null;
        try {
            su = adminService.createOrUpdateSysUser(id, userAccount, userName, userPasswd, SysUserTypeEnum.ORDINARY, userRoleId);
        } catch (AccountAlreadyExistException ex) {
            setErrorResult(ex.getMessage(), request);
            forward("/admin/common/jumpnoback", request, response);
            return FORWARD_TO_ANOTHER_URL;
        }
        request.setAttribute("sysUser", su);
        setSuccessResult("保存成功！", "/admin/organization/user_list", request);
        forward("/admin/common/jumpback", request, response);
        return FORWARD_TO_ANOTHER_URL;
    }

    /**
     * 修改密码
     *
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     */
    private boolean doRepasswd(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        SysUser sysUser = (SysUser) super.getSessionValue(request, SESSION_ATTRIBUTE_ADMIN);
        String userName = super.getRequestString(request, "userName");
        String oldPasswd = super.getRequestString(request, "oldPasswd");
        String newPasswd = super.getRequestString(request, "newPasswd");
        String renewPasswd = super.getRequestString(request, "renewPasswd");
        if (userName == null || oldPasswd == null || newPasswd == null || renewPasswd == null) {
            setErrorResult("保存失败！参数无效！", request);
            forward("/admin/common/jumpnoback", request, response);
            return FORWARD_TO_ANOTHER_URL;
        }
        if (newPasswd.length() < 6) {
            setErrorResult("密码必须大于6位！", request);
            forward("/admin/common/jumpnoback", request, response);
            return FORWARD_TO_ANOTHER_URL;
        }
        if (!newPasswd.equals(renewPasswd)) {
            setErrorResult("两次密码输入不一致！", request);
            forward("/admin/common/jumpnoback", request, response);
            return FORWARD_TO_ANOTHER_URL;
        }
        try {
            adminService.repasswd(sysUser, userName, oldPasswd, newPasswd);
        } catch (EjbMessageException ex) {
            setErrorResult(ex.getMessage(), request);
            forward("/admin/common/jumpnoback", request, response);
            return FORWARD_TO_ANOTHER_URL;
        }
        setSuccessResult("保存成功！", "/admin/main?a=logout", request);
        forward("/admin/common/jumpback", request, response);
        return FORWARD_TO_ANOTHER_URL;
    }

    /**
     * 删除赋权限
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     */
    private boolean doDeletePopedom(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String[] ids = request.getParameterValues("roleIds");
        Long mid = super.getRequestLong(request, "mid");
        List<Long> roleIds = new ArrayList<>();
        for (String id : ids) {
            roleIds.add(Long.parseLong(id));
        }
        adminService.deleteSysRoleMenu(mid, roleIds);
        return KEEP_GOING_WITH_ORIG_URL;
    }

    /**
     * 选择角色
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     */
    private boolean doChooseRole(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String[] roleIds = request.getParameterValues("roleIds");
        Long mid = super.getRequestLong(request, "mid");
        adminService.createOrUpdateSysRoleMenu(mid, roleIds);
        setSuccessResult("保存成功！", request);
        forward("/admin/organization/popedom_choose_role?mid=" + mid, request, response);
        return FORWARD_TO_ANOTHER_URL;
    }

    /**
     * 删除栏目
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     */
    private boolean doDeletePlate(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String[] ids = request.getParameterValues("ids");
        adminService.deletePlateByIds(ids);
        return KEEP_GOING_WITH_ORIG_URL;
    }

    /**
     * 创建或者更新栏目
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     */
    private boolean doCreateOrUpdatePlate(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Long id = super.getRequestLong(request, "id");
        Long pid = super.getRequestLong(request, "pid");
        String name = super.getRequestString(request, "plateName");
        String enName = super.getRequestString(request, "plateEnName");
        String key = super.getRequestString(request, "plateKey");
        String page = super.getRequestString(request, "platePage");
        PlateKeyEnum plateKey = null;
        try {
            plateKey = PlateKeyEnum.valueOf(key);
        } catch (Exception e) {
            plateKey = null;
        }
        String type = super.getRequestString(request, "plateType");
        PlateTypeEnum plateType = null;
        try {
            plateType = PlateTypeEnum.valueOf(type);
        } catch (Exception e) {
            plateType = null;
        }
        if (name == null || plateType == null || enName == null) {
            setErrorResult("保存失败！参数无效！", request);
            forward("/admin/common/jumpnoback", request, response);
            return FORWARD_TO_ANOTHER_URL;
        }
        Plate plate = adminService.createOrUpdatePlate(id, name, enName, plateType, plateKey, page, pid);
        request.setAttribute("plate", plate);
        if (pid != null) {
            setSuccessResult("保存成功！", "/admin/datadict/plate_list?id=" + pid, request);
        } else {
            setSuccessResult("保存成功！", "/admin/datadict/plate_list", request);
        }
        request.setAttribute("reflashTreeFrameUrl", "/admin/datadict/plate_tree");
        forward("/admin/common/jumpback", request, response);
        return FORWARD_TO_ANOTHER_URL;
    }

    /**
     * 栏目排序
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     */
    private boolean doSortPlate(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String[] ids = request.getParameterValues("ids");
        adminService.sortPlateById(ids);
        String id = super.getRequestString(request, "pid");
        if (id != null) {
            setSuccessResult("保存成功！", request);
            forward("/admin/datadict/plate_sort_list?id=" + id, request, response);
            return FORWARD_TO_ANOTHER_URL;
        }
        setSuccessResult("保存成功！", request);
        return KEEP_GOING_WITH_ORIG_URL;
    }

    /**
     * 删除栏目信息
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     */
    private boolean doDeletePlateInfo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String[] ids = request.getParameterValues("ids");
        adminService.deletePlateInformationByIds(ids);
        return KEEP_GOING_WITH_ORIG_URL;
    }

    /**
     * 删除活动
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     */
    private boolean doDeleteEvent(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String[] ids = request.getParameterValues("ids");
        adminService.deleteFundCollectionByIds(ids);
        return KEEP_GOING_WITH_ORIG_URL;
    }

    /**
     * 删除招聘信息
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     */
    private boolean doDeleteOffer(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String[] ids = request.getParameterValues("ids");
        adminService.deleteOfferByIds(ids);
        return KEEP_GOING_WITH_ORIG_URL;
    }

    /**
     * 创建/更新栏目信息
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     */
    private boolean doCreateOrUpdatePlateInfo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        FileUploadObj fileUploadObj = null;
        try {
            fileUploadObj = super.uploadFile(request, 10.0, null, null, null);
            List<FileUploadItem> list = fileUploadObj.getFileList();
            FileUploadItem fileUploadItem = null;
            for (FileUploadItem item : list) {
                if ("image".equals(item.getFieldName())) {
                    fileUploadItem = item;
                }
            }
            Long plateId = fileUploadObj.getLongFormField("plateId");
            Long id = fileUploadObj.getLongFormField("id");
            Plate plate = adminService.findPlateById(plateId);
            String pushDateStr = fileUploadObj.getFormField("pushDate");
            Date pushDate = Tools.parseDate(pushDateStr, "yyyy-MM-dd HH:mm:ss");
            Integer orderIndex = fileUploadObj.getIntegerFormField("orderIndex");
            if (pushDate == null) {
                setErrorResult("保存失败，参数异常！", request);
                return KEEP_GOING_WITH_ORIG_URL;
            }
            String languageType = fileUploadObj.getFormField("languageType");
            LanguageType languageTypeEnum = null;
            try {
                languageTypeEnum = LanguageType.valueOf(languageType);
            } catch (Exception e) {
                languageTypeEnum = LanguageType.ZH;
            }
            if (PlateKeyEnum.ABOUT.equals(plate.getPlateKey()) || PlateKeyEnum.CONTACT_US.equals(plate.getPlateKey())) {
                PlateInformation pi = adminService.findPlateInformationByPlateId(plateId, LanguageType.ZH);
                PlateInformation piEn = adminService.findPlateInformationByPlateId(plateId, LanguageType.EN);
                if (piEn != null) {
                    id = piEn.getId();
                }
                if (pi != null) {
                    id = pi.getId();
                }
                String content = fileUploadObj.getFormField("content");
                String contentEn = fileUploadObj.getFormField("contentEn");
                if (content == null || contentEn == null) {
                    setErrorResult("请填写内容！", request);
                    return KEEP_GOING_WITH_ORIG_URL;
                }
                PlateInformation plateInfo = adminService.createOrUpdatePlateInformation(plateId, content, pushDate, LanguageType.ZH);
                PlateInformation plateInfoEn = adminService.createOrUpdatePlateInformation(plateId, contentEn, pushDate, LanguageType.EN);
                request.setAttribute("plateInfo", plateInfo);
                request.setAttribute("plateInfoEn", plateInfoEn);
                request.setAttribute("id", id);
            } else if (PlateKeyEnum.NEWS.equals(plate.getPlateKey()) || PlateKeyEnum.COMMITTEE.equals(plate.getPlateKey())) {
                PlateInformation pi = new PlateInformation();
                if (id != null) {
                    pi = adminService.findPlateInformationById(id);
                }
                String navUrl = fileUploadObj.getFormField("navUrl");
                String content = fileUploadObj.getFormField("content");
                String title = fileUploadObj.getFormField("title");
                String introduction = fileUploadObj.getFormField("introduction");
                if (content == null) {
                    setErrorResult("请填写内容！", request);
                    return KEEP_GOING_WITH_ORIG_URL;
                }
                if (title == null || introduction == null) {
                    setErrorResult("保存失败，参数异常！", request);
                    return KEEP_GOING_WITH_ORIG_URL;
                }
                String touristAuth = fileUploadObj.getFormField("touristAuth");
                String userAuth = fileUploadObj.getFormField("userAuth");
                String companyAuth = fileUploadObj.getFormField("companyAuth");
                PlateAuthEnum touristAuthEnum = null;
                PlateAuthEnum userAuthEnum = null;
                PlateAuthEnum companyAuthEnum = null;
                try {
                    touristAuthEnum = PlateAuthEnum.valueOf(touristAuth);
                } catch (Exception e) {
                    touristAuthEnum = PlateAuthEnum.ONLY_VIEW;
                }
                try {
                    userAuthEnum = PlateAuthEnum.valueOf(userAuth);
                } catch (Exception e) {
                    userAuthEnum = PlateAuthEnum.ONLY_VIEW;
                }
                try {
                    companyAuthEnum = PlateAuthEnum.valueOf(companyAuth);
                } catch (Exception e) {
                    companyAuthEnum = PlateAuthEnum.ONLY_VIEW;
                }
                PlateInformation plateInfo = adminService.createOrUpdatePlateInformation(id, plateId, title, introduction, content, pushDate, languageTypeEnum, navUrl, fileUploadItem, orderIndex, touristAuthEnum, userAuthEnum, companyAuthEnum);
                request.setAttribute("plateInfo", plateInfo);
                request.setAttribute("id", plateInfo.getId());
            } else if (PlateKeyEnum.HOME_ABOUT.equals(plate.getPlateKey()) || PlateKeyEnum.HOME_AD_MENU.equals(plate.getPlateKey())
                    || PlateKeyEnum.HOME_EXPERT.equals(plate.getPlateKey()) || PlateKeyEnum.HOME_SHUFFLING_AD_MENU.equals(plate.getPlateKey()) || PlateKeyEnum.HOME_STYLE.equals(plate.getPlateKey())
                    || PlateKeyEnum.TOP_INTO.equals(plate.getPlateKey()) || PlateKeyEnum.TOP_EVENT.equals(plate.getPlateKey()) || PlateKeyEnum.TOP_TRAIN.equals(plate.getPlateKey())
                    || PlateKeyEnum.TOP_STYLE.equals(plate.getPlateKey()) || PlateKeyEnum.TOP_JOIN.equals(plate.getPlateKey()) || PlateKeyEnum.HOME_NEWS.equals(plate.getPlateKey())) {
                PlateInformation pi = new PlateInformation();
                if (id != null) {
                    pi = adminService.findPlateInformationById(id);
                }
                String navUrl = fileUploadObj.getFormField("navUrl");
                String title = fileUploadObj.getFormField("title");
                String introduction = fileUploadObj.getFormField("introduction");
                if (title == null) {
                    setErrorResult("保存失败，参数异常！", request);
                    return KEEP_GOING_WITH_ORIG_URL;
                }
                PlateInformation plateInfo = adminService.createOrUpdatePlateInformation(id, plateId, title, introduction, pushDate, navUrl, languageTypeEnum, fileUploadItem, orderIndex);
                request.setAttribute("plateInfo", plateInfo);
                request.setAttribute("id", plateInfo.getId());
            }
            request.setAttribute("plateId", plateId);
            setSuccessResult("保存成功！", request);
        } catch (FileUploadException ex) {
            setErrorResult(ex.getMessage(), request);
            return KEEP_GOING_WITH_ORIG_URL;
        }
        return KEEP_GOING_WITH_ORIG_URL;
    }

    /**
     * 创建更新招聘
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     */
    private boolean doCreateOrUpdateOffer(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        FileUploadObj fileUploadObj = null;
        try {
            fileUploadObj = super.uploadFile(request, 10.0, null, null, null);
            Long plateId = fileUploadObj.getLongFormField("plateId");
            Long id = fileUploadObj.getLongFormField("id");
            String pushDateStr = fileUploadObj.getFormField("pushDate");
            Date pushDate = Tools.parseDate(pushDateStr, "yyyy-MM-dd HH:mm:ss");
            if (pushDate == null) {
                setErrorResult("保存失败，参数异常！", request);
                return KEEP_GOING_WITH_ORIG_URL;
            }
            String languageType = fileUploadObj.getFormField("languageType");
            LanguageType languageTypeEnum = null;
            try {
                languageTypeEnum = LanguageType.valueOf(languageType);
            } catch (Exception e) {
                languageTypeEnum = LanguageType.ZH;
            }
            String position = fileUploadObj.getFormField("position");
            String depart = fileUploadObj.getFormField("depart");
            String city = fileUploadObj.getFormField("city");
            String station = fileUploadObj.getFormField("station");
            String count = fileUploadObj.getFormField("count");
            String monthly = fileUploadObj.getFormField("monthly");
            String description = fileUploadObj.getFormField("description");
            String duty = fileUploadObj.getFormField("duty");
            String competence = fileUploadObj.getFormField("competence");
            String age = fileUploadObj.getFormField("age");
            String gender = fileUploadObj.getFormField("gender");
            String englishLevel = fileUploadObj.getFormField("englishLevel");
            String education = fileUploadObj.getFormField("education");
            String name = fileUploadObj.getFormField("name");
            String enName = fileUploadObj.getFormField("enName");
            String mobile = fileUploadObj.getFormField("mobile");
            String email = fileUploadObj.getFormField("email");
            String obtain = fileUploadObj.getFormField("obtain");
            String company = fileUploadObj.getFormField("company");
            String address = fileUploadObj.getFormField("address");
            String zipCode = fileUploadObj.getFormField("zipCode");
            String positionEnum = fileUploadObj.getFormField("positionEnum");
            String others = fileUploadObj.getFormField("others");
            String[] icPositions = fileUploadObj.getFormFieldArray("accountIcPosition");
            String icPosition;
            StringBuilder sb = new StringBuilder();
            if (icPositions != null) {
                for (String ic : icPositions) {
                    sb.append(ic);
                    sb.append("_");
                }
            }
            icPosition = sb.toString();
            UserPosition up = null;
            try {
                up = UserPosition.valueOf(positionEnum);
            } catch (Exception e) {
                up = null;
            }
            if (up != null) {
                others = null;
            }
            String touristAuth = fileUploadObj.getFormField("touristAuth");
            String userAuth = fileUploadObj.getFormField("userAuth");
            String companyAuth = fileUploadObj.getFormField("companyAuth");
            PlateAuthEnum touristAuthEnum = null;
            PlateAuthEnum userAuthEnum = null;
            PlateAuthEnum companyAuthEnum = null;
            try {
                touristAuthEnum = PlateAuthEnum.valueOf(touristAuth);
            } catch (Exception e) {
                touristAuthEnum = PlateAuthEnum.ONLY_VIEW;
            }
            try {
                userAuthEnum = PlateAuthEnum.valueOf(userAuth);
            } catch (Exception e) {
                userAuthEnum = PlateAuthEnum.ONLY_VIEW;
            }
            try {
                companyAuthEnum = PlateAuthEnum.valueOf(companyAuth);
            } catch (Exception e) {
                companyAuthEnum = PlateAuthEnum.ONLY_VIEW;
            }
            Offer offer = adminService.createOrUpdateOffer(id, plateId, pushDate, position, depart, city, station, count, monthly, description, duty, competence, age, gender, englishLevel, education, languageTypeEnum, name, enName, mobile, email, obtain, company, address, zipCode, up, others, icPosition, touristAuthEnum, userAuthEnum, companyAuthEnum);
            request.setAttribute("offer", offer);
            request.setAttribute("id", offer.getId());
            request.setAttribute("plateId", plateId);
            setSuccessResult("保存成功！", request);
        } catch (FileUploadException ex) {
            setErrorResult(ex.getMessage(), request);
            return KEEP_GOING_WITH_ORIG_URL;
        }
        return KEEP_GOING_WITH_ORIG_URL;
    }

    /**
     * 创建更新活动
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     */
    private boolean doCreateOrUpdateEvent(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        FileUploadObj fileUploadObj = null;
        try {
            fileUploadObj = super.uploadFile(request, 10.0, null, null, null);
            List<FileUploadItem> list = fileUploadObj.getFileList();
            FileUploadItem fileUploadItem = null;
            FileUploadItem fileUploadItem2 = null;
            for (FileUploadItem item : list) {
                if ("image".equals(item.getFieldName())) {
                    fileUploadItem = item;
                }
                if ("mobileImage".equals(item.getFieldName())) {
                    fileUploadItem2 = item;
                }
            }
            Long plateId = fileUploadObj.getLongFormField("plateId");
            Long id = fileUploadObj.getLongFormField("id");
            Date statusBeginDate = fileUploadObj.getDateFormField("statusBeginDate", "yyyy-MM-dd HH:mm:ss");
            Date statusEndDate = fileUploadObj.getDateFormField("statusEndDate", "yyyy-MM-dd HH:mm:ss");
            Date eventBeginDate = fileUploadObj.getDateFormField("eventBeginDate", "yyyy-MM-dd HH:mm:ss");
            Date eventEndDate = fileUploadObj.getDateFormField("eventEndDate", "yyyy-MM-dd HH:mm:ss");
            Date checkinDate = fileUploadObj.getDateFormField("checkinDate", "yyyy-MM-dd HH:mm:ss");
            String title = fileUploadObj.getFormField("title");
            String eventLocation = fileUploadObj.getFormField("eventLocation");
            BigDecimal touristPrice = fileUploadObj.optBigDecimalFormField("touristPrice", BigDecimal.ZERO);
            BigDecimal userPrice = fileUploadObj.optBigDecimalFormField("userPrice", BigDecimal.ZERO);
            BigDecimal companyPrice = fileUploadObj.optBigDecimalFormField("companyPrice", BigDecimal.ZERO);
            Integer eachCompanyFreeCount = fileUploadObj.getIntegerFormField("eachCompanyFreeCount");
            String touristAuth = fileUploadObj.getFormField("touristAuth");
            String userAuth = fileUploadObj.getFormField("userAuth");
            String companyAuth = fileUploadObj.getFormField("companyAuth");
            String allowAttendee = fileUploadObj.getFormField("allowAttendee");
            String languageType = fileUploadObj.getFormField("languageType");
            String detailDescHtml = fileUploadObj.getFormField("detailDescHtml");
            String mobileIntroduction = fileUploadObj.getFormField("mobileIntroduction");
            FundCollectionLanaguageEnum languageTypeEnum = null;
            PlateAuthEnum touristAuthEnum = null;
            PlateAuthEnum userAuthEnum = null;
            PlateAuthEnum companyAuthEnum = null;
            FundCollectionAllowAttendeeEnum allowAttendeeEnum = null;
            if (eachCompanyFreeCount == null) {
                eachCompanyFreeCount = 0;
            }
            try {
                languageTypeEnum = FundCollectionLanaguageEnum.valueOf(languageType);
            } catch (Exception e) {
                languageTypeEnum = FundCollectionLanaguageEnum.ZH;
            }
            try {
                touristAuthEnum = PlateAuthEnum.valueOf(touristAuth);
            } catch (Exception e) {
                touristAuthEnum = PlateAuthEnum.ONLY_VIEW;
            }
            try {
                userAuthEnum = PlateAuthEnum.valueOf(userAuth);
            } catch (Exception e) {
                userAuthEnum = PlateAuthEnum.ONLY_VIEW;
            }
            try {
                companyAuthEnum = PlateAuthEnum.valueOf(companyAuth);
            } catch (Exception e) {
                companyAuthEnum = PlateAuthEnum.ONLY_VIEW;
            }
            try {
                allowAttendeeEnum = FundCollectionAllowAttendeeEnum.valueOf(allowAttendee);
            } catch (Exception e) {
                allowAttendeeEnum = FundCollectionAllowAttendeeEnum.PUBLIC;
            }
            FundCollection fundCollection = adminService.createOrUpdateFundCollection(id, plateId, statusBeginDate, statusEndDate, eventBeginDate, eventEndDate, checkinDate, title, detailDescHtml, allowAttendeeEnum, languageTypeEnum, eventLocation, touristPrice, userPrice, companyPrice, eachCompanyFreeCount, touristAuthEnum, userAuthEnum, companyAuthEnum, mobileIntroduction, fileUploadItem, fileUploadItem2);
            request.setAttribute("fundCollection", fundCollection);
            request.setAttribute("id", fundCollection.getId());
            request.setAttribute("plateId", plateId);
            setSuccessResult("保存成功！", request);
        } catch (FileUploadException ex) {
            setErrorResult(ex.getMessage(), request);
            return KEEP_GOING_WITH_ORIG_URL;
        }
        return KEEP_GOING_WITH_ORIG_URL;
    }

    /**
     * 创建/更新权限信息
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     */
    private boolean doCreateOrUpdateAuthInfo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Long id = super.getRequestLong(request, "plateId");
        String touristAuth = super.getRequestString(request, "touristAuth");
        String userAuth = super.getRequestString(request, "userAuth");
        String companyAuth = super.getRequestString(request, "companyAuth");
        PlateAuthEnum touristAuthEnum = null;
        PlateAuthEnum userAuthEnum = null;
        PlateAuthEnum companyAuthEnum = null;
        try {
            touristAuthEnum = PlateAuthEnum.valueOf(touristAuth);
            userAuthEnum = PlateAuthEnum.valueOf(userAuth);
            companyAuthEnum = PlateAuthEnum.valueOf(companyAuth);
        } catch (Exception e) {
            touristAuthEnum = PlateAuthEnum.ONLY_VIEW;
            userAuthEnum = PlateAuthEnum.ONLY_VIEW;
            companyAuthEnum = PlateAuthEnum.ONLY_VIEW;
        }
        if (id == null) {
            setErrorResult("保存失败，参数异常！", request);
            return KEEP_GOING_WITH_ORIG_URL;
        }
        Plate plate = adminService.updatePlateAuth(id, touristAuthEnum, userAuthEnum, companyAuthEnum);
        request.setAttribute("plate", plate);
        request.setAttribute("plateId", plate.getId());
        setSuccessResult("保存成功！", request);
        return KEEP_GOING_WITH_ORIG_URL;
    }

    /**
     * 用户注册审批
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     */
    private boolean doAccountApproval(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Long id = super.getRequestLong(request, "id");
        String status = super.getRequestString(request, "type");
        String message = super.getRequestString(request, "message");
        AccountStatus statusEnum = null;
        try {
            statusEnum = AccountStatus.valueOf(status);
        } catch (Exception e) {
            setErrorResult("保存失败，参数异常！", request);
            return KEEP_GOING_WITH_ORIG_URL;
        }
        Account account = accountService.approvalAccount(id, statusEnum, message);
        request.setAttribute("account", account);
        setSuccessResult("操作成功！", request);
        return KEEP_GOING_WITH_ORIG_URL;
    }

    /**
     * 删除信息
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     */
    private boolean doDeleteMessage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String[] ids = request.getParameterValues("ids");
        adminService.deleteMessageByIds(ids);
        return KEEP_GOING_WITH_ORIG_URL;
    }

    /**
     * 创建更新信息
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     */
    private boolean doCreateOrUpdateMessage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Long id = super.getRequestLong(request, "id");
        Long mid = super.getRequestLong(request, "mid");
        String content = super.getRequestString(request, "content");
        String messageSecretLevel = super.getRequestString(request, "messageSecretLevel");
        MessageSecretLevelEnum messageSecretLevelEnum = null;
        try {
            messageSecretLevelEnum = MessageSecretLevelEnum.valueOf(messageSecretLevel);
        } catch (Exception e) {
            messageSecretLevelEnum = MessageSecretLevelEnum.PUBLIC;
        }
        if (mid == null) {
            setErrorResult("保存失败，参数异常！", request);
            return KEEP_GOING_WITH_ORIG_URL;
        }
        ReplyMessage replyMessage = adminService.createOrUpdateReplyMessage(id, mid, super.getSysUserFromSessionNoException(request), content, messageSecretLevelEnum);
        request.setAttribute("message", replyMessage);
        request.setAttribute("id", id);
        request.setAttribute("mid", mid);
        setSuccessResult("保存成功！", request);
        return KEEP_GOING_WITH_ORIG_URL;
    }

    /**
     * 账户删除
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     */
    private boolean doAccountDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String[] ids = request.getParameterValues("ids");
        System.out.println(ids[0]);
        accountService.deleteAccountByIds(ids);
        return KEEP_GOING_WITH_ORIG_URL;
    }

    /**
     * 更新个人用户信息
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     */
    private boolean doUpdateUserAccount(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Long id = super.getRequestLong(request, "id");
        String email = super.getRequestEmail(request, "userAccount.email");
        String name = super.getRequestString(request, "userAccount.name");
        String passwd = super.getRequestString(request, "userAccount.passwd");
        String account = super.getRequestString(request, "userAccount.account");
        String enName = super.getRequestString(request, "userAccount.enName");
        String company = super.getRequestString(request, "userAccount.company");
        Integer workingYear = super.getRequestInteger(request, "userAccount.workingYear");
        String position = super.getRequestString(request, "userAccount.position");
        String address = super.getRequestString(request, "userAccount.address");
        String zipCode = super.getRequestString(request, "userAccount.zipCode");
        String workExperience = super.getRequestString(request, "userAccount.workExperience");
        String projectExperience = super.getRequestString(request, "userAccount.projectExperience");
        String others = super.getRequestString(request, "userAccount.others");
        String[] icPositions = request.getParameterValues("accountIcPosition");
        String icPosition;
        StringBuilder sb = new StringBuilder();
        if (icPositions != null) {
            for (String ic : icPositions) {
                sb.append(ic);
                sb.append("_");
            }
        }
        icPosition = sb.toString();
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
        UserAccount userAccount = null;
        try {
            userAccount = accountService.updateUserAccount(id, account, passwd, name, email, address, zipCode, icPosition, enName, workingYear, company, up, others, workExperience, projectExperience);
        } catch (AccountAlreadyExistException ex) {
            setErrorResult(bundle.getString("ACCOUNT_SIGNUP_MSG_账户已经存在"), request);
        }
        setSuccessResult("保存成功！", request);
        return KEEP_GOING_WITH_ORIG_URL;
    }

    /**
     * 更新公司用户信息
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     */
    private boolean doUpdateCompanyAccount(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Long id = super.getRequestLong(request, "id");
        String email = super.getRequestEmail(request, "email");
        String name = super.getRequestString(request, "name");
        String passwd = super.getRequestString(request, "passwd");
        String account = super.getRequestString(request, "account");
        Date companyCreateDate = super.getRequestDate(request, "companyCreateDate");
        String legalPerson = super.getRequestString(request, "legalPerson");
        String webSide = super.getRequestString(request, "webSide");
        String enterpriseQalityGrading = super.getRequestString(request, "enterpriseQalityGrading");
        Date authenticationDate = super.getRequestDate(request, "authenticationDate");
        String zipCode = super.getRequestString(request, "zipCode");
        String address = super.getRequestString(request, "address");
        String productionLicenseNumber = super.getRequestString(request, "productionLicenseNumber");
        Date productionLicenseValidDate = super.getRequestDate(request, "productionLicenseValidDate");
        String natureOthers = super.getRequestString(request, "natureOthers");
        String[] icPositions = request.getParameterValues("accountIcPosition");
        String icPosition;
        StringBuilder sb = new StringBuilder();
        if (icPositions != null) {
            for (String ic : icPositions) {
                sb.append(ic);
                sb.append("_");
            }
        }
        icPosition = sb.toString();
        String nature = super.getRequestString(request, "nature");
        CompanyNatureEnum cn = null;
        try {
            cn = CompanyNatureEnum.valueOf(nature);
        } catch (Exception e) {
            cn = null;
        }
        if (cn == null && Tools.isBlank(natureOthers)) {
            setErrorResult(bundle.getString("ACCOUNT_SIGNUP_MSG_注册失败手机错误"), request);
            return KEEP_GOING_WITH_ORIG_URL;
        }
        String scale = super.getRequestString(request, "scale");
        CompanyScaleEnum cs = null;
        try {
            cs = CompanyScaleEnum.valueOf(scale);
        } catch (Exception e) {
            cs = null;
        }
        CompanyAccount companyAccount = null;
        try {
            companyAccount = accountService.updateCompanyAccount(id, account, passwd, name, email, address, zipCode, icPosition, companyCreateDate, legalPerson, webSide, enterpriseQalityGrading, authenticationDate, productionLicenseNumber, productionLicenseValidDate, cn, natureOthers, cs);
        } catch (AccountAlreadyExistException ex) {
            setErrorResult(bundle.getString("ACCOUNT_SIGNUP_MSG_账户已经存在"), request);
        }
        setSuccessResult("保存成功！", request);
        return KEEP_GOING_WITH_ORIG_URL;
    }

    /**
     * 订单审批
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     */
    private boolean doOrderApproval(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Long id = super.getRequestLong(request, "id");
        String status = super.getRequestString(request, "type");
        String message = super.getRequestString(request, "message");
        OrderStatusEnum orderStatusEnum = null;
        try {
            orderStatusEnum = OrderStatusEnum.valueOf(status);
        } catch (Exception e) {
            setErrorResult("保存失败，参数异常！", request);
            return KEEP_GOING_WITH_ORIG_URL;
        }
        OrderCollection order = accountService.approvalOrder(id, orderStatusEnum, message);
        request.setAttribute("order", order);
        request.setAttribute("oid", order.getId());
        setSuccessResult("操作成功！", request);
        return KEEP_GOING_WITH_ORIG_URL;
    }

    /**
     * 删除银行转账
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     */
    private boolean doBankTransferDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String[] ids = request.getParameterValues("ids");
        accountService.deleteBankTransferByIds(ids);
        return KEEP_GOING_WITH_ORIG_URL;
    }

    /**
     * 银行转账确认
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     */
    private boolean doBankTransferConfirm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Long id = super.getRequestLong(request, "id");
        gatewayService.confirmBankTransfer(id);
        return KEEP_GOING_WITH_ORIG_URL;
    }

    /**
     * 银行转账确认
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     */
    private boolean doBankTransferServiceConfirm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Long id = super.getRequestLong(request, "id");
        gatewayService.confirmBankTransfer(id);
        return KEEP_GOING_WITH_ORIG_URL;
    }

    // ************************************************************************
    // *************** PAGE RANDER处理的相关函数，放在这下面
    // ************************************************************************
    //*********************************************************************
    /**
     * 显示页面左侧
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     */
    private boolean loadLeftPage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        SysUser sysUser = (SysUser) super.getSessionValue(request, SESSION_ATTRIBUTE_ADMIN);
        request.setAttribute("menuList", adminService.findSysMenuByUserId(sysUser.getId(), 1));
        request.setAttribute("subMenuList", adminService.findSysMenuByUserId(sysUser.getId(), 2));
        return KEEP_GOING_WITH_ORIG_URL;
    }

    /**
     * 显示页面顶端
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     */
    private boolean loadTopPage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        return KEEP_GOING_WITH_ORIG_URL;
    }

    /**
     * 显示页面右侧的首页
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     */
    private boolean loadRightPage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        return KEEP_GOING_WITH_ORIG_URL;
    }

    /**
     * 菜单树
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     */
    private boolean loadMenuTree(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("menuList", adminService.findSysMenuListByLevel(1));
        return KEEP_GOING_WITH_ORIG_URL;
    }

    /**
     * 菜单列表
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     */
    private boolean loadMenuList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("menuList", adminService.findSysMenuListByParentId(super.getRequestLong(request, "id")));
        request.setAttribute("pid", super.getRequestString(request, "id"));
        return KEEP_GOING_WITH_ORIG_URL;
    }

    /**
     * 菜单排序页
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     */
    private boolean loadMenuSortList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("menuList", adminService.findSysMenuListByParentId(super.getRequestLong(request, "id")));
        request.setAttribute("pid", super.getRequestString(request, "id"));
        return KEEP_GOING_WITH_ORIG_URL;
    }

    /**
     * 菜单详细信息
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     */
    private boolean loadMenuInfo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        SysMenu sysMenu = null;
        if (super.getRequestLong(request, "id") != null) {
            sysMenu = adminService.findSysMenuById(super.getRequestLong(request, "id"));
            request.setAttribute("id", sysMenu.getId());
        } else {
            sysMenu = new SysMenu();
        }
        request.setAttribute("sysMenu", sysMenu);
        request.setAttribute("menuPopedomList", Arrays.asList(SysMenuPopedomEnum.values()));
        request.setAttribute("pid", super.getRequestString(request, "pid"));
        return KEEP_GOING_WITH_ORIG_URL;
    }

    /**
     * 角色列表
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     */
    private boolean loadRoleList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("roleList", adminService.findSysRoleListAll());
        return KEEP_GOING_WITH_ORIG_URL;
    }

    /**
     * 角色排序页
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     */
    private boolean loadRoleSortList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("roleList", adminService.findSysRoleListAll());
        return KEEP_GOING_WITH_ORIG_URL;
    }

    /**
     * 角色详细信息
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     */
    private boolean loadRoleInfo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        SysRole sysRole = null;
        if (super.getRequestLong(request, "id") != null) {
            sysRole = adminService.findSysRoleById(super.getRequestLong(request, "id"));
            request.setAttribute("id", sysRole.getId());
        } else {
            sysRole = new SysRole();
        }
        request.setAttribute("sysRole", sysRole);
        return KEEP_GOING_WITH_ORIG_URL;
    }

    /**
     * 用户列表
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     */
    private boolean loadUserList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Integer page = super.getRequestInteger(request, "page");
        if (page == null) {
            page = 1;
        }
        Map<String, Object> map = new HashMap<>();
        ResultList<SysUser> resultList = adminService.findSysUserList(map, page, 10, null, true);
        request.setAttribute("resultList", resultList);
        return KEEP_GOING_WITH_ORIG_URL;
    }

    /**
     * 用户详细信息
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     */
    private boolean loadUserInfo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        SysUser sysUser = null;
        if (super.getRequestLong(request, "id") != null) {
            sysUser = adminService.findById(super.getRequestLong(request, "id"));
            request.setAttribute("id", sysUser.getId());
        } else {
            sysUser = new SysUser();
        }
        request.setAttribute("sysUser", sysUser);
        request.setAttribute("roleList", adminService.findSysRoleListAll());
        return KEEP_GOING_WITH_ORIG_URL;
    }

    /**
     * 赋权限菜单
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     */
    private boolean loadPopedomMenu(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("menuList", adminService.findSysMenuListByPopedom(SysMenuPopedomEnum.COMMON));
        return KEEP_GOING_WITH_ORIG_URL;
    }

    /**
     * 赋权限列表
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     */
    private boolean loadPopedomList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Long menuId = super.getRequestLong(request, "mid");
        request.setAttribute("roleList", adminService.findSysRoleListByMenuId(menuId));
        request.setAttribute("mid", menuId);
        return KEEP_GOING_WITH_ORIG_URL;
    }

    /**
     * 选择赋权限列表
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     */
    private boolean loadPopedomChooseRole(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Long menuId = super.getRequestLong(request, "mid");
        request.setAttribute("roleList", adminService.findSysRoleListAll());
        request.setAttribute("mid", menuId);
        return KEEP_GOING_WITH_ORIG_URL;
    }

    /**
     * 栏目树
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     */
    private boolean loadPlateTree(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("plateList", adminService.findPlateList());
        return KEEP_GOING_WITH_ORIG_URL;
    }

    /**
     * 栏目列表
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     */
    private boolean loadPlateList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("plateList", adminService.findPlateListByParentId(super.getRequestLong(request, "id")));
        request.setAttribute("pid", super.getRequestString(request, "id"));
        return KEEP_GOING_WITH_ORIG_URL;
    }

    /**
     * 栏目详细信息
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     */
    private boolean loadPlateInfo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Plate plate = null;
        if (super.getRequestLong(request, "id") != null) {
            plate = adminService.findPlateById(super.getRequestLong(request, "id"));
            request.setAttribute("id", plate.getId());
        } else {
            plate = new Plate();
        }
        request.setAttribute("plate", plate);
        request.setAttribute("plateTypeEnumList", Arrays.asList(PlateTypeEnum.values()));
        request.setAttribute("plateKeyEnumList", Arrays.asList(PlateKeyEnum.values()));
        request.setAttribute("pid", super.getRequestString(request, "pid"));
        return KEEP_GOING_WITH_ORIG_URL;
    }

    /**
     * 栏目排序页
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     */
    private boolean loadPlateSortList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("plateList", adminService.findPlateListByParentId(super.getRequestLong(request, "id")));
        request.setAttribute("pid", super.getRequestString(request, "id"));
        return KEEP_GOING_WITH_ORIG_URL;
    }

    /**
     * 栏目信息树
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     */
    private boolean loadPlateInfoTree(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("plateList", adminService.findPlateList());
        return KEEP_GOING_WITH_ORIG_URL;
    }

    /**
     * 栏目信息列表
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     */
    private boolean loadPlateInfoList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Long plateId = super.getRequestLong(request, "plateId");
        Plate plate = adminService.findPlateById(plateId);
        if (PlateKeyEnum.ABOUT.equals(plate.getPlateKey()) || PlateKeyEnum.CONTACT_US.equals(plate.getPlateKey())) {
            super.forward("/admin/plate/plate_info_info?plateId=" + plateId, request, response);
            return FORWARD_TO_ANOTHER_URL;
        } else if (PlateKeyEnum.OFFER.equals(plate.getPlateKey())) {
            super.forward("/admin/plate/offer_list?plateId=" + plateId, request, response);
            return FORWARD_TO_ANOTHER_URL;
        } else if (PlateKeyEnum.EVENT.equals(plate.getPlateKey())) {
            super.forward("/admin/plate/event_list?plateId=" + plateId, request, response);
            return FORWARD_TO_ANOTHER_URL;
        } else {
            Integer page = super.getRequestInteger(request, "page");
            if (page == null) {
                page = 1;
            }
            Map<String, Object> map = new HashMap<>();
            map.put("plateId", plateId);
            ResultList<PlateInformation> resultList = adminService.findPlateInformationList(map, page, 15, null, true);
            request.setAttribute("resultList", resultList);
            request.setAttribute("plate", plate);
        }
        request.setAttribute("plateId", plateId);
        return KEEP_GOING_WITH_ORIG_URL;
    }

    /**
     * 招聘列表
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     */
    private boolean loadOfferList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Long plateId = super.getRequestLong(request, "plateId");
        Integer page = super.getRequestInteger(request, "page");
        if (page == null) {
            page = 1;
        }
        String searchName = super.getRequestString(request, "searchName");
        String searchPositionEnum = super.getRequestString(request, "searchPositionEnum");
        Map<String, Object> map = new HashMap<>();
        map.put("plateId", plateId);
        if (searchName != null) {
            map.put("searchName", searchName);
        }
        if ("others".equals(searchPositionEnum)) {
            request.setAttribute("searchPositionEnumOthers", "true");
            map.put("searchPositionEnumOthers", "true");
        } else {
            UserPosition up = null;
            try {
                up = UserPosition.valueOf(searchPositionEnum);
                request.setAttribute("searchPositionEnum", searchPositionEnum);
                map.put("searchPositionEnum", up);
            } catch (Exception e) {
                up = null;
            }
        }
        ResultList<Offer> resultList = adminService.findOfferList(map, page, 15, null, true);
        request.setAttribute("searchName", searchName);
        request.setAttribute("resultList", resultList);
        request.setAttribute("plateId", plateId);
        request.setAttribute("positions", UserPosition.values());
        return KEEP_GOING_WITH_ORIG_URL;
    }

    /**
     * 活动列表
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     */
    private boolean loadEventList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Long plateId = super.getRequestLong(request, "plateId");
        Integer page = super.getRequestInteger(request, "page");
        if (page == null) {
            page = 1;
        }
        Map<String, Object> map = new HashMap<>();
        map.put("plateId", plateId);
        ResultList<FundCollection> resultList = adminService.findCollectionList(map, page, 15, null, true);
        request.setAttribute("resultList", resultList);
        request.setAttribute("plateId", plateId);
        return KEEP_GOING_WITH_ORIG_URL;
    }

    /**
     * 加载订单列表
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     */
    private boolean loadOrderList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Integer page = super.getRequestInteger(request, "page");
        if (page == null) {
            page = 1;
        }
        Map<String, Object> map = new HashMap<>();
        String statusStr = super.getRequestString(request, "status");
        try {
            map.put("status", OrderStatusEnum.valueOf(statusStr));
            request.setAttribute("status", OrderStatusEnum.valueOf(statusStr));
        } catch (Exception e) {
            map.remove("status");
        }
        ResultList<OrderCollection> resultList = orderService.findOrderCollectionList(map, page, 15, null, true);
        request.setAttribute("resultList", resultList);
        request.setAttribute("statusList", Arrays.asList(OrderStatusEnum.values()));
        return KEEP_GOING_WITH_ORIG_URL;
    }

    /**
     * 加载用户订单
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     */
    private boolean loadUserOrderList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Integer page = super.getRequestInteger(request, "page");
        if (page == null) {
            page = 1;
        }
        Map<String, Object> map = new HashMap<>();
        String statusStr = super.getRequestString(request, "status");
        try {
            map.put("status", OrderStatusEnum.valueOf(statusStr));
            request.setAttribute("status", OrderStatusEnum.valueOf(statusStr));
        } catch (Exception e) {
            map.remove("status");
        }
        ResultList<OrderCbraService> resultList = orderService.findOrderCbraServiceList(map, page, 15, null, true);
        request.setAttribute("resultList", resultList);
        request.setAttribute("statusList", Arrays.asList(OrderStatusEnum.values()));
        return KEEP_GOING_WITH_ORIG_URL;
    }

    /**
     * 加载订单详细页
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     */
    private boolean loadOrderInfo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Long id = super.getRequestLong(request, "oid");
        if (id == null) {
            id = (Long) request.getAttribute("oid");
        }
        OrderCollection orderCollection = orderService.findOrderCollectionById(id);
        List<Attendee> attendeeList = orderService.findAttendeeByOrder(orderCollection.getId());
        request.setAttribute("orderCollection", orderCollection);
        request.setAttribute("attendeeList", attendeeList);
        return KEEP_GOING_WITH_ORIG_URL;
    }

    /**
     * 银行转账未确认列表
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     */
    private boolean loadBankTransferList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Integer page = super.getRequestInteger(request, "page");
        if (page == null) {
            page = 1;
        }
        Map<String, Object> map = new HashMap<>();
        String statusStr = super.getRequestString(request, "status");
        try {
            map.put("status", OrderStatusEnum.valueOf(statusStr));
            request.setAttribute("status", OrderStatusEnum.valueOf(statusStr));
        } catch (Exception e) {
            map.remove("status");
            List<OrderStatusEnum> statuss = new ArrayList<>();
            statuss.add(OrderStatusEnum.PENDING_PAYMENT_CONFIRM);
            statuss.add(OrderStatusEnum.SUCCESS);
            map.put("statuss", statuss);
        }
        ResultList<GatewayManualBankTransfer> resultList = adminService.findGatewayManualBankTransferList(map, page, 15, null, true);
        request.setAttribute("resultList", resultList);
        return KEEP_GOING_WITH_ORIG_URL;
    }

    /**
     * 银行转账未确认列表
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     */
    private boolean loadBankTransferServiceList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Integer page = super.getRequestInteger(request, "page");
        if (page == null) {
            page = 1;
        }
        Map<String, Object> map = new HashMap<>();
        String statusStr = super.getRequestString(request, "status");
        try {
            map.put("serviceStatus", OrderStatusEnum.valueOf(statusStr));
            request.setAttribute("status", OrderStatusEnum.valueOf(statusStr));
        } catch (Exception e) {
            map.remove("serviceStatus");
            List<OrderStatusEnum> statuss = new ArrayList<>();
            statuss.add(OrderStatusEnum.PENDING_PAYMENT_CONFIRM);
            statuss.add(OrderStatusEnum.SUCCESS);
            map.put("serviceStatuss", statuss);
        }
        ResultList<GatewayManualBankTransfer> resultList = adminService.findGatewayManualBankTransferList(map, page, 15, null, true);
        request.setAttribute("resultList", resultList);
        return KEEP_GOING_WITH_ORIG_URL;
    }

    /**
     * 下载文件
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     */
    private boolean loadDownload(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path1 = super.getPathInfoStringAt(request, 1);
        String path2 = super.getPathInfoStringAt(request, 2);
        Tools.download(Config.FILE_UPLOAD_DIR + path1 + "/" + path2, response);
        return FORWARD_TO_ANOTHER_URL;
    }

    /**
     * 活动信息
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     */
    private boolean loadEventInfo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Long id = super.getRequestLong(request, "id");
        Long plateId = super.getRequestLong(request, "plateId");
        if (plateId == null && id == null) {
            plateId = (Long) (request.getAttribute("plateId"));
            id = (Long) (request.getAttribute("id"));
        }
        FundCollection collection = null;
        if (id == null) {
            collection = new FundCollection();
        } else {
            collection = adminService.findCollectionById(id);
        }
        Plate plate = adminService.findPlateById(plateId);
        request.setAttribute("showBackBtn", true);
        request.setAttribute("fundCollection", collection);
        request.setAttribute("plate", plate);
        request.setAttribute("languageTypeList", Arrays.asList(FundCollectionLanaguageEnum.values()));
        request.setAttribute("allowAttendeeEnumList", Arrays.asList(FundCollectionAllowAttendeeEnum.values()));
        request.setAttribute("plateAuthEnumList", Arrays.asList(PlateAuthEnum.values()));
        return KEEP_GOING_WITH_ORIG_URL;
    }

    /**
     * 加载栏目信息
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     */
    private boolean loadPlateInfoInfo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Long id = super.getRequestLong(request, "id");
        Long plateId = super.getRequestLong(request, "plateId");
        if (plateId == null && id == null) {
            plateId = (Long) (request.getAttribute("plateId"));
            id = (Long) (request.getAttribute("id"));
        }
        PlateInformation plateInfo = null;
        if (id == null) {
            plateInfo = new PlateInformation();
        } else {
            plateInfo = adminService.findPlateInformationByIdFetchContent(id);
        }
        Plate plate = adminService.findPlateById(plateId);
        if (PlateKeyEnum.ABOUT.equals(plate.getPlateKey()) || PlateKeyEnum.CONTACT_US.equals(plate.getPlateKey())) {
            plateInfo = adminService.findPlateInformationByPlateId(plateId, LanguageType.ZH);
            if (plateInfo != null) {
                plateInfo.setPlateInformationContent(adminService.findContentByPlateInformation(plateInfo.getId()));
            }
            PlateInformation plateEnInfo = adminService.findPlateInformationByPlateId(plateId, LanguageType.EN);
            if (plateEnInfo != null) {
                plateEnInfo.setPlateInformationContent(adminService.findContentByPlateInformation(plateEnInfo.getId()));
            }
            request.setAttribute("plateEnInfo", plateEnInfo);
            request.setAttribute("showBackBtn", false);
        } else {
            request.setAttribute("showBackBtn", true);
        }
        request.setAttribute("plateInfo", plateInfo);
        request.setAttribute("plate", plate);
        request.setAttribute("languageTypeList", Arrays.asList(LanguageType.values()));
        request.setAttribute("plateAuthEnumList", Arrays.asList(PlateAuthEnum.values()));
        return KEEP_GOING_WITH_ORIG_URL;
    }

    /**
     * 招聘信息
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     */
    private boolean loadOfferInfo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Long id = super.getRequestLong(request, "id");
        Long plateId = super.getRequestLong(request, "plateId");
        if (plateId == null && id == null) {
            plateId = (Long) (request.getAttribute("plateId"));
            id = (Long) (request.getAttribute("id"));
        }
        Offer offer = null;
        if (id == null) {
            offer = new Offer();
        } else {
            offer = adminService.findOfferById(id);
        }
        Plate plate = adminService.findPlateById(plateId);
        request.setAttribute("showBackBtn", true);
        request.setAttribute("offer", offer);
        request.setAttribute("plate", plate);
        request.setAttribute("languageTypeList", Arrays.asList(LanguageType.values()));
        request.setAttribute("accountIcPositionList", Arrays.asList(AccountIcPosition.values()));
        request.setAttribute("positions", UserPosition.values());
        request.setAttribute("plateAuthEnumList", Arrays.asList(PlateAuthEnum.values()));
        if (offer.getIcPosition() != null) {
            request.setAttribute("positionList", Arrays.asList(offer.getIcPosition().split("_")));
        } else {
            request.setAttribute("positionList", new ArrayList());
        }
        return KEEP_GOING_WITH_ORIG_URL;
    }

    /**
     * 权限树
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     */
    private boolean loadPlateAuthTree(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("plateList", adminService.findPlateAuthList());
        return KEEP_GOING_WITH_ORIG_URL;
    }

    /**
     * 权限设置页
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     */
    private boolean loadPlateAuthInfo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("plate", adminService.findPlateById(super.getRequestLong(request, "plateId")));
        request.setAttribute("plateAuthEnumList", Arrays.asList(PlateAuthEnum.values()));
        return KEEP_GOING_WITH_ORIG_URL;
    }

    /**
     * 消息列表
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     */
    private boolean loadMessageList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Integer page = super.getRequestInteger(request, "page");
        if (page == null) {
            page = 1;
        }
        Map<String, Object> map = new HashMap<>();
        ResultList<Message> resultList = adminService.findMessageList(map, page, 15, null, true);
        request.setAttribute("resultList", resultList);
        return KEEP_GOING_WITH_ORIG_URL;
    }

    /**
     * 加载信息页面
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     */
    private boolean loadMessageInfo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Long id = super.getRequestLong(request, "id");
        Long mid = super.getRequestLong(request, "mid");
        if (id != null) {
            request.setAttribute("message", adminService.findReplyMessageById(id));
        }
        request.setAttribute("secretLevelList", Arrays.asList(MessageSecretLevelEnum.values()));
        request.setAttribute("mid", mid);
        request.setAttribute("id", id);
        return KEEP_GOING_WITH_ORIG_URL;
    }

    /**
     * 公司用户列表
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     */
    private boolean loadCUserList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Integer page = super.getRequestInteger(request, "page");
        if (page == null) {
            page = 1;
        }
        Map<String, Object> map = new HashMap<>();
        String searchName = super.getRequestString(request, "searchName");
        if (Tools.isNotBlank(searchName)) {
            map.put("searchName", searchName);
        }
        request.setAttribute("searchName", searchName);
        ResultList<CompanyAccount> resultList = accountService.findCompanyList(map, page, 15);
        request.setAttribute("resultList", resultList);
        return KEEP_GOING_WITH_ORIG_URL;
    }

    /**
     * 公司用户详细信息
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     */
    private boolean loadCUserInfo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Long id = super.getRequestLong(request, "id");
        CompanyAccount ca = (CompanyAccount) accountService.findById(id);
        request.setAttribute("positionList", Arrays.asList(ca.getIcPosition().split("_")));
        request.setAttribute("accountIcPositionList", Arrays.asList(AccountIcPosition.values()));
        request.setAttribute("companyNatureEnums", CompanyNatureEnum.values());
        request.setAttribute("companyScaleEnums", CompanyScaleEnum.values());
        request.setAttribute("companyAccount", ca);
        return KEEP_GOING_WITH_ORIG_URL;
    }

    /**
     * 个人用户泪列表
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     */
    private boolean loadOUserList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Integer page = super.getRequestInteger(request, "page");
        if (page == null) {
            page = 1;
        }
        Map<String, Object> map = new HashMap<>();
        String searchName = super.getRequestString(request, "searchName");
        if (Tools.isNotBlank(searchName)) {
            map.put("searchName", searchName);
        }
        request.setAttribute("searchName", searchName);
        ResultList<UserAccount> resultList = accountService.findUserList(map, page, 15);
        request.setAttribute("resultList", resultList);
        return KEEP_GOING_WITH_ORIG_URL;
    }

    /**
     * 个人用户详细
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     */
    private boolean loadOUserInfo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Long id = super.getRequestLong(request, "id");
        UserAccount ua = (UserAccount) accountService.findById(id);
        request.setAttribute("positionList", Arrays.asList(ua.getIcPosition().split("_")));
        request.setAttribute("accountIcPositionList", Arrays.asList(AccountIcPosition.values()));
        request.setAttribute("positions", UserPosition.values());
        request.setAttribute("userAccount", ua);
        return KEEP_GOING_WITH_ORIG_URL;
    }

    /**
     * 上传文件
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     * @throws NoSessionException
     */
    private boolean loadKeUpload(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, NoSessionException {
        SysUser sysUser = (SysUser) super.getSessionValue(request, SESSION_ATTRIBUTE_ADMIN);
        FileUploadObj fileUploadObj = null;
        String dirName = request.getParameter("dir");
        try {
            fileUploadObj = super.uploadFile(request, 10.0, null, null, null);
            if (Tools.isBlank(dirName)) {
                dirName = fileUploadObj.getFormField("dir");
            }
            List<FileUploadItem> list = fileUploadObj.getFileList();
            for (FileUploadItem item : list) {
                JSONObject obj = null;
                try {
                    String name = adminService.setHtmlEditorUploadFile(item, sysUser, dirName);
                    if (name != null) {
                        obj = new JSONObject();
                        obj.put("error", 0);
                        obj.put("url", name);
                        super.outputText(response, obj.toJSONString());
                    }
                } catch (ImageConvertException e) {
                    setErrorResult(bundle.getString("ACCOUNT_REGINFO_MSG_请上传正确的图片格式"), request);
                    return KEEP_GOING_WITH_ORIG_URL;
                }
            }
            return KEEP_GOING_WITH_ORIG_URL;
        } catch (FileUploadException ex) {
            setErrorResult(ex.getMessage(), request);
            return KEEP_GOING_WITH_ORIG_URL;
        }
    }

    /**
     * 文件管理
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     * @throws NoSessionException
     */
    private boolean loadKeManager(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, NoSessionException {
        SysUser sysUser = (SysUser) super.getSessionValue(request, SESSION_ATTRIBUTE_ADMIN);
        String dirName = request.getParameter("dir");
        String path = request.getParameter("path") != null ? request.getParameter("path") : "";
        String order = request.getParameter("order") != null ? request.getParameter("order").toLowerCase() : "name";
        Map map = adminService.doHtmlEditorFileManager(sysUser, dirName, path, order);
        if (null != map && !map.isEmpty()) {
            JSONObject result = new JSONObject();
            result.put("moveup_dir_path", map.get("moveup_dir_path"));
            result.put("current_dir_path", map.get("current_dir_path"));
            result.put("current_url", map.get("current_url"));
            result.put("total_count", map.get("total_count"));
            result.put("file_list", map.get("file_list"));
            response.setContentType("application/json; charset=UTF-8");
            super.outputText(response, result.toJSONString());
        }
        return KEEP_GOING_WITH_ORIG_URL;
    }

    /**
     * 删除文件‘
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     * @throws NoSessionException
     */
    private boolean loadKeDel(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, NoSessionException {
        SysUser sysUser = (SysUser) super.getSessionValue(request, SESSION_ATTRIBUTE_ADMIN);
        String fileName = request.getParameter("filename");
        adminService.doHtmlEditorFileDel(sysUser, fileName);
        return super.outputSuccessAjax("Success...", null, response);
    }

    // ************************************************************************
    // *************** PAGE RANDER处理的相关函数，放在这下面
    // ************************************************************************
    //*********************************************************************
}
