<%-- 
    Document   : 账户首页
    Created on : Mar 29, 2011, 11:12:27 AM
    Author     : HUXIAOFENG
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="cn.yoopay.*"%>
<%-- 设置MenuSelection参数 --%>
<%
    request.setAttribute("mainMenuSelection", cn.yoopay.web.support.MenuSelectionEnum.ACCOUNT);
    request.setAttribute("subMenuSelection", cn.yoopay.web.support.MenuSelectionEnum.ACCOUNT_OVERVIEW);
%>
<%-- 设置MenuSelection参数结束 --%>

<jsp:include page="/WEB-INF/public/z_header.jsp"/>
<div>
    <%--<div class="overview_header"><fmt:message key="ACCOUNT_OVERVIEW_LABEL_一览表" bundle="${bundle}"/></div>
    <div class="overview_body">
        <div class="left"><p><c:choose><c:when test="${user.accountType=='COMPANY'}"><fmt:message key="ACCOUNT_OVERVIEW_LABEL_公司名称" bundle="${bundle}"/></c:when><c:otherwise><fmt:message key="ACCOUNT_OVERVIEW_LABEL_姓名" bundle="${bundle}"/></c:otherwise></c:choose>：<span><c:choose><c:when test="${user.accountType=='COMPANY'}">${user.company}<span><a></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></c:when>
                    <c:otherwise>${user.name}<span><a href="javascript:SignupCompanyAccountTipDialog.open();"><fmt:message key="ACCOUNT_OVERVIEW_LABEL_注册公司账户" bundle="${bundle}"/></a></span></c:otherwise></c:choose></span></p><p><fmt:message key="ACCOUNT_OVERVIEW_LABEL_邮箱" bundle="${bundle}"/>：<span>${user.email}</span></p>
            <p><fmt:message key="ACCOUNT_OVERVIEW_LABEL_版本" bundle="${bundle}"/>：<span><c:choose><c:when test="${USER_YPSERVICE_TYPE == 'STANDARD'}"><fmt:message key="ACCOUNT_OVERVIEW_LABEL_标准版" bundle="${bundle}" /></c:when><c:when test="${USER_YPSERVICE_TYPE == 'PROFESSIONAL'}"><fmt:message key="ACCOUNT_OVERVIEW_LABEL_专业版" bundle="${bundle}" /></c:when><c:otherwise><fmt:message key="ACCOUNT_OVERVIEW_LABEL_普通版" bundle="${bundle}" /></c:otherwise></c:choose></span><span><a href="/ypservice/list"><fmt:message key="ACCOUNT_OVERVIEW_LABEL_升级" bundle="${bundle}"/></a></span></p>
        </div>
        <div class="right"><p><fmt:message key="ACCOUNT_OVERVIEW_LABEL_收款余额" bundle="${bundle}"/>：<span><fmt:formatNumber value="${user.collectBalance}" type="currency"  pattern="￥#,##0.##"/></span><span><a href="/withdraw/create"><fmt:message key="ACCOUNT_OVERVIEW_LABEL_提款" bundle="${bundle}"/></a></span></p>
            <p><fmt:message key="ACCOUNT_OVERVIEW_LABEL_充值余额" bundle="${bundle}"/>：<span><fmt:formatNumber value="${user.addFundBalance}" type="currency"  pattern="￥#,##0.##"/></span><span><a href="/addfund/create"><fmt:message key="ACCOUNT_OVERVIEW_LABEL_充值" bundle="${bundle}"/></a></span><span><a href="javascript:FundAddFund.showAddFundInstructionDialog()"><img src="/images/overview_img.png" ></a></span></p>
        </div>
        <div class="clear"></div>
    </div>--%>
    <%--由于此功能涉及以前的转款功能，暂时关闭--%>
    <%--
    <div class="overview_footer">
        <div><fmt:message key="ACCOUNT_OVERVIEW_LABEL_专属友付链接" bundle="${bundle}"/>：<span><c:choose><c:when test="${user.accountType=='COMPANY'}"><fmt:message key="ACCOUNT_OVERVIEW_TEXT_即可向您付款" bundle="${bundle}" /></c:when><c:otherwise><fmt:message key="ACCOUNT_OVERVIEW_TEXT_即可向您公司付款" bundle="${bundle}" /></c:otherwise></c:choose></span></div>
        <div style="padding-left:60px;"><input name="" type="text" value="<c:choose><c:when test="${user.accountType=='COMPANY'}">https://yoopay.cn/o/</c:when><c:otherwise>https://yoopay.cn/p/</c:otherwise></c:choose>${user.ypLinkId}" style="width:514px; height:37px; border:solid 1px #b5b4b4"/><input class="collection_button MarginL7" type="button" value="复制"></div>
    </div>
    --%>
    <%-- 账户信息结束 --%>
    <c:if test="${not empty ticketList}">
        <div class="overview">
            <span class="overviewh2"><fmt:message key="ACCOUNT_OVERVIEW_LABEL_我的门票" bundle="${bundle}"/></span>
        </div>
        <table class="overview_table" width="100%" cellspacing="0" cellpadding="0" border="0">
            <thead>
                <tr>
                    <td width="20%"><fmt:message key="ACCOUNT_OVERVIEW_LABEL_活动时间" bundle="${bundle}"/></td>
            <td width="35%"><fmt:message key="ACCOUNT_OVERVIEW_LABEL_名称" bundle="${bundle}"/></td>
            <td width="35%"><fmt:message key="ACCOUNT_OVERVIEW_LABEL_门票名称" bundle="${bundle}"/></td>
            <td width="10%">&nbsp;</td>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="ticket" items="${ticketList}" varStatus="status">
                <tr <c:if test="${status.count%2!=0}">class="white"</c:if>>
                <td><fmt:formatDate value="${ticket.fundCollection.eventBeginDate}" type="date" pattern="yyyy.MM.dd"/></td>
                <td><a href='/pay/${ticket.fundCollection.webId}' target="_blank"> ${ticket.fundCollection.title}</a></td>
                <td>${ticket.fundCollectionPrice.name}</td>
                <td class="last"><a href="/account/ticket_download/${ticket.id}"  target="_blank" ><fmt:message key="ACCOUNT_OVERVIEW_LABEL_下载门票" bundle="${bundle}"/></a></td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </c:if>
    <%-- 我的门票列表结束 --%>
    <c:if test="${not empty eventList}">
        <div class="overview">
            <span class="overviewh2"><fmt:message key="ACCOUNT_OVERVIEW_LABEL_我的活动" bundle="${bundle}"/></span><input class="overview_input" type="button" onclick="location.href='/collect/create/event'" value="<fmt:message key='ACCOUNT_OVERVIEW_LABEL_发布新活动' bundle='${bundle}'/>"><br class="clear"/>
        </div>
        <table class="overview_table" width="100%" cellspacing="0" cellpadding="0" border="0">
            <thead>
                <tr>
                    <td width="12%"><fmt:message key="ACCOUNT_OVERVIEW_LABEL_收款" bundle="${bundle}"/></td>
            <td width="8%"><fmt:message key="ACCOUNT_OVERVIEW_LABEL_门票" bundle="${bundle}"/></td>
            <td width="8%"><fmt:message key="ACCOUNT_OVERVIEW_LABEL_待审批" bundle="${bundle}"/></td>
            <td width="8%"><fmt:message key="ACCOUNT_OVERVIEW_LABEL_浏览" bundle="${bundle}"/></td>
            <td width="40%"><fmt:message key="ACCOUNT_OVERVIEW_LABEL_名称" bundle="${bundle}"/></td>
            <td width="11%"><fmt:message key="ACCOUNT_OVERVIEW_LABEL_发布时间" bundle="${bundle}"/></td>
            <td width="10%">&nbsp;</td>
            </tr>
            </thead>
            <tbody>
            <c:set value="0" var="index"></c:set>
            <c:forEach var="event" items="${eventList}" varStatus="status">
                <tr <c:if test="${status.count%2!=0}">class="white"</c:if>>
                <td><%--收款总额和笔数--%><a href="/collect/payment_list/${event.webId}">
                        <c:choose>
                            <c:when test="${event.paymentAmountUSD.intValue() == 0 && event.paymentAmountCNY.intValue() == 0&&event.paidCountUSD==0&&event.paidCountCNY==0}">
                                <fmt:formatNumber value="${event.paymentAmountCNY}" type="currency"  pattern="¤#,##0.##" currencySymbol="￥" />
                            </c:when>
                            <c:otherwise>
                                <c:choose>
                                    <c:when test="${event.paymentAmountCNY.intValue()>0||event.paymentAmountUSD.intValue()>0}">
                                        <c:if test="${event.paymentAmountCNY.intValue()>0}">
                                            <fmt:formatNumber value="${event.paymentAmountCNY}" type="currency"  pattern="¤#,##0.##" currencySymbol="￥" />
                                        </c:if>
                                        <c:if test="${event.paidCountCNY>0}"></c:if>
                                        <c:if test="${event.paymentAmountUSD.intValue()>0}">
                                            <fmt:formatNumber value="${event.paymentAmountUSD}" type="currency"  pattern="¤#,##0.##" currencySymbol="$" />
                                        </c:if>
                                        <c:if test="${event.paidCountUSD>0}"></c:if>
                                    </c:when>
                                    <c:otherwise><%--免费领取的--%>
                                        <fmt:message key="ACCOUNT_OVERVIEW_TEXT_免费" bundle="${bundle}"/>
                                    </c:otherwise>
                                </c:choose>
                            </c:otherwise>
                        </c:choose></a>
                </td>
                <td><a href="/collect/ticket_list/${event.webId}">${ticketAccountList[index]}</a></td>
                <td><a href="/collect/approval_list/${event.webId}">${approvalCountList[index]}</a></td>
                <td>${event.visitCount}</td>
                <td><a href='/event/${event.webId}' target="_blank">${event.title}</a></td>
                <td><fmt:formatDate value="${event.createDate}" type="date" pattern="yyyy.MM.dd"/></td>
                <td class="last">
                    <a href="/collect/edit/${event.webId}"><fmt:message key="ACCOUNT_OVERVIEW_LABEL_编辑" bundle="${bundle}"/></a><span>|</span><a href="javascript:OverviewCollectDialog.open('${event.webId}', '${event.type}')"><fmt:message key="ACCOUNT_OVERVIEW_LABEL_隐藏" bundle="${bundle}"/></a></td>
                </tr>
                <c:set value="${index+1}" var="index"></c:set>
            </c:forEach>
            </tbody>
        </table>
    </c:if>
    <%-- 我的活动列表结束 --%>
    <c:if test="${not empty serviceList}">
        <div class="overview">
            <span class="overviewh2"><fmt:message key="ACCOUNT_OVERVIEW_LABEL_我的服务" bundle="${bundle}"/></span><input class="overview_input" type="button" onclick="location.href='/collect/create/service'" value="<fmt:message key='ACCOUNT_OVERVIEW_LABEL_发布新服务' bundle='${bundle}'/>"><br class="clear"/>
        </div>
        <table class="overview_table" width="100%" cellspacing="0" cellpadding="0" border="0">
            <thead>
                <tr>
                    <td width="15%"><fmt:message key="ACCOUNT_OVERVIEW_LABEL_收款" bundle="${bundle}"/></td>
            <td width="10%"><fmt:message key="ACCOUNT_OVERVIEW_LABEL_交易" bundle="${bundle}"/></td>
            <td width="10%"><fmt:message key="ACCOUNT_OVERVIEW_LABEL_浏览" bundle="${bundle}"/></td>
            <td width="55%"><fmt:message key="ACCOUNT_OVERVIEW_LABEL_名称" bundle="${bundle}"/></td>
            <td width="10%">&nbsp;</td>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="service" items="${serviceList}" varStatus="status">
                <tr <c:if test="${status.count%2!=0}">class="white"</c:if>>
                <td><%--收款总额和笔数--%><a href="/collect/payment_list/${service.webId}">
                        <c:choose>
                            <c:when test="${service.paymentAmountUSD.intValue() == 0 && service.paymentAmountCNY.intValue() == 0&&service.paidCountUSD==0&&service.paidCountCNY==0}">
                                <fmt:formatNumber value="${service.paymentAmountCNY}" type="currency"  pattern="¤#,##0.##" currencySymbol="￥" />
                            </c:when>
                            <c:otherwise>
                                <c:choose>
                                    <c:when test="${service.paymentAmountCNY.intValue()>0||service.paymentAmountUSD.intValue()>0}">
                                        <c:if test="${service.paymentAmountCNY.intValue()>0}">
                                            <fmt:formatNumber value="${service.paymentAmountCNY}" type="currency"  pattern="¤#,##0.##" currencySymbol="￥" />
                                        </c:if>
                                        <c:if test="${service.paidCountCNY>0}"></c:if>
                                        <c:if test="${service.paymentAmountUSD.intValue()>0}">
                                            <fmt:formatNumber value="${service.paymentAmountUSD}" type="currency"  pattern="¤#,##0.##" currencySymbol="$" />
                                        </c:if>
                                        <c:if test="${service.paidCountUSD>0}"></c:if>
                                    </c:when>
                                    <c:otherwise><%--免费领取的--%>
                                        <fmt:message key="ACCOUNT_OVERVIEW_TEXT_免费" bundle="${bundle}"/>
                                    </c:otherwise>
                                </c:choose>
                            </c:otherwise>
                        </c:choose></a>
                </td>
                <td>${service.paidCountUSD+service.paidCountCNY}</td>
                <td>${service.visitCount}</td>
                <td><a href='/service/${service.webId}' target="_blank">${service.title}</a></td>
                <td class="last">
                    <a href="/collect/edit/${service.webId}"><fmt:message key="ACCOUNT_OVERVIEW_LABEL_编辑" bundle="${bundle}"/></a><span>|</span><a href="javascript:OverviewCollectDialog.open('${service.webId}', '${service.type}')"><fmt:message key="ACCOUNT_OVERVIEW_LABEL_隐藏" bundle="${bundle}"/></a></td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </c:if>
    <%-- 服务列表结束 --%>
    <c:if test="${not empty productList}">
        <div class="overview">
            <span class="overviewh2"><fmt:message key="ACCOUNT_OVERVIEW_LABEL_我的产品" bundle="${bundle}"/></span><input class="overview_input" type="button" onclick="location.href='/collect/create/product'" value="<fmt:message key='ACCOUNT_OVERVIEW_LABEL_发布新产品' bundle='${bundle}'/>"><br class="clear"/>
        </div>
        <table class="overview_table" width="100%" cellspacing="0" cellpadding="0" border="0">
            <thead>
                <tr>
                    <td width="15%"><fmt:message key="ACCOUNT_OVERVIEW_LABEL_收款" bundle="${bundle}"/></td>
            <td width="10%"><fmt:message key="ACCOUNT_OVERVIEW_LABEL_交易" bundle="${bundle}"/></td>
            <td width="10%"><fmt:message key="ACCOUNT_OVERVIEW_LABEL_浏览" bundle="${bundle}"/></td>
            <td width="55%"><fmt:message key="ACCOUNT_OVERVIEW_LABEL_名称" bundle="${bundle}"/></td>
            <td width="10%">&nbsp;</td>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="product" items="${productList}" varStatus="status">
                <tr <c:if test="${status.count%2!=0}">class="white"</c:if>>
                <td><%--收款总额和笔数--%><a href="/collect/payment_list/${product.webId}">
                        <c:choose>
                            <c:when test="${product.paymentAmountUSD.intValue() == 0 && product.paymentAmountCNY.intValue() == 0&&product.paidCountUSD==0&&product.paidCountCNY==0}">
                                <fmt:formatNumber value="${product.paymentAmountCNY}" type="currency"  pattern="¤#,##0.##" currencySymbol="￥" />
                            </c:when>
                            <c:otherwise>
                                <c:choose>
                                    <c:when test="${product.paymentAmountCNY.intValue()>0||product.paymentAmountUSD.intValue()>0}">
                                        <c:if test="${product.paymentAmountCNY.intValue()>0}">
                                            <fmt:formatNumber value="${product.paymentAmountCNY}" type="currency"  pattern="¤#,##0.##" currencySymbol="￥" />
                                        </c:if>
                                        <c:if test="${product.paidCountCNY>0}"></c:if>
                                        <c:if test="${product.paymentAmountUSD.intValue()>0}">
                                            <fmt:formatNumber value="${product.paymentAmountUSD}" type="currency"  pattern="¤#,##0.##" currencySymbol="$" />
                                        </c:if>
                                        <c:if test="${product.paidCountUSD>0}"></c:if>
                                    </c:when>
                                    <c:otherwise><%--免费领取的--%>
                                        <fmt:message key="ACCOUNT_OVERVIEW_TEXT_免费" bundle="${bundle}"/>
                                    </c:otherwise>
                                </c:choose>
                            </c:otherwise>
                        </c:choose></a>
                </td>
                <td>${product.paidCountUSD+product.paidCountCNY}</td>
                <td>${product.visitCount}</td>
                <td><a href='/product/${product.webId}' target="_blank">${product.title}</a></td>
                <td class="last">
                    <a href="/collect/edit/${product.webId}"><fmt:message key="ACCOUNT_OVERVIEW_LABEL_编辑" bundle="${bundle}"/></a><span>|</span></span><a href="javascript:OverviewCollectDialog.open('${product.webId}', '${product.type}')"><fmt:message key="ACCOUNT_OVERVIEW_LABEL_隐藏" bundle="${bundle}"/></a></td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </c:if>
    <%-- 产品列表结束 --%>
    <c:if test="${not empty memberList}">
        <div class="overview">
            <span class="overviewh2"><fmt:message key="ACCOUNT_OVERVIEW_LABEL_我的会员费" bundle="${bundle}"/></span><input class="overview_input" type="button" onclick="location.href='/collect/create/member'" value="<fmt:message key='ACCOUNT_OVERVIEW_LABEL_发布新会员费' bundle='${bundle}'/>"><br class="clear"/>
        </div>
        <table class="overview_table" width="100%" cellspacing="0" cellpadding="0" border="0">
            <thead>
                <tr>
                    <td width="15%"><fmt:message key="ACCOUNT_OVERVIEW_LABEL_收款" bundle="${bundle}"/></td>
            <td width="10%"><fmt:message key="ACCOUNT_OVERVIEW_LABEL_交易" bundle="${bundle}"/></td>
            <td width="10%"><fmt:message key="ACCOUNT_OVERVIEW_LABEL_浏览" bundle="${bundle}"/></td>
            <td width="55%"><fmt:message key="ACCOUNT_OVERVIEW_LABEL_名称" bundle="${bundle}"/></td>
            <td width="10%">&nbsp;</td>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="member" items="${memberList}" varStatus="status">
                <tr <c:if test="${status.count%2!=0}">class="white"</c:if>>
                <td><%--收款总额和笔数--%><a href="/collect/payment_list/${member.webId}">
                        <c:choose>
                            <c:when test="${member.paymentAmountUSD.intValue() == 0 && member.paymentAmountCNY.intValue() == 0&&member.paidCountUSD==0&&member.paidCountCNY==0}">
                                <fmt:formatNumber value="${member.paymentAmountCNY}" type="currency"  pattern="¤#,##0.##" currencySymbol="￥" />
                            </c:when>
                            <c:otherwise>
                                <c:choose>
                                    <c:when test="${member.paymentAmountCNY.intValue()>0||member.paymentAmountUSD.intValue()>0}">
                                        <c:if test="${member.paymentAmountCNY.intValue()>0}">
                                            <fmt:formatNumber value="${member.paymentAmountCNY}" type="currency"  pattern="¤#,##0.##" currencySymbol="￥" />
                                        </c:if>
                                        <c:if test="${member.paidCountCNY>0}"></c:if>
                                        <c:if test="${member.paymentAmountUSD.intValue()>0}">
                                            <fmt:formatNumber value="${member.paymentAmountUSD}" type="currency"  pattern="¤#,##0.##" currencySymbol="$" />
                                        </c:if>
                                        <c:if test="${member.paidCountUSD>0}"></c:if>
                                    </c:when>
                                    <c:otherwise><%--免费领取的--%>
                                        <fmt:message key="ACCOUNT_OVERVIEW_TEXT_免费" bundle="${bundle}"/>
                                    </c:otherwise>
                                </c:choose>
                            </c:otherwise>
                        </c:choose></a>
                </td>
                <td>${member.paidCountUSD+member.paidCountCNY}</td>
                <td>${member.visitCount}</td>
                <td><a href='/membership/${member.webId}' target="_blank">${member.title}</a></td>
                <td class="last">
                    <a href="/collect/edit/${member.webId}"><fmt:message key="ACCOUNT_OVERVIEW_LABEL_编辑" bundle="${bundle}"/></a><span>|</span><a href="javascript:OverviewCollectDialog.open('${member.webId}', '${member.type}')"><fmt:message key="ACCOUNT_OVERVIEW_LABEL_隐藏" bundle="${bundle}"/></a></td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </c:if>
    <%-- 会员费列表结束 --%>
    <c:if test="${empty ticketList && empty eventList && empty serviceList && empty productList && empty memberList}">
        <br/>
        <div class="overviewImg"><fmt:message key="ACCOUNT_OVERVIEW_LABEL_OVERVIEWIMG" bundle="${bundle}"/></div>
    </c:if>
</div>
<div class="clear"></div>
<div id="ticket_error" style="display:none">
    <fmt:message key='ACCOUNT_TICKET_票未能生成，请及时与管理员联系' bundle='${bundle}'/><br/>
    <input  class="collection_button FloatRight" type="button" value="<fmt:message key='GLOBAL_确定' bundle='${bundle}'/>" onclick="TicketError.close();"/>
</div>
<div id="addFund_instruction" style="display:none">
    <span class="text16 MarginR10"><fmt:message key='ACCOUNT_ADDFUND_说明内容' bundle='${bundle}'/></span>
    <div class="TextAlignRight MarginTop10">
        <input class="collection_button" type="button" class="collection_button" onclick="FundAddFund.closeAddFundInstructionDialog()" value="<fmt:message key='ACCOUNT_ADDFUND_关闭' bundle='${bundle}'/>"/>
    </div>
</div>
<jsp:include page="/WEB-INF/public/z_footer.jsp"/>
<jsp:include page="/WEB-INF/account/z_remove_overviewc_dialog.jsp"/>
<c:if test="${user != null && !user.ypLinkIdFixed}">
    <jsp:include page="/WEB-INF/account/z_yplink_dialog.jsp"/>
    <script type="text/javascript">
        $(document).ready(function(){
            yplinkDialog.open();
        });
    </script>
</c:if>
<%@include file="/WEB-INF/public/z_footer_close.html" %> 
