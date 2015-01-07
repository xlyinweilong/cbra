<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:if test="${empty bundle}">
    <fmt:setLocale value="${SESSION_ATTRIBUTE_LOCALE}" scope="session" />
    <fmt:setBundle basename="message" scope="session" var="bundle"/>
</c:if>
<%-- 设置语言要在输出任何response之前 --%>

<%-- 
    Document   : header_login
    Created on : Mar 31, 2011, 6:03:33 PM
    Author     : HUXIAOFENG
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>  
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>
            <c:choose>
                <c:when test="${empty param.PAGE_HEADER_TITLE}">
                    <fmt:message key="GLOBAL_HEADER_TITLE" bundle="${bundle}"/>
                </c:when>
                <c:otherwise>
                    ${param.PAGE_HEADER_TITLE}
                </c:otherwise>
            </c:choose>
        </title> 
        <meta name="keywords" content="Yoopay Event China Management Registration Payment Eventbrite Amiando Paypal Wepay China UnionPay Alipay 活动 会议 发布 推广 票务 报名 收款 银联 支付宝 网银 国际 信用卡"/> 
        <meta name="description" content="友付 是会议及活动的线上报名、推广、票务、收款一站式平台。20,000多个会议及活动，在使用友付，包括大型国内及国际行业会议会展、企业内部培训、经销商、供应商会议，及各种社交、聚会、文体、培训、演出活动。Yoopay is China's first event online management platform for event publishing, promotion, registration, and ticketing. Event organizers can also collect payments online in advance easily with dual currencies (RMB/USD) and dual languages (Chinese/English) via China Union Pay, Alipay, Visa, Mastercard, and Paypal. More than 20,000 domestic and international events, including conferences, exihibitions, forums, corporate and social events are using Yoopay for their events in China."/> 
        <link rel="shortcut icon" href="/favicon.ico" /> 
        <%-- 在正式DEPLOY时，所有CSS和JAVASCRIPT文件，都需要设置BROWSWER SIDE CACHE，并且在登录前各页面做预加载。 --%>
        <link href="/css/jquery-ui-1.9.1.custom.min.css" rel="stylesheet" type="text/css"/>	
        <script type="text/javascript" src="/scripts/jquery-1.8.2.min.js"></script>
        <script type="text/javascript" src="/scripts/jquery-ui-1.9.1.custom.min.js"></script>
        <!--[if IE]><script src="/scripts/excanvas.compiled.js" type="text/javascript"></script><![endif]-->
        <script type="text/javascript" src="/scripts/yoopay.js"></script>
    </head>
    <body>
        <c:choose>
            <c:when test="${empty isIndexUrl}">
                <div class="container" >
            </c:when>
            <c:otherwise>
                <div class="container Indexbg" >
            </c:otherwise>
        </c:choose>
        <c:choose>
            <c:when test="${not empty eventPaymentPage || not empty apiPaymentPage}">
                <%@include file="/WEB-INF/public/z_event_header.jsp" %>
            </c:when>
            <c:otherwise>
                <c:choose>
                    <%-- 登录后主餐单 --%>
                    <c:when test="${sessionScope.user != null && pageViewLoginAllowed}">
                        <div class="head">
                            <div class="head_inner">
                                <div class="logo" onClick="document.location.href='/account/overview'" style="cursor: pointer"></div>
                                <div class="after_login">
                                    <div class="company_login">
                                        <div class="FloatLeft">
                                            <c:choose>
                                                <c:when test="${user.accountType=='COMPANY'}"><strong>${user.company}</strong></c:when>
                                                <c:otherwise>
                                                    <strong> ${user.name}</strong>&nbsp;&nbsp;<a href="javascript:SignupCompanyAccountTipDialog.open();"><fmt:message key="ACCOUNT_OVERVIEW_LABEL_注册公司账户" bundle="${bundle}"/></a>
                                                </c:otherwise>
                                            </c:choose>
                                            &nbsp;&nbsp;
                                            <c:choose>
                                                <c:when test="${USER_YPSERVICE_TYPE == 'STANDARD'}"><strong><fmt:message key="ACCOUNT_OVERVIEW_LABEL_标准版" bundle="${bundle}" /></strong>&nbsp;
                                                    <a href="/ypservice/list"><fmt:message key="ACCOUNT_OVERVIEW_LABEL_升级" bundle="${bundle}"/></a>
                                                </c:when>
                                                <c:when test="${USER_YPSERVICE_TYPE == 'PROFESSIONAL'}"><strong><fmt:message key="ACCOUNT_OVERVIEW_LABEL_专业版" bundle="${bundle}" /></strong></c:when>
                                                <c:otherwise><strong><fmt:message key="ACCOUNT_OVERVIEW_LABEL_普通版" bundle="${bundle}" /></strong>&nbsp;
                                                    <a href="/ypservice/list"><fmt:message key="ACCOUNT_OVERVIEW_LABEL_升级" bundle="${bundle}"/></a>
                                                </c:otherwise>
                                            </c:choose>
                                            &nbsp;&nbsp;
                                            <%--显示友付链接--%>
                                            <strong><fmt:message key="COLLECT_LINK_付款链接" bundle="${bundle}"/></strong>&nbsp;&nbsp;
                                            <c:choose>                            
                                                <c:when test="${user.accountType=='USER'}">
                                                    <span style="float : none" id="header_yoopay_link"><a href="https://yoopay.cn/p/${user.ypLinkId}">https://yoopay.cn/p/${user.ypLinkId}</a></span>
                                                    <div class="Lboxcontent Padding15" style="display:none">
                                                        <p class="text16 ColorBlue MarginR10 bold" id="header_yoopay_link_title"><fmt:message key='ACCOUNT_OVERVIEW_TEXT_您的个人友付链接' bundle='${bundle}'/></p><p class="text12" id="header_yoopay_link_contents"><fmt:message key='ACCOUNT_OVERVIEW_TEXT_即可向您付款' bundle='${bundle}'/></p> 
                                                    </div>
                                                </c:when>
                                                <c:otherwise>
                                                    <span style="float : none" id="header_yoopay_link"><a href="https://yoopay.cn/o/${user.ypLinkId}">https://yoopay.cn/o/${user.ypLinkId}</a></span>
                                                    <div class="Lboxcontent Padding15" style="display:none">
                                                        <p class="text16 ColorBlue MarginR10 bold" id="header_yoopay_link_title"><fmt:message key='ACCOUNT_OVERVIEW_TEXT_您的公司友付链接' bundle='${bundle}'/></p><p class="text12" id="header_yoopay_link_contents"><fmt:message key='ACCOUNT_OVERVIEW_TEXT_即可向您公司付款' bundle='${bundle}'/></p> 
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                        <c:if test="${empty apiPaymentPage}">
                                            <div class="FloatRight ColorGreen"> &nbsp;&nbsp;<a href="javascript:language.doSetChinese()">中文</a> | <a href="javascript:language.doSetEnglish()">English</a></div>        
                                        </c:if>
                                        <div class="clear"></div>
                                    </div>
                                    <span class="account">
                                        <span><fmt:message key="GLOBAL_HEADER_LABEL_BALANCE_账户余额" bundle="${bundle}"/>:</span>
                                        <%--余额--%>
                                        <span class="ColorBlue"><a href="/transaction"><fmt:formatNumber value="${user.totalBalance}" type="currency"  pattern="￥#,##0.##"/></a></span>
                                        <%--
                                        <!--充值余额 -->
                                        <c:if test="${user.addFundBalance > 0}"><span>&nbsp;&nbsp;<fmt:message key="GLOBAL_HEADER_LABEL_BALANCE_充值余额" bundle="${bundle}"/>:</span><span class="ColorBlue"><a href="/transaction"><fmt:formatNumber value="${user.addFundBalance}" type="currency"  pattern="￥#,##0.##"/></a></span></c:if>--%>

                                        <div class="clear"></div></span>
                                    <span class="tel"><fmt:message key="GLOBAL_HEADER_LABEL_PHONE" bundle="${bundle}"/><em>400.0800.620</em>　　<fmt:message key="GLOBAL_HEADER_LABEL_EMAIL" bundle="${bundle}"/><em>service@yoopay.cn</em><em class="exit"><a href="#" title=""></a><a href="/public/about"><fmt:message key="GLOBAL_HEADER_LINK_HELP" bundle="${bundle}"/></a> | <a href="/account/logout"><fmt:message key="GLOBAL_HEADER_LINK_LOGOUT" bundle="${bundle}"/></a></em></span>
                                    <div class="clear"></div>
                                </div>
                                <div class="clear"></div>
                            </div>
                        </div>
                        <div class="nav">
                            <%--一级菜单--%>
                            <ul id="nbaglobal" class="<fmt:message key="GLOBAL_MENU_菜单样式" bundle="${bundle}"/>" >
                                <li  <c:if test="${mainMenuSelection eq 'ACCOUNT'}">class="nowpage"</c:if>>
                                    <a  href="/account/overview"><fmt:message key="GLOBAL_MENU_MAIN_ACCOUNT" bundle="${bundle}"/></a>
                                </li>
                                <li  <c:if test="${mainMenuSelection eq 'FUNDCOLLECT_EVENT'}">class="nowpage"</c:if>>
                                    <a  href="/collect/create/event"><fmt:message key="GLOBAL_MENU_MAIN_活动收款" bundle="${bundle}"/></a>
                                </li>

                                <li  <c:if test="${mainMenuSelection eq 'FUNDCOLLECT_SERVICE'}">class="nowpage"</c:if>>
                                    <a  href="/collect/create/service"><fmt:message key="GLOBAL_MENU_MAIN_服务收款" bundle="${bundle}"/></a>
                                </li>
                                <li  <c:if test="${mainMenuSelection eq 'FUNDCOLLECT_PRODUCT'}">class="nowpage"</c:if>>
                                    <a  href="/collect/create/product"><fmt:message key="GLOBAL_MENU_MAIN_产品收款" bundle="${bundle}"/></a>
                                </li>
                                <li  <c:if test="${mainMenuSelection eq 'FUNDCOLLECT_MEMBER'}">class="nowpage"</c:if>>
                                    <a  href="/collect/create/member"><fmt:message key="GLOBAL_MENU_MAIN_收会员费" bundle="${bundle}"/></a>
                                </li>
                                <li  <c:if test="${mainMenuSelection eq 'YOOPAY_API'}">class="nowpage"</c:if>>
                                    <a  href="/ypservice/api"><fmt:message key="GLOBAL_MENU_MAIN_友付API" bundle="${bundle}"/></a>
                                </li>
                                <li  class="<c:if test="${mainMenuSelection eq 'TRANSACTION'}"> nowpage</c:if>" ><a  href="/transaction"><fmt:message key="GLOBAL_MENU_MAIN_HISTORY" bundle="${bundle}"/></a></li>
                                <div class="clear"></div>
                            </ul>
                        </div>
                        <div class="sub_nav">
                            <div class="sub_nav_inner">
                                <%--二级菜单--%>
                                <c:if test="${mainMenuSelection eq 'ACCOUNT'}">
                                    <span <c:if test="${subMenuSelection eq 'ACCOUNT_OVERVIEW'}">class="sub_nav_now"</c:if>><a href="/account/overview" title=""><fmt:message key="GLOBAL_MENU_ACCOUNT_OVERVIEW" bundle="${bundle}"/></a></span>

                                    <span>|</span>
                                    <span <c:if test="${subMenuSelection eq 'ACCOUNT_REG_INFO'}">class="sub_nav_now"</c:if>><a href="/account/reginfo" title=""><fmt:message key="GLOBAL_MENU_ACCOUNT_REGINFO" bundle="${bundle}"/></a></span>
                                    <span>|</span>
                                    <span <c:if test="${subMenuSelection eq 'ACCOUNT_MODIFY_PASSWORD'}">class="sub_nav_now"</c:if>><a href="/account/modify_passwd" title=""><fmt:message key="GLOBAL_MENU_ACCOUNT_PASSWD" bundle="${bundle}"/></a></span>
                                    <span>|</span>
                                    <span <c:if test="${subMenuSelection eq 'ACCOUNT_SEAL'}">class="sub_nav_now"</c:if>><a href="/account/seal" title=""><fmt:message key="GLOBAL_MENU_ACCOUNT_SEAL" bundle="${bundle}"/></a></span>
                                    <span>|</span>
                                    <span <c:if test="${subMenuSelection eq 'YOOPAY_SERVICE'}">class="sub_nav_now"</c:if>><a href="/ypservice/list" title=""><fmt:message key="GLOBAL_MENU_MAIN_友付服务" bundle="${bundle}"/></a></span>
                                    <span>|</span>
                                    <span <c:if test="${subMenuSelection eq 'FUNDWITHDRAW'}">class="sub_nav_now"</c:if>><a href="/withdraw/create" title=""><fmt:message key="GLOBAL_MENU_MAIN_WITHDRAW" bundle="${bundle}"/></a></span>
                                    <span>|</span>
                                    <span <c:if test="${subMenuSelection eq 'ADDFUND'}">class="sub_nav_now"</c:if>><a href="/addfund/create" title=""><fmt:message key="GLOBAL_MENU_MAIN_充值" bundle="${bundle}"/></a></span>
                                    <span>|</span>
                                    <span <c:if test="${subMenuSelection eq 'TICKET'}">class="sub_nav_now"</c:if>><a href="/account/ticket" title=""><fmt:message key="ACCOUNT_OVERVIEW_我的门票" bundle="${bundle}"/></a></span>

                                </c:if>
                                <c:if test="${mainMenuSelection eq 'FUNDCOLLECT_EVENT'}">
                                    <span style="padding-left:100px" <c:if test="${subMenuSelection eq 'FUNDCOLLECT_EVENT_CREATE'}">class="sub_nav_now"</c:if>><a href="/collect/create/event" title=""><fmt:message key="COLLECT_SUB_MENU_EVENT_CREATE" bundle="${bundle}"/></a></span>
                                    <span>|</span>
                                    <span <c:if test="${subMenuSelection eq 'FUNDCOLLECT_EVENT_LIST'}">class="sub_nav_now"</c:if>><a href="/collect/list/event" title=""><fmt:message key="COLLECT_SUB_MENU_EVENT_COLLECT_LIST" bundle="${bundle}"/></a></span>
                                    <span>|</span>
                                    <span <c:if test="${subMenuSelection eq 'FUNDCOLLECT_EVENT_TEMPLATE_LIST'}">class="sub_nav_now"</c:if>><a href="/collect/template_list/event" title=""><fmt:message key="COLLECT_SUB_MENU_EVENT_COLLECT_TEMPLATE_LIST" bundle="${bundle}"/></a></span>
                                    <span>|</span>
                                    <span <c:if test="${subMenuSelection eq 'FUNDCOLLECT_EVENT_CALENDAR'}">class="sub_nav_now"</c:if>><a href="/calendar/widget" title=""><fmt:message key="COLLECT_SUB_MENU_EVENT_COLLECT_CALENDAR" bundle="${bundle}"/></a></span>
                                </c:if>
                                <c:if test="${mainMenuSelection eq 'FUNDCOLLECT_DONATION'}">
                                    <span style="padding-left:590px" <c:if test="${subMenuSelection eq 'FUNDCOLLECT_DONATION_CREATE'}">class="sub_nav_now"</c:if>><a href="/collect/create/donation" title=""><fmt:message key="COLLECT_SUB_MENU_DONATION_CREATE" bundle="${bundle}"/></a></span>
                                    <span>|</span>
                                    <span <c:if test="${subMenuSelection eq 'FUNDCOLLECT_DONATION_LIST'}">class="sub_nav_now"</c:if>><a href="/collect/list/donation" title=""><fmt:message key="COLLECT_SUB_MENU_DONATION_COLLECT_LIST" bundle="${bundle}"/></a></span>
                                </c:if>
                                <c:if test="${mainMenuSelection eq 'FUNDCOLLECT_SERVICE'}">
                                    <span style="padding-left:270px" <c:if test="${subMenuSelection eq 'FUNDCOLLECT_SERVICE_CREATE'}">class="sub_nav_now"</c:if>><a href="/collect/create/service" title=""><fmt:message key="COLLECT_SUB_MENU_SERVICE_CREATE" bundle="${bundle}"/></a></span>
                                    <span>|</span>
                                    <span <c:if test="${subMenuSelection eq 'FUNDCOLLECT_SERVICE_LIST'}">class="sub_nav_now"</c:if>><a href="/collect/list/service" title=""><fmt:message key="COLLECT_SUB_MENU_SERVICE_COLLECT_LIST" bundle="${bundle}"/></a></span>
                                </c:if>
                                <c:if test="${mainMenuSelection eq 'FUNDCOLLECT_PRODUCT'}">
                                    <span style="padding-left:420px" <c:if test="${subMenuSelection eq 'FUNDCOLLECT_PRODUCT_CREATE'}">class="sub_nav_now"</c:if>><a href="/collect/create/product" title=""><fmt:message key="COLLECT_SUB_MENU_PRODUCT_CREATE" bundle="${bundle}"/></a></span>
                                    <span>|</span>
                                    <span <c:if test="${subMenuSelection eq 'FUNDCOLLECT_PRODUCT_LIST'}">class="sub_nav_now"</c:if>><a href="/collect/list/product" title=""><fmt:message key="COLLECT_SUB_MENU_PRODUCT_COLLECT_LIST" bundle="${bundle}"/></a></span>
                                </c:if>
                                <c:if test="${mainMenuSelection eq 'FUNDCOLLECT_MEMBER'}">
                                    <span style="padding-left:520px" <c:if test="${subMenuSelection eq 'FUNDCOLLECT_MEMBER_CREATE'}">class="sub_nav_now"</c:if>><a href="/collect/create/member" title=""><fmt:message key="COLLECT_SUB_MENU_MEMBER_CREATE" bundle="${bundle}"/></a></span>
                                    <span>|</span>
                                    <span <c:if test="${subMenuSelection eq 'FUNDCOLLECT_MEMBER_LIST'}">class="sub_nav_now"</c:if>><a href="/collect/list/member" title=""><fmt:message key="COLLECT_SUB_MENU_MEMBER_COLLECT_LIST" bundle="${bundle}"/></a></span>
                                </c:if>
                                <c:if test="${mainMenuSelection eq 'YOOPAY_API'}">
                                    <c:if test="${sessionScope.userServiceStatus != null && userServiceStatus.isApiEnabled()}">
                                        <span style="padding-left:670px" <c:if test="${subMenuSelection eq 'YOOPAY_SERVICE_API'}">class="sub_nav_now"</c:if>><a href="/ypservice/api" title=""><fmt:message key="GLOBAL_MENU_MAIN_友付API" bundle="${bundle}"/></a></span>
                                        <span>|</span>
                                        <span <c:if test="${subMenuSelection eq 'YOOPAY_SERVICE_API_INVOICE_LIST'}">class="sub_nav_now"</c:if>><a href="/ypservice/api_invoice_list" title=""><fmt:message key="GLOBAL_MENU_MAIN_友付API发票列表" bundle="${bundle}"/></a></span>
                                    </c:if>
                                </c:if>
                                <c:if test="${mainMenuSelection eq 'TRANSACTION'}">
                                    <span style="padding-left:780px" <c:if test="${subMenuSelection eq 'TRANSACTION_LIST'}">class="sub_nav_now"</c:if>><a href="/transaction/list" title=""><fmt:message key="GLOBAL_MENU_收款付款" bundle="${bundle}"/></a></span>
                                    <c:if test="${user.isVolumeMenuShow()}">
                                        <span>|</span>
                                        <span <c:if test="${subMenuSelection eq 'TRANSACTION_VOLUME_LIST'}">class="sub_nav_now"</c:if>><a href="/transaction/list_volume" title=""><fmt:message key="GLOBAL_MENU_套餐流量" bundle="${bundle}"/></a></span>
                                    </c:if>    
                                </c:if>
                            </div>
                        </div>
                        <div class="home_content"> 
                    </c:when>
                    <%-- 未登录时的主菜单 --%>
                    <c:otherwise>
                        <div class="head">
                            <div class="head_inner">
                                <div class="logo" onClick="document.location.href='/public/index'" style="cursor: pointer"></div>
                                <div class="service">
                                    <div class="company_login">

                                        <div class="FloatLeft" style="font-size: 15px; font-weight: bold">
                                            <font style=" margin-left: 20px"><%--已售票款额：--%>
                                                <%--
                                                <c:if test="${not empty IS_SHOW_SYSTEM_STATISTIC_NUMBERS}">
                                                    %--<span><%=Config.SYSTEM_NEWS_UPDATE_HTML%></span>--%
                                                    <span><fmt:message key="GLOBAL_HEADER_LABEL_已售票款额" bundle="${bundle}"/>￥
                                                        <fmt:formatNumber value="${pageScope.newSysNumbers}" pattern="#,#00"/>&nbsp;&nbsp;&nbsp;&nbsp;
                                                    </span>
                                                </c:if>
                                                --%>
                                                <c:if test="${empty IS_SHOW_SYSTEM_STATISTIC_NUMBERS}">
                                                    <%--<span><%=Config.SYSTEM_STATISTIC_NUMBERS_HTML%></span>--%>
                                                    <span><fmt:message key="GLOBAL_HEADER_LABEL_已售票款额" bundle="${bundle}"/>￥
                                                        <fmt:formatNumber value="${pageScope.sysNumbers}" pattern="#,#00"/>&nbsp;&nbsp;&nbsp;&nbsp;
                                                    </span>
                                                </c:if>
                                            </font><%--￥8,857,097--%>
                                            <font style=" margin-left: 20px"><%--已售门票：--%>
                                                <%--
                                                <c:if test="${not empty IS_SHOW_SYSTEM_STATISTIC_NUMBERS}">
                                                    <span>
                                                        <fmt:message key="GLOBAL_HEADER_LABEL_已售门票" bundle="${bundle}"/>
                                                        <fmt:formatNumber value="${pageScope.newTotalTicket}" pattern="#,#00"/>
                                                        <fmt:message key="GLOBAL_HEADER_LABEL_张" bundle="${bundle}"/>
                                                    </span>
                                                </c:if>
                                                --%>
                                                <c:if test="${empty IS_SHOW_SYSTEM_STATISTIC_NUMBERS}">
                                                    <span>
                                                        <fmt:message key="GLOBAL_HEADER_LABEL_已售门票" bundle="${bundle}"/>
                                                        <fmt:formatNumber value="${pageScope.totalTicket}" pattern="#,#00"/>
                                                        <fmt:message key="GLOBAL_HEADER_LABEL_张" bundle="${bundle}"/>
                                                    </span>
                                                </c:if>
                                            </font><%--6,657,097张--%>
                                        </div>
                                        <c:if test="${empty apiPaymentPage}">
                                            <div class="FloatRight ColorGreen"><a href="javascript:language.doSetChinese()">中文</a> | <a href="javascript:language.doSetEnglish()">English</a></div>        
                                        </c:if>
                                        <div class="clear"></div>
                                    </div>
                                    <span><fmt:message key="GLOBAL_HEADER_LABEL_PHONE" bundle="${bundle}"/><em>400.0800.620</em></span><span><fmt:message key="GLOBAL_HEADER_LABEL_EMAIL" bundle="${bundle}"/><em>service@yoopay.cn</em></span>
                                    <span class="entrance"><a href="/account/login" title=""><fmt:message key="GLOBAL_HEADER_LINK_LOGIN" bundle="${bundle}"/></a>	|	<a href="/account/signup_select" title=""><fmt:message key="GLOBAL_HEADER_LINK_SIGNUP" bundle="${bundle}"/></a>	|	<a href="/public/about" title=""><fmt:message key="GLOBAL_HEADER_LINK_ABOUT" bundle="${bundle}"/></a>	|	<a href="/public/index" title=""><fmt:message key="GLOBAL_HEADER_LINK_INDEX" bundle="${bundle}"/></a></span>
                                    <div class="clear"></div>
                                </div>
                                <div class="clear"></div>
                            </div>
                        </div>
                        <%--
                          <div class="news_title">
                              <span class="news_span"><%=Config.SYSTEM_NEWS_UPDATE_HTML%></span>
                              <c:if test="${empty IS_SHOW_SYSTEM_STATISTIC_NUMBERS}">
                                 <span><%=Config.SYSTEM_STATISTIC_NUMBERS_HTML%></span>
                              </c:if>
                              <div class="clear"></div>
                          </div>
                        --%>
                        <div class="home_content">
                    </c:otherwise>
                </c:choose>
            </c:otherwise>
        </c:choose>

