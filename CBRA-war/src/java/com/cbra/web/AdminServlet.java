/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cbra.web;

import cn.yoopay.support.exception.NotVerifiedException;
import com.cbra.web.support.BadPageException;
import com.cbra.web.support.BadPostActionException;
import com.cbra.web.support.NoSessionException;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
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

        LOGIN,
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
            default:
                throw new BadPostActionException();
        }
    }

    public static enum PageEnum {

        LOGIN, MAIN,TOP,LEFT,RIGHT
    }

    @Override
    boolean processPage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, NoSessionException, BadPageException {
        AdminServlet.PageEnum page = (AdminServlet.PageEnum) request.getAttribute(REQUEST_ATTRIBUTE_PAGE_ENUM);
        switch (page) {
            case LOGIN:
            case MAIN:
            case TOP:
                return KEEP_GOING_WITH_ORIG_URL;
            case LEFT:
                return loadLeftPage(request,response);
            case RIGHT:
                return loadRightPage(request,response);
            default:
                throw new BadPageException();
        }
    }
    // ************************************************************************
    // *************** ACTION处理的相关函数，放在这下面
    // ************************************************************************

    private boolean loadLogout(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getSession().removeAttribute(SESSION_ATTRIBUTE_ADMIN);
        forward("/admin/main", request, response);
        return FORWARD_TO_ANOTHER_URL;
    }

    private boolean doLogin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String passwd = getRequestString(request, "passwd");
        request.getSession().setAttribute(SESSION_ATTRIBUTE_USER, "12312");
        request.getSession().setAttribute("admin", "123");
        setErrorResult("密码输入错误", request);
        redirect("/admin/main", request, response);
        System.out.println("123123");
        return REDIRECT_TO_ANOTHER_URL;
    }

    // ************************************************************************
    // *************** PAGE RANDER处理的相关函数，放在这下面
    // ************************************************************************
    //*********************************************************************
    
    private boolean loadLeftPage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String passwd = getRequestString(request, "passwd");
        setErrorResult("密码输入错误", request);
        System.out.println("123123");
        return KEEP_GOING_WITH_ORIG_URL;
    }
    
    private boolean loadRightPage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String passwd = getRequestString(request, "passwd");
        setErrorResult("密码输入错误", request);
        System.out.println("123123");
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
