/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cbra.web;

import cn.yoopay.support.exception.NotVerifiedException;
import com.cbra.entity.SysMenu;
import com.cbra.entity.SysRole;
import com.cbra.entity.SysUser;
import com.cbra.service.AdminService;
import com.cbra.support.Pagination;
import com.cbra.support.ResultList;
import com.cbra.support.enums.SysMenuPopedomEnum;
import com.cbra.support.enums.SysUserTypeEnum;
import com.cbra.support.exception.AccountAlreadyExistException;
import com.cbra.support.exception.AccountNotExistException;
import com.cbra.support.exception.EjbMessageException;
import com.cbra.web.support.BadPageException;
import com.cbra.web.support.BadPostActionException;
import com.cbra.web.support.NoSessionException;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
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
import org.apache.commons.lang.StringUtils;

/**
 * 后台管理WEB层
 *
 * @author yin
 */
@WebServlet(name = "AdminServlet", urlPatterns = {"/admin/common/*", "/admin/organization/*", "/admin/*"})
public class AdminServlet extends BaseServlet {

    @EJB
    private AdminService adminService;

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

        LOGIN, LOGOUT,
        MENU_DELETE, MENU_SORT, MENU_CREATE_OR_UPDATE,
        ROLE_DELETE, ROLE_SORT, ROLE_CREATE_OR_UPDATE,
        USER_DELETE, USER_CREATE_OR_UPDATE,
        POPEDOM_DELETE, CHOOSE_ROLE,

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
            case POPEDOM_DELETE:
                return doDeletePopedom(request, response);
            case CHOOSE_ROLE:
                return doChooseRole(request, response);
            default:
                throw new BadPostActionException();
        }
    }

    public static enum PageEnum {

        JUMPBACK, JUMPNOBACK,
        LOGIN, MAIN, TOP, LEFT, RIGHT,
        USER_MANAGE, USER_LIST, USER_INFO,
        MENU_MANAGE, MENU_LIST, MENU_INFO, MENU_TREE, MENU_SORT_LIST,
        ROLE_LIST, ROLE_INFO, ROLE_SORT_LIST,
        POPEDOM_MANAGE, POPEDOM_MENU, POPEDOM_LIST, POPEDOM_CHOOSE_ROLE,
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

    // ************************************************************************
    // *************** PAGE RANDER处理的相关函数，放在这下面
    // ************************************************************************
    //*********************************************************************
    private void setDate(HttpServletRequest request, HttpServletResponse response) {
        Date startDate = this.getRequestStartDate(request);
        Date endDate = this.getRequestEndDate(request);
        request.setAttribute("startDate", startDate);
        request.setAttribute("endDate", endDate);
    }

    private Date getRequestStartDate(HttpServletRequest request) {
        String start = request.getParameter("start");
        Date startDate = null;
        if (start != null) {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            try {
                startDate = sdf.parse(start);
            } catch (ParseException ex) {
            }
        }
        return startDate;
    }

    private Date getRequestEndDate(HttpServletRequest request) {
        String end = request.getParameter("end");
        Date endDate = null;
        if (end != null) {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            try {
                endDate = sdf.parse(end);
            } catch (ParseException ex) {
            }
        }
        return endDate;
    }

}
