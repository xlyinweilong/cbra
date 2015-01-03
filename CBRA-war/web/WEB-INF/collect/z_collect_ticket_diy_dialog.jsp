<%-- 
    Document   : z_collect_ticket_diy_dialog
    Created on : Dec 12, 2012, 11:29:10 AM
    Author     : Yin.Weilong
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%--指定门票海报--%>
<div id="collect_ticket_diy_dialog" style="display:none;line-height: 2;padding-left: 10px;padding-right: 10px">
    <div class="noticeMessage" id="collect_ticket_diy_notice_msg">
        <div class="wrongMessage" id="collect_ticket_diy_wrong_msg">
            <c:if test="${!empty postResult.singleErrorMsg}">
                <div>${postResult.singleErrorMsg}</div> 
            </c:if>
        </div>	
        <div class="loadingMessage" id="collect_ticket_diy_loading_div" style="display:none"><fmt:message key="GLOBAL_MSG_LOADING" bundle="${bundle}"/><img src="/images/032.gif" alt="" /></div>
    </div>
    <div>
        <form id="collect_add_ticket_poster_image_from" enctype="multipart/form-data" method="post" action="/collect/upload_ticket_poster_image" target="collect_ticket_poster_image_hidden_frame">
            <div class="PopDiv"><b class="b1h"></b><b class="b2h"></b><b class="b3h"></b><b class="b4h"></b>
                <div class="headh">
                    <h3><fmt:message key='COLLECT_TICKET_DIY_上传文件' bundle='${bundle}'/></h3>
                </div>
                <div class="contenth">
                    <div class="FloatLeft ticker_bg_pop"><img id="collect_ticket_poster_image_img" src="<fmt:message key='COLLECT_EDIT_默认图片' bundle='${bundle}'/>"  width="98"/><br/>
                    <a id="collect_ticket_poster_image_show" style="display:none" href="javascript:void(0)"><fmt:message key="COLLECT_EDIT_查看" bundle="${bundle}"/></a>
                    <a id="collect_ticket_poster_image_del" style="display:none" href="javascript:void(0)"><fmt:message key="COLLECT_EDIT_删除" bundle="${bundle}"/></a>
                    </div>
                    <div class="FloatLeft"><fmt:message key="COLLECT_EDIT_上传图片" bundle="${bundle}"/><br/><input type="file" name="ticket_poster_image" id="ticket_poster_image"/>
                    <input type="hidden" value="" id="old_file_url" />
                    <input type="hidden" value="" id="old_file_name" /></div>
                    <div class="clear"></div>
                </div>
                <b class="b4bh"></b><b class="b3bh"></b><b class="b2bh"></b><b class="b1h"></b>
            </div>
            <div class="PopDiv"><b class="b1h"></b><b class="b2h"></b><b class="b3h"></b><b class="b4h"></b>
                <div class="headh">
                    <h3><fmt:message key='COLLECT_TICKET_DIY_选择票种' bundle='${bundle}'/></h3>
                </div>
                <div class="contenth">
                    <dl>
                        <div id="collect_ticket_diy_dialog_ticket_poster_image_div">
                            <c:set var="index" value="0" />
                            <c:forEach var="price" items="${fundCollectionPriceList}" varStatus="priceStatus">
                                <p>
                                    <input type="checkbox"
                                           name="fund_collection_price[${index}].ticket_poster_image" 
                                           value="${price.order}"
                                           />${price.name}
                                </p>
                                <c:set var="index" value="${index+1}" />
                            </c:forEach>
                        </div>   
                    </dl>
                </div>
                <b class="b4bh"></b><b class="b3bh"></b><b class="b2bh"></b><b class="b1h"></b>
            </div>
            <div class="TextAlignRight MarginTop10 LineHeight">
                <a href="javascript:FundCollectionTicketDiy.closeAddTicketPosterImageDialog();"><fmt:message key="GLOBAL_取消" bundle="${bundle}"/></a>
                <input type="button" value="<fmt:message key='GLOBAL_保存' bundle='${bundle}'/>" class="collection_button" onclick="FundCollectionTicketDiy.doAddOrEditTicketPosterImage();"/>
            </div>
        </form>
        <div id="hidden_for_del_in_ticket_input_diy_div_container"></div>
    </div>
</div>
<%--默认门票海报--%>
<div id="default_ticket_poster_image_dialog" style="display:none">
    <div class="noticeMessage" id="collect_default_ticket_diy_notice_msg">
        <div class="wrongMessage" id="collect_default_ticket_diy_wrong_msg">
            <c:if test="${!empty postResult.singleErrorMsg}">
                <div>${postResult.singleErrorMsg}</div> 
            </c:if>
        </div>	
        <div class="loadingMessage" id="collect_default_ticket_diy_loading_div" style="display:none"><fmt:message key="GLOBAL_MSG_LOADING" bundle="${bundle}"/><img src="/images/032.gif" alt="" /></div>
    </div>
    <form id="collect_default_ticket_poster_image_from" enctype="multipart/form-data" method="post" action="/collect/upload_ticket_poster_image" target="collect_default_ticket_poster_image_hidden_frame">
        <div class="FloatLeft ticker_bg_pop">
            <c:choose>
                <c:when test="${fundCollection.getDefaultTicketPosterImageUrl()!=null}">
                    <img id="default_ticket_poster_image_img" src="${fundCollection.getDefaultTicketPosterImageUrl()}"  width="98" height="99" />
                    <a id="default_ticket_poster_image_del1" href="${fundCollection.getDefaultTicketPosterImageUrl()}" class="MarginL7 " target="_blank"><fmt:message key="COLLECT_EDIT_查看" bundle="${bundle}"/></a> 
                    <a id="default_ticket_poster_image_del2" href="javascript:void(0)" onclick = "FundCollectionTicketDiy.delDefaultTicketPosterImage()">
                        <fmt:message key="COLLECT_EDIT_删除" bundle="${bundle}"/>
                    </a>
                </c:when>
                <c:otherwise>
                    <img id="default_ticket_poster_image_img" src="<fmt:message key='COLLECT_EDIT_默认图片' bundle='${bundle}'/>"  width="98"/>
                </c:otherwise>
            </c:choose>
        </div>
                <div class="FloatLeft">
            <fmt:message key="COLLECT_EDIT_上传背景图片" bundle="${bundle}" /><br/>
            <input type="file" name="ticket_poster_image" id="default_ticket_poster_image" />
        </div>
            <div class="clear"></div> 
        <div class="TextAlignRight MarginTop10 LineHeight">
            <a href="javascript:FundCollectionTicketDiy.closeDefaultTicketPosterImageDialog();"><fmt:message key="GLOBAL_取消" bundle="${bundle}"/></a>
            <input type="button" value="<fmt:message key='GLOBAL_保存' bundle='${bundle}'/>" class="collection_button" onclick="FundCollectionTicketDiy.doSubmitDefaultTicketPosterImage();"/>
        </div>
    </form>
</div>
<script type="text/javascript">
    $(document).ready(
    function(){
        var oFrm = document.getElementById('collect_ticket_poster_image_hidden_frame');
        oFrm.onload = oFrm.onreadystatechange = function() {
            if (this.readyState && this.readyState != 'complete') return;
            else {
                if($(document.getElementById('collect_ticket_poster_image_hidden_frame').contentWindow.document.body).html() != ''){
                    FundCollectionTicketDiy.ajaxFileCallBack($(document.getElementById('collect_ticket_poster_image_hidden_frame').contentWindow.document.body).html());
                }
            }
        };
        var dFrm = document.getElementById('collect_default_ticket_poster_image_hidden_frame');
        dFrm.onload = dFrm.onreadystatechange = function() {
            if (this.readyState && this.readyState != 'complete') return;
            else {
                if($(document.getElementById('collect_default_ticket_poster_image_hidden_frame').contentWindow.document.body).html() != ''){
                    FundCollectionTicketDiy.ajaxDefaultFileCallBack($(document.getElementById('collect_default_ticket_poster_image_hidden_frame').contentWindow.document.body).html());
                }
            }
        }
    });
</script>
<iframe id="collect_ticket_poster_image_hidden_frame" name='collect_ticket_poster_image_hidden_frame' style='display:none'><head></head><body></body></iframe>
<iframe id="collect_default_ticket_poster_image_hidden_frame" name='collect_default_ticket_poster_image_hidden_frame' style='display:none'><head></head><body></body></iframe>
