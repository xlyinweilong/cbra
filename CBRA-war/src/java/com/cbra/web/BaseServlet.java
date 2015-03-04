/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cbra.web;

import cn.yoopay.support.exception.NotVerifiedException;
import com.cbra.Config;
import com.cbra.entity.Account;
import com.cbra.entity.Plate;
import com.cbra.entity.SysUser;
import com.cbra.service.AccountService;
import com.cbra.service.CbraService;
import com.cbra.support.FileUploadItem;
import com.cbra.support.FileUploadObj;
import com.cbra.support.NoPermException;
import com.cbra.support.Tools;
import com.cbra.support.enums.PlateTypeEnum;
import com.cbra.web.support.BadPageException;
import com.cbra.web.support.BadPostActionException;
import com.cbra.web.support.NoSessionException;
import com.cbra.web.support.PostResult;
import flexjson.JSONSerializer;
import java.io.*;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;
import java.math.BigDecimal;
import java.net.URLEncoder;
import java.util.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.ejb.EJB;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FileUtils;
import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.validator.EmailValidator;

/**
 * 基础抽象Servlet
 *
 * @author yin.weilong
 */
public abstract class BaseServlet extends HttpServlet {

    protected static final boolean debug = true;
    protected ResourceBundle bundle;
    //
    public static final String DEFAULT_LANG = "zh";
    //
    public static final boolean KEEP_GOING_WITH_ORIG_URL = true;
    public static final boolean FORWARD_TO_ANOTHER_URL = false;
    public static final boolean REDIRECT_TO_ANOTHER_URL = false;
    //
    public static final String COOKIE_LANG = "COOKIE_LANG";
    public static final String COOKIE_LOGIN_URL_REDIRECT = "COOKIE_LOGIN_URL_REDIRECT";
    public static final String COOKIE_PAYMENT_REF_URL = "COOKIE_PAYMENT_REF_URL";
    public static final String COOKIE_PAYER_EMAIL = "COOKIE_PAYER_EMAIL";
    public static final String COOKIE_TRANSFER_FORM_EMAIL = "COOKIE_TRANSFER_FORM_EMAIL";
    public static final String COOKIE_GATEWAYPAYMENT_ID = "COOKIE_GATEWAYPAYMENT_ID";
    public static final String SESSION_ATTRIBUTE_USER = "user";
    public static final String SESSION_ATTRIBUTE_ADMIN = "admin";
    public static final String SESSION_ATTRIBUTE_LOCALE = "SESSION_ATTRIBUTE_LOCALE";
    public static final String REQUEST_ATTRIBUTE_ACTION_ENUM = "ATTRIBUTE_ACTION_ENUM";
    public static final String REQUEST_ATTRIBUTE_PAGE_ENUM = "ATTRIBUTE_PAGE_ENUM";
    public static final String REQUEST_ATTRIBUTE_PATHINFO_ARRAY = "ATTRIBUTE_PATHINFO_ARRAY";
    public static final String REQUEST_ATTRIBUTE_LOGIN_ALLOWED = "pageViewLoginAllowed";
    public static final String REQUEST_ATTRIBUTE_LOGOUT_ALLOWED = "pageViewLogoutAllowed";
    public static final String REQUEST_ATTRIBUTE_FILEUPLOAD_ITEMS = "items";

    public static boolean startup = false;

    @Override
    public void init() {
        if (!startup) {
            startup = true;
            ServletContext application = this.getServletContext();
            List<PlateTypeEnum> types = new LinkedList<PlateTypeEnum>();
            types.add(PlateTypeEnum.NAVIGATION);
            application.setAttribute("navigationPlates", cbraService.getPlateList4Web(types));
            types.clear();
            types.add(PlateTypeEnum.MENU);
            List<Plate> list = cbraService.getPlateList4Web(types);
            application.setAttribute("menuPlates", list);
            List<Long> newsids = new LinkedList<>();
            List<Long> eventids = new LinkedList<>();
            List<Long> trainids = new LinkedList<>();
            List<Long> consultids = new LinkedList<>();
            for (Plate plate : list) {
                if("news_list".equalsIgnoreCase(plate.getPage())){
                    newsids.add(plate.getId());
                }
                if("industry_list".equalsIgnoreCase(plate.getPage())){
                    newsids.add(plate.getId());
                }
                if("event".equalsIgnoreCase(plate.getPage())){
                    eventids.add(plate.getId());
                }
                if("partners".equalsIgnoreCase(plate.getPage())){
                    eventids.add(plate.getId());
                }
                if("train".equalsIgnoreCase(plate.getPage())){
                    trainids.add(plate.getId());
                }
                if("purchase".equalsIgnoreCase(plate.getPage())){
                    consultids.add(plate.getId());
                }
                if("overseas".equalsIgnoreCase(plate.getPage())){
                    consultids.add(plate.getId());
                }
                if("building".equalsIgnoreCase(plate.getPage())){
                    consultids.add(plate.getId());
                }
                if("pension".equalsIgnoreCase(plate.getPage())){
                    consultids.add(plate.getId());
                }
                if("material".equalsIgnoreCase(plate.getPage())){
                    consultids.add(plate.getId());
                }
                if("industrialization".equalsIgnoreCase(plate.getPage())){
                    consultids.add(plate.getId());
                }
                if("green".equalsIgnoreCase(plate.getPage())){
                    consultids.add(plate.getId());
                }
                if("bim".equalsIgnoreCase(plate.getPage())){
                    consultids.add(plate.getId());
                }
            }
            application.setAttribute("newsids", newsids);
            application.setAttribute("eventids", eventids);
            application.setAttribute("trainids", trainids);
            application.setAttribute("consultids", consultids);
        }
    }

    @EJB
    private AccountService accountService;
    @EJB
    private CbraService cbraService;
    //这里类似Filter中的Chain。任何一部都有可能跳出而不继续这个Chain。

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            //System.out.println("Servlet: Request URI=" + request.getRequestURI() + ", servletPath=" + request.getServletPath() + ", pathInfo=" + request.getPathInfo());
            // UrlReWrite, 同时也解析 PAGE_ENUM 和 PATHINFO_ARRAY，以备后续使用。
            if (!processUrlReWrite(request, response)) {
                return;
            }

            // 解析ACTION_ENUM，以备后续使用。
            String actionString = getActionString(request);
            Object actionEnum = request.getAttribute(REQUEST_ATTRIBUTE_ACTION_ENUM);
            if (actionString != null && actionEnum == null) {
                //只解析第一次request的Action, 不执行forward过来的Action. 一般是在做第一个PostAction处理时出错然后forward到第二个页面的这种情况。
                if (!processActionEnum(actionString, request, response)) {
                    return;
                }
            }

            // LoginAccess, 根据ACTION和PAGE来设置错误信息或forward到登录页面。
            if (!processLoginControl(request, response)) {
                return;
            }
            if (!loginControlForward(request, response)) {
                return;
            }

            //多语言相关处理，需要在正式processAction或者processPage之前选择好语言并初始化语言包，以供后续使用。
            if (!processLocale(request, response)) {
                return;
            }

            // 执行Form提交等动作。但是不要执行forward过来的动作，一般是在做第一个PostAction处理时出错然后forward到第二个页面的这种情况。
            // 正常的form提交，此时，REQUEST_ATTRIBUTE_ACTION_ENUM应该已经在request中setAttribute了，而actionEnum这个变量仍然是null;
            if (actionString != null && actionEnum == null) {
                // doAction, 这时再有NoSessionException或者BadPostActionException等，就真的是异常了。
                if (!processAction(request, response)) {
                    return;
                }
            }

            // 加载页面所需数据。这时再有NoSessionException或者BadPostActionException等，就真的是异常了。
            if (!processPage(request, response)) {
                return;
            }

            // 真正的页面显示就在这这里啦
            randerPage(request, response);

            //这里的异常处理要注意不要用forward，因为那样还会进入某个Servlet里面，有可能发生循环出错的情况。
            //所以，异常处理尽量使用一次性出结果的redirect或include，并且不要用到Servlet管理的url。
            // 比如，jsp页面要用/WEB-INF/等格式。
        } catch (NoPermException | BadPostActionException ex) {
            includeWithError(bundle.getString("GLOBAL_MSG_DATA_ERROR"), "/WEB-INF/public/error_page.jsp", request, response);
        } catch (NotVerifiedException ex) {
            includeWithError(bundle.getString("GLOBAL_MSG_EMAIL_VALID"), "/WEB-INF/public/error_page.jsp", request, response);
        } catch (NoSessionException ex) {
            if (request.getMethod().equalsIgnoreCase("POST")) {
                includeWithError(bundle.getString("GLOBAL_MSG_LOGIN_FIRST"), "/WEB-INF/public/error_page.jsp", request, response);
            } else {
                include("/WEB-INF/account/login.jsp", request, response);
            }
        } catch (BadPageException ex) {
            redirectToFileNotFound(request, response);
        } catch (ServletException ex) {
            includeWithException(ex, request, response);
        } catch (IOException ex) {
            includeWithException(ex, request, response);
        } catch (Exception ex) {
            includeWithException(ex, request, response);
        }
    }

    public abstract boolean processUrlReWrite(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;

    public abstract boolean processLoginControl(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, NoSessionException;

    abstract boolean processActionEnum(String actionString, HttpServletRequest request, HttpServletResponse response) throws BadPostActionException, ServletException, IOException;

    abstract boolean processAction(HttpServletRequest request, HttpServletResponse response) throws BadPostActionException, NotVerifiedException, ServletException, IOException, NoSessionException;

    abstract boolean processPage(HttpServletRequest request, HttpServletResponse response) throws BadPageException, ServletException, IOException, NoSessionException, NoPermException;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public void log(String msg) {
        if (debug) {
            super.log(msg);
        }
    }

    boolean processLocale(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(true);
        Locale locale = (Locale) session.getAttribute(SESSION_ATTRIBUTE_LOCALE);
        // if first request, set locale in sesssion. following requests won't need do this.
        if (locale == null) {
            // try cookies
            String lang = getLanguageFromCookie(request, response);
            if (lang != null) {
                locale = setLanguage(lang, request, response);
                //System.out.println("setLanguage from Cookie=" + locale.getLanguage());
            }

            // set default lang
            if (locale == null) {
                // "locale = null" will cause setLanguage to use the default lang.
                locale = setLanguage(locale, request, response);
            }

            // try browser Accept-Language header
//            if (locale == null) {
//                locale = request.getLocale();
//                locale = setLanguage(locale, request, response);
//                System.out.println("setLanguage from Accept-Language header=" + locale.getLanguage());
//            }
        } else {
            //System.out.println("getLanguage from session=" + locale.getLanguage());
        }
        // load message bundle for selected locale.
        // TODO...should cache these bundles.
        //System.out.println(locale.getLanguage());
        bundle = ResourceBundle.getBundle("message", locale);
        return KEEP_GOING_WITH_ORIG_URL;
    }

    /**
     * 从GOOKIE中获取语言
     *
     * @param request
     * @param response
     * @return
     */
    String getLanguageFromCookie(HttpServletRequest request, HttpServletResponse response) {
        Cookie cookie = getLanguageCookie(request, response);
        if (cookie == null) {
            return null;
        }
        String lang = cookie.getValue();
        return lang;
    }

    /**
     * 获取语言的COOKIE
     *
     * @param request
     * @param response
     * @return
     */
    Cookie getLanguageCookie(HttpServletRequest request, HttpServletResponse response) {
        Cookie[] cookies = request.getCookies();
        for (int i = 0; cookies != null && i < cookies.length; i++) {
            Cookie cookie = cookies[i];
            String name = cookie.getName();
            if (name.equals(COOKIE_LANG)) {
                return cookie;
            }
        }
        return null;
    }

    /**
     * 获取COOKIE
     *
     * @param request
     * @param response
     * @param cname
     * @return
     */
    Cookie getCookie(HttpServletRequest request, HttpServletResponse response, String cname) {
        Cookie[] cookies = request.getCookies();
        for (int i = 0; cookies != null && i < cookies.length; i++) {
            Cookie cookie = cookies[i];
            String name = cookie.getName();
            if (name.equals(cname)) {
                return cookie;
            }
        }
        return null;
    }

    /**
     * 获取COOKIE的值
     *
     * @param request
     * @param response
     * @param cname
     * @return
     */
    String getCookieValue(HttpServletRequest request, HttpServletResponse response, String cname) {
        Cookie[] cookies = request.getCookies();
        for (int i = 0; cookies != null && i < cookies.length; i++) {
            Cookie cookie = cookies[i];
            String name = cookie.getName();
            if (name.equals(cname)) {
                return cookie.getValue();
            }
        }
        return null;
    }

    /**
     * 设置COOKIE
     *
     * @param request
     * @param response
     * @param cname
     * @param cvalue
     */
    void setCookieValue(HttpServletRequest request, HttpServletResponse response, String cname, String cvalue) {
        Cookie cookie = new Cookie(cname, cvalue);
        cookie.setPath("/");
        response.addCookie(cookie);
    }

    /**
     * 删除COOKIE
     *
     * @param request
     * @param response
     * @param cname
     */
    void removeCookie(HttpServletRequest request, HttpServletResponse response, String cname) {
        Cookie cookie = new Cookie(cname, null);
        cookie.setPath("/");
        cookie.setMaxAge(0);
        response.addCookie(cookie);
    }

    /**
     * 保存用户语言
     *
     * @param lang
     * @param request
     * @param response
     * @return
     */
    Locale setLanguage(String lang, HttpServletRequest request, HttpServletResponse response) {
        Locale locale = new Locale(lang);
        return setLanguage(locale, request, response);
    }

    /**
     * 保存用户语言
     *
     * @param locale
     * @param request
     * @param response
     * @return
     */
    Locale setLanguage(Locale locale, HttpServletRequest request, HttpServletResponse response) {
        if (locale == null) {
            locale = new Locale(DEFAULT_LANG);
        }
        //Set session
        HttpSession session = request.getSession(true);
        session.setAttribute(SESSION_ATTRIBUTE_LOCALE, locale);
        //Set cookie
        Cookie cookie = getLanguageCookie(request, response);
        if (cookie == null) {
            cookie = new Cookie(COOKIE_LANG, locale.getLanguage());
            cookie.setPath("/");
        } else {
            cookie.setValue(locale.getLanguage());
            cookie.setPath("/");
        }
        response.addCookie(cookie);
        //Set db
        Account user = getUserFromSessionNoException(request);
        if (user != null && !locale.getLanguage().equalsIgnoreCase("")) {
            user = accountService.setLanguage(user.getId(), locale.getLanguage());
            setSessionUser(request, user);
        }
        return locale;
    }

    /**
     * 从request中获取用户语言
     *
     * @param request
     * @return
     */
    Locale getLanguage(HttpServletRequest request) {
        Locale locale = null;
        HttpSession session = request.getSession(false);
        if (session != null) {
            locale = (Locale) session.getAttribute(SESSION_ATTRIBUTE_LOCALE);
        }
        if (locale == null) {
            locale = new Locale(DEFAULT_LANG);
        }
        return locale;
    }

    /**
     * 登录控制
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     */
    boolean loginControlForward(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Boolean pageViewLoginAllowed = (Boolean) request.getAttribute("pageViewLoginAllowed");
        Boolean pageViewLogoutAllowed = (Boolean) request.getAttribute("pageViewLogoutAllowed");
        String requestURI = request.getRequestURI();
        HttpSession session = request.getSession();
        Object user = session.getAttribute("user");
        boolean userLogin = false;
        if (user != null) {
            userLogin = true;
        }
        if (!userLogin && pageViewLoginAllowed && !pageViewLogoutAllowed) {
            //Access login only page
            String url = null;
            String queryString = request.getQueryString();
            if (StringUtils.isBlank(queryString)) {
                url = requestURI;
            } else {
                url = requestURI + "?" + queryString;
            }
            request.setAttribute("urlUserWantToAccess", url); // 这个url是login之后跳转的页面，缺省是home
            RequestDispatcher requestDispatcher = request.getRequestDispatcher("/account/login");
            requestDispatcher.forward(request, response);
            if (debug) {
                log("Access login only page, forward to login from: " + requestURI);
            }
            return FORWARD_TO_ANOTHER_URL;
        } else if (userLogin && !pageViewLoginAllowed && pageViewLogoutAllowed) {
            response.sendRedirect("/account/overview");
            response.flushBuffer();
            if (debug) {
                log("Access logout only page, redirect to home from: " + requestURI);
            }
            return FORWARD_TO_ANOTHER_URL;
        } else {
            return KEEP_GOING_WITH_ORIG_URL;
        }
    }

    /**
     * 设置只能登录访问
     *
     * @param request
     */
    void setLoginOnly(HttpServletRequest request) {
        request.setAttribute(REQUEST_ATTRIBUTE_LOGIN_ALLOWED, Boolean.TRUE);
        request.setAttribute(REQUEST_ATTRIBUTE_LOGOUT_ALLOWED, Boolean.FALSE);
    }

    /**
     * 设置只能未登录访问
     *
     * @param request
     */
    void setLogoutOnly(HttpServletRequest request) {
        request.setAttribute(REQUEST_ATTRIBUTE_LOGIN_ALLOWED, Boolean.FALSE);
        request.setAttribute(REQUEST_ATTRIBUTE_LOGOUT_ALLOWED, Boolean.TRUE);
    }

    /**
     * 设置未登录和登录都能访问
     *
     * @param request
     */
    void setLoginLogoutBothAllowed(HttpServletRequest request) {
        request.setAttribute(REQUEST_ATTRIBUTE_LOGIN_ALLOWED, Boolean.TRUE);
        request.setAttribute(REQUEST_ATTRIBUTE_LOGOUT_ALLOWED, Boolean.TRUE);
    }

    /**
     * 设置未登录和登录都不能访问
     *
     * @param request
     */
    void setNoPermit(HttpServletRequest request) {
        request.setAttribute(REQUEST_ATTRIBUTE_LOGIN_ALLOWED, Boolean.FALSE);
        request.setAttribute(REQUEST_ATTRIBUTE_LOGOUT_ALLOWED, Boolean.FALSE);
    }

    /**
     * 兼容上传表单获取action
     *
     * @param request
     * @return
     * @throws FileUploadException
     * @throws UnsupportedEncodingException
     */
    String getActionString(HttpServletRequest request) throws FileUploadException, UnsupportedEncodingException {
        //解决是否为文件上传
        boolean isMultipart = ServletFileUpload.isMultipartContent(request);
        if (isMultipart) {
            FileItemFactory factory = new DiskFileItemFactory();
            ServletFileUpload upload = new ServletFileUpload(factory);
            List<FileItem> items = upload.parseRequest(request);
            request.setAttribute(REQUEST_ATTRIBUTE_FILEUPLOAD_ITEMS, items);
            String action = null;
            for (FileItem item : items) {
                if (item.getFieldName().equals("a")) {
                    action = item.getString("UTF-8");
                    break;
                }
            }
            return action == null ? null : action.toUpperCase();
        } else {
            String action = request.getParameter("a");
            if (StringUtils.isEmpty(action)) {
                return null;
            }
            action = action.toUpperCase();
            return action;
        }

    }

    /**
     * 获取真实页面
     *
     * @param request
     * @param response
     * @throws IOException
     * @throws ServletException
     */
    void randerPage(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
//        String requestURI = request.getRequestURI();
//        String contextPath = request.getContextPath();
//        if (!StringUtils.isBlank(contextPath)) {
//            int indexOf = contextPath.length();
//            requestURI = requestURI.substring(indexOf);
//        }
//        if (StringUtils.isBlank(requestURI) || requestURI.equals("/")) {
//            requestURI = "/index";
//        }
        String servletPath = request.getServletPath();
        String pathInfoAt = getPathInfoStringAt(request, 0);
        if (pathInfoAt == null) {
            pathInfoAt = "index";
        }
        String file = "/WEB-INF" + servletPath + "/" + pathInfoAt;

        String url = file + ".jsp";
        String queryString = request.getQueryString();
        if (!StringUtils.isBlank(queryString)) {
            url = file + ".jsp?" + queryString;
        }

        //System.out.println("Randers page: " + url);
        RequestDispatcher requestDispatcher = request.getRequestDispatcher(url);
        requestDispatcher.forward(request, response);
    }

    /**
     * include
     *
     * @param url
     * @param request
     * @param response
     * @throws IOException
     * @throws ServletException
     */
    void include(String url, HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        RequestDispatcher requestDispatcher = request.getRequestDispatcher(url);
        requestDispatcher.include(request, response);
    }

    /**
     * redirect
     *
     * @param url
     * @param request
     * @param response
     * @throws IOException
     * @throws ServletException
     */
    void redirect(String url, HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        response.sendRedirect(url);
        response.flushBuffer();
    }

    /**
     * 重定向到404页面
     *
     * @param request
     * @param response
     * @throws IOException
     */
    void redirectToFileNotFound(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setStatus(404);
        response.sendRedirect("/error404.html");
        response.flushBuffer();
    }

    /**
     * forward
     *
     * @param pageForwardTo
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    void forward(String pageForwardTo, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher requestDispatcher = request.getRequestDispatcher(pageForwardTo);
        requestDispatcher.forward(request, response);
    }

    /**
     * 设置返回结果信息
     *
     * @param postResult
     * @param request
     * @throws ServletException
     * @throws IOException
     */
    void setPostResult(PostResult postResult, HttpServletRequest request) throws ServletException, IOException {
        request.setAttribute("postResult", postResult);
    }

    /**
     * 设置返回的错误结果信息
     *
     * @param error
     * @param request
     * @throws ServletException
     * @throws IOException
     */
    void setErrorResult(String error, HttpServletRequest request) throws ServletException, IOException {
        PostResult postResult = new PostResult(false, error);
        setPostResult(postResult, request);
    }

    /**
     * 设置返回的错误结果信息
     *
     * @param msg
     * @param redirectUrl
     * @param request
     * @throws ServletException
     * @throws IOException
     */
    void setErrorResult(String msg, String redirectUrl, HttpServletRequest request) throws ServletException, IOException {
        PostResult postResult = new PostResult(false, msg, redirectUrl);
        setPostResult(postResult, request);
    }

    /**
     * 设置返回的错误结果信息
     *
     * @param msg
     * @param redirectUrl
     * @param object
     * @param request
     * @throws ServletException
     * @throws IOException
     */
    void setErrorResult(String msg, String redirectUrl, Object object, HttpServletRequest request) throws ServletException, IOException {
        PostResult postResult = new PostResult(false, msg, redirectUrl);
        postResult.setObject(object);
        setPostResult(postResult, request);
    }

    /**
     * 设置返回的成功结果信息
     *
     * @param msg
     * @param request
     * @throws ServletException
     * @throws IOException
     */
    void setSuccessResult(String msg, HttpServletRequest request) throws ServletException, IOException {
        PostResult postResult = new PostResult(true, msg);
        setPostResult(postResult, request);
    }

    /**
     * 设置返回的成功结果信息
     *
     * @param msg
     * @param redirectUrl
     * @param request
     * @throws ServletException
     * @throws IOException
     */
    void setSuccessResult(String msg, String redirectUrl, HttpServletRequest request) throws ServletException, IOException {
        PostResult postResult = new PostResult(true, msg, redirectUrl);
        setPostResult(postResult, request);
    }

    /**
     * 设置返回的成功结果信息
     *
     * @param msg
     * @param redirectUrl
     * @param object
     * @param request
     * @throws ServletException
     * @throws IOException
     */
    void setSuccessResult(String msg, String redirectUrl, Object object, HttpServletRequest request) throws ServletException, IOException {
        PostResult postResult = new PostResult(true, msg, redirectUrl);
        postResult.setObject(object);
        setPostResult(postResult, request);
    }

    /**
     * 包含带有结果
     *
     * @param postResult
     * @param pageForwardTo
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    void includeWithResult(PostResult postResult, String pageForwardTo, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("postResult", postResult);
        include(pageForwardTo, request, response);
    }

    /**
     * 包含带有错误结果信息
     *
     * @param error
     * @param pageForwardTo
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    void includeWithError(String error, String pageForwardTo, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PostResult postResult = new PostResult(false, error);
        includeWithResult(postResult, pageForwardTo, request, response);
    }

    /**
     * 包含带有成功结果信息
     *
     * @param msg
     * @param pageForwardTo
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    void includeWithSuccess(String msg, String pageForwardTo, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PostResult postResult = new PostResult(true, msg);
        includeWithResult(postResult, pageForwardTo, request, response);
    }

    /**
     * 转发带有结果信息
     *
     * @param postResult
     * @param pageForwardTo
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    void forwardWithResult(PostResult postResult, String pageForwardTo, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("postResult", postResult);
        forward(pageForwardTo, request, response);
    }

    /**
     * 转发带有错误结果信息
     *
     * @param error
     * @param pageForwardTo
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    void forwardWithError(String error, String pageForwardTo, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PostResult postResult = new PostResult(false, error);
        forwardWithResult(postResult, pageForwardTo, request, response);
    }

    /**
     * 转发带有成功结果信息
     *
     * @param msg
     * @param pageForwardTo
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    void forwardWithSuccess(String msg, String pageForwardTo, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PostResult postResult = new PostResult(true, msg);
        forwardWithResult(postResult, pageForwardTo, request, response);
    }

    /**
     * 转发带有异常
     *
     * @param t
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    void forwardWithException(Throwable t, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("exceptionMessage", t.toString());
        String stackTrace = Tools.getStackTrace(t);
        request.setAttribute("exceptionStackTrace", stackTrace);
        forward("/public/exception", request, response);
    }

    /**
     * 包含带有异常
     *
     * @param t
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    void includeWithException(Throwable t, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("exceptionMessage", t.toString());
        String stackTrace = Tools.getStackTrace(t);
        request.setAttribute("exceptionStackTrace", stackTrace);
        response.setContentType("text/html;charset=UTF-8");
        include("/WEB-INF/public/exception.jsp", request, response);
    }

    /**
     * 校验空白的参数
     *
     * @param singleErrorMsg
     * @param request
     * @param response
     * @param params
     * @return
     * @throws ServletException
     * @throws IOException
     */
    boolean validateBlankParams(String singleErrorMsg, HttpServletRequest request, HttpServletResponse response, String... params) throws ServletException, IOException {
        return validateBlankParams(singleErrorMsg, null, request, response, params);
    }

    /**
     * 校验空白的参数
     *
     * @param singleErrorMsg
     * @param errorPage
     * @param request
     * @param response
     * @param params
     * @return
     * @throws ServletException
     * @throws IOException
     */
    boolean validateBlankParams(String singleErrorMsg, String errorPage, HttpServletRequest request, HttpServletResponse response, String... params) throws ServletException, IOException {
        PostResult postResult = new PostResult(true, null);
        for (String param : params) {
            if (StringUtils.isBlank(request.getParameter(param))) {
                postResult.addErrorMsg(param, "必填");
            }
        }
        if (!postResult.isSuccess()) {
            postResult.setSingleErrorMsg(singleErrorMsg);
            if (errorPage == null) {
                setPostResult(postResult, request);
            } else {
                forwardWithResult(postResult, errorPage, request, response);
            }
            return false;
        }
        return true;
    }

    /**
     * 从会话取值
     *
     * @param request
     * @param key
     * @return
     */
    Object getSessionValue(HttpServletRequest request, String key) {
        HttpSession session = request.getSession();
        return session.getAttribute(key);
    }

    /**
     * 保存键值对到会话
     *
     * @param request
     * @param key
     * @param value
     */
    void setSessionValue(HttpServletRequest request, String key, Object value) {
        HttpSession session = request.getSession();
        session.setAttribute(key, value);
    }

    /**
     * 从会话中获取用户
     *
     * @param request
     * @return
     * @throws NoSessionException
     */
    Account getUserFromSession(HttpServletRequest request) throws NoSessionException {
        HttpSession session = request.getSession();
        Account user = (Account) session.getAttribute("user");
        if (user == null) {
            throw new NoSessionException("Fatal Error: no session!");
        }
        return user;
    }

    /**
     * 从会话中获取用户
     *
     * @param request
     * @return
     */
    Account getUserFromSessionNoException(HttpServletRequest request) {
        HttpSession session = request.getSession();
        Account user = (Account) session.getAttribute("user");
        return user;
    }

    /**
     * 从会话中获取管理员
     *
     * @param request
     * @return
     */
    SysUser getSysUserFromSessionNoException(HttpServletRequest request) {
        HttpSession session = request.getSession();
        SysUser admin = (SysUser) session.getAttribute("admin");
        return admin;
    }

    /**
     * 从会话和请求中获取用户
     *
     * @param request
     * @return
     */
    Account getUserFromSessionAndRequest(HttpServletRequest request) {
        HttpSession session = request.getSession();
        Account user = (Account) session.getAttribute("user");
        if (user == null) {
            user = (Account) request.getAttribute("user");
        }
        return user;
    }

    /**
     * 获取URL中需要的值
     *
     * @param request
     * @param index
     * @return
     */
    String getPathInfoStringAt(HttpServletRequest request, int index) {
        String[] pathArray = (String[]) request.getAttribute(REQUEST_ATTRIBUTE_PATHINFO_ARRAY);
        String path = null;
        if (pathArray != null && pathArray.length > index) {
            path = pathArray[index];
            if (StringUtils.isBlank(path)) {
                path = null;
            } else {
                path = path.trim();
            }
        }
        return path;
    }

    /**
     * 从请求中获取字符串
     *
     * @param request
     * @param param
     * @return
     * @throws ServletException
     * @throws IOException
     */
    String getRequestString(HttpServletRequest request, String param) throws ServletException, IOException {
        String result = request.getParameter(param);
        if (StringUtils.isBlank(result)) {
            result = null;
        } else {
            result = result.trim();
        }
        return result;
    }

    /**
     * 从请求中获取邮件地址
     *
     * @param request
     * @param param
     * @return
     * @throws ServletException
     * @throws IOException
     */
    String getRequestEmail(HttpServletRequest request, String param) throws ServletException, IOException {
        String str = getRequestString(request, param);
        if (str == null) {
            return null;
        }
        boolean valid = EmailValidator.getInstance().isValid(str);
        if (valid) {
            return str;
        } else {
            return null;
        }
    }

    /**
     * 获取日期
     *
     * @param request
     * @param param
     * @param style
     * @return
     * @throws ServletException
     * @throws IOException
     */
    Date getRequestDate(HttpServletRequest request, String param, String style) throws ServletException, IOException {
        String str = getRequestString(request, param);
        if (str == null) {
            return null;
        }
        return Tools.parseDate(str, style);
    }

    /**
     * 获取日期
     *
     * @param request
     * @param param
     * @return
     * @throws ServletException
     * @throws IOException
     */
    Date getRequestDate(HttpServletRequest request, String param) throws ServletException, IOException {
        String str = getRequestString(request, param);
        if (str == null) {
            return null;
        }
        return getRequestDate(request, param, "yyyy-MM-dd HH:mm:ss");
    }

    /**
     * 字符串转成BigDecimal
     *
     * @param str
     * @return
     */
    BigDecimal getBigDecimal(String str) {
        if (str == null) {
            return null;
        }
        try {
            return new BigDecimal(str);
        } catch (NumberFormatException ex) {
            return null;
        }
    }

    /**
     * 从请求中获取BigDecimal
     *
     * @param request
     * @param param
     * @return
     * @throws ServletException
     * @throws IOException
     */
    BigDecimal getRequestBigDecimal(HttpServletRequest request, String param) throws ServletException, IOException {
        String str = getRequestString(request, param);
        return getBigDecimal(str);
    }

    /**
     * 从url中获取BigDecimal
     *
     * @param request
     * @param index
     * @return
     * @throws ServletException
     * @throws IOException
     */
    BigDecimal getPathInfoBigDecimalAt(HttpServletRequest request, int index) throws ServletException, IOException {
        String str = getPathInfoStringAt(request, index);
        return getBigDecimal(str);
    }

    /**
     * 字符串转int
     *
     * @param str
     * @return
     */
    Integer getInteger(String str) {
        if (str == null) {
            return null;
        }
        try {
            return Integer.valueOf(str);
        } catch (NumberFormatException ex) {
            return null;
        }
    }

    /**
     * 从请求中获取int
     *
     * @param request
     * @param param
     * @return
     * @throws ServletException
     * @throws IOException
     */
    Integer getRequestInteger(HttpServletRequest request, String param) throws ServletException, IOException {
        String str = getRequestString(request, param);
        return getInteger(str);
    }

    /**
     * 字符串转布尔值
     *
     * @param str
     * @return
     */
    Boolean getBoolean(String str) {
        if (str == null) {
            return null;
        }
        return Boolean.valueOf(str);
    }

    /**
     * 从请求中获取布尔值
     *
     * @param request
     * @param param
     * @return
     * @throws ServletException
     * @throws IOException
     */
    Boolean getRequestBoolean(HttpServletRequest request, String param) throws ServletException, IOException {
        String str = getRequestString(request, param);
        return getBoolean(str);
    }

    /**
     * 从请求中获取带有默认值的布尔值
     *
     * @param request
     * @param param
     * @param opt
     * @return
     * @throws ServletException
     * @throws IOException
     */
    Boolean optRequestBoolean(HttpServletRequest request, String param, Boolean opt) throws ServletException, IOException {
        String str = getRequestString(request, param);
        Boolean result = getBoolean(str);
        if (result == null) {
            return opt;
        }
        return result;
    }

    /**
     * 从URL中获取int
     *
     * @param request
     * @param index
     * @return
     * @throws ServletException
     * @throws IOException
     */
    Integer getPathInfoIntegerAt(HttpServletRequest request, int index) throws ServletException, IOException {
        String str = getPathInfoStringAt(request, index);
        return getInteger(str);
    }

    /**
     * 字符串转成long
     *
     * @param str
     * @return
     */
    Long getLong(String str) {
        if (str == null) {
            return null;
        }
        try {
            return Long.valueOf(str);
        } catch (NumberFormatException ex) {
            return null;
        }
    }

    /**
     * 从请求中获取long
     *
     * @param request
     * @param param
     * @return
     * @throws ServletException
     * @throws IOException
     */
    Long getRequestLong(HttpServletRequest request, String param) throws ServletException, IOException {
        String str = getRequestString(request, param);
        return getLong(str);
    }

    /**
     * 从URL中获取long
     *
     * @param request
     * @param index
     * @return
     * @throws ServletException
     * @throws IOException
     */
    Long getPathInfoLongAt(HttpServletRequest request, int index) throws ServletException, IOException {
        String str = getPathInfoStringAt(request, index);
        return getLong(str);
    }

    /**
     * 网站根路径：eg：http://localhost:8080/
     *
     * @param request
     * @return
     */
    String getSiteBaseUrl(HttpServletRequest request) {
        return request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + "/";
    }

    /**
     * 保存用户的SESSION
     *
     * @param request
     * @param userAccount
     */
    void setSessionUser(HttpServletRequest request, Account userAccount) {
        request.getSession().setAttribute(SESSION_ATTRIBUTE_USER, userAccount);
    }

    /**
     * 时间格式化
     *
     * @param request
     */
    void setDateStyle(HttpServletRequest request) {
        Locale locale = getLanguage(request);
        String dateParseStyle = locale.getLanguage().equals("zh") ? "yyyy/MM/dd" : "MM/dd/yyyy";
        request.setAttribute("dateStyle", dateParseStyle);
    }

    /**
     * 输出JSON格式的成功信息
     *
     * @param msg
     * @param redirectUrl
     * @param response
     * @return
     * @throws IOException
     */
    Boolean outputSuccessAjax(String msg, String redirectUrl, HttpServletResponse response) throws IOException {
        return outputAjax(true, msg, redirectUrl, response);
    }

    /**
     * 输出JSON格式的错误信息
     *
     * @param msg
     * @param redirectUrl
     * @param response
     * @return
     * @throws IOException
     */
    Boolean outputErrorAjax(String msg, String redirectUrl, HttpServletResponse response) throws IOException {
        return outputAjax(false, msg, redirectUrl, response);
    }

    /**
     * 输出JSON格式的信息
     *
     * @param successMsg
     * @param msg
     * @param redirectUrl
     * @param response
     * @return
     * @throws IOException
     */
    Boolean outputAjax(boolean successMsg, String msg, String redirectUrl, HttpServletResponse response) throws IOException {
        outputText(response, toJSON(new PostResult(successMsg, msg, redirectUrl)));
        return FORWARD_TO_ANOTHER_URL;
    }

    /**
     * 输出JSON格式
     *
     * @param request
     * @param response
     * @return
     * @throws IOException
     */
    Boolean outputAjax(HttpServletRequest request, HttpServletResponse response) throws IOException {
        outputText(response, toJSON(request));
        return FORWARD_TO_ANOTHER_URL;
    }

    /**
     * 输出错误参数的JSON格式信息
     *
     * @param request
     * @param response
     * @return
     * @throws IOException
     */
    Boolean outputErrorParamJSON(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Map result = new HashMap();
        result.put("success", false);
        result.put("errorMsg", bundle.getString("GLOBAL_MSG_PARAM_INVALID"));
        JSONSerializer serializer = new JSONSerializer();
        String serialize = serializer.serialize(result);
        outputText(response, serialize);
        return FORWARD_TO_ANOTHER_URL;
    }

    /**
     * 输出文本
     *
     * @param response
     * @param text
     * @throws IOException
     */
    void outputText(HttpServletResponse response, String text) throws IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            out.println(text);
        } finally {
            out.close();
        }
    }

    /**
     * 输出JSON或者转发
     *
     * @param request
     * @param response
     * @param isFromAjax
     * @param successMsg
     * @param msg
     * @param url
     * @return
     * @throws IOException
     * @throws ServletException
     */
    Boolean outputAjaxOrForward(HttpServletRequest request, HttpServletResponse response, boolean isFromAjax, boolean successMsg, String msg, String url) throws IOException, ServletException {
        if (isFromAjax) {
            return outputAjax(successMsg, msg, url, response);
        } else {
            if (successMsg) {
                forwardWithSuccess(msg, url, request, response);
            } else {
                forwardWithError(msg, url, request, response);
            }
            return FORWARD_TO_ANOTHER_URL;
        }
    }

    /**
     * 对象JSON化
     *
     * @param o
     * @return
     */
    String toJSON(Object o) {
        JSONSerializer serializer = new JSONSerializer();
        String serialize = serializer.serialize(o);
        return serialize;
    }

    /**
     * 请求JSON化
     *
     * @param request
     * @return
     */
    String toJSON(HttpServletRequest request) {
        PostResult result = (PostResult) request.getAttribute("postResult");
        if (result != null) {
            JSONSerializer serializer = new JSONSerializer();
            String serialize = serializer.serialize(result);
            return serialize;
        }
        return null;
    }

    /**
     * 获取上传文件
     *
     * @param request
     * @param maxFileSizeMB
     * @param fileNamePrefix
     * @param uploadPath
     * @param fileType
     * @return
     * @throws FileUploadException
     */
    public FileUploadObj uploadFile(HttpServletRequest request, double maxFileSizeMB, String fileNamePrefix, String uploadPath, String fileType) throws FileUploadException {
        //上传数据封装到上传对象中
        FileUploadObj fileUploadObj = new FileUploadObj();
        boolean isMultipart = ServletFileUpload.isMultipartContent(request);
        if (!isMultipart) {
            throw new FileUploadException("文件上传失败");
        }
//        FileItemFactory factory = new DiskFileItemFactory();
//        ServletFileUpload upload = new ServletFileUpload(factory);
        List<FileItem> items = (List<FileItem>) request.getAttribute(REQUEST_ATTRIBUTE_FILEUPLOAD_ITEMS);
//        try {
//            items = upload.parseRequest(request);
//        } catch (FileUploadException ex) {
//            throw new FileUploadException("文件上传失败");
//        }
        //循环上传Items
        Iterator<FileItem> iter = items.iterator();
        while (iter.hasNext()) {
            FileItem item = (FileItem) iter.next();
            if (item.isFormField()) {
                //普通表单域(非文件域)
                try {
                    String fieldName = item.getFieldName();
                    if (fieldName != null && fieldName.length() > 0) {
                        if (fileUploadObj.containsKey(fieldName)) {
                            fileUploadObj.putToFormFieldArray(fieldName, item.getString("UTF-8"));
                        } else {
                            fileUploadObj.putFormField(fieldName, item.getString("UTF-8"));
                        }
                    }
                    if (maxFileSizeMB == 0 && fieldName.equals("max_size")) {
                        Double maxSize = Double.valueOf(fileUploadObj.getFormField("max_size"));
                        maxFileSizeMB = maxSize.doubleValue();
                        fileUploadObj.setMaxSizeMB(maxFileSizeMB);
                    }
                } catch (UnsupportedEncodingException ex) {
                    Logger.getLogger(BaseServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
                continue;
            }
            //文件域
            //上传前的文件名
            String fileName = item.getName();
            if (fileName == null || fileName.trim().equals("")) {
                continue;
            }

            //文件大小控制
            Long size = item.getSize();
            if (size > maxFileSizeMB * 1024 * 1024) {
                throw new FileUploadException("文件大小不能超过" + maxFileSizeMB + "MB");
            }

            // 创建临时上传目录
            String targetDir = Config.FILE_UPLOAD_TEMP_DIR;

            if (uploadPath != null) {
                targetDir = uploadPath;
            }
            File uploadedFileDir = new File(targetDir);
            if (!uploadedFileDir.exists()) {
                try {
                    FileUtils.forceMkdir(uploadedFileDir);
                } catch (IOException ex) {
                    throw new FileUploadException("文件上传失败");
                }
            }

            // 上传前文件基名和扩展名
            String baseName = FilenameUtils.getBaseName(fileName);
            String extension = FilenameUtils.getExtension(fileName);

            //设置上传后文件名前缀
            if (fileNamePrefix != null && fileNamePrefix.length() > 0) {
                fileNamePrefix = fileNamePrefix + "_";
            } else {
                fileNamePrefix = "Upload_";
            }
            if (extension == null) {
                extension = "";
            }
            if (extension.length() > 0) {
                extension = "." + extension;
            }
            //校验文件类型
            if (fileType != null) {
                String contentType = item.getContentType();
                boolean flag = false;
                if (fileType.indexOf("image") != -1) {
                    if (contentType.equalsIgnoreCase("image/pjpeg") || contentType.equalsIgnoreCase("image/jpeg") || contentType.equalsIgnoreCase("image/gif") || contentType.equalsIgnoreCase("image/png") || contentType.equalsIgnoreCase("image/x-png")) {
                        flag = true;
                    }
                }
                if (fileType.indexOf("text") != -1) {
                    if (contentType.equalsIgnoreCase("text/plain") || contentType.equalsIgnoreCase("application/msword") || contentType.equalsIgnoreCase("application/vnd.openxmlformats-officedocument.wordprocessingml.document")) {
                        flag = true;
                    }
                }
                if (!flag) {
                    throw new FileUploadException("请上传正确的文件格式");
                }
            }
            //生成上传后文件名
            String tmpName = fileNamePrefix + Tools.md5(fileName + size + System.currentTimeMillis());
            String filename = tmpName + extension;

            // 保存文件
            File savedFile = new File(uploadedFileDir, filename);
            try {
                item.write(savedFile);
                item.delete();
            } catch (Exception ex) {
                throw new FileUploadException("文件上传失败");
            }
            //success upload
            FileUploadItem fileitem = new FileUploadItem();
            fileitem.setOrigFileBaseName(baseName);
            fileitem.setOrigFileExtName(extension);  //包含.
            fileitem.setOrigFileName(baseName + extension);
            fileitem.setFileSize(size);
            fileitem.setUploadFileName(filename);
            fileitem.setUploadFullPath(savedFile.getAbsolutePath());

            String fieldName = item.getFieldName();
            if (fieldName != null && fieldName.length() > 1) {
                fileitem.setFieldName(fieldName);
                fileUploadObj.putFileField(fieldName, fileitem);
            }
            fileUploadObj.addFileUploadItem(fileitem);
        }
        return fileUploadObj;
    }

    /**
     * 输出文件下载
     *
     * @param request
     * @param response
     * @param file
     * @param displayName
     */
    void outputFileForDownload(HttpServletRequest request, HttpServletResponse response, File file, String displayName) {
        FileInputStream is = null;
        ServletOutputStream sos = null;
        try {
            // FILE DATE, MIME TYPE, FILE SIZE
            String userAgent = request.getHeader("user-agent");
            long lastModified = file.lastModified();
            response.setDateHeader("Last-Modified", lastModified);
            response.setContentType("application/x-download");
            String FileDisplayName = "";
            if (userAgent.indexOf("MSIE") == -1) {
                FileDisplayName = new String(displayName.getBytes("UTF-8"), "iso-8859-1");
                response.setHeader("Content-Disposition", "attachment; filename=\"" + FileDisplayName + "\"");//将文件名用引号再引起来防止firefox在下载含空格文件名时空格后丢失
            } else {
                FileDisplayName = URLEncoder.encode(displayName, "UTF-8");
                FileDisplayName = StringUtils.replace(FileDisplayName, "+", "%20");//%20为utf-8中空格的编码                
                response.setHeader("Content-Disposition", "attachment; filename=" + FileDisplayName);
            }

            response.setContentLength((int) file.length());
            // CACHE CONTROL
            long ifModifiedSince = request.getDateHeader("If-Modified-Since");
            if (ifModifiedSince == lastModified) {
                response.setStatus(response.SC_NOT_MODIFIED);
                response.flushBuffer();
                return;
            }
            // FILE DATA
            is = new FileInputStream(file);
            sos = response.getOutputStream();
            byte[] buf = new byte[10240];
            int len;
            while ((len = is.read(buf)) > 0) {
                sos.write(buf, 0, len);
            }
            sos.flush();
            response.flushBuffer();
        } catch (IOException ex) {
        } finally {
            if (is != null) {
                try {
                    is.close();
                } catch (IOException ex1) {
                }
            }
            if (sos != null) {
                try {
                    sos.close();
                } catch (IOException ex1) {
                }
            }
        }
    }

    /**
     * 表单集合传递
     *
     * @param requestDataMap
     * @param prefix
     * @param firstSubPrefix
     * @param secondSubPrefix
     * @param locale
     * @param escapeHTML
     * @return
     * @throws ClassNotFoundException
     * @throws InstantiationException
     * @throws IllegalAccessException
     * @throws NoSuchFieldException
     * @throws NoSuchMethodException
     * @throws IllegalArgumentException
     * @throws InvocationTargetException
     */
    public Map<String, Object> getFormFieldListMap(Map requestDataMap, String prefix, String firstSubPrefix, String secondSubPrefix, Locale locale, boolean escapeHTML) throws ClassNotFoundException, InstantiationException, IllegalAccessException, NoSuchFieldException, NoSuchMethodException, IllegalArgumentException, InvocationTargetException {
        String dateParseStyle = locale.getLanguage().equals("zh") ? "yy/MM/dd" : "MM/dd/yy";

        String className = this.parseObjectName(prefix, true);
        String firstSubClassName = null;
        String secondSubClassName = null;
        if (Tools.isNotBlank(secondSubPrefix)) {
            secondSubClassName = this.parseObjectName(secondSubPrefix, true);
        }
        if (Tools.isNotBlank(firstSubPrefix)) {
            firstSubClassName = this.parseObjectName(firstSubPrefix, true);
        }

        Class c = Class.forName("com.cbra.entity." + className);
        Class firstSubC = null;
        Class secondSubC = null;
        if (null != firstSubClassName) {
            firstSubC = Class.forName("com.cbra.entity." + firstSubClassName);
        }
        if (null != secondSubClassName) {
            secondSubC = Class.forName("com.cbra.entity." + secondSubClassName);
        }
        Map<String, Object> objectContainer = new LinkedHashMap<String, Object>();
        Map<String, Object> firstSubObjectContainer = new LinkedHashMap<String, Object>();
        Map<String, Object> secondSubObjectContainer = new LinkedHashMap<String, Object>();
        for (Map.Entry<String, Object> entry : (Set<Map.Entry>) requestDataMap.entrySet()) {
            String key = entry.getKey();
            if (key.startsWith(prefix)) {
                String[] array = key.split("\\.");
                //Get the entity by the prefix
                String indexKey = this.getIndexStr(array[0]);
                Object entity = objectContainer.get(indexKey);
                if (entity == null) {
                    //Create entity
                    entity = c.newInstance();
                    objectContainer.put(indexKey, entity);
                }
                String attr = this.parseObjectName(array[1], false);
                Field field = c.getDeclaredField(attr);
                if (array.length == 2) {
                    //This entry not have subprefix
                    //Set value for entity
                    Method setterMethod = c.getDeclaredMethod(parseObjectSetMethod(array[1]), new Class[]{field.getType()});
                    setterMethod.setAccessible(true);
                    Method getterMethod = c.getDeclaredMethod(parseObjectGetMethod(array[1]));
                    getterMethod.setAccessible(true);
//                    if (field.getType().isEnum()) {
//                        Class enumClass = field.getType();
//                        setterMethod.invoke(entity, new Object[]{Enum.valueOf(enumClass, Tools.getEscapedHtml((String) entry.getValue()))});
//                    } else {
                    Object rawValue = entry.getValue();
                    String strValue = null;
                    String[] strArrayValue = null;
                    //Check the value real type
                    if (rawValue instanceof String) {
                        strValue = (String) rawValue;
                    } else if (rawValue instanceof String[]) {
                        strArrayValue = (String[]) rawValue;
                    }
                    if (Tools.isNotBlank(strValue) || Tools.isNotEmpty(strArrayValue)) {
                        //Set value only if the request raw value is not null
                        //Field type simple name:such as Long/List/String and so on
                        String fieldTypeSimpleName = field.getType().getSimpleName();
                        Object realValue = null;
                        if (Tools.isNotEmpty(strArrayValue)) {
                            strValue = strArrayValue[0];
                        }
                        if (field.getType().isEnum()) {
                            Class enumClass = field.getType();
                            setterMethod.invoke(entity, new Object[]{Enum.valueOf(enumClass, Tools.getEscapedHtml(strValue))});
                        } else if (fieldTypeSimpleName.equalsIgnoreCase("Long")) {
                            realValue = Long.parseLong(strValue);
                        } else if (fieldTypeSimpleName.equalsIgnoreCase("Integer") || fieldTypeSimpleName.equalsIgnoreCase("int")) {
                            realValue = Integer.parseInt(strValue);
                        } else if (fieldTypeSimpleName.equalsIgnoreCase("Boolean")) {
                            realValue = Boolean.parseBoolean(strValue);
                        } else if (fieldTypeSimpleName.equalsIgnoreCase("String")) {
                            if (escapeHTML) {
                                realValue = Tools.getEscapedHtml(strValue);
                            } else {
                                realValue = strValue;
                            }
                        } else if (fieldTypeSimpleName.equalsIgnoreCase("Date")) {
                            realValue = Tools.parseDate(strValue, dateParseStyle);
                        } else if (fieldTypeSimpleName.equalsIgnoreCase("BigDecimal")) {
                            realValue = new BigDecimal(strValue);
                        } else if (fieldTypeSimpleName.equalsIgnoreCase("List")) {
                            List list = (List) getterMethod.invoke(entity);
                            Type type = field.getGenericType();
                            if (type instanceof ParameterizedType) {
                                ParameterizedType pt = (ParameterizedType) type;
                                Type actualType = pt.getActualTypeArguments()[0];
                                if (actualType.toString().endsWith("java.lang.Long")) {
                                    if (Tools.isNotEmpty(strArrayValue)) {
                                        for (String value : strArrayValue) {
                                            Long l = Long.parseLong(value);
                                            list.add(l);
                                        }
                                    } else {
                                        Long l = Long.parseLong(strValue);
                                        list.add(l);
                                    }
                                } else if (actualType.toString().endsWith("java.lang.Integer")) {
                                    if (Tools.isNotEmpty(strArrayValue)) {
                                        for (String value : strArrayValue) {
                                            Integer i = Integer.parseInt(value);
                                            list.add(i);
                                        }
                                    } else {
                                        Integer i = Integer.parseInt(strValue);
                                        list.add(i);
                                    }
                                } else {
                                    list.addAll(Arrays.asList(strArrayValue));
                                }
                            }
                        }
                        if (null != realValue) {
                            setterMethod.invoke(entity, new Object[]{realValue});
                        }
                    }
                    //}
                }
                if (array.length == 3) {
                    String subAttr = this.parseObjectName(array[2], false);
                    String firstSubObjectName = null;
                    String secondSubObjectName = null;
                    if (Tools.isNotBlank(firstSubPrefix)) {
                        firstSubObjectName = this.parseObjectName(firstSubPrefix, false);
                    }
                    if (Tools.isNotBlank(secondSubPrefix)) {
                        secondSubObjectName = this.parseObjectName(secondSubPrefix, false);
                    }

                    String subIndexKey = indexKey + "-" + array[1];
                    Object subEntity = null;
                    Field subfield = null;
                    Method subSetterMethod = null;
                    Method subGetterMethod = null;
                    if (attr.substring(0, attr.length() - "List".length()).equals(firstSubObjectName)) {
                        //This entry have 1st subPrefix
                        subEntity = firstSubObjectContainer.get(subIndexKey);
                        if (subEntity == null) {
                            //Create entity
                            subEntity = firstSubC.newInstance();
                            firstSubObjectContainer.put(subIndexKey, subEntity);
                        }
                        subfield = firstSubC.getDeclaredField(subAttr);
                        subSetterMethod = firstSubC.getDeclaredMethod(parseObjectSetMethod(array[2]), new Class[]{subfield.getType()});
                        subGetterMethod = firstSubC.getDeclaredMethod(parseObjectGetMethod(array[2]));

                    } else if (attr.substring(0, attr.length() - "List".length()).equals(secondSubObjectName)) {
                        subEntity = secondSubObjectContainer.get(subIndexKey);
                        if (subEntity == null) {
                            //Create entity
                            subEntity = secondSubC.newInstance();
                            secondSubObjectContainer.put(subIndexKey, subEntity);
                        }
                        subfield = secondSubC.getDeclaredField(subAttr);
                        subSetterMethod = secondSubC.getDeclaredMethod(parseObjectSetMethod(array[2]), new Class[]{subfield.getType()});
                        subGetterMethod = secondSubC.getDeclaredMethod(parseObjectGetMethod(array[2]));
                    }

                    if (subfield != null) {
                        subSetterMethod.setAccessible(true);
                        subGetterMethod.setAccessible(true);
//                        if (subfield.getType().isEnum()) {
//                            Class enumClass = subfield.getType();
//                            subSetterMethod.invoke(subEntity, new Object[]{Enum.valueOf(enumClass, Tools.getEscapedHtml((String) entry.getValue()))});
//                        } else {
                        Object rawValue = entry.getValue();
                        String strValue = null;
                        String[] strArrayValue = null;
                        //Check the value real type
                        if (rawValue instanceof String) {
                            strValue = (String) rawValue;
                        } else if (rawValue instanceof String[]) {
                            strArrayValue = (String[]) rawValue;
                        }
                        if (Tools.isNotBlank(strValue) || Tools.isNotEmpty(strArrayValue)) {
                            //Set value only if the request raw value is not null
                            //Field type simple name:such as Long/List/String and so on
                            String fieldTypeSimpleName = subfield.getType().getSimpleName();
                            Object realValue = null;
                            if (Tools.isNotEmpty(strArrayValue)) {
                                strValue = strArrayValue[0];
                            }
                            if (subfield.getType().isEnum()) {
                                Class enumClass = subfield.getType();
                                subSetterMethod.invoke(subEntity, new Object[]{Enum.valueOf(enumClass, Tools.getEscapedHtml(strValue))});
                            } else if (fieldTypeSimpleName.equalsIgnoreCase("Long")) {
                                realValue = Long.parseLong(strValue);
                            } else if (fieldTypeSimpleName.equalsIgnoreCase("Integer") || fieldTypeSimpleName.equalsIgnoreCase("int")) {
                                realValue = Integer.parseInt(strValue);
                            } else if (fieldTypeSimpleName.equalsIgnoreCase("Boolean")) {
                                realValue = Boolean.parseBoolean(strValue);
                            } else if (fieldTypeSimpleName.equalsIgnoreCase("String")) {
                                if (escapeHTML) {
                                    realValue = Tools.getEscapedHtml(strValue);
                                } else {
                                    realValue = strValue;
                                }
                            } else if (fieldTypeSimpleName.equalsIgnoreCase("Date")) {
                                realValue = Tools.parseDate(strValue, dateParseStyle);
                            } else if (fieldTypeSimpleName.equalsIgnoreCase("BigDecimal")) {
                                realValue = new BigDecimal(strValue);
                            } else if (fieldTypeSimpleName.equalsIgnoreCase("List")) {
                                List list = (List) subGetterMethod.invoke(subEntity);
                                Type type = subfield.getGenericType();
                                if (type instanceof ParameterizedType) {
                                    ParameterizedType pt = (ParameterizedType) type;
                                    Type actualType = pt.getActualTypeArguments()[0];
                                    if (strArrayValue != null) {
                                        if (actualType.toString().endsWith("java.lang.Long")) {
                                            for (String value : strArrayValue) {
                                                Long l = Long.parseLong(value);
                                                list.add(l);
                                            }
                                        } else if (actualType.toString().endsWith("java.lang.Integer")) {
                                            for (String value : strArrayValue) {
                                                Integer i = Integer.parseInt(value);
                                                list.add(i);
                                            }
                                        } else {
                                            list.addAll(Arrays.asList(strArrayValue));
                                        }
                                    } else {
                                        list.add(Long.parseLong(strValue));
                                    }
                                }
                            }
                            if (null != realValue) {
                                subSetterMethod.invoke(subEntity, new Object[]{realValue});
                            }
                        }
                        //}
                    }
                    if (subEntity != null) {
                        //Set sub object
                        if (field.getType().getName().equals("java.util.List")) {
                            //Sub Object is a list
                            Method method = c.getMethod(parseObjectGetMethod(array[1]));
                            List subEntityList = (List) method.invoke(entity);
                            if (subEntityList.contains(subEntity)) {
                                subEntityList.remove(subEntity);
                                subEntityList.add(subEntity);
                            } else {
                                subEntityList.add(subEntity);
                            }
                        }
                    }
                }
            }
        }
        return objectContainer;
    }

    /**
     * 获取集合内容的角标
     *
     * @param rawStr
     * @return
     */
    public String getIndexStr(String rawStr) {
        return rawStr.substring(rawStr.indexOf("[") + 1, rawStr.indexOf("]"));
    }

    /**
     * 通过属性访问SET方法
     *
     * @param rawStr
     * @return
     */
    private String parseObjectSetMethod(String rawStr) {
        String result = "set" + this.parseObjectName(rawStr, true);
        return result;
    }

    /**
     * 通过属性访问GET方法
     *
     * @param rawStr
     * @return
     */
    private String parseObjectGetMethod(String rawStr) {
        String result = "get" + this.parseObjectName(rawStr, true);
        return result;
    }

    /**
     *
     * @param rawStr register_question_option_list
     * @return registerQuestionOptionList
     */
    private String parseObjectName(String rawStr, boolean capitalLetter) {
        StringBuilder result = new StringBuilder();
        String[] array = rawStr.split("_");
        if (capitalLetter) {
            array[0] = array[0].substring(0, 1).toUpperCase() + array[0].substring(1);
        }
        result.append(array[0]);
        if (array.length > 1) {
            for (int i = 1; i < array.length; i++) {
                array[i] = array[i].substring(0, 1).toUpperCase() + array[i].substring(1);
                result.append(array[i]);
            }
        }
        return result.toString().replaceAll("\\[.*\\]", "");
    }

    /**
     * 私网IP段检查
     *
     * @param request
     * @return
     * @throws IOException
     * @throws ServletException
     */
    public boolean checkRequestIsPrivateInternetIp(HttpServletRequest request) throws IOException, ServletException {
        String ip = request.getRemoteAddr();
        if (ip.matches("^10\\..*$") || ip.matches("^172\\.(1[6-9]\\.|2[0-9]\\.|3[0-1]\\.).*$") || ip.matches("^192\\.168\\..*$")) {
            return true;
        }
        return false;
    }

    /**
     * HTTPS请求验证
     *
     * @param request
     * @return
     * @throws IOException
     * @throws ServletException
     */
    public boolean checkRequestIsHttps(HttpServletRequest request) throws IOException, ServletException {
        if ("https".equals(request.getScheme()) && this.checkRequestPort(request, 443)) {
            return true;
        }
        return false;
    }

    /**
     * 端口检查
     *
     * @param request
     * @param port
     * @return
     * @throws IOException
     * @throws ServletException
     */
    public boolean checkRequestPort(HttpServletRequest request, int port) throws IOException, ServletException {
        if (request.getServerPort() == port) {
            return true;
        }
        return false;
    }
}
