/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cbra.web;

import cn.yoopay.support.exception.NotVerifiedException;
import com.cbra.entity.Account;
import com.cbra.entity.CompanyAccount;
import com.cbra.entity.Offer;
import com.cbra.entity.Plate;
import com.cbra.entity.PlateInformation;
import com.cbra.entity.SubCompanyAccount;
import com.cbra.service.AccountService;
import com.cbra.service.AdminService;
import com.cbra.service.CbraService;
import com.cbra.support.NoPermException;
import com.cbra.support.ResultList;
import com.cbra.support.Tools;
import com.cbra.support.enums.AccountStatus;
import com.cbra.support.enums.LanguageType;
import com.cbra.support.enums.MessageTypeEnum;
import com.cbra.support.enums.PlateAuthEnum;
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
import javax.servlet.ServletContext;
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
@WebServlet(name = "AboutServlet", urlPatterns = {"/join/*", "/into/*", "/team/*", "/auth/*"})
public class AboutServlet extends BaseServlet {

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
            default:
                throw new BadPostActionException();
        }
    }

    private enum PageEnum {

        MEMBERSHIP_APPLICATION, JOIN_REG, JOIN_REG_C, QUARTERS, QUARTERS_DETAILS, RECRUIT, COOPERATION,
        IDEA, PATTERN, COURSE, SPEECH, DECLARATION, CONTACT_US, THREE_PARTY_OFFER, OUR_OFFER, OFFER_DETAILS,
        PURCHASE, OVERSEAS, BUILDING, PENSION,
        MATERIAL, INDUSTRIALIZATION, GREEN, BIM, INFO_AREA,
        DIRECTOR, COMMITTEE, BRANCH, EXPERT, STYLE, TEAM_DETAILS,
        DESIGN, CONSTRUCTION, QUALITY, SAFE, QUALITY_AUTH, SAFE_AUTH, DETAILS;
    }

    @Override
    boolean processPage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, NoSessionException, BadPageException, NoPermException {
        PageEnum page = (PageEnum) request.getAttribute(REQUEST_ATTRIBUTE_PAGE_ENUM);
        switch (page) {
            case MEMBERSHIP_APPLICATION:
            case JOIN_REG:
            case JOIN_REG_C:
            case RECRUIT:
            case COOPERATION:
            case IDEA:
            case PATTERN:
            case COURSE:
            case SPEECH:
            case DECLARATION:
            case CONTACT_US:
            case DESIGN:
            case CONSTRUCTION:
            case SAFE:
            case QUALITY_AUTH:
            case SAFE_AUTH:
            case QUALITY:
                return loadPagePlate(request, response);
            case QUARTERS:
            case THREE_PARTY_OFFER:
            case OUR_OFFER:
                return loadPagePlateList(request, response);
            case QUARTERS_DETAILS:
            case OFFER_DETAILS:
                return loadPageOfferInfo(request, response);
            case PURCHASE:
            case OVERSEAS:
            case BUILDING:
            case PENSION:
            case MATERIAL:
            case INDUSTRIALIZATION:
            case GREEN:
            case BIM:
            case DIRECTOR:
            case COMMITTEE:
            case BRANCH:
            case EXPERT:
            case STYLE:
                return loadPagePlateInfoList(request, response);
            case DETAILS:
            case TEAM_DETAILS:
                return loadDetails(request, response);
            case INFO_AREA:
                return loadInfoArea(request, response);
            default:
                throw new BadPageException();
        }
    }

    // ************************************************************************
    // *************** ACTION处理的相关函数，放在这下面
    // ************************************************************************
    // ************************************************************************
    // *************** PAGE RANDER处理的相关函数，放在这下面
    // ************************************************************************
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
        PageEnum page = (PageEnum) request.getAttribute(REQUEST_ATTRIBUTE_PAGE_ENUM);
        ServletContext application = this.getServletContext();
        List<Plate> list = (List<Plate>) application.getAttribute("menuPlates");
        for (Plate plate : list) {
            if (page.name().equalsIgnoreCase(plate.getPage())) {
                request.setAttribute("plate", plate);
                request.setAttribute("plateInformation", adminService.findPlateInformationByPlateId(plate.getId(), super.getLanguageType(request)));
                break;
            }
        }
        return KEEP_GOING_WITH_ORIG_URL;
    }

    /**
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     */
    private boolean loadPagePlateList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        AboutServlet.PageEnum page = (AboutServlet.PageEnum) request.getAttribute(REQUEST_ATTRIBUTE_PAGE_ENUM);
        ServletContext application = this.getServletContext();
        List<Plate> list = (List<Plate>) application.getAttribute("menuPlates");
        Plate pagePlate = null;
        for (Plate plate : list) {
            if (page.name().equalsIgnoreCase(plate.getPage())) {
                pagePlate = plate;
                request.setAttribute("plate", plate);
                request.setAttribute("plateInformation", adminService.findPlateInformationByPlateId(plate.getId(), super.getLanguageType(request)));
                break;
            }
        }
        Integer pageIndex = super.getRequestInteger(request, "page");
        if (pageIndex == null) {
            pageIndex = 1;
        }
        int maxPerPage = 15;
        String searchName = super.getRequestString(request, "searchName");
        Map< String, Object> map = new HashMap<>();
        if (searchName != null) {
            map.put("searchName", searchName);
        }
        map.put("plateId", pagePlate.getId());
        map.put("languageType", super.getLanguageType(request));
        ResultList<Offer> resultList = adminService.findOfferList(map, pageIndex, maxPerPage, null, true);
        request.setAttribute("resultList", resultList);
        request.setAttribute("searchName", searchName);
        return KEEP_GOING_WITH_ORIG_URL;
    }

    /**
     * 加载招聘信息
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     */
    private boolean loadPageOfferInfo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Long id = super.getRequestLong(request, "id");
        Offer offer = adminService.findOfferById(id);
        request.setAttribute("offer", offer);
        PlateAuthEnum auth = cbraService.getPlateAuthEnum(offer, super.getUserFromSessionNoException(request));
        if (PlateAuthEnum.NO_VIEW.equals(auth)) {
            super.forward("/public/no_authorization", request, response);
            return FORWARD_TO_ANOTHER_URL;
        }
        request.setAttribute("plateAuth", auth);
        request.setAttribute("messageList", cbraService.findMessageList(offer, MessageTypeEnum.PUBLISH_FROM_USER, super.getUserFromSessionNoException(request)));
        return KEEP_GOING_WITH_ORIG_URL;
    }

    /**
     * 加载PLATE页面
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     */
    private boolean loadPagePlateInfoList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        AboutServlet.PageEnum page = (AboutServlet.PageEnum) request.getAttribute(REQUEST_ATTRIBUTE_PAGE_ENUM);
        ServletContext application = this.getServletContext();
        List<Plate> list = (List<Plate>) application.getAttribute("menuPlates");
        Plate pagePlate = null;
        for (Plate plate : list) {
            if (page.name().equalsIgnoreCase(plate.getPage())) {
                pagePlate = plate;
                request.setAttribute("plate", plate);
                request.setAttribute("plateInformation", adminService.findPlateInformationByPlateId(plate.getId(), super.getLanguageType(request)));
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
        map.put("languageType", super.getLanguageType(request));
        ResultList<PlateInformation> resultList = adminService.findPlateInformationList(map, pageIndex, maxPerPage, null, true);
        request.setAttribute("resultList", resultList);
        //加载左侧点击高的
        map.put("plateId", pagePlate.getId());
        request.setAttribute("plateInfoHots", cbraService.getPlateInformationList4Hot(pagePlate, 5, super.getLanguageType(request)));
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
        PlateAuthEnum auth = cbraService.getPlateAuthEnum(plateInfo, super.getUserFromSessionNoException(request));
        if (PlateAuthEnum.NO_VIEW.equals(auth)) {
            super.forward("/public/no_authorization", request, response);
            return FORWARD_TO_ANOTHER_URL;
        }
        request.setAttribute("plateAuth", auth);
        request.setAttribute("messageList", cbraService.findMessageList(plateInfo, super.getUserFromSessionNoException(request)));
        return KEEP_GOING_WITH_ORIG_URL;
    }

    /**
     * 加载infoArea
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     */
    private boolean loadInfoArea(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ServletContext application = this.getServletContext();
        List<Plate> list = (List<Plate>) application.getAttribute("menuPlates");
        Plate pagePlate = null;
        List<Long> plateIds = new LinkedList<>();
        for (Plate plate : list) {
            if ("three_party_offer".equalsIgnoreCase(plate.getPage())) {
                pagePlate = plate;
            }
            if ("material".equalsIgnoreCase(plate.getPage())) {
                plateIds.add(plate.getId());
            }
            if ("industrialization".equalsIgnoreCase(plate.getPage())) {
                plateIds.add(plate.getId());
            }
            if ("green".equalsIgnoreCase(plate.getPage())) {
                plateIds.add(plate.getId());
            }
            if ("bim".equalsIgnoreCase(plate.getPage())) {
                plateIds.add(plate.getId());
            }
        }
        Account account = super.getUserFromSessionNoException(request);
        if (account instanceof CompanyAccount && account.getStatus().equals(AccountStatus.MEMBER)) {
            request.setAttribute("isCompany", true);
        }
        if (account instanceof SubCompanyAccount) {
            SubCompanyAccount sub = (SubCompanyAccount) account;
            if (sub.getCompanyAccount().getStatus().equals(AccountStatus.MEMBER)) {
                request.setAttribute("isCompany", true);
            }
        }
        request.setAttribute("offerList", cbraService.findOfferList4Hot(pagePlate, 5, super.getLanguageType(request)));
        request.setAttribute("plateInfoList", cbraService.findPlateInformationList4Hot(plateIds, 5, super.getLanguageType(request)));
        return KEEP_GOING_WITH_ORIG_URL;
    }

}
