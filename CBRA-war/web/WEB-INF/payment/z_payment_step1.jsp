<%-- 
    Document   : z_payment_step1
    Created on : Apr 23, 2012, 5:45:19 PM
    Author     : Swang
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div class="BlueBoxContent">
    <%--------------------------------------------门票列表 ---------------------------------------------------------%>
    <dl>
        <dd class="ticket">
            <span class="spanOne"><fmt:message key="PAYMENT_DETAIL_LABEL_种类" bundle="${bundle}"/></span>
            <%--List Header --%>
            <span class="spanFour TextAlignCenter">
                <c:choose>
                    <c:when test="${fundCollection.showTicketRemain}">
                        <c:choose>
                            <c:when test="${isHaveExposedPriceLimitMaxTotalCount}"><fmt:message key="PAYMENT_DETAIL_LABEL_还剩" bundle="${bundle}"/></c:when>
                            <c:otherwise>&nbsp;</c:otherwise>
                        </c:choose>
                    </c:when>
                    <c:otherwise>
                        &nbsp;
                    </c:otherwise>
                </c:choose>
            </span>
            <span class="spanFour TextAlignCenter">
                <c:choose>
                    <c:when test="${fundCollection.type == 'EVENT'}"><fmt:message key="PAYMENT_DETAIL_LABEL_截止" bundle="${bundle}"/></c:when>
                    <c:otherwise>&nbsp;</c:otherwise>
                </c:choose>
            </span>
            <span class="spanTwo TextAlignCenter"><fmt:message key="PAYMENT_DETAIL_LABEL_价格" bundle="${bundle}"/></span>
            <span class="spanThree TextAlignRight"><fmt:message key="PAYMENT_DETAIL_LABEL_数量" bundle="${bundle}"/></span>
        </dd>
    </dl>
    <dl class="active_dl">
        <c:choose>
            <c:when test="${not empty subCollectionOrder}">
                <%--In the step2 status,so the price is only for display,can't modify --%>
                <c:forEach var="orderItem" items="${subCollectionOrderItemList}" varStatus="status">
                    <c:set var="price" value="${orderItem.price}"></c:set>
                    <dd>
                        <%--门票名称 --%>
                        <span class="spanOne">
                            <span>
                                <c:choose>
                                    <c:when test="${empty price.name}"><fmt:message key="COLLECT_EDIT_TEXT_票价" bundle="${bundle}"/>${status.count}</c:when>
                                    <c:otherwise>${price.name}<c:if test="${price.requireApproval}"><span class="ColorOrange bold">*</span></c:if></c:otherwise>
                                </c:choose>
                            </span>
                            <c:if test="${not empty price.description && !price.showDescription}"><a href="javascript:void(0)" onclick="FundPayment.togglePriceDescrpiton(this);"><fmt:message key="GLOBAL_详情" bundle="${bundle}"/></a></c:if>
                        </span>
                        <%--余票数量 --%>    
                        <span class="spanFour TextAlignCenter">
                            <c:choose>
                                <c:when test="${!fundCollection.showTicketRemain || price.ticketRemain==null}">
                                    &nbsp;
                                </c:when>
                                <c:otherwise>
                                    <c:choose>
                                        <c:when test="${price.ticketRemain == 0}">
                                            <fmt:message key="PAYMENT_DETAIL_售罄" bundle="${bundle}"/>
                                        </c:when>
                                        <c:otherwise>
                                            ${price.ticketRemain}
                                        </c:otherwise>
                                    </c:choose>
                                </c:otherwise>
                            </c:choose>
                        </span>
                        <%--结束日期 --%>
                        <span class="spanFour TextAlignCenter">
                            <c:choose>
                                <c:when test="${!price.isStart()}">
                                    <fmt:message key="PAYMENT_DETAIL_未开始" bundle="${bundle}"/>
                                </c:when>
                                <c:when test="${price.isExpire()}">
                                    <fmt:message key="PAYMENT_DETAIL_已结束" bundle="${bundle}"/>
                                </c:when>
                                <c:when test="${not empty price.expireDate}">
                                    <fmt:formatDate value="${price.expireDate}" type="date" pattern="yyyy-MM-dd" />
                                </c:when>
                                <c:when test="${not empty fundCollection.eventEndDate}">
                                    <fmt:formatDate value="${fundCollection.eventEndDate}" type="date" pattern="yyyy-MM-dd" />
                                </c:when>
                                <c:otherwise>
                                    &nbsp;
                                </c:otherwise>
                            </c:choose>
                        </span>
                        <%--价格 --%>
                        <span class="spanTwo TextAlignCenter">
                            <c:choose>
                                <c:when test="${price.isFree()}">
                                    <fmt:message key="PAYMENT_PRICE_免费" bundle="${bundle}"/>
                                </c:when>
                                <c:otherwise>
                                    <fmt:formatNumber value="${price.amount}" type="currency"  pattern="¤#,##0.##" currencySymbol="${price.currencySign}" />
                                </c:otherwise>
                            </c:choose>
                        </span>
                        <%--选择数量 --%>
                        <span class="spanThree TextAlignRight ">
                            <label>
                                <b>${orderItem.quantity}</b>
                            </label>
                        </span>
                    <c:if test="${not empty price.description}">
                        <div class="TicketDescription" style="<c:if test="${!price.showDescription}">display: none</c:if>">
                        ${price.escapeNRDescription}
                    </div>
                    </c:if>
                    <div class="clear"></div>
                    </dd>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <%--In the step1 status,choose the price --%>
                <c:forEach var="price" items="${fundCollectionPriceList}" varStatus="status">
                    <c:if test="${price.requireApproval}">
                        <c:set var="requireApproval" value="${price.requireApproval}"></c:set>
                    </c:if>
                    <dd>
                        <%--门票名称 --%>
                        <span class="spanOne">
                            <span id="fund_collection_price[${status.index}].name">
                                <c:choose>
                                    <c:when test="${empty price.name}"><fmt:message key="COLLECT_EDIT_TEXT_票价" bundle="${bundle}"/>${status.count}</c:when>
                                    <c:otherwise>${price.name}<c:if test="${price.requireApproval}"><span class="ColorOrange bold">*</span></c:if></c:otherwise>
                                </c:choose>
                            </span>
                            <c:if test="${not empty price.description && !price.showDescription}"><a href="javascript:void(0)" onclick="FundPayment.togglePriceDescrpiton(this);"><fmt:message key="GLOBAL_详情" bundle="${bundle}"/></a></c:if>
                        </span>
                        <%--余票数量 --%>    
                        <span class="spanFour TextAlignCenter">
                            <c:choose>
                                <c:when test="${!fundCollection.showTicketRemain || price.ticketRemain==null}">
                                    &nbsp;
                                </c:when>
                                <c:otherwise>
                                    <c:choose>
                                        <c:when test="${price.ticketRemain == 0}">
                                            <fmt:message key="PAYMENT_DETAIL_售罄" bundle="${bundle}"/>
                                        </c:when>
                                        <c:otherwise>
                                            ${price.ticketRemain}
                                        </c:otherwise>
                                    </c:choose>
                                </c:otherwise>
                            </c:choose>
                        </span>
                        <%--结束日期 --%>
                        <span class="spanFour TextAlignCenter">
                            <c:choose>
                                <c:when test="${!price.isStart()}">
                                    <fmt:message key="PAYMENT_DETAIL_未开始" bundle="${bundle}"/>
                                </c:when>
                                <c:when test="${price.isExpire()}">
                                    <fmt:message key="PAYMENT_DETAIL_已结束" bundle="${bundle}"/>
                                </c:when>
                                <c:when test="${not empty price.expireDate}">
                                    <fmt:formatDate value="${price.expireDate}" type="date" pattern="yyyy-MM-dd" />
                                </c:when>
                                <c:when test="${not empty fundCollection.eventEndDate}">
                                    <fmt:formatDate value="${fundCollection.eventEndDate}" type="date" pattern="yyyy-MM-dd" />
                                </c:when>
                                <c:otherwise>
                                    &nbsp;
                                </c:otherwise>
                            </c:choose>
                        </span>
                        <%--价格 --%>
                        <span class="spanTwo TextAlignCenter">
                            <c:choose>
                                <c:when test="${price.isFree()}">
                                    <fmt:message key="PAYMENT_PRICE_免费" bundle="${bundle}"/>
                                </c:when>
                                <c:otherwise>
                                    <fmt:formatNumber value="${price.amount}" type="currency"  pattern="¤#,##0.##" currencySymbol="${price.currencySign}" />
                                </c:otherwise>
                            </c:choose>
                            <input type="hidden" name="order_collection_sub_item[${status.index}].list_order" value="${status.index}" />
                            <input type="hidden" name="order_collection_sub_item[${status.index}].unit_amount" value="${price.amount}" disabled="true"/>
                        </span>
                        <%--选择数量 --%>
                        <span class="spanThree TextAlignRight ">
                            <label>
                                <input type="hidden" name="order_collection_sub_item[${status.index}].price_id" value="${price.id}" />
                                <select class="Select40" name="order_collection_sub_item[${status.index}].quantity"
                                        <c:choose><c:when test='${price.requireApproval}'>id="order_collection_sub_item[${status.index}].approvalQuantity"</c:when><c:otherwise>id="order_collection_sub_item[${status.index}].quantity"</c:otherwise></c:choose>
                                    <c:if test="${!price.isPriceAvailable()}">disabled="disabled"</c:if> 
                                    onchange="FundPayment.setTotalAmount();">
                                    <c:choose>
                                        <c:when test="${not empty price.minCount && price.minCount>1}">
                                            <c:set var="startCount" value="${price.minCount}"></c:set>
                                        </c:when>
                                        <c:when test="${fundCollectionPriceList.size() == 1}">
                                            <%--只有一个票价，数量起始于1 --%>
                                            <c:set value="1" var="startCount"></c:set>
                                        </c:when>
                                        <c:otherwise>
                                            <c:set value="0" var="startCount"></c:set>
                                        </c:otherwise>
                                    </c:choose>
                                    <c:if test="${startCount > 1}">
                                        <option value="0">0</option>
                                    </c:if>
                                    <c:forEach begin="${startCount}" end="${price.getSelectableMaxCount()}" varStatus="innerStatus">
                                        <option value="${innerStatus.index}">${innerStatus.index}</option>
                                    </c:forEach>
                                </select>
                            </label>
                        </span>
                    <c:if test="${not empty price.description}">
                        <div class="TicketDescription" style="<c:if test="${!price.showDescription}">display: none</c:if>">
                        ${price.escapeNRDescription}
                    </div>
                    </c:if>
                    <div class="clear"></div>
                    </dd>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </dl>
    <%--审批说明 --%>
    <c:if test="${requireApproval}"><div><span class="ColorOrange bold">* <fmt:message key="COLLECT_EVENT_EDIT_TEXT_需经主办方审批" bundle="${bundle}"/></span><br/></div></c:if>
    <div class="MarginBottom5 MarginTop10 ">
        <%--折扣码输入框 --%>
        <c:if test="${!fundCollection.isEmptyDiscount()}">
            <div class="FloatLeft count_left">
                <c:if test="${empty subCollectionOrder}">
                    <%--Discount code before input container --%>
                    <span id="discount_before_input_container">
                        <a href="javascript:void(0);" onclick="FundPayment.showDiscountInputContainer();"><fmt:message key="PAYMENT_DETAIL_TEXT_我有折扣码" bundle="${bundle}"/></a>
                    </span>
                    <%--Discount code input container --%>
                    <span id="discount_input_container" style="display:none">
                        <span class="MarginR10">
                            <input name="discount_code" id="discount_code" type="text" />
                        </span>
                        <a href="javascript:void(0);" onclick="FundPayment.checkDiscount();"><fmt:message key="PAYMENT_DETAIL_TEXT_使用" bundle="${bundle}"/></a>
                        <span id="wrong_message_for_discount" class="wrongMessage" style="display:none"></span>
                    </span>
                </c:if>
                <%--Discount code after input container --%>
                <span id="discount_after_input_container" <c:if test="${subCollectionOrder.fundCollectionDiscount == null}">style="display:none"</c:if>>
                    <span class="MarginR10">
                        <font id="discount_name_container">${subCollectionOrder.fundCollectionDiscount.name}</font>
                        <fmt:message key="PAYMENT_DETAIL_TEXT_减" bundle="${bundle}"/>
                        <font id="discount_rate_container">
                            <c:if test="${subCollectionOrder.fundCollectionDiscount != null}">
                                <fmt:formatNumber value="${subCollectionOrder.fundCollectionDiscount.rate}" type="currency"  pattern="#,##0.##" />

                                <c:choose>
                                    <c:when test="${subCollectionOrder.fundCollectionDiscount.type == 'RATE'}">%</c:when>
                                    <c:otherwise>
                                        <c:choose>
                                            <c:when test="${subCollectionOrder.fundCollection.currencyType == 'CNY'}"><fmt:message key="GLOBAL_元/人民币" bundle="${bundle}"/></c:when>
                                            <c:otherwise><fmt:message key="GLOBAL_元/美元" bundle="${bundle}"/></c:otherwise>
                                        </c:choose>
                                    </c:otherwise>
                                </c:choose>
                            </c:if>

                        </font>&nbsp;
                        <fmt:message key="PAYMENT_DETAIL_TEXT_OFF" bundle="${bundle}"/>
                        <font id="discount_related_price_container">
                            <c:if test="${subCollectionOrder.fundCollectionDiscount != null}">
                                <c:choose>
                                    <c:when test="${subCollectionOrder.fundCollectionDiscount.isEnableToAllPrices()}">
                                        <fmt:message key="PAYMENT_EDIT_针对所有票价" bundle="${bundle}"/>
                                    </c:when>
                                    <c:otherwise>
                                        <fmt:message key="PAYMENT_EDIT_针对以下票价优惠" bundle="${bundle}"/>
                                        ${subCollectionOrder.fundCollectionDiscount.getEnablePriceNames()}
                                    </c:otherwise>
                                </c:choose>
                            </c:if>

                        </font>
                    </span>
                    <c:if test="${subCollectionOrder.fundCollectionDiscount == null}">
                        <a href="javascript:void(0);" onclick="FundPayment.resetDiscount()" id="discount_edit_link"><fmt:message key="WITHDRAW_ACCOUNT_LINK_编辑" bundle="${bundle}"/></a>
                    </c:if>
                </span>
            </div>
        </c:if>
        <%--价钱总计 --%>
        <div class="FloatRight TextAlignRight count_right" <c:if test="${isAllExposedPriceFree=='true'}">style="display:none"</c:if>>
            <%--未用折扣码前总计 --%>
            <p>
                <span><fmt:message key="PAYMENT_DETAIL_TEXT_小计" bundle="${bundle}"/>：</span> 
            <font id="currency_sign">${fundCollection.currencySign}</font><font id="payment_subamount_container"><fmt:formatNumber value="${subCollectionOrder.preDiscountAmount}" type="currency"  pattern="#,##0.##" /></font>
            </p>
            <div id="payment_amount_after_discount_container" <c:if test="${subCollectionOrder.fundCollectionDiscount == null}">style="display:none"</c:if>>
                <%--折扣总计 --%>
                <p>
                    <span><fmt:message key="PAYMENT_DETAIL_TEXT_折扣" bundle="${bundle}"/>：</span>
                    -${fundCollection.currencySign}<font id="discount_total_amount_container"><fmt:formatNumber value="${subCollectionOrder.discountAmount}" type="currency"  pattern="#,##0.##" /></font>
                </p>
                <%--使用折扣码后总计 --%>
                <p class="yellow">
                    <span><fmt:message key="PAYMENT_DETAIL_TEXT_总计" bundle="${bundle}"/>：</span>
                ${fundCollection.currencySign}<font id="payment_total_container"><fmt:formatNumber value="${subCollectionOrder.amount}" type="currency"  pattern="#,##0.##" /></font>
                </p>
                <input type="hidden" value="${subCollectionOrder.amount}" id="payment_amount" disabled="true"/>
                <c:if test="${not empty subCollectionOrder}"><input type="hidden" id="payment_balance_toggle_amount" disabled="true"/></c:if>
            </div>
        </div>
        <div class="clear"></div>
    </div>

</div>
<c:if test="${empty subCollectionOrderItemList}">
    <%--Payment Step 1 Button --%>
    <div  class='BlueBoxContent TextAlignRight' id="payment_step1_button_container">
        <div class="Margin22">   
            <span class="FloatRight">
                <%--Set button text --%>
                <%--<c:choose>
                    <c:when test="${fundCollection.isCollectionActive() && isAllExposedPriceExpire}">
                        <c:set var="paymentButtonValue"><fmt:message key="PAYMENT_DETAIL_BUTTON_加入候选名单" bundle="${bundle}"/></c:set>
                    </c:when>
                    <c:otherwise>--%>
                <c:choose>
                    <c:when test="${fundCollection.type == 'EVENT'}"><c:set var="paymentButtonValue"> <fmt:message key="PAYMENT_DETAIL_BUTTON_报名" bundle="${bundle}"/></c:set></c:when>
                    <c:otherwise><c:set var="paymentButtonValue"> <fmt:message key="PAYMENT_DETAIL_BUTTON_订购" bundle="${bundle}"/></c:set></c:otherwise>
                </c:choose>
                <%--</c:otherwise>
            </c:choose>--%>
                <%--Buttons --%>
                <c:choose>
                    <c:when test="${!fundCollection.isCollectionActive() || isAllExposedPriceSoldOut}">
                        <input type="button" class="gray_button" value="${paymentButtonValue}"/>
                    </c:when>
                    <c:when test="${isAllExposedPriceExpire}">
                        <input type="button" disabled="disabled" class="gray_button" onclick="FundPayment.checkStepOneForm();" value="${paymentButtonValue}"/>
                    </c:when>
                    <c:otherwise>
                        <input type="button" class="collection_button" onclick="FundPayment.checkStepOneForm();" value="${paymentButtonValue}"/>
                    </c:otherwise>
                </c:choose>
            </span>
            <c:choose>
                <c:when test="${isAllExposedPriceExpire && fundCollection.isCollectionActive()}">
                    <%--<span class="FloatRight WaitingListMessage"><fmt:message key="PAYMENT_DETAIL_报名已截止但您可以申请加入候补名单" bundle="${bundle}"/></span>--%>
                </c:when>
                <c:otherwise>
                    <span class="FloatRight MarginTop10 MarginR10">
                        <c:if test="${!isAllExposedPriceFree}">
                            <img src="/images/icon_zhifu.png" width="218" height="24" />
                        </c:if>
                    </span>
                </c:otherwise>
            </c:choose>
            <div class="clear"></div>
        </div>
    </div>
</c:if>
<script type="text/javascript">
    $(document).ready(
    function(){
        var orderExist = ${not empty subCollectionOrder};
        if(!orderExist) {
            FundPayment.setTotalAmount();
        }
        
    }
);
</script>   
