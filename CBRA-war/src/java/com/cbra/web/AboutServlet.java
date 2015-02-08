/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cbra.web;

import cn.yoopay.support.exception.NotVerifiedException;
import com.cbra.entity.Account;
import com.cbra.service.AccountService;
import com.cbra.support.NoPermException;
import com.cbra.support.Tools;
import com.cbra.support.exception.AccountNotExistException;
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

/**
 * 走进、加入WEB层
 *
 * @author yin.weilong
 */
@WebServlet(name = "AboutServlet", urlPatterns = {"/join/*", "/into/*", "/team/*"})
public class AboutServlet extends BaseServlet {

    @EJB
    private AccountService accountService;
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

        LOGIN_AJAX;
    }

    @Override
    boolean processAction(HttpServletRequest request, HttpServletResponse response) throws BadPostActionException, ServletException, IOException, NoSessionException, NotVerifiedException {
        ActionEnum action = (ActionEnum) request.getAttribute(REQUEST_ATTRIBUTE_ACTION_ENUM);
        switch (action) {
            case LOGIN_AJAX:
                return doLoginAjax(request, response);
            default:
                throw new BadPostActionException();
        }
    }

    private enum PageEnum {

        MEMBERSHIP_APPLICATION, JOIN_REG, JOIN_REG_C, QUARTERS, QUARTERS_DETAILS, RECRUIT, COOPERATION,
        IDEA, PATTERN, COURSE, SPEECH, DECLARATION, CONTACT_US,THREE_PARTY_OFFER,OUR_OFFER,OFFER_DETAILS,
        PURCHASE,OVERSEAS,BUILDING, PENSION,
        MATERIAL,INDUSTRIALIZATION,GREEN,BIM,INFO_AREA,
        DIRECTOR,COMMITTEE,BRANCH,EXPERT,STYLE,TEAM_DETAILS;
    }

    @Override
    boolean processPage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, NoSessionException, BadPageException, NoPermException {
        PageEnum page = (PageEnum) request.getAttribute(REQUEST_ATTRIBUTE_PAGE_ENUM);
        switch (page) {
            case MEMBERSHIP_APPLICATION:
            case JOIN_REG:
            case JOIN_REG_C:
            case QUARTERS:
            case RECRUIT:
            case COOPERATION:
            case QUARTERS_DETAILS:
            case IDEA:
            case PATTERN:
            case COURSE:
            case SPEECH:
            case DECLARATION:
            case CONTACT_US:
            case THREE_PARTY_OFFER:
                case OUR_OFFER:
                case OFFER_DETAILS:
                case PURCHASE:
                case OVERSEAS:
                case BUILDING:
                case PENSION:
                 case MATERIAL:case INDUSTRIALIZATION:case GREEN: case BIM:
                 case INFO_AREA:
                 case DIRECTOR:case COMMITTEE:case BRANCH:case EXPERT:case STYLE:
                 case TEAM_DETAILS:
                return KEEP_GOING_WITH_ORIG_URL;
            default:
                throw new BadPageException();
        }
    }

    // ************************************************************************
    // *************** ACTION处理的相关函数，放在这下面
    // ************************************************************************
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

}
