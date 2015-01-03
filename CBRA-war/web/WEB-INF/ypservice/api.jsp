<%-- 
    Document   : api
    Created on : Dec 26, 2012, 4:07:05 PM
    Author     : wangshuai
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%-- 设置MenuSelection参数 --%>
<%
    request.setAttribute("mainMenuSelection", cn.yoopay.web.support.MenuSelectionEnum.YOOPAY_API);
    request.setAttribute("subMenuSelection", cn.yoopay.web.support.MenuSelectionEnum.YOOPAY_SERVICE_API);
%>
<jsp:include page="/WEB-INF/public/z_header.jsp">
    <jsp:param name="current_page" value="api"></jsp:param>
</jsp:include>
<c:choose>
    <%--没有api权限的页面--%>
    <c:when test="${sessionScope.userServiceStatus == null || !userServiceStatus.isApiEnabled()}">
        <div class="BlueBox">
            <div class="BlueBoxTitle">
                <fmt:message key="PULIC_Z_FOOTER_LINK_友付API" bundle="${bundle}"/> 
            </div>
            <div style="padding:30px 40px"><fmt:message key="PUBLIC_API_TEXT" bundle="${bundle}"/></div>
        </div>
    </c:when>
    <%--有api权限的页面--%>
    <c:when test="${sessionScope.userServiceStatus != null && userServiceStatus.isApiEnabled()}">
        <%--App Key --%>
        <div class="BlueBox">
            <div class="BlueBoxTitle">
                <fmt:message key='GLOBAL_MENU_YPSERVICE_API_KEY' bundle='${bundle}'/>
            </div>
            <div class="BlueBoxContent">
                <div class="sk-item MarginTop30 TextAlignLeft ">
                    <label class="sk-label fontgreen" style="width:250px;margin-left: -270px">APP Key:</label>
                    <input id="api_app_key_copy_text" type="text" name="api_app_key" class="Input380" style="width:350px;" id="api_allow_ip_list" value="${user.apiAppKey}"/>&nbsp;
                    <input id="api_app_key_copy_link" type="button" value="<fmt:message key='COLLECT_CHECKIN_LABEL_复制' bundle='${bundle}'/>" class="collection_button" style="height:32px"/>
                </div>
            </div>
        </div>

        <%--IP地址过滤列表--%>
        <div class="BlueBox" style="margin-top:30px;">
            <div class="BlueBoxTitle">
                <fmt:message key='GLOBAL_MENU_YPSERVICE_API_IP地址列表' bundle='${bundle}'/>
            </div>
            <%--提示信息开始--%>
            <div class="noticeMessage" style="display:none">
                <div class="successMessage" style="display:none"></div>
                <div class="wrongMessage" style="display:none"></div>
                <div class="loadingMessage" style="display:none"><fmt:message key="GLOBAL_MSG_LOADING" bundle="${bundle}"/><img alt="" src="/images/032.gif"></div>
            </div>
            <c:if test="${!empty successResultDoUpdateAPIAllowIPList}"> 
                <div class="noticeMessage">
                    <div class="successMessage">${successResultDoUpdateAPIAllowIPList}</div>
                </div>
            </c:if>
            <%--提示信息结束--%>
            <div class="BlueBoxContent">
                <form action="/ypservice/api" method="POST">
                    <input type="hidden" name="a" value="UPDATE_API_ALLOW_IP_LIST" />
                    <div class="sk-item MarginTop30 TextAlignLeft ">
                        <label class="sk-label fontgreen" style="width:250px;margin-left: -270px"><fmt:message key="YPSERVICE_API_允许访问的IP地址" bundle="${bundle}"/></label>
                        <input type="text" name="api_allow_ip_list" class="Input450" id="api_allow_ip_list" value="${user.apiAllowIpList}"/> 
                    </div>
                    <div class="sk-item">
                        <label class="sk-label"></label>
                        <span style="float:left;font-size:12px;color:silver"><fmt:message key='YPSERVICE_API_允许访问的IP地址说明' bundle='${bundle}'/> </span>
                        <input type="submit" value="<fmt:message key='GLOBAL_保存' bundle='${bundle}'/>" class="collection_button"/>
                    </div>
                </form>
            </div>
        </div>

        <%--应用回调URL--%>
        <div class="BlueBox" style="margin-top:30px;">
            <div class="BlueBoxTitle">
                <fmt:message key='GLOBAL_MENU_YPSERVICE_API_回调URL' bundle='${bundle}'/>  
            </div>
            <%--提示信息开始--%>
            <div class="noticeMessage" style="display:none">
                <div class="successMessage" style="display:none"></div>
                <div class="wrongMessage" style="display:none"></div>
                <div class="loadingMessage" style="display:none"><fmt:message key="GLOBAL_MSG_LOADING" bundle="${bundle}"/><img alt="" src="/images/032.gif"></div>
            </div>
            <c:if test="${!empty successResultDoUpdateAPIReturnUrl}"> 
                <div class="noticeMessage">
                    <div class="successMessage">${successResultDoUpdateAPIReturnUrl}</div>
                </div>
            </c:if>
            <%--提示信息结束--%>
            <div class="BlueBoxContent">
                <form action="/ypservice/api" method="POST">
                    <input type="hidden" name="a" value="UPDATE_API_RETURN_URL" />
                    <div class="sk-item MarginTop30 TextAlignLeft ">
                        <label class="sk-label fontgreen"><fmt:message key="YPSERVICE_API_浏览器回调URL" bundle="${bundle}"/></label>
                        <input type="text" name="api_return_url" class="Input450" id="api_return_url" value="${user.apiReturnUrl}"/>
                    </div>
                    <div class="sk-item">
                        <label class="sk-label"></label>
                        <span style="float:left;font-size:12px;color:silver"><fmt:message key='YPSERVICE_API_浏览器回调URL说明' bundle='${bundle}'/> </span>
                    </div>
                    <div class="sk-item  TextAlignLeft ">
                        <label class="sk-label fontgreen"><fmt:message key="YPSERVICE_API_应用通知URL" bundle="${bundle}"/></label>
                        <input type="text" name="api_notify_url" class="Input450" id="api_notify_url" value="${user.apiNotifyUrl}"/> 
                    </div>
                    <div class="sk-item">
                        <label class="sk-label"></label>
                        <span style="float:left;font-size:12px;color:silver"><fmt:message key='YPSERVICE_API_应用通知URL说明' bundle='${bundle}'/> </span>
                        <input type="submit" value="<fmt:message key='GLOBAL_保存' bundle='${bundle}'/>" class="collection_button"/>
                    </div>
                </form>
            </div>
        </div>

        <%--提供发票信息 --%>
        <div class="BlueBox" style="margin-top:30px;">
            <div class="BlueBoxTitle">
                <fmt:message key="COLLECT_EDIT_LABEL_提供发票" bundle="${bundle}"/>
            </div>
            <%--提示信息开始--%>
            <div class="noticeMessage" style="display:none">
                <div class="successMessage" style="display:none"></div>
                <div class="wrongMessage" style="display:none"></div>
                <div class="loadingMessage" style="display:none"><fmt:message key="GLOBAL_MSG_LOADING" bundle="${bundle}"/><img alt="" src="/images/032.gif"></div>
            </div>
            <c:if test="${!empty successResultDoUpdateAPIInvoiceProvider}"> 
                <div class="noticeMessage">
                    <div class="successMessage">${successResultDoUpdateAPIInvoiceProvider}</div>
                </div>
            </c:if>
            <%--提示信息结束--%>
            <div class="BlueBoxContent">
                <form action="/ypservice/api" method="POST">
                    <input type="hidden" name="a" value="UPDATE_API_INVOICE_PROVIDER" />
                    <div class="sk-item MarginTop30 TextAlignLeft ">
                        <input type="checkbox" name="api_invoice_provider" id="hostInvoiceFaPiao" onclick="invoiceFaPiao.invoiceProviderOnclick();" value="HOST" <c:if test="${user.apiInvoiceProvider == 'HOST'}">checked="checked"</c:if>/>
                        <label class="fontgreen"><fmt:message key="COLLECT_EDIT_TEXT_我会为参会者提供发票" bundle="${bundle}"/></label>

                    </div>
                    <div class="sk-item  TextAlignLeft ">
                        <input type="checkbox" name="api_invoice_provider" id="letYoopayInvoiceFaPiao" onclick="invoiceFaPiao.open('letYoopayInvoiceFaPiao');" value="YOOPAY" <c:if test="${user.apiInvoiceProvider == 'YOOPAY'}">checked="checked"</c:if>/>
                        <label class="fontgreen"><fmt:message key="COLLECT_EDIT_TEXT_由友付代开发票" bundle="${bundle}"/></label>
                    </div>
                    <div class="sk-item">
                        <input type="submit" value="<fmt:message key='GLOBAL_保存' bundle='${bundle}'/>" class="collection_button"/>
                    </div>
                </form>
            </div>
        </div>

        <%--上传Banner--%>
        <div class="BlueBox" style="margin-top:30px;">
            <div class="BlueBoxTitle">
                <fmt:message key="YPSERVICE_API_上传BANNER" bundle="${bundle}"/>
            </div>
            <%--提示信息开始--%>
            <div class="noticeMessage" style="display:none">
                <div class="successMessage" style="display:none"></div>
                <div class="wrongMessage" style="display:none"></div>
                <div class="loadingMessage" style="display:none"><fmt:message key="GLOBAL_MSG_LOADING" bundle="${bundle}"/><img alt="" src="/images/032.gif"></div>
            </div>
            <c:if test="${!empty successResultDoUploadAPIBanner}"> 
                <div class="noticeMessage">
                    <div class="successMessage">${successResultDoUploadAPIBanner}</div>
                </div>
            </c:if>
            <%--提示信息结束--%>
            <div class="BlueBoxContent">
                <form enctype="multipart/form-data" action="/ypservice/api" method="POST">
                    <input type="hidden" name="a" value="UPLOAD_API_BANNER" />
                    <div class="sk-item MarginTop30 TextAlignLeft ">
                        <label class="sk-label fontgreen"><fmt:message key="YPSERVICE_API_LABEL_上传BANNER" bundle="${bundle}"/></label>
                        <input type="file" name="api_banner" class="MarginL7"/>
                        <c:if test="${not empty user && user.apiBanner != null}">
                            <%--查看--%>
                            <a id="api_banner_del1" href="${user.apiBanner}" class=" " target="_blank"><fmt:message key="YPSERVICE_API_LABEL_查看" bundle="${bundle}"/></a>
                            &nbsp;|&nbsp;
                            <%--删除--%>
                            <a id="api_banner_del2" href="javascript:void(0)" onclick = "APIChargeOrder.delImage('${user.id}','api_banner','api_banner_del1','api_banner_del2')"><fmt:message key="COLLECT_EDIT_TEXT_删除" bundle="${bundle}"/></a>
                        </c:if>
                        <br/><span style="float:left;font-size:12px;color:silver"><fmt:message key='YPSERVICE_API_LABEL_上传BANNER说明' bundle='${bundle}'/></span><br/>
                    </div>
                    <div class="sk-item TextAlignLeft ">
                        <input type="checkbox" name="api_show_logo" value="true" <c:if test="${user.apiShowLogo == null || user.apiShowLogo}">checked="checked"</c:if> />
                        <label class="fontgreen"><fmt:message key="YPSERVICE_API_LABEL_显示logo" bundle="${bundle}"/></label>
                    </div>
                    <div class="sk-item">
                        <input type="submit" value="<fmt:message key='GLOBAL_保存' bundle='${bundle}'/>" class="collection_button"/>
                    </div>
                </form>
            </div>
        </div>
        <div id="invoiceFaPiao" style="display:none;">  
            <div>
                <div class="MarginTop10"><fmt:message key='COLLECT_EDIT_DIALOG_代开发票说明' bundle='${bundle}'/></div>
                <div class="TextAlignRight MarginTop10"><a href="javascript:void(0);" onclick="invoiceFaPiao.close();"><fmt:message key='GLOBAL_取消' bundle='${bundle}'/></a><input type="button" value="<fmt:message key='COLLECT_EDIT_DIALOG_BUTTON_确定' bundle='${bundle}'/>" class="collection_button MarginL7" onclick="invoiceFaPiao.confirm()"/></div>
            </div>
        </div>
        <script type="text/javascript">
            $(document).ready(function(){
                APIChargeOrder.initTextCopy();
            });
        </script>
    </c:when>
</c:choose>
<jsp:include page="/WEB-INF/public/z_footer.jsp"/> 
<%@include file="/WEB-INF/public/z_footer_close.html" %> 
