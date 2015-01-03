<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%-- 
    Document   : z_header
    Created on : Aug 1, 2012, 5:00:01 PM
    Author     : HUXIAOFENG
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="cn.yoopay.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>  
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>友付Support系统</title> 

        <link rel="shortcut icon" href="/favicon.ico" /> 

        <link rel="stylesheet" type="text/css" href="/css/jquery.cleditor.css" />
        <link href="/css/jquery-ui-1.9.1.custom.min.css" rel="stylesheet" type="text/css"/>
        <link href="/css/style_admin.css" rel="stylesheet" type="text/css" />
        <script type="text/javascript" src="/scripts/yoopay.js"></script>
        <script type="text/javascript" src="/scripts/jquery-1.8.2.min.js"></script>
        <script type="text/javascript" src="/scripts/jquery-ui-1.9.1.custom.min.js"></script>
        <script type="text/javascript" src="/scripts/jquery.bgiframe.js"></script>
        <script type="text/javascript" src="/scripts/jquery.bt.min.js" ></script>
        <script type="text/javascript" src="/scripts/jquery.cleditor.js"></script>
        <script type="text/javascript" src="/scripts/jquery.datepicker.local.cn.js"></script>
        <script type="text/javascript" src="/kindeditor-4.1.2/kindeditor.js"></script>
    </head>

    <body>
        <div class="head">
            <div class="head_inner ">
                <div class="logo" style="cursor: pointer" onclick="document.location.href='/account/overview'"></div>
                <div class="HeaderRight"><a href="/support/repassword">账户管理</a><span>|</span><a href="/support/logout">退出</a></div>
            </div>
        </div>

        <div class="nav">
            <ul id="nbaglobal" class="globalnav" >
                <c:if test="${supportAccountPermit.accountQueryPermit}">
                    <li <c:if test="${mainMenuSelection eq 'ACCOUNT'}">class="nowpage"</c:if>>
                        <a href="/support/account_query" >账户查询</a>
                    </li>
                </c:if>
                <c:if test="${supportAccountPermit.collectionQueryPermit}">
                    <li <c:if test="${mainMenuSelection eq 'EVENT_COLLECTION'}">class="nowpage"</c:if>>
                        <a href="/support/collection_query" >活动/收款查询</a>
                    </li>
                </c:if>
                <c:if test="${supportAccountPermit.feedbackQueryPermit}">
                    <li <c:if test="${mainMenuSelection eq 'FEEDBACK'}">class="nowpage"</c:if>>
                        <a href="/support/feedback" >Feedback查询</a>
                    </li>
                </c:if>
                <c:if test="${supportAccountPermit.withdrawQueryPermit}">
                    <li <c:if test="${mainMenuSelection eq 'WITHDRAW'}">class="nowpage"</c:if>>
                        <a href="/support/un_processed_withdraw" >提款请求查询</a>
                    </li>
                </c:if>
                <c:if test="${supportAccountPermit.accountSealQueryPermit}">
                    <li <c:if test="${mainMenuSelection eq 'SEAL'}">class="nowpage"</c:if>>
                        <a href="/support/un_processed_seal_list">实名认证查询</a>
                    </li>
                </c:if>
                <c:if test="${supportAccountPermit.bankTransferQueryPermit}">
                    <li <c:if test="${mainMenuSelection eq 'BANK_TRANSFER'}">class="nowpage"</c:if>>
                        <a href="/support/pending_bank_transfer_list">银行转账</a>
                    </li>
                </c:if>
                <c:if test="${supportAccountPermit.paypalTransactionQueryPermit}">
                    <li <c:if test="${mainMenuSelection eq 'PAYPAL'}">class="nowpage"</c:if>>
                        <a href="/support/paypal_transaction" >Paypal交易查询</a>
                    </li>
                </c:if>
                <c:if test="${supportAccountPermit.invoiceQueryPermit}">
                    <li <c:if test="${mainMenuSelection eq 'INVOICE'}">class="nowpage"</c:if>>
                        <a href="/support/un_processed_invoice">友付代开发票查询</a>
                    </li>
                </c:if>
                <li <c:if test="${mainMenuSelection eq 'BLOG_ARTICLE_LIST'}">class="nowpage"</c:if>>
                    <a href="/support/blog_article_list">友付博客</a>
                </li>
                <c:if test="${supportAccountPermit.orderRefundQueryPermit}">
                    <li <c:if test="${mainMenuSelection eq 'ORDER_REFUND'}">class="nowpage"</c:if>>
                        <a href="/support/order_refund_list">退款查询</a>
                    </li>
                </c:if>

                <%--
        <c:if test="${supportAccountPermit.fundTransferQueryPermit}">
            <li <c:if test="${mainMenuSelection eq 'FUND_TRANSFER'}">class="nowpage"</c:if>>
                <a href="/support/transfer" >转款查询</a>
            </li>
        </c:if>
                --%>
            </ul>

            <div class="clear"></div>
        </div>

        <div class="sub_nav">
            <div class="sub_nav_inner">
                <c:if test="${mainMenuSelection eq 'WITHDRAW'}">
                    <span  style="padding-left:320px" <c:if test="${subMenuSelection eq 'WITHDRAW_UN_PROCESSED'}">class="sub_nav_now"</c:if>><a href="/support/un_processed_withdraw" >未处理提款请求查询</a></span>
                    <span>|</span>
                    <span <c:if test="${subMenuSelection eq 'WITHDRAW_PROCESSED'}">class="sub_nav_now"</c:if>><a href="/support/processed_withdraw">已处理提款请求查询</a></span>
                </c:if>
                <c:if test="${mainMenuSelection eq 'SEAL'}">
                    <span style="padding-left:460px" <c:if test="${subMenuSelection eq 'SEAL_UN_PROCESSED'}">class="sub_nav_now"</c:if>><a href="/support/un_processed_seal_list">未处理实名认证查询</a></span>
                    <span>|</span>
                    <span <c:if test="${subMenuSelection eq 'SEAL_PROCESSED'}">class="sub_nav_now"</c:if>><a href="/support/processed_seal_list">已处理实名认证查询</a></span>
                </c:if>
                <c:if test="${mainMenuSelection eq 'INVOICE'}">
                    <span style="padding-left:460px" <c:if test="${subMenuSelection eq 'UN_PROCESSED_INVOICE'}">class="sub_nav_now"</c:if>><a href="/support/un_processed_invoice">未处理的友付代开发票</a></span>
                    <span>|</span>
                    <span <c:if test="${subMenuSelection eq 'PROCESSED_INVOICE'}">class="sub_nav_now"</c:if>><a href="/support/processed_invoice">已处理的友付代开发票</a></span>
                </c:if>
                <c:if test="${mainMenuSelection eq 'ORDER_REFUND'}">
                    <span style="padding-left:460px" <c:if test="${subMenuSelection eq 'ORDER_REFUND_LIST'}">class="sub_nav_now"</c:if>><a href="/support/order_refund_list">未处理的退款</a></span>
                    <span>|</span>
                    <span <c:if test="${subMenuSelection eq 'ORDER_REFUND_LIST_CONFIRMED'}">class="sub_nav_now"</c:if>><a href="/support/order_refund_list_confirmed">已处理的退款</a></span>
                </c:if>
            </div>
        </div>
        <div class="content">





