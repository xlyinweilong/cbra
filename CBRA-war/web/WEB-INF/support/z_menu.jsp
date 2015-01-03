<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%-- 
    Document   : z_menu
    Created on : Jul 11, 2012, 1:07:14 PM
    Author     : Yin.Weilong
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<head>
    <link href="/css/style.css" rel="stylesheet" type="text/css" />
    <link href="/css/jquery-ui-1.9.1.custom.min.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="/scripts/jquery-1.8.2.min.js"></script>
    <script type="text/javascript" src="/scripts/jquery-ui-1.9.1.custom.min.js"></script>
</head>
<style type="text/css" >
    body{text-align: center;padding:0px;margin:0px;}
    .nolist{ padding:10px;font-size:16px;text-align:center;color:#A75C25;}
    table{ border-collapse:collapse; text-align: center; }
    .content{margin-top: 30px}
    .vPagging{ margin-top: 30px}
    .vPagging a { border: #eee 1px solid; margin:2px; line-height:21px; background-color:#fff; padding: 2px 5px; color:#036cb4; text-decoration:none; font-weight:100; font-size:12px}
    .vPagging a:hover {border:#036cb4 1px solid; color:#fff; background-color:#036cb4; font-weight:100;}
    .vPagging a.curp{border:#036cb4 1px solid;}
    .admin-nav{background: none repeat scroll 0 0 #DEF1FE;height: 30px;line-height:30px;}
    .admin-nav span{display: block;height: 30px;line-height:30px;}
    .admin-nav span a:link,.admin-nav span a:visited{color:#686868;text-decoration:none ;}
    .admin-nav span a:hover,.admin-nav span a:active{color:#686868;text-decoration:underline;}
    .exit{text-align: right;margin:10px 40px 10px 0px;}
    .exit a:link,.exit a:visited{color:#57913C;text-decoration: none;}
    .exit a:hover,.exit a:active{color:#57913C;text-decoration: underline;}
</style>
<div class="admin-nav">
    <span>
        <c:if test="${supportAccountPermit.accountQueryPermit}">
            <a href="/support/account_query" >账户查询</a>&nbsp;|&nbsp;
        </c:if>
        <c:if test="${supportAccountPermit.collectionQueryPermit}">
            <a href="/support/collection_query" >活动/收款查询</a>&nbsp;|&nbsp;
        </c:if>
        <c:if test="${supportAccountPermit.feedbackQueryPermit}">
            <a href="/support/feedback" >Feedback查询</a>&nbsp;|&nbsp;
        </c:if>
        <c:if test="${supportAccountPermit.withdrawQueryPermit}">
            <a href="/support/un_processed_withdraw" >提款请求查询</a>&nbsp;|&nbsp;
        </c:if>
        <c:if test="${supportAccountPermit.accountSealQueryPermit}">
            <a href="/support/un_processed_seal_list">实名认证查询</a>&nbsp;|&nbsp;
        </c:if>
        <c:if test="${supportAccountPermit.bankTransferQueryPermit}">
            <a href="/support/pending_bank_transfer_list" >银行转款查询</a>&nbsp;|&nbsp;
        </c:if>
        <c:if test="${supportAccountPermit.paypalTransactionQueryPermit}">
            <a href="/support/paypal_transaction" >Paypal交易查询</a>&nbsp;|&nbsp;
        </c:if>
        <c:if test="${supportAccountPermit.fundTransferQueryPermit}">
            <a href="/support/transfer" >转款查询</a>&nbsp;|&nbsp;
        </c:if>
        <a href="/support/repassword">账户管理</a>
    </span>
</div>
<div class="exit">
    &nbsp;&nbsp;&nbsp;<a href="/support/logout">退出</a>
</div>
<div class="clear"></div>