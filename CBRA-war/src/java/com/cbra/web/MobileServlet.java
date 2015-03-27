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
import com.cbra.entity.Offer;
import com.cbra.entity.OrderCbraService;
import com.cbra.entity.OrderCollection;
import com.cbra.entity.Plate;
import com.cbra.entity.PlateInformation;
import com.cbra.entity.SubCompanyAccount;
import com.cbra.entity.UserAccount;
import com.cbra.service.AccountService;
import com.cbra.service.AdminService;
import com.cbra.service.CbraService;
import com.cbra.service.GatewayService;
import com.cbra.service.MobileService;
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
 * 手机接口
 *
 * @author yin.weilong
 */
@WebServlet(name = "MobileServlet", urlPatterns = {"/mobile/*"})
public class MobileServlet extends BaseServlet {

    @EJB
    private MobileService mobileService;
    @EJB
    private OrderService orderService;
    @EJB
    private GatewayService gatewayService;
    @EJB
    private CbraService cbraService;
    @EJB
    private AccountService accountService;
    @EJB
    private AdminService adminService;
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
        PageEnum page = PageEnum.LOGIN;
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

        LOGIN, USER_INFO, INDEX, EVENT_LIST, PARTNERS_LIST, NEWS_LIST, NEWS_INDEX, INFO_INDEX, INFO_LIST, RESOURCE, OFFER, FRONT;

    }

    @Override
    boolean processPage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, NoSessionException, BadPageException, NoPermException {
        PageEnum page = (PageEnum) request.getAttribute(REQUEST_ATTRIBUTE_PAGE_ENUM);
        switch (page) {
            case LOGIN:
                return login(request, response);
            case USER_INFO:
                return userInfo(request, response);
            case INDEX:
                return index(request, response);
            case EVENT_LIST:
                return eventList(request, response);
            case PARTNERS_LIST:
                return partnersList(request, response);
            case NEWS_INDEX:
                return newsIndex(request, response);
            case NEWS_LIST:
                return newsList(request, response);
            case INFO_INDEX:
                return infoIndex(request, response);
            case RESOURCE:
                return loadResource(request, response);
            case OFFER:
                return loadOffer(request, response);
            case FRONT:
                return loadFront(request, response);
            default:
                throw new BadPageException();
        }
    }

    // ************************************************************************
    // *************** PAGE RANDER处理的相关函数，放在这下面
    // ************************************************************************
    /**
     * 登录
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     */
    private boolean login(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Map map = new HashMap();
        map.put("responsecode", 1);
        String account = super.getRequestString(request, "username");
        String passwd = super.getRequestString(request, "password");
        if (account == null || passwd == null) {
            map.put("msg", "参数异常");
            return super.outputObjectAjax(map, response);
        }
        Account user = null;
        try {
            user = mobileService.getAccountForLoginMobile(account, passwd);
        } catch (AccountNotExistException ex) {
            map.put("msg", "帐号不存在");
            return super.outputObjectAjax(map, response);
        }
        if (user != null) {
            map.put("responsecode", 0);
            map.put("msg", null);
            Map subMap = new HashMap();
            subMap.put("logincode", user.getLoginCode());
            if (user instanceof SubCompanyAccount) {
                subMap.put("type", "SUB");
            } else if (user instanceof CompanyAccount) {
                subMap.put("type", "COMPANY");
            } else {
                subMap.put("type", "USER");
            }
            map.put("data", subMap);
            return super.outputObjectAjax(map, response);
        }
        map.put("msg", "密码错误");
        return super.outputObjectAjax(map, response);
    }

    /**
     * 用户信息
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     */
    private boolean userInfo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Map map = new HashMap();
        map.put("responsecode", 1);
        String logincode = super.getRequestString(request, "logincode");
        if (logincode == null) {
            map.put("msg", "参数异常");
            return super.outputObjectAjax(map, response);
        }
        Account user = mobileService.findByLoginCode(logincode);
        if (user == null) {
            map.put("msg", "请重新登录");
            return super.outputObjectAjax(map, response);
        }
        map.put("msg", null);
        map.put("responsecode", 0);
        if (user instanceof SubCompanyAccount) {
//            subMap.put("subCompanyAccountList", accountService.getSubCompanyAccountList(((CompanyAccount) user)));
            map.put("data", ((SubCompanyAccount) user).getCompanyAccount());
            map.put("type", "SUB");
        } else if (user instanceof CompanyAccount) {
//            subMap.put("subCompanyAccountList", accountService.getSubCompanyAccountList(((CompanyAccount) user)));
            map.put("data", user);
            map.put("type", "COMPANY");
        } else {
            map.put("data", user);
            map.put("type", "USER");
        }
        return super.outputObjectAjax(map, response);
    }

    /**
     * 首页
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     */
    private boolean index(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Plate plate = mobileService.findPlateByPage("mobile_event");
        Map<String, Object> searchMap = new HashMap<>();
        Map map = new HashMap();
        searchMap.put("plateId", plate.getId());
        Map submap = new HashMap();
        ResultList<PlateInformation> resultList = adminService.findPlateInformationList(searchMap, 1, 1, true, false);
        if (resultList != null && resultList.size() > 0) {
            PlateInformation pif = resultList.get(0);
            Map scmap = new HashMap();
            scmap.put("url", pif.getPicUrl());
            scmap.put("link", pif.getNavUrl());
            submap.put("ad", scmap);
        } else {
            Map scmap = new HashMap();
            scmap.put("url", null);
            scmap.put("link", null);
            submap.put("ad", scmap);
        }
        map.put("responsecode", 0);
        //获取筑誉活动
        plate = mobileService.findPlateByPage("event");
        searchMap.clear();
        searchMap.put("plateId", plate.getId());
        searchMap.put("mobile", true);
        searchMap.put("baomingzhong", new Date());
        ResultList<FundCollection> list = adminService.findCollectionList(searchMap, 1, 5, true, false);
        if (list.size() < 5) {
            int next = 5 - list.size();
            searchMap.clear();
            searchMap.put("plateId", plate.getId());
            searchMap.put("weikaishi", new Date());
            searchMap.put("mobile", true);
            list.addAll(adminService.findCollectionList(searchMap, 1, next, true, false));
            if (list.size() < 5) {
                int last = 5 - list.size();
                searchMap.clear();
                searchMap.put("plateId", plate.getId());
                searchMap.put("period", new Date());
                searchMap.put("mobile", true);
                list.addAll(adminService.findCollectionList(searchMap, 1, last, true, false));
            }
        }
        for (FundCollection fc : list) {
            fc.setDetailDescHtml(null);
        }
        list.setTotalCount(list.size());
        submap.put("eventList", list);
        searchMap.put("mobile", true);
        //获取合作伙伴活动
        plate = mobileService.findPlateByPage("partners");
        searchMap.clear();
        searchMap.put("plateId", plate.getId());
        searchMap.put("mobile", true);
        ResultList<FundCollection> partnersList = adminService.findCollectionList(searchMap, 1, 5, true, false);
        submap.put("partnersList", partnersList);
        map.put("data", submap);
        return super.outputObjectAjax(map, response);
    }

    private boolean eventList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int type = super.getRequestInteger(request, "type");
        int page = super.getRequestInteger(request, "page");
        int maxcount = super.getRequestInteger(request, "maxcount");
        Map<String, Object> searchMap = new HashMap<>();
        Map map = new HashMap();
        map.put("responsecode", 0);
        //获取筑誉活动
        Plate plate = mobileService.findPlateByPage("event");
        searchMap.put("plateId", plate.getId());
        searchMap.put("mobile", true);
        if (type == 1) {
            searchMap.put("plateId", plate.getId());
            searchMap.put("mobile", true);
            ResultList<FundCollection> list = adminService.findCollectionList(searchMap, page, maxcount, null, true);
            for (FundCollection fc : list) {
                fc.setDetailDescHtml(null);
            }
            map.put("data", list);
        } else {
            if (type == 2) {
                searchMap.put("baomingzhong", new Date());
            } else if (type == 3) {
                searchMap.put("weikaishi", new Date());
            } else if (type == 4) {
                searchMap.put("period", new Date());
            }
            ResultList<FundCollection> list = adminService.findCollectionList(searchMap, page, maxcount, null, true);
            for (FundCollection fc : list) {
                fc.setDetailDescHtml(null);
            }
            map.put("data", list);
        }
        return super.outputObjectAjax(map, response);
    }

    private boolean partnersList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int page = super.getRequestInteger(request, "page");
        int maxcount = super.getRequestInteger(request, "maxcount");
        Map<String, Object> searchMap = new HashMap<>();
        Map map = new HashMap();
        map.put("responsecode", 0);
        //获取筑誉活动
        Plate plate = mobileService.findPlateByPage("partners");
        searchMap.put("plateId", plate.getId());
        searchMap.put("mobile", true);
        ResultList<FundCollection> partnersList = adminService.findCollectionList(searchMap, page, maxcount, null, true);
        map.put("data", partnersList);
        return super.outputObjectAjax(map, response);
    }

    private boolean newsList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int type = super.getRequestInteger(request, "type");
        int page = super.getRequestInteger(request, "page");
        int maxcount = super.getRequestInteger(request, "maxcount");
        Map<String, Object> searchMap = new HashMap<>();
        Map map = new HashMap();
        map.put("responsecode", 0);
        Plate plate = mobileService.findPlateByPage("news_list");
        if (type == 2) {
            plate = mobileService.findPlateByPage("industry_list");
        }
        searchMap.put("plateId", plate.getId());
        ResultList<PlateInformation> newsList = adminService.findPlateInformationList(searchMap, page, maxcount, null, true);
        for (PlateInformation pif : newsList) {
            pif.setPlateInformationContent(null);
        }
        map.put("data", newsList);
        return super.outputObjectAjax(map, response);
    }

    private boolean newsIndex(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Map<String, Object> searchMap = new HashMap<>();
        Map map = new HashMap();
        Map submap = new HashMap();
        map.put("responsecode", 0);
        Plate plate = mobileService.findPlateByPage("news_list");
        searchMap.put("plateId", plate.getId());
        ResultList<PlateInformation> newsList = adminService.findPlateInformationList(searchMap, 1, 3, null, true);
        for (PlateInformation pif : newsList) {
            pif.setPlateInformationContent(null);
        }
        submap.put("newsList", newsList);
        plate = mobileService.findPlateByPage("industry_list");
        searchMap.clear();
        searchMap.put("plateId", plate.getId());
        ResultList<PlateInformation> newsList2 = adminService.findPlateInformationList(searchMap, 1, 3, null, true);
        for (PlateInformation pif : newsList2) {
            pif.setPlateInformationContent(null);
        }
        submap.put("industryList", newsList2);
        map.put("data", submap);
        return super.outputObjectAjax(map, response);
    }

    private boolean infoIndex(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String logincode = super.getRequestString(request, "logincode");
        Map map = new HashMap();
        Map submap = new HashMap();
        submap.put("isCompany", 0);
        if (Tools.isNotBlank(logincode)) {
            Account user = mobileService.findByLoginCode(logincode);
            if (user instanceof CompanyAccount && user.getStatus().equals(AccountStatus.MEMBER)) {
                submap.put("isCompany", 1);
            }
            if (user instanceof SubCompanyAccount) {
                CompanyAccount u = ((SubCompanyAccount) user).getCompanyAccount();
                if (u.getStatus().equals(AccountStatus.MEMBER)) {
                    submap.put("isCompany", 1);
                }
            }
        }
        Map<String, Object> searchMap = new HashMap<>();
        map.put("responsecode", 0);
        Plate plate = mobileService.findPlateByPage("three_party_offer");
        searchMap.put("plateId", plate.getId());
        ResultList<Offer> offerList = adminService.findOfferList(searchMap, 1, 3, null, true);
        for (Offer offer : offerList) {
            offer.setCompetence(null);
            offer.setDescription(null);
            offer.setDuty(null);
        }
        submap.put("offerList", offerList);
        searchMap.clear();
        List<Long> ids = new ArrayList<>();
        ids.add(mobileService.findPlateByPage("material").getId());
        ids.add(mobileService.findPlateByPage("industrialization").getId());
        ids.add(mobileService.findPlateByPage("green").getId());
        ids.add(mobileService.findPlateByPage("bim").getId());
        searchMap.put("ids", ids);
        ResultList<PlateInformation> newsList2 = adminService.findPlateInformationList(searchMap, 1, 5);
        for (PlateInformation pif : newsList2) {
            pif.setPlateInformationContent(null);
        }
        submap.put("frontList", newsList2);
        map.put("data", submap);
        return super.outputObjectAjax(map, response);
    }

    private boolean loadResource(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String logincode = super.getRequestString(request, "logincode");
        Integer type = super.getRequestInteger(request, "type");
        int page = super.getRequestInteger(request, "page");
        int maxcount = super.getRequestInteger(request, "maxcount");
        Map map = new HashMap();
        Map<String, Object> searchMap = new HashMap<>();
        map.put("responsecode", 0);
        Plate plate = null;
        if (type == 1) {
            plate = mobileService.findPlateByPage("purchase");
        } else if (type == 2) {
            plate = mobileService.findPlateByPage("overseas");
        } else if (type == 3) {
            plate = mobileService.findPlateByPage("building");
        } else if (type == 4) {
            plate = mobileService.findPlateByPage("pension");
        }
        searchMap.put("plateId", plate.getId());
        ResultList<PlateInformation> list = adminService.findPlateInformationList(searchMap, page, maxcount, null, true);
        for (PlateInformation pif : list) {
            pif.setPlateInformationContent(null);
        }
        map.put("data", list);
        return super.outputObjectAjax(map, response);
    }

    private boolean loadOffer(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String logincode = super.getRequestString(request, "logincode");
        int page = super.getRequestInteger(request, "page");
        int maxcount = super.getRequestInteger(request, "maxcount");
        Map map = new HashMap();
        Map<String, Object> searchMap = new HashMap<>();
        map.put("responsecode", 0);
        List<Long> ids = new ArrayList<>();
        ids.add(mobileService.findPlateByPage("three_party_offer").getId());
        ids.add(mobileService.findPlateByPage("our_offer").getId());
        searchMap.put("ids", ids);
        ResultList<Offer> list = adminService.findOfferList(searchMap, page, maxcount);
        for (Offer offer : list) {
            offer.setCompetence(null);
            offer.setDescription(null);
            offer.setDuty(null);
        }
        map.put("data", list);
        return super.outputObjectAjax(map, response);
    }

    private boolean loadFront(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String logincode = super.getRequestString(request, "logincode");
        Integer type = super.getRequestInteger(request, "type");
        int page = super.getRequestInteger(request, "page");
        int maxcount = super.getRequestInteger(request, "maxcount");
        Map map = new HashMap();
        Map<String, Object> searchMap = new HashMap<>();
        map.put("responsecode", 0);
        Plate plate = null;
        List<Long> ids = new ArrayList<>();
        if (type == 1) {
            ids.add(mobileService.findPlateByPage("material").getId());
            ids.add(mobileService.findPlateByPage("industrialization").getId());
            ids.add(mobileService.findPlateByPage("green").getId());
            ids.add(mobileService.findPlateByPage("bim").getId());
        } else if (type == 2) {
            ids.add(mobileService.findPlateByPage("material").getId());
        } else if (type == 3) {
            ids.add(mobileService.findPlateByPage("industrialization").getId());
        } else if (type == 4) {
            ids.add(mobileService.findPlateByPage("green").getId());
        } else if (type == 5) {
            ids.add(mobileService.findPlateByPage("bim").getId());
        }
        searchMap.put("ids", ids);
        ResultList<PlateInformation> list = adminService.findPlateInformationList(searchMap, page, maxcount);
        for (PlateInformation pif : list) {
            pif.setPlateInformationContent(null);
            pif.setIntroduction(null);
            pif.setPlate(null);
        }
        map.put("data", list);
        return super.outputObjectAjax(map, response);
    }

}
