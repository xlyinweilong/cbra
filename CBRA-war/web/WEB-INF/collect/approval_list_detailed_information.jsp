<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%-- 
    Document   : approval_list_detailed_information
    Created on : Sep 10, 2012, 6:34:00 PM
    Author     : Yin.Weilong
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="cn.yoopay.entity.*"%>
<div style="margin:10px 15px 15px 10px;">
    <c:if test="${!orderIsFree}"><div><span style="color:#2BA8DD;font-size:18px;"><fmt:message key='COLLECT_DETAIL_LABEL_付款链接' bundle='${bundle}'/>: https://yoopay.cn/payment/payment_order/${subSerialId}</span><div></c:if>
                <table width="100%" border="0"  cellpadding="0" cellspacing="0" class="payment_list_table " style="margin:10px auto;">
                    <thead>
                    <td><fmt:message key='COLLECT_DETAIL_LABEL_门票种类' bundle='${bundle}'/></td>
                    <td><fmt:message key='COLLECT_DETAIL_LABEL_姓名' bundle='${bundle}'/></td> 
                    <td><fmt:message key='COLLECT_DETAIL_LABEL_公司' bundle='${bundle}'/></td> 
                    <td><fmt:message key='COLLECT_DETAIL_LABEL_职务' bundle='${bundle}'/></td> 
                    <td><fmt:message key='COLLECT_DETAIL_LABEL_手机' bundle='${bundle}'/></td>
                    <td><fmt:message key='COLLECT_DETAIL_LABEL_邮箱' bundle='${bundle}'/></td>
                    <c:forEach var="question" items="${registerQuestions}">
                        <td>${question.title}</td>
                    </c:forEach>
                    </thead>
                    <tbody>
                    <c:set  var="index" value="-1"></c:set>
                    <c:if test="${ not empty registerInfoList}">
                        <c:forEach var="item" items="${registerInfoList}" varStatus="status">
                            <c:set var='index' value="${index+1}"/>
                            <tr <c:if test="${index%2!=0}">class="white"</c:if>>
                            <td>${ticket[index]}</td>
                            <td>${item.name}</td> 
                            <td>${item.company}</td>  
                            <td>${item.position}</td> 
                            <td>${item.mobilePhone}</td> 
                            <td>${item.email}</td>
                            <c:if test="${registerQuestions.size()>0}">
                                <c:forEach var="num" begin="0" end="${registerQuestions.size()-1}" step="1">
                                    <td>
                                        ${registerAnswerMap[index][num]}
                                    </td>
                                </c:forEach>
                            </c:if>
                            </tr>
                        </c:forEach>
                        <c:if test="${not empty orderCollectionSub.approverRemarks}"><td><strong><fmt:message key='COLLECT_APPROVAL_备注信息' bundle='${bundle}'/></strong>：${orderCollectionSub.approverRemarks}</td></c:if>
                    </c:if>
                    </tbody>
                </table>
                        <c:if test="${!orderIsFree}"><div style="font-size:10px;"><fmt:message key='COLLECT_DETAIL_LABEL_付款链接说明' bundle='${bundle}'/></div></c:if>
            </div>