<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%-- 
    Document   : index
    Created on : May 17, 2011, 5:23:59 PM
    Author     : chenjianlin
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
    request.setAttribute("mainMenuSelection", "STATS_REPORT");
    request.setAttribute("subMenuSelection", "");
%>

<%@include file="/WEB-INF/report/z_header.jsp"%>        
<jsp:include page="/WEB-INF/report/z_date_form.jsp">
    <jsp:param name="action" value="/report/sta" />
    <jsp:param name="title" value="统计：" />
</jsp:include>
<div class="admin-content">
    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="history_table">
        <tr class="white">
            <td>注册人数</td><td>${map['registerCount']}</td><td>Email已验证人数</td><td>${map['verifiedCount']}</td>
        </tr>
        <tr>
            <td>收款个数</td><td>${map['collectionCount']}</td><td>已收到(未计算退款与充值)</td>
            <td>
                <fmt:formatNumber value="${mapAmount['cny']}" type="currency"  pattern="￥#,##0.##"  />&nbsp;
                <fmt:formatNumber value="${mapAmount['usd']}" type="currency"  pattern="$#,##0.##"  /></td>
        </tr>
        <%--
        <tr  class="white">
            <td>转款次数</td><td>${map['transferCount']}</td><td>已支付</td><td>${mapAmount['transferSuccessAmount']}元</td>
        </tr>
        --%>
        <tr>
            <td>提款次数</td><td>${map['withdrawCount']}</td><td>共提款</td><td>${mapAmount['withdrawAmount']}元</td>
        </tr>
    </table>
</div>
<jsp:include page="/WEB-INF/report/z_footer.jsp"/>
