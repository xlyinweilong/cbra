<%-- 
    Document   : z_payment_step2
    Created on : Apr 23, 2012, 5:59:30 PM
    Author     : Swang
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%--Payer information --%>    
<dl class="dlRegister">  
    <dt><fmt:message key="PAYMENT_DETAIL_您的信息" bundle="${bundle}"/></dt>
<dd class="Padding0">
    <div class="payment_left FloatLeft MarginTop10" >
        <div><fmt:message key="PAYMENT_DETAIL_LABEL_姓名" bundle="${bundle}"/>
            <c:if test="${fundCollection.payerInfoRequired || user==null}"> 
                <span class="ColorOrange">*</span>
            </c:if>
        </div>
        <c:if test="${not empty payer}">
            <input type="hidden" name="register_personal_info[0].id" value="${payer.id}" />
        </c:if>
        <input type="hidden" name="register_personal_info[0].type" value="PAYER" />
        <input type="text" <c:if test="${requireApproval}">disabled="disabled"</c:if> name="register_personal_info[0].name" id="payer_name" class="Input450 Input300 MarginBottom5"
        value="${payer != null ? payer.name : user.name}"/>

        <div class="TextAlignLeft"><fmt:message key="PAYMENT_DETAIL_LABEL_手机" bundle="${bundle}"/>
            <c:if test="${fundCollection.payerMobileInfoRequired}">
                <span class="ColorOrange">*</span>
            </c:if>
        </div>
        <input type="text" <c:if test="${requireApproval}">disabled="disabled"</c:if> name="register_personal_info[0].mobile_phone" id="payer_mobilePhone" class="Input450 Input300 MarginBottom5"
        value="${payer != null ? payer.mobilePhone : user.mobilePhone}"/>

        <div class="TextAlignLeft"><fmt:message key="PAYMENT_DETAIL_LABEL_公司" bundle="${bundle}"/>
            <c:if test="${fundCollection.payerWorkInfoRequired}">
                <span class="ColorOrange">*</span>
            </c:if>
        </div>
        <input type="text" <c:if test="${requireApproval}">disabled="disabled"</c:if> name="register_personal_info[0].company" id="payer_company" class="Input450 Input300 MarginBottom5"
        value="${payer != null ? payer.company : user.company}"/> 

        <div><fmt:message key="PAYMENT_DETAIL_LABEL_职务" bundle="${bundle}"/>
            <c:if test="${fundCollection.payerWorkInfoRequired}">
                <span class="ColorOrange">*</span>
            </c:if>
        </div>
        <input type="text" <c:if test="${requireApproval}">disabled="disabled"</c:if> name="register_personal_info[0].position" id="payer_position" class="Input450 Input300 MarginBottom5"
        value="${payer != null ? payer.position : user.position}" />
    </div> 
    <div class="payment_right FloatRight TextAlignRight MarginTop10">
        <div class="TextAlignLeft"><fmt:message key="PAYMENT_DETAIL_LABEL_邮箱" bundle="${bundle}"/>
            <c:if test="${fundCollection.payerInfoRequired || user==null}">
                <span class="ColorOrange">*</span>
            </c:if>
        </div>
        <input type="text" <c:if test="${requireApproval}">disabled="disabled"</c:if> name="register_personal_info[0].email" id="payer_email" class="Input450 Input300 MarginBottom5" 
        value="${payer != null ? payer.email : user.email}" />
        <textarea <c:if test="${requireApproval}">disabled="disabled"</c:if> class="TextareaPaymentMessage" id="payer_msg" name="payer_msg" onblur="YpEffects.toggleFocus('payer_msg', 'blurs','<fmt:message key="PAYMENT_DETAIL_MSG_给收款人留言" bundle="${bundle}"/>','', '#909ea4');" onfocus="YpEffects.toggleFocus('payer_msg','focus','<fmt:message key="PAYMENT_DETAIL_MSG_给收款人留言" bundle="${bundle}"/>', '', 'black');"><fmt:message key="PAYMENT_DETAIL_MSG_给收款人留言" bundle="${bundle}"/></textarea>
    </div>
    <div class="clear"></div>
</dd>
</dl>

<%--Register question and every attendee infomation if need--%>
<c:set var="agreementQuestion" value=""/>
<c:choose>
    <c:when test="${!fundCollection.collectEachAttendeeInfo}">
        <%--Payer register question : Only output when collectEachAttendeeInfo is false--%>
        <c:if test="${not empty registerQuestions}">
            <dl class="dlRegister bg" id="payer_reg_question_container">
                <dt><fmt:message key="COLLECT_INOVICE_其它信息" bundle="${bundle}"/></dt>
                <c:forEach var="question" items="${registerQuestions}" varStatus="status">
                    <c:if test="${question.type!='AGREEMENT'}">
                        <dd>
                            <label> ${question.title}
                                <c:if test="${question.isRequired() }">
                                    <span class="ColorOrange">*</span>
                                </c:if>
                                <input type="hidden" name="register_question[${status.index}].id" value="${question.id}" />
                                <input type="hidden" name="register_question[${status.index}].register_question_answer_list[0].type" value="ALL" />
                                <c:if test="${not empty rqAnswerMap}">
                                    <c:set var="rqAnswerList" value="${rqAnswerMap[question.id]}"/>
                                </c:if> 
                            </label>
                        <c:choose>
                            <c:when test="${question.type=='TEXT_FIELD'}">
                                <input <c:if test="${question.isRequired() }">title="required"</c:if> type="text" <c:if test="${requireApproval}">disabled="disabled"</c:if>
                                name="register_question[${status.index}].register_question_answer_list[0].answerText" 
                                value="${rqAnswerList[0].answerText}"
                                class="Input450 Input300" />
                            </c:when>
                            <c:when test="${question.type=='TEXT_AREA'}">
                                <textarea <c:if test="${requireApproval}">disabled="disabled"</c:if> <c:if test="${question.isRequired() }">title="required"</c:if> class="textarea458" name="register_question[${status.index}].register_question_answer_list[0].answerText" >
                                    ${rqAnswerList[0].answerText}
                                </textarea>
                            </c:when>
                            <c:when test="${question.type=='SELECTION_DROPDOWN_LIST'}">
                                <div <c:if test="${question.isRequired() }">title="dropdownRequired"</c:if> >
                                    <select <c:if test="${requireApproval}">disabled="disabled"</c:if> name="register_question[${status.index}].register_question_answer_list[0].register_option_id" >
                                        <c:forEach var="option" items="${question.registerQuestionOptionList}">
                                            <option value="${option.id}" <c:if test="${rqAnswerList[0].registerOptionId == option.id}">selected="selected"</c:if>>${option.optionTitle}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </c:when>
                            <c:when test="${question.type=='SELECTION_RADIO_BUTTON'}">
                                <div <c:if test="${question.isRequired() }">title="radioRequired"</c:if> >
                                    <ul>
                                        <c:forEach var="option" items="${question.registerQuestionOptionList}">
                                            <li>
                                                <label <c:if test="${question.isRequired() }">title="radioRequired"</c:if>>
                                                    <input type="radio" <c:if test="${requireApproval}">disabled="disabled"</c:if> name="register_question[${status.index}].register_question_answer_list[0].register_option_id" value="${option.id}" <c:if test="${rqAnswerList[0].registerOptionId == option.id}">checked="checked"</c:if>/></label>${option.optionTitle}
                                            </li>
                                        </c:forEach>
                                    </ul>
                                </div>
                            </c:when>
                            <c:when test="${question.type=='SELECTION_CHECK_BOX'}">
                                <div  <c:if test="${question.isRequired() }">title="checkboxRequired"</c:if> >
                                    <ul>
                                        <c:forEach var="option" items="${question.registerQuestionOptionList}" varStatus="optionStatus">
                                            <li>
                                                <label <c:if test="${question.isRequired() }">title="checkboxRequired"</c:if>>
                                                    <input type="checkbox" <c:if test="${requireApproval}">disabled="disabled"</c:if>
                                                    name="register_question[${status.index}].register_question_answer_list[0].register_option_ids" 
                                                    value="${option.id}" 
                                                    <c:if test="${fn:contains(rqAnswerList[0].registerOptionIds,option.id)}">checked="checked"</c:if>/>
                                                </label>${option.optionTitle}
                                            </li>
                                        </c:forEach>
                                    </ul>
                                </div>
                            </c:when>
                            <c:when test="${question.type=='UPLOAD_FILE'}">
                                <c:choose>
                                    <c:when test="${!requireApproval}">
                                        <input <c:if test="${question.isRequired() }">title="required"</c:if> type="file" name="register_question[${status.index}].register_question_answer_list[0].uploadFile" class="Input450 Input300" />
                                    </c:when>
                                    <c:otherwise>
                                        <input type="text" value="${rqAnswerList[0].answerFileName}" disabled="disabled" />
                                    </c:otherwise>
                                </c:choose>
                            </c:when>
                            <c:otherwise>
                            </c:otherwise>
                        </c:choose>
                        </dd>
                    </c:if>
                    <c:if test="${question.type=='AGREEMENT'}">
                        <c:set var="agreementQuestion" value="${question}"/>
                    </c:if>
                </c:forEach>
            </dl> 
        </c:if>
    </c:when>
    <c:otherwise>
        <%--Every attendee information,include basic info and register question --%>
        <div id="attendee_info_collect_container">
            <c:if test="${not empty subCollectionOrderItemList}">
                <c:set var="counter4orderItem" value="0"/>
                <c:forEach var="subOrderItem" items="${subCollectionOrderItemList}" varStatus="orderItemStatus4step2">
                    <c:forEach begin="1" end="${subOrderItem.quantity}" varStatus="orderItemStatus4Qua">
                        <c:set var="counter4orderItem" value="${counter4orderItem + 1}"/>
                        <c:if test="${not empty attendeeInfoList}">
                            <c:set var="attendeeInfo" value="${attendeeInfoList[counter4orderItem-1]}"/>
                            <input type="hidden" name="register_personal_info[${counter4orderItem}].id" value="${attendeeInfo.id}" />
                        </c:if>
                        <c:if test="${counter4orderItem == 2}">
                            <div class="TextAlignRight">
                                <input id="syn_all_attendee_cb" type="checkbox" onclick="FundPayment.synAllAttendeeFromFirstAttendee();">
                                <fmt:message key="PAYMENT_PAY_以下门票信息相同" bundle="${bundle}"/>
                            </div>
                        </c:if>
                        <input type="hidden" name="register_personal_info[${counter4orderItem}].type" value="ATTENDEE" />
                        <dl class="dlRegister bg each_attendee_info_container ${counter4orderItem==1 ? 'first_attendee_info_container' : 'no_first_attendee_info_container'}">
                            <dt class="each_attendee_info_title"><fmt:message key="PAYMENT_PAY_参加人" bundle="${bundle}"/> #${counter4orderItem}&nbsp;-&nbsp;${subOrderItem.price.name}</dt>
                            <dd>
                                <%--Attendee name --%>
                                <label>
                                    <fmt:message key="PAYMENT_DETAIL_LABEL_姓名" bundle="${bundle}"/>
                                    <c:if test="${fundCollection.payerInfoRequired}"> 
                                        <span class="ColorOrange">*</span>
                                    </c:if>
                                </label>
                            <input type="text" <c:if test="${requireApproval}">disabled="disabled"</c:if> name="register_personal_info[${counter4orderItem}].name" 
                            <c:if test="${fundCollection.payerInfoRequired}">title="required"</c:if> 
                            value="${attendeeInfo != null ? attendeeInfo.name : payer != null ? payer.name : user.name}"
                            class="Input450 Input300 MarginBottom5"/>
                            </dd>
                            <dd>
                                <%--Attendee phone --%>
                                <label class="TextAlignLeft"><fmt:message key="PAYMENT_DETAIL_LABEL_手机" bundle="${bundle}"/>
                                    <c:if test="${fundCollection.payerMobileInfoRequired}">
                                        <span class="ColorOrange">*</span>
                                    </c:if>
                                </label>
                            <input type="text" <c:if test="${requireApproval}">disabled="disabled"</c:if> name="register_personal_info[${counter4orderItem}].mobilePhone" 
                            <c:if test="${fundCollection.payerInfoRequired}">title="required"</c:if> 
                            value="${attendeeInfo != null ? attendeeInfo.mobilePhone : payer != null ? payer.mobilePhone : user.mobilePhone}"
                            class="Input450 Input300 MarginBottom5"/>    
                            </dd>
                            <dd>
                                <%--Attendee company --%>
                                <label><fmt:message key="PAYMENT_DETAIL_LABEL_公司" bundle="${bundle}"/>
                                    <c:if test="${fundCollection.payerWorkInfoRequired}">
                                        <span class="ColorOrange">*</span>
                                    </c:if>
                                </label>
                            <input type="text" <c:if test="${requireApproval}">disabled="disabled"</c:if> name="register_personal_info[${counter4orderItem}].company" 
                            <c:if test="${fundCollection.payerWorkInfoRequired}">title="required"</c:if> 
                            value="${attendeeInfo != null ? attendeeInfo.company : payer != null ? payer.company : user.company}"
                            class="Input450 Input300 MarginBottom5"/>    
                            </dd>
                            <dd>
                                <%--Attendee position --%>
                                <label>
                                    <fmt:message key="PAYMENT_DETAIL_LABEL_职务" bundle="${bundle}"/>
                                    <c:if test="${fundCollection.payerWorkInfoRequired}">
                                        <span class="ColorOrange">*</span>
                                    </c:if>
                                </label>
                            <input type="text" <c:if test="${requireApproval}">disabled="disabled"</c:if> name="register_personal_info[${counter4orderItem}].position" 
                            <c:if test="${fundCollection.payerWorkInfoRequired}">title="required"</c:if>
                            value="${attendeeInfo != null ? attendeeInfo.position : payer != null ? payer.position : user.position}"
                            class="Input450 Input300 MarginBottom5"/>    
                            </dd>
                            <dd> 
                                <%--Attendee email --%>
                                <label>
                                    <fmt:message key="PAYMENT_DETAIL_LABEL_邮箱" bundle="${bundle}"/>
                                    <c:if test="${fundCollection.payerInfoRequired}">
                                        <span class="ColorOrange">*</span>
                                    </c:if>
                                </label>
                            <input type="text" <c:if test="${requireApproval}">disabled="disabled"</c:if> name="register_personal_info[${counter4orderItem}].email" 
                            <c:if test="${fundCollection.payerInfoRequired}">title="required"</c:if> 
                            value="${attendeeInfo != null ? attendeeInfo.email : payer != null ? payer.email : user.email}"
                            class="Input450 Input300 MarginBottom5"/>    
                            </dd>
                            <%--Custom register questions for attendee --%>
                            <c:if test="${not empty registerQuestions}">
                                <c:forEach var="question" items="${registerQuestions}" varStatus="regStatus"> 
                                    <c:if test="${question.type!='AGREEMENT'}">
                                        <dd>
                                            <label> ${question.title}
                                                <c:if test="${question.isRequired() }">
                                                    <span class="ColorOrange">*</span>
                                                </c:if>
                                                <input type="hidden" name="register_question[${regStatus.index}].id" value="${question.id}" />
                                                <input type="hidden" name="register_question[${regStatus.index}].register_question_answer_list[${counter4orderItem}].type" value="ATTENDEE" />
                                                <c:if test="${not empty rqAnswerMap}">
                                                    <c:set var="rqAnswerList" value="${rqAnswerMap[question.id]}"/>
                                                    <input type="hidden" name="register_question[${regStatus.index}].register_question_answer_list[${counter4orderItem}].id" value="${rqAnswerList[counter4orderItem-1].id}" />
                                                </c:if> 
                                            </label> 

                                        <c:choose>
                                            <c:when test="${question.type=='TEXT_FIELD'}">
                                                <input <c:if test="${question.isRequired() }">title="required"</c:if> type="text" <c:if test="${requireApproval}">disabled="disabled"</c:if>
                                                name="register_question[${regStatus.index}].register_question_answer_list[${counter4orderItem}].answerText" 
                                                value="${rqAnswerList[counter4orderItem-1].answerText}"
                                                class="Input450 Input300" />
                                            </c:when>
                                            <c:when test="${question.type=='TEXT_AREA'}">
                                                <textarea <c:if test="${requireApproval}">disabled="disabled"</c:if> <c:if test="${question.isRequired() }">title="required"</c:if> class="textarea458" name="register_question[${regStatus.index}].register_question_answer_list[${counter4orderItem}].answerText" >
                                                    ${rqAnswerList[counter4orderItem-1].answerText}
                                                </textarea>
                                            </c:when>
                                            <c:when test="${question.type=='SELECTION_DROPDOWN_LIST'}">
                                                <div <c:if test="${question.isRequired() }">title="dropdownRequired"</c:if> >
                                                    <select <c:if test="${requireApproval}">disabled="disabled"</c:if> name="register_question[${regStatus.index}].register_question_answer_list[${counter4orderItem}].register_option_id" >
                                                        <c:forEach var="option" items="${question.registerQuestionOptionList}">
                                                            <option value="${option.id}" <c:if test="${rqAnswerList[counter4orderItem-1].registerOptionId == option.id}">selected="selected"</c:if>>${option.optionTitle}</option>
                                                        </c:forEach>
                                                    </select>
                                                </div>
                                            </c:when>
                                            <c:when test="${question.type=='SELECTION_RADIO_BUTTON'}">
                                                <div <c:if test="${question.isRequired() }">title="radioRequired"</c:if> >
                                                    <ul>
                                                        <c:forEach var="option" items="${question.registerQuestionOptionList}">
                                                            <li>
                                                                <label <c:if test="${question.isRequired() }">title="radioRequired"</c:if>>
                                                                    <input type="radio" <c:if test="${requireApproval}">disabled="disabled"</c:if>
                                                                    name="register_question[${regStatus.index}].register_question_answer_list[${counter4orderItem}].register_option_id" 
                                                                    value="${option.id}" 
                                                                    <c:if test="${rqAnswerList[counter4orderItem-1].registerOptionId == option.id}">checked="checked"</c:if>/>
                                                                </label>${option.optionTitle}
                                                            </li>
                                                        </c:forEach>
                                                    </ul>
                                                </div>
                                            </c:when>
                                            <c:when test="${question.type=='SELECTION_CHECK_BOX'}">
                                                <div  <c:if test="${question.isRequired() }">title="checkboxRequired"</c:if> >
                                                    <ul>
                                                        <c:forEach var="option" items="${question.registerQuestionOptionList}" varStatus="optionStatus">
                                                            <li>
                                                                <label <c:if test="${question.isRequired() }">title="checkboxRequired"</c:if>>
                                                                    <input type="checkbox" <c:if test="${requireApproval}">disabled="disabled"</c:if>
                                                                    name="register_question[${regStatus.index}].register_question_answer_list[${counter4orderItem}].register_option_ids" 
                                                                    value="${option.id}" 
                                                                    <c:if test="${fn:contains(rqAnswerList[counter4orderItem-1].registerOptionIds,option.id)}">checked="checked"</c:if>
                                                                    />
                                                                </label>${option.optionTitle}
                                                            </li>
                                                        </c:forEach>
                                                    </ul>
                                                </div>
                                            </c:when>
                                            <c:when test="${question.type=='UPLOAD_FILE'}">
                                                <c:choose>
                                                    <c:when test="${!requireApproval}">
                                                        <input <c:if test="${question.isRequired()}">title="required"</c:if> type="file" 
                                                        name="register_question[${regStatus.index}].register_question_answer_list[${counter4orderItem}].uploadFile" class="Input450 Input300" />
                                                    </c:when>
                                                    <c:otherwise>
                                                        <input type="text" value="${rqAnswerList[0].answerFileName}" disabled="disabled" />
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:when>
                                            <c:otherwise>
                                            </c:otherwise>
                                        </c:choose>
                                        </dd>
                                    </c:if>
                                    <c:if test="${question.type=='AGREEMENT'}">
                                        <c:set var="agreementQuestion" value="${question}"/>
                                    </c:if>
                                </c:forEach>
                            </c:if>
                        </dl>

                    </c:forEach>
                </c:forEach>
            </c:if>
        </div>
    </c:otherwise>
</c:choose>
<%--Agreement --%>
<c:if test="${not empty agreementQuestion}">
    <input type="hidden" name="rq_agreement_cb_exist" value="true" />
    <dl class="dlRegister">  
        <dt><fmt:message key="PAYMENT_DETAIL_同意条款" bundle="${bundle}"/></dt>
        <dd class="Padding0">
            <textarea class="textarea640" rows="5" cols="45" readonly="readonly">${agreementQuestion.agreementText}</textarea></dd>
        <dd class="Padding0"><input type="checkbox" <c:if test="${requireApproval}">disabled="disabled"</c:if> value="agree" id="rq_agreement_cb" name="rq_agreement_cb" <c:if test="${orderStatus=='PENDING_PAYMENT' || orderStatus=='FAILURE' || orderStatus=='PAYMENT_TIMEOUT'}">checked="checked"</c:if>><fmt:message key="PAYMENT_DETAIL_我同意以上内容" bundle="${bundle}"/><span class="ColorOrange">*</span></dd>
    </dl>
</c:if>
<%--Invoice:only display when all the price is not free and not expire and the fundcollection provide the invoice and the order is not free--%>
<c:if test="${!isAllExposedPriceFree && !isAllExposedPriceExpire && fundCollection.invoiceProvider != null && fundCollection.invoiceProvider != 'NO_PROVIDE' && !subCollectionOrder.isFree()}">
    <dl class="dlRegister" id="invoice_input_container">
        <dt><fmt:message key="COLLECT_INOVICE_发票信息" bundle="${bundle}"/></dt>
        <dd class="Padding0"><input type="checkbox" autocomplete="off" name="need_invoice" <c:if test="${useInvoice}">checked="checked"</c:if> id="need_invoice" onclick="FundPayment.showInvoiceDiv();" value="true" /><fmt:message key="PAYMENT_DETAIL_LABEL_我需要发票" bundle="${bundle}"/></dd>
        <dd class="Padding0" id="need_invoice_div"  <c:if test="${useInvoice == null}">style="display:none"</c:if>>
        <div  class="charge_form">
            <div><fmt:message key="COLLECT_INOVICE_发票抬头" bundle="${bundle}"/>：</div><input type="text" name="invoice_title" id="invoice_title" class="TextareaInvoice MarginBottom5" value="${invoice.invoiceTitle}"/>
            <div class="FloatLeft" >
                <div> <fmt:message key="COLLECT_INOVICE_收件人" bundle="${bundle}"/>：</div><input type="text" name="invoice_name" id="invoice_name" class="Input285 MarginBottom5" value="${invoice.recipientName}"/>
            </div>

            <div class="FloatRight">
                <div><fmt:message key="COLLECT_INOVICE_电话" bundle="${bundle}"/>：</div><input type="text" name="invoice_phone" id="invoice_phone" class="Input285  MarginBottom5" value="${invoice.recipientPhone}"/>
            </div>
            <div class="clear"></div> 
            <div><fmt:message key="COLLECT_INOVICE_地址" bundle="${bundle}"/>：</div><input type="text" name="invoice_address" id="invoice_address" class="TextareaInvoice MarginBottom5" value="${invoice.recipientAddress}"/>
            <div class="FloatLeft" >
                <div><fmt:message key="COLLECT_INOVICE_省市" bundle="${bundle}"/>：</div><input type="text" name="invoice_province" id="invoice_province" class="Input285 MarginBottom5" value="${invoice.recipientProvince}"/>
            </div>
            <div class="FloatRight">
                <div><fmt:message key="COLLECT_INOVICE_邮编" bundle="${bundle}"/>：</div><input type="text" name="invoice_postcode" id="invoice_postcode" class="Input285 MarginBottom5" value="${invoice.recipientPostcode}"/>
            </div>
            <div class="clear"></div> 
        </div></dd>
    </dl>
</c:if>

<%--Gateway payment--%>
<c:if test="${!subCollectionOrder.isFree() && !('INIT' == subCollectionOrder.getParentOrderCollection().getStatus() && subCollectionOrder.isContainsApprovalPrice())}">
    <dl class="dlRegister" id="payment_style_choose">
        <dt><fmt:message key="PAYMENT_DETAIL_LABEL_支付方式" bundle="${bundle}"/></dt>
        <dd class="Padding0">
        <c:if test="${user != null}">
            <div id="balance_lack_container" style="display: none">
                <input type="checkbox" name="balance_lack_payment" value="true" onclick="GatewayPayment.toggleBalancePayment();"/>
                <span id="balance_lack_text">
                    <c:choose>
                        <c:when test="${fundCollection.currencyType=='USD'}" >
                            <fmt:message key='PAYMENT_LABEL_用友付余额支付XXX元XXX美元,剩余YYY美元用其他方式' bundle='${bundle}'></fmt:message>
                        </c:when>
                        <c:otherwise>
                            <fmt:message key='PAYMENT_LABEL_用友付余额支付XXX元,剩余YYY元用其他方式' bundle='${bundle}'></fmt:message>
                        </c:otherwise>
                    </c:choose>
                </span>
            </div>
        </c:if>
        <div>
            <c:set var="gateway_type_init" value="PAYMENT_DETAIL_LABEL_请选择"></c:set>
            <input type="hidden" id="currency_type" name="currency_type" value="${fundCollection.currencyType}" disabled="true"/>
            <div  class="MarginTop20">
                <!-- 支付方式下拉列表信息-->
                <span class="FloatLeft" style=" line-height:32px;height:32px;"><fmt:message key="PAYMENT_DETAIL_LABEL_选择支付方式" bundle="${bundle}" /></span>
                <span class="FloatLeft"><jsp:directive.include file="/WEB-INF/paygate/z_gateway_select.jsp"></jsp:directive.include></span>
                    <div class="clear"></div>
                </div>
                <div class="charge_form" id="credit_card_input_div" style="display: none">
                    <!-- 信用卡输入信息-->
                <jsp:directive.include file="/WEB-INF/paygate/z_creditcard_input.jsp" />
            </div>

            <div id="bank_transfer" style="display:none">
                <!-- 银行转账输入信息-->
                <jsp:directive.include file="/WEB-INF/paygate/z_bank_transfer.jsp" />
            </div>
            <div id="bank_list_div" style="display: none">
                <!-- 银行列表信息-->
                <jsp:directive.include file="/WEB-INF/paygate/z_bank_list.jsp" />
            </div>
            <div class="noteMessage MarginTop10" style="display:none" id="zhao_shang_caution">
                <fmt:message key="PAYMENT_GATEWAY_NOTICE_注意：在使用招商银行信用卡支付时，招行需要电话联系您来确认，请留意接听" bundle="${bundle}"/>
            </div>
        </div>
        </dd>
        <div class="line"></div>
    </dl>
</c:if>


<div class="BlueBoxContent TextAlignRight" style="line-height:36px; margin:15px 0px;">
    <%--Payment Step 2 button --%>
    <span id="payment_not_free">  
        <c:choose>
            <c:when test="${isAllExposedPriceExpire && !subCollectionOrder.isContainsApprovalPrice()}">
                <%--<span class="WaitingListMessage"><fmt:message key="PAYMENT_DETAIL_报名已截止但您可以申请加入候补名单" bundle="${bundle}"/></span>
                <input type="button" name="Submit" class="collection_button FloatRight  MarginL7" value="<fmt:message key="PAYMENT_DETAIL_BUTTON_加入候选名单" bundle="${bundle}"/>" id="payment_btn" onclick="FundPayment.addToWaitingList(${fundCollection.payerInfoRequired},${fundCollection.payerWorkInfoRequired}, ${user != null});"/> --%>
                <c:choose>
                    <c:when test="${fundCollection.type == 'EVENT'}"><c:set var="paymentButtonValue"> <fmt:message key="PAYMENT_DETAIL_BUTTON_报名" bundle="${bundle}"/></c:set></c:when>
                    <c:otherwise><c:set var="paymentButtonValue"> <fmt:message key="PAYMENT_DETAIL_BUTTON_订购" bundle="${bundle}"/></c:set></c:otherwise>
                </c:choose>
                <input type="button" disabled="disabled" name="Submit" class="gray_button" value="${paymentButtonValue}" id="payment_btn" onclick="FundPayment.checkStepTwoForm('${fundCollection.type}',${fundCollection.payerInfoRequired},${fundCollection.payerMobileInfoRequired},${fundCollection.payerWorkInfoRequired}, ${user != null} ,<c:out default="0" value="${registerQuestions.size()}"></c:out>);"/> 
            </c:when>
            <c:otherwise>
                <c:choose>
                    <c:when test="${fundCollection.type == 'EVENT'}"><c:set var="paymentButtonValue"> <fmt:message key="PAYMENT_DETAIL_BUTTON_报名" bundle="${bundle}"/></c:set></c:when>
                    <c:otherwise><c:set var="paymentButtonValue"> <fmt:message key="PAYMENT_DETAIL_BUTTON_订购" bundle="${bundle}"/></c:set></c:otherwise>
                </c:choose>
                <input type="button" name="Submit" class="collection_button FloatRight  MarginL7" value="${paymentButtonValue}" id="payment_btn" onclick="FundPayment.checkStepTwoForm('${fundCollection.type}',${fundCollection.payerInfoRequired},${fundCollection.payerMobileInfoRequired},${fundCollection.payerWorkInfoRequired}, ${user != null} ,<c:out default="0" value="${registerQuestions.size()}"></c:out>);"/> 
            </c:otherwise>
        </c:choose>

    </span>
    <input type="hidden" name="pmode_id" id="pmode_id" value="-1"/>    
    <input type="hidden" name="gateway_type" id="gateway_type" value="<c:choose><c:when test='${subCollectionOrder.isFree()}'>FREE</c:when><c:otherwise>-1</c:otherwise></c:choose>"/>
    <input type="hidden" name="chinabank_credit_card_sub" id="chinabank_credit_card_sub" value="-1"/>
    <input id="detail_pay_order" type="hidden" name="a" value="DETAIL_PAY_ORDER" />
    <input type="hidden" name="sub_order_serial_id" value="${subCollectionOrder.subSerialId}" />
    <input type="hidden" name="urlUserWantToAccess" id="login_redirect_url_field" value="/payment/payment_order/${subCollectionOrder.subSerialId}" />
    <input type="hidden" name="is_approval_order" id="is_approval_order" <c:choose><c:when test="${'INIT' == subCollectionOrder.getParentOrderCollection().getStatus() && subCollectionOrder.isContainsApprovalPrice()}">value="true"</c:when><c:otherwise>value="false"</c:otherwise></c:choose> />
    <%-- 操作成功、错误信息--%>
    <div class="noticeMessage FloatRight" id="payment_notice_div" style="display: none">
        <div class="wrongMessage" id="payment_wrong_msg_div" style="display: none"></div>
        <div class="loadingMessage" style="display: none" id="payment_loading_div">
            <fmt:message key="GLOBAL_MSG_LOADING" bundle="${bundle}"/><img src="/images/032.gif" alt="" />
        </div>
    </div>
    <%-- 币种转换提示信息--%>
    <div id="currency_convert_tip"  class="FloatRight MarginR10" style=" line-height:34px;">
        <div style="display:none" id="usd_tip">
        </div>
        <div style="display:none" id="cny_tip">
        </div>
    </div>
    <div class="clear"></div>
</div>
<script type="text/javascript">
    $(document).ready(
    function(){
        var isLogin = ${user != null};
        var isCollectEachAttendeeInfo = ${fundCollection.collectEachAttendeeInfo};
        FundPayment.initPages(isLogin, isCollectEachAttendeeInfo);
        // init gateway selects 
        GatewayPayment.initGatewaySelect("payment",${rateCNY2USD},${rateUSD2CNY},'<fmt:message key="PAYMENT_DETAIL_LABEL_请选择" bundle="${bundle}"/>',${user.totalBalance == null ? 0 : user.totalBalance});
        //init credit card expdate 
        var creditCardDiv = $("#credit_card_input_div");
        if(creditCardDiv.length>0){
            CreditCard.initExpdateDate();
        }
        //init bank list click event
        ChinaBank.initClickEvent();
    }
);
</script>
