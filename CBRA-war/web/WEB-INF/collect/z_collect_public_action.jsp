
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="cn.yoopay.entity.*"%>
<%
    FundCollection fundCollection = (FundCollection) request.getAttribute("fundCollection");
    String collectionType = null;
    if(fundCollection == null) {
        collectionType = (String)request.getAttribute("collectionType");
    } else {
        collectionType = fundCollection.getType().toString();
    }
    if ("EVENT".equals(collectionType)) {
        request.setAttribute("mainMenuSelection", cn.yoopay.web.support.MenuSelectionEnum.FUNDCOLLECT_EVENT);
        request.setAttribute("subMenuSelection", cn.yoopay.web.support.MenuSelectionEnum.FUNDCOLLECT_EVENT_CREATE);
    } else if ("DONATION".equals(collectionType)) {
        request.setAttribute("mainMenuSelection", cn.yoopay.web.support.MenuSelectionEnum.FUNDCOLLECT_DONATION);
        request.setAttribute("subMenuSelection", cn.yoopay.web.support.MenuSelectionEnum.FUNDCOLLECT_DONATION_CREATE);
    } else if ("SERVICE".equals(collectionType)) {
        request.setAttribute("mainMenuSelection", cn.yoopay.web.support.MenuSelectionEnum.FUNDCOLLECT_SERVICE);
        request.setAttribute("subMenuSelection", cn.yoopay.web.support.MenuSelectionEnum.FUNDCOLLECT_SERVICE_CREATE);
    } else if ("PRODUCT".equals(collectionType)) {
        request.setAttribute("mainMenuSelection", cn.yoopay.web.support.MenuSelectionEnum.FUNDCOLLECT_PRODUCT);
        request.setAttribute("subMenuSelection", cn.yoopay.web.support.MenuSelectionEnum.FUNDCOLLECT_PRODUCT_CREATE);
    } else if ("MEMBER".equals(collectionType)) {
        request.setAttribute("mainMenuSelection", cn.yoopay.web.support.MenuSelectionEnum.FUNDCOLLECT_MEMBER);
        request.setAttribute("subMenuSelection", cn.yoopay.web.support.MenuSelectionEnum.FUNDCOLLECT_MEMBER_CREATE);
    } else {
        request.setAttribute("mainMenuSelection", cn.yoopay.web.support.MenuSelectionEnum.FUNDCOLLECT_EVENT);
        request.setAttribute("subMenuSelection", cn.yoopay.web.support.MenuSelectionEnum.FUNDCOLLECT_EVENT_CREATE);
    }
%>
