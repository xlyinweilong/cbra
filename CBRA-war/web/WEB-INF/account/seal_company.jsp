
<%-- 
    Document   : company_seal
    Created on : May 26, 2011, 2:17:55 PM
    Author     : WangShuai
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%-- 设置MenuSelection参数 --%>
<%
    request.setAttribute("mainMenuSelection", cn.yoopay.web.support.MenuSelectionEnum.ACCOUNT);
    request.setAttribute("subMenuSelection", cn.yoopay.web.support.MenuSelectionEnum.ACCOUNT_SEAL);
%>
<%-- 设置MenuSelection参数结束 --%>
<jsp:include page="/WEB-INF/public/z_header.jsp"/>
<div class="BlueBox">
    <div class="noticeMessage">
        <div class="successMessage" id="seal_success_msg_div"><span class="FloatLeft"><fmt:message key="ACCOUNT_SEAL_COMPANY_LABEL_申请实名认证" bundle="${bundle}"/></span><span class="FloatRight why_verify"><a href="/public/verification" title="" target="_blank"><fmt:message key="ACCOUNT_SEAL_USER_LINK_为什么要实名认证？" bundle="${bundle}"/></a></span><div class="clear"></div></div>
        <div class="wrongMessage" style="display:none" id="seal_wrong_msg_div">
        </div>
        <c:if test="${!empty postResult.singleErrorMsg}"> 
            <div style="background:#F8E1E1; color:#BD2C2C;">
                ${postResult.singleErrorMsg}
            </div>
        </c:if> 
        <div class="loadingMessage" style="display:none" id="seal_loading_div"><fmt:message key="GLOBAL_MSG_LOADING" bundle="${bundle}"/><img alt="" src="/images/032.gif"></div>
    </div>
    <div class="BlueBoxContent826">
    <div class="Padding30">
        <div class="FloatLeft BlueBoxLeft">
            <div class="photo">
                <c:choose>
                    <c:when test="${not empty user.logoUrl}"> <img src="${user.logoUrl}"  width="80"/></c:when>
                    <c:otherwise><img src="/images/company_logo.png"  width="80"/></c:otherwise>
                </c:choose>
            </div>
        </div>
        <div class="FloatLeft BlueBoxContent">
            <form method="POST" action="${formAction}" enctype="multipart/form-data" onsubmit="return CompanySeal.checkSealForm(${user.logoUrl == null});">
                <div>
                <div class="creditcard FloatLeft">
                    <dl>
                        <dd>
                            <p><fmt:message key="COLLECT_SEND_LABEL_上传logo" bundle="${bundle}"/><span><fmt:message key="ACCOUNT_REGINFO_TEXT_最佳尺寸80x80像素" bundle="${bundle}"/></span></p>
                            <input name="logo" type="file" class="Input450 select240" id="seal_logo"/>
                        </dd>
                        <dd>
                            <p><fmt:message key="ACCOUNT_SIGNUPC_LABEL_公司团体名称" bundle="${bundle}"/></p>
                            <input type="text" class="Input450 Input240" name="company_name" id="seal_name" value="${user.company}"/>
                        </dd>
                        <dd>
                            <p><fmt:message key="ACCOUNT_SEAL_COMPANY_LABEL_证件种类" bundle="${bundle}"/></p>
                            <div class="card_kinds">
                                <select name="ctype"  class="Input450 select247"  id="seal_ctype">
                                    <option value="-1"><fmt:message key="WITHDRAW_LABEL_请选择" bundle="${bundle}"/></option>
                                    <option value="BUSINESS_LICENCE"><fmt:message key="ACCOUNT_SEAL_COMPANY_SELECT_营业执照" bundle="${bundle}"/></option>
                                    <option value="ORGANIZATION_LICENCE"><fmt:message key="ACCOUNT_SEAL_COMPANY_SELECT_组织机构代码证" bundle="${bundle}"/></option>
                                    <option value="ARTICLE_INCORPORATION">Article of Incorporation</option>
                                    <option value="OTHERS"><fmt:message key="ACCOUNT_SEAL_COMPANY_SELECT_其他" bundle="${bundle}"/></option>
                                </select>
                            </div>
                        </dd>
                        <dd>
                            <p><fmt:message key="ACCOUNT_SEAL_COMPANY_LABEL_证件号码" bundle="${bundle}"/></p>
                            <input type="text" class="Input450 Input240" name="cnumber" id="seal_cnumber"/>
                        </dd>
                        <dd>
                            <p><fmt:message key="ACCOUNT_SEAL_COMPANY_TEXT_上传证件扫描件" bundle="${bundle}"/><span><fmt:message key="ACCOUNT_SEAL_COMPANY_TEXT_文件最大5MB" bundle="${bundle}"/></span></p>
                            <input  type="file" class="Input450 select240" name="cimg" id="seal_cimg"/>
                        </dd>
                    </dl>
                </div>
                <div class="creditcard FloatRight">
                    <dl> 
                        <dd>
                            <p><fmt:message key="ACCOUNT_SEAL_COMPANY_LABEL_官方网址" bundle="${bundle}"/></p>
                            <input type="text" class="Input450 Input240" name="company_web" id="seal_web" value="http://"/>
                        </dd>
                        <dd>
                            <p><fmt:message key="ACCOUNT_SEAL_COMPANY_LABEL_预计年收款额" bundle="${bundle}"/><span><fmt:message key="COLLECT_EDIT_LABEL_UNIT" bundle="${bundle}"/></span></p>
                            <select name="collect_scale"  class="Input450 select247" id="seal_company_collect_scale">
                                <option value="-1" selected="selected"><fmt:message key="PAYMENT_DETAIL_LABEL_请选择" bundle="${bundle}"/></option>
                                <option value="LT50"><fmt:message key="ACCOUNT_SEAL_COMPANY_SELECT_小于50万" bundle="${bundle}"/></option>
                                <option value="GE50LT100"><fmt:message key="ACCOUNT_SEAL_COMPANY_SELECT_50万-200万" bundle="${bundle}"/></option>
                                <option value="GE200"><fmt:message key="ACCOUNT_SEAL_COMPANY_SELECT_200万以上" bundle="${bundle}"/></option>
                            </select>
                        </dd>
                        <dd>
                            <p><fmt:message key="PAYMENT_CREDITCARD_LABEL_地址" bundle="${bundle}"/></p>
                            <input type="text" class="Input450 Input240" name="company_address" id="seal_address"/>
                        </dd>
                        <dd>
                            <p><fmt:message key="ACCOUNT_SEAL_COMPANY_LABEL_电话" bundle="${bundle}"/></p>
                            <input type="text" class="Input450 Input240" name="company_phone" id="seal_phone"/>
                        </dd>
                        <dd>
                            <p><fmt:message key="ACCOUNT_SEAL_COMPANY_LABEL_传真" bundle="${bundle}"/></p>
                            <input type="text" class="Input450 Input240" name="company_fax" id="seal_fax"/>
                        </dd>
                        <dd>

                        </dd>
                    </dl>
                </div>
                            <div class="clear"></div>
                            </div>
                <div class="TextAlignLeft" style=" padding-left:58px;"><fmt:message key="ACCOUNT_SEAL_COMPANY_LABEL_补充说明" bundle="${bundle}"/>
                <textarea name="addition_notes" class="textarea550 FloatRight" id="textarea"></textarea>
                 <div class="clear"></div>   
                </div>
                <input type="hidden" name="a" value="CREATE_SEAL" />
                <c:choose>
                    <c:when test="${user.verified}">
                        <input type="submit" name="Submit" value="<fmt:message key='ACCOUNT_SEAL_COMPANY_BUTTON_申请认证' bundle='${bundle}'/>" class="collection_button FloatRight MarginTop10" id="seal_submit_btn"/>
                    </c:when>
                    <c:otherwise>
                        <input type="button" name="Submit" value="<fmt:message key='ACCOUNT_SEAL_COMPANY_BUTTON_申请认证' bundle="${bundle}"/>" class="collection_button FloatRight MarginTop10" id="seal_submit_btn" onclick="verifyDialog.open();"/>
                    </c:otherwise>
                </c:choose>
                <div class="clear"></div>   
            </form>
        </div> 
        <div class="clear"></div>
    </div></div>
</div>
<jsp:include page="/WEB-INF/public/z_footer.jsp"/>
<c:if test="${!user.verified}">
    <script type="text/javascript">
        window.onload = function() {
            verifyDialog.open();
        }
    </script>
</c:if>
<%@include file="/WEB-INF/public/z_footer_close.html" %> 
