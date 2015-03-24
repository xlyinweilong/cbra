/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cbra.web;

import cn.yoopay.support.exception.NotVerifiedException;
import com.cbra.entity.Account;
import com.cbra.entity.CompanyAccount;
import com.cbra.entity.FundCollection;
import com.cbra.entity.Plate;
import com.cbra.entity.PlateInformation;
import com.cbra.entity.SubCompanyAccount;
import com.cbra.entity.UserAccount;
import com.cbra.service.AccountService;
import com.cbra.service.AdminService;
import com.cbra.service.CbraService;
import com.cbra.support.NoPermException;
import com.cbra.support.ResultList;
import com.cbra.support.enums.AccountStatus;
import com.cbra.support.enums.LanguageType;
import com.cbra.support.enums.MessageTypeEnum;
import com.cbra.support.enums.PlateAuthEnum;
import static com.cbra.web.BaseServlet.FORWARD_TO_ANOTHER_URL;
import static com.cbra.web.BaseServlet.KEEP_GOING_WITH_ORIG_URL;
import static com.cbra.web.BaseServlet.REQUEST_ATTRIBUTE_PAGE_ENUM;
import com.cbra.web.support.BadPageException;
import com.cbra.web.support.BadPostActionException;
import com.cbra.web.support.NoSessionException;
import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.ejb.EJB;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.lang.StringUtils;

/**
 * 活动WEB层
 *
 * @author yin.weilong
 */
@WebServlet(name = "EventServlet", urlPatterns = {"/event/*"})
public class EventServlet extends BaseServlet {

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

        NEAR_FUTURE, PERIOD, PARTNERS, EVENT_DETAILS;
    }

    @Override
    boolean processPage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, NoSessionException, BadPageException, NoPermException {
        PageEnum page = (PageEnum) request.getAttribute(REQUEST_ATTRIBUTE_PAGE_ENUM);
        switch (page) {
            case NEAR_FUTURE:
                return loadNearFutre(request, response);
            case PERIOD:
                return loadPeriod(request, response);
            case PARTNERS:
                return loadPariners(request, response);
            case EVENT_DETAILS:
                return loadEventDetails(request, response);
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
    /**
     * 加载近期活动
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     */
    private boolean loadNearFutre(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ServletContext application = this.getServletContext();
        List<Plate> list = (List<Plate>) application.getAttribute("menuPlates");
        Plate platePage = null;
        for (Plate plate : list) {
            if ("event".equalsIgnoreCase(plate.getPage())) {
                platePage = plate;
            }
            if ("partners".equalsIgnoreCase(plate.getPage())) {
                request.setAttribute("hotEventList", cbraService.getFundCollectionList4Web(plate, 10));
            }
        }
        Integer page = super.getRequestInteger(request, "page");
        if (page == null) {
            page = 1;
        }
        Map<String, Object> map = new HashMap<>();
        map.put("plateId", platePage.getId());
        map.put("nearFutre", new Date());
        ResultList<FundCollection> resultList = adminService.findCollectionList(map, page, 15, null, true);

        request.setAttribute("resultList", resultList);
        return KEEP_GOING_WITH_ORIG_URL;
    }

    /**
     * 加载往期活动
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     */
    private boolean loadPeriod(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ServletContext application = this.getServletContext();
        List<Plate> list = (List<Plate>) application.getAttribute("menuPlates");
        Plate platePage = null;
        for (Plate plate : list) {
            if ("event".equalsIgnoreCase(plate.getPage())) {
                platePage = plate;
            }
            if ("partners".equalsIgnoreCase(plate.getPage())) {
                request.setAttribute("hotEventList", cbraService.getFundCollectionList4Web(plate, 10));
            }
        }
        Integer page = super.getRequestInteger(request, "page");
        if (page == null) {
            page = 1;
        }
        Map<String, Object> map = new HashMap<>();
        map.put("plateId", platePage.getId());
        map.put("period", new Date());
        ResultList<FundCollection> resultList = adminService.findCollectionList(map, page, 15, null, true);
        request.setAttribute("resultList", resultList);
        return KEEP_GOING_WITH_ORIG_URL;
    }

    /**
     * 加载合作伙伴的
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     */
    private boolean loadPariners(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ServletContext application = this.getServletContext();
        List<Plate> list = (List<Plate>) application.getAttribute("menuPlates");
        Plate platePage = null;
        for (Plate plate : list) {
            if ("partners".equalsIgnoreCase(plate.getPage())) {
                platePage = plate;
                break;
            }
        }
        Integer page = super.getRequestInteger(request, "page");
        if (page == null) {
            page = 1;
        }
        Map<String, Object> map = new HashMap<>();
        map.put("plateId", platePage.getId());
        ResultList<FundCollection> resultList = adminService.findCollectionList(map, page, 15, null, true);
        request.setAttribute("hotEventList", cbraService.getFundCollectionList4Web(platePage, 10));
        request.setAttribute("resultList", resultList);
        return KEEP_GOING_WITH_ORIG_URL;
    }

    /**
     * 加载具体活动
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     */
    private boolean loadEventDetails(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Long id = super.getRequestLong(request, "id");
        FundCollection fundCollection = adminService.findCollectionById(id);
        //set data
        request.setAttribute("hotEventList", cbraService.getFundCollectionList4Web(fundCollection.getPlate(), 10));
        request.setAttribute("fundCollection", fundCollection);
        PlateAuthEnum auth = cbraService.getPlateAuthEnum(fundCollection, super.getUserFromSessionNoException(request));
        if (PlateAuthEnum.NO_VIEW.equals(auth)) {
            super.forward("/public/no_authorization", request, response);
            return FORWARD_TO_ANOTHER_URL;
        }
        request.setAttribute("plateAuth", auth);
        request.setAttribute("messageList", cbraService.findMessageList(fundCollection, MessageTypeEnum.PUBLISH_FROM_USER, super.getUserFromSessionNoException(request)));
        request.setAttribute("isSignUpEvent", cbraService.getAccountCanSignUpEvent(fundCollection, super.getUserFromSessionNoException(request)));
        return KEEP_GOING_WITH_ORIG_URL;
    }

}
