
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    request.setAttribute("mainMenuSelection", "");
    request.setAttribute("subMenuSelection", "");
%>

<%@include file="/WEB-INF/support/z_header.jsp"%>

<c:if test="${postResult.success}">
    <h3 class="nolist">
        ${postResult.singleSuccessMsg}
    </h3>
</c:if>

<c:if test="${!empty postResult.singleErrorMsg}">
    <h3 class="nolist">
        ${postResult.singleErrorMsg}
    </h3>
</c:if>
<h3 align="left">用户信息（${User.name}）：</h3>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="history_table">
    <tbody>
    <div class="admin-content">
        <c:choose>
            <c:when test="${not empty User}">
                <input type="hidden" id="userid" name="id" value="${User.id}"/>
                <table width="100%" border="0" cellpadding="0" cellspacing="0" class="history_table">
                    <tr>
                        <td>姓名</td>
                        <td class="white">${User.name}</td>
                        <td>邮箱</td>
                        <td class="white" id="userEmail">${User.email}</td>
                    </tr>
                    <tr>
                        <td>账户是否可用</td>
                        <td class="white">${User.enabled}</td>
                        <td>邮箱是否激活</td>
                        <td class="white">${User.verified}</td>
                    </tr>
                    <tr>
                        <td>充值余额</td>
                        <td class="white">${User.addFundBalance}</td>
                        <td>收款余额</td>
                        <td class="white">${User.collectBalance}</td>
                    </tr>
                    <tr>
                        <td>共计收款</td>
                        <td class="white">${User.collectionAmount}</td>
                        <td>共计付款</td>
                        <td class="white">${User.paymentAmount}</td>
                    </tr>
                    <tr>
                        <td>提款</td>
                        <td class="white">${User.withdrawAmount}</td>
                        <td>手机</td>
                        <td class="white">${User.mobilePhone}</td>
                    </tr>
                    <tr>
                        <td>公司</td>
                        <td class="white">${User.company}</td>
                        <td>链接</td>
                        <td class="white">${User.ypLinkId}</td>
                    </tr>
                    <tr>
                        <td>默认语言</td>
                        <td class="white">${User.language}</td>
                        <td>账户创建时间</td>
                        <td class="white"><fmt:formatDate value='${User.createDate}'type='date' pattern='yyyy.MM.dd'/></td>
                    </tr>
                </table>
                <c:if test="${supportAccountPermit.accountLoginAsPermit}">
                    <form target= "_blank" action="/support/user_information" method="POST">
                        <input type="hidden" name="a" value="ACCOUNT_LOGIN_AS" />
                        <input type="hidden" id="id" name="id" value="${User.id}"/>
                        <input type="hidden" id="email" name="email" value="${User.email}"/>
                        <input type="submit" value="登录该用户" />
                        <font color="red">点击后直接登录，不需要密码</font>
                    </form>
                </c:if>
                <c:if test="${supportAccountPermit.accountModifyPermit}">
                    <input type="hidden" id="oldEmail" name="email" value="${User.email}"/>
                    <div>
                        输入新邮箱：
                        <input type="text" id="newEmail" name="newEmail" size="35" onKeyDown= "if(event.keyCode==13){return BackgroupOperation.changeEmail()}"/>
                        <input type="button" value="修改邮箱" onclick="return BackgroupOperation.changeEmail()"/>
                        <span>需要重新验证</span><input type="checkbox" name="validationEmail" value="validationEmail" id="validationEmail"/>
                    </div>
                    <div>
                        输入新密码：
                        <input type="text" id="newPassword" name="newPassword" size="35" onKeyDown= "if(event.keyCode==13){return BackgroupOperation.changePasswrod()}"/>
                        <input type="button" value="修改密码" onclick="return BackgroupOperation.changePasswrod()"/>
                        <span>（密码至少6位）</span>
                    </div>
                </c:if>
                <div>
                    <c:if test="${supportAccountPermit.modifyUserServiceStatusPermit}">
                        <c:choose>
                            <c:when test="${showElement == 'service_status'}">
                                <a id="service_status_link" href="javascript:BackgroupOperation.elementHide('service_status','service_status_link')">隐藏修改服务</a>&nbsp;&nbsp;
                            </c:when>
                            <c:otherwise>
                                <a id="service_status_link" href="javascript:BackgroupOperation.elementShow('service_status','service_status_link')">显示修改服务</a>&nbsp;&nbsp;
                            </c:otherwise>
                        </c:choose>
                    </c:if>
                    <c:if test="${supportAccountPermit.modifyUserRatePermit}">
                        <c:choose>
                            <c:when test="${showElement == 'basic_rate'}">
                                <a id="basic_rate_link" href="javascript:BackgroupOperation.elementHide('basic_rate','basic_rate_link')">隐藏修改基本费率</a>&nbsp;&nbsp;
                                <a id="widget_rate_link" href="javascript:BackgroupOperation.elementShow('widget_rate','widget_rate_link')">显示修改微件费率</a>
                            </c:when>
                            <c:when test="${showElement == 'widget_rate'}">
                                <a id="basic_rate_link" href="javascript:BackgroupOperation.elementShow('basic_rate','basic_rate_link')">显示修改基本费率</a>&nbsp;&nbsp;
                                <a id="widget_rate_link" href="javascript:BackgroupOperation.elementHide('widget_rate','widget_rate_link')">隐藏修改微件费率</a>
                            </c:when>
                            <c:otherwise>
                                <a id="basic_rate_link" href="javascript:BackgroupOperation.elementShow('basic_rate','basic_rate_link')">显示修改基本费率</a>&nbsp;&nbsp;
                                <a id="widget_rate_link" href="javascript:BackgroupOperation.elementShow('widget_rate','widget_rate_link')">显示修改微件费率</a>
                            </c:otherwise>
                        </c:choose>

                    </c:if>
                </div>
                <c:if test="${supportAccountPermit.modifyUserServiceStatusPermit}">
                    <div <c:if test="${showElement != 'service_status'}">style="display:none"</c:if> id="service_status">
                        <div style="margin:9px 0px 9px 0px;padding: 5px 5px 5px 5px;BORDER-RIGHT: 3px double #000000; BORDER-TOP: 3px double #000000; BACKGROUND: #ffffff; BORDER-LEFT: 3px double #000000; WIDTH: 98.5%; BORDER-BOTTOM: 3px double #000000; HEIGHT: 100%">
                            <span style="color:red">服务</span><br/>
                            生效时间&nbsp;<input type="text" id="user_service_status_start_date" style="" />&nbsp;&nbsp;&nbsp;
                            <script>
                                $("#user_service_status_start_date").datepicker();
                                $("#user_service_status_start_date").datepicker("option", "dateFormat", "yy-mm-dd");
                            </script>
                            过期时间&nbsp;<input type="text" id="user_service_status_end_date" style="" /><br/>
                            <script>
                                $("#user_service_status_end_date").datepicker();
                                $("#user_service_status_end_date").datepicker("option", "dateFormat", "yy-mm-dd");
                            </script>
                            服务版本&nbsp;
                            <select id="user_service_status_type">
                                <option value="">不修改</option>
                                <option value="free">免费版</option>
                                <option value="standard">标准版</option>
                                <option value="profession">专业版</option>
                            </select>&nbsp;&nbsp;&nbsp;&nbsp;
                            是否开通信用卡&nbsp;
                            <select id="user_service_status_credit_card">
                                <option value="">不修改</option>
                                <option value="open">开通</option>
                                <option value="close">关闭</option>
                            </select>&nbsp;&nbsp;&nbsp;&nbsp;
                            是否开通自定义票&nbsp;
                            <select id="user_service_status_custom_ticket">
                                <option value="">不修改</option>
                                <option value="open">开通</option>
                                <option value="close">关闭</option>
                            </select>&nbsp;&nbsp;&nbsp;&nbsp;
                            是否开通API服务&nbsp;
                            <select id="user_service_status_api">
                                <option value="">不修改</option>
                                <option value="open">开通</option>
                                <option value="close">关闭</option>
                            </select>&nbsp;&nbsp;&nbsp;&nbsp;
                            是否开通签到系统&nbsp;
                            <select id="user_service_status_checkin">
                                <option value="">不修改</option>
                                <option value="open">开通</option>
                                <option value="close">关闭</option>
                            </select>&nbsp;&nbsp;&nbsp;&nbsp;
                            <input type="button" value="修改服务" onclick="return BackgroupOperation.changeUserServiceStatus()"/>
                        </div>
                        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="history_table">
                            <tr>
                                <td>生效时间</td>
                                <td class="white"><c:choose><c:when test="${userServiceStatus.startDate == null}">无期限</c:when><c:otherwise><fmt:formatDate value='${userServiceStatus.startDate}'type='date' pattern='yyyy.MM.dd'/></c:otherwise></c:choose></td>
                            <td>过期时间</td>
                            <td class="white"><c:choose><c:when test="${userServiceStatus.endDate == null}">无期限</c:when><c:otherwise><fmt:formatDate value='${userServiceStatus.endDate}'type='date' pattern='yyyy.MM.dd'/></c:otherwise></c:choose></td>
                            </tr>
                            <tr>
                                <td>服务版本</td>
                                <td class="white"><c:choose><c:when test="${userServiceStatus.serviceType == null}">免费版</c:when><c:when test="${userServiceStatus.serviceType == 'STANDARD'}">标准版</c:when><c:when test="${userServiceStatus.serviceType == 'PROFESSIONAL'}">专业版</c:when></c:choose></td>
                            <td>是否开通Visa、Mastercard、Paypal</td>
                            <td class="white">${userServiceStatus.isPayPalEnable()}</td>
                            </tr>
                            <tr>
                                <td>是否开通自定义票</td>
                                <td class="white">${userServiceStatus.isCustomTicketEnabled()}</td>
                                <td>服务余额</td>
                                <td class="white">${userServiceStatus.volumeBalance}</td>
                            </tr>
                            <tr>
                                <td>是否开通API服务</td>
                                <td class="white">${userServiceStatus.apiEnabled}</td>
                                <td>是否开通签到系统</td>
                                <td class="white">${userServiceStatus.checkinEnabled}</td>
                            </tr>
                            <tr>
                                <td>找出记录条数</td>
                                <td class="white">${userServiceStatusCountAndNoDateRestrict}</td>
                                <td>找出有效记录条数</td>
                                <td class="white">${userServiceStatusCount}</td>
                            </tr>
                        </table>
                        <p>记录条数为0，代表没有该用户的信息；记录大于1，即有多条信息，修改和显示出的是最后到期的信息(设置时请注意不要同时有2条信息是非过期的)</p>
                        <p>修改时若不想修改某项信息，请不要输入数值(例如:不修改生效时间，生效时间留空)</p>
                        <p>修改时为在原有的基础上修改，没有原来记录时才会创建(创建时默认时间是now到1年)。</p>
                        <p style="color:red">免费版的服务是不能使用信用卡支付、门票定制、签到系统等功能</p>
                    </div>
                </c:if>
                <c:if test="${supportAccountPermit.modifyUserRatePermit}">
                    <div <c:if test="${showElement != 'basic_rate'}">style="display:none"</c:if> id="basic_rate">
                        <div style="margin:9px 0px 9px 0px;padding: 5px 5px 5px 5px;BORDER-RIGHT: 3px double #000000; BORDER-TOP: 3px double #000000; BACKGROUND: #ffffff; BORDER-LEFT: 3px double #000000; WIDTH: 98.5%; BORDER-BOTTOM: 3px double #000000; HEIGHT: 100%">
                            <span style="color:red">基本费率</span><br/>
                            生效时间&nbsp;<input type="text" id="user_rate_start_date_by_basic" style="" />
                            <script>
                                $("#user_rate_start_date_by_basic").datepicker();
                                $("#user_rate_start_date_by_basic").datepicker("option", "dateFormat", "yy-mm-dd");
                            </script>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            过期时间&nbsp;<input type="text" id="user_rate_end_date_by_basic" style="" /><br/>
                            <script>
                                $("#user_rate_end_date_by_basic").datepicker();
                                $("#user_rate_end_date_by_basic").datepicker("option", "dateFormat", "yy-mm-dd");
                            </script>
                            支付宝费率:&nbsp;${basicRate.alipayRate}&nbsp;<input id="user_rate_alipayRate_by_basic" type="text" onKeyDown= "if(event.keyCode==13){return BackgroupOperation.changeUserRate('basic')}"/><br/>
                            余额费率:&nbsp;${basicRate.accountBalanceRate}&nbsp;<input id="user_rate_accountBalanceRate_by_basic" type="text" onKeyDown= "if(event.keyCode==13){return BackgroupOperation.changeUserRate('basic')}"/><br/>
                            网银费率:&nbsp;${basicRate.chinabankRate}&nbsp;<input id="user_rate_chinabankRate_by_basic" type="text" onKeyDown= "if(event.keyCode==13){return BackgroupOperation.changeUserRate('basic')}"/><br/>
                            银行转帐费率:&nbsp;${basicRate.bankTransferRate}&nbsp;<input id="user_rate_bankTransferRate_by_basic" type="text" onKeyDown= "if(event.keyCode==13){return BackgroupOperation.changeUserRate('basic')}"/><br/>
                            Visa费率:&nbsp;${basicRate.visaRate}&nbsp;<input id="user_rate_visaRate_by_basic" type="text" onKeyDown= "if(event.keyCode==13){return BackgroupOperation.changeUserRate('basic')}"/><br/>
                            Mastercard费率:&nbsp;${basicRate.mastercardRate}&nbsp;<input id="user_rate_mastercardRate_by_basic" type="text" onKeyDown= "if(event.keyCode==13){return BackgroupOperation.changeUserRate('basic')}"/><br/>
                            Paypal费率:&nbsp;${basicRate.paypalRate}&nbsp;<input id="user_rate_paypalRate_basic" type="text" onKeyDown= "if(event.keyCode==13){return BackgroupOperation.changeUserRate('basic')}"/><br/>
                            发票费率:&nbsp;${basicRate.invoiceRate}&nbsp;<input id="user_rate_invoiceRate_basic" type="text" onKeyDown= "if(event.keyCode==13){return BackgroupOperation.changeUserRate('basic')}"/><br/>
                            邮件推广费率:&nbsp;${basicRate.emailPromoteRate}&nbsp;<input id="user_rate_email_promote_basic" type="text" onKeyDown= "if(event.keyCode==13){return BackgroupOperation.changeUserRate('basic')}"/><br/>
                            短信推广费率:&nbsp;${basicRate.messagePromoteRate}&nbsp;<input id="user_rate_message_promote_basic" type="text" onKeyDown= "if(event.keyCode==13){return BackgroupOperation.changeUserRate('basic')}"/><br/>
                            <input type="button" value="修改费率" onclick="return BackgroupOperation.changeUserRate('basic')"/>
                        </div>
                        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="history_table">
                            <tr>
                                <td>生效时间</td>
                                <td class="white"><fmt:formatDate value='${basicRate.startDate}'type='date' pattern='yyyy.MM.dd'/></td>
                            <td>过期时间</td>
                            <td class="white"><fmt:formatDate value='${basicRate.endDate}'type='date' pattern='yyyy.MM.dd'/></td>
                            </tr>
                            <tr>
                                <td>找出记录条数</td>
                                <td class="white">${userRateCountFromBasicAndNoDateRestrict}</td>
                                <td>找出有效记录条数</td>
                                <td class="white">${userRateCountFromBasic}</td>
                            </tr>
                        </table>
                        <p>记录条数为0，代表没有该用户的信息；记录大于1，即有多条信息，修改和显示出的是最后到期的信息(设置时请注意不要同时有2条信息是非过期的)</p>
                        <p>修改时若不想修改某项信息，请不要输入数值(例如:不修改生效时间，生效时间留空)</p>
                        <p>修改时为在原有的基础上修改，没有原来记录时才会创建(创建时默认时间是now到1年)。</p>
                        <p>修改的数值为小数(例如:0.026)</p>
                        <p>邮件推广费率,短信推广费率是实际扣的钱数，可以大于1</p>
                    </div>
                    <div <c:if test="${showElement != 'widget_rate'}">style="display:none"</c:if> id="widget_rate">
                        <div style="margin:9px 0px 9px 0px;padding: 5px 5px 5px 5px;BORDER-RIGHT: 3px double #000000; BORDER-TOP: 3px double #000000; BACKGROUND: #ffffff; BORDER-LEFT: 3px double #000000; WIDTH: 98.5%; BORDER-BOTTOM: 3px double #000000; HEIGHT: 100%">
                            <span style="color:red">微件费率</span><br/>
                            生效时间&nbsp;<input type="text" id="user_rate_start_date_by_widget" style="" />
                            <script>
                                $("#user_rate_start_date_by_widget").datepicker();
                                $("#user_rate_start_date_by_widget").datepicker("option", "dateFormat", "yy-mm-dd");
                            </script>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            过期时间&nbsp;<input type="text" id="user_rate_end_date_by_widget" style="" /><br/>
                            <script>
                                $("#user_rate_end_date_by_widget").datepicker();
                                $("#user_rate_end_date_by_widget").datepicker("option", "dateFormat", "yy-mm-dd");
                            </script>
                            支付宝费率:&nbsp;${widgetRate.alipayRate}&nbsp;<input id="user_rate_alipayRate_by_widget" type="text" onKeyDown= "if(event.keyCode==13){return BackgroupOperation.changeUserRate('widget')}"/><br/>
                            余额费率:&nbsp;${widgetRate.accountBalanceRate}&nbsp;<input id="user_rate_accountBalanceRate_by_widget" type="text" onKeyDown= "if(event.keyCode==13){return BackgroupOperation.changeUserRate('widget')}"/><br/>
                            网银费率:&nbsp;${widgetRate.chinabankRate}&nbsp;<input id="user_rate_chinabankRate_by_widget" type="text" onKeyDown= "if(event.keyCode==13){return BackgroupOperation.changeUserRate('widget')}"/><br/>
                            银行转帐费率:&nbsp;${widgetRate.bankTransferRate}&nbsp;<input id="user_rate_bankTransferRate_by_widget" type="text" onKeyDown= "if(event.keyCode==13){return BackgroupOperation.changeUserRate('widget')}"/><br/>
                            Visa费率:&nbsp;${widgetRate.visaRate}&nbsp;<input id="user_rate_visaRate_by_widget" type="text" onKeyDown= "if(event.keyCode==13){return BackgroupOperation.changeUserRate('widget')}"/><br/>
                            Mastercard费率:&nbsp;${widgetRate.mastercardRate}&nbsp;<input id="user_rate_mastercardRate_by_widget" type="text" onKeyDown= "if(event.keyCode==13){return BackgroupOperation.changeUserRate('widget')}"/><br/>
                            Paypal费率:&nbsp;${widgetRate.paypalRate}&nbsp;<input id="user_rate_paypalRate_widget" type="text" onKeyDown= "if(event.keyCode==13){return BackgroupOperation.changeUserRate('widget')}"/><br/>
                            发票费率:&nbsp;${widgetRate.invoiceRate}&nbsp;<input id="user_rate_invoiceRate_widget" type="text" onKeyDown= "if(event.keyCode==13){return BackgroupOperation.changeUserRate('widget')}"/><br/>
                            <input type="button" value="修改费率" onclick="return BackgroupOperation.changeUserRate('widget')"/>
                        </div>
                        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="history_table">
                            <tr>
                                <td>生效时间</td>
                                <td class="white"><fmt:formatDate value='${widgetRate.startDate}'type='date' pattern='yyyy.MM.dd'/></td>
                            <td>过期时间</td>
                            <td class="white"><fmt:formatDate value='${widgetRate.endDate}'type='date' pattern='yyyy.MM.dd'/></td>
                            </tr>
                            <tr>
                                <td>找出记录条数</td>
                                <td class="white">${userRateCountFromWidgetAndNoDateRestrict}</td>
                                <td>找出有效记录条数</td>
                                <td class="white">${userRateCountFromWidget}</td>
                            </tr>
                        </table>
                        <p>记录条数为0，代表没有该用户的信息；记录大于1，即有多条信息，修改和显示出的是最后到期的信息(设置时请注意不要同时有2条信息是非过期的)</p>
                        <p>修改时若不想修改某项信息，请不要输入数值(例如:不修改生效时间，生效时间留空)</p>
                        <p>修改时为在原有的基础上修改，没有原来记录时才会创建(创建时默认时间是now到1年)。</p>
                        <p>修改的数值为小数(例如:0.026)</p>
                    </div>
                </c:if>
            </c:when>
            <c:otherwise>
                <h3 class="nolist">列表为空</h3>
            </c:otherwise>
        </c:choose>
    </div>
</tbody>
</table>
<jsp:include page="/WEB-INF/support/z_footer.jsp"/>
