<%-- 
    Document   : 创建或编辑收款模版
    Created on : Mar 27, 2012, 4:33:00 PM
    Author     : Swang
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page import="cn.yoopay.Config"%>
<%--收款链接URL PATH和表单Action--%>
<c:choose>
    <c:when test="${collectionType=='EVENT'||fundCollection.type=='EVENT'}">
        <c:set var="payLinkVal" value="event"></c:set>
        <c:set var="form_action" value="/collect/create/event" scope="page"></c:set>
    </c:when>
    <c:when test="${collectionType=='SERVICE'||fundCollection.type=='SERVICE'}">
        <c:set var="payLinkVal" value="service"></c:set>
        <c:set var="form_action" value="/collect/create/service" scope="page"></c:set>
    </c:when>
    <c:when test="${collectionType=='PRODUCT'||fundCollection.type=='PRODUCT'}">
        <c:set var="payLinkVal" value="product"></c:set>
        <c:set var="form_action" value="/collect/create/product" scope="page"></c:set>
    </c:when>
    <c:when test="${collectionType=='MEMBER'||fundCollection.type=='MEMBER'}">
        <c:set var="payLinkVal" value="membership"></c:set>
        <c:set var="form_action" value="/collect/create/member" scope="page"></c:set>
    </c:when>
    <c:when test="${collectionType=='DONATION'||fundCollection.type=='DONATION'}">
        <c:set var="payLinkVal" value="donation"></c:set>
        <c:set var="form_action" value="/collect/create/donation" scope="page"></c:set>
    </c:when>
</c:choose>
<c:if test="${not empty fundCollection && !useTemplate}">
    <c:set var="form_action" value="/collect/edit/${fundCollection.webId}"></c:set>
</c:if>
<c:if test="${not empty fundCollection}">
    <c:set var="collectionType" value="${fundCollection.type}"></c:set>
</c:if>

<c:set var="hiddenPriceCount" value="0"></c:set>
<%--表单 --%>
<div>
    <form action="${form_action}<c:if test="${templateWebId != null}">?templateWebId=${templateWebId}</c:if>" method="POST" enctype="multipart/form-data" id="collection_create_or_edit_form">
        <input type="hidden" name="a" value="create_update" />
        <input type="hidden" name="use_template" value="${useTemplate == null ? false : useTemplate}" />

        <input id="fundCollection_webId" type="hidden" name="webId" value="${fundCollection.webId}" />
        <div id="collection_inputs_div">
            <%--依据收款类别，显示不同表单域--%>
            <c:choose>
                <c:when test="${collectionType=='DONATION'}">
                    <%--募捐收款 --%>
                    <%@include file="/WEB-INF/collect/z_collect_donation.jsp" %>
                </c:when>
                <c:otherwise>
                    <%--活动、服务、产品、会员费收款 --%>
                    <%@include file="/WEB-INF/collect/z_collect_event_service_product_member.jsp" %>
                </c:otherwise>
            </c:choose>
        </div>
        <div>
            <%--公共信息 （收款方式 其它选项 详细说明）--%>
            <c:if test="${serviceStatus != null}">
                <dl class="dlEdit">
                    <dt><fmt:message key="COLLECT_EDIT_LABEL_收款方式" bundle="${bundle}"/></dt>
                    <dd class="left">
                        <div class="sk-item-edit TextAlignLeft">
                            <label class="sk-label-edit "></label>
                            <div id="collect_paygate_type_container">
                                <input type="checkbox" class="shortInput" name="allow_paygate_type" value="CHINABANK" 
                                       <c:if test="${empty fundCollection || fn:containsIgnoreCase(fundCollection.allowPayGateType, 'CHINABANK')}">checked="checked"</c:if>
                                />
                                <fmt:message key="COLLECT_EDIT_LABEL_银联" bundle="${bundle}"/><img src="/images/collect_alipay.png" width="147" height="33"/><br/>
                                <input type="checkbox" class="shortInput" name="allow_paygate_type" value="BANK_TRANSFER"
                                       <c:if test="${empty fundCollection || fn:containsIgnoreCase(fundCollection.allowPayGateType, 'BANK_TRANSFER')}">checked="checked"</c:if>
                                />
                                <fmt:message key="COLLECT_EDIT_LABEL_银行汇款" bundle="${bundle}"/><br/>
                                <%--
                                <input type="checkbox" class="shortInput" name="allow_paygate_type" value="ALIPAY"
                                       <c:choose>
                                           <c:when test="${serviceStatus.alipayEnabled}"> checked="checked"</c:when>
                                           <c:otherwise> onclick="allowPayGateDialog.open('alipay',this);"</c:otherwise>
                                       </c:choose>
                                       />
                                <fmt:message key="COLLECT_EDIT_LABEL_支付宝" bundle="${bundle}"/><img src="/images/collect_alipay.png" width="147" height="33"/><br/>
                                --%>
                                <%-- --%>
                                <%--Visa/MC/Paypal --%>
                                <input type="checkbox" class="shortInput" name="allow_paygate_type" value="PAYPAL_CREDITCARD_VISA,PAYPAL_CREDITCARD_MASTERCARD,PAYPAL"
                                       <c:choose>
                                    <c:when test="${not empty fundCollection}">
                                        <%--Edit --%>
                                        <c:choose>
                                            <c:when test="${fn:containsIgnoreCase(fundCollection.allowPayGateType, 'PAYPAL_CREDITCARD_VISA')}">checked="checked"</c:when>
                                            <c:when test="${!serviceStatus.visaEnabled || !serviceStatus.mastercardEnabled || !serviceStatus.paypalEnabled}"> onclick="allowPayGateDialog.open('visa',this);"</c:when>
                                        </c:choose>
                                    </c:when>
                                    <c:when test="${serviceStatus.visaEnabled && serviceStatus.mastercardEnabled && serviceStatus.paypalEnabled}"> checked="checked"</c:when>
                                    <c:otherwise> onclick="allowPayGateDialog.open('visa',this);"</c:otherwise>
                                </c:choose>
                                />
                                Visa, MasterCard, Paypal<img src="/images/collect_visa.png" width="180" height="33"/><br/>
                                <%--BankTransfer --%>
                                <input type="hidden" name="allow_paygate_type" value="BALANCE" />    
                                <%--
                                <input type="checkbox" class="shortInput" name="allow_paygate_type" value="BALANCE"
                                       <c:choose>
                                           <c:when test="${serviceStatus.accountBalanceEnabled}"> checked="checked"</c:when>
                                           <c:otherwise> onclick="allowPayGateDialog.open('balance',this);"</c:otherwise>
                                       </c:choose>
                                       />
                                <fmt:message key="COLLECT_EDIT_LABEL_友付余额" bundle="${bundle}"/><br/> --%>
                            </div>
                        </div>
                    </dd>
                    <dd class="right">
                    <fmt:message key="COLLECT_EDIT_TEXT_付款人可以使用的付款方式" bundle="${bundle}"/>
                    </dd> 
                    <div class="clear"></div>
                </dl>
            </c:if>
            <%--发票服务 --%>
            <dl class="dlEdit"><dt><fmt:message key="COLLECT_EDIT_LABEL_提供发票" bundle="${bundle}"/> </dt>
                <dd class="left">
                    <div class="sk-item-edit TextAlignLeft">
                        <label class="sk-label-edit "></label>
                        <span class="FloatLeft shortInput">
                            <input type="checkbox" id="hostInvoiceFaPiao" name="invoice_provider" value="host" onclick="invoiceFaPiao.invoiceProviderOnclick()" <c:if test="${fundCollection.invoiceProvider == 'HOST'}">checked="checked"</c:if> />
                            <c:choose>
                                <c:when test="${collectionType=='EVENT'}">
                                    <fmt:message key="COLLECT_EDIT_TEXT_我会为参会者提供发票" bundle="${bundle}"/>
                                </c:when>
                                <c:otherwise>
                                    <fmt:message key="COLLECT_EDIT_TEXT_我会为订购者提供发票" bundle="${bundle}"/>
                                </c:otherwise>
                            </c:choose>
                        </span><br/>
                        <span class="FloatLeft shortInput">
                            <input type="checkbox" id="letYoopayInvoiceFaPiao" name="invoice_provider" value="yoopay" onclick="invoiceFaPiao.open('letYoopayInvoiceFaPiao');" <c:if test="${fundCollection.invoiceProvider == 'YOOPAY'}">checked="checked"</c:if> />
                            <fmt:message key="COLLECT_EDIT_TEXT_由友付代开发票" bundle="${bundle}"/>
                        </span>
                        <c:if test="${collectionType == 'EVENT'}">
                            <br class="clear"/>
                        </c:if>
                    </div>
                </dd>
                <dd class="right">
                <fmt:message key="COLLECT_EDIT_TEXT_发票服务信息" bundle="${bundle}" />
                </dd>
            </dl>
            <%--活动收款页面样式 --%>
            <c:if test="${collectionType=='EVENT'}">
                <dl class="dlEdit"><dt><fmt:message key="COLLECT_EDIT_LABEL_样式选择" bundle="${bundle}"/> </dt>
                    <dd class="left">
                        <div class="sk-item-edit TextAlignLeft">
                            <label class="sk-label-edit "></label>
                            <ul class="SkinIcon">
                                <c:set var="style_selection" value="CUSTOMIZED"></c:set>
                                <c:choose>
                                    <c:when test="${empty fundCollection.eventStyle}"> <c:set var="style_selection" value="CLASSIC_WHITE"></c:set></c:when>
                                    <c:when test="${fundCollection.eventStyle=='CLASSIC_WHITE'}"> <c:set var="style_selection" value="CLASSIC_WHITE"></c:set></c:when>
                                    <c:when test="${fundCollection.eventStyle=='CLASSIC_BLACK'}"> <c:set var="style_selection" value="CLASSIC_BLACK"></c:set></c:when>
                                    <c:when test="${fundCollection.eventStyle=='CLASSIC_BLUE'}"> <c:set var="style_selection" value="CLASSIC_BLUE"></c:set></c:when>
                                    <c:when test="${fundCollection.eventStyle=='CLASSIC_GREEN'}"> <c:set var="style_selection" value="CLASSIC_GREEN"></c:set></c:when>
                                    <c:when test="${fundCollection.eventStyle=='CLASSIC_PURPLE'}"> <c:set var="style_selection" value="CLASSIC_PURPLE"></c:set></c:when>
                                    <c:when test="${fundCollection.eventStyle=='CLASSIC_SILVER'}"> <c:set var="style_selection" value="CLASSIC_SILVER"></c:set></c:when>
                                    <c:when test="${fundCollection.eventStyle=='CLASSIC_ORANGE'}"> <c:set var="style_selection" value="CLASSIC_ORANGE"></c:set></c:when>
                                    <c:otherwise> <c:set var="style_selection" value="CUSTOMIZED"></c:set></c:otherwise>
                                </c:choose>
                                <li><p><input name="eventStyle" type="radio" value="CLASSIC_WHITE" <c:if test="${style_selection=='CLASSIC_WHITE'}">checked="true"</c:if> /><fmt:message key="COLLECT_EDIT_LABEL_经典白" bundle="${bundle}"/></p></li>
                                <li class="SkinBlack"><p><input name="eventStyle" type="radio" value="CLASSIC_BLACK" <c:if test="${style_selection=='CLASSIC_BLACK'}">checked="true"</c:if> /> <fmt:message key="COLLECT_EDIT_LABEL_经典黑" bundle="${bundle}"/></p></li>
                                <li class="SkinOrange"><p><input name="eventStyle" type="radio" value="CLASSIC_ORANGE" <c:if test="${style_selection=='CLASSIC_ORANGE'}">checked="true"</c:if> /> <fmt:message key="COLLECT_EDIT_LABEL_经典橙" bundle="${bundle}"/></p></li>
                                <li class="SkinGreen"><p><input name="eventStyle" type="radio" value="CLASSIC_GREEN" <c:if test="${style_selection=='CLASSIC_GREEN'}">checked="true"</c:if> /> <fmt:message key="COLLECT_EDIT_LABEL_经典绿" bundle="${bundle}"/></p></li>
                                <li class="SkinBlue"><p><input name="eventStyle" type="radio" value="CLASSIC_BLUE" <c:if test="${style_selection=='CLASSIC_BLUE'}">checked="true"</c:if> /> <fmt:message key="COLLECT_EDIT_LABEL_经典蓝" bundle="${bundle}"/></p></li>
                                <li class="SkinPurple"><p><input name="eventStyle" type="radio" value="CLASSIC_PURPLE" <c:if test="${style_selection=='CLASSIC_PURPLE'}">checked="true"</c:if> /> <fmt:message key="COLLECT_EDIT_LABEL_经典紫" bundle="${bundle}"/></p></li>
                                <li class="SkinSilver"><p><input name="eventStyle" type="radio" value="CLASSIC_SILVER" <c:if test="${style_selection=='CLASSIC_SILVER'}">checked="true"</c:if> /> <fmt:message key="COLLECT_EDIT_LABEL_经典银" bundle="${bundle}"/></p></li>
                                <c:if test="${style_selection=='CUSTOMIZED'}">
                                    <li class="SkinCustomized"><p><input name="eventStyle" type="radio" value="${fundCollection.eventStyle}" checked="true" /> <fmt:message key="COLLECT_EDIT_LABEL_定制" bundle="${bundle}"/></p></li>
                                </c:if>

                            </ul>

                        </div>

                    </dd>
                    <dd class="right"><fmt:message key="COLLECT_EDIT_TEXT_请选择活动页面的样式" bundle="${bundle}"/></dd>
                    <div class="clear"></div> 
                </dl>  
            </c:if>
            <%--报名信息收集 --%>
            <dl class="dlEdit"><dt><fmt:message key="COLLECT_EDIT_LABEL_报名信息" bundle="${bundle}"/> </dt>
                <dd class="left">
                    <div class="sk-item-edit TextAlignLeft">
                        <label class="sk-label-edit "></label>
                        <span class="FloatLeft shortInput">
                            <input type="checkbox" id="payer_input_required_cb" onclick="CollectDIY.toggleAllCB(this)" <c:if test="${fundCollection.payerWorkInfoRequired}">checked="true"</c:if>/><fmt:message key="COLLECT_EDIT_DIY_报名时必须填信息" bundle="${bundle}"/> &nbsp; 
                            <c:if test="${collectionType == 'EVENT'}">
                                <a href="javascript:CollectDIY.showAddOptionDialog();"><fmt:message key="COLLECT_EDIT_DIY_+添加更多信息" bundle="${bundle}"/></a>
                            </c:if>
                        </span>
                        <div class="clear"></div>
                        <div id="payer_input_div" style="margin-left:25px">
                            <c:if test="${collectionType=='EVENT'}">
                                <div class="TextAlignLeft">
                                    <input type="radio" name="collect_each_attendee_info" value="false" <c:if test="${fundCollection==null || !fundCollection.collectEachAttendeeInfo}">checked="true"</c:if>/><fmt:message key="COLLECT_CREATE_EDIT_LABEL_只搜集订票者的信息" bundle="${bundle}"/>
                                    <input type="radio" name="collect_each_attendee_info" value="true" <c:if test="${fundCollection!=null && fundCollection.collectEachAttendeeInfo}">checked="true"</c:if>/><fmt:message key="COLLECT_CREATE_EDIT_LABEL_搜集每位参会者的信息" bundle="${bundle}"/>
                                </div>
                            </c:if>
                            <div class="TextAlignLeft">
                                <input type="checkbox" name="payer_input_basic_required" value="true" checked="true"/><fmt:message key="COLLECT_EDIT_DIY_个人信息：姓名、电子邮件" bundle="${bundle}"/>
                            </div>
                            <div class="TextAlignLeft">
                                <input type="checkbox" name="payer_input_mobile_required" value="true" <c:if test="${empty fundCollection.payerMobileInfoRequired || fundCollection.payerMobileInfoRequired}">checked="true"</c:if>/><fmt:message key="COLLECT_EDIT_DIY_个人信息：手机号码" bundle="${bundle}"/>
                            </div>
                            <div class="TextAlignLeft">
                                <input type="checkbox" name="payer_input_work_required" value="true" <c:if test="${fundCollection.payerWorkInfoRequired}">checked="true"</c:if>/><fmt:message key="COLLECT_EDIT_DIY_职业信息：公司、职务" bundle="${bundle}"/>
                            </div>
                            <div id="payer_input_diy_div">
                                <%--自定义其他选项信息--%>
                                <c:forEach items="${registerQuestionList}" var="registerQuestion" varStatus="status">
                                    <div class="collect_diy_option  TextAlignLeft">

                                        <span class="hidden_input_container FloatLeft">
                                            <%--输出自定义注册问题基础信息--%>
                                            <input type="hidden" name="register_question[${status.index}].id" value="${registerQuestion.id}" />
                                            <input type="hidden" name="register_question[${status.index}].title" value="${registerQuestion.title}" />
                                            <input type="hidden" name="register_question[${status.index}].type" value="${registerQuestion.type}" />
                                            <%--输出自定义注册问题price信息--%>
                                            <c:set var="noDeletedStatus" value="0" />
                                            <c:forEach items="${registerQuestion.registerQuestionPriceList}" var="registerQuestionPrice" varStatus="subStatus">
                                                <c:if test="${!registerQuestionPrice.deleted}">
                                                    <input type="hidden" name="register_question[${status.index}].register_question_price_list[${noDeletedStatus}].related_price_index" value="${registerQuestionPrice.fundCollectionPrice == null ? null:registerQuestionPrice.fundCollectionPrice.order}" />
                                                    <input type="hidden" name="register_question[${status.index}].register_question_price_list[${noDeletedStatus}].price_id" value="${registerQuestionPrice.fundCollectionPrice == null ? null:registerQuestionPrice.fundCollectionPrice.id}" />
                                                    <c:set var="noDeletedStatus" value="${noDeletedStatus+1}" />
                                                </c:if>
                                            </c:forEach>
                                            <c:if test="${registerQuestion.type=='AGREEMENT'}">
                                                <input type="hidden" name="register_question[${status.index}].agreement_text" value="${registerQuestion.agreementText}" />
                                            </c:if>
                                            <%--输出自定义注册问题答案列表--%>
                                            <c:if test="${registerQuestion.type=='SELECTION_CHECK_BOX' || registerQuestion.type=='SELECTION_DROPDOWN_LIST' || registerQuestion.type=='SELECTION_RADIO_BUTTON'}">
                                                <c:set var="noDeletedStatus" value="0" />
                                                <c:forEach items="${registerQuestion.registerQuestionOptionList}" var="registerQuestionOption" varStatus="subStatus">
                                                    <c:if test="${!registerQuestionOption.deleted}">
                                                        <input type="hidden" name="register_question[${status.index}].register_question_option_list[${noDeletedStatus}].id" value="${registerQuestionOption.id}" />
                                                        <input type="hidden" name="register_question[${status.index}].register_question_option_list[${noDeletedStatus}].option_title" value="${registerQuestionOption.optionTitle}" />
                                                        <input type="hidden" name="register_question[${status.index}].register_question_option_list[${noDeletedStatus}].deleted" value="${registerQuestionOption.deleted}" />
                                                        <c:set var="noDeletedStatus" value="${noDeletedStatus+1}" />
                                                    </c:if>
                                                </c:forEach>
                                            </c:if>
                                            <input type="checkbox" name="register_question[${status.index}].required" value="true" <c:if test="${registerQuestion.required}">checked="true"</c:if>/>
                                            <span class="diy_title">${registerQuestion.title}</span>
                                            <span class="collect_diy_option_edit_span"><a href="javascript:void(0)" onclick="CollectDIY.loadOptionForEdit(${status.index});"><fmt:message key="GLOBAL_编辑" bundle="${bundle}"/></a></span>
                                            <span class="collect_diy_option_del_span"><a href="javascript:void(0)" onclick="CollectDIY.doDelOption(${status.index});"><fmt:message key="GLOBAL_删除" bundle="${bundle}"/></a></span>

                                        </span>
                                        <div class="clear"></div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                        <div class="clear"></div>
                        <hr class="sk-item-edit-hr"/>
                    </div>
                <c:if test="${collectionType == 'EVENT'}">
                    <%--支付页面是否显示已报名人信息 --%>
                    <div class="sk-item-edit TextAlignLeft">
                        <label class="sk-label-edit"></label>  
                        <span class="shortInput">
                            <input value="true" name="show_attendee_list" id="showAttendeeList" type="checkbox" 
                                   <c:if test="${fundCollection.showAttendeeList}">checked="checked"</c:if>
                            onclick="FundCollection.toggleAttendeeListOption();" /><fmt:message key="COLLECT_CREATE_EVENT_LABEL_显示报名人信息" bundle="${bundle}"/>
                        </span> 
                        <div style="margin-left:25px;<c:if test="${!fundCollection.showAttendeeList}">display:none</c:if>" id="attendee_list_options_container">
                            <input value="true" name="show_attendee_name" id="showName" type="checkbox"
                                   <c:if test="${fundCollection.showAttendeeList && fundCollection.eventAttendeeListOption.showName}">checked="checked"</c:if> /><fmt:message key="COLLECT_CREATE_EVENT_LABEL_姓名" bundle="${bundle}"/><br/>
                            <input value="true" name="show_attendee_company" id="showCompany" type="checkbox"
                                   <c:if test="${fundCollection.showAttendeeList && fundCollection.eventAttendeeListOption.showCompany}">checked="checked"</c:if> /><fmt:message key="COLLECT_CREATE_EVENT_LABEL_公司" bundle="${bundle}"/><br/>
                            <input value="true" name="show_attendee_position" id="showPosition" type="checkbox"
                                   <c:if test="${fundCollection.showAttendeeList && fundCollection.eventAttendeeListOption.showPosition}">checked="checked"</c:if> /><fmt:message key="COLLECT_CREATE_EVENT_LABEL_职务" bundle="${bundle}"/><br/>
                            <input value="true" name="show_attendee_ticket_order" id="showTicketOrder" type="checkbox"
                                   <c:if test="${fundCollection.showAttendeeList && fundCollection.eventAttendeeListOption.showTicketOrder}">checked="checked"</c:if>  /><fmt:message key="COLLECT_CREATE_EVENT_LABEL_购票信息" bundle="${bundle}"/>
                            <c:forEach items="${registerQuestionList}" var="registerQuestion" varStatus="status">
                                <c:if test="${registerQuestion.type!='AGREEMENT'}">
                                    <div>
                                        <input type="checkbox" name="register_question[${status.index}].show_on_attendee_list" value="true" <c:if test="${registerQuestion.showOnAttendeeList}">checked="checked"</c:if>/>
                                        <span>${registerQuestion.title}</span>
                                    </div>
                                </c:if>
                            </c:forEach>
                        </div>
                        <br class="clear"/>
                    </div>
                </c:if>
                </dd>
                <dd class="right">
                <c:choose>
                    <c:when test="${collectionType == 'EVENT'}">
                        <fmt:message key="COLLECT_EDIT_TEXT_活动报名信息" bundle="${bundle}" />
                    </c:when>
                    <c:otherwise>
                        <fmt:message key="COLLECT_EDIT_TEXT_报名信息" bundle="${bundle}" />
                    </c:otherwise>
                </c:choose>
                </dd>
            </dl>

            <%--门票订制 --%>                    
            <c:if test="${collectionType == 'EVENT'}">
                <dl class="dlEdit" style="margin-bottom: 0px;">
                    <dt><fmt:message key="COLLECT_EDIT_LABEL_门票订制" bundle="${bundle}"/>&nbsp;</dt>
                    <dd class="left">
                        <div class="sk-item-edit TextAlignLeft" >
                            <fmt:message key="COLLECT_EDIT_使用自己的logo" bundle="${bundle}" />
                            <input type="file" name="ticket_custom_logo" style="width:200px" 
                                   <c:if test="${!serviceStatus.customTicketEnabled}">onclick="TicketCustomServiceDialog.open();return false;"</c:if>
                            />
                            <c:if test="${fundCollection.getTicketCustomLogoUrl()!=null}">
                                <a id="custom_ticket_logo_del1" href="${fundCollection.getTicketCustomLogoUrl()}" class="MarginL7 " target="_blank"><fmt:message key="COLLECT_EDIT_查看门票自定义Logo" bundle="${bundle}"/></a> 
                                <a id="custom_ticket_logo_del2" href="javascript:void(0)" onclick = "CollectionEventUpload.del('${fundCollection.webId}','event_custom_ticket_logo','custom_ticket_logo_del1','custom_ticket_logo_del2')">
                                    <fmt:message key="COLLECT_EDIT_TEXT_删除" bundle="${bundle}"/>
                                </a>
                            </c:if>
                        </div>

                    </dd>
                    <dd class="right">
                    <fmt:message key="COLLECT_EDIT_TEXT_门票订制说明" bundle="${bundle}" />
                    </dd>
                    <div class="clear"></div>
                </dl>
                <dl>
                    <dd>
                        <div class="sk-item-edit TextAlignLeft" >
                            <fmt:message key="COLLECT_EDIT_自定义门票通知信的内容" bundle="${bundle}" />&nbsp;&nbsp;
                            <span id="custom_ticket_content_btn">
                                <a href="javascript:void(0);" id="custom_ticket_content_link" 
                                   <c:choose>
                                        <c:when test="${serviceStatus.customTicketEnabled}">onclick="FundCollection.toggleTicketCustomContainer();"</c:when>
                                        <c:otherwise>onclick="TicketCustomServiceDialog.open();"</c:otherwise>
                                    </c:choose>
                                    >
                                    <fmt:message key="GLOBAL_编辑" bundle="${bundle}" />
                                </a>
                            </span>
                            <div id="custom_ticket_content_tabs" style="display:none">
                                <ul style="font-size:12px">
                                    <li><a href="#custom_ticket_content_tabs1"><fmt:message key="COLLECT_EDIT_中文版" bundle="${bundle}" /></a></li>
                                    <li><a href="#custom_ticket_content_tabs2"><fmt:message key="COLLECT_EDIT_英文版" bundle="${bundle}" /></a></li>  
                                </ul>
                                <div id="custom_ticket_content_tabs1" style="padding:0px;margin: 0px;">
                                    <p>
                                        <b><fmt:message key="COLLECT_EDIT_TEXT_门票通知信主题" bundle="${bundle}" /></b>
                                        <input name="ticket_custom_zh_subject" type="text" value="${fundCollection.ticketCustomZhSubject}" style="width:632px"/>
                                        <br />
                                        <textarea name="ticket_custom_zh_content" id="ticket_custom_zh_content" style="width:800px;height:500px" >${fundCollection.ticketCustomZhContent}</textarea>
                                    </p>
                                </div>
                                <div id="custom_ticket_content_tabs2" style="padding:0px;margin: 0px;">
                                    <p>
                                        <b><fmt:message key="COLLECT_EDIT_TEXT_门票通知信主题" bundle="${bundle}" /></b>
                                        <input name="ticket_custom_en_subject" type="text" value="${fundCollection.ticketCustomEnSubject}" style="width:632px"/>
                                        <br />
                                        <textarea name="ticket_custom_en_content" id="ticket_custom_en_content" style="width:800px;height:500px" >${fundCollection.ticketCustomEnContent}</textarea>
                                    </p>
                                </div>
                            </div>
                        </div>
                    </dd>
                </dl>
                <%--定制门票背景--%>
                <dl class="dlEdit" style="margin-top: 20px;">
                    <dd class="left">
                        <div class="sk-item-edit TextAlignLeft" style="line-height:22px;">
                            <label class="sk-label-edit"></label>
                            <fmt:message key="COLLECT_EDIT_定制门票背景" bundle="${bundle}" /><br/>
                            　<fmt:message key="COLLECT_EDIT_默认背景" bundle="${bundle}" />
                            <input type="hidden" id="fund_collection_default_ticket_poster_image_url" name="fund_collection_default_ticket_poster_image_url" value="<c:if test="${fundCollection.getDefaultTicketPosterImageUrl()!=null}">${fundCollection.getDefaultTicketPosterImageUrl()}</c:if>" />
                            <a href="javascript:void(0)" 
                               <c:choose>
                                    <c:when test="${serviceStatus.customTicketEnabled}">onclick="FundCollectionTicketDiy.showDefaultTicketPosterImageDialog()"</c:when>
                                    <c:otherwise>onclick="TicketCustomServiceDialog.open()"</c:otherwise>
                                </c:choose>
                                ><fmt:message key="GLOBAL_编辑" bundle="${bundle}" /></a><br/>
                            　<fmt:message key="COLLECT_EDIT_门票背景" bundle="${bundle}" />
                            <a href=
                               <c:choose>
                                <c:when test="${serviceStatus.customTicketEnabled}">"javascript:FundCollectionTicketDiy.showAddTicketPosterImageDialog();"</c:when>
                                <c:otherwise>"javascript:TicketCustomServiceDialog.open();"</c:otherwise>
                                </c:choose>
                                ><fmt:message key="COLLECT_EDIT_添加票种自定义的门票海报图片" bundle="${bundle}"/></a>　　<%--<span class="MarginL7 " id="contain_invalid_ticket_poster_image" <c:if test="${containInvalidTicketPosterImage == null || !containInvalidTicketPosterImage}">style="display:none"</c:if>><a href="javascript:FundCollectionTicketDiy.deleteAllTicketPosterImage();"><fmt:message key="COLLECT_EDIT_删除所有无效的" bundle="${bundle}"/></a></span>--%>
                        </div>
                        <div class="clear"></div>
                        <div id="ticket_input_div" style="margin-left:25px">
                            <div id="ticket_input_diy_div_container">
                                <c:set var="index" value="0" />
                                <c:forEach var="price" items="${fundCollectionPriceList}" varStatus="priceStatus">
                                    <c:if test="${price.ticketPosterImageUrl != null}">
                                        <input type="hidden" name="fund_collection_price[${index}].ticket_poster_image_url" value="${price.ticketPosterImageUrl}" />
                                        <input type="hidden" name="fund_collection_price[${index}].ticket_poster_image_name" value="${price.ticketPosterImageName}" />
                                    </c:if>
                                    <c:set var="index" value="${index+1}" />
                                </c:forEach>
                            </div></div>
                        <div id="ticket_input_diy_div" class="collect_diy_ticket sk-item-edit TextAlignLeft" style="line-height:20px;">
                            <label class="sk-label-edit"></label>
                            <%--自定义票种与门票--%>
                            <c:forEach items="${ticketPosterImageList}" var="ticketPosterImage" varStatus="status">
                                <div style="padding-left:30px;">
                                    <span class="collect_diy_ticket">
                                        <input type="hidden" id="ticket_poster_image_url_${status.index}" value="${ticketPosterImage.ticketPosterImageUrl}" />
                                        <input type="hidden" name="fund_payment_ticket_poster_image[${status.index}].ticket_poster_image_name" value="${ticketPosterImage.ticketPosterImageName}" />
                                        <input type="hidden" name="fund_payment_ticket_poster_image[${status.index}].ticket_poster_image_url" value="${ticketPosterImage.ticketPosterImageUrl}" />
                                        <input type="hidden" name="fund_payment_ticket_poster_image[${status.index}].id" value="${ticketPosterImage.id}" />
                                        <input type="hidden" name="fund_payment_ticket_poster_image[${status.index}].deleted" value="${ticketPosterImage.deleted}" />
                                        <%--输出指定的门票背景--%>
                                        <span class="hidden_input_container FloatLeft">
                                            <span class="diy_title">${ticketPosterImage.ticketPosterImageName}</span>
                                            <span class="collect_diy_ticket_edit_span"><a href="javascript:void(0)" onclick="FundCollectionTicketDiy.loadTicketPosterImageForEdit(${status.index},'${ticketPosterImage.ticketPosterImageUrl}','${ticketPosterImage.ticketPosterImageName}');"><fmt:message key="GLOBAL_编辑" bundle="${bundle}"/></a></span>
                                        </span>
                                        <br/>
                                    </span>
                                </div>
                            </c:forEach>
                        </div>
                    </dd>
                    <dd class="right">
                    <fmt:message key="COLLECT_EDIT_门票海报图片说明文字" bundle="${bundle}" />
                    </dd>
                    <div class="clear"></div>
                </dl>
            </c:if>

            <%--其他选项信息--%>
            <c:if test="${collectionType == 'EVENT'}">
                <dl class="dlEdit">
                    <dt><fmt:message key="COLLECT_EDIT_LABEL_其他选项" bundle="${bundle}"/></dt>
                    <dd class="left">
                    <c:if test="${collectionType == 'EVENT'}">
                        <div class="sk-item-edit TextAlignLeft" >
                            <label class="sk-label-edit"></label>  
                            <span class="FloatLeft shortInput">
                                <input type="checkbox" name="searchable" id="searchable" value="true" <c:if test="${empty fundCollection || fundCollection.searchable}">checked="true"</c:if> />
                                <fmt:message key="COLLECT_EDIT_TEXT_此活动允许被搜索" bundle="${bundle}"/>
                            </span>
                            <br class="clear"/>
                            <hr class="sk-item-edit-hr"/>
                        </div>
                        <div class="sk-item-edit TextAlignLeft" >
                            <label class="sk-label-edit"></label>  
                            <span class="FloatLeft shortInput">
                                <input type="checkbox" name="showAtCalendar" id="" value="true" <c:if test="${empty fundCollection || fundCollection.showAtCalendar}">checked="true"</c:if> />
                                <fmt:message key="COLLECT_EDIT_TEXT_此活动收录到日历" bundle="${bundle}"/>
                            </span>
                            <br class="clear"/>
                            <hr class="sk-item-edit-hr"/>
                        </div>
                    </c:if>
                    <c:if test="${collectionType == 'EVENT'}">
                        <div class="sk-item-edit" >
                            <label class="sk-label-edit TextAlignLeft"></label>  
                            <span class="FloatLeft shortInput">
                                <input type="checkbox" name="weiboSharable" id="weiboSharable" value="true" <c:if test="${empty fundCollection || fundCollection.weiboSharable}">checked="true"</c:if> />
                                <fmt:message key="COLLECT_EDIT_TEXT_显示微博分享" bundle="${bundle}"/>
                            </span>
                            <br class="clear"/>
                            <hr class="sk-item-edit-hr"/>
                        </div>
                        <div class="sk-item-edit TextAlignLeft">
                            <label class="sk-label-edit"></label>  
                            <span class="shortInput">
                                <fmt:message key="COLLECT_CREATE_EVENT_LABEL_语言设置" bundle="${bundle}"/>
                            </span> 
                            <span class="shortInput">
                                <input type="radio" name="languageSetting" checked="checked" value="AUTODETECT" <c:if test="${empty fundCollection.eventLanguage || fundCollection.eventLanguage=='AUTODETECT'}">checked="true"</c:if> /><fmt:message key="COLLECT_CREATE_EVENT_LABEL_自动检测" bundle="${bundle}"/>
                                <input type="radio" name="languageSetting" value="CHINESE" <c:if test="${fundCollection.eventLanguage=='CHINESE'}">checked="true"</c:if> /><fmt:message key="COLLECT_CREATE_EVENT_LABEL_强制中文" bundle="${bundle}"/>
                                <input type="radio" name="languageSetting" value="ENGLISH" <c:if test="${fundCollection.eventLanguage=='ENGLISH'}">checked="true"</c:if> /><fmt:message key="COLLECT_CREATE_EVENT_LABEL_强制英文" bundle="${bundle}"/>
                            </span>
                            <br class="clear"/>

                        </div>
                    </c:if>
                    </dd>
                    <dd class="right">
                    <c:choose>
                        <c:when test="${collectionType == 'EVENT'}">
                            <fmt:message key="COLLECT_EDIT_TEXT_其他选项信息活动" bundle="${bundle}" />
                        </c:when>
                        <c:otherwise>
                            <fmt:message key="COLLECT_EDIT_TEXT_其他选项信息" bundle="${bundle}" />
                        </c:otherwise>
                    </c:choose>
                    </dd>
                    <div class="clear"></div>
                </dl>
            </c:if>
            <dl class="dlEdit"><dt></dt></dl>

            <%--提交按钮 --%>
            <dd>
                <div class="sk-item-edit" style="margin-top: 15px">
                    <label class="sk-label-edit"></label>
                    <c:choose>
                        <c:when test="${user.verified}">
                            <c:choose>
                                <c:when test="${not empty fundCollection}">
                                    <c:set var="submitBtnValue">
                                        <fmt:message key="WITHDRAW_ACCOUNT_BUTTON_保存" bundle="${bundle}"/>
                                    </c:set>
                                </c:when>
                                <c:otherwise>
                                    <c:set var="submitBtnValue">
                                        <fmt:message key="COLLECT_EDIT_BUTTON_CREATE" bundle="${bundle}"/>
                                    </c:set>
                                </c:otherwise>
                            </c:choose>
                            <input type="button" id="Submit" name="Submit" value="${submitBtnValue}" class="collection_button FloatRight MarginL7" />
                        </c:when>
                        <c:otherwise>
                            <input type="button" name="Submit" value="<fmt:message key='COLLECT_EDIT_BUTTON_CREATE' bundle='${bundle}'/>" class="collection_button FloatRight MarginL7" onclick="verifyDialog.open();"/>
                        </c:otherwise>
                    </c:choose>
                    <div id="public_message">
                        <div class="noticeMessage FloatRight">
                            <div class="successMessage" style="display:none"></div>
                            <div class="wrongMessage" style="display:none"></div>
                            <div class="loadingMessage" style="display:none"><fmt:message key="GLOBAL_MSG_LOADING" bundle="${bundle}"/><img alt="" src="/images/032.gif"></div>
                        </div>
                    </div>
                    <c:if test="${collectionType=='EVENT'||fundCollection.type=='EVENT'}">
                        <span class="FloatRight">
                            <input type="checkbox" name="template" value="true" <c:if test="${fundCollection.template}">checked="checked"</c:if>/><fmt:message key="COLLECT_EDIT_同时保存为活动模板" bundle="${bundle}"/>
                        </span>
                    </c:if>
                </div> 
            </dd>
            </dl>
        </div>
    </form>
    <%--JavaScript HTML模版 --%>
    <div id="collect_html_templates" style="display:none">
        <%--自定义门票海报模版 --%>
        <div class="collect_diy_ticket  TextAlignLeft" id="collect_diy_ticket_poster_image_template">
            <div style="padding-left:30px;">
                <span class="collect_diy_ticket">
                    <input type="hidden" id="ticket_poster_image_url_-1" value="" />
                    <input type="hidden" name="ticket_poster_image_url" value="" />
                    <input type="hidden" name="ticket_poster_image_name" value="" />
                    <span class="hidden_input_container FloatLeft">
                        <span class="diy_title"></span>
                        <span class="collect_diy_ticket_edit_span"><a href="javascript:void(0)"><fmt:message key="GLOBAL_编辑" bundle="${bundle}"/></a></span>
                    </span>
                    <br/>
                </span>
            </div>
        </div>
        <%--自定义注册问题模版 --%>
        <div class="collect_diy_option " id="collect_diy_option_template">
            <span class="hidden_input_container FloatLeft">
                <input type="checkbox" value="true"/>
                <span class="diy_title"></span>
                <span class="collect_diy_option_edit_span"><a href="javascript:void(0)"><fmt:message key="GLOBAL_编辑" bundle="${bundle}"/></a></span>
                <span class="collect_diy_option_del_span"><a href="javascript:void(0)"><fmt:message key="GLOBAL_删除" bundle="${bundle}"/></a></span>
            </span>
            <br class="clear"/>
        </div>
        <%--票价option模版 --%>
        <table id="collect_price_option_template">
            <tr class="white basic_inputs_container">
                <td>
                    <input type="text" style="color:#999999" 
                           onfocus="YpEffects.toggleFocus4Ele(this, 'focus', '${priceNameDefaultText}', '', 'black')" 
                           onblur="FundCollectionPrice.synFundCollectionDiscountAndReferral(this, '${priceNameDefaultText}')"
                           value="${priceNameDefaultText}" 
                           class="Input154"  name="fund_collection_price[{0}].name" />
                </td>
                <td><input class="Input40" name="fund_collection_price[{0}].maxTotalCount"/></td>
                <td>
                    <input type="text" class="Input40" name='fund_collection_price[{0}].amount' 
                           onblur="FundCollectionPrice.synFundCollectionDiscountAndReferral(this, '')"/>
                </td>
                <td>
                    <select class="Input184 Select124" name="fund_collection_price[{0}].currency_type" onchange="FundCollectionPrice.synCurrencyType(this)">
                        <option value="CNY"><fmt:message key="COLLECT_EDIT_LABEL_UNIT" bundle="${bundle}"/></option>
                        <option value="USD"><fmt:message key="COLLECT_EDIT_LABEL_元/美元" bundle="${bundle}"/></option>
                    </select> 
                </td>
                <td width="42"><input class="EventCheckbox" type="checkbox" onclick="FundCollectionPrice.setFreeAmount(this);"></td>
                <td>
                    <input type="hidden" name="fund_collection_price[{0}].order" value="{0}" />
                    <a href="javascript:void(0);" onclick="FundCollectionPrice.toggleExtraInputs(this);"><fmt:message key="COLLECT_EVENT_EDIT_TEXT_展开" bundle="${bundle}"/></a>
                    <a href="javascript:void(0);" onclick="FundCollectionPrice.delOption(this);"><fmt:message key="GLOBAL_删除" bundle="${bundle}"/></a>
                </td>
            </tr>
            <%--票价额外信息 --%>
            <tr style="display: none" class="extra_inputs_container">
                <td colspan="6">
            <c:if test="${collectionType=='EVENT'}">
                <%--票价描述 --%>
                <div class="sk-item-edit-ticket">
                    <label class="sk-label-edit-ticket "><b><fmt:message key="COLLECT_EVENT_EDIT_LABEL_门票描述" bundle="${bundle}"/></b></label>
                    <p><textarea name="fund_collection_price[{0}].description" style="color: black" class="TextareaPaymentMessage"></textarea></p>
                    <p>
                        <input type="checkbox"  name="fund_collection_price[{0}].show_description" value="false"/>
                    <fmt:message key="COLLECT_EVENT_EDIT_LABEL_在活动页面上隐藏此描述" bundle="${bundle}"/>
                    </p>
                </div>
                <%--票价有效期：开始与结束时间 --%>
                <div class="sk-item-edit-ticket">
                    <label class="sk-label-edit-ticket "><b><fmt:message key="COLLECT_EVENT_EDIT_LABEL_优惠结束时间" bundle="${bundle}"/></b></label>
                    <p><fmt:message key="COLLECT_EVENT_EDIT_LABEL_开始时间" bundle="${bundle}"/></p>
                    <p>
                        <input  class="Input130 FloatLeft" type="text"
                                name="fund_collection_price[{0}].startDate" >
                        <select  class="Input184 Select70 FloatLeft MarginL7" name="fund_collection_price[{0}].startTime"></select>
                    </p>
                    <br/> 
                    <p><fmt:message key="COLLECT_EVENT_EDIT_LABEL_结束时间" bundle="${bundle}"/></p>
                    <p>
                        <input  class="Input130 FloatLeft" type="text"
                                name="fund_collection_price[{0}].expireDate" >
                        <select  class="Input184 Select70 FloatLeft MarginL7" name="fund_collection_price[{0}].expireTime"></select>
                    </p>
                    <div class="clear"></div> 
                </div>
            </c:if>
            <%--票价每次订购张数限制 --%>
            <div class="sk-item-edit-ticket">
                <label class="sk-label-edit-ticket "><b><fmt:message key="COLLECT_EVENT_EDIT_LABEL_订购张数限制" bundle="${bundle}"/></b></label>
                <span class="FloatLeft" style="margin-left:0px;"><fmt:message key='COLLECT_EVENT_EDIT_TEXT_最少张数' bundle="${bundle}"/></span>
                <select class="Input184 Select60 shortInput FloatLeft" name="fund_collection_price[{0}].minCount">
                    <c:forEach begin="1" end="50" varStatus="status">
                        <option>${status.index}</option>
                    </c:forEach>
                </select>  
                <span class="FloatLeft"><fmt:message key='COLLECT_EVENT_EDIT_TEXT_最多张数' bundle="${bundle}"/></span>
                <select class="Input184 Select60 shortInput FloatLeft" name="fund_collection_price[{0}].maxCount">
                    <c:forEach begin="0" end="50" varStatus="status">
                        <option>${status.index}</option>
                    </c:forEach>
                </select> 
                <div class="clear"></div> 
            </div>
            <%--门票隐藏设置 --%>
            <c:if test="${collectionType=='EVENT'}">
                <div class="sk-item-edit-ticket">
                    <label class="sk-label-edit-ticket "><b><fmt:message key="COLLECT_EVENT_EDIT_LABEL_隐藏门票" bundle="${bundle}"/></b></label>

                    <div style=" padding-top:5px;"><input  style="float: left; margin:5px 10px 20px 0px" type="checkbox" name="fund_collection_price[{0}].hidden" value="true"
                                                           onclick="FundCollectionPrice.synFundCollectionDiscountAndReferral(this, '')">
                        <span style="line-height:18px; margin-left: 0px;"><fmt:message key='COLLECT_EVENT_EDIT_TEXT_隐藏的门票' bundle="${bundle}"/></span>
                    </div><div class="clear"></div>
                </div>
            </c:if>
            <%--门票需审批--%>
            <c:if test="${collectionType=='EVENT'}">
                <div class="sk-item-edit-ticket">
                    <label class="sk-label-edit-ticket "><b><fmt:message key="COLLECT_EVENT_EDIT_LABEL_门票需审批" bundle="${bundle}"/></b></label>

                    <div style=" padding-top:5px;"> <input  type="checkbox"  style="float: left; margin:5px 10px 20px 0px"  name="fund_collection_price[{0}].requireApproval" value="true"
                                                            onclick="FundCollectionPrice.synFundCollectionDiscountAndReferral(this, '')">

                        <span style="line-height:18px; margin-left: 0px;"><fmt:message key='COLLECT_EVENT_EDIT_TEXT_需审批的门票' bundle="${bundle}"/></span></div>
                    <div class="clear"></div>
                </div>
            </c:if>
            </td>
            </tr>
        </table>
        <%--折扣码option模版 --%>
        <table id="collect_discount_option_template">
            <%--折扣码基本信息 --%>
            <tr class="white basic_inputs_container">
                <td width="23%"><input type="text" name="fund_collection_discount[{0}].code" class="Input144"/></td>
                <td width="33%"><input type="text" name="fund_collection_discount[{0}].name" class="Input154"/></td>
                <td width="18%">
                    <input type="text" name="fund_collection_discount[{0}].rate" onfocus="YpEffects.toggleFocus4Ele(this, 'focus', '<fmt:message key='COLLECT_EDIT_TEXT_折扣' bundle="${bundle}"/>', '', 'black')" class="Input50"/>
                </td>
                <td width="16%">
                    <select  class="Input184 Select60" name="fund_collection_discount[{0}].type" >
                        <option value="RATE">%</option>
                        <option value="AMOUNT"><fmt:message key='COLLECT_DETAIL_元' bundle="${bundle}"/></option>
                    </select>
                </td>
                <td width="10%">
                    <input type="hidden" name="fund_collection_discount[{0}].order" value="{0}" />
                    <a href="javascript:void(0);" onclick="FundCollectionDiscount.toggleExtraInputs(this);"><fmt:message key="COLLECT_EVENT_EDIT_TEXT_展开" bundle="${bundle}"/></a>
                    <a href="javascript:void(0);" onclick="FundCollectionDiscount.delOption(this);"><fmt:message key="GLOBAL_删除" bundle="${bundle}"/></a>
                </td>
            </tr>
            <%--折扣码额外信息 --%>
            <tr style="display: none" class="extra_inputs_container">
                <td colspan="5">
                    <div class="sk-item-edit-ticket">
                        <label class="sk-label-edit-ticket">
                            <b><fmt:message key="COLLECT_EDIT_TEXT_针对" bundle="${bundle}"/></b>
                        </label>
                        <input type="checkbox" class="MarginL7 discount_related_price_all_cb" checked="checked" onclick="FundCollectionDiscount.toggleRelatedPrice(this);"/><fmt:message key="COLLECT_EDIT_TEXT_所有价格" bundle="${bundle}"/>
                        <div class="MarginL60 collect_discount_related_price_container">
                            <c:forEach var="price" items="${fundCollectionPriceList}" varStatus="priceStatus">
                                <c:if test="${price.amount > 0}">
                                    <p>
                                        <input type="checkbox" 
                                               name="fund_collection_discount[{0}].price_order_list[${price.order}]" 
                                               value="${price.order}"
                                               checked="checked"
                                               onclick="FundCollectionDiscount.toggleRelatedAllPriceCheckbox(this);"
                                               />${price.name}
                                    </p>
                                </c:if>
                            </c:forEach>
                        </div>

                    </div>
                    <%--折扣码有效期 --%>
                    <div class="sk-item-edit-ticket">
                        <label class="sk-label-edit-ticket "><b><fmt:message key="COLLECT_EVENT_EDIT_LABEL_有效期" bundle="${bundle}"/></b></label>
                        <p><fmt:message key="COLLECT_EVENT_EDIT_LABEL_开始时间" bundle="${bundle}"/></p>
                        <p>
                            <input  class="Input130 FloatLeft" type="text"
                                    name="fund_collection_discount[{0}].startDate">
                            <select  class="Input184 Select70 FloatLeft MarginL7" name="fund_collection_discount[{0}].startTime"></select>
                        </p>
                        <br/> 
                        <p><fmt:message key="COLLECT_EVENT_EDIT_LABEL_结束时间" bundle="${bundle}"/></p>
                        <p>
                            <input  class="Input130 FloatLeft" type="text"
                                    name="fund_collection_discount[{0}].expireDate">
                            <select  class="Input184 Select70 FloatLeft MarginL7" name="fund_collection_discount[{0}].expireTime"></select>
                        </p>
                        <div class="clear"></div> 
                    </div>
                    <%--折扣码次数限制--%>
                    <div class="sk-item-edit-ticket">
                        <label class="sk-label-edit-ticket "><b><fmt:message key="COLLECT_EVENT_EDIT_LABEL_次数限制" bundle="${bundle}"/></b></label>
                        <input type="text" name="fund_collection_discount[{0}].maxCount" class="Input40"/>&nbsp;<span style="font-size: 12px"><fmt:message key="COLLECT_EVENT_EDIT_LABEL_折扣码被用了设定的次数将会失效" bundle="${bundle}"/></span>
                        <div class="clear"></div> 
                    </div>
                </td>
            </tr>
        </table>
        <c:if test="${collectionType=='EVENT'}">
            <%--渠道码option模版 --%>
            <table id="collect_referral_option_template">
                <tr class="white basic_inputs_container">
                    <td width="23%"><input type="text" name="fund_collection_referral[{0}].code" class="Input144" onblur="FundCollectionReferral.setLinkText(this);"/></td>
                    <td width="67%">
                        <input type="text" name="fund_collection_referral[{0}].name" 
                               style="color:#999999"  
                               value="<fmt:message key='COLLECT_EDIT_TEXT_名称' bundle="${bundle}"/>" 
                               onfocus="YpEffects.toggleFocus4Ele(this, 'focus', '<fmt:message key='COLLECT_EDIT_TEXT_名称' bundle="${bundle}"/>', '', 'black')" 
                onblur="YpEffects.toggleFocus4Ele(this, 'blur', '<fmt:message key='COLLECT_EDIT_TEXT_名称' bundle="${bundle}"/>', '', '#999999')"
                class="Input340"/>
                </td>
                <td width="10%">
                    <input type="hidden" name="fund_collection_referral[{0}].order" value="{0}" />
                    <a href="javascript:void(0);" onclick="FundCollectionReferral.toggleExtraInputs(this);"><fmt:message key="COLLECT_EVENT_EDIT_TEXT_展开" bundle="${bundle}"/></a>
                    <a href="javascript:void(0);" onclick="FundCollectionReferral.delOption(this);"><fmt:message key="GLOBAL_删除" bundle="${bundle}"/></a>
                </td>
                </tr>
                <tr style="display: none">
                    <td colspan="3" class="collect_referral_link_container"></td>
                </tr>
                <tr class="extra_inputs_container" style="display: none">
                    <td colspan="3">
                        <div class="sk-item-edit-ticket">
                            <label class="sk-label-edit-ticket">
                                <fmt:message key="COLLECT_EDIT_TEXT_显示隐藏门票" bundle="${bundle}"/>
                            </label>
                            <input type="checkbox" class="MarginL7 referral_related_hprice_all_cb" onclick="FundCollectionReferral.toggleRelatedPrice(this);"/><fmt:message key="COLLECT_EDIT_TEXT_所有隐藏门票" bundle="${bundle}"/>
                            <div class="MarginL60 collect_referral_related_hprice_container">
                                <c:forEach var="price" items="${fundCollectionPriceList}" varStatus="priceStatus">
                                    <c:if test="${price.hidden}">
                                        <c:set var="hiddenPriceCount" value="${hiddenPriceCount + 1}"></c:set>
                                        <p>
                                            <input type="checkbox" 
                                                   name="fund_collection_referral[{0}].price_order_list[${price.order}]" 
                                                   value="${price.order}"
                                                   onclick="FundCollectionReferral.toggleRelatedAllPriceCheckbox(this);"
                                                   />${price.name}
                                        </p>
                                    </c:if>
                                </c:forEach>
                            </div>
                        </div>
                    </td>
                </tr>
            </table>
        </c:if>
    </div>                        
    <%--弹出窗口Dialog --%>
    <c:if test="${collectionType=='EVENT'}">
        <jsp:include page="/WEB-INF/collect/z_collect_diy_dialog.jsp"/>
        <jsp:include page="/WEB-INF/collect/z_collect_ticket_diy_dialog.jsp"/>
    </c:if>
    <div id="ticket_custom_service_dialog" style="display:none;">  
        <div>
            <div class="MarginTop10">
                <fmt:message key='COLLECT_EDIT_DIALOG_门票定制化只对专业版用户开放' bundle='${bundle}'>
                    <fmt:param value="/ypservice/pay/professional"></fmt:param>
                </fmt:message>
            </div>
            <div class="TextAlignRight MarginTop10"><a href="javascript:void(0);" onclick="TicketCustomServiceDialog.close();"><fmt:message key='GLOBAL_取消' bundle='${bundle}'/></a><input type="button" value="<fmt:message key='COLLECT_EDIT_DIALOG_BUTTON_马上升级' bundle='${bundle}'/>" class="collection_button MarginL7" onclick="window.open('/ypservice/pay/professional')"/></div>
        </div>
    </div>
    <div id="allowPayGateDialog" style="display:none;">  
        <div>
            <div class="MarginTop10">
                <fmt:message key='COLLECT_EDIT_DIALOG_请先购买相应的友付服务开通此支付方式' bundle='${bundle}'>
                    <fmt:param value="/ypservice/pay/standard"></fmt:param>
                </fmt:message>
            </div>
            <div class="TextAlignRight MarginTop10"><a href="javascript:void(0);" onclick="allowPayGateDialog.close();"><fmt:message key='GLOBAL_取消' bundle='${bundle}'/></a><input type="button" value="<fmt:message key='COLLECT_EDIT_DIALOG_BUTTON_选择套餐' bundle='${bundle}'/>" class="collection_button MarginL7" onclick="window.open('/ypservice/pay/standard')"/></div>
        </div>
    </div>
    <div id="invoiceFaPiao" style="display:none;">  
        <div>
            <div class="MarginTop10"><fmt:message key='COLLECT_EDIT_DIALOG_代开发票说明' bundle='${bundle}'/></div>
            <div class="TextAlignRight MarginTop10"><a href="javascript:void(0);" onclick="invoiceFaPiao.close();"><fmt:message key='GLOBAL_取消' bundle='${bundle}'/></a><input type="button" value="<fmt:message key='COLLECT_EDIT_DIALOG_BUTTON_确定' bundle='${bundle}'/>" class="collection_button MarginL7" onclick="invoiceFaPiao.confirm()"/></div>
        </div>
    </div>
    <%--页面初始化脚本 --%>
    <script type="text/javascript">
        $(document).ready(function() {
            
            var isEdit = ${not empty fundCollection};
            var cType = "${collectionType}";
            //初始化收款票价相关数据
            FundCollectionPrice.init(isEdit,cType);
            //初始化收款折扣码相关数据
            FundCollectionDiscount.init(isEdit);
           
            //按收款类型初始化数据
            if( cType == "DONATION"){
                if(isEdit){
                    $("#collection_inputs_div #unit_amount_type").val("${fundCollection.unitAmountType}");
                }
                var cUnitAmountType = "${fundCollection.unitAmountType}";
                if(cUnitAmountType == "FREEWILL") {
                    var amountInput = $("#collection_inputs_div #collect_amount");
                    amountInput.val("");
                    amountInput.css("background-color", "F0F0F0");
                    amountInput.attr("disabled", "true");
                }
            } else if( cType == "EVENT" || cType=="SERVICE" || cType=="MEMBER" || cType=="PRODUCT"){
                //添加渠道码添加事件监听器
                if(cType == "EVENT") {
                    //初始化门票订制Tab
                    $("#custom_ticket_content_tabs").tabs();
                    //初始化收款渠道码相关数据
                    FundCollectionReferral.init(isEdit, ${hiddenPriceCount});
                    //初始化活动开始和结束日期和时间
                    var eventBeginDate = $('#event_begin_date');
                    var eventEndDate = $('#event_end_date');
                    YpDate.setDatePicker(eventBeginDate, eventEndDate, true);
                    var eventBeginTime = $("#event_begin_time");
                    var eventEndTime = $("#event_end_time");
                    YpDate.setTimeSelect(eventBeginTime, eventEndTime);
                    if(!isEdit) {
                        //设置开始和结束日期默认值
                        eventBeginDate.val(Lang.get("COLLECT_EDIT_年月日")).css("color","#909ea4");
                        eventEndDate.val(Lang.get("COLLECT_EDIT_年月日")).css("color","#909ea4");
                    }
                    //设置开始和结束时间默认值
                    if(!isEdit) {
                        //新建时，初始化为9:00和18:00
                        eventBeginTime.val("09:00");
                        eventBeginTime.trigger("change");
                        eventEndTime.val("18:00");
                    } else {
                        var eventDateWholeDay = "${fundCollection.eventDateWholeDay}";
                        if(eventDateWholeDay!="true") {
                            eventBeginTime.val("${fundCollection.eventBeginTime}");
                            eventBeginTime.trigger("change");
                            eventEndTime.val("${fundCollection.eventEndTime}");
                        } else {
                            $("#event_date_whole_day").attr("checked",true);
                            eventBeginTime.val("09:00");
                            eventBeginTime.trigger("change");
                            eventEndTime.val("18:00");
                            eventBeginTime.attr("disabled", true);
                            eventEndTime.attr("disabled", true);
                        }
                    }
                    //添加全天复选框单击事件监听器
                    $("#event_date_whole_day").click(function(event) {
                        var e = $(event.target);
                        if(e.attr("checked") == true || e.attr("checked") == 'checked') {
                            eventBeginTime.attr("disabled", true);
                            eventEndTime.attr("disabled", true);
                        } else {
                            eventBeginTime.attr("disabled", false);
                            eventEndTime.attr("disabled", false);
                        }
                    });
                }
            }
            //添加附件添加按钮单击事件监听器
            $('#attach_add').bind('click',Collect.addAttatch());
            //Make sure the payer_input_basic_required checkbox checked
            $("input[name='payer_input_basic_required']").click(function(e){
                e.preventDefault();
                alert(Lang.get("COLLECT_DIY_必须勾选此选项"));
            });
        });
            <c:if test="${!user.verified}">
            window.onload = function() {
            verifyDialog.open();
        }
            </c:if>
            var lang = 'zh_CN';
        if(Lang.getLanguage()=='en'){
            lang = 'en';
        }
        KindEditor.ready(function(K) {
            var temp;
            var ticketCZhContentEditor;
            var ticketCEnContentEditor;
            var Keditor;
            var KeditorHost;
            if(Lang._getCookie("support")!= null){
                KeditorHost = createKindEditor("event_host_desc",true,1,210,450,false);
                Keditor = createKindEditor("detailDesc",true,0,null,null,false);
                ticketCZhContentEditor = createKindEditor("ticket_custom_zh_content",true,1,710,400,true);
                ticketCEnContentEditor = createKindEditor("ticket_custom_en_content",true,1,710,400,true);
            }else{
                KeditorHost = createKindEditor("event_host_desc",false,1,210,450,false);
                Keditor = createKindEditor("detailDesc",null,0,false,null,false);
                ticketCZhContentEditor = createKindEditor("ticket_custom_zh_content",false,1,710,400,true);
                ticketCEnContentEditor = createKindEditor("ticket_custom_en_content",false,1,710,400,true);
            }
            $('#Submit').click(function(){FundCollection.checkCreateForm(<%=Config.MIN_COLLECT_AMOUNT%>,Keditor,KeditorHost,ticketCZhContentEditor,ticketCEnContentEditor)});
            function createKindEditor(textareaId,isSupportLogin,resizeType,width,height,isIncludeTicket){
                var item;
                if(isSupportLogin){
                    if(isIncludeTicket) {
                        item = ['source', '|', 'undo', 'redo', '|', 'preview', 'print', 'template', 'code', 'cut', 'copy', 'paste',
                            'plainpaste', 'wordpaste', '|', 'justifyleft', 'justifycenter', 'justifyright',
                            'justifyfull', 'insertorderedlist', 'insertunorderedlist', 'indent', 'outdent', 'subscript',
                            'superscript', 'clearhtml', 'quickformat', 'selectall', '|', 'fullscreen', '/',
                            'formatblock', 'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold',
                            'italic', 'underline', 'strikethrough', 'lineheight', 'removeformat', '|', 'image', 'multiimage',
                            'flash', 'media', 'insertfile', 'table', 'hr', 'emoticons', 'baidumap', 'pagebreak',
                            'anchor', 'link', 'unlink','ypticket'];
                    } else {
                        item = ['source', '|', 'undo', 'redo', '|', 'preview', 'print', 'template', 'code', 'cut', 'copy', 'paste',
                            'plainpaste', 'wordpaste', '|', 'justifyleft', 'justifycenter', 'justifyright',
                            'justifyfull', 'insertorderedlist', 'insertunorderedlist', 'indent', 'outdent', 'subscript',
                            'superscript', 'clearhtml', 'quickformat', 'selectall', '|', 'fullscreen', '/',
                            'formatblock', 'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold',
                            'italic', 'underline', 'strikethrough', 'lineheight', 'removeformat', '|', 'image', 'multiimage',
                            'flash', 'media', 'insertfile', 'table', 'hr', 'emoticons', 'baidumap', 'pagebreak',
                            'anchor', 'link', 'unlink'];
                    }
                        
                } else {
                    if(isIncludeTicket) {
                        item = ['undo','redo','|',
                            'justifyleft','justifycenter','justifyright','justifyfull','insertorderedlist','insertunorderedlist','indent','outdent',
                            'subscript','superscript','selectall','|','formatblock','fontname','fontsize','|',
                            'forecolor','hilitecolor','bold','italic','underline','lineheight','removeformat','|','image','multiimage',
                            'table','hr','pagebreak','link','unlink','ypticket'];
                    } else {
                        item = ['undo','redo','|',
                            'justifyleft','justifycenter','justifyright','justifyfull','insertorderedlist','insertunorderedlist','indent','outdent',
                            'subscript','superscript','selectall','|','formatblock','fontname','fontsize','|',
                            'forecolor','hilitecolor','bold','italic','underline','lineheight','removeformat','|','image','multiimage',
                            'table','hr','pagebreak','link','unlink'];
                    }
                         
                }
                return K.create('textarea[id="'+textareaId+'"]', {
                    items:item, 
                    langType:lang,
                    resizeType : resizeType,
                    uploadJson : '/collect/upload_json',
                    fileManagerJson : '/collect/file_manager_json',
                    delFile:'/collect/file_manager_del_json',
                    allowFileManager : true,
                    width : width,
                    height : height
                });
            }
                
        });
            
            <c:if test="${not empty postResult.singleErrorMsg}">
            $(document).ready(function(){
            var wrongMessage='${postResult.singleErrorMsg}';
            if(wrongMessage!=''){
                MessageShow.showPopWrongMessage('#public_message',wrongMessage);
            }
        });
            </c:if>
    </script>
</div>
