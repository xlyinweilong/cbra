<%-- 
    Document   : bank
    Created on : Jun 2, 2011, 11:04:39 AM
    Author     : lining
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<jsp:include page="/WEB-INF/public/z_header.jsp">
    <jsp:param name="PAGE_HEADER_TITLE" value="PAGE_HEADER_TITLE" />
</jsp:include>
<div class="FloatLeft BlueBoxContent">
    <table id="bank_table" width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
        <tr>
            <td height="62" align="center" valign="middle"><input type="radio" name="radio" id="radio" value="radio"> <a href="#" onclick="return false;"><img src="/images/bank_gsyh2_card.gif"  alt="中国工商银行银行卡支付"  width="130" height="52" border="0" align="middle" class="bank_img_red"/></a></td>
            <td width="30" align="center" valign="middle">&nbsp;</td>
            <td align="center"><input type="radio"/><a href="#" onclick="return false;"><img src="/images/bank_gsyh2.gif"  alt="中国工商银行手机银行 "  width="130" height="52" border="0" align="middle"/></a></td>
            <td width="30" align="center">&nbsp;</td>

            <td align="center"><input type="radio"/><a href="#" onclick="return false;"><img src="/images/bank_zsyh2.gif" alt="招商银行 "  width="130" height="52" border="0" align="middle"/></a></td>
        </tr>
        <tr>
            <td height="62" align="center" valign="middle"><a href="#" onclick="return false;">
                    <input type="radio"/>
                    <img src="/images/bank_zgyh2.gif" alt="中国银行" width="130" height="52" border="0" align="middle"/></a></td>
            <td width="30" align="center" valign="middle">&nbsp;</td>
            <td align="center"><a href="#" onclick="return false;">
                    <input type="radio"/>
                    <img src="/images/bank_jsyh2.gif" alt="中国建设银行" width="130" height="52" border="0" align="middle" /></a></td>
            <td width="30" align="center">&nbsp;</td>

            <td align="center"><a href="#" onclick="return false;">
                    <input type="radio"/>
                    <img src="/images/bank_jtyh.gif" alt="交通银行" width="130" height="52" border="0" align="middle"/></a></td>
        </tr>
        <tr>
            <td height="62" align="center"><a href="#" onclick="return false;">
                    <input type="radio"/>
                    <img src="/images/bank_nyyh2.gif" alt="中国农业银行" width="130" height="52" border="0" align="middle" /></a></td>
            <td width="30" align="center">&nbsp;</td>
            <td align="center"><a href="#" onclick="return false;">
                    <input type="radio"/>
                </a><a href="#" onClick="return false;"><img src="/images/bank_zxyh.gif" alt="中信银行"  width="130" height="52" border="0" align="middle"/></a></td>
            <td width="30" align="center">&nbsp;</td>

            <td align="center"><a href="#" onclick="return false;">
                    <input type="radio" />
                    <img src="/images/bank_msyh2_card.gif" alt="中国民生银行民生卡支付"  width="130" height="52" border="0" align="middle"/>                                    </a></td>
        </tr>
        <tr>
            <td height="62" align="center"><a href="#" onclick="return false;">
                    <input type="radio" />
                    <img src="/images/bank_msyh2.gif" alt="中国民生银行民生网银支付"  width="130" height="52" border="0" align="middle"/></a></td>
            <td width="30" align="center">&nbsp;</td>
            <td align="center"><a href="#" onclick="return false;">
                    <input type="radio" />
                    <img src="/images/bank_gdyh.gif" alt="光大银行"  width="130" height="52" border="0" align="middle"/></a></td>
            <td width="30" align="center">&nbsp;</td>

            <td align="center"><a href="#" onclick="return false;">
                    <input type="radio"/>
                    <img src="/images/bank_hxyh.gif" alt="华夏银行" width="130" height="52" border="0" align="middle"/></a></td>
        </tr>
        <tr>
            <td height="62" align="center"><a href="#" onclick="return false;">
                    <input type="radio"/>
                    <img src="/images/bank_xyyh.gif" alt="兴业银行"  width="130" height="52" border="0" align="middle"/>                                    </a></td>
            <td width="30" align="center">&nbsp;</td>
            <td align="center"><a href="#" onclick="return false;">
                    <input type="radio"/>
                    <img src="/images/bank_gdfz.gif" alt="广东发展银行"  width="130" height="52" border="0" align="middle"/></a></td>
            <td width="30" align="center">&nbsp;</td>

            <td align="center"><a href="#" onclick="return false;">
                    <input type="radio"/>
                    <img src="/images/bank_pfyh.gif" alt="上海浦东发展银行"  width="130" height="52" border="0" align="middle"/></a></td>
        </tr>
        <tr>
            <td height="62" align="center"><a href="#" onclick="return false;">
                    <input type="radio"/>
                    <img src="/images/bank_szfz.gif" alt="深圳发展银行"  width="130" height="52" border="0" align="middle"/></a></td>
            <td align="center">&nbsp;</td>
            <td align="center"><a href="#" onclick="return false;">
                    <input type="radio"/>
                    <img src="/images/bank_cqyh.gif" alt="重庆银行"  width="130" height="52" border="0" align="middle"/></a></td>
            <td align="center">&nbsp;</td>
            <td align="center"><a href="#" onclick="return false;">
                    <input type="radio"/>
                    <img src="/images/bank_njyh.gif" alt="南京银行"  width="130" height="52" border="0" align="middle"/> </a></td>
        </tr>
        <tr>
            <td height="62" align="center"><a href="#" onclick="return false;">
                    <input type="radio"/>
                    <img src="/images/bank_bhyh.gif" alt="渤海银行"  width="130" height="52" border="0" align="middle"/></a></td>
            <td align="center">&nbsp;</td>
            <td align="center"><a href="#" onclick="return false;">
                    <input type="radio"/>
                    <img src="/images/bank_dyyh.gif" alt="东亚银行"  width="130" height="52" border="0" align="middle"/></a></td>
            <td align="center">&nbsp;</td>
            <td align="center">&nbsp;</td>
        </tr>
    </table>
</div>


<jsp:include page="/WEB-INF/public/z_footer.jsp"/> <%@include file="/WEB-INF/public/z_footer_close.html" %> 