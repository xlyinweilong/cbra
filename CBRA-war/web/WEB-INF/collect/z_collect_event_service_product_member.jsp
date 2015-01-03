<%-- 
    Document   : 活动收款模版
    Created on : Mar 27, 2012, 4:33:00 PM
    Author     : Swang
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<c:if test="${not empty saveSuccess}">
    <h3 class="nolist">
        <fmt:message key='COLLECT_EVENT_EDIT_LABEL_保存成功' bundle='${bundle}'/> 
        <a href="/${payLinkVal}/${fundCollection.webId}" target="_blank" class="MarginL15"><fmt:message key='COLLECT_EVENT_EDIT_LABEL_预览' bundle='${bundle}'/></a>
    </h3>
</c:if>
<%--设置i18n文本变量 --%>
<c:choose>
    <c:when test="${'EVENT'==collectionType}">
        <c:set var="labelBasicInfo"><fmt:message key="COLLECT_EVENT_EDIT_LABEL_门票信息" bundle="${bundle}"/></c:set>
        <c:set var="labelInputCollectionName"><fmt:message key="COLLECT_EVENT_EDIT_TEXT_活动名称" bundle="${bundle}"/></c:set>
        <c:set var="labelInputCollectionLink"><fmt:message key="COLLECT_EDIT_TEXT_活动链接" bundle="${bundle}"/></c:set>
        <c:set var="remarkBasicInfo"><fmt:message key="COLLECT_EVENT_EDIT_TEXT_请填写收款金额与理由" bundle="${bundle}"/></c:set>
        <c:set var="labelPriceCategory"><fmt:message key="COLLECT_EVENT_EDIT_LABEL_门票种类" bundle="${bundle}"/></c:set>
        <c:set var="theadPriceName"><fmt:message key='COLLECT_EVENT_EDIT_TEXT_票价名称' bundle="${bundle}"/></c:set>
        <c:set var="theadPriceCount"><fmt:message key='COLLECT_EVENT_LABEL_票量' bundle="${bundle}"/></c:set>
        <c:set var="theadPriceAmount"><fmt:message key="COLLECT_EVENT_EDIT_TEXT_票价" bundle="${bundle}"/></c:set>
        <c:set var="theadPriceCurrencyType"><fmt:message key="COLLECT_EVENT_EDIT_TEXT_币种" bundle="${bundle}"/></c:set>
        <c:set var="theadPriceFree"><fmt:message key="COLLECT_EVENT_EDIT_LABEL_免费" bundle="${bundle}"/></c:set>
        <c:set var="priceNameDefaultText"><fmt:message key='COLLECT_EVENT_EDIT_TEXT_票价种类名称' bundle="${bundle}"/></c:set>
        <c:set var="remarkPriceCategory"><fmt:message key="COLLECT_EVENT_EDIT_TEXT_您可以提供一种或多种门票" bundle="${bundle}"/></c:set>
        <c:set var="remarkDiscounts"><fmt:message key="COLLECT_EVENT_EDIT_TEXT_您可以针对不同参加者，提供不同的折扣，来推广活动" bundle="${bundle}"/></c:set>
    </c:when>
    <c:when test="${'SERVICE'==collectionType}">
        <c:set var="labelBasicInfo"><fmt:message key="COLLECT_SERVICE_EDIT_LABEL_服务基本信息" bundle="${bundle}"/></c:set>
        <c:set var="labelInputCollectionName"><fmt:message key="COLLECT_SERVICE_EDIT_TEXT_服务名称" bundle="${bundle}"/></c:set>
        <c:set var="labelInputCollectionLink"><fmt:message key="COLLECT_EDIT_TEXT_服务链接" bundle="${bundle}"/></c:set>
        <c:set var="remarkBasicInfo"><fmt:message key="COLLECT_SERVICE_EDIT_TEXT_请填写收款金额与理由" bundle="${bundle}"/></c:set>
        <c:set var="labelPriceCategory"><fmt:message key="COLLECT_SERVICE_EDIT_LABEL_服务种类" bundle="${bundle}"/></c:set>
        <c:set var="theadPriceName"><fmt:message key='COLLECT_SERVICE_EDIT_TEXT_票价名称' bundle="${bundle}"/></c:set>
        <c:set var="theadPriceCount"><fmt:message key='COLLECT_SERVICE_LABEL_票量' bundle="${bundle}"/></c:set>
        <c:set var="theadPriceAmount"><fmt:message key="COLLECT_SERVICE_EDIT_TEXT_票价" bundle="${bundle}"/></c:set>
        <c:set var="theadPriceCurrencyType"><fmt:message key="COLLECT_EVENT_EDIT_TEXT_币种" bundle="${bundle}"/></c:set>
        <c:set var="theadPriceFree"><fmt:message key="COLLECT_EVENT_EDIT_LABEL_免费" bundle="${bundle}"/></c:set>
        <c:set var="priceNameDefaultText"><fmt:message key='COLLECT_SERVICE_EDIT_TEXT_票价种类名称' bundle="${bundle}"/></c:set>
        <c:set var="remarkPriceCategory"><fmt:message key="COLLECT_SERVICE_EDIT_TEXT_您可以提供一种或多种门票" bundle="${bundle}"/></c:set>
        <c:set var="remarkDiscounts"><fmt:message key="COLLECT_SERVICE_EDIT_TEXT_您可以针对不同参加者，提供不同的折扣，来推广活动" bundle="${bundle}"/></c:set>
    </c:when>
    <c:when test="${'MEMBER'==collectionType}">
        <c:set var="labelBasicInfo"><fmt:message key="COLLECT_MEMBER_EDIT_LABEL_会员费基本信息" bundle="${bundle}"/></c:set>
        <c:set var="labelInputCollectionName"><fmt:message key="COLLECT_MEMBER_EDIT_TEXT_会员费" bundle="${bundle}"/></c:set>
        <c:set var="labelInputCollectionLink"><fmt:message key="COLLECT_EDIT_TEXT_会员链接" bundle="${bundle}"/></c:set>
        <c:set var="remarkBasicInfo"><fmt:message key="COLLECT_MEMBER_EDIT_TEXT_请填写收款金额与理由" bundle="${bundle}"/></c:set>
        <c:set var="labelPriceCategory"><fmt:message key="COLLECT_MEMBER_EDIT_LABEL_会员费种类" bundle="${bundle}"/></c:set>
        <c:set var="theadPriceName"><fmt:message key='COLLECT_MEMBER_EDIT_TEXT_票价名称' bundle="${bundle}"/></c:set>
        <c:set var="theadPriceCount"><fmt:message key='COLLECT_MEMBER_LABEL_票量' bundle="${bundle}"/></c:set>
        <c:set var="theadPriceAmount"><fmt:message key="COLLECT_MEMBER_EDIT_TEXT_票价" bundle="${bundle}"/></c:set>
        <c:set var="theadPriceCurrencyType"><fmt:message key="COLLECT_EVENT_EDIT_TEXT_币种" bundle="${bundle}"/></c:set>
        <c:set var="theadPriceFree"><fmt:message key="COLLECT_EVENT_EDIT_LABEL_免费" bundle="${bundle}"/></c:set>
        <c:set var="priceNameDefaultText"><fmt:message key='COLLECT_MEMBER_EDIT_TEXT_票价种类名称' bundle="${bundle}"/></c:set>
        <c:set var="remarkPriceCategory"><fmt:message key="COLLECT_MEMBER_EDIT_TEXT_您可以提供一种或多种门票" bundle="${bundle}"/></c:set>
        <c:set var="remarkDiscounts"><fmt:message key="COLLECT_MEMBER_EDIT_TEXT_您可以针对不同参加者，提供不同的折扣，来推广活动" bundle="${bundle}"/></c:set>
    </c:when>
    <c:when test="${'PRODUCT'==collectionType}">
        <c:set var="labelBasicInfo"><fmt:message key="COLLECT_PRODUCT_EDIT_LABEL_产品基本信息" bundle="${bundle}"/></c:set>
        <c:set var="labelInputCollectionName"><fmt:message key="COLLECT_PRODUCT_EDIT_TEXT_产品" bundle="${bundle}"/></c:set>
        <c:set var="labelInputCollectionLink"><fmt:message key="COLLECT_EDIT_TEXT_产品链接" bundle="${bundle}"/></c:set>
        <c:set var="remarkBasicInfo"><fmt:message key="COLLECT_PRODUCT_EDIT_TEXT_请填写收款金额与理由" bundle="${bundle}"/></c:set>
        <c:set var="labelPriceCategory"><fmt:message key="COLLECT_PRODUCT_EDIT_LABEL_产品种类" bundle="${bundle}"/></c:set>
        <c:set var="theadPriceName"><fmt:message key='COLLECT_PRODUCT_EDIT_TEXT_票价名称' bundle="${bundle}"/></c:set>
        <c:set var="theadPriceCount"><fmt:message key='COLLECT_PRODUCT_LABEL_票量' bundle="${bundle}"/></c:set>
        <c:set var="theadPriceAmount"><fmt:message key="COLLECT_PRODUCT_EDIT_TEXT_票价" bundle="${bundle}"/></c:set>
        <c:set var="theadPriceCurrencyType"><fmt:message key="COLLECT_EVENT_EDIT_TEXT_币种" bundle="${bundle}"/></c:set>
        <c:set var="theadPriceFree"><fmt:message key="COLLECT_EVENT_EDIT_LABEL_免费" bundle="${bundle}"/></c:set>
        <c:set var="priceNameDefaultText"><fmt:message key='COLLECT_PRODUCT_EDIT_TEXT_票价种类名称' bundle="${bundle}"/></c:set>
        <c:set var="remarkPriceCategory"><fmt:message key="COLLECT_PRODUCT_EDIT_TEXT_您可以提供一种或多种门票" bundle="${bundle}"/></c:set>
        <c:set var="remarkDiscounts"><fmt:message key="COLLECT_PRODUCT_EDIT_TEXT_您可以针对不同参加者，提供不同的折扣，来推广活动" bundle="${bundle}"/></c:set>
    </c:when>
</c:choose>
<dl class="dlEdit">
    <dt> 
        <c:if test="${collectionType=='EVENT'}">
        <div class="TheEnd">
            <c:if test="${empty fundCollection}">
                <a href="javascript:void(0);" onclick="templateListDialog.open();">
                    <fmt:message key="COLLECT_EVENT_EDIT_LABEL_使用模板生成活动" bundle="${bundle}" />
                </a>
            </c:if>
            <c:if test="${not empty fundCollection && fundCollection.status!='FINISHED'}">
                <a href="javascript:void(0);" onclick="DeactiveCollectionDialog.open();">
                    <fmt:message key="COLLECT_EVENT_EDIT_LABEL_结束此活动" bundle="${bundle}" />
                </a>
            </c:if>
            <c:if test="${not empty fundCollection && fundCollection.status=='FINISHED'}">
                <a href="javascript:void(0);" onclick="ActiveCollectionDialog.open();">
                    <fmt:message key="COLLECT_EVENT_EDIT_LABEL_重新启用此活动" bundle="${bundle}" />
                </a>
            </c:if>
            <%--
    <c:if test="${not empty fundCollection}">
        <a href="javascript:void(0);" onclick="DeleteCollectionDialog.open();">
            &nbsp;&nbsp;&nbsp;<fmt:message key="COLLECT_EVENT_EDIT_LABEL_删除此活动" bundle="${bundle}" />
        </a>
    </c:if>
            --%>
        </div>
    </c:if>
    ${labelBasicInfo}
</dt>
<%----------------------------------------收款基本信息--------------------------------------------------%>
<dd class="left">
    <%--收款类型 --%>
    <input type="hidden" name="type" value="${collectionType}" id="collection_type_input"/>
    <%--收款价格类型为MULTIPLE --%>
    <input type="hidden" name="unit_amount_type" value="MULTIPLE" />
    <%--收款名称 --%>
    <div class="sk-item-edit">
        <label class="sk-label-edit ">${labelInputCollectionName}</label>
        <input type="text" class="Input450" name="title" value="${fundCollection.getEscapeQuotTitle()}" />
    </div>
    <c:if test="${collectionType=='EVENT'}">
        <%--活动时间和地点--%>
        <div class="sk-item-edit">
            <label class="sk-label-edit "><fmt:message key="COLLECT_EDIT_TEXT_活动时间" bundle="${bundle}"/></label>
            <input type="text" class="Input144 FloatLeft MarginL7" name="event_begin_date" id="event_begin_date"  readonly="readonly"
                   value="<fmt:formatDate value='${fundCollection.eventBeginDate}' type='date' pattern='${dateStyle}' />"
                   />
            <select name="event_begin_time" class="Input184 Select70 FloatLeft MarginL7" id="event_begin_time">
            </select>
            <span class="FloatLeft">&nbsp;-&nbsp;</span> 
            <input type="text" class="Input144 FloatLeft" name="event_end_date" id="event_end_date" readonly="readonly"
                   value="<fmt:formatDate value="${fundCollection.eventEndDate}" type="date" pattern="${dateStyle}" />" 
                   />
            <select name="event_end_time" class="Input184 Select70 FloatLeft MarginL7" id="event_end_time">
            </select>
            <input type="checkbox" name="event_date_whole_day" class="FloatRight EventCheckbox" id="event_date_whole_day" value="true"/><span><fmt:message key="COLLECT_EDIT_TEXT_全天" bundle="${bundle}"/></span>
        </div>
        <div class="sk-item-edit"> 
            <label class="sk-label-edit " ><fmt:message key="COLLECT_EDIT_TEXT_活动地点" bundle="${bundle}"/></label>
            <input type="text" class="Input450" name="eventPlace" value="${fundCollection.eventLocation}" id="eventPlace" />
        </div>
    </c:if>
    <%--活动链接 --%>
    <div class="sk-item-edit TextAlignLeft"> 
        <label class="sk-label-edit " >
            ${labelInputCollectionLink}
        </label>
        <div class="MarginL7">
            <span id="collect_default_webId_span" style="font-size: 16px;">
                https://yoopay.cn/${payLinkVal}/ <input type="text" class="Input154" id="custom_webid" 
                                                        name="custom_webid"
                                                        <c:if test="${'EVENT'==collectionType}">onblur="FundCollectionReferral.updateAllLinkText();"</c:if>
                                                        value="<c:choose><c:when test="${not empty fundCollection && !useTemplate}">${fundCollection.webId}</c:when><c:otherwise>${uniqueWebCollectionWebId}</c:otherwise></c:choose>" />
                <a href="javascript:void(0);" onclick="FundCollection.checkWebId('${useTemplate ? "": fundCollection.webId}');" class="MarginL7">
                    <fmt:message key="GLOBAL_保存" bundle="${bundle}"/>
                </a>
            </span>
            <div class="wrongMessage" id="custom_webid_message" <c:if test="${empty webIdExist}">style="display:none"</c:if>>${webIdExist}</div>
            </div>
        </div>
    <c:if test="${collectionType=='EVENT'}">
        <%--活动主办方--%>
        <div class="sk-item-edit TextAlignLeft">
            <label class="sk-label-edit " ><fmt:message key="COLLECT_EDIT_TEXT_主办方" bundle="${bundle}"/></label>
            <span id="event_host_default_container" class="MarginL7">
                <span id="event_host_default_text">
                    <c:choose>
                        <c:when test="${fundCollection.eventHost != null}">
                            ${fundCollection.eventHost}
                        </c:when>
                        <c:otherwise>
                            ${user.getDisplayName()}
                        </c:otherwise>
                    </c:choose>
                </span>
                <a href="javascript:void(0);" onclick="FundCollection.showEventHostEdit();"><fmt:message key="GLOBAL_编辑" bundle="${bundle}"/></a>
            </span>
            <div id="event_host_custom_container" style="display: none">
                <span style="font-size: 16px;" >
                    <input type="text" id="event_host" name="event_host" 
                           value="<c:choose><c:when test="${fundCollection.eventHost != null}">${fundCollection.eventHost}</c:when><c:otherwise>${user.getDisplayName()}</c:otherwise></c:choose>"
                                   class="Input330 MarginL7"/>
                                   <a href="javascript:void(0);" onclick="FundCollection.cancelEventHostEdit();"  class="MarginL7" ><fmt:message key="GLOBAL_取消" bundle="${bundle}"/></a>
                </span>
                <div class="MarginTop10" style="padding-left:7px;float:left;overflow:hidden;width:220px; margin-bottom:10px;"><textarea id="event_host_desc" class="textareaH50 textareaH100 MarginL7 " name="event_host_desc" rows="5" cols="45">${fundCollection.eventHostDesc}</textarea>
                </div>
                <div style="padding-top:3px">
                    <fmt:message key="COLLECT_EDIT_TEXT_主办方编辑器宽度说明" bundle="${bundle}"/>
                </div>
            </div>
        </div>
        <%--活动Banner --%>
        <div class="sk-item-edit TextAlignLeft">
            <label class="sk-label-edit " ><fmt:message key="COLLECT_EDIT_TEXT_上传横幅" bundle="${bundle}"/></label>
            <input type="file" class="MarginL7" name="event_banner" onchange="FundCollection.displayShowInfoOnBannerContainer();"/>
            <c:if test="${fundCollection.getEventBannerUrl()!=null}">
                <a id= "event_banner_del1" href="${fundCollection.getEventBannerUrl()}" class="MarginL7 " target="_blank"><fmt:message key="COLLECT_EDIT_TEXT_查看横幅" bundle="${bundle}"/></a> 
                <a id ="event_banner_del2" href="javascript:void(0)" onclick = "CollectionEventUpload.del('${fundCollection.webId}','event_banner','event_banner_del1','event_banner_del2')">
                    <fmt:message key="COLLECT_EDIT_TEXT_删除" bundle="${bundle}"/>
                </a>
            </c:if>
        </div>
        <div class="sk-item-edit TextAlignLeft" <c:if test="${fundCollection.getEventBannerUrl()==null}">style="display: none"</c:if> id="showInfoOnBannerContainer">
                <label class="sk-label-edit " >&nbsp;</label> 
                <input type="checkbox" value="true" name="show_info_on_banner" <c:if test="${empty fundCollection || fundCollection.showInfoOnBanner}">checked="true"</c:if> /><fmt:message key="COLLECT_EDIT_TEXT_在横幅上显示信息" bundle="${bundle}"/>
            </div>
        <%--活动logo --%>
        <div class="sk-item-edit TextAlignLeft">
            <label class="sk-label-edit " ><fmt:message key="COLLECT_EDIT_TEXT_上传logo" bundle="${bundle}"/></label>
            <input type="file"  name="event_logo" class="MarginL7" id="event_logo"/>
            <c:if test="${fundCollection.getEventLogoUrl()!=null}">
                <a id="event_logo_del1" href="${fundCollection.getEventLogoUrl()}" class="MarginL7 " target="_blank"><fmt:message key="COLLECT_EDIT_TEXT_查看logo" bundle="${bundle}"/></a>
                <a id="event_logo_del2" href="javascript:void(0)" onclick = "CollectionEventUpload.del('${fundCollection.webId}','event_logo','event_logo_del1','event_logo_del2')">
                    <fmt:message key="COLLECT_EDIT_TEXT_删除" bundle="${bundle}"/>
                </a>
            </c:if>
        </div>
        <%--活动地图 --%>
        <div class="sk-item-edit TextAlignLeft">
            <label class="sk-label-edit " ><fmt:message key="COLLECT_EDIT_TEXT_上传地图" bundle="${bundle}"/></label>
            <input type="file"  name="event_map" class="MarginL7" id="event_map"/>
            <c:if test="${fundCollection.getEventMapUrl()!=null}">
                <a id="event_map_del1" href="${fundCollection.getEventMapUrl()}" class="MarginL7 " target="_blank"><fmt:message key="COLLECT_EDIT_TEXT_查看地图" bundle="${bundle}"/></a>
                <a id="event_map_del2" href="javascript:void(0)" onclick = "CollectionEventUpload.del('${fundCollection.webId}','event_map','event_map_del1','event_map_del2')">
                    <fmt:message key="COLLECT_EDIT_TEXT_删除" bundle="${bundle}"/>
                </a>
            </c:if>
        </div>

    </c:if>
</dd>
<dd class="right">${remarkBasicInfo}</dd>
<div class="clear"></div>
<dd class="left">
    <%--海报--%>
    <dl class="dlEdit">
        <c:choose>
            <c:when test="${collectionType=='EVENT'}">
                <dt><fmt:message key="COLLECT_EDIT_LABEL_上传活动宣传海报" bundle="${bundle}"/></dt>
            </c:when>
            <c:when test="${collectionType=='SERVICE'}">
                <dt><fmt:message key="COLLECT_EDIT_LABEL_上传服务宣传海报" bundle="${bundle}"/></dt>
            </c:when>
            <c:when test="${collectionType=='PRODUCT'}">
                <dt><fmt:message key="COLLECT_EDIT_LABEL_上传产品宣传广告" bundle="${bundle}"/></dt>
            </c:when>
            <c:when test="${collectionType=='MEMBER'}">
                <dt><fmt:message key="COLLECT_EDIT_LABEL_上传会员费宣传海报" bundle="${bundle}"/></dt>
            </c:when>
        </c:choose>
        <dd class="left">
            <div class="sk-item-edit TextAlignLeft">
                <label class="sk-label-edit " ><fmt:message key="COLLECT_EDIT_TEXT_上传海报" bundle="${bundle}"/></label>
                <input type="file" class="MarginL7" name="event_poster" />
                <c:if test="${fundCollection.getEventPosterUrl()!=null}">
                    <a id ="event_poster_del1" href="${fundCollection.getEventPosterUrl()}" class="MarginL7 " target="_blank"><fmt:message key="COLLECT_EDIT_TEXT_查看海报" bundle="${bundle}"/></a> 
                    <a id ="event_poster_del2" href="javascript:void(0)" onclick = "CollectionEventUpload.del('${fundCollection.webId}','event_poster','event_poster_del1','event_poster_del2')">
                        <fmt:message key="COLLECT_EDIT_TEXT_删除" bundle="${bundle}"/>
                    </a>
                </c:if>
            </div>
        </dd>
        <dd class="right"><fmt:message key="COLLECT_EVENT_EDIT_TEXT_上传海报右侧说明" bundle="${bundle}"/></dd>
        <div class="clear"></div>
    </dl>
</dd>
<div class="clear"></div>
</dl> 
<%----------------------------------------附件和详细说明----------------------------------------------------%>
<%--收款附件信息 --%>
<dl class="dlEdit dlEditOne" style="margin-bottom:0px;">
    <dt><fmt:message key="COLLECT_EDIT_LABEL_TITLE_上传附件" bundle="${bundle}"/></dt>
    <dd>
        <c:if test="${not empty fundCollection.fundCollectionDesAttatch}">

            <dl class=" AttachmentMessage">
                <dt><fmt:message key="PAYMENT_DETAIL_LABEL_附件" bundle="${bundle}"/></dt>
                <c:forEach var="attatch" items="${fundCollection.fundCollectionDesAttatch}" varStatus="status">
                    <c:if test="${!attatch.deleted}">
                        <dd id="attatch_${attatch.id}" class="${attatch.getFileType()}">
                            <a href="javascript:;"onclick="Collect.downloadAttatch(${attatch.id});return false;">
                                <c:choose>
                                    <c:when test="${not empty attatch.customedFileName}">
                                        ${attatch.customedFileName}
                                    </c:when>
                                    <c:otherwise>
                                        ${attatch.fileName}
                                    </c:otherwise>
                                </c:choose>
                            </a> 
                            <a href="javascript:;" class="MarginL7" onclick="$('#attatch_${attatch.id}').remove()">
                                <fmt:message key="WITHDRAW_ACCOUNT_LINK_删除" bundle="${bundle}"/>
                            </a>
                            <input name="attatch_id" value="${attatch.id}" type="hidden"/>
                        </dd>
                    </c:if>
                </c:forEach>
                <div class="clear"></div>
            </dl></c:if>
        </dd>
        <dd class="left">
            <div class=" TextAlignLeft" style="line-height:33px;">
            <%--<div><fmt:message key="COLLECT_EDIT_LABEL_上传附件" bundle="${bundle}"/></div>--%>
            <div id="collect_attatch">
                <input name="attach_customed_name0" class="Input120" type="text"onfocus="Collect.eventOnfocus('<fmt:message key='COLLECT_EDIT_TEXT_附件名称' bundle="${bundle}"/>',this)" onblur="Collect.eventOnBlur('<fmt:message key='COLLECT_EDIT_TEXT_附件名称' bundle="${bundle}"/>',this)"value="<fmt:message key='COLLECT_EDIT_TEXT_附件名称' bundle="${bundle}"/>" style="color:#999999" />
                <input name="attach0" type="file" /> 
                <a id="attach_add" href="javascript:void(0);">
                    <fmt:message key="COLLECT_EDIT_TEXT_+添加" bundle="${bundle}"/>
                </a>
            </div>
            <div id="collect_attatchs"></div>
        </div>
    </dd>
    <dd class="right">
        <c:choose>
            <c:when test="${'EVENT'==collectionType}">
                <fmt:message key="COLLECT_EVENT_EDIT_TEXT_您可以添加附件文档和其他补充说明" bundle="${bundle}"/>
            </c:when>
            <c:when test="${'DONATION'==collectionType}">
                <fmt:message key="COLLECT_DONATION_EDIT_TEXT_您可以添加附件文档和其他补充说明" bundle="${bundle}"/>
            </c:when>
            <c:when test="${'SERVICE'==collectionType}">
                <fmt:message key="COLLECT_SERVICE_EDIT_TEXT_您可以添加附件文档和其他补充说明" bundle="${bundle}"/>
            </c:when>
            <c:when test="${'MEMBER'==collectionType}">
                <fmt:message key="COLLECT_MEMBER_EDIT_TEXT_您可以添加附件文档和其他补充说明" bundle="${bundle}"/>
            </c:when>
            <c:when test="${'PRODUCT'==collectionType}">
                <fmt:message key="COLLECT_PRODUCT_EDIT_TEXT_您可以添加附件文档和其他补充说明" bundle="${bundle}"/>
            </c:when>
            <c:otherwise>
                <fmt:message key="COLLECT_EDIT_TEXT_您可以添加附件文档和其他补充说明" bundle="${bundle}"/>
            </c:otherwise>
        </c:choose>
    </dd>
    <div class="clear"></div>
</dl>
<dl class="dlEdit" style="margin-top:0px;">
    <%--收款详情 --%>
    <dl class="dlEdit">
        <dt><fmt:message key="COLLECT_EDIT_LABEL_DETAIL" bundle="${bundle}"/></dt>
        <dd> 
            <div>
                <textarea name="detailDesc" id="detailDesc" class="textarea450" >${fundCollection.detailDescHtml}</textarea>
                <div class="clear"></div>
            </div>
        </dd>
        <div class="clear"></div>
    </dl>
    <%----------------------------------------收款票价----------------------------------------------------%>
    <dl class="dlEdit">
        <dt>
            ${labelPriceCategory}&nbsp;&nbsp;
            <span>
                <a href="javascript:void(0);" onclick="FundCollectionPrice.addOption();">
                    <fmt:message key="COLLECT_EDIT_TEXT_+添加新票价" bundle="${bundle}"/>
                </a>
            </span>
        </dt>
        <dd class="left">
            <div id="price_divs">
                <c:if test="${collectionType=='EVENT'}">
                    <%--支付页面是否显示剩余票数信息 --%>
                    <div style="margin-bottom: 5px">
                        <fmt:message key="COLLECT_EVENT_EDIT_LABEL_剩余票数" bundle="${bundle}"/>：
                        <input type="radio" name="showTicketRemain" value="false" <c:if test="${empty fundCollection || !fundCollection.showTicketRemain}">checked="true"</c:if>><fmt:message key="COLLECT_EVENT_EDIT_LABEL_不显示剩余票数" bundle="${bundle}"/>
                        <input type="radio" name="showTicketRemain" value="true" <c:if test="${not empty fundCollection && fundCollection.showTicketRemain}">checked="true"</c:if>><fmt:message key="COLLECT_EVENT_EDIT_LABEL_显示剩余票数" bundle="${bundle}"/>
                        </div>
                </c:if>
                <table class="history_table MarginBottom20" width="100%" cellspacing="0" cellpadding="0" border="0">
                    <thead>
                        <tr>
                            <td>${theadPriceName}</td>
                            <td>${theadPriceCount}</td>
                            <td>${theadPriceAmount}</td>
                            <td>${theadPriceCurrencyType}</td>
                            <td width="42">${theadPriceFree}</td>
                            <td width="42">&nbsp;</td>
                        </tr>
                    </thead>
                    <tbody id="collect_prices_container">
                        <c:choose>
                            <c:when test="${not empty fundCollection && fundCollectionPriceList.size()>0}">
                                <%--编辑收款票价 --%>
                                <c:forEach var="price" items="${fundCollectionPriceList}" varStatus="status">
                                    <tr class="white basic_inputs_container">
                                        <td>
                                            <input type="text"
                                                   value="${price.name}" 
                                                   onblur="FundCollectionPrice.synFundCollectionDiscountAndReferral(this, '${priceNameDefaultText}')"
                                                   class="Input154"  name="fund_collection_price[${status.index}].name" />
                                        </td>
                                        <td><input class="Input40" name="fund_collection_price[${status.index}].maxTotalCount" value="${price.maxTotalCount}"/></td>
                                        <td>
                                            <input type="text" class="Input40" name='fund_collection_price[${status.index}].amount' 
                                                   value="<fmt:formatNumber value="${price.amount}" type="currency"  pattern="###0.##"/>"
                                                   onblur="FundCollectionPrice.synFundCollectionDiscountAndReferral(this, '')"/>
                                        </td>
                                        <td>
                                            <select class="Input184 Select124" name="fund_collection_price[${status.index}].currency_type" onchange="FundCollectionPrice.synCurrencyType(this)">
                                                <option value="CNY" <c:if test="${price.currencyType=='CNY'}">selected="true"</c:if>><fmt:message key="COLLECT_EDIT_LABEL_UNIT" bundle="${bundle}"/></option>
                                                <option value="USD" <c:if test="${price.currencyType=='USD'}">selected="true"</c:if>><fmt:message key="COLLECT_EDIT_LABEL_元/美元" bundle="${bundle}"/></option>
                                                </select> 
                                            </td>
                                            <td width="42"><input class="EventCheckbox" type="checkbox" onclick="FundCollectionPrice.setFreeAmount(this);" <c:if test="${price.isFree()}">checked="true"</c:if>></td>
                                            <td>
                                                <input type="hidden" name="fund_collection_price[${status.index}].order" 
                                                   <c:choose>
                                                       <c:when test="${price.order == -1}">value="${status.index}"</c:when>
                                                       <c:otherwise>value="${price.order}"</c:otherwise>
                                                   </c:choose> />
                                            <input type="hidden" name="fund_collection_price[${status.index}].id" value="${price.id}" />
                                            <input type="hidden" name="fund_collection_price[${status.index}].deleted" value="${price.deleted}" />
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
                                                    <p><textarea name="fund_collection_price[${status.index}].description" style="color: black" class="TextareaPaymentMessage">${price.description}</textarea></p>
                                                    <p>
                                                        <input type="checkbox"  name="fund_collection_price[${status.index}].show_description" value="false" <c:if test="${!price.showDescription}">checked="true"</c:if>/>
                                                        <fmt:message key="COLLECT_EVENT_EDIT_LABEL_在活动页面上隐藏此描述" bundle="${bundle}"/>
                                                    </p>
                                                </div>
                                                <%--票价有效期：开始与结束时间 --%>
                                                <div class="sk-item-edit-ticket">
                                                    <label class="sk-label-edit-ticket "><b><fmt:message key="COLLECT_EVENT_EDIT_LABEL_优惠结束时间" bundle="${bundle}"/></b></label>
                                                    <p><fmt:message key="COLLECT_EVENT_EDIT_LABEL_开始时间" bundle="${bundle}"/></p>
                                                    <p>
                                                        <input  class="Input130 FloatLeft" type="text"
                                                                name="fund_collection_price[${status.index}].startDate" value="<fmt:formatDate pattern="${dateStyle}" value="${price.startDate}"/>">
                                                        <select  class="Input184 Select70 FloatLeft MarginL7" name="fund_collection_price[${status.index}].startTime" cvalue="<fmt:formatDate pattern="HH:mm" value="${price.startDate}"/>"></select>
                                                    </p>
                                                    <br/> 
                                                    <p><fmt:message key="COLLECT_EVENT_EDIT_LABEL_结束时间" bundle="${bundle}"/></p>
                                                    <p>
                                                        <input  class="Input130 FloatLeft" type="text"
                                                                name="fund_collection_price[${status.index}].expireDate" value="<fmt:formatDate pattern="${dateStyle}" value="${price.expireDate}"/>">
                                                        <select  class="Input184 Select70 FloatLeft MarginL7" name="fund_collection_price[${status.index}].expireTime" cvalue="<fmt:formatDate pattern="HH:mm" value="${price.expireDate}"/>"></select>
                                                    </p>
                                                    <div class="clear"></div> 
                                                </div>
                                            </c:if>
                                            <%--票价每次订购张数限制 --%>
                                            <div class="sk-item-edit-ticket">
                                                <label class="sk-label-edit-ticket "><b><fmt:message key="COLLECT_EVENT_EDIT_LABEL_订购张数限制" bundle="${bundle}"/></b></label>
                                                <span class="FloatLeft"><fmt:message key='COLLECT_EVENT_EDIT_TEXT_最少张数' bundle="${bundle}"/></span>
                                                <select class="Input184 Select60 shortInput FloatLeft" name="fund_collection_price[${status.index}].minCount">
                                                    <c:forEach begin="1" end="50" varStatus="minCountStatus">
                                                        <option <c:if test="${price.minCount == minCountStatus.index}">selected="true"</c:if>>${minCountStatus.index}</option>
                                                    </c:forEach>
                                                </select>  
                                                <span class="FloatLeft"><fmt:message key='COLLECT_EVENT_EDIT_TEXT_最多张数' bundle="${bundle}"/></span>
                                                <select class="Input184 Select60 shortInput FloatLeft" name="fund_collection_price[${status.index}].maxCount">
                                                    <c:forEach begin="0" end="50" varStatus="maxCountStatus">
                                                        <option <c:if test="${price.maxCount == maxCountStatus.index}">selected="true"</c:if>>${maxCountStatus.index}</option>
                                                    </c:forEach>
                                                </select> 
                                                <div class="clear"></div> 
                                            </div>
                                            <%--门票隐藏设置 --%>
                                            <c:if test="${collectionType=='EVENT'}">
                                                <div class="sk-item-edit-ticket">
                                                    <label class="sk-label-edit-ticket "><b><fmt:message key="COLLECT_EVENT_EDIT_LABEL_隐藏门票" bundle="${bundle}"/></b></label>
                                                    <div style=" padding-top:5px;">
                                                        <input type="checkbox" 
                                                               name="fund_collection_price[${status.index}].hidden" value="true"  style="float: left; margin:5px 10px 20px 0px" 
                                                               <c:if test="${price.hidden}">checked="true"</c:if>
                                                                   onclick="FundCollectionPrice.synFundCollectionDiscountAndReferral(this, '')">

                                                               <span style="line-height:18px; margin-left: 0px;"><fmt:message key='COLLECT_EVENT_EDIT_TEXT_隐藏的门票' bundle="${bundle}"/></span></div>
                                                    <div class="clear"></div> 
                                                </div>
                                            </c:if>
                                            <%--门票需审批设置--%>
                                            <c:if test="${collectionType=='EVENT'}">
                                                <div class="sk-item-edit-ticket">
                                                    <label class="sk-label-edit-ticket"><b><fmt:message key="COLLECT_EVENT_EDIT_LABEL_门票需审批" bundle="${bundle}"/></b></label>

                                                    <div style=" padding-top:5px;"> <input type="checkbox" style="float: left; margin:5px 10px 20px 0px"
                                                                                           name="fund_collection_price[${status.index}].requireApproval" value="true" 
                                                                                           <c:if test="${price.requireApproval}">checked="true"</c:if>
                                                                                               onclick="FundCollectionPrice.synFundCollectionDiscountAndReferral(this, '')">
                                                                                           <span style="line-height:18px; margin-left: 0px;"><fmt:message key='COLLECT_EVENT_EDIT_TEXT_需审批的门票' bundle="${bundle}"/></span></div>

                                                    <div class="clear"></div> 
                                                </div>
                                            </c:if>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <%--新建收款票价 --%>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>
        </dd>
        <dd class="right">${remarkPriceCategory}</dd> 
    </dl>
    <%----------------------------------------折扣码----------------------------------------------------%>
    <dl class="dlEdit">
        <dt>
            <fmt:message key="COLLECT_EDIT_TEXT_添加折扣码" bundle="${bundle}"/> 
            &nbsp;&nbsp;
            <span>
                <a href="javascript:void(0);" onclick="FundCollectionDiscount.addOption();"><fmt:message key="COLLECT_EDIT_TEXT_+添加折扣码" bundle="${bundle}"/></a>
            </span>
        </dt>
        <dd class="left">
            <div>
                <table class="history_table MarginBottom20" width="100%" cellspacing="0" cellpadding="0" border="0" style="position: relative">
                    <thead>
                        <tr>
                            <td width="23%"><fmt:message key="COLLECT_EDIT_TEXT_折扣码" bundle="${bundle}"/></td>
                            <td width="33%"><fmt:message key='COLLECT_EDIT_TEXT_名称' bundle="${bundle}"/></td>
                            <td width="18%"><fmt:message key='COLLECT_EDIT_TEXT_减' bundle="${bundle}"/></td>
                            <td width="16%"><fmt:message key='COLLECT_EDIT_TEXT_方式' bundle="${bundle}"/></td>
                            <td width="10%">&nbsp;</td>
                        </tr>
                    </thead>
                    <tbody id="collect_discounts_container">
                        <c:choose> 
                            <c:when test="${not empty fundCollection}">
                                <%--编辑收款：折扣码列表 --%>
                                <c:forEach var="discount" items="${fundCollection.getAvailableFundCollectionDiscountList()}" varStatus="status">
                                    <%--折扣码基本信息 --%>
                                    <tr class="white basic_inputs_container">
                                        <td width="23%"><input type="text" name="fund_collection_discount[${status.index}].code" class="Input144" value="${discount.code}"/></td>
                                        <td width="33%"><input type="text" name="fund_collection_discount[${status.index}].name" class="Input154" value="${discount.name}"/></td>
                                        <td width="18%">
                                            <input type="text" name="fund_collection_discount[${status.index}].rate" class="Input50" 
                                                   <c:choose>
                                                       <c:when test="${discount.type == 'RATE'}">value="<fmt:formatNumber value="${discount.rate}" type="currency"  pattern="###0.##"/>"</c:when>
                                                       <c:otherwise>value="<fmt:formatNumber value="${discount.amount}" type="currency"  pattern="###0.##"/>"</c:otherwise>
                                                   </c:choose>
                                                   />
                                        </td>
                                        <td width="16%">
                                            <select  class="Input184 Select60" name="fund_collection_discount[${status.index}].type" >
                                                <option value="RATE" <c:if test="${discount.type == 'RATE'}">selected="true"</c:if>>%</option>
                                                <option value="AMOUNT" <c:if test="${discount.type == 'AMOUNT'}">selected="true"</c:if>><fmt:message key='COLLECT_DETAIL_元' bundle="${bundle}"/></option>
                                                </select>
                                            </td>
                                            <td width="10%">
                                                <input type="hidden" name="fund_collection_discount[${status.index}].id" value="${discount.id}" />
                                            <input type="hidden" name="fund_collection_discount[${status.index}].deleted" value="${discount.deleted}" />
                                            <input type="hidden" name="fund_collection_discount[${status.index}].order" 
                                                   <c:choose>
                                                       <c:when test="${discount.order == -1}">value="${status.index}"</c:when>
                                                       <c:otherwise>value="${discount.order}"</c:otherwise>
                                                   </c:choose> />
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
                                                <input type="checkbox" class="MarginL7 discount_related_price_all_cb" onclick="FundCollectionDiscount.toggleRelatedPrice(this);"/><fmt:message key="COLLECT_EDIT_TEXT_所有价格" bundle="${bundle}"/>
                                                <div class="MarginL60 collect_discount_related_price_container">
                                                    <c:forEach var="price" items="${fundCollectionPriceList}" varStatus="priceStatus">
                                                        <c:if test="${price.amount > 0}">
                                                            <c:set value="false" var="price_discount_cb"></c:set>
                                                            <c:forEach var="priceDiscount" items="${discount.fundCollectionDiscountPriceList}">
                                                                <c:if test="${priceDiscount.fundCollectionPrice.id == price.id}"><c:set value="true" var="price_discount_cb"></c:set></c:if>
                                                            </c:forEach>
                                                            <p>
                                                                <input type="checkbox" 
                                                                       name="fund_collection_discount[${status.index}].price_order_list[${price.order}]" 
                                                                       value="${price.order}"
                                                                       <c:if test="${price_discount_cb}">checked="true"</c:if> 
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
                                                            name="fund_collection_discount[${status.index}].startDate" value="<fmt:formatDate pattern="${dateStyle}" value="${discount.startDate}"/>">
                                                    <select  class="Input184 Select70 FloatLeft MarginL7" name="fund_collection_discount[${status.index}].startTime" cvalue="<fmt:formatDate pattern="HH:mm" value="${discount.startDate}"/>"></select>
                                                </p>
                                                <br/> 
                                                <p><fmt:message key="COLLECT_EVENT_EDIT_LABEL_结束时间" bundle="${bundle}"/></p>
                                                <p>
                                                    <input  class="Input130 FloatLeft" type="text"
                                                            name="fund_collection_discount[${status.index}].expireDate" value="<fmt:formatDate pattern="${dateStyle}" value="${discount.expireDate}"/>">
                                                    <select  class="Input184 Select70 FloatLeft MarginL7" name="fund_collection_discount[${status.index}].expireTime" cvalue="<fmt:formatDate pattern="HH:mm" value="${discount.expireDate}"/>"></select>
                                                </p>
                                                <div class="clear"></div> 
                                            </div>
                                            <%--折扣码次数限制--%>
                                            <div class="sk-item-edit-ticket">
                                                <label class="sk-label-edit-ticket "><b><fmt:message key="COLLECT_EVENT_EDIT_LABEL_次数限制" bundle="${bundle}"/></b></label>
                                                <input type="text" name="fund_collection_discount[${status.index}].maxCount" class="Input40" value="${discount.maxCount}"/>&nbsp;<span style="font-size: 12px"><fmt:message key="COLLECT_EVENT_EDIT_LABEL_折扣码被用了设定的次数将会失效" bundle="${bundle}"/></span>
                                                <div class="clear"></div> 
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <%--新建折扣码 --%>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>
        </dd>
        <dd class="right">${remarkDiscounts}</dd>
    </dl>
    <c:if test="${'EVENT'==collectionType}">
        <%----------------------------------------渠道码----------------------------------------------------%>
        <dl class="dlEdit">
            <dt><fmt:message key="COLLECT_EDIT_TEXT_渠道码" bundle="${bundle}"/>
                &nbsp;&nbsp;
                <span>
                    <a href="javascript:void(0);" onclick="FundCollectionReferral.addOption();">
                        <fmt:message key="COLLECT_EDIT_TEXT_添加新渠道码" bundle="${bundle}"/>
                    </a>
                </span>
            </dt>
            <dd class="left">
                <div>
                    <table class="history_table MarginBottom20" width="100%" cellspacing="0" cellpadding="0" border="0" style="position: relative">
                        <thead>
                            <tr>
                                <td width="23%"><fmt:message key="COLLECT_EDIT_TEXT_INPUT_渠道码" bundle="${bundle}"/></td>
                                <td width="67%"><fmt:message key='COLLECT_EDIT_TEXT_名称' bundle="${bundle}"/></td>
                                <td width="10%">&nbsp;</td>
                            </tr>
                        </thead>
                        <tbody id="collect_referrals_container">
                            <c:choose>
                                <c:when test="${not empty fundCollection}">
                                    <c:forEach var="referral" varStatus="status" items="${fundCollection.getAvailableFundCollectionReferralList()}">
                                        <tr class="white basic_inputs_container">
                                            <td width="23%"><input type="text" name="fund_collection_referral[${status.index}].code" 
                                                                   class="Input144" value="${referral.code}"
                                                                   onblur="FundCollectionReferral.setLinkText(this);"/></td>
                                            <td width="67%">
                                                <input type="text" name="fund_collection_referral[${status.index}].name" 
                                                       value="${referral.name}" 
                                                       onfocus="YpEffects.toggleFocus4Ele(this, 'focus', '<fmt:message key='COLLECT_EDIT_TEXT_名称' bundle="${bundle}"/>', '', 'black')" 
                                                       onblur="YpEffects.toggleFocus4Ele(this, 'blur', '<fmt:message key='COLLECT_EDIT_TEXT_名称' bundle="${bundle}"/>', '', '#999999')"
                                                       class="Input340"/>
                                            </td>
                                            <td width="10%">
                                                <input type="hidden" name="fund_collection_referral[${status.index}].order" 
                                                       <c:choose>
                                                           <c:when test="${referral.order == -1}">value="${status.index}"</c:when>
                                                           <c:otherwise>value="${referral.order}"</c:otherwise>
                                                       </c:choose> />
                                                <input type="hidden" name="fund_collection_referral[${status.index}].id" value="${referral.id}" />
                                                <input type="hidden" name="fund_collection_referral[${status.index}].deleted" value="${referral.deleted}" />
                                                <a href="javascript:void(0);" onclick="FundCollectionReferral.toggleExtraInputs(this);"><fmt:message key="COLLECT_EVENT_EDIT_TEXT_展开" bundle="${bundle}"/></a>
                                                <a href="javascript:void(0);" onclick="FundCollectionReferral.delOption(this);"><fmt:message key="GLOBAL_删除" bundle="${bundle}"/></a>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="3"  class="collect_referral_link_container">https://yoopay.cn/event/${fundCollection.webId}?ref=${referral.code}</td>
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
                                                                <c:set value="false" var="price_referral_cb"></c:set>
                                                                <c:forEach var="priceReferral" items="${referral.fundCollectionReferralHiddenPriceList}">
                                                                    <c:if test="${priceReferral.fundCollectionPrice.id == price.id}"><c:set value="true" var="price_referral_cb"></c:set></c:if>
                                                                </c:forEach>
                                                                <p>
                                                                    <input type="checkbox" 
                                                                           name="fund_collection_referral[${status.index}].price_order_list[${price.order}]" 
                                                                           value="${price.order}"
                                                                           <c:if test="${price_referral_cb}">checked="true"</c:if> 
                                                                               onclick="FundCollectionReferral.toggleRelatedAllPriceCheckbox(this);"
                                                                               />${price.name}
                                                                </p>
                                                            </c:if>
                                                        </c:forEach>
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise></c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>
            </dd>
            <dd class="right">
                <fmt:message key="COLLECT_REFERRAL_EDIT_TEXT_为不同的推广渠道提供不同的渠道码，以便观测推广效果" bundle="${bundle}"/>
            </dd>
            <div class="clear"></div>
        </dl>
    </c:if>
    <div class="clear"></div>
    <c:if test="${'EVENT'==collectionType}">
        <%--弹出窗口Dialog --%>
        <div id="templateListDialog" style="display:none;line-height: 2;padding-left: 10px;padding-right: 10px">
            <div class="noticeMessage" id="template_list_notice_msg">
                <div class="wrongMessage" id="template_list_wrong_msg">
                </div>	
                <div class="loadingMessage" id="template_list_loading_div" style="display:none"><fmt:message key="GLOBAL_MSG_LOADING" bundle="${bundle}"/><img src="/images/032.gif" alt="" /></div>
            </div>
            <div>
                <div id="template_list_blank" style="display: none"><h3 class="nolist"><fmt:message key="GLOBAL_MSG_BLANK_LIST" bundle="${bundle}"/></h3></div>
                <div id="template_list_table" style="display: none">
                    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="history_table">
                        <thead>
                            <tr>
                                <td width="5px"></td>
                                <td><fmt:message key="COLLECT_LIST_LABEL_名称" bundle="${bundle}"/></td>
                            </tr>
                        </thead>
                        <tbody id="template_list_tbody">

                        </tbody>
                    </table>
                </div>
                <p class="sk-item-edit MarginTop20">
                    <input type="button" value="<fmt:message key='GLOBAL_确定' bundle='${bundle}'/>" class="collection_button FloatRight" onclick="templateListDialog.loadTemplate();"/>
                    <a href="javascript:void(0);" onclick="templateListDialog.close();" class="FloatRight MarginR10"><fmt:message key='GLOBAL_取消' bundle="${bundle}"/></a>
                </p>
            </div>
        </div>
        <div id="deactiveCollectionDialog" style="display: none">
            <div class="noticeMessage" id="deactiveCollectionDiv" style="display:none">
                <div class="wrongMessage" id="deactiveCollectionMessage"></div>
            </div>
            <div style="margin-top: 15px">
                <p> <fmt:message key="COLLECT_EVENT_EDIT_LABEL_这将把活动活动链接变成不可用" bundle="${bundle}"/></p>
                <p class="MarginTop10"><fmt:message key="COLLECT_EVENT_EDIT_LABEL_确定要结束此活动" bundle="${bundle}"/></p>
                <p class="sk-item-edit MarginTop20"><input class="collection_button FloatRight" type="button"  value="<fmt:message key='GLOBAL_YES_确定' bundle='${bundle}'/>" onclick="Collect.deactiveCollection('${fundCollection.webId}')" name="Submit">
                    <a href="javascript:;" onclick="DeactiveCollectionDialog.close();" class="FloatRight MarginR10"><fmt:message key='GLOBAL_不' bundle="${bundle}"/></a>
                </p>
            </div>
        </div>
        <div id="activeCollectionDialog" style="display: none">
            <div class="noticeMessage" id="activeCollectionDiv" style="display:none">
                <div class="wrongMessage" id="activeCollectionMessage"></div>
            </div>
            <div style="margin-top: 15px">
                <p><fmt:message key="COLLECT_EVENT_EDIT_LABEL_这将把活动活动链接变成可用" bundle="${bundle}"/></p>
                <p class="sk-item-edit MarginTop20">
                    <input class="collection_button FloatRight" type="button"  value="<fmt:message key='GLOBAL_确定' bundle='${bundle}'/>" onclick="Collect.activeCollection('${fundCollection.webId}')" name="Submit">
                    <a href="javascript:;" onclick="ActiveCollectionDialog.close();" class="FloatRight MarginR10"><fmt:message key='GLOBAL_取消' bundle="${bundle}"/></a>
                </p>
            </div>
        </div>
        <div id="deleteCollectionDialog" style="display: none">
            <div class="noticeMessage" id="deleteCollectionDiv" style="display:none">
                <div class="wrongMessage" id="deleteCollectionMessage"></div>
            </div>
            <div style="margin-top: 15px">
                <p> <fmt:message key="COLLECT_EVENT_EDIT_LABEL_这将把活动删除" bundle="${bundle}"/></p>
                <p class="MarginTop10"><fmt:message key="COLLECT_EVENT_EDIT_LABEL_确定要删除此活动" bundle="${bundle}"/></p>
                <p class="sk-item-edit MarginTop20"><input class="collection_button FloatRight" type="button"  value="<fmt:message key='GLOBAL_确定' bundle='${bundle}'/>" onclick="Collect.deleteCollection('${fundCollection.webId}')" name="Submit">
                    <a href="javascript:;" onclick="DeleteCollectionDialog.close();" class="FloatRight MarginR10"><fmt:message key='GLOBAL_取消' bundle="${bundle}"/></a>
                </p>
            </div>
        </div>
    </c:if>


