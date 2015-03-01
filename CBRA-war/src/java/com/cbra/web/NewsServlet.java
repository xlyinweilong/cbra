/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cbra.web;

import cn.yoopay.support.exception.NotVerifiedException;
import com.cbra.entity.Account;
import com.cbra.entity.Plate;
import com.cbra.entity.PlateInformation;
import com.cbra.service.AccountService;
import com.cbra.service.AdminService;
import com.cbra.service.CbraService;
import com.cbra.support.NoPermException;
import com.cbra.support.ResultList;
import com.cbra.support.Tools;
import com.cbra.support.enums.LanguageType;
import com.cbra.support.enums.MessageTypeEnum;
import com.cbra.support.enums.PlateAuthEnum;
import com.cbra.support.exception.AccountNotExistException;
import static com.cbra.web.BaseServlet.KEEP_GOING_WITH_ORIG_URL;
import static com.cbra.web.BaseServlet.REQUEST_ATTRIBUTE_PAGE_ENUM;
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
 * 新闻WEB层
 *
 * @author yin.weilong
 */
@WebServlet(name = "NewServlet", urlPatterns = {"/news/*"})
public class NewsServlet extends BaseServlet {

    @EJB
    private AccountService accountService;
    @EJB
    private AdminService adminService;
    @EJB
    private CbraService cbraService;
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

        NEWS_LIST, INDUSTRY_LIST, DETAILS;
    }

    @Override
    boolean processPage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, NoSessionException, BadPageException, NoPermException {
        PageEnum page = (PageEnum) request.getAttribute(REQUEST_ATTRIBUTE_PAGE_ENUM);
        switch (page) {
            case NEWS_LIST:
            case INDUSTRY_LIST:
                return loadPagePlate(request, response);
            case DETAILS:
                return loadDetails(request, response);
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

    // ************************************************************************
    // *************** PAGE RANDER处理的相关函数，放在这下面
    // ************************************************************************
    //*********************************************************************
    /**
     * 加载PLATE页面
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     */
    private boolean loadPagePlate(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        NewsServlet.PageEnum page = (NewsServlet.PageEnum) request.getAttribute(REQUEST_ATTRIBUTE_PAGE_ENUM);
        ServletContext application = this.getServletContext();
        List<Plate> list = (List<Plate>) application.getAttribute("menuPlates");
        Plate pagePlate = null;
        for (Plate plate : list) {
            if (page.name().equalsIgnoreCase(plate.getPage())) {
                pagePlate = plate;
                request.setAttribute("plate", plate);
                request.setAttribute("plateInformation", adminService.findPlateInformationByPlateId(plate.getId(), LanguageType.ZH));
                break;
            }
        }
        Integer pageIndex = super.getRequestInteger(request, "page");
        if (pageIndex == null) {
            pageIndex = 1;
        }
        int maxPerPage = 5;
        Map< String, Object> map = new HashMap<>();
        map.put("plateId", pagePlate.getId());
        ResultList<PlateInformation> resultList = adminService.findPlateInformationList(map, pageIndex, maxPerPage, null, true);
        request.setAttribute("resultList", resultList);
        //加载左侧点击高的
        map.put("plateId", pagePlate.getId());
        request.setAttribute("plateInfoHots", cbraService.getPlateInformationList4Hot(pagePlate, 5));
        return KEEP_GOING_WITH_ORIG_URL;
    }

    /**
     * 加载详细
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     */
    private boolean loadDetails(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Long id = super.getRequestLong(request, "id");
        PlateInformation plateInfo = adminService.findPlateInformationByIdFetchContent(id);
        //异步增加数量
        cbraService.addPlateVisitCount(id);
        //因为异步运算返回的结果慢，这里做数据修正
        plateInfo.setVisitCount(plateInfo.getVisitCount() + 1L);
        //set data
        request.setAttribute("plateInfo", plateInfo);
        request.setAttribute("plateInfoHots", cbraService.getPlateInformationList4Hot(plateInfo.getPlate(), 5));
        PlateAuthEnum auth = cbraService.getPlateAuthEnum(plateInfo.getPlate(), super.getUserFromSessionNoException(request));
        if(PlateAuthEnum.NO_VIEW.equals(auth)){
            super.forward("/public/no_authorization", request, response);
            return FORWARD_TO_ANOTHER_URL;
        }
        request.setAttribute("plateAuth", auth);
        request.setAttribute("messageList", cbraService.findMessageList(plateInfo, super.getUserFromSessionNoException(request)));
        return KEEP_GOING_WITH_ORIG_URL;
    }
}
