<%-- 
    Document   : z_bank_transfer
    Created on : Sep 29, 2011, 4:57:16 PM
    Author     : WangShuai
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="charge_form">
    <div class="paygate_left" >
        <p class="text16 bold" style="margin-bottom:30px"><fmt:message key="PAYMENT_BANK_TRANSFER_MSG_请转款到以下账户" bundle="${bundle}"/></p>


        <div id="china_bank_transfer_intro" style="display:none; background:#9C9C9C">
            <table width="100%" border="0" cellspacing="1" cellpadding="5" style="font-size:13px;">
                <tr>
                    <td align="left" valign="top" bgcolor="#DADADA" class="bold"><fmt:message key="PAYMENT_BANK_TRANSFER_MSG_金额" bundle="${bundle}"/>：</td>
                <td align="left" valign="top" bgcolor="#DADADA"><span id="bank_transfer_amount_span"></span></td>
                </tr>
                <tr>
                    <td align="left" valign="top" bgcolor="#DADADA" class="bold"><fmt:message key="PAYMENT_BANK_TRANSFER_MSG_账户名称" bundle="${bundle}"/></td>
                <td align="left" valign="top" bgcolor="#DADADA"><fmt:message key="PAYMENT_BANK_TRANSFER_MSG_北京恒知动奇" bundle="${bundle}"/></td>
                </tr>
                <c:choose>
                    <c:when test="${fundCollection.invoiceProvider == 'YOOPAY'}">
                        <tr id="payment_bank_transfer_msg_account_1">
                            <td align="left" valign="top" bgcolor="#DADADA" class="bold"><fmt:message key="PAYMENT_BANK_TRANSFER_MSG_银行账户" bundle="${bundle}"/>：</td>
                        <td align="left" valign="top" bgcolor="#DADADA">11090 62075 10801</td>
                        </tr>
                        <tr id="payment_bank_transfer_msg_name_1">
                            <td align="left" valign="top" bgcolor="#DADADA" class="bold"><fmt:message key="PAYMENT_BANK_TRANSFER_MSG_开户银行" bundle="${bundle}"/></td>
                        <td align="left" valign="top" bgcolor="#DADADA"><fmt:message key="PAYMENT_BANK_TRANSFER_MSG_招商银行北京分行华贸" bundle="${bundle}"/></td>
                        </tr>
                        <tr id="payment_bank_transfer_msg_account_2" style="display:none">
                            <td align="left" valign="top" bgcolor="#DADADA" class="bold"><fmt:message key="PAYMENT_BANK_TRANSFER_MSG_银行账户" bundle="${bundle}"/>：</td>
                        <td align="left" valign="top" bgcolor="#DADADA">11090 62075 10508</td>
                        </tr>
                        <tr id="payment_bank_transfer_msg_name_2" style="display:none">
                            <td align="left" valign="top" bgcolor="#DADADA" class="bold"><fmt:message key="PAYMENT_BANK_TRANSFER_MSG_开户银行" bundle="${bundle}"/></td>
                        <td align="left" valign="top" bgcolor="#DADADA"><fmt:message key="PAYMENT_BANK_TRANSFER_MSG_招商银行北京分行万达" bundle="${bundle}"/></td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <tr>
                            <td align="left" valign="top" bgcolor="#DADADA" class="bold"><fmt:message key="PAYMENT_BANK_TRANSFER_MSG_银行账户" bundle="${bundle}"/>：</td>
                        <td align="left" valign="top" bgcolor="#DADADA">11090 62075 10801</td>
                        </tr>
                        <tr>
                            <td align="left" valign="top" bgcolor="#DADADA" class="bold"><fmt:message key="PAYMENT_BANK_TRANSFER_MSG_开户银行" bundle="${bundle}"/></td>
                        <td align="left" valign="top" bgcolor="#DADADA"><fmt:message key="PAYMENT_BANK_TRANSFER_MSG_招商银行北京分行华贸" bundle="${bundle}"/></td>
                        </tr>
                    </c:otherwise>
                </c:choose>
            </table>
        </div>

        <div id="international_bank_transfer_intro" style="display:; background:#9C9C9C">
            <table width="100%" border="0" cellspacing="1" cellpadding="5" style="font-size:13px;">
                <tr>
                    <td align="left" valign="top" bgcolor="#DADADA" class="bold"><fmt:message key="PAYMENT_INT_BANK_TRANSFER_账户名称" bundle="${bundle}"/>:</td>
                <td align="left" valign="top" bgcolor="#DADADA">Tokiva Technologies Inc.</td>
                </tr>
                <tr>
                    <td align="left" valign="top" bgcolor="#DADADA" class="bold"><fmt:message key="PAYMENT_INT_BANK_TRANSFER_银行账号" bundle="${bundle}"/>:</td>
                <td align="left" valign="top" bgcolor="#DADADA">7300319</td>
                </tr>
                <tr>
                    <td align="left" valign="top" bgcolor="#DADADA" class="bold">Transit Number:</td>
                    <td align="left" valign="top" bgcolor="#DADADA">13132</td>
                </tr>
                <tr>
                    <td align="left" valign="top" bgcolor="#DADADA" class="bold">SWIFT Code:</td>
                    <td align="left" valign="top" bgcolor="#DADADA">TDOMCATTTOR</td>
                </tr>
                <tr>
                    <td align="left" valign="top" bgcolor="#DADADA" class="bold"><fmt:message key="PAYMENT_INT_BANK_TRANSFER_银行名称" bundle="${bundle}"/>:</td>
                <td align="left" valign="top" bgcolor="#DADADA">TD Canada Trust</td>
                </tr>
                <tr>
                    <td align="left" valign="top" bgcolor="#DADADA" class="bold"><fmt:message key="PAYMENT_INT_BANK_TRANSFER_银行地址" bundle="${bundle}"/>:</td>
                <td align="left" valign="top" bgcolor="#DADADA">Station Plaza, 231 Main<br/> Street North, Markham,<br/>
                    Ontario, Canada L3P 1Y6</td>
                </tr>
                <tr>
                    <td align="left" valign="top" bgcolor="#DADADA" class="bold"><fmt:message key="PAYMENT_INT_BANK_TRANSFER_补充信息" bundle="${bundle}"/>:</td>
                <td align="left" valign="top" bgcolor="#DADADA">For Yoopay</td>
                </tr>
            </table>


        </div>   
    </div>
    <div class="paygate_right">
        <p class="text16 bold"><fmt:message key="PAYMENT_BANK_TRANSFER_MSG_汇款成功后" bundle="${bundle}"/></p>
        <dl class="zhuanzhang" id="china_bank_transfer" style="display: none">

            <dd>
                <p><fmt:message key="PAYMENT_BANK_TRANSFER_LABEL_银行卡号" bundle="${bundle}"/><span></span></p>
            <input  class="charge_input" type="text" name="bank_account_number"/>
            </dd>
            <dd>
                <p><fmt:message key="PAYMENT_BANK_TRANSFER_LABEL_名称" bundle="${bundle}"/><span></span></p>
            <input  class="charge_input" type="text" name="bank_user_name"/>
            </dd>
            <dd>
                <p><fmt:message key="PAYMENT_BANK_TRANSFER_LABEL_银行" bundle="${bundle}"/><span></span></p>
            <input  class="charge_input" type="text" name="bank_name"/>
            </dd>
            <dd>
                <p><fmt:message key="PAYMENT_BANK_TRANSFER_LABEL_联系电话" bundle="${bundle}"/></p>
            <input  class="charge_input" type="text" name="user_phone" value="${user.mobilePhone}"/>
            </dd>


        </dl>
        <dl class="zhuanzhang" id="international_bank_transfer" style="display: none">
            <dd>
                <p><fmt:message key="WITHDRAW_ACCOUNT_LABEL_INT_BANK_账户名称" bundle="${bundle}"/><span></span></p>
            <input  class="charge_input" type="text" name="bank_user_name"/>
            </dd>
            <dd>
                <p><fmt:message key="WITHDRAW_ACCOUNT_LABEL_INT_BANK_开户行" bundle="${bundle}"/><span></span></p>
            <input  class="charge_input" type="text" name="bank_name"/>
            </dd>
            <dd>
                <p><fmt:message key="WITHDRAW_ACCOUNT_LABEL_INT_BANK_账户号码" bundle="${bundle}"/></p>
            <input  class="charge_input" type="text" name="bank_account_number"/>
            </dd>
            <dd>
                <p><fmt:message key="PAYMENT_BANK_TRANSFER_LABEL_联系电话" bundle="${bundle}"/></p>
            <input  class="charge_input" type="text" name="user_phone" value="${user.mobilePhone}"/>
            </dd>
        </dl>
    </div>
    <div class="clear"></div>
</div>
