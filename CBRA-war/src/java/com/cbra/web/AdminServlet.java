/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cbra.web;

import cn.yoopay.support.exception.NotVerifiedException;
import com.cbra.entity.SysUser;
import com.cbra.service.AdminService;
import com.cbra.support.exception.AccountNotExistException;
import com.cbra.support.exception.EjbMessageException;
import com.cbra.web.support.BadPageException;
import com.cbra.web.support.BadPostActionException;
import com.cbra.web.support.NoSessionException;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.lang.StringUtils;

/**
 *
 * @author yin
 */
@WebServlet(name = "AdminServlet", urlPatterns = {"/admin/*"})
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

        LOGIN, LOGOUT
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
            default:
                throw new BadPostActionException();
        }
    }

    public static enum PageEnum {

        LOGIN, MAIN, TOP, LEFT, RIGHT
    }

    @Override
    boolean processPage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, NoSessionException, BadPageException {
        AdminServlet.PageEnum page = (AdminServlet.PageEnum) request.getAttribute(REQUEST_ATTRIBUTE_PAGE_ENUM);
        switch (page) {
            case LOGIN:
            case MAIN:
                return KEEP_GOING_WITH_ORIG_URL;
            case TOP:
                return loadTopPage(request, response);
            case LEFT:
                return loadLeftPage(request, response);
            case RIGHT:
                return loadRightPage(request, response);
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
