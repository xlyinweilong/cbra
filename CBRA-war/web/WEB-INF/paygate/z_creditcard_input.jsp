<%-- 
    Document   : z_creditcard_input
    Created on : Apr 22, 2011, 3:29:32 PM
    Author     : WangShuai
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div><img src="/images/visa.png" width="53" height="15" /></div>
<div class="paygate_left">
    <table width="0" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td colspan="2"><fmt:message key="PAYMENT_CREDITCARD_LABEL_卡号" bundle="${bundle}"/><span>*</span></td>			
        </tr>
        <tr>
            <td colspan="2"><input type="text" name="acct" class="charge_input" id="acct"/></td>
        </tr>
        <tr>
            <td class="charge_td1"><fmt:message key="PAYMENT_CREDITCARD_LABEL_有效期" bundle="${bundle}"/></td>
        <td><fmt:message key="PAYMENT_CREDITCARD_LABEL_验证码" bundle="${bundle}"/><span>*</span></td>
        </tr>
        <tr>
            <td class="charge_td4">
                <select name="expdate_month" id="expdate_month"><option value="-1">MM</option></select>
                <select name="expdate_year" id="expdate_year"><option value="-1">YYYY</option></select>
            </td>
            <td>
                <input type="text" name="cvv2" class="charge_input2" id="cvv2"/>                         
            </td>
        </tr>
        <tr>
            <td class="charge_td5" colspan="2"><fmt:message key="PAYMENT_CREDITCARD_MSG_必须与信用卡上的姓名相同" bundle="${bundle}"/></td>
        </tr>
        <tr>
            <td colspan="2"><input type="text" name="credit_name" class="charge_input" id="credit_name"/></td>
        </tr>
    </table>
</div>
<div class="paygate_right">
    <table width="0" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td colspan="2"><fmt:message key="PAYMENT_CREDITCARD_LABEL_地址" bundle="${bundle}"/></td>
        </tr>
        <tr>
            <td colspan="2"><input type="text" name="credit_addr" class="charge_input" id="credit_addr"/></td>
        </tr>
        <tr>
            <td class="charge_td6"><fmt:message key="PAYMENT_CREDITCARD_LABEL_城市" bundle="${bundle}"/></td>
        <td class="charge_td7"><fmt:message key="PAYMENT_CREDITCARD_LABEL_州/省" bundle="${bundle}"/></td>
        </tr>
        <tr>

            <td><input type="text" name="credit_city" class="charge_input2" id="credit_city"/></td>
            <td class="TextAlignRight"><input type="text" name="credit_state" class="charge_input3" id="credit_state"/></td>
        </tr>
        <tr>
            <td class="charge_td6"><fmt:message key="PAYMENT_CREDITCARD_LABEL_国家" bundle="${bundle}"/></td>
        <td class="charge_td7"><fmt:message key="PAYMENT_CREDITCARD_LABEL_邮编" bundle="${bundle}"/></td>
        </tr>
        <tr>
            <td><input type="text" name="credit_country" class="charge_input2" id="credit_country"/></td>
            <td class="TextAlignRight"><input type="text" name="credit_zip" class="charge_input3" id="credit_zip"/></td>
        </tr>

    </table>
</div>
<div class="clear"></div>

