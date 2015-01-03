<%-- 
    Document   : z_collect_diy_dialog
    Created on : Jan 12, 2012, 11:07:05 AM
    Author     : Swang
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div id="collect_diy_dialog" style="display:none;line-height: 2;padding-left: 10px;padding-right: 10px">
    <div class="noticeMessage" id="collect_diy_notice_msg">
        <div class="wrongMessage" id="collect_diy_wrong_msg">
            <c:if test="${!empty postResult.singleErrorMsg}">
                <div>${postResult.singleErrorMsg}</div> 
            </c:if>
        </div>	
        <div class="loadingMessage" id="collect_diy_loading_div" style="display:none"><fmt:message key="GLOBAL_MSG_LOADING" bundle="${bundle}"/><img src="/images/032.gif" alt="" /></div>
    </div>
    <div id="collect_add_option_div">
        <form id="collect_add_option_from">

            <div class="PopDiv"><b class="b1h"></b><b class="b2h"></b><b class="b3h"></b><b class="b4h"></b>
                <div class="headh">
                    <h3><fmt:message key='COLLECT_DETAIL_ADD_POP_LABEL_问题标题' bundle='${bundle}'/></h3>
                </div>
                <div class="contenth">
                    <textarea  type="text" name="collect_diy_title"  id="collect_diy_title" ></textarea>
                </div>
                <b class="b4bh"></b><b class="b3bh"></b><b class="b2bh"></b><b class="b1h"></b>
            </div>
            <div class="PopDiv"><b class="b1h"></b><b class="b2h"></b><b class="b3h"></b><b class="b4h"></b>
                <div class="headh">
                    <h3><fmt:message key='COLLECT_DETAIL_ADD_POP_LABEL_答案种类' bundle='${bundle}'/></h3>
                </div>
                <div class="contenth">


                    <dl> 
                        <dt><input type="radio" name="collect_diy_type"  id="collect_diy_type_text" value="TEXT_FIELD"/><fmt:message key='COLLECT_DETAIL_ADD_POP_INPUT_单行文字' bundle='${bundle}'/></dt>
                        <dt><input type="radio" name="collect_diy_type" id="collect_diy_type_textarea" value="TEXT_AREA"/><fmt:message key='COLLECT_DETAIL_ADD_POP_INPUT_多行文字' bundle='${bundle}'/></dt>
                        <dt><input type="radio" name="collect_diy_type"  id="collect_diy_type_multi" value="MULTI"/><fmt:message key='COLLECT_DETAIL_ADD_POP_INPUT_多项选择' bundle='${bundle}'/> 
                        <span id="collect_diy_multi_span" style="display: none">
                            <select name="collect_diy_type_multi">
                                <option value="NULL"><fmt:message key='COLLECT_DETAIL_ADD_POP_SELECT_展现形式' bundle='${bundle}'/></option>
                                <option value="SELECTION_DROPDOWN_LIST"><fmt:message key='COLLECT_DETAIL_ADD_POP_SELECT_下拉列表' bundle='${bundle}'/></option>
                                <option value="SELECTION_RADIO_BUTTON"><fmt:message key='COLLECT_DETAIL_ADD_POP_SELECT_单一答案' bundle='${bundle}'/></option>
                                <option value="SELECTION_CHECK_BOX"><fmt:message key='COLLECT_DETAIL_ADD_POP_SELECT_多答案' bundle='${bundle}'/></option>
                            </select>
                        </span></dt>
                        <div id="collect_diy_multi_option_divs"  style="display: none">
                            <div class="collect_diy_multi_option_div MarginBottom5"><input type="text" name="collect_diy_multi_option" class="Input400" /> <span class="collect_diy_multi_operation"><a href="javascript:CollectDIY.addMultiOption();"><fmt:message key='COLLECT_DETAIL_ADD_POP_TEXT_+添加更多选择' bundle='${bundle}'/></a></span></div>
                        </div>
                        <dt><input type="radio" name="collect_diy_type"  id="collect_diy_type_consent" value="AGREEMENT"/><fmt:message key='COLLECT_DETAIL_ADD_POP_TEXT_同意书' bundle='${bundle}'/></dt>
                        <div id="collect_diy_consent_div" style="display: none">
                            <div><fmt:message key='COLLECT_DETAIL_ADD_POP_TEXT_报名者必须接受' bundle='${bundle}'/> </div>
                            <div><textarea name="collect_diy_consent" id="collect_diy_consent_tt" ></textarea></div>
                        </div>
                        <dt><input type="radio" name="collect_diy_type" id="collect_diy_type_uploadfile" value="UPLOAD_FILE"><fmt:message key='COLLECT_DETAIL_ADD_POP_INPUT_上传文件' bundle='${bundle}'/></dt>
                    </dl>

                </div>
                <b class="b4bh"></b><b class="b3bh"></b><b class="b2bh"></b><b class="b1h"></b>
            </div>
            <div class="PopDiv"><b class="b1h"></b><b class="b2h"></b><b class="b3h"></b><b class="b4h"></b>
                <div class="headh">
                    <h3><fmt:message key='COLLECT_DETAIL_ADD_POP_LABEL_选择票种' bundle='${bundle}'/></h3>
                </div>
                <div class="contenth">
                    <dl>
                        <input type="checkbox" id="collect_diy_question_price_all" onclick="CollectDIY.toggleRelatedPrice(this);"><fmt:message key='COLLECT_DETAIL_ADD_POP_LABEL_此问题针对所有票种' bundle='${bundle}'/>
                        <div id="collect_diy_dialog_question_price_div">
                            <c:set var="index" value="0" />
                            <c:forEach var="price" items="${fundCollectionPriceList}" varStatus="priceStatus">
                                <p>
                                    <input type="checkbox" id="fund_collection_question_price_order_list_${price.order}"
                                           name="fund_collection_question.price_order_list[${index}]" 
                                           value="${price.order}"
                                           onclick="CollectDIY.toggleRelatedAllPriceCheckbox(this);"
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
                <input type="hidden" name="collect_diy_index" value="-1" />
                <a href="javascript:CollectDIY.closeAddOptionDialog();"><fmt:message key="GLOBAL_取消" bundle="${bundle}"/></a>
                <input type="button" value="<fmt:message key='GLOBAL_保存' bundle='${bundle}'/>" class="collection_button" onclick="CollectDIY.doAddOption();"/>
            </div>
        </form>
    </div>
</div>
<script type="text/javascript">
    $(document).ready(
    function(){
        CollectDIY.initPages();
    });   
</script>
