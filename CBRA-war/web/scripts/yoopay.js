/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
var YpService={
    checkForm : function() {
        var paymentWMsgDiv = $("#ypservice_wrong_msg_container");
        var paymentLoadDiv = $("#ypservice_loading_container");
        var paymentForm = $("#ypservice_form");
        //Check gateway select
        var gatewayCheckFlag = GatewayPayment.checkGatewayForm(paymentWMsgDiv);
        if(!gatewayCheckFlag) {
            return false;
        }
        //Post ajax data
        
        var url = paymentForm.attr("action");
        var data = paymentForm.serialize();
        YpMessage.showLoadingMessage(paymentLoadDiv);
        $("#payment_btn").attr("disabled", "disabled");
        var gatewayType = $("#gateway_type").val();
        if(gatewayType == "ALIPAY" || gatewayType == "CHINABANK" || gatewayType == "PAYPAL"){
            //Show model dialog
            $("#paymentTipDialog" ).dialog({
                title:Lang.get("PAYMENT_PAY_支付"),
                resizable: false,
                height:180,
                width:350,
                modal: true,
                show: 'fade',
                hide: 'fade'
            });
            //Submit form
            return true;
        }
        else {
            $.post(url, data, function(json){
                if(!json.success){
                    YpMessage.showMessage(paymentWMsgDiv, json.singleErrorMsg);
                }
                else {
                    if(json.redirectUrl != "") {
                        redirect(json.redirectUrl);
                    }
                }
                YpMessage.hideLoadingMessageOnly(paymentLoadDiv);
                $("#payment_btn").removeAttr("disabled");
            }, "json");
            return false;
        }
    },
    redirectToResult : function(hintSuccess) {
        $.getJSON("/ypservice/result", {
            a: "REDIRECT_RESULT", 
            hint_success: hintSuccess,
            time : new Date().getTime()
        }, function(json) {
            if(!json.success){
                alert(json.singleErrorMsg);
            } else {
                if(json.redirectUrl != "") {
                    redirect(json.redirectUrl);
                }
            }
        });
    }
}
var FundAddFund={
    checkForm : function() {
        var paymentWMsgDiv = $("#addfund_wrong_msg_container");
        var paymentLoadDiv = $("#addfund_loading_container");
        var paymentForm = $("#add_fund_form");
        //Check amount
        var paymentAmountJEle = $("#payment_amount");
        if(YpValid.checkFormValueNull(paymentAmountJEle)) {
            YpMessage.showMessageAndFocusEle(paymentWMsgDiv, Lang.get("ADD_FUND_请输入充值金额"), paymentAmountJEle);
            return false;
        }
        var amountRegex = /^[\d]+(\.\d{0,2})?$/;
        if(!amountRegex.test(paymentAmountJEle.val())){
            YpMessage.showMessageAndFocusEle(paymentWMsgDiv, Lang.get("COLLECT_EDIT_金额必须为数字"), paymentAmountJEle);
            return false;
        }
        //Check gateway select
        var gatewayCheckFlag = GatewayPayment.checkGatewayForm(paymentWMsgDiv);
        if(!gatewayCheckFlag) {
            return false;
        }
        //Post ajax data
        
        var url = paymentForm.attr("action");
        var data = paymentForm.serialize();
        YpMessage.showLoadingMessage(paymentLoadDiv);
        $("#payment_btn").attr("disabled", "disabled");
        var gatewayType = $("#gateway_type").val();
        if(gatewayType == "ALIPAY" || gatewayType == "CHINABANK" || gatewayType == "PAYPAL"){
            //Show model dialog
            $("#paymentTipDialog" ).dialog({
                title:Lang.get("PAYMENT_PAY_支付"),
                resizable: false,
                height:180,
                width:350,
                modal: true,
                show: 'fade',
                hide: 'fade'
            });
            //Submit form
            return true;
        } else {
            $.post(url, data, function(json){
                if(!json.success){
                    YpMessage.showMessage(paymentWMsgDiv, json.singleErrorMsg);
                } else {
                    if(json.redirectUrl != "") {
                        redirect(json.redirectUrl);
                    }
                }
                YpMessage.hideLoadingMessageOnly(paymentLoadDiv);
                $("#payment_btn").removeAttr("disabled");
            }, "json");
            return false;
        }
    },
    redirectToResult : function(hintSuccess) {
        $.getJSON("/addfund/result", {
            a: "REDIRECT_RESULT", 
            hint_success: hintSuccess,
            time : new Date().getTime()
        }, function(json) {
            if(!json.success){
                alert(json.singleErrorMsg);
            } else {
                if(json.redirectUrl != "") {
                    redirect(json.redirectUrl);
                }
            }
        });
    },
    _initAddFundInstruction:false,
    showAddFundInstructionDialog : function(){
        if(!FundAddFund._initAddFundInstruction){
            $('#addFund_instruction').dialog({
                autoOpen: false, 
                width:660,
                show: 'fade',
                modal: true,
                title: Lang.get("ADDFUND_DIALOG_标题")
            });
            FundAddFund._initAddFundInstruction = true;
        }
        $('#addFund_instruction').dialog('open');
    },
    closeAddFundInstructionDialog : function(){
        $('#addFund_instruction').dialog('close');
        FundAddFund.resetAddFundInstructionDialog();
    },
    resetAddFundInstructionDialog : function(){
        $('#addFund_instruction').show();
    }
}
var FundPaymentTicket = {
    defaultMsg : true,
    hideTextDefaultMsg:function(){
        if(FundPaymentTicket.defaultMsg){
            $('#search_input').val('');
            $('#search_input').css('color', '');
            FundPaymentTicket.defaultMsg = false;
        }
    },
    showTextDefaultMsg:function(){
        if($('#search_input').val() == ''){
            $('#search_input').val(Lang.get("COLLECT_DETAIL_LABEL_TEXT_搜索灰字"));
            $('#search_input').css('color', '#999999'); 
            FundPaymentTicket.defaultMsg = true;
        }
    },
    showAllTicketList : function() {
        $("#search_input").val("");
        $('#ticket_list_table').removeHighlight();
        $.uiTableFilter($('#ticket_list_table'), "");
        $("#show_all_tickets_span").hide();
        $('#search_input').val(Lang.get("COLLECT_DETAIL_LABEL_TEXT_搜索灰字"));
        $('#search_input').css('color', '#999999');
        FundPaymentTicket.defaultMsg = true;
    },
    downloadForPayment : function(gatewayPaymentId) {
        var prepareMsgDIv = $("#ticket_prepare_msg");
        var prepareProcess = $("#ticket_prepare_progress");
        YpMessage.showLoadingMessage(prepareMsgDIv);
        prepareProcess.progressbar({
            value: 10
        });
        FundPaymentTicket.prepareForDownload(gatewayPaymentId);
    },
    prepareForDownload : function(gatewayPaymentId) {
        var prepareProcess = $("#ticket_prepare_progress");
        var prepareMsgDIv = $("#ticket_prepare_msg");
        var timer = null;
        $.getJSON("/payment/result", {
            a: "TICKET_PREPARE", 
            gid: gatewayPaymentId,
            time : new Date().getTime() 
        }, function(json) {
            if(!json.success){
                YpMessage.showWrongMessage(prepareMsgDIv, json.singleErrorMsg);
                if(timer != null){
                    window.clearTimeout(timer);
                }
                //Hide the prepare msg div and the ticket prepare progress
                window.setTimeout(function(){
                    YpMessage.hideMessage(prepareMsgDIv);
                    prepareProcess.hide();
                }, 2000);
            }
            else {
                var value;
                if(json.status == "PREPARE") {
                    value = prepareProcess.progressbar("value");
                    value += 10;
                    if(value >= 100) {
                        value = 95;
                    }
                }else {
                    value = 100;
                }                  
                prepareProcess.progressbar({
                    value: value
                });
                if(value == 100) {
                    YpMessage.showSuccessMessage(prepareMsgDIv, Lang.get('GLOBAL_处理成功'));
                    if(timer != null){
                        window.clearTimeout(timer);
                    }
                    var filename = json.filename;
                    $("#ticket_download_filename").val(filename);
                    $("#ticket_download_form").submit();
                    //Hide the prepare msg div and the ticket prepare progress
                    window.setTimeout(function(){
                        YpMessage.hideMessage(prepareMsgDIv);
                        prepareProcess.hide();
                    }, 2000);
                }
                else {
                    timer = window.setTimeout(function(){
                        FundPaymentTicket.prepareForDownload(gatewayPaymentId);
                    },3000);
                }
            }
        });
    }
}

var FundCollectionSearch = {
    search:function(defaultKeyword){
        var keywordJEle = $("#keyword");
        var wrongMsgContainer = $("div.wrongMessage");
        if(YpValid.checkFormValueNull(keywordJEle) || keywordJEle.val()==defaultKeyword) {
            YpMessage.showWrongMessageAndFocusEle(wrongMsgContainer, Lang.get("GLOBAL_MSG_SEARCH_KEYWORD_BLANK"), keywordJEle);
            return false;
        }
        YpMessage.hideMessage(wrongMsgContainer);
        var loadingMsgContainer = $("div.loadingMessage");
        YpMessage.showLoadingMessage(loadingMsgContainer)
        return true;
    }
}
var FundCollection = {
    toggleTicketCustomContainer : function() {
        var container = $("#custom_ticket_content_tabs");
        var controlLink = $("#custom_ticket_content_link");
        if(container.css("display") == "none") {
            controlLink.text(Lang.get("COLLECT_TICKET_CUSTOM_收起"));
            container.show();
        } else {
            controlLink.text(Lang.get("COLLECT_TICKET_CUSTOM_编辑"));
            container.hide();
        }
    },
    toggleAttendeeListOption:function(){
        var attendeeListOptionsContainer = $("#attendee_list_options_container");
        if($('#showAttendeeList').attr('checked')){
            attendeeListOptionsContainer.find(":checkbox").attr("checked",true);
            $('#showTicketOrder').attr('checked',false);
            attendeeListOptionsContainer.fadeIn();
            $("#showName").click(function(e){
                alert(Lang.get("COLLECT_DIY_必须勾选此选项"));
                return false;
            });
        } else {
            attendeeListOptionsContainer.find(":checkbox").attr("checked",false);
            attendeeListOptionsContainer.fadeOut();
        }
    },
    //显示活动主办方编辑
    showEventHostEdit:function(){
        $('#event_host_default_container').hide();
        $('#event_host_custom_container').show();
    },
    //取消活动主办方编辑
    cancelEventHostEdit:function(){
        $('#event_host_default_container').show();
        $('#event_host_custom_container').hide();
        $("#event_host").val($.trim($('#event_host_default_text').html()));
        $("#event_host_desc").empty();
    },
    //检查收款WEBID
    checkWebId:function(oldWebId){
        var wrongMsgContainer = $("#custom_webid_message");
        var webIdRegex = /^[0-9a-zA-Z-]{8,50}$/;
        var webIdJEle = $("#custom_webid");
        var webId = $.trim(webIdJEle.val());
        if(!webIdRegex.test(webId)){
            YpMessage.showWrongMessageAndFocusEle(wrongMsgContainer, Lang.get('COLLECT_EDIT_链接错误'), webIdJEle);
            return;
        }
        $.getJSON("/collect/check_webid", {
            webId : webId,
            oldWebId: oldWebId
        } ,function(json){
            if(json.success){
                YpMessage.showSuccessMessage(wrongMsgContainer, Lang.get('COLLECT_EDIT_该链接可用'));
            }
            else {
                YpMessage.showWrongMessageAndFocusEle(wrongMsgContainer, json.singleErrorMsg, webIdJEle);
            }
        });
    },
    displayShowInfoOnBannerContainer : function() {
        $("#showInfoOnBannerContainer").show();
    },
    //检查创建/编辑收款Form
    checkCreateForm : function(minAmount,keditor,keditorHost,ticketCZhContentEditor,ticketCEnContentEditor) {
        var language = Lang.getLanguage();
        var wrongMsgContainer = $("#public_message div.wrongMessage");
        var loadingMsgContainer = $("#public_message div.loadingMessage");
        YpMessage.hideMessage(wrongMsgContainer);
        YpMessage.hideMessage(loadingMsgContainer);
        var collectionType = $("#collection_type_input").val();
        //Load wrong message for i18n and collection type
        var cTitleWrongMessage;
        var cPriceNameWrongMessage;
        var cPriceAmountWrongMessage;
        var cPriceNameDefaultText;
        if(collectionType == "EVENT") {
            cTitleWrongMessage = Lang.get("COLLECT_EDIT_请输入活动名称");
            cPriceAmountWrongMessage = Lang.get("COLLECT_EDIT_请输入票价");
            cPriceNameWrongMessage = Lang.get("COLLECT_EDIT_请输入票价名称");
            cPriceNameDefaultText = Lang.get("COLLECT_EVENT_EDIT_票价种类名称");
        }
        else if(collectionType == "SERVICE") {
            cTitleWrongMessage = Lang.get("COLLECT_EDIT_请输入服务名称");
            cPriceAmountWrongMessage = Lang.get("COLLECT_EDIT_请输入服务票价");
            cPriceNameWrongMessage = Lang.get("COLLECT_EDIT_请输入服务票价名称");
            cPriceNameDefaultText = Lang.get("COLLECT_SERVICE_EDIT_票价种类名称");
        }
        else if(collectionType == "MEMBER") {
            cTitleWrongMessage = Lang.get("COLLECT_EDIT_请输入会员费名称");
            cPriceAmountWrongMessage = Lang.get("COLLECT_EDIT_请输入会员费票价");
            cPriceNameWrongMessage = Lang.get("COLLECT_EDIT_请输入会员费票价名称");
            cPriceNameDefaultText = Lang.get("COLLECT_PRODUCT_EDIT_票价种类名称");
        } else if(collectionType == "PRODUCT") {
            cTitleWrongMessage = Lang.get("COLLECT_EDIT_请输入产品名称");
            cPriceAmountWrongMessage = Lang.get("COLLECT_EDIT_请输入产品票价");
            cPriceNameWrongMessage = Lang.get("COLLECT_EDIT_请输入产品票价名称");
            cPriceNameDefaultText = Lang.get("COLLECT_MEMBER_EDIT_票价种类名称");
        }
        //检查收款名称
        var collectionTitleJEle = $("#collection_create_or_edit_form input[name='title']");
        if(YpValid.checkFormValueNull(collectionTitleJEle)) {
            YpMessage.showMessageAndFocusEle(wrongMsgContainer, cTitleWrongMessage, collectionTitleJEle);
            return;
        }
        //检查活动日期和地点
        if(collectionType == "EVENT") {
            var dateDefaultText=Lang.get("COLLECT_EDIT_年月日");
            var collectionEBeginDateJEle = $("#event_begin_date");
            var collectionEEndDateJEle = $("#event_end_date");
            if(YpValid.checkFormValueNull(collectionEBeginDateJEle) || collectionEBeginDateJEle.val()==dateDefaultText) {
                YpMessage.showMessageAndFocusEle(wrongMsgContainer, Lang.get("COLLECT_EDIT_请输入活动开始时间"), collectionEBeginDateJEle);
                return;
            }
            if(YpValid.checkFormValueNull(collectionEEndDateJEle) || collectionEEndDateJEle.val()==dateDefaultText) {
                YpMessage.showMessageAndFocusEle(wrongMsgContainer, Lang.get("COLLECT_EDIT_请输入活动结束时间"), collectionEEndDateJEle);
                return;
            }
            var collectionELocationJEle = $("#eventPlace");
            if(YpValid.checkFormValueNull(collectionELocationJEle)) {
                YpMessage.showMessageAndFocusEle(wrongMsgContainer, Lang.get("COLLECT_EDIT_请输入活动地点"), collectionELocationJEle);
                return;
            }
        }
        //检查webid
        var oldWebId = $("input[name='webId']").val();
        var wrongMsgContainer2 = $("#custom_webid_message");
        var webIdRegex = /^[0-9a-zA-Z-]{8,50}$/;
        var webIdJEle = $("#custom_webid");
        var webId = $.trim(webIdJEle.val());
        if(!webIdRegex.test(webId)){
            YpMessage.showWrongMessageAndFocusEle(wrongMsgContainer2, Lang.get('COLLECT_EDIT_链接错误'), webIdJEle);
            return;
        }
        $.getJSON("/collect/check_webid", {
            webId : webId,
            oldWebId: oldWebId
        } ,function(json){
            if(json.success){
                //检查收款票价
                
                var priceBasicInputsContainers = $("#collect_prices_container .basic_inputs_container");
                if(priceBasicInputsContainers.length == 0) {
                    YpMessage.showMessage(wrongMsgContainer, Lang.get("COLLECT_EDIT_请添加新种类"));
                    return;
                }
                else {
                    var flag = true;
                    $("body").removeData();
                    priceBasicInputsContainers.each(function(){
                        var container = $(this);
                        var priceNameJEle = container.find("input[name$='.name']");
                        if(YpValid.checkFormValueNull(priceNameJEle) || priceNameJEle.val()==cPriceNameDefaultText) {
                            YpMessage.showMessageAndFocusEle(wrongMsgContainer, cPriceNameWrongMessage, priceNameJEle);
                            flag = false;
                            return false;
                        }
                        var priceAmountJEle = container.find("input[name$='.amount']");
                        if(YpValid.checkFormValueNull(priceAmountJEle)) {
                            YpMessage.showMessageAndFocusEle(wrongMsgContainer, cPriceAmountWrongMessage, priceAmountJEle);
                            flag = false;
                            return false;
                        }
                        var amountRegex = /^[\d]+(\.\d{0,2})?$/;
                        if(!amountRegex.test(priceAmountJEle.val())){
                            YpMessage.showMessageAndFocusEle(wrongMsgContainer, Lang.get("COLLECT_EDIT_金额必须为数字"), priceAmountJEle);
                            flag = false;
                            return false;
                        }
                        //检查票价的起始时间和过期时间不应晚于活动的结束日期
                        if(collectionType == "EVENT") {
                            var priceExtraInputsContainer = container.next("tr");
                            var collectionEEndDate = $("#event_end_date").val();
                            var priceStartDateJEle = priceExtraInputsContainer.find("input[name$='.startDate']");
                            var priceExpireDateJEle = priceExtraInputsContainer.find("input[name$='.expireDate']");
                            var eventEndDateArray = collectionEEndDate.split("/");
                            var priceStartDateArray = priceStartDateJEle.val().split("/");
                            var priceExpireDateArray = priceExpireDateJEle.val().split("/");
                            if(language == "zh") {
                                // yyyy/MM/dd
                                var eventEndDate = new Date(eventEndDateArray[0],eventEndDateArray[1],eventEndDateArray[2]);
                                var priceStartDate = new Date(priceStartDateArray[0],priceStartDateArray[1],priceStartDateArray[2]);
                                var priceExpireDate = new Date(priceExpireDateArray[0],priceExpireDateArray[1],priceExpireDateArray[2]);
                            } else {
                                // MM/dd/yyyy
                                eventEndDate = new Date(eventEndDateArray[2],eventEndDateArray[0],eventEndDateArray[1]);
                                priceStartDate = new Date(priceStartDateArray[2],priceStartDateArray[0],priceStartDateArray[1]);
                                priceExpireDate = new Date(priceExpireDateArray[2],priceExpireDateArray[0],priceExpireDateArray[1]);
                            }
                            if(priceStartDate.getTime() > eventEndDate.getTime()) {
                                YpMessage.showMessageAndFocusEle(wrongMsgContainer, Lang.get("COLLECT_EDIT_MSG_价格有效期开始时间不能晚于活动结束时间"), priceStartDateJEle);
                                flag = false;
                                return false;
                            }
                            if(priceExpireDate.getTime() > eventEndDate.getTime()) {
                                YpMessage.showMessageAndFocusEle(wrongMsgContainer, Lang.get("COLLECT_EDIT_MSG_价格有效期结束时间不能晚于活动结束时间"), priceExpireDateJEle);
                                flag = false;
                                return false;
                            }
                        }
                        var order = container.find("input[name$='.order']").val();
                        $("body").data("price_order" + order + "_amount", $.trim(priceAmountJEle.val()));
                    })
                    if(!flag) {
                        return;
                    }
                }
                //检查折扣码
                var discountBasicInputsContainers = $("#collect_discounts_container .basic_inputs_container");
                var discountExtraInputsContainers = $("#collect_discounts_container .extra_inputs_container");
                if(discountBasicInputsContainers.length != 0) {
                    flag = true;
                    discountBasicInputsContainers.each(function(){
                        var container = $(this);
                        var discountCodeJEle = container.find("input[name$='.code']");
                        var discountNameJEle = container.find("input[name$='.name']");
                        var discountRateJEle = container.find("input[name$='.rate']");
                        if(!YpValid.checkFormValueNull(discountCodeJEle) || !YpValid.checkFormValueNull(discountNameJEle) || !YpValid.checkFormValueNull(discountRateJEle)) {
                            var discountCodeRegex = /[\w]{6,}/;
                            if(!discountCodeRegex.test(discountCodeJEle.val())) {
                                YpMessage.showMessageAndFocusEle(wrongMsgContainer, Lang.get("COLLECT_EDIT_折扣码应至少为六位的数字字母组合"), discountCodeJEle);
                                flag = false;
                                return false;
                            }
                            if(YpValid.checkFormValueNull(discountNameJEle)) {
                                YpMessage.showMessageAndFocusEle(wrongMsgContainer, Lang.get("COLLECT_EDIT_请输入折扣码名称"), discountNameJEle);
                                flag = false;
                                return false;
                            }
                            var discountType = container.find("select[name$='.type']").val();
                            var discountRateRegex = /\d+/;
                            if(discountType == "RATE") {
                                if(!discountRateRegex.test(discountRateJEle.val()) || parseInt(discountRateJEle.val())>100) {
                                    YpMessage.showMessageAndFocusEle(wrongMsgContainer, Lang.get("COLLECT_EDIT_折扣应为0到100间的数字"), discountRateJEle);
                                    flag = false;
                                    return false;
                                }
                            } else {
                                //Discount type is Amount
                                if(!discountRateRegex.test(discountRateJEle.val())) {
                                    YpMessage.showMessageAndFocusEle(wrongMsgContainer, Lang.get("COLLECT_EDIT_折扣应为0到100间的数字"), discountRateJEle);
                                    flag = false;
                                    return false;
                                }
                                var discountRate = discountRateJEle.val();
                                var discountPriceJEles = container.next("tr").find("div.collect_discount_related_price_container :checked");
                                discountPriceJEles.each(function(){
                                    var priceOrder = $(this).val();
                                    var priceAmount = $("body").data("price_order" + priceOrder + "_amount");
                                    if(parseInt(priceAmount) < parseInt(discountRate)) {
                                        YpMessage.showMessageAndFocusEle(wrongMsgContainer, Lang.get("COLLECT_EDIT_折扣码折扣不能大于对应的票价"), discountRateJEle);
                                        flag = false;
                                        return false;
                                    }
                                })
                            }
                        
                        }
                    })
                    if(!flag) {
                        return;
                    }
                }
                if(discountExtraInputsContainers.length != 0) {
                    flag = true;
                    discountExtraInputsContainers.each(function(){
                        var container = $(this);
                        var discountMaxCountJEle = container.find("input[name$='.maxCount']");
                        var discountMaxCountRegex = /\d+/;
                        
                        if(!YpValid.checkFormValueNull(discountMaxCountJEle) && !discountMaxCountRegex.test(discountMaxCountJEle.val())) {
                            YpMessage.showMessageAndFocusEle(wrongMsgContainer, Lang.get("COLLECT_EDIT_折扣次数限制应为数字"), discountMaxCountJEle);
                            flag = false;
                            return false;
                        }
                    });
                    if(!flag) {
                        return;
                    }
                }
                if(collectionType == "EVENT") {
                    //检查渠道码
                    var refBasicInputsContainers = $("#collect_referrals_container .basic_inputs_container");
                    if(refBasicInputsContainers.length != 0) {
                        var refNameDefaultText = Lang.get("COLLECT_EDIT_名称");
                        flag = true;
                        refBasicInputsContainers.each(function(){
                            var container = $(this);
                            var refCodeJEle = container.find("input[name$='.code']");
                            var refNameJEle = container.find("input[name$='.name']");
                            if(!YpValid.checkFormValueNull(refCodeJEle) || !YpValid.checkFormValueNullAndEqual(refNameJEle,refNameDefaultText)) {
                                var refCodeRegex = /[\w]{6,}/;
                                if(!refCodeRegex.test(refCodeJEle.val())) {
                                    YpMessage.showMessageAndFocusEle(wrongMsgContainer, Lang.get("COLLECT_EDIT_渠道码应至少为六位的数字字母组合"), refCodeJEle);
                                    flag = false;
                                    return false;
                                }
                                if(YpValid.checkFormValueNullAndEqual(refNameJEle,refNameDefaultText)) {
                                    YpMessage.showMessageAndFocusEle(wrongMsgContainer, Lang.get("COLLECT_EDIT_请输入渠道码名称"), refNameJEle);
                                    flag = false;
                                    return false;
                                }
                            }
                        })
                        if(!flag) {
                            return;
                        }
                    }
                }
                //检查收款方式
                var allowPayGateTypeContainer = $("#collect_paygate_type_container");
                var allowPayGateTypes = allowPayGateTypeContainer.find(":checkbox:checked");
                if(allowPayGateTypes.length < 1){
                    YpMessage.showMessage(wrongMsgContainer, Lang.get("COLLECT_EDIT_请至少选择一种支付方式"));
                    return;
                }
                if(keditor != null){
                    keditor.sync();
                }
                if(keditorHost != null){
                    keditorHost.sync();
                }
                if(ticketCZhContentEditor != null){
                    ticketCZhContentEditor.sync();
                }
                if(ticketCEnContentEditor != null){
                    ticketCEnContentEditor.sync();
                }
                
                $('#collection_create_or_edit_form').submit();   
            }
            else {
                YpMessage.showWrongMessageAndFocusEle(wrongMsgContainer2, json.singleErrorMsg, webIdJEle);
                return;
            }
        });
    }
}
var Approval = {
    _initApprovalOperationUnprocessed:false,
    showApprovalOperationDialogUnprocessed : function(serialId){
        if(!Approval._initApprovalOperationUnprocessed){
            if($('#approval_operatin_is_send_email').attr("checked")){
                $('#approval_operatin_is_send_note_message_unp').removeAttr("disabled");
            }
            else{
                $('#approval_operatin_is_send_note_message_unp').attr("disabled","disabled");
            }
            $('#approval_operation_template_unprocessed').dialog({
                autoOpen: false, 
                width:660,
                show: 'fade',
                modal: true,
                title: Lang.get("COLLECT_APPROVAL_OPERATION_DIALOG_操作")
            });
            Approval._initApprovalOperationUnprocessed = true;
        }
        $('input[name=subSerial_id]').val(serialId);
        $('#approval_operation_template_unprocessed').dialog('open');
    },
    closeApprovalOperationDialogUnprocessed : function(){
        $('#approval_operation_template_unprocessed').dialog('close');
        Approval.resetApprovalOperationDialog();
    },
    resetApprovalOperationDialogUnprocessed : function(){
        $('#approval_operation_template_unprocessed').show();
    },
    _initApprovalOperationProcessed:false,
    showApprovalOperationDialogProcessed : function(serialId){
        if(!Approval._initApprovalOperationProcessed){
            $('#approval_operation_template_processed').dialog({
                autoOpen: false, 
                width:660,
                show: 'fade',
                modal: true,
                title: Lang.get("COLLECT_APPROVAL_OPERATION_DIALOG_操作")
            });
            Approval._initApprovalOperationProcessed = true;
        }
        $('input[name=subSerial_id]').val(serialId);
        var url = '/collect/approval_list/'+serialId;
        var data = {
            a : 'SHOW_APPROVAL_NOTE_MESSAGE'
        };
        $.post(url, data, function(json){
            if(json.success){
                document.getElementById("approval_operated_textarea_message_p").value=json.singleSuccessMsg;
                $('#approval_operation_template_processed').dialog('open');
            } else {
                alert("COLLECT_APPROVAL_OPERATION_DIALOG_操作失败");
            }
        }, "json");
    },
    closeApprovalOperationDialogProcessed : function(){
        $('#approval_operation_template_processed').dialog('close');
        Approval.resetApprovalOperationDialog();
    },
    resetApprovalOperationDialogProcessed : function(){
        $('#approval_operation_template_processed').show();
    },
    operationApproval : function(type){
        var orderId = $('input[name=subSerial_id]').val();
        var isSendMail = $("#approval_operatin_is_send_email").attr("checked");
        var isSendNoteMessage;
        var noteMessage;
        if(type == "PASS"){
            noteMessage = $("#approval_unoperated_textarea_message_unp").val();
            isSendNoteMessage = $("#approval_operatin_is_send_note_message_unp").attr("checked");
        }else if(type == "REFUSE"){
            noteMessage = $("#approval_unoperated_textarea_message_unp").val();
            isSendNoteMessage = $("#approval_operatin_is_send_note_message_unp").attr("checked");
        }
        else if(type == "RESEND_MAIL"){
            noteMessage = $("#approval_operated_textarea_message_p").val();
            isSendNoteMessage = $("#approval_operatin_is_send_note_message_p").attr("checked");
        }
        else if(type == "REMARK_NOTE"){
            noteMessage = $("#approval_operated_textarea_message_p").val();
            alert(noteMessage);
        }
        if(isSendMail == true || isSendMail == 'checked'){
            isSendMail = true;
        }else{
            isSendMail = false;
        }
        if(isSendNoteMessage == true || isSendNoteMessage == 'checked'){
            isSendNoteMessage = true;
        }
        else{
            isSendNoteMessage = false;
        }
        var url = "/collect/approval_list/"+orderId;
        var data = {
            is_send_mail:isSendMail,
            is_send_note_message:isSendNoteMessage,
            note_message:noteMessage,
            type:type,
            a:"APPROVAL_OPRERATION"
        };
        $.post(url, data, function(json){
            if(json.success){
                alert(Lang.get("COLLECT_APPROVAL_OPERATION_DIALOG_操作成功"));
                redirectSelf();
            } else {
                alert(Lang.get("COLLECT_APPROVAL_OPERATION_DIALOG_操作失败"));
                redirectSelf();
            }
        }, "json");
    },
    checkedOnclick : function(webId){
        var value = window.document.getElementById("approval_select").value;
        var pendingFoeApproval = false;
        var approvalPass = false;
        var approvalReject = false;
        var url = "/collect/approval_list/"+webId;
        if(value == 0){
            pendingFoeApproval = true;
            approvalPass = true;
            approvalReject = true;
        }else if(value == 1){
            pendingFoeApproval = true;
        }else if(value == 2){
            approvalPass = true;
        }else if(value == 3){
            approvalReject = true;
        }
        redirect(url+'?pending_for_approval='+pendingFoeApproval+'&approval_pass='+approvalPass+'&approval_reject='+approvalReject);
    },
    showDetiledInformation: function(webId,serialId){
        var data = {
            serial_id:serialId
        };
        var url = "/collect/approval_list_detailed_information/"+webId;
        $("#approval_list_detailed_information").load(url,data, function(){
            $('#approval_list_detailed_information').dialog({
                autoOpen: false, 
                width: 925,
                show: 'fade',
                modal: true,
                title: Lang.get("COLLECT_APPROVAL_OPERATION_DIALOG_详细信息")
            });
            $('#approval_list_detailed_information').dialog('open');
        }); 
    },
    onclickIsSendEmail:function(){
        if($('#approval_operatin_is_send_email').attr("checked")){
            $('#approval_operatin_is_send_note_message_unp').removeAttr("disabled");
        }else{
            $('#approval_operatin_is_send_note_message_unp').attr("disabled","disabled");
        } 
    }
}

var CollectPromote={
    showConfirmSend : function(webId,type,elementId){
        var data;
        if(type=="mobile"){
            var mobilePhones = $.trim($("#promote_mobile_phones").val());
            var shortMessageContent = $.trim($("#promote_short_message_content").val());
            if(mobilePhones == "" ){
                MessageShow.showWrongMessage(Lang.get("COLLECT_SEND_请输入手机号码"),'mobilePhones');
                return;
            }
            if(shortMessageContent == ""){
                MessageShow.showWrongMessage(Lang.get("COLLECT_SEND_请输入短信内容"),'shortMessageContent');
                return; 
            }
            data = {
                webId:webId,
                mobilePhones:mobilePhones,
                shortMessageContent:shortMessageContent,
                type:type
            };
        }else{
            var fromName=$.trim($('#fromName').val());
            var replyToEmail=$.trim($('#replyToEmail').val());
            var emails=$.trim($('#send_email').val());
            var subject=$.trim($('#subject').val());
            var emailContent=$.trim($('#email_content').val());
            if(type=="event_email"){
                data = {
                    webId:webId,
                    fromName:fromName,
                    replyToEmail:replyToEmail,
                    subject:subject,
                    emailContent:emailContent,
                    emails:emails,
                    type:type
                };  
            }else{
                data = {
                    webId:webId,
                    emails:emails,
                    type:type
                };
            }
             
        }
        var url = "/collect/confirm_send/"+webId;
        $("#"+elementId).load(url,data, function(){
            $('#'+elementId).dialog({
                autoOpen: false, 
                width: 650,
                show: 'fade',
                modal: true,
                title: ""
            });
            $('#'+elementId).dialog('open');
            var fundCollectionShortId = $("#collect_promote_fund_collection_short_id_copy").val();
            if(fundCollectionShortId != ""){
                $("#collect_promote_fund_collection_short_id").val(fundCollectionShortId + "");
            }
        });
    },
    closeConfirmSend : function(elementId){
        $('#'+elementId).dialog('close');
    },
    submitForm : function(formId,elementId){
        MessageShow.showLoadingMessage();
        CollectPromote.closeConfirmSend(elementId);
        $("#"+formId).submit();
    },
    calculateShortMessageCount : function(){
        var shortMessageContent = $.trim($("#promote_short_message_content").val());
        $("#short_message_count_promote").text((Math.ceil((4+shortMessageContent.length)/70))+"");
    },
    textareaOnfocus : function(eid){
        eid = $.trim(eid);
        var element = $("#"+eid);
        if(eid=="promote_mobile_phones"){
            var phoneflag = $("#collect_promote_fund_collection_short_phone").val();
            if(phoneflag == 1){
                $("#collect_promote_fund_collection_short_phone").val("-1");
                element.val("");
                element.css("color", "");
            }
        }else if(eid=="promote_short_message_content"){
            var testflag = $("#collect_promote_fund_collection_short_test").val();
            if(testflag == 1){
                $("#collect_promote_fund_collection_short_test").val("-1");
                element.val("");
                element.css("color", "");
            }
        }
    },
    initCollectPromoteIndex : function(){
        var sms = $("#collect_promote_index_sms");
        var email = $("#collect_promote_index_email");
        sms.mouseover(function(){
            sms.css("border-style","solid");
            sms.css("border-width","1px");
            sms.css("border-color","aqua");
        });
        sms.mouseout(function(){
            sms.css("border-style","");
            sms.css("border-width","");
            sms.css("border-color","");
        });
        email.mouseover(function(){
            email.css("border-style","solid");
            email.css("border-width","1px");
            email.css("border-color","aqua");
        });
        email.mouseout(function(){
            email.css("border-style","");
            email.css("border-width","");
            email.css("border-color","");
        });
    }
}

//签到
var Checkin={
    showCheckinModel : function(id){
        var element = $("#"+id);
        element.dialog({
            autoOpen: false, 
            width:660,
            show: 'fade',
            modal: true,
            title: ""
        });
        element.dialog('open');
    },
    closeCheckinModel  : function(id){
        var element = $("#"+id);
        element.dialog('close');
        Checkin.resetCheckinModel(id);
    },
    resetCheckinModel  : function(id){
        var element = $("#"+id);
        element.show();
    },
    setCheckinEnabled : function(webId,state,id){
        var checkinEnabled = true;
        if(state == 'off'){
            checkinEnabled = false;
        }
        var url = "/collect/checkin/"+webId;
        var data = {
            checkinEnabled:checkinEnabled,
            webId:webId,
            a:"MODIFY_CHECKIN_ENABLED"
        };
        $.post(url, data, function(json){
            if(json.success){
                $("#"+id).attr("checked", "checked");
                if(state == 'on'){
                    $("#checkin_set3").css("display","");
                    Checkin.closeCheckinModel('checkin_system_on');
                    redirectSelf();
                }else if(state == 'off'){
                    $("#checkin_set3").css("display","none");
                    Checkin.closeCheckinModel('checkin_system_off');
                }
            //location.reload();
            }
            else{
                if(json.redirectUrl != "") {
                    redirect(json.redirectUrl);
                }
                else{
                    alert(json.singleErrorMsg);  
                }
            }
        }, "json");
    },
    setCheckinPassword : function(webId){
        var passwd1 = $.trim($("#checkin_passwd1").val());
        var passwd2 = $.trim($("#checkin_passwd2").val());
        if(passwd1 == "" || passwd2 == ""){
            alert(Lang.get("COLLECT_CHECKIN_密码不能为空"));
            return false;
        }
        if(passwd1.length < 6 || passwd2.length < 6){
            alert(Lang.get("COLLECT_CHECKIN_密码长度至少6位"));
            return false;
        }
        if(passwd1 != passwd2){
            alert(Lang.get("COLLECT_CHECKIN_两次密码不一致"));
            return false;
        }
        var url = "/collect/checkin/"+webId;
        var data = {
            passwd1:passwd1,
            passwd2:passwd2,
            webId:webId,
            a:"SET_CHECKIN_PASSWORD"
        };
        $.post(url, data, function(json){
            if(json.success){
                $("#checkin_passwd1").attr("disabled", "disabled");
                $("#checkin_passwd2").attr("disabled", "disabled");
                $("#checkin_passwd1").val("******");
                $("#checkin_passwd2").val("******");
                $("#checkin_passwd_button").attr("disabled", "disabled");
                $("#checkin_set2").css("display","");
                $("#checkin_passwd2").css("display","none");
                $("#checkin_passwd_button").css("display","none");
                $("#checkin_passwd_link").css("display","");
                $("#checkin_passwd_link_cancel").css("display", "none");
            }else {
                alert(Lang.get(json.singleErrorMsg));
            }
        }, "json");
    },
    resetCheckinPassword:function(){
        $("#checkin_passwd1").removeAttr("disabled");
        $("#checkin_passwd2").removeAttr("disabled");
        $("#checkin_passwd1").val("");
        $("#checkin_passwd2").val("");
        $("#checkin_passwd2").css("display","");
        $("#checkin_passwd_button").css("display","");
        $("#checkin_passwd_button").removeAttr("disabled");
        $("#checkin_passwd_link").css("display", "none");
        $("#checkin_passwd_link_cancel").css("display", "");
        $("#checkin_passwd1").focus();
    },
    cancelResetCheckinPassword:function(){
        $("#checkin_passwd1").attr("disabled", "disabled");
        $("#checkin_passwd2").attr("disabled", "disabled");
        $("#checkin_passwd1").val("******");
        $("#checkin_passwd2").val("******");
        $("#checkin_passwd_button").attr("disabled", "disabled");
        $("#checkin_set2").css("display","");
        $("#checkin_passwd2").css("display","none");
        $("#checkin_passwd_button").css("display","none");
        $("#checkin_passwd_link").css("display","");
        $("#checkin_passwd_link_cancel").css("display", "none");
    },
    fouceCheckinPassword:function(id){
        var element = $("#"+id);
        element.val("");
        element.css("color","");
        element[0].type = "password";
    },
    _init:false,
    openServiceDialog:function(){
        if(!Checkin._init){
            $('#chekin_service_dialog').dialog({
                autoOpen: false, 
                width: 600,
                show: 'fade',
                hide: 'fade',
                modal: true
            });   
            Checkin._init = true;
        }
        $('#chekin_service_dialog').dialog('open');
    },
    closeServiceDialog:function(){
        $('#chekin_service_dialog').dialog('close');
    },
    doCheckin : function(barcode,checkin){
        var url = "/checkin/login/"+ $("#checkin_webId").val();
        var data = {
            webId:$("#checkin_webId").val(),
            barcode:barcode,
            checkin:checkin,
            a:"DO_CHECKIN"
        };
        $.post(url, data, function(json){
            if(json.success){
                if(checkin == 'true'){
                    $("#checkin_on_"+barcode).css("display", "none");
                    $("#checkin_off_"+barcode).css("display", "");
                }
                else if(checkin == 'false'){
                    $("#checkin_on_"+barcode).css("display", "");
                    $("#checkin_off_"+barcode).css("display", "none");
                }else{
                    redirectSelf();
                }
            } else {
                if(json.redirectUrl != "") {
                    redirect(json.redirectUrl);
                }
                else{
                    alert(Lang.get("GLOBAL_操作失败"));
                }
            }
        }, "json");
    },
    checkinSelectOnchange : function(webId){
        var checkin = $("#checkin_select").val();
        var url = "/checkin/search/"+webId;
        redirect(url+'?checkin='+checkin);
    },
    initTextCopy : function() {
        $("#checkin_copy_link").zclip({
            path:'/scripts/ZeroClipboard.swf',
            copy:function(){
                return $('#checkin_copy_text').val();
            },
            beforeCopy:function(){
            },
            afterCopy:function(){
                alert(Lang.get("PAYMENT_WIDGET_复制成功"));
            }
        });
    }
}
//收款票价
var FundCollectionPrice = {
    //init
    init:function(isEdit,type){
        if(!isEdit){
            //Create new FundCollection
            FundCollectionPrice.addOption();
        }
        else {
            //Edit FundCollection
            if(type=="EVENT") {
                //Init datepicker and timeselecter
                var optionExtraInputsContainers = $("#collect_prices_container .extra_inputs_container");
                optionExtraInputsContainers.each(function(){
                    var startDateEle = $(this).find("input[name$='.startDate']").first();
                    var expireDateEle = $(this).find("input[name$='.expireDate']").first();
                    YpDate.setDatePicker(startDateEle, expireDateEle);
                    var startTimeEle = $(this).find("select[name$='.startTime']").first();
                    var expireTimeEle = $(this).find("select[name$='.expireTime']").first();
                    YpDate.setTimeSelect(startTimeEle, expireTimeEle);
                    
                    var startTime = startTimeEle.attr("cvalue");
                    startTimeEle.val(startTime);
                    
                    var endTime = expireTimeEle.attr("cvalue");
                    expireTimeEle.val(endTime);
                })
            }
        }
    },
    synCurrencyType: function(obj){
        var currencyType = $(obj).val();
        $("#collect_prices_container select[name$='.currency_type']").val(currencyType);
        var discountTypeText = Lang.get("GLOBAL_元");
        if(currencyType == "USD") {
            discountTypeText = Lang.get("GLOBAL_美元");
        }
        $("select[name^='fund_collection_discount'][name$='.type'] option[value='AMOUNT']").text(discountTypeText);
    },
    //Add or del price option which discount related and hidden price which referral related and price option which custom question related
    synFundCollectionDiscountAndReferral : function(obj, defaultText) {
        var container = $(obj).parents("td").parent("tr");
        var priceBasicInputsContainer;
        var priceExtraInputsContainer;
        if(container.hasClass("extra_inputs_container")) {
            priceExtraInputsContainer = container;
            priceBasicInputsContainer = priceExtraInputsContainer.prev("tr.basic_inputs_container");
        }
        else {
            priceBasicInputsContainer = container;
            priceExtraInputsContainer = priceBasicInputsContainer.next("tr.extra_inputs_container");
        }
        
        var priceNameJEle = priceBasicInputsContainer.find("input[name$='.name']");
        var priceName = priceNameJEle.val();
        var priceOrderJEle = priceBasicInputsContainer.find("input[name$='.order']");
        var priceOrder = priceOrderJEle.val();
        var priceAmountJEle = priceBasicInputsContainer.find("input[name$='.amount']");
        var priceAmount = priceAmountJEle.val();
        var priceHiddenJEle = priceExtraInputsContainer.find("input[name$='.hidden']");
        if(priceName != "" && priceName != defaultText && priceAmount != "" && parseInt(priceAmount) > 0) {
            FundCollectionDiscount.addOrEditRelatedPrice(priceOrder, priceName);
        }else {
            FundCollectionDiscount.delRelatedPrice(priceOrder);
        }
        if(priceName != "" && priceName != defaultText && priceHiddenJEle.attr("checked")) {
            FundCollectionReferral.addOrEditRelatedPrice(priceOrder, priceName);
        }else {
            FundCollectionReferral.delRelatedPrice(priceOrder);
        }
        if(priceName != "" && priceName != defaultText) {
            CollectDIY.addOrEditRelatedPrice(priceOrder, priceName);
        } else {
            CollectDIY.delRelatedPrice(priceOrder);
        }
        if(priceName != "" && priceName != defaultText) {
            FundCollectionTicketDiy.addOrEditRelatedPrice(priceOrder, priceName);
        } else {
            FundCollectionTicketDiy.delRelatedPrice(priceOrder);
        }
        if(defaultText != "") {
            YpEffects.toggleFocus4Ele(priceNameJEle[0], 'blur', defaultText, '', '#909ea4');
        }
    },
    setFreeAmount : function(eleCheckBox) {
        var ele = $(eleCheckBox);
        var priceBasicInputsContainer = ele.parent("td").parent("tr");
        var amountEle = priceBasicInputsContainer.find("input[name$='.amount']");
        if(ele.attr("checked")=="checked"){
            amountEle.val("0");
            amountEle.attr("readonly", "readonly");
            amountEle.css("color", "#909ea4");
            var priceOrderJEle = priceBasicInputsContainer.find("input[name$='.order']");
            var priceOrder = priceOrderJEle.val();
            FundCollectionDiscount.delRelatedPrice(priceOrder);
        }
        else {
            amountEle.val("");
            amountEle.removeAttr("readonly");
            amountEle.css("color", "black");
        }
    },
    
    //Add new price option
    addOption:function(){
        var collectionType = $("#collection_type_input").val();
        var container = $("#collect_prices_container");
        var optionTemplate = $("#collect_price_option_template").clone();
        var options = container.find("tr");
        var optionsLength = options.length;
        var index = 0;
        if(optionsLength!=0) {
            index = parseInt($(options[optionsLength-2]).find("input[name$='.order']").val()) + 1;
        }
        optionTemplate.html(optionTemplate.html().replace(/\{0\}/g, index));
        optionTemplate.find("input[name$='.order']").val(index);
        var currencyType = "CNY";
        if(optionsLength!=0) {
            //Set currency type same to others
            currencyType = options.first().find("select[name$='.currency_type']").val();
        }
        optionTemplate.find("select[name$='.currency_type']").val(currencyType); 
        if(collectionType == 'EVENT') {
            //设置票价开始和结束日期和时间的datepicker和timeselecter
            var startDateEle = optionTemplate.find("input[name$='.startDate']").first();
            var expireDateEle = optionTemplate.find("input[name$='.expireDate']").first();
            YpDate.setDatePicker(startDateEle, expireDateEle);
            var startTimeEle = optionTemplate.find("select[name$='.startTime']").first();
            var expireTimeEle = optionTemplate.find("select[name$='.expireTime']").first();
            YpDate.setTimeSelect(startTimeEle, expireTimeEle);
            //初始化开始和结束日期的默认值
            startDateEle.val(Lang.get("COLLECT_EDIT_年月日")).css("color","#909ea4");
            expireDateEle.val(Lang.get("COLLECT_EDIT_年月日")).css("color","#909ea4");
        }
        
        container.append(optionTemplate.find("tr"));
    },
    //Remove price option
    delOption:function(eleA){
        if(confirm(Lang.get('GLOBAL_确定删除'))){
            var parentContainer = $(eleA).parent("td").parent("tr");
            var extraContainer = parentContainer.next("tr");
            //Check whether or not the option is database status
            if(parentContainer.find("input[name$='.id']").length > 0) {
                //the option exist in the database
                parentContainer.find("input[name$='.deleted']").val("true");
                parentContainer.hide();
                extraContainer.hide();
            } else {
                parentContainer.remove();
                extraContainer.remove();
            }
            //Del price option which discount related 
            var priceOrderJEle = parentContainer.find("input[name$='.order']");
            var priceOrder = priceOrderJEle.val();
            FundCollectionDiscount.delRelatedPrice(priceOrder);
            CollectDIY.delRelatedPrice(priceOrder);
            FundCollectionTicketDiy.delRelatedPrice(priceOrder);
        }
    },
    toggleExtraInputs : function(eleA){
        var parentContainer = $(eleA).parent("td").parent("tr");
        var extraContainer = parentContainer.next("tr");
        if(extraContainer.css("display") == "none") {
            extraContainer.show();
            $(eleA).html(Lang.get('COLLECT_EDIT_ACTION_收起'));
        }
        else {
            extraContainer.hide();
            $(eleA).html(Lang.get('COLLECT_EDIT_ACTION_展开'));
        }
    }
}
//收款折扣码
var FundCollectionDiscount = {
    //init
    init:function(isEdit){
        if(!isEdit){
            //Create new FundCollection
            FundCollectionDiscount.addOption();
        }
        else {
            //Edit FundCollection
            var container = $("#collect_discounts_container");
            if(container.find("input[name$='.id']").length == 0){
                FundCollectionDiscount.addOption();
            }
            //Check the all price checkbox
            var discountPriceContainers = $("#collection_create_or_edit_form .collect_discount_related_price_container");
            discountPriceContainers.each(function(){
                if($(this).find(":checkbox").length == $(this).find(":checkbox:checked").length) {
                    //All check
                    $(this).prev().attr("checked",true);
                }
            });
            //Init datepicker and timeselecter
            var optionExtraInputsContainers = $("#collect_discounts_container .extra_inputs_container");
            optionExtraInputsContainers.each(function(){
                var startDateEle = $(this).find("input[name$='.startDate']").first();
                var expireDateEle = $(this).find("input[name$='.expireDate']").first();
                YpDate.setDatePicker(startDateEle, expireDateEle);
                var startTimeEle = $(this).find("select[name$='.startTime']").first();
                var expireTimeEle = $(this).find("select[name$='.expireTime']").first();
                YpDate.setTimeSelect(startTimeEle, expireTimeEle);
                
                var startTime = startTimeEle.attr("cvalue");
                startTimeEle.val(startTime);
                
                var endTime = expireTimeEle.attr("cvalue");
                expireTimeEle.val(endTime);
            })
        }
    },
    //全选/全不选所有价钱
    toggleRelatedPrice:function(obj){
        var checked = $(obj).attr("checked");
        $(obj).next("div").find("input[type='checkbox']").attr("checked", checked);
    },
    //选中/不选中所有价格复选框
    toggleRelatedAllPriceCheckbox : function(obj) {
        var checked = $(obj).attr("checked");
        if(!checked){
            $(obj).parent("p").parent("div").prev(":checkbox.discount_related_price_all_cb").attr("checked",false);
        }
    },
    addOrEditRelatedPrice:function(priceOrder,priceName) {
        var cdiscountRelatedPriceContainers =  $(".collect_discount_related_price_container");
        cdiscountRelatedPriceContainers.each(function(){
            var cdiscountRelatedPriceContainer = $(this);
            var discountContainer = cdiscountRelatedPriceContainer.parent("div").parent("td").parent("tr").prev("tr");
            var discountOrderName = discountContainer.find("input[name$='.order']").attr("name");
            var discountIndex = discountOrderName.split(".")[0].substring(discountOrderName.indexOf("[") + 1, discountOrderName.indexOf("]"));
            
            var checkboxInputName = "fund_collection_discount["+ discountIndex +"].price_order_list[" + priceOrder + "]";
            var checkboxPriceJEle = cdiscountRelatedPriceContainer.find("input[name='"+checkboxInputName+"']");
            if(checkboxPriceJEle.length > 0){
                var parentP = checkboxPriceJEle.parent("p");
                parentP.text(priceName);
                parentP.prepend(checkboxPriceJEle);
            }
            else {
                var allCheckboxJEle = cdiscountRelatedPriceContainer.parent().find(":checkbox.discount_related_price_all_cb").first();
                var checkbox = YpElement.createCheckboxInput(checkboxInputName, priceOrder);
                if(allCheckboxJEle.attr("checked")) {
                    checkbox[0].setAttribute("checked", "checked");
                }
                checkbox.click(function(){
                    FundCollectionDiscount.toggleRelatedAllPriceCheckbox(checkbox[0]);
                })
                var option = $("<p></p>");
                option.text(priceName);
                option.prepend(checkbox);
                cdiscountRelatedPriceContainer.append(option);
            }
        
        })
    
    
    },
    delRelatedPrice : function(priceOrder) {
        var cdiscountRelatedPriceContainers =  $(".collect_discount_related_price_container");
        var checkboxPriceJEle = cdiscountRelatedPriceContainers.find("input[name$='.price_order_list["+priceOrder+"]']");
        checkboxPriceJEle.parent("p").remove();
    },
    //Add new discount option
    addOption:function(){
        var container = $("#collect_discounts_container");
        var optionTemplate = $("#collect_discount_option_template").clone();
        var options = container.find("tr");
        var optionsLength = options.length;
        var index = 0;
        if(optionsLength!=0) {
            index = parseInt($(options[optionsLength-2]).find("input[name$='.order']").val()) + 1;
        }
        optionTemplate.html(optionTemplate.html().replace(/\{0\}/g, index));
        optionTemplate.find("input[name$='.order']").val(index);
        //设置票价开始和结束日期和时间的datepicker和timeselecter
        var startDateEle = optionTemplate.find("input[name$='.startDate']").first();
        var expireDateEle = optionTemplate.find("input[name$='.expireDate']").first();
        YpDate.setDatePicker(startDateEle, expireDateEle);
        var startTimeEle = optionTemplate.find("select[name$='.startTime']").first();
        var expireTimeEle = optionTemplate.find("select[name$='.expireTime']").first();
        YpDate.setTimeSelect(startTimeEle, expireTimeEle);
        //初始化开始和结束日期的默认值
        startDateEle.val(Lang.get("COLLECT_EDIT_年月日")).css("color","#909ea4");
        expireDateEle.val(Lang.get("COLLECT_EDIT_年月日")).css("color","#909ea4");
        container.append(optionTemplate.find("tr"));
    },
    //Remove discount option
    delOption:function(eleA){
        if(confirm(Lang.get('GLOBAL_确定删除'))){
            var parentContainer = $(eleA).parent("td").parent("tr");
            var extraContainer = parentContainer.next("tr");
            //Check whether or not the option is database status
            if(parentContainer.find("input[name$='.id']").length > 0) {
                //the option exist in the database
                parentContainer.find("input[name$='.deleted']").val("true");
                parentContainer.hide();
                extraContainer.hide();
            } else {
                parentContainer.remove();
                extraContainer.remove();
            }
        
        }
    },
    toggleExtraInputs : function(eleA){
        var parentContainer = $(eleA).parent("td").parent("tr");
        var extraContainer = parentContainer.next("tr");
        if(extraContainer.css("display") == "none") {
            extraContainer.show();
            $(eleA).html(Lang.get('COLLECT_EDIT_ACTION_收起'));
        }
        else {
            extraContainer.hide();
            $(eleA).html(Lang.get('COLLECT_EDIT_ACTION_展开'));
        }
    }
}
//收款渠道码
var FundCollectionReferral = {
    //init
    init:function(isEdit, hiddenPriceCount){
        if(!isEdit){
            //Create new FundCollection
            FundCollectionReferral.addOption();
        } else {
            //Edit FundCollection
            var container = $("#collect_referrals_container");
            if(container.find("input[name$='.id']").length == 0){
                FundCollectionReferral.addOption();
            }
            //Check the all price checkbox
            var referralPriceContainers = $("#collection_create_or_edit_form .collect_referral_related_hprice_container");
            referralPriceContainers.each(function(){
                if($(this).find(":checkbox").length == $(this).find(":checkbox:checked").length) {
                    //All check
                    $(this).prev().attr("checked",true);
                }
            })
        }
        if(hiddenPriceCount > 0) {
            $(".referral_related_hprice_all_cb").removeAttr("disabled");
        } else {
            $(".referral_related_hprice_all_cb").attr("disabled", "disabled");
        }
    },
    //Set referral link text: https://yoopay.cn/event/[webid]?ref=[refname]
    setLinkText:function(obj){
        var link = "https://yoopay.cn/event/";
        var webIdEle = $("#custom_webid");
        if(webIdEle.val()!="") {
            link += webIdEle.val();
        } else {
            return;
        }
        var refCodeJEle = $(obj);
        var referralExtraContainer = refCodeJEle.parent("td").parent("tr").next("tr");
        var referralLinkContainer = referralExtraContainer.find("td.collect_referral_link_container");
        
        var pattern = /[\w]{6,}/;
        if(pattern.test(refCodeJEle.val())) {
            link += "?ref=" + refCodeJEle.val();
            referralLinkContainer.html(link);
            referralLinkContainer.css("color","black");
        } else {
            referralLinkContainer.html(Lang.get("COLLECT_EDIT_渠道码应至少为六位的数字字母组合"));
            referralLinkContainer.css("color","red");
        }
        referralExtraContainer.fadeIn();
    
    },
    updateAllLinkText:function(){
        var link = "https://yoopay.cn/event/";
        var webIdEle = $("#custom_webid");
        if(webIdEle.val()!="") {
            link += webIdEle.val();
        } else {
            return;
        }
        var referralLinkContainers = $("td.collect_referral_link_container");
        referralLinkContainers.each(function(){
            var referralLinkContainer = $(this);
            var referalCodeJEle = referralLinkContainer.parent("tr").prev("tr").find("input[name$='.code']");
            if(referalCodeJEle.val()!="") {
                var nlink = link+  "?ref=" + referalCodeJEle.val();
            } else {
                return;
            }
            referralLinkContainer.html(nlink);
        })
    },
    //Add new referral option
    addOption:function(){
        var container = $("#collect_referrals_container");
        var optionTemplate = $("#collect_referral_option_template").clone();
        var options = container.find("tr");
        var optionsLength = options.length;
        var index = 0;
        if(optionsLength!=0) {
            index = parseInt($(options[optionsLength-3]).find("input[name$='.order']").val()) + 1;
        }
        optionTemplate.html(optionTemplate.html().replace(/\{0\}/g, index));
        optionTemplate.find("input[name$='.order']").val(index);
        container.append(optionTemplate.find("tr"));
    },
    //Remove referral option
    delOption:function(eleA){
        if(confirm(Lang.get('GLOBAL_确定删除'))){
            var parentContainer = $(eleA).parent("td").parent("tr");
            var extraContainer = parentContainer.next("tr");
            var extraContainer2 = extraContainer.next("tr");
            //Check whether or not the option is database status
            if(parentContainer.find("input[name$='.id']").length > 0) {
                //the option exist in the database
                parentContainer.find("input[name$='.deleted']").val("true");
                parentContainer.hide();
                extraContainer.hide();
                extraContainer2.hide();
            } else {
                parentContainer.remove();
                extraContainer.remove();
                extraContainer2.remove();
            }
        
        }
    },
    //全选/全不选所有价钱
    toggleRelatedPrice:function(obj){
        var checked = $(obj).attr("checked");
        $(obj).next("div").find("input[type='checkbox']").attr("checked", checked);
    },
    //选中/不选中所有价格复选框
    toggleRelatedAllPriceCheckbox : function(obj) {
        var checked = $(obj).attr("checked");
        if(!checked){
            $(obj).parent("p").parent("div").prev(":checkbox.referral_related_hprice_all_cb").attr("checked",false);
        }
    },
    addOrEditRelatedPrice:function(priceOrder,priceName) {
        var cRefRelatedPriceContainers =  $(".collect_referral_related_hprice_container");
        cRefRelatedPriceContainers.each(function(){
            var cRefRelatedPriceContainer = $(this);
            var refContainer = cRefRelatedPriceContainer.parent("div").parent("td").parent("tr").prevAll("tr.basic_inputs_container");
            var refOrderName = refContainer.find("input[name$='.order']").attr("name");
            var refIndex = refOrderName.split(".")[0].substring(refOrderName.indexOf("[") + 1, refOrderName.indexOf("]"));
            
            var checkboxInputName = "fund_collection_referral["+ refIndex +"].price_order_list[" + priceOrder + "]";
            var checkboxPriceJEle = cRefRelatedPriceContainer.find("input[name='"+checkboxInputName+"']");
            if(checkboxPriceJEle.length > 0){
                var parentP = checkboxPriceJEle.parent("p");
                parentP.text(priceName);
                parentP.prepend(checkboxPriceJEle);
            } else {
                var checkbox = YpElement.createCheckboxInput(checkboxInputName, priceOrder);
                checkbox.click(function(){
                    FundCollectionReferal.toggleRelatedAllPriceCheckbox(checkbox[0]);
                })
                var option = $("<p></p>");
                option.text(priceName);
                option.prepend(checkbox);
                cRefRelatedPriceContainer.append(option);
                //Uncheck all the all price checkbox
                $(".referral_related_hprice_all_cb").attr("checked",false);
                $(".referral_related_hprice_all_cb").removeAttr("disabled");
            }
        })
    },
    delRelatedPrice : function(priceOrder) {
        var cdiscountRelatedPriceContainers =  $(".collect_referral_related_hprice_container");
        var checkboxPriceJEle = cdiscountRelatedPriceContainers.find("input[name$='.price_order_list["+priceOrder+"]']");
        checkboxPriceJEle.parent("p").remove();
        if(cdiscountRelatedPriceContainers.find("p").length == 0) {
            $(".referral_related_hprice_all_cb").attr("disabled","disabled");
        }
    },
    toggleExtraInputs : function(eleA){
        var parentContainer = $(eleA).parent("td").parent("tr");
        var extraContainer = parentContainer.next("tr");
        var extraContainer2 = extraContainer.next("tr");
        if(extraContainer.css("display") == "none") {
            extraContainer.show();
            extraContainer2.show();
            $(eleA).html(Lang.get('COLLECT_EDIT_ACTION_收起'));
        } else {
            extraContainer.hide();
            extraContainer2.hide();
            $(eleA).html(Lang.get('COLLECT_EDIT_ACTION_展开'));
        }
    }
}

var CalendarWidget = {
    initWidgetCopyToClipBoard : function() {
        $("#calendar_widget_copy_link").zclip({
            path:'/scripts/ZeroClipboard.swf',
            copy:function(){
                return $('#calendar_widget_code_container').text();
            },
            beforeCopy:function(){
            //$('#widget_code_container').css('background','yellow');
            },
            afterCopy:function(){
                alert(Lang.get("PAYMENT_WIDGET_复制成功"));
            }
        });
    },
    initWidgetPreview : function() {
        var text = $("#calendar_widget_code_container").html();
        var replace = text.replace(/&lt;/g, "<").replace(/&gt;/g, ">");
        $("#calendar_preview_container").css("width", "800px");
        $("#calendar_preview_container").html(replace); 
    },
    initWidgetTips : function() {
        if (document.getElementById('calendar_message_link') != null){
            $('#calendar_message_link').qtip({
                content: {
                    text: $('#calendar_message_link_contents').html(),
                    title: {
                        text: $('#calendar_message_link_title').html(),
                        button: true
                    }
                },
                position: {
                    my: 'top center', // ...at the center of the viewport
                    at: 'bottom center',
                    target: $('#calendar_message_link')
                },
                show: {
                    event: 'mouseover' // Show it on click...
                },
                hide: {
                    event: 'mouseout'
                },
                style: {
                    classes: 'qtip-shadow  qtip-rounded qtip-green'
                }
            });
        }
    },
    closeWidgetTips : function() {
        $(".bt-wrapper").hide("slow");
    }
}
//支付微件
var FundPaymentWidget = {
    init : function() {
        $("#older_radio").click(function(e) {
            FundPaymentWidget.showLoginContainer();
        })
        $("#newer_radio").click(function(e) {
            FundPaymentWidget.showPayerInputContainer();
        })
    },
    showLoginContainer : function() {
        $("#payer_login_inputs_container").show();
        $(".hidden_input_container").hide();
    }, 
    showPayerInputContainer : function() {
        $("#payer_login_inputs_container").hide();
        $(".hidden_input_container").show();
    },
    hideInputContainerControler : function() {
        $(".input_container_controler").hide();
    }, 
    loadPayerInfo : function() {
        var wrongMsgContainer = $("#payer_login_msg_container");
        var payerLoginNameEle = $("#payer_login_name");
        var payerLoginPwdEle = $("#payer_login_password");
        if(YpValid.checkFormValueNull(payerLoginNameEle)){
            YpMessage.showMessage(wrongMsgContainer, Lang.get("ACCOUNT_LOGIN_请输入邮件地址"));
            return;
        };
        if(YpValid.checkFormValueNull(payerLoginPwdEle)){
            YpMessage.showMessage(wrongMsgContainer, Lang.get("ACCOUNT_LOGIN_请输入密码"));
            return;
        };
        var loadingContainer = $("#payer_login_loading_container");
        loadingContainer.show();
        $.getJSON("/account/load_account_by_ajax", {
            email : payerLoginNameEle.val(),
            password : payerLoginPwdEle.val()
        }, function(data){
            loadingContainer.hide();
            if(data.success){
                wrongMsgContainer.hide();
                var user = eval('(' + data.singleSuccessMsg + ')');
                $("#payer_name,.first_attendee_info_container input[name$='.name']").val(user.name);
                $("#payer_mobilePhone,.first_attendee_info_container input[name$='.mobilePhone']").val(user.mobilePhone);
                $("#payer_company,.first_attendee_info_container input[name$='.company']").val(user.company);
                $("#payer_position,.first_attendee_info_container input[name$='.position']").val(user.position);
                $("#payer_email,.first_attendee_info_container input[name$='.email']").val(user.email);
                FundPaymentWidget.showPayerInputContainer();
                FundPaymentWidget.hideInputContainerControler();
            } else {
                YpMessage.showMessage(wrongMsgContainer, data.singleErrorMsg);
            }
        })
    },
    initWidgetSize : function(cid) {
        var sizeWidth = YpCookie.getCookie("WIDGET_SIZE_"+cid);
        var codeContainer = $("#widget_code_container");
        if(sizeWidth == "small") {
            $("input[name='widget_width'][value='small']").attr("checked", true);
            codeContainer.text(codeContainer.text().replace("%3Fwidth%3Dbig", "%3Fwidth%3Dsmall"));
        } else {
            $("input[name='widget_width'][value='big']").attr("checked", true);
            codeContainer.text(codeContainer.text().replace("%3Fwidth%3Dsmall", "%3Fwidth%3Dbig"));
        }
        var attendeeList = YpCookie.getCookie("ATTENDEE_LIST_"+cid);
        if("show" == attendeeList) {
            $("#widget_attendee_list").attr("checked", true);
            codeContainer.text(codeContainer.text().replace("%26attendeeList%3Dhideen", "%26attendeeList%3Dshow"));
        } else {
            $("#widget_attendee_list").attr("checked", false);
            codeContainer.text(codeContainer.text().replace("%26attendeeList%3Dshow", "%26attendeeList%3Dhidden"));
        }
        FundPaymentWidget.initWidgetPreview();
    },
    initWidgetPreview : function() {
        var text = $("#widget_code_container").html();
        if($("input[name='widget_width'][value='small']")[0].checked) {
            $("#preview_container").css("width", "570px");
        } else {
            $("#preview_container").css("width", "670px");
        }
        var replace = text.replace(/&lt;/g, "<").replace(/&gt;/g, ">");
        $("#preview_container").html(replace); 
    },
    initWidgetCopyToClipBoard : function() {
        $("#widget_copy_link").zclip({
            path:'/scripts/ZeroClipboard.swf',
            copy:function(){
                return $('#widget_code_container').text();
            },
            beforeCopy:function(){
            //$('#widget_code_container').css('background','yellow');
            },
            afterCopy:function(){
                alert(Lang.get("PAYMENT_WIDGET_复制成功"));
            }
        });
    },
    changeWidthCode : function(ele, cid) {
        var radio = $(ele);
        var codeContainer = $("#widget_code_container");
        if(radio.val() == "small") {
            codeContainer.text(codeContainer.text().replace("%3Fwidth%3Dbig", "%3Fwidth%3Dsmall"));
            YpCookie.setCookie("WIDGET_SIZE_"+cid , "small", 1);
        } else if(radio.val() == "big") {
            codeContainer.text(codeContainer.text().replace("%3Fwidth%3Dsmall", "%3Fwidth%3Dbig"));
            YpCookie.setCookie("WIDGET_SIZE_"+cid , "big", 1);
        }
        FundPaymentWidget.initWidgetPreview();
    },
    changeAttendeeListCode : function(ele, cid){
        var checkbox = $(ele);
        var codeContainer = $("#widget_code_container");
        if(checkbox.attr("checked") == "true" || checkbox.attr("checked")) {
            codeContainer.text(codeContainer.text().replace("%26attendeeList%3Dhideen", "%26attendeeList%3Dshow"));
            YpCookie.setCookie("ATTENDEE_LIST_"+cid , "show", 1);
        } else if(!checkbox.attr("checked")) {
            codeContainer.text(codeContainer.text().replace("%26attendeeList%3Dshow", "%26attendeeList%3Dhideen"));
            YpCookie.setCookie("ATTENDEE_LIST_"+cid , "hidden", 1);
        }
        FundPaymentWidget.initWidgetPreview();
    }
}
//自定义收款信息
var CollectDIY = {
    _initAddOptionDialog:false,
    
    showAddOptionDialog : function(clearData) {
        if(!CollectDIY._initAddOptionDialog){
            $('#collect_diy_dialog').dialog({
                autoOpen: false, 
                width: 600,
                show: 'fade',
                hide: 'fade',
                modal: true,
                title: Lang.get("COLLECT_DIY_DIALOG_报名信息收集")
            });   
            CollectDIY._initAddOptionDialog = true;
        }
        if(clearData != false) {
            CollectDIY.resetAddOptionDialog();
        }
        
        $('#collect_diy_dialog').dialog('open');
    },
    closeAddOptionDialog:function(){
        $('#collect_diy_dialog').dialog('close');
        CollectDIY.resetAddOptionDialog();
    },
    resetAddOptionDialog : function() {
        $('#collect_diy_question_price_all').attr("checked", true);
        $("#collect_diy_dialog_question_price_div").find("input[type='checkbox']").each(function(){
            $(this).attr("checked", true);
        });
        $("#collect_add_option_from")[0].reset();
        $("#collect_diy_wrong_msg").empty();
        $("#collect_diy_wrong_msg").hide();
        $("input[name=collect_diy_index]").val(-1);
        $("#collect_diy_consent_div").hide();
        $("#collect_diy_multi_span").hide();
        $("#collect_diy_multi_option_divs").hide();
        $("#collect_add_option_from input[name='collect_diy_multi_option_id']").remove();
        var subOptions = $(".collect_diy_multi_option_div");
        subOptions.each(function(index){
            if(index != subOptions.size() - 1) {
                $(this).remove();
            }
        });
    },
    //全选/全不选所有价钱
    toggleRelatedPrice:function(obj){
        var checked = $(obj).attr("checked");
        if(checked == 'checked' || checked || checked == 'true'){
            $("#collect_diy_dialog_question_price_div").find("input[type='checkbox']").attr("checked", checked);
        }else{
            $("#collect_diy_dialog_question_price_div").find("input[type='checkbox']").removeAttr("checked");
        }
    },
    //选中/不选中所有价格复选框
    toggleRelatedAllPriceCheckbox : function(obj) {
        var checked = $(obj).attr("checked");
        if(!checked){
            $("#collect_diy_question_price_all").attr("checked",false);
        }
    },
    addOrEditRelatedPrice:function(priceOrder,priceName) {
        var questionRelatedPriceContainer =  $("#collect_diy_dialog_question_price_div");
        var checkboxInputName = "fund_collection_question.price_order_list["+priceOrder+"]";
        var checkboxPriceJEle = questionRelatedPriceContainer.find("input[name='"+checkboxInputName+"']");
        if(checkboxPriceJEle.length > 0){
            var parentP = checkboxPriceJEle.parent("p");
            parentP.text(priceName);
            parentP.prepend(checkboxPriceJEle);
        } else {
            var allCheckboxJEle = $('#collect_diy_question_price_all');
            var checkbox = YpElement.createCheckboxInput(checkboxInputName, priceOrder);
            checkbox.attr('id','fund_collection_question_price_order_list_temp_'+priceOrder);
            if(allCheckboxJEle.attr("checked")) {
                checkbox[0].setAttribute("checked", "checked");
            }
            checkbox.click(function(){
                CollectDIY.toggleRelatedAllPriceCheckbox(checkbox[0]);
            });
            var option = $("<p></p>");
            option.text(priceName);
            option.prepend(checkbox);
            questionRelatedPriceContainer.append(option);
        }
    },
    delRelatedPrice : function(priceOrder) {
        var cquestionRelatedPriceContainers =  $("#collect_diy_dialog_question_price_div");
        var checkboxPriceJEle = cquestionRelatedPriceContainers.find("input[name$='fund_collection_question.price_order_list["+priceOrder+"]']");
        checkboxPriceJEle.parent("p").remove();
    },
    addMultiOption:function() {
        var container = $("#collect_diy_multi_option_divs");
        var lastEle = $(".collect_diy_multi_option_div").last();
        var cloneEle = lastEle.clone(true);
        cloneEle.children("input[name=collect_diy_multi_option]").val("");
        var aEle = $("<a></a>").attr("href", "javascript:void(0)").click(function(event){
            CollectDIY.delMultiOption(event)
        }).html(Lang.get("GLOBAL_删除"));
        lastEle.children(".collect_diy_multi_operation").first().html(aEle);
        container.append(cloneEle);
    },
    delMultiOption:function(eve) {
        var target = $(eve.currentTarget);
        var delEle = target.parents(".collect_diy_multi_option_div");
        var updateIndex =  $("input[name=collect_diy_index]").val();
        if(updateIndex != -1) {
            //If is edit register question
            delEle.append(YpElement.createHiddenInput("collect_diy_multi_option_deleted", "true"));
            delEle.css("display","none");
        }
        else{
            //If is add new register question, do remove action
            delEle.remove();
        }
    },
    toggleAllCB: function(controlCB) {
        YpElement.toggleAllCB('payer_input_div', controlCB);
        $("input[name='payer_input_basic_required']").attr("checked", true);
        var rqDivs = $("#payer_input_diy_div .collect_diy_option");
        rqDivs.each(function(){
            var rqDiv = $(this);
            if(rqDiv.find("input[name$='.type']").val() == "AGREEMENT") {
                rqDiv.find("input[name$='.required']").attr("checked", true);
            }
        });
    }, 
    initPages: function() {
        $("input[type=radio][name=collect_diy_type]").click(function(e) {
            var target = $(e.currentTarget);
            if(target.val()=="AGREEMENT") {
                $("#collect_diy_consent_div").show();
            }
            else {
                $("#collect_diy_consent_div").hide();
            }
            if(target.val()=="MULTI") {
                $("#collect_diy_multi_span").show();
                $("select[name=collect_diy_type_multi]").val("NULL");
            } else {
                $("#collect_diy_multi_span").hide();
                $("#collect_diy_multi_option_divs").hide();
            }
        
        })
        $("select[name=collect_diy_type_multi]").click(function(e) {
            var target = $(e.currentTarget);
            if(target.val()!="NULL") {
                $("#collect_diy_multi_option_divs").show();
            }
        })
        var rqAgreementEles = $("#payer_input_diy_div input[name$=type][value='AGREEMENT']");
        if(rqAgreementEles.length > 0) {
            rqAgreementEles.first().nextAll("input[name$='.required']").click(function(event){
                event.preventDefault();
                alert(Lang.get("COLLECT_DIY_必须勾选此选项"));
            })
        } 
    
    },
    doAddOption:function(){
        //Check input data
        var wrongMsgDiv = $("#collect_diy_wrong_msg");
        //First empty msg
        YpMessage.hideMessage(wrongMsgDiv);
        //Register Question Title Element
        var optionTitleEle = $("#collect_diy_title");
        if(YpValid.checkFormValueNull(optionTitleEle)) {
            YpMessage.showMessageAndFocusEle(wrongMsgDiv, Lang.get("COLLECT_DIY_DIALOG_请输入问题标题"), optionTitleEle);
            return;
        }
        var optionTypeEles = $("input[name=collect_diy_type]:checked");
        //Register Question Type Element
        var optionTypeEle;
        //Register Question AgreementText Element
        var consentContentEle;
        //Register Question Options Array
        var mutilOptions;
        //Register Question prices
        var prices;
        if(optionTypeEles.length < 1) {
            YpMessage.showMessage(wrongMsgDiv, Lang.get("COLLECT_DIY_DIALOG_请输入答案种类"));
            return;
        } else {
            optionTypeEle = optionTypeEles.first();
            //The option type is consent, then must input the consent content
            if(optionTypeEle.val() == "AGREEMENT") {
                consentContentEle = $("#collect_diy_consent_tt");
                if(YpValid.checkFormValueNull(consentContentEle)) {
                    YpMessage.showMessageAndFocusEle(wrongMsgDiv, Lang.get("COLLECT_DIY_DIALOG_请输入同意书"), consentContentEle);
                    return;
                }
            } else if(optionTypeEle.val() == "MULTI"){
                var mutilSelectEle = $("#collect_diy_multi_span select");
                var mutilSelect = mutilSelectEle.val();
                
                if(mutilSelect=="NULL") {
                    YpMessage.showMessageAndFocusEle(wrongMsgDiv, Lang.get("COLLECT_DIY_DIALOG_请选择展现形式"), mutilSelectEle);
                    return;
                } else {
                    mutilOptions = $("#collect_diy_multi_option_divs input[name=collect_diy_multi_option]");
                    if(YpValid.checkFormArrayValueNull(mutilOptions)) {
                        YpMessage.showMessageAndFocusEle(wrongMsgDiv, Lang.get("COLLECT_DIY_DIALOG_请输入至少一个答案"));
                        return;
                    } else {
                        //Set option type element as mutilselect element
                        optionTypeEle = mutilSelectEle;
                    }
                }
            }
        }
        //check price is all unchecked
        var flag = true;
        $("#collect_diy_dialog_question_price_div").find("input[type='checkbox']").each(function(){
            if($(this).attr('checked')){
                flag = false;
            }
        });
        if(flag){
            YpMessage.showMessageAndFocusEle(wrongMsgDiv, Lang.get("COLLECT_DIY_DIALOG_请至少选择一个票价"));
            return;
        }
        //Run operation
        var insertRq = true;
        var optionsContainer = $("#payer_input_diy_div");
        var attendeeListOptionsContainer = $("#attendee_list_options_container");
        //Update data index, -1 is add new data
        var updateIndex =  $("input[name='collect_diy_index']").val();
        if(updateIndex != -1) {
            var inputPrefix = "register_question[" + updateIndex + "].";
            
            //Update data
            var options = optionsContainer.children(".collect_diy_option");
            var option = $(options.get(updateIndex));
            var eContainer = option.find("span.hidden_input_container");
            if(optionTypeEle.val() != "AGREEMENT") {
                //Set data
                option.find("span.diy_title").html(optionTitleEle.val());
                //Set request hidden data
                option.find("input[type=hidden][name$='.title']").val(optionTitleEle.val());
                option.find("input[type=hidden][name$='.type']").val(optionTypeEle.val());
                //Update AttendeeListOptionsContainer
                attendeeListOptionsContainer.find(":checkbox[name^='"+ inputPrefix +"']").next("span").html(optionTitleEle.val());
            }
            //Set price
            eContainer.find("input[type=hidden][name$='.related_price_index']").remove();
            eContainer.find("input[type=hidden][name$='.price_id']").remove();
            prices = $("#collect_diy_dialog_question_price_div").find("input[type='checkbox']");
            if(!$('#collect_diy_question_price_all').attr("checked")){
                prices.each(function(index) {
                    var priceOption = $(this);
                    if(priceOption.attr("checked")){
                        var inputOptionInputName = inputPrefix + "register_question_price_list[" + index + "].related_price_index"
                        var eOption = YpElement.createHiddenInput(inputOptionInputName, priceOption.val());
                        eOption.attr('id','price_order_list_temp_'+index);
                        eContainer.append(eOption);
                    }
                })
            }
            var rqRequiredEle = option.find("input[type=checkbox][name$='.required']");
            rqRequiredEle.unbind("click");
            if(optionTypeEle.val() == "AGREEMENT") {
                var rqAgreementEles = $("#payer_input_diy_div input[name$=type][value='AGREEMENT']");
                if(rqAgreementEles.length > 0) {
                    rqAgreementEles.first().prevAll("input[name$='.title']").val(optionTitleEle.val());
                    rqAgreementEles.first().siblings("span.diy_title").html(optionTitleEle.val());
                    rqAgreementEles.first().nextAll("input[name$='.agreement_text']").val(consentContentEle.val());
                }
                else {
                    //Set data
                    option.find("span.diy_title").html(optionTitleEle.val());
                    //Set request hidden data
                    option.find("input[type=hidden][name$='.title']").val(optionTitleEle.val());
                    option.find("input[type=hidden][name$='.type']").val(optionTypeEle.val());
                    //If the option type is consent, check the required 
                    rqRequiredEle.attr("checked",true);
                    rqRequiredEle.click(function(event){
                        event.preventDefault();
                        alert(Lang.get("COLLECT_DIY_必须勾选此选项"));
                    })
                    var agreementTextEle = option.find("input[type=hidden][name$='.agreement_text']");
                    //Check is exist or not 
                    if(agreementTextEle.length > 0) {
                        //Exist, update
                        agreementTextEle.val(consentContentEle.val());
                    } else {
                        var eAgreementText = YpElement.createHiddenInput(inputPrefix + "agreement_text", consentContentEle.val());
                        eContainer.append(eAgreementText);
                    }
                }
            
            } else if(optionTypeEle.val().indexOf("SELECTION") != -1){
                
                //The type is mutil option
                mutilOptions.each(function(index) {
                    //Dialog Element
                    var dialogRqoTitleEle = $(this);
                    var dialogRqoDeletedEle = $(this).nextAll("input[name='collect_diy_multi_option_deleted']");
                    //Page Element
                    var pageRqoTitleEle = option.find("input[type=hidden][name$='register_question_option_list[" + index + "].option_title']");
                    var pageRqoDeletedEle = option.find("input[type=hidden][name$='register_question_option_list[" + index + "].deleted']");
                    if(pageRqoTitleEle.length > 0) {
                        pageRqoTitleEle.val(dialogRqoTitleEle.val());
                        if(dialogRqoDeletedEle.length>0) {
                            if(pageRqoDeletedEle.length>0) {
                                //Database rqo
                                pageRqoDeletedEle.val(dialogRqoDeletedEle.first().val());
                            } else {
                                pageRqoTitleEle.remove();
                            }
                        } 
                    }
                    else {
                        if(dialogRqoDeletedEle.length<=0) {
                            var pageRqoInputName = inputPrefix + "register_question_option_list[" + index + "].option_title"
                            pageRqoTitleEle = YpElement.createHiddenInput(pageRqoInputName, dialogRqoTitleEle.val());
                            eContainer.append(pageRqoTitleEle);
                        }
                    }
                
                })
            }
        }
        else {
            //Add data
            var optionTemplate = $("#collect_diy_option_template").clone();
            var index = optionsContainer.children(".collect_diy_option").length;
            //Set data
            inputPrefix = "register_question[" + index + "].";
            
            optionTemplate.find("span.diy_title").html(optionTitleEle.val());
            //Get Hidden input container
            eContainer = optionTemplate.find("span.hidden_input_container");
            //Set title
            var eTitle = YpElement.createHiddenInput(inputPrefix + "title", optionTitleEle.val());
            eContainer.append(eTitle);
            //Set Type
            var eType = YpElement.createHiddenInput(inputPrefix + "type", optionTypeEle.val());
            eContainer.append(eType);
            //Set price 
            prices = $("#collect_diy_dialog_question_price_div").find("input[type='checkbox']");
            if(!$('#collect_diy_question_price_all').attr("checked")){
                prices.each(function(index) {
                    var option = $(this);
                    if(option.attr("checked")){
                        var inputOptionInputName = inputPrefix + "register_question_price_list[" + index + "].related_price_index"
                        var eOption = YpElement.createHiddenInput(inputOptionInputName, option.val());
                        eOption.attr('id','price_order_list_temp_'+index);
                        eContainer.append(eOption);
                    }
                })
            }
            //Set Required
            var requiredCheckedBox = optionTemplate.find("input[type=checkbox]").attr("name", inputPrefix + "required");
            if(optionTypeEle.val() == "AGREEMENT") {
                //Find the agreement in the page, only allow one agreement type register question
                rqAgreementEles = $("#payer_input_diy_div input[name$=type][value='AGREEMENT']");
                if(rqAgreementEles.length > 0) {
                    rqAgreementEles.first().prevAll("input[name$='.title']").val(optionTitleEle.val());
                    rqAgreementEles.first().siblings("span.diy_title").html(optionTitleEle.val());
                    rqAgreementEles.first().nextAll("input[name$='.agreement_text']").val(consentContentEle.val());
                    insertRq = false;
                } else {
                    //If the option type is consent, check the required 
                    requiredCheckedBox.attr("checked",true);
                    requiredCheckedBox.click(function(event){
                        event.preventDefault();
                        alert(Lang.get("COLLECT_DIY_必须勾选此选项"));
                    })
                    //Set consent content
                    eAgreementText = YpElement.createHiddenInput(inputPrefix + "agreement_text", consentContentEle.val());
                    eContainer.append(eAgreementText);
                }
            
            } else if(optionTypeEle.val().indexOf("SELECTION") != -1){
                //is mutil option
                mutilOptions.each(function(index) {
                    var option = $(this);
                    var inputOptionInputName = inputPrefix + "register_question_option_list[" + index + "].option_title"
                    var eOption = YpElement.createHiddenInput(inputOptionInputName, option.val());
                    eContainer.append(eOption);
                })
            }
            
            if(insertRq) {
                //Add event listener on edit and delete action
                optionTemplate.find("span.collect_diy_option_edit_span a").click(function(){
                    CollectDIY.loadOptionForEdit(index);
                });
                optionTemplate.find("span.collect_diy_option_del_span a").click(function(){
                    CollectDIY.doDelOption(index);
                });
                optionTemplate.removeAttr("id");
                optionsContainer.append(optionTemplate);
            }
            
            //Add option to the AttendeeListOptionsContainer
            if(optionTypeEle.val() != "AGREEMENT") {
                var rqShowCb = YpElement.createCheckboxInput(inputPrefix + "show_on_attendee_list", "true");
                var rqTitleSpan = $("<span></span>").html(optionTitleEle.val());
                var rqAttendeeListOption = $("<div></div>").append(rqShowCb).append(rqTitleSpan);
                attendeeListOptionsContainer.append(rqAttendeeListOption);
            }
        }
        
        CollectDIY.closeAddOptionDialog();
    },
    loadOptionForEdit : function(index) {
        //Reset dialog
        CollectDIY.resetAddOptionDialog();
        //Load basic data from current page
        var optionsContainer = $("#payer_input_diy_div");
        var options = optionsContainer.children(".collect_diy_option");
        var option = $(options.get(index));
        var rqTitle = option.find("input[type=hidden][name$='.title']").val();
        //Set basic data to dialog
        $("input[name=collect_diy_index]").val(index);
        $("#collect_diy_title").val(rqTitle);
        
        //Load and set other data form current page
        var rqType = option.find("input[type=hidden][name$='.type']").val();
        if(rqType == "AGREEMENT") {
            $("#collect_diy_type_consent").attr("checked",true);
            var agreementText = option.find("input[type=hidden][name$='.agreement_text']").val();
            $("#collect_diy_consent_tt").val(agreementText);
            //Show agreement div
            $("#collect_diy_consent_div").show();
        } else if(rqType.indexOf("SELECTION") != -1) {
            //The rq type is mutil:list/radio/checkbox
            $("#collect_diy_type_multi").attr("checked",true);
            $("select[name=collect_diy_type_multi]").val(rqType);
            var rqoTitleArray = option.find("input[type=hidden][name$='.option_title']");
            rqoTitleArray.each(function(subIndex){
                if(subIndex != 0) {
                    CollectDIY.addMultiOption();
                } 
                //Set register question option title
                $(".collect_diy_multi_option_div").last().css("display","block");
                $(".collect_diy_multi_option_div").last().children("input[name='collect_diy_multi_option']").val($(this).val());
                var rqoDelEle = $(this).nextAll("input[name$='.deleted']");
                if(rqoDelEle.length > 0) {
                    rqoDelEle = rqoDelEle.first();
                    if(rqoDelEle.val() == "true") {
                        $(".collect_diy_multi_option_div").last().append(YpElement.createHiddenInput("collect_diy_multi_option_deleted","true"));
                        $(".collect_diy_multi_option_div").last().css("display","none");
                    }
                }
            
            });
            //Show mutil option div
            $("#collect_diy_multi_span").show();

            $("#collect_diy_multi_option_divs").show();
        } else if(rqType == "TEXT_FIELD") {
            $("#collect_diy_type_text").attr("checked",true);
        } else if(rqType =="TEXT_AREA") {
            $("#collect_diy_type_textarea").attr("checked",true);
        } else if(rqType == "UPLOAD_FILE"){
            $("#collect_diy_type_uploadfile").attr("checked",true);
        }
        //Set register question price checked
        var rqpIdArray = option.find("input[type=hidden][name$='.related_price_index']");
        var rqpPriceIdArray = option.find("input[type=hidden][name$='.price_id']");
        $('#collect_diy_dialog_question_price_div').find("input[type='checkbox']").attr("checked", false);
        $('#collect_diy_question_price_all').attr("checked", false);
        var pol = $("#collect_diy_dialog_question_price_div").find("input[type='checkbox']");
        pol.each(function(){
            $(this).attr("checked", false);
        });
        var emptyFlag = 0;
        rqpIdArray.each(function(index){
            emptyFlag++;
            $('#fund_collection_question_price_order_list_'+$(this).val()).attr("checked", true);
            if($(this).attr("id") != null){
                var indexId = $(this).attr("id").substring($(this).attr("id").lastIndexOf("_")+1);
                $('#fund_collection_question_price_order_list_temp_'+indexId).attr("checked", true);
            }
        });
        rqpPriceIdArray.each(function(){
            emptyFlag++;
        });
        if(emptyFlag == 0){
            $('#collect_diy_question_price_all').attr("checked", true);
            pol.each(function(){
                $(this).attr("checked", true);
            });
        }
        //Show dialog
        CollectDIY.showAddOptionDialog(false);
    },
    doDelOption: function(index) {
        if(window.confirm(Lang.get("GLOBAL_确定删除"))) {
            //Get the del option
            var optionsContainer = $("#payer_input_diy_div");
            var options = optionsContainer.children(".collect_diy_option");
            var option = $(options.get(index));
            var eContainer = option.find("span.hidden_input_container");
            var rqId = option.find("input[type=hidden][name$='register_question[" + index + "].id']").val();
            if(rqId != undefined && rqId > 0) {
                //The option is exist in database and web page
                var rqDeletedEle = option.find("input[type=hidden][name='register_question[" + index + "].deleted']");
                if(rqDeletedEle.length>0) {
                    rqDeletedEle.val("true");
                }
                else {
                    rqDeletedEle = YpElement.createHiddenInput("register_question[" + index + "].deleted", "true");
                    eContainer.append(rqDeletedEle);
                }
                //Hide the option
                option.css("display", "none");
            } else { 
                //The option is only exist in web page
                //remove the option
                option.remove();
            }
            //Remove option in the AttendeeListOptionsContainer
            $("#attendee_list_options_container").find(":checkbox[name^='register_question[" + index + "]']").parent("div").remove();
        
        }
    }
}

var FundCollectionTicketDiy = {
    _initAddTicketPosterImageDialog : false,
    showAddTicketPosterImageDialog : function(clearData) {
        if(!FundCollectionTicketDiy._initAddTicketPosterImageDialog){
            $('#collect_ticket_diy_dialog').dialog({
                autoOpen: false, 
                width: 600,
                show: 'fade',
                hide: 'fade',
                modal: true,
                title: Lang.get("COLLECT_TICKET_DIY_DIALOG_自定义门票海报图片")
            });   
            FundCollectionTicketDiy._initAddTicketPosterImageDialog = true;
        }
        if(clearData != false) {
            FundCollectionTicketDiy.resetAddTicketPosterImageDialog();
        }
        $('#collect_ticket_diy_dialog').dialog('open');
    },
    closeAddTicketPosterImageDialog : function(){
        $('#collect_ticket_diy_dialog').dialog('close');
        FundCollectionTicketDiy.resetAddTicketPosterImageDialog();
    },
    resetAddTicketPosterImageDialog : function() {
        $('#old_file_url').val('');
        $('#old_file_name').val('');
        $('#hidden_for_del_in_ticket_input_diy_div_container').html('');
        var prices = $('#collect_ticket_diy_dialog_ticket_poster_image_div').find("input[type='checkbox']:checked");
        prices.attr("checked", false);
        document.getElementById("ticket_poster_image").outerHTML = document.getElementById("ticket_poster_image").outerHTML;
        $('#collect_ticket_poster_image_show').hide();
        $('#collect_ticket_poster_image_del').hide();
        $('#collect_ticket_poster_image_img').attr("src",Lang.get("COLLECT_TICKET_DIY_DIALOG_默认图片"));
    },
    addOrEditRelatedPrice:function(priceOrder,priceName) {
        var ticketPosterImageRelatedPriceContainer =  $("#collect_ticket_diy_dialog_ticket_poster_image_div");
        var checkboxInputName = "fund_collection_price["+priceOrder+"].ticket_poster_image";
        var checkboxPriceJEle = ticketPosterImageRelatedPriceContainer.find("input[name='"+checkboxInputName+"']");
        if(checkboxPriceJEle.length > 0){
            var parentP = checkboxPriceJEle.parent("p");
            parentP.text(priceName);
            parentP.prepend(checkboxPriceJEle);
        } else {
            var checkbox = YpElement.createCheckboxInput(checkboxInputName, priceOrder);
            var option = $("<p></p>");
            option.text(priceName);
            option.prepend(checkbox);
            ticketPosterImageRelatedPriceContainer.append(option);
        }
    },
    delRelatedPrice : function(priceOrder) {
        var cticketPosterImageRelatedPriceContainers =  $("#collect_ticket_diy_dialog_ticket_poster_image_div");
        var checkboxPriceJEle = cticketPosterImageRelatedPriceContainers.find("input[name$='fund_collection_price["+priceOrder+"].ticket_poster_image']");
        checkboxPriceJEle.parent("p").remove();
    },
    loadTicketPosterImageForEdit : function(index,url,name){
        FundCollectionTicketDiy.showAddTicketPosterImageDialog();
        //加载checkbox
        var eContainer = $('#ticket_input_diy_div_container');
        eContainer.find("input[type=hidden][name$='.ticket_poster_image_url']").each(function(eindex){
            var ticketPosterImage = $(this);
            if($.trim(ticketPosterImage.val()) == $.trim(url)){
                $('#collect_ticket_diy_dialog_ticket_poster_image_div').find("input[type=checkbox][name^='"+ticketPosterImage.attr('name').split('.')[0]+"']").attr("checked", true);
                //输出到页面,用于删除
                var inputOptionInputName = ticketPosterImage.attr('name').split('.')[0] + ".ticket_poster_image_url";
                var eOption = YpElement.createHiddenInput(inputOptionInputName, "");
                $('#hidden_for_del_in_ticket_input_diy_div_container').append(eOption);
            }
        });
        //加载文件
        $('#old_file_url').val(url);
        $('#old_file_name').val(name);
        //加载预览和删除
        $('#collect_ticket_poster_image_img').attr("src",url);
        $('#collect_ticket_poster_image_img').css("display", "");
        $('#collect_ticket_poster_image_show').css("display", "");
        $('#collect_ticket_poster_image_show').unbind("click");
        $('#collect_ticket_poster_image_show').click(function(){
            FundCollectionTicketDiy.showImage(url);
        });
        
        $('#collect_ticket_poster_image_del').css("display", "");
        $('#collect_ticket_poster_image_del').unbind("click");
        $('#collect_ticket_poster_image_del').click(function(){
            FundCollectionTicketDiy.deleteTicketPosterImage(index,url);
        });
    },
    deleteTicketPosterImage : function(index,url){
        if(window.confirm(Lang.get("GLOBAL_确定删除"))) {
            var ticketsContainer = $("#ticket_input_diy_div");
            var tickets = ticketsContainer.find("span.collect_diy_ticket");
            var ticket = $(tickets.get(index));
            var eContainer = $('#ticket_input_diy_div_container');
            eContainer.find("input[type=hidden][name$='.ticket_poster_image_url']").each(function(){
                var ticketPosterImage = $(this);
                if($.trim(ticketPosterImage.val()) == $.trim(url)){
                    eContainer.find("input[type=hidden][name^='"+ticketPosterImage.attr('name').split('.')[0]+"']").remove();
                }
            });
            ticket.remove();
            //关闭dialog
            FundCollectionTicketDiy.closeAddTicketPosterImageDialog();
            var webid = $.trim($('#fundCollection_webId').val());
            if(webid != ""){
                $.ajax({
                    url: '/collect/upload_ticket_poster_image',
                    type: 'POST',
                    data: {
                        a:'DELETE_TICKET_POSTER_IMAGE',
                        webId:webid,
                        imageUrl:url
                    },
                    dataType: 'text',
                    success: function(json){
                    }
                });
            }
        }
    },
    deleteAllTicketPosterImage : function(){
        if(window.confirm(Lang.get("GLOBAL_确定删除"))) {
            var ticketsContainer = $("#ticket_input_diy_div");
            var tickets = ticketsContainer.find("span.collect_diy_ticket");
            var eContainer = $('#ticket_input_diy_div_container');
            tickets.each(function(index){
                var ticket = $(this);
                var ticketUrl = ticket.find("input[type=hidden][name$='.ticket_poster_image_url']").val();
                var removeFlag = true;
                eContainer.find("input[type=hidden][name$='.ticket_poster_image_url']").each(function(){
                    var ticketPosterImage = $(this);
                    if(ticketPosterImage.val() == ticketUrl){
                        removeFlag = false;
                    }
                });
                if(removeFlag){
                    ticket.remove();
                }
            })
            var webid = $.trim($('#fundCollection_webId').val());
            if(webid != ""){
                $.ajax({
                    url: '/collect/upload_ticket_poster_image',
                    type: 'POST',
                    data: {
                        a:'DELETE_ALL_TICKET_POSTER_IMAGE',
                        webId:webid
                    },
                    dataType: 'text',
                    success: function(json){
                        
                    }
                });
            }
        }
    },
    doAddOrEditTicketPosterImage : function(){
        var wrongMsgDiv = $("#collect_ticket_diy_wrong_msg");
        YpMessage.hideMessage(wrongMsgDiv);
        var oldFileUrl = $('#old_file_url').val();
        if((oldFileUrl == null || $.trim(oldFileUrl) == '') && ($('#ticket_poster_image').val() == null || $('#ticket_poster_image').val() == "")){
            YpMessage.showMessage(wrongMsgDiv, Lang.get("COLLECT_TICKET_DIY_DIALOG_请上传文件"));
            return;
        }
        var pricesChecked = $('#collect_ticket_diy_dialog_ticket_poster_image_div').find("input[type='checkbox']:checked");
        if(pricesChecked.length < 1) {
            YpMessage.showMessage(wrongMsgDiv, Lang.get("COLLECT_TICKET_DIY_DIALOG_请至少选择一个票价"));
            return;
        }
        var prices = $('#collect_ticket_diy_dialog_ticket_poster_image_div').find("input[type='checkbox']");
        var returnFlag = false;
        prices.each(function(index){
            var price = $(this);
            if(price.attr("checked")){
                if($('#hidden_for_del_in_ticket_input_diy_div_container').find("input[name='fund_collection_price[" + index + "].ticket_poster_image_url']").length < 1){
                    var covers = $('#ticket_input_diy_div_container').find("input[name='fund_collection_price[" + index + "].ticket_poster_image_url']");
                    if(covers.length > 0){
                        var r = window.confirm(Lang.get("COLLECT_TICKET_DIY_DIALOG_将覆盖第x张票",(index+1)+""));
                        if(r == false){
                            returnFlag = true;
                            return;
                        } 
                    } 
                }
            }
        });
        if(returnFlag){
            return;
        }
        //删除hidden_for_del_in_ticket_input_diy_div_container中的记录
        $('#hidden_for_del_in_ticket_input_diy_div_container').find("input[type='hidden']").each(function(index){
            $('#ticket_input_diy_div_container').find("input[name^='"+$(this).attr("name").split('.')[0]+"']").remove();
        });
        if((oldFileUrl == null || $.trim(oldFileUrl) == '') || !($('#ticket_poster_image').val() == null || $('#ticket_poster_image').val() == "")){
            $('#collect_add_ticket_poster_image_from').submit(); 
        }
        else{
            var prices = $('#collect_ticket_diy_dialog_ticket_poster_image_div').find("input[type='checkbox']");
            prices.each(function(index){
                var price = $(this);
                if(price.attr("checked")){
                    $('#ticket_input_diy_div_container').find("input[name^='fund_collection_price[" + index + "].']").remove();
                    var inputOptionInputName1 = "fund_collection_price[" + index + "].ticket_poster_image_url"
                    var eOption1 = YpElement.createHiddenInput(inputOptionInputName1, oldFileUrl);
                    $('#ticket_input_diy_div_container').append(eOption1);
                    var inputOptionInputName2 = "fund_collection_price[" + index + "].ticket_poster_image_name"
                    var eOption2 = YpElement.createHiddenInput(inputOptionInputName2, $('#old_file_name').val());
                    $('#ticket_input_diy_div_container').append(eOption2);
                }
            });
            FundCollectionTicketDiy.containInvalidTicketPosterImage();
            //关闭dialog
            FundCollectionTicketDiy.closeAddTicketPosterImageDialog();
        }
    },
    ajaxFileCallBack : function(nameAndUrl){
        nameAndUrl = $.trim(nameAndUrl)
        if(nameAndUrl == "" || nameAndUrl == null || nameAndUrl == 'null'){
            FundCollectionTicketDiy.closeAddTicketPosterImageDialog();
            return;
        }
        var fileName = nameAndUrl.split(";")[0];
        var fileUrl = nameAndUrl.split(";")[1];
        //输出url到容器
        //找不到oldFileUrl为新增加的
        var oldFileUrl = $.trim($('#old_file_url').val());
        var prices = $('#collect_ticket_diy_dialog_ticket_poster_image_div').find("input[type='checkbox']");
        prices.each(function(index){
            var price = $(this);
            if(price.attr("checked")){
                $('#ticket_input_diy_div_container').find("input[name^='fund_collection_price[" + index + "].']").remove();
                var inputOptionInputName1 = "fund_collection_price[" + index + "].ticket_poster_image_url"
                var eOption1 = YpElement.createHiddenInput(inputOptionInputName1, fileUrl);
                $('#ticket_input_diy_div_container').append(eOption1);
                var inputOptionInputName2 = "fund_collection_price[" + index + "].ticket_poster_image_name"
                var eOption2 = YpElement.createHiddenInput(inputOptionInputName2, fileName);
                $('#ticket_input_diy_div_container').append(eOption2);
            }
        });
        var eContainer = $('#ticket_input_diy_div');
        if(oldFileUrl == null || oldFileUrl == '') {
            //Add data
            var ticketPosterImageTemplate = $("#collect_diy_ticket_poster_image_template").clone();
            var index = eContainer.find("span.collect_diy_ticket").length;
            //Set data
            ticketPosterImageTemplate.find("span.diy_title").html(fileName);
            var fileUrlRecord = ticketPosterImageTemplate.find("input[type='hidden'][id='ticket_poster_image_url_-1']").val(fileUrl);
            fileUrlRecord.attr('id','ticket_poster_image_url_'+index);
            ticketPosterImageTemplate.find("input[type='hidden'][name='ticket_poster_image_url']").attr('name','fund_payment_ticket_poster_image['+index+'].ticket_poster_image_url').attr('value',fileUrl);
            ticketPosterImageTemplate.find("input[type='hidden'][name='ticket_poster_image_name']").attr('name','fund_payment_ticket_poster_image['+index+'].ticket_poster_image_name').attr('value',fileName);
            //Add event listener on show and edit and delete action
            ticketPosterImageTemplate.find("span.collect_diy_ticket_edit_span a").click(function(){
                FundCollectionTicketDiy.loadTicketPosterImageForEdit(index,fileUrl,fileName);
            });
            ticketPosterImageTemplate.removeAttr("id");
            eContainer.append(ticketPosterImageTemplate);
        }else{
            //编辑时上传了新的图片
            eContainer.find("span.collect_diy_ticket").each(function(eindex){
                if(oldFileUrl == $(this).find("input[type='hidden'][id^='ticket_poster_image_url_']").val()){
                    $(this).find("input[type='hidden'][id^='ticket_poster_image_url_']").val(fileUrl);
                    $(this).find("span.diy_title").html(fileName);
                    $(this).find("input[type='hidden'][name$='.ticket_poster_image_url']").attr("value",fileUrl);
                    $(this).find("input[type='hidden'][name$='.ticket_poster_image_name']").attr("value",fileName);
                    if($(this).find("input[type='hidden'][name$='.deleted']").length > 0){
                        $(this).find("input[type='hidden'][name$='.deleted']").attr("value","true");  
                    }
                    $(this).find("span.collect_diy_ticket_edit_span a").unbind("click");
                    $(this).find("span.collect_diy_ticket_edit_span a").click(function(){
                        FundCollectionTicketDiy.loadTicketPosterImageForEdit(eindex,fileUrl,fileName);
                    });
                    FundCollectionTicketDiy.closeAddTicketPosterImageDialog();
                    FundCollectionTicketDiy.emptyFrame("collect_ticket_poster_image_hidden_frame");
                    return;
                }
            });
        }
        FundCollectionTicketDiy.containInvalidTicketPosterImage();
        //关闭dialog
        FundCollectionTicketDiy.closeAddTicketPosterImageDialog();
        FundCollectionTicketDiy.emptyFrame("collect_ticket_poster_image_hidden_frame");
    },
    showImage : function(url){
        window.open(url);
    },
    containInvalidTicketPosterImage : function(){
        var ticketsContainer = $("#ticket_input_diy_div");
        var tickets = ticketsContainer.find("span.collect_diy_ticket");
        var eContainer = $('#ticket_input_diy_div_container');
        tickets.each(function(index){
            var ticket = $(this);
            var ticketUrl = ticket.find("input[type=hidden][name$='.ticket_poster_image_url']").val();
            var removeFlag = true;
            eContainer.find("input[type=hidden][name$='.ticket_poster_image_url']").each(function(){
                var ticketPosterImage = $(this);
                if(ticketPosterImage.val() == ticketUrl){
                    removeFlag = false;
                }
            });
        })
    },
    _initDefaultTicketPosterImageDialog : false,
    showDefaultTicketPosterImageDialog : function(clearData) {
        if(!FundCollectionTicketDiy._initDefaultTicketPosterImageDialog){
            $('#default_ticket_poster_image_dialog').dialog({
                autoOpen: false, 
                width: 600,
                show: 'fade',
                hide: 'fade',
                modal: true,
                title: Lang.get("COLLECT_TICKET_DIY_DIALOG_自定义门票海报图片")
            });   
            FundCollectionTicketDiy._initDefaultTicketPosterImageDialog = true;
        }
        if(clearData != false) {
            FundCollectionTicketDiy.resetDefaultTicketPosterImageDialog();
        }
        $('#default_ticket_poster_image_dialog').dialog('open');
    },
    closeDefaultTicketPosterImageDialog : function(){
        $('#default_ticket_poster_image_dialog').dialog('close');
        FundCollectionTicketDiy.resetDefaultTicketPosterImageDialog();
    },
    resetDefaultTicketPosterImageDialog : function() {
    },
    doSubmitDefaultTicketPosterImage:function(){
        var wrongMsgDiv = $("#collect_default_ticket_diy_wrong_msg");
        YpMessage.hideMessage(wrongMsgDiv);
        var oldFileUrl = $('#old_default_file_url').val();
        if((oldFileUrl == null || $.trim(oldFileUrl) == '') && ($('#default_ticket_poster_image').val() == null || $('#default_ticket_poster_image').val() == "")){
            YpMessage.showMessage(wrongMsgDiv, Lang.get("COLLECT_TICKET_DIY_DIALOG_请上传文件"));
            return;
        }
        if((oldFileUrl == null || $.trim(oldFileUrl) == '') || !($('#default_ticket_poster_image').val() == null || $('#default_ticket_poster_image').val() == "")){
            $('#collect_default_ticket_poster_image_from').submit(); 
        }
        else{
            FundCollectionTicketDiy.closeDefaultTicketPosterImageDialog(); 
        }
    },
    ajaxDefaultFileCallBack:function(nameAndUrl){
        nameAndUrl = $.trim(nameAndUrl)
        if(nameAndUrl == "" || nameAndUrl == null || nameAndUrl == 'null'){
            FundCollectionTicketDiy.closeDefaultTicketPosterImageDialog();
            return;
        }
        var fileName = nameAndUrl.split(";")[0];
        var fileUrl = nameAndUrl.split(";")[1];
        $('#fund_collection_default_ticket_poster_image_url').val(fileUrl);
        FundCollectionTicketDiy.closeDefaultTicketPosterImageDialog();
        FundCollectionTicketDiy.emptyFrame("collect_default_ticket_poster_image_hidden_frame");
    },
    delDefaultTicketPosterImage : function(){
        var r=confirm(Lang.get("COLLECT_EDIT_您真的要删除吗？"));
        if(r == true){
            $('#default_ticket_poster_image_img').attr("src","/images/collection/default_ticket_poster_image.png");
            $('#default_ticket_poster_image_del1').hide();
            $('#default_ticket_poster_image_del2').hide();
            $('#fund_collection_default_ticket_poster_image_url').val('');
            FundCollectionTicketDiy.closeDefaultTicketPosterImageDialog();
        }
    },
    emptyFrame : function(frameId){
        $(document.getElementById(frameId).contentWindow.document.body).html('');
    }
}

var BackgroupOperation = {
    elementShow:function(id,slefId){
        $("#"+id).css("display", "");
        $("#"+slefId).attr("href", "javascript:BackgroupOperation.elementHide('"+id+"','"+slefId+"')");
        $("#"+slefId).html($("#"+slefId).html().replace("显示", "隐藏"));
    },
    elementHide:function(id,slefId){
        $("#"+id).css("display", "none");
        $("#"+slefId).attr("href", "javascript:BackgroupOperation.elementShow('"+id+"','"+slefId+"')");
        $("#"+slefId).html($("#"+slefId).html().replace("隐藏", "显示"));
    },
    changeEmail:function(){
        var emailRegex = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,8}$/i;
        var newEmail = $.trim($("#newEmail").val());
        var email = $.trim($("#oldEmail").val());
        var validationEmail = $("#validationEmail").attr("checked");
        var id = $.trim($("#userid").val());
        if(newEmail == null || newEmail == ""){
            alert("内容不能空！");
            return flase;
        }
        if(!emailRegex.test(newEmail)){
            alert("请输入正确的邮件格式！");
            return false;
        }
        var e = true;
        if(email == newEmail){
            e = confirm("修改后的邮箱与原来的邮箱相同，您确定继续操作吗？");
            if(e==false){
                return false;
            }
        }
        var r;
        if(validationEmail == "true" || validationEmail == 'checked'){
            r = confirm("你的操作：修改邮箱,邮箱修改后需要重新验证\n修改内容："+newEmail);
            validationEmail = true;
        }
        else {
            r = confirm("你的操作：修改邮箱，邮箱修改后不需要重新验证\n修改内容："+newEmail);
            validationEmail = false;
        }
        if(r == true){
            $.getJSON("/support/user_information",{
                a:"ACCOUNT_MODIFY_EMAIL",
                newEmail:newEmail,
                validationEmail:validationEmail,
                id:id
            },function(json){
                if(json.success){
                    alert("修改成功！");
                    $('#newEmail').val('');
                    document.getElementById("userEmail").innerHTML = "<td class='white' id='userEmail'>"+json.singleSuccessMsg+"</td>";
                }else{
                    alert(json.singleErrorMsg);
                }
            })
        }
        return true;
    },
    changePasswrod:function(){
        var password = $.trim($("#newPassword").val());
        var id = $.trim($("#userid").val());
        if(password==null||password==""){
            alert("内容不能空！");
            $('#newPassword').focus();
            return flase;
        }
        if(password.length<6){
            alert("请输入至少6位的密码！");
            $('#newPassword').focus();
            return false;
        }
        var r = confirm("你的操作：修改密码\n修改内容："+password);
        if(r == true){
            $.getJSON("/support/user_information",{
                a:"ACCOUNT_MODIFY_PASSWORD",
                newPassword:password,
                id:id
            },function(json){
                if(json.success){
                    alert("修改成功！");
                    $('#newPassword').val('');
                }
                else{
                    alert("发生一个意外错误，请关闭网页重新登录尝试！");
                }
            })
        }
        return true;
    },
    changeUserRate:function(source){
        var uid = $.trim($("#userid").val());
        var startDate = $.trim($("#user_rate_start_date_by_"+source).val());
        var endDate = $.trim($("#user_rate_end_date_by_"+source).val());
        var accountRegex =  /^[0]\.+.?[0-9]*$/;
        var dateRegex =  /^[0-9]{4}\-[0-9]{2}\-[0-9]{2}$/;
        if((endDate != "" && !dateRegex.test(endDate)) || (startDate != ""  && !dateRegex.test(startDate))){
            alert("日期格式错误！");
            return;
        }
        var alipayRate = $.trim($("#user_rate_alipayRate_by_"+source).val());
        var accountBalanceRate = $.trim($("#user_rate_accountBalanceRate_by_"+source).val());
        var chinabankRate = $.trim($("#user_rate_chinabankRate_by_"+source).val());
        var bankTransferRate = $.trim($("#user_rate_bankTransferRate_by_"+source).val());
        var visaRate = $.trim($("#user_rate_visaRate_by_"+source).val());
        var mastercardRate = $.trim($("#user_rate_mastercardRate_by_"+source).val());
        var paypalRate = $.trim($("#user_rate_paypalRate_"+source).val());
        var invoiceRate = $.trim($("#user_rate_invoiceRate_"+source).val());
        var emailPromoteRate;
        var messagePromoteRate
        if(source == 'basic'){
            emailPromoteRate = $.trim($("#user_rate_email_promote_"+source).val());
            messagePromoteRate = $.trim($("#user_rate_message_promote_"+source).val());
        }
        if(alipayRate != "" && alipayRate != 1 && alipayRate != 0 && !accountRegex.test(alipayRate)){
            alert("支付宝费率格式错误！");
            return;
        }
        if(accountBalanceRate != "" && accountBalanceRate != 1 && accountBalanceRate != 0 && !accountRegex.test(accountBalanceRate)){
            alert("余额费率格式错误！");
            return;
        }
        if(chinabankRate != "" && chinabankRate != 1 && chinabankRate != 0 && !accountRegex.test(chinabankRate)){
            alert("网银费率格式错误！");
            return;
        }
        if(bankTransferRate != "" && bankTransferRate != 1 && bankTransferRate != 0 && !accountRegex.test(bankTransferRate)){
            alert("银行转帐费率格式错误！");
            return;
        }
        if(visaRate != "" && visaRate != 1 && visaRate != 0 && !accountRegex.test(visaRate)){
            alert("visa费率格式错误！");
            return;
        }
        if(mastercardRate != "" && mastercardRate != 1 && mastercardRate != 0 && !accountRegex.test(mastercardRate)){
            alert("mastercard费率格式错误！");
            return;
        }
        if(paypalRate != "" && paypalRate != 1 && paypalRate != 0 && !accountRegex.test(paypalRate)){
            alert("paypal费率格式错误！");
            return;
        }
        if(invoiceRate != "" && invoiceRate != 1 && invoiceRate != 0 && !accountRegex.test(invoiceRate)){
            alert("发票费率格式错误！");
            return;
        }
        if(source == "" || uid == ""){
            alert("数据出现异常，请刷新页面！");
            return;
        }
        var message = "你的操作：修改用户费率\n修改内容：来源="+source+" 有效期="+startDate+" - "+endDate+" 支付宝="+alipayRate+" 余额="+accountBalanceRate+" 网银="+chinabankRate+" 银行转账="+bankTransferRate+" visa="+visaRate+" mastercard="+mastercardRate+" paypal="+paypalRate+" 发票="+invoiceRate;
        if(source == 'basic'){
            message = message + " 邮件推广费率="+emailPromoteRate+" 短息推广费率="+messagePromoteRate; 
        }
        var r = confirm(message);
        if(r == true){
            $.getJSON("/support/user_information",{
                a:"MODIFY_USER_RATE",
                source:source,
                startDate:startDate,
                endDate:endDate,
                uid:uid,
                alipayRate:alipayRate,
                accountBalanceRate:accountBalanceRate,
                chinabankRate:chinabankRate,
                bankTransferRate:bankTransferRate,
                visaRate:visaRate,
                mastercardRate:mastercardRate,
                paypalRate:paypalRate,
                invoiceRate:invoiceRate,
                emailPromoteRate:emailPromoteRate,
                messagePromoteRate:messagePromoteRate
            },function(json){
                if(json.success){
                    alert("修改成功！");
                    $("#user_rate_start_date_by_"+source).val('');
                    $("#user_rate_end_date_by_"+source).val('');
                    var url = $(location).attr('href');
                    redirect("/support/user_information/"+uid+"?show="+source+"_rate");
                }
                else{
                    alert(json.singleErrorMsg);
                    alert("发生一个意外错误，请关闭网页重新登录尝试！");
                }
            })
        }
    },
    changeUserServiceStatus:function(){
        var uid = $.trim($("#userid").val());
        var startDate = $.trim($("#user_service_status_start_date").val());
        var endDate = $.trim($("#user_service_status_end_date").val());
        var type = $.trim($("#user_service_status_type").val());
        var creditCard = $.trim($("#user_service_status_credit_card").val());
        var custonTicket = $.trim($("#user_service_status_custom_ticket").val());
        var checkin = $.trim($("#user_service_status_checkin").val());
        var api = $.trim($("#user_service_status_api").val());
        var dateRegex =  /^[0-9]{4}\-[0-9]{2}\-[0-9]{2}$/;
        if(startDate != "" && !dateRegex.test(startDate)){
            alert("生效时间格式错误！");
            return;
        }
        if(endDate != "" &&!dateRegex.test(endDate)){
            alert("过期时间格式错误！");
            return;
        }
        var r = confirm("你的操作：修改用户费率\n修改内容：开始时间="+startDate+" 结束时间="+endDate+" 服务版本="+type+" 是否开通信用卡="+creditCard +" 是否开通自定义票="+custonTicket+" 是否开通API服务="+api+" 是否开启签到系统="+checkin);
        if(creditCard == 'open'){
            creditCard = true;
        }
        else if(creditCard == 'close'){
            creditCard = false;
        }else{
            creditCard = null; 
        }
        if(custonTicket == 'open'){
            custonTicket = true;
        }else if(custonTicket == 'close'){
            custonTicket = false;
        }else{
            custonTicket = null; 
        }
        if(checkin == 'open'){
            checkin = true;
        }else if(checkin == 'close'){
            checkin = false;
        }else{
            checkin = null; 
        }
        if(api == 'open'){
            api = true;
        }else if(api == 'close'){
            api = false;
        }else{
            api = null;
        }
        if(r == true){
            $.getJSON("/support/user_information",{
                a:"MODIFY_USER_SERVICE_STATUS",
                startDate:startDate,
                endDate:endDate,
                type:type,
                creditCard:creditCard,
                custonTicket:custonTicket,
                checkin:checkin,
                api:api,
                uid:uid
            },function(json){
                if(json.success){
                    alert("修改成功！");
                    $('#user_service_status_start_date').val('');
                    $('#user_service_status_end_date').val('');
                    redirect("/support/user_information/"+uid+"?show=service_status");
                }else{
                    alert("发生一个意外错误，请关闭网页重新登录尝试！");
                }
            })
        }
    }
}
var UserLogin = {
    checkLoginForm : function() {
        $("#login_msg").empty();
        var email = $.trim($("#login_email").val());
        var passwd = $.trim($("#login_passwd").val());
        var emailRegex = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,8}$/i;
        if(email == ""){
            MessageShow.showWrongMessage(Lang.get("ACCOUNT_LOGIN_请输入邮件地址"), "login_email");
            return false;
        }
        if(!emailRegex.test(email)){
            MessageShow.showWrongMessage(Lang.get("ACCOUNT_LOGIN_请输入合法的邮件地址"), "login_email");
            return false;
        }
        if(passwd == ""){
            MessageShow.showWrongMessage(Lang.get("ACCOUNT_LOGIN_请输入密码"), "login_passwd");
            return false;
        }
        MessageShow.showLoadingMessage();
        $("#login_submit_btn").attr("disabled", true);
        return true;
    },
    checkPopLoginForm : function() {
        $("#pop_login_msg").empty();
        var email = $.trim($("#pop_login_email").val());
        var passwd = $.trim($("#pop_login_passwd").val());
        var emailRegex = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,8}$/i;
        
        if(email == ""){
            MessageShow.showPopWrongMessage('#loginForm',Lang.get("ACCOUNT_LOGIN_请输入邮件地址"), "pop_login_email");
            return false;
        }
        if(!emailRegex.test(email)){
            MessageShow.showPopWrongMessage('#loginForm',Lang.get("ACCOUNT_LOGIN_请输入合法的邮件地址"), "pop_login_email");
            return false;
        }
        if(passwd == ""){
            MessageShow.showPopWrongMessage('#loginForm',Lang.get("ACCOUNT_LOGIN_请输入密码"), "pop_login_passwd");
            return false;
        }
        MessageShow.showPopLoadingMessage('#loginForm');
        $("#pop_login_submit_btn").attr("disabled", true);
        return true;
    }
}
var Calendar={
    initCalendar:function(){
        var search = $("#calendar_edit_input_email");
        $("#calendar_edit_button").click(function(){
            if($.trim(search.val()) != "" && $.trim(search.val()) != Lang.get("COLLECT_CALENDAR_TEXT_搜索灰字")){
                $("#calendar_edit_form").submit();
            }else{
                alert(Lang.get("COLLECT_CALENDAR_PROMPT_请输入搜索内容"));
            }
        });
        $("#detail_edit_check_all").click(function(){
            var checkboxAll = $("#detail_edit_check_all");
            if(checkboxAll.attr("checked") || checkboxAll.attr("checked") == "true"){
                $("input[type=checkbox][name^='user_email_']").attr('checked',true);
            }else{
                $("input[type=checkbox][name^='user_email_']").attr('checked',false);
            }
        });
        search.css("color","rgb(153, 153, 153)");
        search.val(Lang.get("COLLECT_CALENDAR_TEXT_搜索灰字"));
        search.focus(function(){
            search.css("color","");
            if(search.val() == Lang.get("COLLECT_CALENDAR_TEXT_搜索灰字")){
                search.val("");
            }
        });
        search.blur(function(){
            if($.trim(search.val()) == ""){
                search.css("color","rgb(153, 153, 153)");
                search.val(Lang.get("COLLECT_CALENDAR_TEXT_搜索灰字"));
            }
        });
    },
    deleteUserCalendar:function(email){
        $.getJSON("/calendar/edit",{
            a:"DELETE_USER_CALENDAR",
            email:email
        },function(json){
            if(json.success){
                alert(Lang.get("COLLECT_APPROVAL_OPERATION_DIALOG_操作成功"));
                redirectSelf();
            }else{
                alert(Lang.get("COLLECT_APPROVAL_OPERATION_DIALOG_操作失败"));
            }
        })
    },
    addUserCalendars:function(){
        if($("input[type=checkbox][name^='user_email_']:checked").length > 0){
            $("#calendar_edit_after_search_form").submit();
        }else{
            alert(Lang.get("COLLECT_CALENDAR_PROMPT_至少选择一个"));
        }
    }
}
var WeiBo={
    shareToSinaWB : function(fcwebid){
        var url = encodeURIComponent(document.location);
        var title = encodeURI(document.title);
        window.open("http://v.t.sina.com.cn/share/share.php?url="+url+"&title="+title+"&pic=&appkey=3434232676&ralateUid=2137814425","_blank","width=615,height=505");
        WeiBo.share('XIN_LANG',fcwebid);
    },
    shareToTengxunWB : function(fcwebid){
        var t = encodeURI(document.title);
        var url = encodeURIComponent(document.location);
        var appkey = encodeURI('');//从腾讯获得的appkey这个可以不填，如果有自己的appkey则可以显示自己的来源显示
        var pic = encodeURI('');//
        var site = '';//你的网站地址，可以留空
        window.open("http://share.v.t.qq.com/index.php?c=share&a=index&title="+t+"&url="+url+"&appkey=&site=&pic=","_blank","width=615,height=505");
        WeiBo.share('TENG_XUN',fcwebid);
    },
    shareToRenrenWB : function(fcwebid){
        var url = encodeURIComponent(document.location);
        var title = encodeURI(document.title);
        window.open("http://widget.renren.com/dialog/share?resourceUrl="+url+"&srcUrl="+url+"&title="+title+"&pic=&description=","_blank","width=615,height=505");
        WeiBo.share('REN_REN',fcwebid);
    },
    followUsWithSinaWB :function(){
        WeiBo.follow('XIN_LANG');
    },
    followUsWithTengxunWB : function(){
        WeiBo.follow('TENG_XUN');
    },
    followUsWhihRenrenWB:function(){
        WeiBo.follow('REN_REN');
    },
    share:function(shareType,fcwebid){
        $.getJSON("/public/weibo",{
            a:"SHARE_TO_WEIBO",
            shareType:shareType,
            fcwebid:fcwebid
        })
    },
    follow:function(shareType){
        $.getJSON("/public/weibo",{
            a:"FOLLOW_US",
            shareType:shareType
        })
    }
}
var IndexImgs={
    init:function(){
        var imgIndex=0;//当前被选中的图片的下标（index）
        var internalId=-1;//图片轮转的异步 id
        var lis=[];//li
        var img0={
            href:'',
            alt:'',
            src:'/images/index/index_img_22.jpg',
            head:'',
            content:'',
            showContnet:false
        };
        var img1={
            href:'https://yoopay.cn/event/macworldasia-2012?ref=hengzhi',
            alt:'',
            src:'/images/index/index_img_10.jpg',
            head:Lang.get("INDEX_IMG_HEAD_10"),
            content:Lang.get("INDEX_IMG_CONTENT_10"),
            showContent:true
        };
        var img2={
            href:'https://yoopay.cn/event/cv2012sh',
            alt:'',
            src:'/images/index/index_img_15.jpg',
            head:Lang.get("INDEX_IMG_HEAD_15"),
            content:Lang.get("INDEX_IMG_CONTENT_1"),
            showContent:true
        };
        var img3={
            href:'https://yoopay.cn/event/CEIBS-PE-2012-CN',
            alt:'',
            src:'/images/index/index_img_16.jpg',
            head:Lang.get("INDEX_IMG_HEAD_16"),
            content:Lang.get("INDEX_IMG_CONTENT_11"),
            showContent:true
        };
        var img4={
            href:'https://yoopay.cn/EVENT/92003460',
            alt:'',
            src:'/images/index/index_img_17.jpg',
            head:Lang.get("INDEX_IMG_HEAD_17"),
            content:Lang.get("INDEX_IMG_CONTENT_14"),
            showContent:true
        };
        var img5={
            href:'https://yoopay.cn/event/hcb2011dinner',
            alt:'',
            src:'/images/index/index_img_18.jpg',
            head:Lang.get("INDEX_IMG_HEAD_18"),
            content:Lang.get("INDEX_IMG_CONTENT_13"),
            showContent:true
        };
        var img6={
            href:'https://yoopay.cn/EVENT/Haiku-Jinqiao-Opening-Party',
            alt:'',
            src:'/images/index/index_img_19.jpg',
            head:Lang.get("INDEX_IMG_HEAD_19"),
            content:Lang.get("INDEX_IMG_CONTENT_6"),
            showContent:true
        };
        var img7={
            href:'https://yoopay.cn/event/97845611',
            alt:'',
            src:'/images/index/index_img_20.jpg',
            head:Lang.get("INDEX_IMG_HEAD_20"),
            content:Lang.get("INDEX_IMG_CONTENT_5"),
            showContent:true
        };
        var img8={
            href:'https://yoopay.cn/pay/mashupbasketball',
            alt:'',
            src:'/images/index/index_img_21.jpg',
            head:Lang.get("INDEX_IMG_HEAD_21"),
            content:Lang.get("INDEX_IMG_CONTENT_5"),
            showContent:true
        };
        
        //英文下显示不同图片
        if(Lang.getLanguage()=='en'){
            img0.src='/images/index/index_img_22e.jpg';
            img4.src='/images/index/index_img_17e.jpg';
        //img5.src='/images/index/index_img_13e.jpg';
        }
        //所有要显示的图片
        var imgs=[];
        //imgs.push(img0);
        imgs.push(img1);
        imgs.push(img2);
        imgs.push(img3);
        imgs.push(img4);
        imgs.push(img5);
        imgs.push(img6);
        imgs.push(img7);
        imgs.push(img8);
        
        //生成li，并添加事件处理函数
        for(var i=0;i<imgs.length;i++){
            var li=$("<li><img width='108' height='60' border='0' style='display:none' src='" + imgs[i].src+ "' alt='" + imgs[i].alt + "' /></li>");
            $('#slidenav').append(li);
            //li绑定功能
            //鼠标移入移出 //暂封
            //            li.hover(function(){
            //                $(this).children('img').show().fadeIn('fast');
            //            },
            //            function(){
            //                $(this).children('img').hide().fadeOut('fast');
            //            });
            //绑定单击事件
            li.bind('click',function(imgInfo,index){
                function change(){
                    $('#slidenav li').each(function(){
                        $(this).removeClass('active');
                    }); 
                    $(this).addClass('active');
                    IndexImgs.changeImg(imgInfo);
                    imgIndex=index;//设置当前图片index，使自动浏览时下一张图片从当前选中图片开始
                    //图片说明是否显示
                    if(imgInfo.showContent){
                        $('#index_show_img_text').show();
                    }else{
                        $('#index_show_img_text').hide();
                    }
                    //鼠标变为手型
                    if(imgInfo.href==''){
                        $("#super").css('cursor', '');
                    }
                    else{
                        $("#super").css('cursor', 'pointer');
                    }
                    //点击后重新开始计时
                    window.clearInterval(internalId);
                    internalChange();
                }
                return change;
            }(imgs[i],i));
            //使图片与li下标一一对应
            lis[i]=li;
        }
        //初始化
        $('#slidenav li:first').addClass('active');
        $("#index_show_img").attr('src',imgs[0].src);
        $('#index_show_img_head').html(imgs[0].head);
        //$('#index_show_img_content').html(imgs[0].content);
        if(!imgs[0].showContent){
            $('#index_show_img_text').hide();
        }
        if(imgs[0].href!=''){
            $("#index_show_img").click(function(){
                redirect(imgs[0].href) ;
            });
            $("#super").css('cursor', 'pointer');
        }
        else{
            $("#super").css('cursor', '');
        }
        $("#index_show_img").click(function(){
            if(imgs[0].href!=''){
                redirect(imgs[0].href) ;
            }
        });
        //图片自动切换
        var internalChange=function(){
            internalId=window.setInterval(function(){//从当前被选中图片开始滚动
                imgIndex=(imgIndex+1)%imgs.length;
                lis[imgIndex].click();
            },3000); 
        }
        //单击跳转
        $("#index_show_img_text").click(function(){
            if(imgs[imgIndex].href!=''){
                redirect(imgs[imgIndex].href);
            }
        });
        $("#index_show_img").click(function(){
            if(imgs[imgIndex].href!=''){
                redirect(imgs[imgIndex].href);
            }
        });
        internalChange();
        //鼠标移入移出
        $("#index_show_img_text").mouseover(function(){
            window.clearInterval(internalId);
        });
        $("#index_show_img").mouseover(function(){
            window.clearInterval(internalId);
        });
        //$('#slidenav li').mouseover(function(){
        //    window.clearInterval(internalId);
        //});
        $("#index_show_img_text").mouseout(function(){
            internalChange();
        });
        $("#index_show_img").mouseout(function(){
            internalChange();
        });
    },
    changeImg:function(img){
        //设置图片说明;
        $('#index_show_img_text').hide();//ie8需要这两行
        $('#index_show_img_text').show();
        
        $('#index_show_img_head').html(img.head);
        //$('#index_show_img_content').html(img.content);
        //图片渐变效果
        /*
        $("#index_show_img").stop().animate({
            opacity: '.7'
        },200);
         */
        setTimeout(function(){
            $("#index_show_img").attr('src',img.src);          
        }, 200);
        setTimeout(function(){
            $("#index_show_img").stop().animate({
                opacity: '1'
            },200);
        },200);
    }
}
var UserSignup = {
    checkSignupForm : function(){
        //clear
        var name = $.trim($("#signup_name").val());
        var email = $.trim($("#signup_email").val());
        var mobilePhone = $.trim($("#signup_mobile").val());
        var passwd = $.trim($("#signup_passwd").val());
        var passwd2 = $.trim($("#signup_passwd2").val());
        var emailRegex = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,8}$/i;
        var mobileRegex = /^((\+86)|(86))?(1)\d{10}$/i;
        
        if(name == ""){
            MessageShow.showWrongMessage(Lang.get("ACCOUNT_SIGNUP_请输入姓名"), 'signup_name');
            return false;
        }
        if(email == ""){
            MessageShow.showWrongMessage(Lang.get("ACCOUNT_LOGIN_请输入邮件地址"), 'signup_email');
            return false;
        }
        if(!emailRegex.test(email)){
            MessageShow.showWrongMessage(Lang.get("ACCOUNT_LOGIN_请输入合法的邮件地址"), 'signup_email');
            return false;
        }
        if(mobilePhone == ""){
            MessageShow.showWrongMessage(Lang.get("ACCOUNT_LOGIN_请输入手机号码"), 'signup_mobile');
            return false;
        }
        if(!mobileRegex.test(mobilePhone)){
            MessageShow.showWrongMessage(Lang.get("ACCOUNT_LOGIN_请输入合法的手机号码"), 'signup_mobile');
            return false;
        }
        if(passwd == ""){
            MessageShow.showWrongMessage(Lang.get("ACCOUNT_LOGIN_请输入密码"), 'signup_passwd');
            return false;
        }
        if(passwd.length < 6){
            MessageShow.showWrongMessage(Lang.get("ACCOUNT_SIGNUP_密码长度至少6位"), 'signup_passwd');
            return false;
        }     
        if(passwd2 == ""){
            MessageShow.showWrongMessage(Lang.get("ACCOUNT_SIGNUP_请输入重复密码"), 'signup_passwd2');
            return false;
        }
        if(passwd != passwd2){
            MessageShow.showWrongMessage(Lang.get("ACCOUNT_SIGNUP_两次密码输入不一致"), 'signup_passwd2');
            return false;
        }
        MessageShow.showLoadingMessage();
        $("#signup_submit_btn").attr("disabled", true);
        return true;
    },
    checkSignUpCompany:function(){
        MessageShow.hiddenNoticeMessage();
        var company=$.trim($('#company').val());
        var name=$.trim($('#name').val());
        var position=$.trim($('#position').val());
        var email=$.trim($('#email').val());
        var passwd1=$.trim($('#passwd1').val());
        var passwd2=$.trim($('#passwd2').val());
        var mobile=$.trim($('#mobile').val());
        var emailRegex = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,8}$/i;
        if(company==''){
            MessageShow.showWrongMessage(Lang.get("ACCOUNT_SIGNUP_请输入公司名称"),'company');
            return false;
        }
        if(name==''){
            MessageShow.showWrongMessage(Lang.get("ACCOUNT_SIGNUP_请输入姓名"),'name');
            return false;
        }
        if(mobile==''){
            MessageShow.showWrongMessage(Lang.get("ACCOUNT_SIGNUP_请输入手机"),'position');
            return false;
        }
        if(position==''){
            MessageShow.showWrongMessage(Lang.get("ACCOUNT_SIGNUP_请输入职位"),'position');
            return false;
        }
        if(email==''){
            MessageShow.showWrongMessage(Lang.get("ACCOUNT_LOGIN_请输入邮件地址"),'email');
            return false;
        }
        if(!emailRegex.test(email)){
            MessageShow.showWrongMessage(Lang.get("ACCOUNT_LOGIN_请输入合法的邮件地址"),'email');
            return false;
        }
        if(passwd1==''){
            MessageShow.showWrongMessage(Lang.get("ACCOUNT_LOGIN_请输入密码"),'passwd1');
            return false;
        
        }
        if(passwd2==''){
            MessageShow.showWrongMessage(Lang.get("ACCOUNT_SIGNUP_请输入重复密码"),'passwd2');
            return false;
        }
        if(passwd1!=passwd2){
            MessageShow.showWrongMessage(Lang.get("ACCOUNT_SIGNUP_两次密码输入不一致"),'passwd2');
            return false;
        }
        if(passwd1.length<6){
            $('#passwd2').val('');
            $('#passwd2').focus();
            MessageShow.showWrongMessage(Lang.get("ACCOUNT_SIGNUP_密码长度至少6位"),'passwd1');            
            return false;
        }
        MessageShow.showLoadingMessage();
        return true;
    },
    checkPopSignupForm : function(){
        $("#pop_signup_msg").empty();
        var name = $.trim($("#pop_signup_name").val());
        var email = $.trim($("#pop_signup_email").val());
        var mobile = $.trim($("#pop_signup_mobile").val());
        var passwd = $.trim($("#pop_signup_passwd").val());
        var passwd2 = $.trim($("#pop_signup_passwd2").val());
        var emailRegex = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,8}$/i;
        var mobileRegex = /^((\+86)|(86))?(1)\d{10}$/i;
        if(name == ""){
            MessageShow.showPopWrongMessage("#signupForm", Lang.get("ACCOUNT_SIGNUP_请输入姓名"),"pop_signup_name");
            return false;
        }
        if(email == ""){
            MessageShow.showPopWrongMessage("#signupForm", Lang.get("ACCOUNT_LOGIN_请输入邮件地址"),"pop_signup_email");
            return false;
        }
        if(!emailRegex.test(email)){
            MessageShow.showPopWrongMessage("#signupForm", Lang.get("ACCOUNT_LOGIN_请输入合法的邮件地址"),"pop_signup_email");
            return false;
        }
        if(mobile == ""){
            MessageShow.showPopWrongMessage("#signupForm", Lang.get("ACCOUNT_LOGIN_请输入手机号码"),"pop_signup_mobile");
            return false;
        }
        if(!mobileRegex.test(mobile)){
            MessageShow.showPopWrongMessage("#signupForm", Lang.get("ACCOUNT_LOGIN_请输入合法的手机号码"),"pop_signup_mobile");
            return false;
        }
        if(passwd == ""){
            MessageShow.showPopWrongMessage("#signupForm",Lang.get("ACCOUNT_LOGIN_请输入密码"),"pop_signup_passwd");
            return false;
        }
        if(passwd.length < 6){
            MessageShow.showPopWrongMessage("#signupForm",Lang.get("ACCOUNT_SIGNUP_密码长度至少6位"),"pop_signup_passwd");
            return false;;
        }     
        if(passwd2 == ""){
            MessageShow.showPopWrongMessage("#signupForm",Lang.get("ACCOUNT_SIGNUP_请输入重复密码"),"pop_signup_passwd2");
            return false;
        }
        if(passwd != passwd2){
            MessageShow.showPopWrongMessage("#signupForm",Lang.get("ACCOUNT_SIGNUP_两次密码输入不一致"),"pop_signup_passwd2");
            return false;
        }
        MessageShow.showPopLoadingMessage('#signupFrom');
        $("#pop_signup_submit_btn").attr("disabled", true);
        return true;
    }
}

var UserVerify = {
    sendVerifyEmail : function() {
        $("#send_verify_email_msg").css("text-align", "center");
        $("#send_verify_email_msg").html(Lang.get("GLOBAL_发送中")+"<img src=\"/images/032.gif\"/>");
        $.getJSON("/account/send_verify_email", function(json){
            if(json.success){
                $("#send_verify_email_msg").hide();
                $("#send_verify_email_success").show();
            }
            else {
                $("#send_verify_email_msg").html(json.singleErrorMsg);
            }
        })
    }
}

var UserSeal = {
    checkSealForm : function(checklogo){
        var logo = $.trim($("#seal_logo").val());
        var userName = $.trim($("#seal_name").val());
        var userEmail = $.trim($("#seal_email").val());
        var userMobile = $.trim($("#seal_mobile").val());
        var ctype = $.trim($("#seal_ctype").val());
        var cnumber = $.trim($("#seal_cnumber").val());
        var cimg = $.trim($("#seal_cimg").val());
        if(checklogo) {
            if(logo==""){
                MessageShow.showWrongMessage(Lang.get("ACCOUNT_SEAL_请上传头像"), "seal_logo");
                return false;
            }
            if(!YpValid.checkImgType(logo)){
                MessageShow.showWrongMessage(Lang.get("ACCOUNT_SEAL_请上传正确的头像格式"), "seal_logo");
                return false;
            }
        }
        if(userName==""){
            MessageShow.showWrongMessage(Lang.get("ACCOUNT_SEAL_请输入姓名"), "seal_name");
            return false;
        }
        if(userEmail==""){
            MessageShow.showWrongMessage(Lang.get("ACCOUNT_SEAL_请输入邮箱"), "seal_email");
            return false;
        }
        if(userMobile==""){
            MessageShow.showWrongMessage(Lang.get("ACCOUNT_SEAL_请输入手机号码"), "seal_mobile");
            return false;
        }
        if(ctype=="-1"){
            MessageShow.showWrongMessage(Lang.get("ACCOUNT_SEAL_请选择证件类型"), "seal_ctype");
            return false;
        }
        if(cnumber==""){
            MessageShow.showWrongMessage(Lang.get("ACCOUNT_SEAL_请输入证件号码"), "seal_cnumber");
            return false;
        }
        if(cimg==""){
            MessageShow.showWrongMessage(Lang.get("ACCOUNT_SEAL_请上传证件扫描件"), "seal_cimg");
            return false;
        }
        if(!YpValid.checkImgType(cimg)){
            MessageShow.showWrongMessage(Lang.get("ACCOUNT_SEAL_请上传正确的证件图片格式"), "seal_cimg");
            return false;
        }
        MessageShow.showLoadingMessage();
        $("#seal_submit_btn").attr("disabled", true);
        return true;
    }
}

var UserLogo = {
    initToolTips : function() {
        if (document.getElementById('upload_logo_link') != null){
            $("#upload_logo_link").bt(
            {
                trigger: ['mouseover', 'mousedown'],
                contentSelector: "$('#upload_logo_tips').html()",
                fill: '#E9F4E3',
                cssStyles: {
                    color: 'black', 
                    fontSize: '14px'
                },
                spikeLength: 15,
                spikeGirth: 10,
                padding:20,
                strokeStyle: '#6CB54A',
                strokeWidth: 2,
                cornerRadius: 5,
                width: 310
            }
            );
        }
    },
    closeToolTips : function() {
        $(".bt-wrapper").hide("slow");
    }
}
var CompanySeal = {
    checkSealForm : function(checklogo){
        var logo = $.trim($("#seal_logo").val());
        var companyName = $.trim($("#seal_name").val());
        var ctype = $.trim($("#seal_ctype").val());
        var cnumber = $.trim($("#seal_cnumber").val());
        var cimg = $.trim($("#seal_cimg").val());
        
        
        var companyWeb = $.trim($("#seal_web").val());
        var companyAddress = $.trim($("#seal_address").val());
        var companyCollectScale=$('#seal_company_collect_scale').val();
        var companyPhone = $.trim($("#seal_phone").val());
        var companyFax = $.trim($("#seal_fax").val());   
        
        if(checklogo) {
            if(logo==""){
                MessageShow.showWrongMessage(Lang.get("ACCOUNT_SEAL_请上传公司或团体logo"), "seal_logo");
                return false;
            }
            if(!YpValid.checkImgType(logo)){
                MessageShow.showWrongMessage(Lang.get("ACCOUNT_SEAL_请上传正确的logo格式"), "seal_logo");
                return false;
            }
        }
        if(companyName==""){
            MessageShow.showWrongMessage(Lang.get("ACCOUNT_SEAL_请输入公司团体名称"), "seal_name");
            return false;
        }
        if(ctype=="-1"){
            MessageShow.showWrongMessage(Lang.get("ACCOUNT_SEAL_请选择证件类型"), "seal_ctype");
            return false;
        }
        if(cnumber==""){
            MessageShow.showWrongMessage(Lang.get("ACCOUNT_SEAL_请输入证件号码"), "seal_cnumber");
            return false;
        }
        if(cimg==""){
            MessageShow.showWrongMessage(Lang.get("ACCOUNT_SEAL_请上传证件扫描件"), "seal_cimg");
            return false;
        }
        if(!YpValid.checkImgType(cimg)){
            MessageShow.showWrongMessage(Lang.get("ACCOUNT_SEAL_请上传正确的证件图片格式"), "seal_cimg");
            return false;
        }
        if(companyWeb=="" || companyWeb=="http://" || companyWeb=="https://" || (companyWeb.indexOf("http://")==-1 && companyWeb.indexOf("https://")==-1)){
            MessageShow.showWrongMessage(Lang.get("ACCOUNT_SEAL_请输入官方网址"), "seal_web");
            return false;
        }
        if(companyCollectScale=='-1'){
            MessageShow.showWrongMessage(Lang.get("ACCOUNT_SEAL_请选择预计年收款额"));
            return false;
        }
        if(companyAddress==""){
            MessageShow.showWrongMessage(Lang.get("ACCOUNT_SEAL_请输入地址"), "seal_address");
            return false;
        }        
        if(companyPhone==""){
            MessageShow.showWrongMessage(Lang.get("ACCOUNT_SEAL_请输入电话"), "seal_phone");
            return false;
        }
        if(companyFax==""){
            MessageShow.showWrongMessage(Lang.get("ACCOUNT_SEAL_请输入传真"), "seal_fax");
            return false;
        }
        MessageShow.showLoadingMessage();
        $("#seal_submit_btn").attr("disabled", true);
        return true;
    }
}
/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
var Collect={
    
    showPromoteEmailEdit:function(){
        $('#email_save_span').show();
        $('#email_edit_span').hide()
        $('#email_edit_div').show();
        $('#email_save_div').hide();
    },
    canclePromoteEmailSave:function(){
        $('#email_save_span').hide();
        $('#email_edit_span').show();
        $('#email_edit_div').hide();
        if($.trim($("#email_save_div").html())!=''){
            $('#email_save_div').show();
        }
        $('#email_content').val($('#email_save_div').html()).blur();
        $('justSave').val($('#email_content'));
    },
    savePromoteEmail:function(){
        //var fromName=$.trim($('#fromName').val());
        //var replyToEmail=$.trim($('#replyToEmail').val());
        //var emails=$.trim($('#send_email').val());
        //var subject=$.trim($('#subject').val());
        var emailContent=$.trim($('#email_content').val());
        //        if(fromName==''){
        //            MessageShow.showWrongMessage(Lang.get("COLLECT_SEND_请输入发件人姓名"),'fromName');
        //            return;  
        //        }
        //        var emailRegex = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,8}$/i;
        //        if(replyToEmail==''){
        //            MessageShow.showWrongMessage(Lang.get("COLLECT_SEND_请输入回复邮箱"),'replyToEmail');
        //            return;  
        //        }
        //        if(!emailRegex.test(replyToEmail)){
        //            MessageShow.showWrongMessage(Lang.get("COLLECT_SEND_请输入合法的邮箱地址"),'replyToEmail');
        //            return;  
        //        }
        //        if(emails==''||emails==Lang.get("COLLECT_SEND_输入邮件地址,以逗号或换行分隔")){
        //            MessageShow.showWrongMessage(Lang.get("COLLECT_SEND_请输入邮件地址"),'send_email');
        //            return;  
        //        }
        //        if(subject==''){
        //            MessageShow.showWrongMessage(Lang.get("COLLECT_SEND_请输入主题"),'subject');
        //            return;  
        //        }
        if(emailContent==''){
            MessageShow.showWrongMessage(Lang.get("COLLECT_SEND_请输入邮件内容"),'emailContent');
            return;  
        }
        
        $('#justSave').val('true');
        $.getJSON("/collect/promote",
            $('#collect_send').serialize() ,
            function(json){
                if(json.emailContent){
                    $('#email_save_div').html(json.emailContent);
                    if($.trim($("#email_save_div").html())!=''){
                        $('#email_save_div').show();
                    }
                    $('#email_edit_div').hide();
                    $('#email_save_span').hide();
                    $('#email_edit_span').show();
                } else {                       
                    alert(json.singleErrorMsg);
                }
            });
    
    
    },
    
    deactiveCollection:function(webId){
        if(!webId||webId.length<1){
            $('#deactiveCollectionDiv').show();
            $('#deactiveCollectionMessage').html(Lang.get("GLOBAL_MSG_PARAM_INVALID"));
            window.setTimeout(function(){
                $('#deactiveCollectionDiv').hide();
            },3000);
            return ;
        }
        $.getJSON("/collect/deactive_collection", {
            webId:webId
        } ,function(json){
            if(json.success){
                redirect("/collect/preview/"+webId);
            } else {
                $('#deactiveCollectionDiv').show();
                $('#deactiveCollectionMessage').html(json.singleErrorMsg);
                window.setTimeout(function(){
                    $('#deactiveCollectionDiv').hide();
                },3000);
            }
        });
    },
    activeCollection:function(webId){
        if(!webId||webId.length<1){
            $('#activeCollectionDiv').show();
            $('#activeCollectionMessage').html(Lang.get("GLOBAL_MSG_PARAM_INVALID"));
            window.setTimeout(function(){
                $('#activeCollectionDiv').hide();
            },3000);
            return ;
        }
        $.getJSON("/collect/active_collection", {
            webId:webId
        } ,function(json){
            if(json.success){
                redirect("/collect/preview/"+webId);
            } else {
                $('#activeCollectionDiv').show();
                $('#activeCollectionMessage').html(json.singleErrorMsg);
                window.setTimeout(function(){
                    $('#activeCollectionDiv').hide();
                },3000);
            }
        });
    },
    deleteCollection:function(webId){
        if(!webId||webId.length<1){
            $('#deleteCollectionDiv').show();
            $('#deleteCollectionMessage').html(Lang.get("GLOBAL_MSG_PARAM_INVALID"));
            window.setTimeout(function(){
                $('#deleteCollectionDiv').hide();
            },3000);
            return ;
        }
        $.getJSON("/collect/delete_collection", {
            webId:webId
        } ,function(json){
            if(json.success){
                redirect("/collect/list/event");
            } else {
                $('#deleteCollectionDiv').show();
                $('#deleteCollectionMessage').html(json.singleErrorMsg);
                window.setTimeout(function(){
                    $('#deleteCollectionDiv').hide();
                },3000);
            }
        });
    },
    
    setAllowPaygateTypeCantClick:function(){
        var eventFreeCheckboxs=$("#collect_edit input[name*='eventFree']");
        var isAllFree=true;
        if(eventFreeCheckboxs.length>0){
            for(var i=0;i<eventFreeCheckboxs.length;i++){
                if(!$(eventFreeCheckboxs.get(i)).attr('checked')){
                    isAllFree=false;
                    break;
                }
            }
        }
        else{
            isAllFree=false;
        }
        if(isAllFree){
            $('#eventPriceIsNotAllFreeCheckbox').hide();
            $('#eventPriceIsAllFreeCheckbox').hide();
            $('#eventPriceIsAllFreeCheckbox').show();
        }else{
            $('#eventPriceIsAllFreeCheckbox').hide();
            $('#eventPriceIsNotAllFreeCheckbox').hide();
            $('#eventPriceIsNotAllFreeCheckbox').show();
        }
    },
    addAttatch:function(){
        var index=1;
        function add(){
            var attatachName=Lang.get("COLLECT_EDIT_附件名称");
            var innerDiv=$('#collect_attatch').clone();
            innerDiv.find('#attach_add').replaceWith("<a id='attach_add' href='javascript:void(0);'>"+Lang.get("GLOBAL_删除")+"</a>");
            innerDiv.find('input').val('');
            innerDiv.find("input[name='attach0']").attr('name','attach'+index);
            innerDiv.find("input[name='attach_customed_name0']").val(attatachName).css('color','#999999').attr("name","attach_customed_name"+index);
            innerDiv.find('a').bind('click',function(){
                innerDiv.remove();
            });
            innerDiv.appendTo($('#collect_attatchs'));  
            index++;
        
        }
        return add;
    },
    
    updatePage:function(clickedLi,collectionId){
        $('#detail_edit').load("/collect/z_collect_edit",            
        {
            'collectionId':collectionId
        },
        function(response) {
            var ajaxReturn = eval($(response).find('div[title="ajaxReturn"]').text());
            if(ajaxReturn){
                Collect.changeDetail(clickedLi, 'detail_edit');
            }else{
            }
        }
        );
    },
    initPage : function() {
    
    
    },
    changeUnitAmountType : function(){
        var unitAmountType = $("#collection_inputs_div #unit_amount_type").val();
        var amountInput = $("#collection_inputs_div #collect_amount");
        if(unitAmountType == "FREEWILL") {
            amountInput.val("");
            amountInput.css("background-color", "F0F0F0");
            amountInput.attr("disabled", "disabled");
        }
        else {
            amountInput.css("background-color", "white");
            amountInput.removeAttr("disabled");
        }
    },
    showNoticeMessage:function(clazz,message){
        $('#public_message .noticeMessage').css('display','');
        if(clazz=='loadingMessage'){
            $('#public_message .'+clazz).css('display','');
        }else{
            $('#public_message .'+clazz).css('display','').html(message);
        }
    
    },
    hiddenNoticeMessage:function(){
        $('#public_message .noticeMessage').css('display','none');
        $('#public_message .successMessage').css('display','none');
        $('#public_message .wrongMessage').css('display','none');
        $('public_message .loadingMessage').css('display','none');
    },
    validateCollectEdit:function(minAmount){
        this.hiddenNoticeMessage();
        var amountType = $.trim($('#collect_edit #unit_amount_type').val());
        var type = $.trim($('#collect_edit select[name="type"]').val());
        if(amountType=='MULTIPLE'){
            Collect.validateEventCollectEdit();
            return;
        }
        
        var amount=$.trim($('#collect_edit #collect_amount').val());
        var reason=$.trim($('#collect_edit #collect_reason').val());
        
        var allowPayGateTypes = $('#collect_edit input[name="allow_paygate_type"]');
        
        var allowPayGateTypeChecked = false;
        
        var typeMsg = Lang.get("COLLECT_EDIT_收款");
        if(type == "DONATION"){
            typeMsg = Lang.get("COLLECT_EDIT_募捐");
        }
        if((amount=='' || amount==0) && amountType!="FREEWILL"){        
            this.showNoticeMessage('wrongMessage',Lang.get("COLLECT_EDIT_请输入金额"));
            return;
        }
        var numberRegex = /^\d+(\.\d+)?$/;
        if(!numberRegex.test(amount) && amountType!="FREEWILL"){
            this.showNoticeMessage('wrongMessage',Lang.get("COLLECT_EDIT_金额必须为数字"));
            return;
        }
        var decimalRegex = /^\d+(\.\d{0,2})?$/;       
        if(!decimalRegex.test(amount) && amountType!="FREEWILL"){
            this.showNoticeMessage('wrongMessage',Lang.get("COLLECT_EDIT_金额最多保留两位小数"));
            return;
        }
        if(type == "REGULAR" && numberRegex.test(minAmount) && amount<minAmount) {
            this.showNoticeMessage('wrongMessage',Lang.get("COLLECT_EDIT_金额最少为XX元", ""+minAmount));
            return;
        }
        if(reason==''){
            this.showNoticeMessage('wrongMessage',Lang.get("COLLECT_EDIT_请输入理由"));
            return;
        }
        if(!Collect.validateCollectWebId()){
            return;
        }
        if($("input[type=hidden][name=allow_paygate_type]").length == 0) {
            
            
            $.each(allowPayGateTypes, function(index, allowPayGateType) { 
                if($(allowPayGateType).attr("checked")) {
                    allowPayGateTypeChecked = true;
                }
            });
            if(!allowPayGateTypeChecked){
                this.showNoticeMessage('wrongMessage',Lang.get("COLLECT_EDIT_请选择收款方式"));
                return;
            }
        }
        var detail=$("#collect_edit textarea[name='detailDesc']").val();
        if(detail.length>1024000){
            this.showNoticeMessage('wrongMessage',Lang.get("COLLECT_EDIT_详情输入内容过大"));
            return;
        }
        this.showNoticeMessage('loadingMessage');
        $('#collect_edit').submit();
    },
    eventOnfocus:function(msg,input){
        if($.trim($(input).val())==$.trim(msg)){
            $(input).val('');
            $(input).css('color','#505050');
        }
    },
    eventOnFocusForDataPicker:function(msg,input){
        if($.trim($(input).val())==$.trim(msg)){
            $(input).val('');
        }
        $(input).css('color','#505050');
    },
    eventOnBlur:function(msg,input){
        if($.trim($(input).val())==''){
            $(input).val(msg);
            $(input).css('color','#999999');
        }
    
    },
    attatchOnBlur:function(file,msg,input){
        if($.trim($(input).val())==''){
            $(input).val(msg);
            $(input).css('color','#999999');
        }
        if($.trim($(file).val())!=''){
            $(file).next("input[type='file']").attr('name',($.trim($(file).val())));
        }
    },
    validateEventCollectSend:function(webId){
        var fromName=$.trim($('#fromName').val());
        var replyToEmail=$.trim($('#replyToEmail').val());
        var emails=$.trim($('#send_email').val());
        var subject=$.trim($('#subject').val());
        var emailContent=$.trim($('#email_content').val());
        if(fromName==''){
            MessageShow.showWrongMessage(Lang.get("COLLECT_SEND_请输入发件人姓名"),'fromName');
            return;  
        }
        var emailRegex = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,8}$/i;
        if(replyToEmail==''){
            MessageShow.showWrongMessage(Lang.get("COLLECT_SEND_请输入回复邮箱"),'replyToEmail');
            return;  
        }
        if(!emailRegex.test(replyToEmail)){
            MessageShow.showWrongMessage(Lang.get("COLLECT_SEND_请输入合法的邮箱地址"),'replyToEmail');
            return;  
        }
        if(emails==''||emails==Lang.get("COLLECT_SEND_输入邮件地址,以逗号或换行分隔")){
            MessageShow.showWrongMessage(Lang.get("COLLECT_SEND_请输入邮件地址"),'send_email');
            return;  
        }
        if(subject==''){
            MessageShow.showWrongMessage(Lang.get("COLLECT_SEND_请输入主题"),'subject');
            return;  
        }
        
        //MessageShow.showLoadingMessage();
        $('#justSave').val('');
        CollectPromote.showConfirmSend(webId,'event_email','promote_event_confirm_send');
        //$('#collect_send').submit();
        return true;
    },
    validateCollectSend:function(webId){
        var emails=$.trim($('#send_email').val());
        if(emails==''||emails==Lang.get("COLLECT_SEND_输入邮件地址,以逗号或换行分隔")){
            MessageShow.showWrongMessage(Lang.get("COLLECT_SEND_请输入邮件地址"),'send_email');
            return;  
        }
        CollectPromote.showConfirmSend(webId,'email','promote_event_confirm_send');
    //        MessageShow.showLoadingMessage();
    //        $('#collect_send').submit();
    },
    sendMoreOnfocus:function(){
        if($.trim($('#sendmore_email').val())==Lang.get("COLLECT_SEND_输入邮件地址,以逗号或换行分隔")){
            $('#sendmore_email').val('');
            $('#sendmore_email').css('color','');
        }
    },
    validateCollectSendMore:function(){
        //this.hiddenNoticeMessage();
        var emails=$.trim($('#pop_sendmore_email').val());
        if(emails==''){
            $('#need_emails').html('请输入邮件地址');
            window.setTimeout(function(){
                $('#need_emails').html('');
            },2000);
            return;
        }
        Collect.sendAgain();
    },
    sendAgain:function(){
        $.ajax({
            url: '/collect/sendmore',
            type: 'POST',
            data: $('#collect_sendmore').serialize(),
            dataType: 'text',
            error: function(xhr) {
                alert('error')
            },
            success: function(msg){
                var result=eval('('+msg+')');
                if(msg.indexOf('PostResult')>=0){
                    sendMore.close();
                    sendMore.successOpen();
                    // $('#discountWrongMsg').show();
                    $('#sendMoreSuccessMessage').html(result.singleErrorMsg);
                }else if(msg.indexOf('rawTargetInput')>=0){
                    
                    sendMore.close();
                    sendMore.successOpen();
                    $('#sendMoreSuccessMessage').html(Lang.get("COLLECT_SEND_收款链接已发出", [result.unitAmount,result.validCount+"",""+result.total]));
                }
            }
        });  
    },
    promote:function(){
        $.ajax({
            url: '/collect/sendmore',
            type: 'POST',
            data: $('#collect_send').serialize(),
            dataType: 'text',
            error: function(xhr) {
                alert('error')
            },
            success: function(msg){
                alert(msg);
                var result=eval('('+msg+')');
                if(msg.indexOf('PostResult')>=0){
                    
                }
                else if(msg.indexOf('rawTargetInput')>=0){
                    
                
                }
            }
        });  
    },
    sendEmailFocus:function(){
        if($.trim($('#send_email').val())==Lang.get("COLLECT_SEND_输入邮件地址,以逗号或换行分隔")){
            $('#send_email').val('');
            $('#send_email').attr('class', 'send_link_textarea2')  ;
            $('#send_email_button').css('display','');
        }
    },
    sendEmailCancle:function(){
        $('#send_email').val(Lang.get("COLLECT_SEND_输入邮件地址,以逗号或换行分隔"));
        $('#send_email').css('#999999');
        $('#send_email_button').css('display','none');
        $('#send_email_notice').css("display",'none');
        $('#send_email').attr('class', 'send_link_textarea');
        $('#send_email').val();
    },
    downloadOrderList:function(paidCount,webId){
        if(paidCount==null|| paidCount<1){
            $('#order_list_down_msg').html(Lang.get("GLOBAL_列表为空"));
            $('#order_list_down_msg').css('display','block');
            window.setTimeout(function(){
                $('#order_list_down_msg').html('')
            },1000 );
            return;
        }
        location.href='/collect/order_list_download/'+webId;
    },
    downloadTicketList:function(paidCount,webId){
        if(paidCount==null||paidCount<1){
            $('#ticket_list_down_msg').html(Lang.get("GLOBAL_列表为空"));
            $('#ticket_list_down_msg').css('display','');
            window.setTimeout(function(){
                $('#ticket_list_down_msg').html('')
            },1000 );
            return;
        }
        location.href='/collect/ticket_list_download/'+webId;
    },
    downloadWaitingList:function(size, webId) {
        if(size==null||size<1){
            $('#collect_waiting_download').html(Lang.get("GLOBAL_列表为空"));
            $('#collect_waiting_download').css('display','');
            window.setTimeout(function(){
                $('#collect_waiting_download').html('')
            },1000 );
            return;
        }
        location.href='/collect/waiting_download/'+webId;
    }, 
    downloadAttatch:function(attatchId){
        location.href='/collect/attatch_download/'+attatchId;
    },
    downloadInvoiceList:function(invoiceCount,webId){
        if(invoiceCount==null||invoiceCount<1){
            $('#collect_invoice_download').html(Lang.get("GLOBAL_列表为空"));
            $('#collect_invoice_download').css('display','');
            window.setTimeout(function(){
                $('#collect_invoice_download').html('')
            },1000 );
            return;
        }
        location.href='/collect/invoice_list_download/'+webId;
    },
    collectBox:function(){
        $('#collection_detail_top_div').toggle();
        $('#collection_detail_table').toggle();
        if($('#collection_detail_table').css('display')=='none'){
            $('#box_href').html(Lang.get("GLOBAL_查看详情"));
        }
        else{
            $('#box_href').html(Lang.get("GLOBAL_隐藏详情"));
        }
    },
    
    refundDialog:function(id){
        $.ajaxSetup({//ie中防止加载缓存中内容
            cache:false
        });
        $('#refundDialog').load("/collect/z_collect_refund",            
            "a=open_refund&paymentId="+id,
            function(response) {
                var ajaxReturn = eval($(response).find('div[title="ajaxReturnSuccess"]').text());
                var ajaxReturnError=$(response).find('div[title="ajaxReturnError"]').text();
                if(ajaxReturn){
                    RefundDiv.open();
                }else{
                    if($.trim(ajaxReturnError)!=''){
                        alert(ajaxReturnError);
                    }
                }
            }
            );
    },
    canclePayment:function(paymentId){
        
        RefundPaymentCancleDiv.open();
        $('#free_payment_cancle_confirm').click(function(){
            $.getJSON("/collect/cancle_payment", {
                paymentId : paymentId
            } ,function(json){
                if(json.success){
                    redirectSelf();
                } else {
                    alert(json.singleErrorMsg);
                }
            });
        });
    
    },
    refund:function(refundableAmount){
        var refundAmount=$.trim($('#refundAmount').val());
        var numberRegex = /^\d+(\.\d+)?$/;
        if(!numberRegex.test(refundAmount)){
            $('#refundMessageDiv').show();
            $('#refundMessage').html(Lang.get("COLLECT_EDIT_金额必须为数字"));
            $('#refundAmount').focus();
            return;
        }
        var decimalRegex = /^\d+(\.\d{0,2})?$/;       
        if(!decimalRegex.test(refundAmount)){
            $('#refundMessageDiv').show();
            $('#refundMessage').html(Lang.get("COLLECT_EDIT_金额最多保留两位小数"));
            $('#refundAmount').focus();
            return;
        }
        if(refundAmount==0){
            $('#refundMessageDiv').show();
            $('#refundMessage').html(Lang.get("COLLECT_EDIT_退款金额不能为零"));
            $('#refundAmount').focus();
            return;
        }
        if(refundAmount>refundableAmount){
            $('#refundMessageDiv').show();
            $('#refundMessage').html(Lang.get("COLLECT_EDIT_退款金额不能大于可退金额"));
            $('#refundAmount').focus();
            return;
        }
        
        $('#refundDialog').load("/collect/z_collect_refund",            
            $('#refund').serialize(),
            function(response) {
                var ajaxReturn = eval($(response).find('div[title="ajaxReturnSuccess"]').text());
                var ajaxReturnError=$(response).find('div[title="ajaxReturnError"]').text();
                var isRefundableAmountZero=$(response).find('div[title="isRefundableAmountZero"]').text();//是否退空
                var afterProcessingRefundableAmount=$(response).find('div[title="afterProcessingRefundableAmount"]').text();
                if(ajaxReturn){
                    RefundDiv.close();
                    RefundSuccessDiv.open();
                    //刷新收款钱数
                    $('#refundable_amount_'+$('#refund_paymentId').val()).html(afterProcessingRefundableAmount);
                    if(isRefundableAmountZero == 'true'){
                        //把退款按钮改成取消
                        $('#refund_'+$('#refund_paymentId').val()).click(function(){
                            Collect.canclePayment($('#refund_paymentId').val());
                        });
                        $('#refund_'+$('#refund_paymentId').val()).val($('#collect_detatl_button').val());
                    }
                //redirectSelf();
                }else{
                    if($.trim(ajaxReturnError)!=''){
                        RefundDiv.close();
                        alert(ajaxReturnError);
                    }
                }
            });
    },
    initCollectLinkTips : function() {
        if (document.getElementById('collect_link') != null){
            $("#collect_link").bt(
            {
                trigger: ['mouseover', 'mousedown'],
                contentSelector: "$('#collect_link_tips').html()",
                fill: '#E9F4E3',
                cssStyles: {
                    color: 'black', 
                    fontSize: '14px'
                },
                spikeLength: 15,
                spikeGirth: 10,
                padding:20,
                strokeStyle: '#6CB54A',
                strokeWidth: 2,
                cornerRadius: 5,
                width: 450
            }
            );
        }
    },
    closeCollectLinkTips : function() {
        $(".bt-wrapper").hide("slow");
    }

}  

var RefundDiv={
    _init:false,
    open:function(){
        if(!RefundDiv._init){
            $('#refundDialog').dialog({
                autoOpen: false, 
                width:540,
                modal: true,
                bgiframe:true,
                title: Lang.get("COLLECT_REFUND_退款")
            });   
            RefundDiv._init = true;
        }
        $('#refundDialog').dialog('open');
    },
    close:function(){
        $('#refundDialog').dialog('close');
    }
}
var DeactiveCollectionDialog={
    _init:false,
    open:function(){
        if(!DeactiveCollectionDialog._init){
            $('#deactiveCollectionDialog').dialog({
                autoOpen: false, 
                width:540,
                modal: true,
                bgiframe:true,
                title:''
            });   
            DeactiveCollectionDialog._init = true;
        }
        $('#deactiveCollectionDialog').dialog('open');
    },
    close:function(){
        $('#deactiveCollectionDialog').dialog('close');
    }
}
var CollectionEventUpload={
    _init:false,
    del:function(webId,eventWay,hid1,hid2){
        var r=confirm(Lang.get("COLLECT_EDIT_您真的要删除吗？"));
        if(r == true){
            $.getJSON("/collect/del_collection_event_upload",{
                webId:webId,
                eventWay:eventWay,
                random:Math.random()
            },function(json){
                if(json.success){
                    document.getElementById(hid1).style.display = 'none';//隐藏
                    document.getElementById(hid2).style.display = 'none';//隐藏
                }else{
                    alert("删除失败,请重登录尝试!");
                }
            })
        }
    }
}
var ActiveCollectionDialog={
    _init:false,
    open:function(){
        if(!ActiveCollectionDialog._init){
            $('#activeCollectionDialog').dialog({
                autoOpen: false, 
                width:540,
                modal: true,
                bgiframe:true,
                title:''
            });   
            ActiveCollectionDialog._init = true;
        }
        $('#activeCollectionDialog').dialog('open');
    },
    close:function(){
        $('#activeCollectionDialog').dialog('close');
    }
}
var DeleteCollectionDialog={
    _init:false,
    open:function(){
        if(!DeleteCollectionDialog._init){
            $('#deleteCollectionDialog').dialog({
                autoOpen: false, 
                width:540,
                modal: true,
                bgiframe:true,
                title:''
            });   
            DeleteCollectionDialog._init = true;
        }
        $('#deleteCollectionDialog').dialog('open');
    },
    close:function(){
        $('#deleteCollectionDialog').dialog('close');
    }
}
var RefundSuccessDiv={
    _init:false,
    open:function(){
        if(!RefundSuccessDiv._init){
            $('#refundSuccessDialog').dialog({
                autoOpen: false, 
                width:400,
                modal: true,
                bgiframe:true,
                title: ''
            });   
            RefundSuccessDiv._init = true;
        }
        $('#refundSuccessDialog').dialog('open');
    },
    close:function(){
        $('#refundSuccessDialog').dialog('close');
    }
}
var RefundPaymentCancleDiv={
    _init:false,
    open:function(){
        if(!RefundPaymentCancleDiv._init){
            $('#freePaymentCancleDialog').dialog({
                autoOpen: false, 
                width:400,
                modal: true,
                bgiframe:true,
                title: ''
            });   
            RefundPaymentCancleDiv._init = true;
        }
        $('#freePaymentCancleDialog').dialog('open');
    },
    close:function(){
        $('#freePaymentCancleDialog').dialog('close');
    }
}
var TicketError={
    _init:false,
    open:function(){
        if(!TicketError._init){
            $('#ticket_error').dialog({
                autoOpen: false, 
                width:540,
                modal: true,
                bgiframe:true,
                title: ''
            });   
            TicketError._init = true;
        }
        $('#ticket_error').dialog('open');
    },
    close:function(){
        $('#ticket_error').dialog('close');
    }
}
var FeedbackSuccess={
    _init:false,
    open:function(){
        if(!FeedbackSuccess._init){
            $('#sendFeedbackSuccess').dialog({
                autoOpen: false, 
                width:540,
                modal: true,
                bgiframe:true,
                title: Lang.get("ACCOUNT_FEEDBACK_给友付提建议")
            });   
            FeedbackSuccess._init = true;
        }
        $('#sendFeedbackSuccess').dialog('open');
    },
    close:function(){
        $('#sendFeedbackSuccess').dialog('close');
    }
}
var Feedback={
    _init:false,
    open:function(){
        this.hiddenMessage();
        if(!Feedback._init){
            $('#sendFeedback').dialog({
                autoOpen: false, 
                width:540,
                modal: true,
                bgiframe:true,
                title: Lang.get("ACCOUNT_FEEDBACK_给友付提建议")
            });   
            Feedback._init = true;
        }
        $('#sendFeedback').dialog('open');
    },
    close:function(){
        $('#sendFeedback').dialog('close');
    },    
    hiddenMessage:function(){
        $('#notice').css('display','none');  
        $('#wrong').css('display','none');  
        $('#success').css('display','none');  
        $('#loading').css('display','none');  
    },
    showNoticeMessage:function(clazz,message){
        $('#notice').css('display','');
        if(clazz=='loading'){
            $('#'+clazz).css('display','');
        }else{
            if(message==''){
                $('#'+clazz).css('display','');
            }else{
                $('#'+clazz).css('display','').html(message);
            }    
        }        
    },
    sendFeedback:function(){        
        Feedback.hiddenMessage();
        var subject=$.trim($('#subject').val());
        var message=$.trim($('#message').val());    
        if(subject==''){
            Feedback.showNoticeMessage('wrong',Lang.get("ACCOUNT_FEEDBACK_请输入意见或建议"));
            $('#subject').focus();
            return;
        }
        if(message==''){
            this.showNoticeMessage('wrong',Lang.get("ACCOUNT_FEEDBACK_请输入意见或建议"));
            $('#message').focus();
            return;
        }
        $('#sendFeedback').load("/account/z_feedback_dialog",            
            $('#feedback').serialize(),
            function(response) {
                var ajaxReturn = eval($(response).find('div[title="ajaxReturn"]').text());
                if(ajaxReturn){
                    Feedback.close();
                    FeedbackSuccess.open();
                }else{
                }
            }
            );
    } 
}
var viewDiscountCode={
    _init:false,
    open:function(){
        if(!viewDiscountCode._init){
            $('#viewDiscountCode').dialog({
                autoOpen: false, 
                width: 400,
                modal: true,
                title: Lang.get("COLLECT_EDIT_本活动折扣码")
            });   
            viewDiscountCode._init = true;
        }
        $('#viewDiscountCode').dialog('open');
    },
    close:function(){
        $('#viewDiscountCode').dialog('close');
    } 
}
var viewPaymentInvoice={
    _invoiceInit:false,
    openInvoice:function(){
        if(!viewPaymentInvoice._invoiceInit){
            $('#viewPaymentInvoice').dialog({
                autoOpen: false, 
                width: 540,
                modal: true,
                title: Lang.get("COLLECT_CONTACT_发票信息")
            });   
            viewPaymentInvoice._invoiceInit = true;
        }
        $('#viewPaymentInvoice').dialog('open');
    },
    closeInvoice:function(){
        $('#viewPaymentInvoice').dialog('close');
    } ,
    getInvoice:function(paymentId){   
        $('#viewPaymentInvoice').load("/collect/z_invoice/"+paymentId,            
            function(response) {
                var ajaxReturn = eval($(response).find('div[title="ajaxReturn"]').text());
                if(ajaxReturn){
                    viewPaymentInvoice.openInvoice(); 
                }else{
                    viewPaymentInvoice.openInvoice();
                }
            }
            );
    }
}
var viewPaymentDetail={
    _contactInit:false,
    openContact:function(){
        if(!viewPaymentDetail._contactInit){
            $('#viewPaymentDetail').dialog({
                autoOpen: false, 
                width: 540,
                modal: true,
                title: Lang.get("COLLECT_CONTACT_联系方式")
            });   
            viewPaymentDetail._contactInit = true;
        }
        $('#viewPaymentDetail').dialog('open');
    },
    closeContact:function(){
        $('#viewPaymentDetail').dialog('close');
    } ,
    getContact:function(paymentId){        
        $('#viewPaymentDetail').load("/collect/z_contact/"+paymentId,            
            function(response) {
                var ajaxReturn = eval($(response).find('div[title="ajaxReturn"]').text());
                if(ajaxReturn){
                    viewPaymentDetail.openContact(); 
                }else{
                    viewPaymentDetail.openContact();
                }
            }
            );
    }
}
var sendCollectNotice={
    _init:false,
    open:function(){
        if($.trim($('#no_pay_count').html())<=0){
            alert(Lang.get("COLLECT_SEND_无未付款用户"));
            return;
        }
        $('#send_notify_again_msg').hide();
        $('#send_notify_again_notice').show();
        $('#send_close').css('display','none');
        $('#sendNoticeAgainForm').css('display','none'),
        $('#sendNoticeAgainForm').css('display','');
        $('#send_close').css('display','none');
        if(!sendCollectNotice._init){
            $('#sendNoticeAgain').dialog({
                autoOpen: false, 
                width: 400,
                modal: true,
                title: ''
            });   
            sendCollectNotice._init = true;
        }
        $('#sendNoticeAgain').dialog('open');
    },
    close:function(){
        $('#sendNoticeAgain').dialog('close');
    },    
    sendNoticeAgain:function(){
        $('#send_notify_again_notice').hide();
        $('#send_notify_again_msg').html(Lang.get("GLOBAL_发送中"));
        $('#send_notify_again_msg').show();
        $('#sendNoticeAgain').load("/collect/z_send_notice_again", 
            $('#sendNoticeAgainForm').serialize(),
            function(response) {
                var ajaxReturn = eval($(response).find('div[title="ajaxReturn"]').text());
                if(ajaxReturn){
                    $('#send_notify_again_notice').hide();
                    $('#send_notify_again_msg').html(Lang.get("GLOBAL_发送成功"));
                    $('#send_notify_again_msg').show();
                    $('#sendNoticeAgainForm').css('display','none');
                    $('#send_close').css('display','');
                }else{
                    
                }
            }
            );
    } 
}
var sendMore={
    _init:false,
    open:function(){
        if(!sendMore._init){
            $('#sendMoreNotice').dialog({
                autoOpen: false, 
                width: 400,
                modal: true,
                title: '添加新付款人'
            });   
            sendMore._init = true;
        }
        $('#sendMoreNotice').dialog('open');
    },
    close:function(){
        $('#sendMoreNotice').dialog('close');
    },
    success_init:false,
    successOpen:function(){
        if(!sendMore.success_init){
            $('#sendMoreSuccess').dialog({
                autoOpen: false, 
                width: 400,
                modal: true,
                title: ''
            });   
            sendMore.success_init = true;
        }
        $('#sendMoreSuccess').dialog('open');
    },
    successClose:function(){
        $('#sendMoreSuccess').dialog('close');
    }
}
//    sendNoticeAgain:function(){
//        $('#send_notify_again_notice').hide();
//        $('#send_notify_again_msg').html(Lang.get("GLOBAL_发送中"));
//        $('#send_notify_again_msg').show();
//        $('#sendNoticeAgain').load("/collect/z_send_notice_again", 
//            $('#sendNoticeAgainForm').serialize(),
//            function(response) {
//                var ajaxReturn = eval($(response).find('div[title="ajaxReturn"]').text());
//                if(ajaxReturn){

//                    $('#send_notify_again_notice').hide();
//                    $('#send_notify_again_msg').html(Lang.get("GLOBAL_发送成功"));
//                    $('#send_notify_again_msg').show();
//                    $('#sendNoticeAgainForm').css('display','none');
//                    $('#send_close').css('display','');
//                }else{
//                    
//            }
//            }
//            );
//    } 
//}
var Withdraw={
    initToolTips : function() {
        if (document.getElementById('service_fee_a') != null){
            $("#service_fee_a").bt(
            {
                trigger: ['mouseover', 'mousedown'],
                contentSelector: "$('#upload_logo_tips').html()",
                fill: '#E9F4E3',
                cssStyles: {
                    color: 'black', 
                    fontSize: '14px'
                },
                spikeLength: 15,
                spikeGirth: 10,
                padding:20,
                strokeStyle: '#6CB54A',
                strokeWidth: 2,
                cornerRadius: 5,
                width: 310,
                positions: 'right'
            }
            );
        }
    },
    closeToolTips : function() {
        $(".bt-wrapper").hide("slow");
    },
    showWithdrawTypeByCreditCardType:function(){
        this.show();
        $('#withdraw_account_type').bind("change",this.show);
    },
    show:function(){     
        $('#bank_div').css("display","none");
        
        $('#alipay_div').css("display","none");
        $('#credit_card_div').css("display","none");
        $('#paypal_div').css('display','none');
        $('#int_bank_div').css('display','none');
        if($('#withdraw_account_type').val()=='CREDITCARD'){
            $('#credit_card_div').css("display","");
        
        }else if($('#withdraw_account_type').val()=='INT_BANK'){
            $('#int_bank_div').css("display","");
        }else if($('#withdraw_account_type').val()=='ALIPAY'){
            $('#alipay_div').css("display","");
        }else if($('#withdraw_account_type').val()=='PAYPAL'){
            $('#paypal_div').css("display","");
        }
        else{
            $('#bank_div').css("display","");
        }
    },
    validateWithdrawCreate:function(){
        $("input[class='collect_input']").parent().next('em').html('');
        MessageShow.hiddenNoticeMessage();
        var amount=$.trim($('#amount').val());
        var re = /^\d+(\.\d{0,2})?$/;        
        if(amount==''||amount==0){    
            MessageShow.showWrongMessage(Lang.get("WITHDRAW_请输入提款金额"),'amount');
            return;
        }
        var re1 = /^\d+(\.\d+)?$/;
        var notice=Lang.get("WITHDRAW_金额必须为数字");
        if(re1.test(amount)&&!re.test(amount)){
            notice=Lang.get("WITHDRAW_小数点后最多保留两位");
        }
        if(!re.test(amount)){    
            MessageShow.showWrongMessage(notice, 'amount');
            
            return;
        }        
        if($.trim($('#withdrawAccount').val())==-1){
            MessageShow.showWrongMessage(Lang.get("WITHDRAW_选择账户名称"));
            return;
        }
        MessageShow.showLoadingMessage();
        $('#withdraw_edit').submit();
    },
    validateWithdrawAccountCreate:function(){
        MessageShow.hiddenNoticeMessage();
        var name=$.trim($("input[name='name']").val());
        if(name==""||name==Lang.get("WITHDRAW_请给这个账户加个标签")){
            $("input[name='name']").focus();
            this.showSingleErrorMsg(Lang.get("WITHDRAW_请输入账户名称"));
            return ;
        }
        if($('#withdraw_account_type').val()=='CREDITCARD'){
            if(!this.validateIsEmpty('credit_card_holder_name',Lang.get("WITHDRAW_请输入您的姓名"))){
                return;
            }
            if(!this.validateIsEmpty('credit_card_bank_name',Lang.get("WITHDRAW_CREDIT_CARD_请输入开户银行名称"))){
                return;
            }
            if(!this.validateIsEmpty('credit_card_bank_branch',Lang.get("WITHDRAW_CREDIT_CARD_请输入支行名称"))){
                return;
            }
            if(!this.validateIsEmpty('credit_card_number',Lang.get("WITHDRAW_请输入卡号"))){
                return;
            }
        
        }
        else if($('#withdraw_account_type').val()=='ALIPAY'){
            if(!this.validateIsEmpty('email',Lang.get("WITHDRAW_请输入支付宝账户"))){
                return;
            }
        }
        else if($('#withdraw_account_type').val()=='PAYPAL'){
            if(!this.validateIsEmpty('paypal',Lang.get("WITHDRAW_请输入PALPAY账号"))){
                return;
            }
        }else if($('#withdraw_account_type').val()=='INT_BANK'){
            if(!this.validateIsEmpty('int_bank_user_name',Lang.get("WITHDRAW_请输入INT账户名称"))){
                return;
            }
            if(!this.validateIsEmpty('int_bank_user_address',Lang.get("WITHDRAW_请输入INT开户人地址"))){
                return;
            }
            if(!this.validateIsEmpty('int_bank_name',Lang.get("WITHDRAW_请输入INT开户行"))){
                return;
            }
            if(!this.validateIsEmpty('int_bank_account_number',Lang.get("WITHDRAW_请输入INT账户号码"))){
                return;
            }
            if(!this.validateIsEmpty('int_bank_address',Lang.get("WITHDRAW_请输入INT开户行地址"))){
                return;
            }
            if(!this.validateIsEmpty('int_bank_transit_number',Lang.get("WITHDRAW_请输入INTTransit Number"))){
                return;
            }
            if(!this.validateIsEmpty('int_bank_swift_code',Lang.get("WITHDRAW_请输入INTSWIFT code"))){
                return;
            }
        }else{
            if(!this.validateIsEmpty('bank_user_name',Lang.get("WITHDRAW_请输入您的姓名"))){
                return;
            }
            if(!this.validateIsEmpty('bank_name',Lang.get("WITHDRAW_请输入银行名称"))){
                return;
            }
            if(!this.validateIsEmpty('bank_branch',Lang.get("WITHDRAW_请输入支行名称"))){
                return;
            }
            if(!this.validateIsEmpty('bank_account_number',Lang.get("WITHDRAW_请输入银行卡号"))){
                return;
            }
        }
        MessageShow.showLoadingMessage();
        $('#withdraw_account_create').submit();
    },    
    validateIsEmpty:function(name,msg){
        var text=$.trim($("input[name='"+name+"']").val());
        if(text==""){
            $("input[name='"+name+"']").focus();
            this.showSingleErrorMsg(msg);
            return false;
        }else return true;
    },
    showSingleErrorMsg:function(msg){
        if(msg!=null){
            Collect.showNoticeMessage('wrongMessage', msg);
        }
        else{
            Collect.showNoticeMessage('wrongMessage', Lang.get("WITHDRAW_必填项目不能为空"));
        }
    
    },
    deleteWithdrawAccount:function(accountId){
        if(confirm(Lang.get("WITHDRAW_确定要删除？"))){
            location.href="/withdraw/list/"+accountId+"/delete";
        }
        else return;
    },
    jumpToPayment:function(volumeId, jumpBaseUrl){
        var volumeName = $.trim($('#rate_name_'+volumeId).html());
        redirect(jumpBaseUrl + "?volume_id="+volumeId + "&volume_name=" + encodeURI(volumeName)); 
    },
    validateWithdrawAmount:function(){
        var wrongContainer = $("#withdraw_wrong_msg_container");
        var amount = $.trim($('#amount').val());
        var re = /^\d+(\.\d{0,2})?$/;        
        if(!re.test(amount)){   
            YpMessage.showMessage(wrongContainer, Lang.get("COLLECT_EDIT_金额必须为数字"));
            return;
        }
    },
    calServiceFee:function(volumeBalance,withdrawRate,minServiceFee){
        $('#service_fee_div').hide();
        var wrongContainer = $("#withdraw_wrong_msg_container");
        var amount = $.trim($('#amount').val());
        var resultAmount = amount;
        var re = /^\d+(\.\d{0,2})?$/;        
        if(!re.test(amount)){   
            YpMessage.showMessage(wrongContainer, Lang.get("COLLECT_EDIT_金额必须为数字"));
            return;
        }
        var serviceFee = 0;
        var overVolumeBalance = 0;
        var rateAmount = amount;
        if(volumeBalance > 0){
            overVolumeBalance= amount - volumeBalance;
            if (overVolumeBalance <= 0) {
                //Use volume
                rateAmount = 0;
                minServiceFee = 0;
            } else {
                rateAmount = overVolumeBalance;
            }
        }
        serviceFee = rateAmount * withdrawRate;
        if(serviceFee < minServiceFee){
            serviceFee = minServiceFee;
        }
        serviceFee = Math.round(serviceFee*100)/100;
        resultAmount = Math.round((resultAmount - serviceFee)*100)/100;
        if(resultAmount < 0) {
            resultAmount = 0;
        }
        $('#service_fee_div').show();
        $('#service_fee').html(serviceFee);
        $('#actualAmount').html(resultAmount);
    }
}
var UserUpdate={
    validateRegInfo:function(accountType){
        MessageShow.hiddenNoticeMessage();
        $('#reginfo_name_notice').css('display', 'none');
        $('#reginfo_email_notice').css('display', 'none');
        if($.trim($('#reginfo_name').val())==''){
            MessageShow.showWrongMessage(Lang.get("ACCOUNT_REGINFO_请输入您的姓名"),'reginfo_name');
            return;
        }   
        if(accountType=='COMPANY'){
            if($.trim($('#reginfo_position').val())==''){
                MessageShow.showWrongMessage(Lang.get("ACCOUNT_REGINFO_请输入您的职位"), 'reginfo_position');
                return;
            } 
        }
        MessageShow.showLoadingMessage();
        $('#reginfo').submit();
    },
    validateModifyPassword:function(){
        MessageShow.hiddenNoticeMessage();
        if($.trim($('#password').val())==''){
            MessageShow.showWrongMessage(Lang.get("ACCOUNT_MODIFYPWD_请输入原密码"),'password');
            return;
        }
        if($.trim($('#password1').val())==''){
            MessageShow.showWrongMessage(Lang.get("ACCOUNT_MODIFYPWD_请输入新密码"),'password1');
            return;
        }
        if($.trim($('#password2').val())==''){
            MessageShow.showWrongMessage(Lang.get("ACCOUNT_MODIFYPWD_请重复新密码"),'password2');
            return;
        }
        var password1=$.trim($('#password1').val());
        var password2=$.trim($('#password2').val());
        if(password1!=password2){
            $('#password2').val('');
            MessageShow.showWrongMessage(Lang.get("ACCOUNT_MODIFYPWD_两次密码输入不一致"),'password1');
            return;
        }
        MessageShow.showLoadingMessage();
        
        $('#account_modify_password').submit();
    },
    validateSendResetPasswd:function(){
        MessageShow.hiddenNoticeMessage();
        var email=$.trim($('#email').val());
        var verifycode=$.trim($('#verifycode').val());
        if(email==''){
            MessageShow.showWrongMessage(Lang.get("ACCOUNT_RESETPWD_请输入您的注册邮箱"),'email');
            return;
        }
        if(verifycode==''){
            MessageShow.showWrongMessage(Lang.get("ACCOUNT_RESETPWD_请输入验证码"),'verifycode');
            return;
        }
        MessageShow.showLoadingMessage();
        $('#send_reset_passwd').submit();
    },
    validateResetPasswd:function(){
        MessageShow.hiddenNoticeMessage();
        var password=$.trim($('#password').val());
        var password1=$.trim($('#password1').val());
        if(password==''){
            MessageShow.showWrongMessage(Lang.get("ACCOUNT_LOGIN_请输入密码"),'password');
            return;
        }
        if(password.length<6){
            MessageShow.showWrongMessage(Lang.get("ACCOUNT_SIGNUP_密码长度至少6位"),'password');
            return;
        }
        if(password1==''){
            MessageShow.showWrongMessage(Lang.get("ACCOUNT_SIGNUP_请输入重复密码"),'password1');
            return;
        }
        if(password1!=password){
            $('#password1').val('');
            MessageShow.showWrongMessage(Lang.get("ACCOUNT_SIGNUP_两次密码输入不一致"),'password');
            return;
        }
        MessageShow.showLoadingMessage();
        $('#reset_passwd').submit();
    }
}/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
var CreditCard = {
    initExpdateDate : function() {
        var expdateMonth = $("#expdate_month")[0];
        for(var i=1;i<13;i++) {
            var option = document.createElement("option");
            var text = i;
            if(i<10){
                text = "0" + i;
            }
            $(option).text(text);
            $(option).val(text);
            $(expdateMonth).append(option);
        }
        
        var expdateYear = $("#expdate_year")[0];
        var now = new Date();
        var year = now.getFullYear();
        for(i=0;i<30;i++) {
            option = document.createElement("option");
            $(option).text(year + i);
            $(option).val(year + i);
            $(expdateYear).append(option);
        }
    }
}
var ChinaBank = {
    initClickEvent : function(){
        $("#bank_list_div a").click(function(event){
            var target = $(event.currentTarget);
            var radio = target.prev("input:radio");
            radio.attr("checked","checked");
            var value = radio.val();
            $("#pmode_id").val(value);
            $("#bank_list_div a img").removeClass();
            target = $(event.target);
            target.addClass("bank_img_red");
        });
        $("#bank_list_div input:radio").change(function(event){
            var radio = $(event.currentTarget);
            $("#pmode_id").val(radio.val());
            $("#bank_list_div a img").removeClass();
            radio.next("a").children("img").addClass("bank_img_red");
        });
    }
}
var GatewayPayment = {
    
    showCurrencyConvertTip : function(currencyType, amount){
        $('#payment_notice_div').hide();
        $('#currency_convert_tip').show();
        if(currencyType == "USD"){
            if(amount != null) {
                var tip = $("#usd_tip_template").text();
                amount = Math.round(amount*100)/100;
                tip = tip.replace(/\{1\}/, amount);
                $("#usd_tip").text(tip);
            }
            $("#usd_tip").show();
        } else {
            if(amount != null) {
                tip = $("#cny_tip_template").text();
                amount = Math.round(amount*100)/100;
                tip = tip.replace(/\{1\}/, amount);
                $("#cny_tip").text(tip);
            }
            $("#cny_tip").show();
        }
    
    },
    hideCurrencyConvertTip : function(currencyType){
        if(currencyType == "USD"){
            $("#usd_tip").hide();
        } else {
            $("#cny_tip").hide();
        }
    },
    showGatewayUSDTip : function(srcPage,USD2CNYRate){
        //var USD2CNYRate = Math.round((1/CNY2USDRate)*100)/100;
        if(srcPage == "link_transfer"){
            //友付链接付款页面
            var amount = $("#transfer_amount").val();
            if(amount == ""){
                $("#transfer_amount").focus();
                MessageShow.showWrongMessage(Lang.get("LINK_TRANSFER_PAY_请输入金额"), "transfer_amount");
            }
            else {
                this.showCurrencyConvertTip("USD", amount*USD2CNYRate);
            }
        }
        else if(srcPage == "payment" || srcPage == "add_fund" || srcPage == "yp_service" || srcPage == "api_payment"){
            amount = $("#payment_amount").val();
            if(amount == ""){
                MessageShow.showWrongMessage(Lang.get("COLLECT_EDIT_请输入金额"), "payment_amount");
            }
            else {
                this.showCurrencyConvertTip("USD", amount*USD2CNYRate);
            }
        } else {
            $("#usd_tip").show();
        }
    },
    showGatewayCNYTip : function(srcPage,CNY2USDRate){
        if(srcPage == "link_transfer"){
            //友付链接付款页面
            var amount = $("#transfer_amount").val();
            if(amount == ""){
                $("#transfer_amount").focus();
                MessageShow.showWrongMessage(Lang.get("LINK_TRANSFER_PAY_请输入金额"), "transfer_amount");
            } else {
                this.showCurrencyConvertTip("CNY", amount*CNY2USDRate);
            }
        }else if(srcPage == "payment"|| srcPage == "add_fund" || srcPage == "yp_service" || srcPage == "api_payment"){
            amount = $("#payment_amount").val();
            if(amount == ""){
                MessageShow.showWrongMessage(Lang.get("COLLECT_EDIT_请输入金额"), "payment_amount");
            } else {
                this.showCurrencyConvertTip("CNY", amount*CNY2USDRate);
            }
        } else {
            $("#cny_tip").show();
        } 
    },
    fillGatewayCNYField : function(srcPage, CNY2USDRate, currencyType, fieldId){
        var amount;
        if(srcPage == "link_transfer"){
            //友付链接付款页面
            amount = $("#transfer_amount").val();
            if(amount == ""){
                $("#transfer_amount").focus();
                MessageShow.showWrongMessage(Lang.get("LINK_TRANSFER_PAY_请输入金额"), "transfer_amount");
            } 
        }else if(srcPage == "payment" || srcPage == "add_fund" || srcPage == "yp_service" || srcPage == "api_payment"){
            amount = $("#payment_amount").val();
            if(amount == ""){
                MessageShow.showWrongMessage(Lang.get("COLLECT_EDIT_请输入金额"), "payment_amount");
            } 
        }
        //写入交易金额
        if(currencyType == "USD"){
            var cnyamount = Math.round(amount*CNY2USDRate*100)/100;
            $("#"+fieldId).text("￥"+cnyamount+"($"+amount+")");
        } else {
            $("#"+fieldId).text("￥"+amount);
        }
    
    },
    toggleBalancePayment : function() {
        var paymentAmountJEle = $("#payment_amount");
        var paymentBalanceToggleAmount = $("#payment_balance_toggle_amount");
        var paymentAmount = paymentAmountJEle.val();
        paymentAmountJEle.val(paymentBalanceToggleAmount.val());
        paymentBalanceToggleAmount.val(paymentAmount);
        $("#payment_type li.selected").trigger("click");
    
    }, 
    initBalanceSelect : function(userCNYBalance, paymentCurrencyType, paymentTotalAmount, CNY2USDRate, USD2CNYRate) {
        if(userCNYBalance != 0) {
            if(paymentCurrencyType == "CNY") {
                //币种为人民币
                if(userCNYBalance >= paymentTotalAmount) {
                    //余额充足
                    var becontainer = $("#balance_enough_container");
                    paymentTotalAmount = Math.round(paymentTotalAmount *100)/100;
                    becontainer.text(becontainer.text().replace("{0}", paymentTotalAmount));
                    becontainer.show();
                } else {
                    //余额不足
                    var blTextcontainer = $("#balance_lack_text");
                    var lackAmount = Math.round((paymentTotalAmount - userCNYBalance) *100)/100;
                    blTextcontainer.text(blTextcontainer.text().replace("{0}", userCNYBalance).replace("{1}", lackAmount));
                    $("#payment_balance_toggle_amount").val(lackAmount);
                    $("#balance_lack_container").show();
                }
            } else {
                //币种为美元，需要将其转换为人民币
                var paymentTotalCNYAmount = Math.round(paymentTotalAmount*CNY2USDRate*100)/100;
                if(userCNYBalance >= paymentTotalCNYAmount) {
                    //余额充足
                    becontainer = $("#balance_enough_container");
                    becontainer.text(becontainer.text().replace("{0}", paymentTotalCNYAmount).replace("{1}", paymentTotalAmount));
                    becontainer.show();
                } else {
                    //余额不足
                    blTextcontainer = $("#balance_lack_text");
                    var userUSDBalance = Math.round(userCNYBalance*USD2CNYRate*100)/100;
                    var lackUSDAmount = Math.round((paymentTotalAmount - userUSDBalance) *100)/100;
                    blTextcontainer.text(blTextcontainer.text().replace("{0}", userCNYBalance).replace("{1}", lackUSDAmount).replace("{2}", userUSDBalance));
                    $("#payment_balance_toggle_amount").val(lackUSDAmount);
                    $("#balance_lack_container").show();
                }
            }
        }
    },
    initGatewaySelect : function(srcPage, CNY2USDRate, USD2CNYRate, choice, userCNYBalance){
        
        //click body  hide all select options
        $('body').click(function(event){
            var uls = $('.selects ul'); 
            uls.slideUp("fast");
        });
        //add show opinion event
        $('.selects').click(function(event){
            $("#payment_msg_div").hide();
            var ul = $(this).children("ul")[0];
            if($(ul).css("display")!="none") {
                //$(ul).css("display","none");
                $(ul).slideUp("fast");
            }else {
                //$(ul).css("display","block");
                $(ul).slideDown("fast");
            }
            event.stopPropagation();
        });
        //add mouse over select option  event
        $('.selects li').mouseover(function(event){
            $('.selects li').removeClass("selected");
            var target = $(event.target);
            target.addClass("selected");
        })
        var currencyType = $("#currency_type").val();
        //add click event on select option
        $('.selects li').click(function(event){
            currencyType = $("#currency_type").val();
            $('#zhao_shang_caution').hide();//招商银行提示信息
            event.stopPropagation();
            var target = $(event.target);
            var ul = target.parent("ul").first();
            if($(ul).css("display")!="none") {
                $(ul).slideUp("fast");
            } else {
                $(ul).slideDown("fast");
            }
            var span = ul.prev('span').first();
            var inputId = span.attr("input");
            var input = $('#' + inputId);
            var optionValue = target.attr('tvalue');
            var optionHTML = target.html();
            span.html(optionHTML);
            input.val(optionValue);
            if(ul.attr("id") == "payment_type") {
                $("#cny_tip").hide();
                $("#usd_tip").hide();
                //PAYPAL信用卡支付方式
                if(optionValue=="PAYPAL_CREDITCARD_VISA" || optionValue=="PAYPAL_CREDITCARD_MASTERCARD"){
                    $("#credit_card_input_div").slideDown("fast");
                    if(currencyType=="CNY"){
                        GatewayPayment.showGatewayUSDTip(srcPage, USD2CNYRate);
                    }
                }
                else {
                    $("#credit_card_input_div").slideUp("fast");
                }
                //网银信用卡支付
                if(optionValue=="CHINABANK_CREDITCARD"){
                    if(currencyType=="USD"){
                        GatewayPayment.showGatewayCNYTip(srcPage, CNY2USDRate);
                    }
                    //chinabank_credit_span
                    $('#chinabank_credit_span').html(choice);
                    $('#chinabank_credit_card_sub').val('-1');
                    $('#chinabank_credit_select').show();                   
                }else{
                    $('#chinabank_credit_select').hide();
                }
                //银行卡支付
                if(optionValue=="CHINABANK"){
                    //检查浏览器，不是IE弹出提示框
                    if(!$.browser.msie){ 
                        GatewayPayment.chinabankTipNotIeOpen();
                    }
                    $("#bank_list_div").slideDown("fast");
                    if(currencyType=="USD"){
                        GatewayPayment.showGatewayCNYTip(srcPage, CNY2USDRate);
                    }
                } else {
                    $("#bank_list_div").slideUp("fast");
                    $("#pmode_id").val("-1");
                }
                //银行转账支付
                if(optionValue=="BANK_TRANSFER"){
                    GatewayPayment.fillGatewayCNYField(srcPage, CNY2USDRate, currencyType, "bank_transfer_amount_span");
                    $("#payment_btn").val(Lang.get("GLOBAL_BUTTON_提交"));
                    $("#china_bank_transfer").show();
                    $("#china_bank_transfer input").removeAttr("disabled");
                    $("#international_bank_transfer input").attr("disabled", true);
                    $("#international_bank_transfer").hide();
                    $("#international_bank_transfer_intro").hide();
                    $("#china_bank_transfer_intro").show();
                    $("#bank_transfer").slideDown("fast");
                } else {
                    var collectionType=$('#payment_collection_type').val();
                    if(collectionType=='EVENT'){
                        $("#payment_btn").val(Lang.get("GLOBAL_BUTTON_报名")); 
                    }else if(collectionType=='MEMBER'||collectionType=='PRODUCT'||collectionType=='SERVICE'){
                        $("#payment_btn").val(Lang.get("GLOBAL_BUTTON_订购")); 
                    }
                    if(optionValue!="INTERNATIONAL_BANK_TRANSFER"){
                        $("#bank_transfer").slideUp("fast");
                    }
                }
                //国外银行支付
                if(optionValue=="INTERNATIONAL_BANK_TRANSFER"){
                    GatewayPayment.fillGatewayCNYField(srcPage, CNY2USDRate, currencyType, "bank_transfer_amount_span");
                    $("#payment_btn").val(Lang.get("GLOBAL_BUTTON_提交"));
                    $("#international_bank_transfer input").removeAttr("disabled");
                    $("#china_bank_transfer input").attr("disabled", true);
                    $("#china_bank_transfer").hide();
                    $("#international_bank_transfer").show();
                    $("#china_bank_transfer_intro").hide();
                    $("#international_bank_transfer_intro").show();
                    
                    $("#bank_transfer").slideDown("fast");
                } else {
                    var collectionType=$('#payment_collection_type').val();
                    if(collectionType=='EVENT'){
                        $("#payment_btn").val(Lang.get("GLOBAL_BUTTON_报名")); 
                    }else if(collectionType=='MEMBER'||collectionType=='PRODUCT'||collectionType=='SERVICE'){
                        $("#payment_btn").val(Lang.get("GLOBAL_BUTTON_订购")); 
                    }
                    if(optionValue!="BANK_TRANSFER"){
                        $("#bank_transfer").slideUp("fast");
                    }
                }
                //支付宝或paypal支付
                if(optionValue=="ALIPAY" || optionValue=="PAYPAL"){
                    var defaultText = "";
                    if(optionValue=="ALIPAY"){
                        defaultText = Lang.get("PAYMENT_GATEWAY_请输入支付宝账号登录");
                        if(currencyType=="USD"){
                            GatewayPayment.showGatewayCNYTip(srcPage, CNY2USDRate);
                        }
                    }
                    else {
                        defaultText = Lang.get("PAYMENT_GATEWAY_请输入PALPAY账号登录");
                        if(currencyType=="CNY"){
                            GatewayPayment.showGatewayUSDTip(srcPage, USD2CNYRate);
                        }
                    }
                    var buyerEmailField = $("#buyer_email");
                    buyerEmailField.focus(
                        function(){
                            YpEffects.toggleFocus('buyer_email', 'focus', defaultText, '', 'black');
                        }
                        );
                    buyerEmailField.blur(
                        function(){
                            YpEffects.toggleFocus('buyer_email', 'blurs',defaultText, '','#909ea4');
                        }    
                        );
                    
                    $("#buyer_email").val(defaultText);
                    $("#buyer_email_input_div").show();
                } else {
                    $("#buyer_email_input_div").hide();
                }
            }
        })
        //init balance gatewaypayment
        var paymentTotalAmount = $("#payment_amount").val();
        if(userCNYBalance!=0 && (srcPage=="payment" || srcPage=="yp_service")) { 
            GatewayPayment.initBalanceSelect(userCNYBalance, currencyType, paymentTotalAmount, CNY2USDRate, USD2CNYRate);
        }
    
    },
    initChinaCreditCardSelect : function(){
        //click body  hide all select options
        $('body').click(function(event){
            var uls = $('#chinabank_credit_ul'); 
            uls.slideUp("fast");
        });
        //add show opinion event
        $('#chinabank_credit_select').click(function(event){
            $("#payment_msg_div").hide();
            var ul = $(this).children("ul")[0];
            if($(ul).css("display")!="none") {
                //$(ul).css("display","none");
                $(ul).slideUp("fast");
            } else {
                //$(ul).css("display","block");
                $(ul).slideDown("fast");
            }
            event.stopPropagation();
        });
        $('#chinabank_credit_ul li').mouseover(function(event){
            $('#chinabank_credit_ul li').removeClass("selected");
            var target = $(event.target);
            target.addClass("selected");
        })
        $('#chinabank_credit_ul li').click(function(event){
            
            event.stopPropagation();
            var target = $(event.target);
            var ul = target.parent("ul").first();
            if($(ul).css("display")!="none") {
                $(ul).slideUp("fast");
            } else {
                $(ul).slideDown("fast");
            }
            var span = ul.prev('span').first();
            var optionValue = target.attr('tvalue');
            $('#chinabank_credit_card_sub').val(optionValue);
            var optionHTML = target.html();
            span.html(optionHTML);
            if(optionValue=="308"){
                $('#zhao_shang_caution').show();
            }else{
                $('#zhao_shang_caution').hide();
            }
        })
    },
    checkGatewayForm : function(paymentWMsgDiv) {
        var gatewayType = $("#gateway_type").val();
        var gatewayTypeSub = $("#chinabank_credit_card_sub").val();
        //检查支付网关选择
        if(gatewayType == "-1") {
            YpMessage.showMessage(paymentWMsgDiv, Lang.get("PAYMENT_GATEWAY_请选择支付方式"));
            return false;
        } else if(gatewayType == "FREE"){
            return true;
        } else {
            if(gatewayType == "PAYPAL_CREDITCARD_VISA" || gatewayType == "PAYPAL_CREDITCARD_MASTERCARD") {
                //检查信用卡输入信息
                var cardAcct = $.trim($("#acct").val());
                var cardCvv2 = $.trim($("#cvv2").val());
                var expdateYear = $.trim($("#expdate_year").val());
                var expdateMonth = $.trim($("#expdate_month").val());
                var cardName = $.trim($("#credit_name").val());
                var cardAddr = $.trim($("#credit_addr").val());
                var cardZip = $.trim($("#credit_zip").val());
                var cardCountry = $.trim($("#credit_country").val());
                var cardCity = $.trim($("#credit_city").val());
                var cardState = $.trim($("#credit_state").val());
                if(cardAcct=="") {
                    YpMessage.showMessage(paymentWMsgDiv, Lang.get("PAYMENT_GATEWAY_请输入卡号"));
                    $("#acct").focus();
                    return false;
                }
                if(expdateYear=="-1") {
                    $("#expdate_year").focus();
                    YpMessage.showMessage(paymentWMsgDiv, Lang.get("PAYMENT_GATEWAY_请输入有效期"));
                    return false;
                }
                if(expdateMonth=="-1") {
                    $("#expdate_month").focus();
                    YpMessage.showMessage(paymentWMsgDiv, Lang.get("PAYMENT_GATEWAY_请输入有效期"));
                    return false;
                }
                if(cardCvv2=="") {
                    $("#cvv2").focus();
                    YpMessage.showMessage(paymentWMsgDiv, Lang.get("PAYMENT_GATEWAY_请输入验证码"));
                    return false;
                }
                if(cardName=="") {
                    $("#credit_name").focus();
                    YpMessage.showMessage(paymentWMsgDiv, Lang.get("PAYMENT_GATEWAY_请输入姓名"));
                    return false;
                }
                if(cardAddr=="") {
                    $("#credit_addr").focus();
                    YpMessage.showMessage(paymentWMsgDiv, Lang.get("PAYMENT_GATEWAY_请输入地址"));
                    return false;
                }
                if(cardCity=="") {
                    $("#credit_city").focus();
                    YpMessage.showMessage(paymentWMsgDiv, Lang.get("PAYMENT_GATEWAY_请输入城市"));
                    return false;
                }
                if(cardState=="") {
                    $("#credit_state").focus();
                    YpMessage.showMessage(paymentWMsgDiv, Lang.get("PAYMENT_GATEWAY_请输入州/省"));
                    return false;
                }
                if(cardCountry=="") {
                    $("#credit_country").focus();
                    YpMessage.showMessage(paymentWMsgDiv, Lang.get("PAYMENT_GATEWAY_请输入国家"));
                    return false;
                }
                if(cardZip=="") {
                    $("#credit_zip").focus();
                    YpMessage.showMessage(paymentWMsgDiv, Lang.get("PAYMENT_GATEWAY_请输入邮编"));
                    return false;
                }
            }
            else if(gatewayType == "CHINABANK") {
                //检查银行选择
                var pmodeId = $("#pmode_id").val();
                if(pmodeId == "-1") {
                    $("#pmode_id").focus(); 
                    YpMessage.showMessage(paymentWMsgDiv, Lang.get("PAYMENT_GATEWAY_请选择银行"));
                    return false;
                }
            }
            else if(gatewayType ==  "ALIPAY" || gatewayType ==  "PAYPAL"){
                var buyerEmail = $.trim($("#buyer_email").val());
                if(buyerEmail ==Lang.get("PAYMENT_GATEWAY_请输入支付宝账号登录")|| buyerEmail == Lang.get("PAYMENT_GATEWAY_请输入PALPAY账号登录")) {
                    $("#buyer_email").val("");
                }
            }
            else if(gatewayType=="CHINABANK_CREDITCARD"){
                
                if(gatewayTypeSub==-1){
                    YpMessage.showMessage(paymentWMsgDiv, Lang.get("PAYMENT_GATEWAY_请选择银行"));
                    return false;
                }
            } else if(gatewayType=="BANK_TRANSFER"){
                var bankAccountNumberField = $("input[name='bank_account_number']").first();
                var bankUserNameField = $("input[name='bank_user_name']").first();
                var bankNameField = $("input[name='bank_name']").first();
                var userPhoneField = $("input[name='user_phone']").first();
                
                var bankAccountNumber = $.trim(bankAccountNumberField.val());
                var bankUserName = $.trim(bankUserNameField.val());
                var bankName = $.trim(bankNameField.val());
                var userPhone = $.trim(userPhoneField.val());
                if(bankAccountNumber=="") {
                    bankAccountNumberField.focus();
                    YpMessage.showMessage(paymentWMsgDiv, Lang.get("PAYMENT_GATEWAY_请输入银行卡号"));
                    return false;
                }
                if(bankUserName=="") {
                    bankUserNameField.focus();
                    YpMessage.showMessage(paymentWMsgDiv, Lang.get("PAYMENT_GATEWAY_请输入银行卡持有者姓名"));
                    return false;
                }
                if(bankName=="") {
                    bankNameField.focus();
                    YpMessage.showMessage(paymentWMsgDiv, Lang.get("PAYMENT_GATEWAY_请输入银行名称"));
                    return false;
                }
                if(userPhone=="") {
                    userPhoneField.focus();
                    YpMessage.showMessage(paymentWMsgDiv, Lang.get("PAYMENT_GATEWAY_请输入联系电话"));
                    return false;
                }
            }
        }
        return true;
    
    },
    chinabankTipNotIeOpen:function(){
        $('#chinabank_tip_not_ie').dialog({
            autoOpen: false, 
            width:540,
            modal: true,
            bgiframe:true,
            title: ''
        });   
        $('#chinabank_tip_not_ie').dialog('open');
    },
    chinabankTipNotIeClose:function(){
        $('#chinabank_tip_not_ie').dialog('close');
    }
}
var ContactHostDialog={
    _init:false,
    open:function(){
        $('#contactHostMessageDiv').hide();
        if(!ContactHostDialog._init){
            $('#contactHostDialog').dialog({
                autoOpen: false, 
                width:540,
                modal: true,
                bgiframe:true,
                title: ''
            });   
            ContactHostDialog._init = true;
        }
        $('#contactHostDialog').dialog('open');
    },
    close:function(){
        $('#contactHostDialog').dialog('close');
    }
}
var ContactHostSuccessDialog={
    _init:false,
    open:function(){
        if(!ContactHostSuccessDialog._init){
            $('#contactHostSuccessDialog').dialog({
                autoOpen: false, 
                width:540,
                modal: true,
                bgiframe:true,
                title: ''
            });   
            ContactHostSuccessDialog._init = true;
        }
        $('#contactHostSuccessDialog').dialog('open');
    },
    close:function(){
        $('#contactHostSuccessDialog').dialog('close');
    }
}

var APIChargeOrder = {
    downloadInvoiceList:function(invoiceCount){
        if(invoiceCount==null || invoiceCount<1){
            $('#collect_invoice_download').html(Lang.get("GLOBAL_列表为空"));
            $('#collect_invoice_download').css('display','');
            window.setTimeout(function(){
                $('#collect_invoice_download').html('')
            },1000 );
            return;
        }
        location.href='/ypservice/api_invoice_list_download/';
    },
    initTextCopy : function() {
        $("#api_app_key_copy_link").zclip({
            path:'/scripts/ZeroClipboard.swf',
            copy:function(){
                return $('#api_app_key_copy_text').val();
            },
            beforeCopy:function(){
            },
            afterCopy:function(){
                alert(Lang.get("PAYMENT_WIDGET_复制成功"));
            }
        });
    },
    checkForm : function() {
        var paymentForm = $("#payment_form");
        var paymentWMsgDiv = $("#payment_wrong_msg_div");
        var paymentLoadDiv = $("#payment_loading_div");
        paymentWMsgDiv.hide();
        $('#currency_convert_tip').hide();
        //Check Form
        //First, reset form fields css style
        paymentForm.find("input,textarea").removeAttr("style");
        //Check gateway select
        var gatewayCheckFlag = GatewayPayment.checkGatewayForm(paymentWMsgDiv);
        if(!gatewayCheckFlag) {
            return false;
        }
        //Post data
        YpMessage.showLoadingMessage(paymentLoadDiv);
        $("#payment_btn").attr("disabled", "disabled");
        var gatewayType = $("#gateway_type").val();
        if(gatewayType == "ALIPAY" || gatewayType == "CHINABANK" || gatewayType == "PAYPAL"){
            //Show model dialog
            $("#paymentTipDialog" ).dialog({
                title:Lang.get("PAYMENT_PAY_支付"),
                resizable: false,
                height:180,
                width:350,
                modal: true,
                show: 'fade',
                hide: 'fade'
            });
            //Submit form
            return true;
        } else {
            var url = paymentForm.attr("action");
            var data = paymentForm.serialize();
            $.post(url, data, function(json){
                if(!json.success){
                    YpMessage.showMessage(paymentWMsgDiv, json.singleErrorMsg);
                } else {
                    if(json.redirectUrl != "") {
                        redirect(json.redirectUrl);
                    }
                }
                YpMessage.hideLoadingMessageOnly(paymentLoadDiv);
                $("#payment_btn").removeAttr("disabled");
            }, "json");
            return false;
        }
    },
    redirectToResult : function(hintSuccess) {
        var orderSerialId = $("input[name='order_serial_id']").val();
        $.getJSON("/paygate_api/charge_result", {
            a: "REDIRECT_RESULT", 
            hint_success: hintSuccess,
            order_serial_id: orderSerialId,
            time : new Date().getTime()
        }, function(json) {
            if(!json.success){
                alert(json.singleErrorMsg);
            } else {
                if(json.redirectUrl != "") {
                    redirect(json.redirectUrl);
                }
            }
        });
    },
    showPayGate : function(elementId,gatewayTypeVal,srcPage,CNY2USDRate,USD2CNYRate){
        $("#payment_information").css("display", "");
        $('#bank_list_div').css('display', 'none');
        $('#credit_card_input_div').css('display', 'none');
        $('#buyer_email_input_div').css('display', 'none');
        $('#bank_transfer').css('display', 'none');
        var element = $("#"+elementId);
        element.css("display", "");
        var gatewayType = $("#gateway_type");
        gatewayType.val(gatewayTypeVal);
        var currencyType = $("#currency_type").val();
        $("#cny_tip").hide();
        $("#usd_tip").hide();
        //PAYPAL信用卡支付方式
        if(gatewayTypeVal=="PAYPAL_CREDITCARD_VISA" || gatewayTypeVal=="PAYPAL_CREDITCARD_MASTERCARD"){
            $("#credit_card_input_div").slideDown("fast");
            if(currencyType=="CNY"){
                GatewayPayment.showGatewayUSDTip(srcPage, USD2CNYRate);
            }
        }
        else {
            $("#credit_card_input_div").slideUp("fast");
        }
        //网银信用卡支付
        if(gatewayTypeVal=="CHINABANK_CREDITCARD"){
            if(currencyType=="USD"){
                GatewayPayment.showGatewayCNYTip(srcPage, CNY2USDRate);
            }
        }else{
            $('#chinabank_credit_select').hide();
        }
        //银行卡支付
        if(gatewayTypeVal=="CHINABANK"){
            $("#bank_list_div").slideDown("fast");
            if(currencyType=="USD"){
                GatewayPayment.showGatewayCNYTip(srcPage, CNY2USDRate);
            }
        } else {
            $("#bank_list_div").slideUp("fast");
            $("#pmode_id").val("-1");
        }
        //银行转账支付
        if(gatewayTypeVal=="BANK_TRANSFER"){
            GatewayPayment.fillGatewayCNYField(srcPage, CNY2USDRate, currencyType, "bank_transfer_amount_span");
            $("#bank_transfer").slideDown("fast");
        } else {
            var collectionType=$('#payment_collection_type').val();
            $("#bank_transfer").slideUp("fast");
        }
        //支付宝或paypal支付
        if(gatewayTypeVal=="ALIPAY" || gatewayTypeVal=="PAYPAL"){
            var defaultText = "";
            if(gatewayTypeVal=="ALIPAY"){
                defaultText = Lang.get("PAYMENT_GATEWAY_请输入支付宝账号登录");
                if(currencyType=="USD"){
                    GatewayPayment.showGatewayCNYTip(srcPage, CNY2USDRate);
                }
            }
            else {
                defaultText = Lang.get("PAYMENT_GATEWAY_请输入PALPAY账号登录");
                if(currencyType=="CNY"){
                    GatewayPayment.showGatewayUSDTip(srcPage, USD2CNYRate);
                }
            }
            var buyerEmailField = $("#buyer_email");
            buyerEmailField.focus(
                function(){
                    YpEffects.toggleFocus('buyer_email', 'focus', defaultText, '', 'black');
                }
                );
            buyerEmailField.blur(
                function(){
                    YpEffects.toggleFocus('buyer_email', 'blurs',defaultText, '','#909ea4');
                }    
                );
            $("#buyer_email").val(defaultText);
            $("#buyer_email_input_div").show();
        } else {
            $("#buyer_email_input_div").hide();
        }
        $("#bank_transfer_img").attr("src","/images/api/china_bank_transfer_gray.jpg");
        $("#mastercard_img").attr("src","/images/api/mastercard_gray.jpg");
        $("#chinabank_img").attr("src","/images/api/online_banking_gray.jpg");
        $("#paypal_img").attr("src","/images/api/paypal_gray.jpg");
        $("#visa_img").attr("src","/images/api/visa_gray.jpg");
        if(gatewayTypeVal == 'CHINABANK'){
            $("#chinabank_img").attr("src","/images/api/online_banking.jpg");
        }else if(gatewayTypeVal == 'PAYPAL_CREDITCARD_VISA'){
            $("#visa_img").attr("src","/images/api/visa.jpg");
        }else if(gatewayTypeVal == 'PAYPAL_CREDITCARD_MASTERCARD'){
            $("#mastercard_img").attr("src","/images/api/mastercard.jpg");
        }else if(gatewayTypeVal == 'PAYPAL'){
            $("#paypal_img").attr("src","/images/api/paypal.jpg");
            $('#buyer_email').val('');
        }else if(gatewayTypeVal == 'BANK_TRANSFER'){
            $("#bank_transfer_img").attr("src","/images/api/china_bank_transfer.jpg");
        }
    },
    onmouseoverShow : function(elementId){
        var element = $("#"+elementId);
        element.css('background-color', 'royalblue');
        element.css('color', 'buttonface');
    },
    onmouseoutShow : function(elementId){
        var element = $("#"+elementId);
        element.css('background-color', '');
        element.css('color', '');
    },
    delImage:function(uid,type,hid1,hid2){
        var r=confirm(Lang.get("COLLECT_EDIT_您真的要删除吗？"));
        if(r == true){
            $.getJSON("/ypservice/api",{
                a:"DELETE_API_IMAGE",
                uid:uid,
                type:type,
                random:Math.random()
            },function(json){
                if(json.success){
                    document.getElementById(hid1).style.display = 'none';//隐藏
                    document.getElementById(hid2).style.display = 'none';//隐藏
                }else{
                    alert(json.singleErrorMsg);
                }
            })
        }
    }
}

var FundPayment = {
    //初始化支付页面
    initPages : function(isLogin, isCollectEachAttendeeInfo) {
        if(!isLogin && isCollectEachAttendeeInfo) {
            //同步输入支付人与第一个活动参加者的信息
            this.synFirstAttendeeFromPayer();
        }
    },
    //同步支付人与第一个参加者的信息
    synFirstAttendeeFromPayer : function() {
        $("#payer_name,#payer_email,#payer_mobilePhone,#payer_company,#payer_position").blur(function(e){
            var target = $(e.target);
            var targetName = target.attr("id");
            var firstAttendeeNameSuffix = targetName.split("_")[1];
            var firstAttendeeEle = $("#attendee_info_collect_container input[name$='"+firstAttendeeNameSuffix+"']").first();
            if(firstAttendeeEle.length == 1 && YpValid.checkFormValueNull(firstAttendeeEle)) {
                firstAttendeeEle.val(target.val());
            }
        });
    },
    synAllAttendeeFromFirstAttendee : function(){
        var firstAttendeeContainer = $("dl.first_attendee_info_container");
        var allNoFirstAttendeeContainer = $("dl.no_first_attendee_info_container");
        var synAllAttendeeCB = $("#syn_all_attendee_cb");
        var synAllAttendeeCBStatus = synAllAttendeeCB.attr("checked");
        firstAttendeeContainer.find("input,textarea,select").each(function() {
            var type = $(this).attr("tagName");
            var name = $(this).attr("name");
            var value = $(this).val();
            var prefix = name.split(".")[0];
            if(type=="INPUT") {
                var subType = $(this).attr("type");
                if(subType == "text") {
                    if(!synAllAttendeeCBStatus) {
                        value = "";
                    }
                    if(name.indexOf("register_personal_info")!=-1) {
                        var postfix = name.split(".")[1];
                        //Register persional info field
                        allNoFirstAttendeeContainer.find("input[name$='." + postfix + "'][type='text']").val(value);
                    } else if(name.indexOf("register_question")!=-1) {
                        //Register question answer field
                        allNoFirstAttendeeContainer.find("input[name^='" + prefix + "'][type='text']").val(value);
                    }
                } else if(subType == "checkbox") {
                    if(name.indexOf("register_question")!=-1) {
                        //Register question answer field
                        var checked = $(this).attr("checked");
                        if(!synAllAttendeeCBStatus) {
                            checked = false;
                        }
                        allNoFirstAttendeeContainer.find("input[name^='" + prefix + "'][value='"+value+"']").attr("checked",checked);
                    }
                } else if(subType == "radio") {
                    if(name.indexOf("register_question")!=-1) {
                        //Register question answer field
                        checked = $(this).attr("checked");
                        if(!synAllAttendeeCBStatus) {
                            checked = false;
                        }
                        allNoFirstAttendeeContainer.find("input[name^='" + prefix + "'][value='"+value+"']").attr("checked",checked);
                    }
                }
            } else if(type == "TEXTAREA") {
                if(name.indexOf("register_question")!=-1) {
                    //Register question answer field
                    if(!synAllAttendeeCBStatus) {
                        value = "";
                    }
                    allNoFirstAttendeeContainer.find("textarea[name^='" + prefix + "']").val(value);
                }
            } else if(type == "SELECT") {
                if(name.indexOf("register_question")!=-1) {
                    //Register question answer field
                    if(!synAllAttendeeCBStatus) {
                        allNoFirstAttendeeContainer.find("select[name^='" + prefix + "']").attr("selectedIndex", 0);
                    } else {
                        allNoFirstAttendeeContainer.find("select[name^='" + prefix + "']").val(value);
                    }
                }
            } 
        })
    },
    appendAttendeeInfoFields : function() {
        //append input fields for each attendee
        var priceNumSelects=$("select[name$='.quantity']");
        var attendeeInfoContainer = $("#attendee_info_collect_container");
        var attendeeInfoTemplate = $("#each_attendee_info_template");
        var loopCount = 0;
        priceNumSelects.each(function(index,ele){
            $("body").data($(this).attr("id"), $(this).val());
            var priceName = $("#fund_collection_price\\["+index+"\\]\\.name").html();
            for(var i=0;i<parseInt($(this).val());i++) {
                loopCount++;
                var attendeeInfoTitle = Lang.get("PAYMENT_PAY_参加人") + " #" + loopCount + " - " + priceName;
                var attendeeInfoEle = attendeeInfoTemplate.clone();
                attendeeInfoEle.find(".each_attendee_info_title").first().html(attendeeInfoTitle);
                attendeeInfoEle.html(attendeeInfoEle.html().replace(/{tindex}/g,loopCount-1))
                if(loopCount!=1) {
                    attendeeInfoEle.find(":text").val("");
                    //Add Class: no_first_attendee_info_container
                    attendeeInfoEle.children("dl").addClass("no_first_attendee_info_container");
                } else {
                    //Add Class: first_attendee_info_container
                    attendeeInfoEle.children("dl").addClass("first_attendee_info_container");
                }
                //Add link cmd : syn all attendee information
                if(loopCount == 2) {
                    var div = $("<div></div>")
                    var cb = $("<input type='checkbox' id='syn_all_attendee_cb'/>");
                    cb.click(function(){
                        FundPayment.synAllAttendeeFromFirstAttendee();
                    });
                    var text = Lang.get("PAYMENT_PAY_以下门票信息相同");
                    div.append(cb).append(text);
                    div.addClass("TextAlignRight");
                    attendeeInfoContainer.append(div);
                }
                attendeeInfoContainer.append(attendeeInfoEle.find("dl"));
            
            }
        })
    },
    getDiscountAmount : function(discountType, discountRate, discountAmount, paymentUnitAmount, paymentQuantity) {
        var resultAmount;
        if(discountType == "AMOUNT") {
            resultAmount = discountAmount * paymentQuantity;
        } else {
            resultAmount = discountRate/100*paymentUnitAmount*paymentQuantity;
        }
        return Math.round(resultAmount*100)/100;
    },
    //Set total amount contant:subtotal/discount/total
    setTotalAmount : function() {
        var afterDiscountAmountContainer = $("#payment_amount_after_discount_container");
        var totalContainer = $("#payment_total_container");
        var discountTotalAmountContiner = $("#discount_total_amount_container");
        var subtotalContainer = $("#payment_subamount_container");
        var discountJSON = $("#discount_input_container").data("discountJSON");
        var isAvailableForAllPrice;
        var discount;
        if(discountJSON != undefined) {
            isAvailableForAllPrice = discountJSON.isAvailableForAllPrice;
            discount =  eval('(' + discountJSON.discount + ')');
        }
        var priceNumSelects=$("select[name$='.quantity']");
        var subtotalAmount = 0;
        var discountTotalAmount = 0;
        priceNumSelects.each(function(){
            var unitAmount = $(this).parent().parent("span").prev("span").find("input[name$='.unit_amount']").val();
            var quantity = $(this).val();
            //Set subtotal
            subtotalAmount += Math.round(unitAmount*quantity*100)/100;
            //Set discount amount
            //Check whether success use discount 
            if(discountJSON != undefined) {
                if(isAvailableForAllPrice) {
                    //Sum discount total amount
                    discountTotalAmount += FundPayment.getDiscountAmount(discount.type, discount.rate, discount.amount, unitAmount, quantity);
                } else {
                    //FundPayment quantity related price id
                    var quantityPriceId = $(this).prev("input[name$='price_id']").val();
                    //Check whether discount related price ids include quantity related price id
                    $.each(discount.fundCollectionDiscountPriceList,function(index, ele){
                        var relatedPrice = ele.fundCollectionPrice;
                        var priceId = relatedPrice.id;
                        if(priceId == quantityPriceId) {
                            discountTotalAmount += FundPayment.getDiscountAmount(discount.type, discount.rate, discount.amount, unitAmount, quantity);
                            return false;
                        }
                    })
                }
            }
        })
        subtotalContainer.html(subtotalAmount);
        
        if(discountTotalAmount > 0) {
            discountTotalAmount = Math.round(discountTotalAmount*100)/100; 
            discountTotalAmountContiner.text(discountTotalAmount);
            var totalAmount = Math.round((subtotalAmount - discountTotalAmount)*100)/100;
            totalContainer.text(totalAmount);
            afterDiscountAmountContainer.slideDown();
            $("#payment_amount").val(totalAmount);
        } else{
            discountTotalAmountContiner.text(0);
            totalContainer.text(0);
            afterDiscountAmountContainer.slideUp();
            $("#payment_amount").val(subtotalAmount)
        }
    },
    //Show discount input container
    showDiscountInputContainer : function() {
        $("#discount_before_input_container").hide();
        $("#discount_after_input_container").hide();
        $("#discount_input_container").slideDown();
    },
    togglePriceDescrpiton : function(aLink){
        $(aLink).parents("dd").first().find("div").toggle();
    },
    resetDiscount : function() {
        //Empty discount code input field
        $("#discount_code").val("");
        //Remove discount data on the element
        $("#discount_input_container").removeData();
        //Hide after discount amount container
        $("#payment_amount_after_discount_container").hide();
        //Display discount input container
        this.showDiscountInputContainer();
    },
    //Check input discount
    checkDiscount : function(){
        var wrongMsgContainer = $("#wrong_message_for_discount");
        //First hide wrong msg container
        YpMessage.hideMessage(wrongMsgContainer);
        var discountCodeJEle = $("#discount_code");
        if(YpValid.checkFormValueNull(discountCodeJEle)) {
            YpMessage.showMessageAndFocusEle(wrongMsgContainer, Lang.get("COLLECT_EDIT_请输入折扣码"), discountCodeJEle);
        }
        var cwebId = $("#cwebid").val();
        var discountCode = discountCodeJEle.val();
        //Remove data on the element
        $("#discount_input_container").removeData();
        //Check discount by ajax
        var datenow = new Date();
        var rnd = datenow.getTime();
        $.getJSON("/payment/payment", {
            a : "CHECK_DISCOUNT",
            webId : cwebId,
            discount_code : discountCode,
            rnd : rnd
        }, function(json){
            if(json.success) {
                //Get currency type i8n text
                var currencyType;
                var currencySign=$('#currency_sign');
                if($.trim(currencySign.text())=='$'){
                    currencyType=Lang.get('GLOBAL_美元');
                } else{
                    currencyType=Lang.get('GLOBAL_元');
                }
                var isAvailableForAllPrice = json.isAvailableForAllPrice;
                var discount =  eval('(' + json.discount + ')');
                //Display discount name
                $("#discount_name_container").text(discount.name);
                //Display discount rate descr
                var discountRateText;
                if(discount.type == "AMOUNT") {
                    discountRateText = discount.amount + currencyType;
                } else {
                    discountRateText = discount.rate + "%";
                }
                $("#discount_rate_container").text(discountRateText);
                //Display discount related price descr
                var discountRelatedPriceText;
                if(isAvailableForAllPrice) {
                    discountRelatedPriceText = Lang.get("PAYMENT_EDIT_针对所有票价");
                } else {
                    discountRelatedPriceText = Lang.get("PAYMENT_EDIT_针对以下票价优惠");
                    var discountPriceList = discount.fundCollectionDiscountPriceList;
                    for(var discountPriceIndex in discountPriceList) {
                        var relatedPrice = discountPriceList[discountPriceIndex].fundCollectionPrice;
                        var priceName = relatedPrice.name;
                        discountRelatedPriceText += priceName;
                        if(discountPriceIndex != discountPriceList.length - 1) {
                            discountRelatedPriceText += ", ";
                        }
                    
                    }
                }
                $("#discount_input_container").data("discountJSON", json);
                $("#discount_related_price_container").text(discountRelatedPriceText);
                $("#discount_input_container").hide();
                FundPayment.setTotalAmount();
                $("#discount_after_input_container").slideDown();
            } else {
                YpMessage.showMessageAndFocusEle(wrongMsgContainer, json.singleErrorMsg, discountCodeJEle);
            }
        })
    },
    //检查支付人的基本信息
    _checkPayerBasicForm : function(paymentWMsgDiv, payerInfoRequired, payerMobileInfoRequired, payerWorkInfoRequired, isLogin){
        //If required payer basic info or user is not login, check the payer name,email and mobilePhone
        if(payerInfoRequired || !isLogin){
            var payerNameJEle = $('#payer_name');
            if(YpValid.checkFormValueNull(payerNameJEle)) {
                YpMessage.showWrongMessageAndBorderEle(paymentWMsgDiv, Lang.get("PAYMENT_PAY_请填写姓名"),payerNameJEle);
                return false;
            }
            var payerEmailJEle = $('#payer_email');
            if(YpValid.checkFormValueNull(payerEmailJEle)) {
                YpMessage.showWrongMessageAndBorderEle(paymentWMsgDiv, Lang.get("PAYMENT_PAY_请填写您的邮箱"),payerEmailJEle);
                return false;
            }
            if(!YpValid.checkFormValueEmail(payerEmailJEle)) {
                YpMessage.showWrongMessageAndBorderEle(paymentWMsgDiv, Lang.get("ACCOUNT_LOGIN_请输入合法的邮件地址"),payerEmailJEle);
                return false;
            }
        }
        if(payerMobileInfoRequired){
            var payerPhoneJEle = $('#payer_mobilePhone');
            if(YpValid.checkFormValueNull(payerPhoneJEle)) {
                YpMessage.showWrongMessageAndBorderEle(paymentWMsgDiv, Lang.get("PAYMENT_PAY_请填写手机号码"),payerPhoneJEle);
                return false;
            }
        }
        //If required payer work info, check the payer company and position
        if(payerWorkInfoRequired) {
            var payerCompanyJEle = $('#payer_company');
            if(YpValid.checkFormValueNull(payerCompanyJEle)) {
                YpMessage.showWrongMessageAndBorderEle(paymentWMsgDiv, Lang.get("PAYMENT_PAY_请填写您所在公司/组织的名称"),payerCompanyJEle);
                return false;
            }
            var payerPositionJEle = $('#payer_position');
            if(YpValid.checkFormValueNull(payerPositionJEle)) {
                YpMessage.showWrongMessageAndBorderEle(paymentWMsgDiv, Lang.get("PAYMENT_PAY_请填写职位"),payerPositionJEle);
                return false;
            }
        }  
        return true;
    },
    //
    addToWaitingList : function(payerInfoRequired, payerWorkInfoRequired, isLogin) {
        var paymentForm = $("#payment_form");
        var paymentWMsgDiv = $("#payment_wrong_msg_div");
        var paymentLoadDiv = $("#payment_loading_div");
        paymentWMsgDiv.hide();
        var result = this._checkPayerBasicForm(paymentWMsgDiv, payerInfoRequired, payerWorkInfoRequired, isLogin);
        if(!result) {
            return false;
        }
        //Post ajax data
        
        var url = paymentForm.attr("action");
        var payerName = $("#payer_name").val();
        var payerEmail = $("#payer_email").val();
        var payerPhone = $("#payer_mobilePhone").val();
        var payerCompany = $("#payer_company").val();
        var payerPosition = $("#payer_position").val();
        var payerMsg = $("#payer_msg").val();
        var cWebId = $("#cwebid").val();
        var data = {
            payer_name:payerName, 
            payer_email:payerEmail, 
            payer_phone:payerPhone, 
            payer_company:payerCompany,
            payer_position:payerPosition,
            payer_msg:payerMsg,
            cwebid:cWebId,
            a:"ADD_TO_WAITING_LIST"
        };
        paymentLoadDiv.show();
        $.post(url, data, function(json){
            if(!json.success){
                YpMessage.showMessage(paymentWMsgDiv, json.singleErrorMsg);
            } else {
                if(json.redirectUrl != "") {
                    redirect(json.redirectUrl);
                }
            }
            paymentLoadDiv.hide();
        }, "json");
    },
    isApproval_:false,
    //Payment step one: choose ticket
    checkStepOneForm : function() {
        var totalCount = 0;
        var approvalCount = 0;
        var ordinaryCount = 0;
        var priceNumSelects=$("select[name$='.quantity']");
        var approvalPriceNumSelects=$("select[id$='.approvalQuantity']");
        var ordinaryPriceNumSelects=$("select[id$='.quantity']");
        priceNumSelects.each(function(){
            totalCount += parseInt($(this).val());
        })
        ordinaryPriceNumSelects.each(function(){
            ordinaryCount += parseInt($(this).val());
        });
        approvalPriceNumSelects.each(function(){
            approvalCount += parseInt($(this).val());
        });
        if(totalCount == 0) {
            alert(Lang.get("PAYMENT_PAY_请选择数量"));
        } else if(ordinaryCount > 0 && approvalCount > 0){
            alert(Lang.get("PAYMENT_PAY_审批票与非审批票不能同时购买"));
        }else {
            priceNumSelects.each(function(index,ele){
                $(this).css("display", "none");
                $(this).parent().append("<b>"+$(this).val()+"</b>");
            })
            //Reset discount if the discount is invalid
            if($("#payment_amount_after_discount_container").css("display") == "none") {
                FundPayment.resetDiscount();
            } 
            //Hide the discount input container
            $("#discount_before_input_container").hide();
            $("#discount_input_container").hide();
            $("#discount_edit_link").hide();
            var paymentForm = $("#payment_form");
            var data = paymentForm.serialize();
            data += "&a=INIT_ORDER&time=" + new Date().getTime();
            if(approvalCount > 0){
                FundPayment.isApproval_ = true;
                data += "&approval=true";
            }
            var url = paymentForm.attr("action");
            $("#payment_step2_container").load(url,data, function(){
                $("#payment_step1_button_container").hide();
                if(approvalCount > 0){
                    $("#payment_style_choose").hide();//Hide the paygate
                    $("#invoice_input_container").hide();//Hide the invoice
                    $("#is_approval_order").val('true');
                }
            });
        }
    
    } ,
    checkStepTwoForm : function(type,payerInfoRequired,payerMobileInfoRequired,payerWorkInfoRequired,isLogin,questionSize){
        var paymentForm = $("#payment_form");
        $('#payment_form').attr('enctype', 'multipart/form-data').get(0).encoding = 'multipart/form-data';
        var paymentWMsgDiv = $("#payment_wrong_msg_div");
        var paymentLoadDiv = $("#payment_loading_div");
        paymentWMsgDiv.hide();
        $('#currency_convert_tip').hide();
        //Check Form
        //First, reset form fields css style
        paymentForm.find("input,textarea").removeAttr("style");
        //Check payer basic info
        var result = this._checkPayerBasicForm(paymentWMsgDiv, payerInfoRequired,payerMobileInfoRequired, payerWorkInfoRequired, isLogin);
        if(!result) {
            return false;
        }
        //Check payer registion question answer or every attendee basic and register question answer
        if(questionSize > 0){
            
            //Check text and textarea type question answer
            var flag = true;
            $("#payer_reg_question_container,#attendee_info_collect_container").find(":text[title='required'],textarea[title='required'],:file[title='required']").each(function(){
                var e = $(this);
                if(YpValid.checkFormValueNull(e)){
                    YpMessage.showWrongMessageAndBorderEle(paymentWMsgDiv, Lang.get("PAYMENT_PAY_请填写必填项"),e);
                    flag = false;
                    return false;
                }
            })
            if(!flag){
                return false;
            }
            //Check radio type question answer
            var allCheckbox = $("#payer_reg_question_container,#attendee_info_collect_container").find("div[title='checkboxRequired']");
            var allCheckedCheckbox = $("#payer_reg_question_container,#attendee_info_collect_container").find("label[title='checkboxRequired']>:checkbox[name^='register_question']:checked");
            if(allCheckbox.length>allCheckedCheckbox.length){
                YpMessage.showWrongMessage(paymentWMsgDiv, Lang.get("PAYMENT_PAY_请填写必填项"));
                return false;
            }
            //Check checkbox type question answer
            var allRadio= $("#payer_reg_question_container,#attendee_info_collect_container").find("div[title='radioRequired']");
            var allCheckedRadio = $("#payer_reg_question_container,#attendee_info_collect_container").find("label[title='radioRequired']>:radio[name^='register_question']:checked");
            if(allRadio.length != allCheckedRadio.length){
                YpMessage.showWrongMessage(paymentWMsgDiv, Lang.get("PAYMENT_PAY_请填写必填项"));
                return false;
            }
            //Check whether agreement checked
            var rqAgreementCB = $("#rq_agreement_cb");
            if(rqAgreementCB[0] !=null && !rqAgreementCB[0].checked) {
                YpMessage.showWrongMessage(paymentWMsgDiv, Lang.get("PAYMENT_PAY_请勾选同意条款"));
                return false;
            }
        }
        //Check invoice info
        if($('#need_invoice').attr('checked')){
            var invoiceTitle = $('#invoice_title');
            if(YpValid.checkFormValueNull(invoiceTitle)) {
                YpMessage.showWrongMessageAndBorderEle(paymentWMsgDiv, Lang.get("PAYMENT_PAY_请输入发票抬头"),invoiceTitle);
                return false;
            }
            var invoiceName = $('#invoice_name');
            if(YpValid.checkFormValueNull(invoiceName)) {
                YpMessage.showWrongMessageAndBorderEle(paymentWMsgDiv, Lang.get("PAYMENT_PAY_请输入收件人姓名"),invoiceName);
                return false;
            }
            var invoicePhone = $('#invoice_phone');
            if(YpValid.checkFormValueNull(invoicePhone)) {
                YpMessage.showWrongMessageAndBorderEle(paymentWMsgDiv, Lang.get("PAYMENT_PAY_请输入电话号码"),invoicePhone);
                return false;
            }
            var invoiceAddress = $('#invoice_address');
            if(YpValid.checkFormValueNull(invoiceAddress)) {
                YpMessage.showWrongMessageAndBorderEle(paymentWMsgDiv, Lang.get("PAYMENT_PAY_请输入地址"),invoiceAddress);
                return false;
            }
            var invoiceProvince = $('#invoice_province');
            if(YpValid.checkFormValueNull(invoiceProvince)) {
                YpMessage.showWrongMessageAndBorderEle(paymentWMsgDiv, Lang.get("PAYMENT_PAY_请输入省市"),invoiceProvince);
                return false;
            }
            var invoicePostcode = $('#invoice_postcode');
            if(YpValid.checkFormValueNull(invoiceProvince)) {
                YpMessage.showWrongMessageAndBorderEle(paymentWMsgDiv, Lang.get("PAYMENT_PAY_请输入邮编"),invoicePostcode);
                return false;
            }
        }
        //Process payer leave message
        var payerMsgTextArea = $("#payer_msg");
        var payerMsg = $.trim(payerMsgTextArea.val());
        if(payerMsg==Lang.get("PAYMENT_PAY_给收款人留言...") || payerMsg==Lang.get("PAYMENT_PAY_给发起人留言...")) {
            payerMsgTextArea.empty();
        }
        if(FundPayment.isApproval_ || $("#is_approval_order").val() == 'true'){
            //form sumit and return
            paymentForm.attr("target", "_self");
            $("#is_approval_order").val('true');
            YpMessage.showLoadingMessage(paymentLoadDiv);
            paymentForm.submit();
            return;
        }
        //Check gateway select
        var gatewayCheckFlag = GatewayPayment.checkGatewayForm(paymentWMsgDiv);
        if(!gatewayCheckFlag) {
            return false;
        }
        //Post ajax data
        
        //        var url = paymentForm.attr("action");
        //        var data = paymentForm.serialize();
        YpMessage.showLoadingMessage(paymentLoadDiv);
        $("#payment_btn").attr("disabled", "disabled");
        var gatewayType = $("#gateway_type").val();
        if(gatewayType == "ALIPAY" || gatewayType == "CHINABANK" || gatewayType == "PAYPAL"){
            //Show model dialog
            $("#paymentTipDialog" ).dialog({
                title:Lang.get("PAYMENT_PAY_支付"),
                resizable: false,
                height:180,
                width:350,
                modal: true,
                show: 'fade',
                hide: 'fade'
            });
            //Submit form
            paymentForm.submit();
        } else {
            paymentForm.attr('target', '_self');
            paymentForm.submit();
        }
    },
    detectCount : 0,
    detectResult : function(gatewayPaymentId) {
        var resultMsgDiv = $("#result_progressmsg");
        var resultProgress = $("#result_progressbar");
        resultProgress.show();
        var timer = null;
        FundPayment.detectCount += 1;
        if(FundPayment.detectCount >= 30) {
            resultMsgDiv.parent("div").removeClass().addClass("sucess_title2");
            resultMsgDiv.parent("div").parent("div").removeClass().addClass("wrongMessage");
            YpMessage.showWrongMessage(resultMsgDiv, Lang.get("GLOBAL_MSG_PARAM_购买失败"));
            resultMsgDiv.append($("#result_back_msg").html());
            resultProgress.hide();
            return;
        }
        $.getJSON("/payment/result", {
            a: "DETECT_PAYMENT_RESULT", 
            gid: gatewayPaymentId,
            time : new Date().getTime()
        }, function(json) {
            if(!json.success){
                resultMsgDiv.parent("div").addClass("sucess_title2").removeClass("sucess_title");
                resultMsgDiv.parent("div").parent("div").removeClass().addClass("wrongMessage");
                YpMessage.showWrongMessage(resultMsgDiv, json.singleErrorMsg);
                resultProgress.hide();
                if(timer != null){
                    window.clearTimeout(timer);
                }
            } else {
                var value;
                if(json.status == "PAYMENT_PENDING") {
                    value = resultProgress.progressbar("value");
                    value += 10;
                    if(value >= 100) {
                        value = 95;
                    }
                } else {
                    value = 100;
                }                  
                resultProgress.progressbar({
                    value: value
                });
                if(value == 100) {
                    resultMsgDiv.html(Lang.get('GLOBAL_处理成功'));
                    resultMsgDiv.parent("div").removeClass().addClass("sucess_title");
                    resultMsgDiv.parent("div").parent("div").removeClass().addClass("successMessage");
                    if(timer != null){
                        window.clearTimeout(timer);
                    }
                    redirectSelf();
                } else {
                    timer = window.setTimeout(function(){
                        FundPayment.detectResult(gatewayPaymentId);
                    },3000);
                }
            }
        });
    },
    redirectToResult : function(hintSuccess) {
        var subOrderSerialId = $("input[name='sub_order_serial_id']").val();
        $.getJSON("/payment/result", {
            a: "REDIRECT_RESULT", 
            hint_success: hintSuccess,
            sub_order_serial_id: subOrderSerialId,
            time : new Date().getTime()
        }, function(json) {
            if(!json.success){
                alert(json.singleErrorMsg);
            } else {
                if(json.redirectUrl != "") {
                    redirect(json.redirectUrl);
                }
            }
        });
    }, 
    contactHost:function(){
        var fromName=$.trim($('#fromName').val());
        if(fromName==''){
            $('#contactHostMessageDiv').show();
            $('#contactHostMessage').html('姓名不能为空');
            $('#fromName').focus();
            return;
        }
        var fromEmail=$.trim($('#fromEmail').val());
        var emailRegex = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,8}$/i;
        if(!emailRegex.test(fromEmail)){
            $('#contactHostMessageDiv').show();
            $('#contactHostMessage').html('请填写正确的邮件地址');
            $('#fromEmail').focus();
            return;
        }
        var msgContent=$.trim($('#msgContent').val());
        if(msgContent==''){
            $('#contactHostMessageDiv').show();
            $('#contactHostMessage').html('内容不能为空');
            $('#msgContent').focus();
            return;
        }
        $('#contactHostDialog').load("/payment/z_contact_host",            
            $('#contactHost').serialize(),
            function(response) {
                var ajaxReturn = eval($(response).find('div[title="ajaxReturnSuccess"]').text());
                var ajaxReturnError=$(response).find('div[title="ajaxReturnError"]').text();
                if(ajaxReturn){
                    ContactHostDialog.close();
                    ContactHostSuccessDialog.open();
                // RefundSuccessDiv.open();
                //redirectSelf();
                }else{
                    if($.trim(ajaxReturnError)!=''){
                        // RefundDiv.close();
                        alert(ajaxReturnError);
                    }
                }
            });
    },
    showInvoiceDiv:function(){
        if($('#need_invoice').attr('checked')){
            $('#need_invoice_div').show();
            $('#payment_bank_transfer_msg_account_1').hide();
            $('#payment_bank_transfer_msg_name_1').hide();
            $('#payment_bank_transfer_msg_account_2').show();
            $('#payment_bank_transfer_msg_name_2').show();
        }else{
            $('#need_invoice_div').hide(); 
            $('#payment_bank_transfer_msg_account_1').show();
            $('#payment_bank_transfer_msg_name_1').show();
            $('#payment_bank_transfer_msg_account_2').hide();
            $('#payment_bank_transfer_msg_name_2').hide();
        }
    },
    showPaymentStep2Container:function() {
        $("#payment_step1_button_container").hide();
        $("#return_payment_step1_link_container").show();
        $("#payment_step2_container").show(); 
    }
}

var TransferPayment = {
    
    checkPaymentForm : function(){
        var paymentMsgDiv = $("#payment_wrong_msg_div");
        var paymentLoadDiv = $("#payment_loading_div");
        var transferType = $("#transfer_type").val();
        if(transferType == "-1") {
            MessageShow.showWrongMessage(Lang.get("TRANSFER_PAY_请选择转款方式...."));
            return false;
        }
        //        if(transferType == "BALANCE_AND_PAYGATE") {
        //            if($("#transfer_type_balance_checkbox")[0].checked && !$("#transfer_type_gateway_checkbox")[0].checked) {
        //                MessageShow.showWrongMessage(Lang.get("TRANSFER_PAY_请选择支付网关...."));
        //                return false;
        //            }
        //        }
        if(transferType == "PAYGATE" || transferType == "BALANCE_AND_PAYGATE"){
            var gatewayCheckFlag = GatewayPayment.checkGatewayForm(paymentMsgDiv);
            if(!gatewayCheckFlag) {
                return false;
            }
            paymentMsgDiv.empty();
            $('#payment_notice_div').show();
            paymentLoadDiv.show();
            return true;
        }
        return true;
    }
}


/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
var FundTransfer = {
    setTransferAmount : function(userCNYBalance, CNY2USDRate, USD2CNYRate) {
        if(userCNYBalance != undefined && userCNYBalance!=0){
            var paymentTotalAmount = $.trim($("#transfer_amount").val());
            var currencyType = $("#currency_type").val();
            var balanceLackText = $("#balance_lack_text_cny").text();
            if(currencyType == "USD") {
                balanceLackText = $("#balance_lack_text_usd").text();
            }
            $("#balance_lack_text").text(balanceLackText);
            GatewayPayment.initBalanceSelect(userCNYBalance, currencyType, paymentTotalAmount, CNY2USDRate, USD2CNYRate);
        }
    },
    redirectToResult : function(hintSuccess) {
        $.getJSON("/transfer/result", {
            a: "REDIRECT_RESULT", 
            hint_success: hintSuccess,
            payer_email:$("#payer_email").val(),
            time : new Date().getTime()
        }, function(json) {
            if(!json.success){
                alert(json.singleErrorMsg);
            } else {
                if(json.redirectUrl != "") {
                    redirect(json.redirectUrl);
                }
            }
        });
    },
    checkLinkTransferForm : function(minAmount) {
        var paymentForm = $("#payment_form");
        var paymentLoadDiv = $("#payment_loading_div");
        var paymentWMsgDiv = $("#payment_wrong_msg_div");
        var amount = $.trim($("#transfer_amount").val());
        var title = $.trim($("#transfer_title").val());
        if(amount == ""){
            $("#transfer_amount").focus();
            MessageShow.showWrongMessage(Lang.get("LINK_TRANSFER_PAY_请输入金额"), "transfer_amount");
            return false;
        }
        var numberRegex =  /^\d+(\.\d{0,2})?$/;
        if(!numberRegex.test(amount)){
            $("#transfer_amount").focus();
            MessageShow.showWrongMessage(Lang.get("TRANSFER_PAY_请输入合法的金额"), "transfer_amount");
            return false;
        }
        if(numberRegex.test(amount)){
            if(amount<minAmount){
                $("#transfer_amount").focus();
                MessageShow.showWrongMessage(Lang.get("TRANSFER_PAY_最低转款金额为X元", minAmount+''), "transfer_amount");
                return false;
            }
        }
        if(title == ""){
            $("#transfer_title").focus();
            MessageShow.showWrongMessage(Lang.get("LINK_TRANSFER_PAY_请输入事由"), "transfer_title");
            return false;
        }
        var payerNameJEle = $('#payer_name');
        if(YpValid.checkFormValueNull(payerNameJEle)) {
            YpMessage.showWrongMessageAndBorderEle(paymentWMsgDiv, Lang.get("PAYMENT_PAY_请填写姓名"),payerNameJEle);
            return false;
        }
        var payerEmailJEle = $('#payer_email');
        if(YpValid.checkFormValueNull(payerEmailJEle)) {
            YpMessage.showWrongMessageAndBorderEle(paymentWMsgDiv, Lang.get("PAYMENT_PAY_请填写您的邮箱"),payerEmailJEle);
            return false;
        }
        if(!YpValid.checkFormValueEmail(payerEmailJEle)) {
            YpMessage.showWrongMessageAndBorderEle(paymentWMsgDiv, Lang.get("ACCOUNT_LOGIN_请输入合法的邮件地址"),payerEmailJEle);
            return false;
        }
        var payerMsg = $.trim($("#payer_msg").val());
        if(payerMsg==Lang.get("PAYMENT_PAY_给收款人留言...")) {
            $("#payer_msg").empty();
        }
        var gatewayCheckFlag = GatewayPayment.checkGatewayForm(paymentWMsgDiv);
        if(!gatewayCheckFlag) {
            return false;
        }
        //Post ajax data
        
        var url = paymentForm.attr("action");
        var data = paymentForm.serialize();
        YpMessage.showLoadingMessage(paymentLoadDiv);
        $("#payment_btn").attr("disabled", "disabled");
        var gatewayType = $("#gateway_type").val();
        if(gatewayType == "ALIPAY" || gatewayType == "CHINABANK" || gatewayType == "PAYPAL"){
            //Show model dialog
            $("#paymentTipDialog" ).dialog({
                title:Lang.get("PAYMENT_PAY_支付"),
                resizable: false,
                height:180,
                width:350,
                modal: true,
                show: 'fade',
                hide: 'fade'
            });
            //Submit form
            return true;
        } else {
            $.post(url, data, function(json){
                if(!json.success){
                    YpMessage.showMessage(paymentWMsgDiv, json.singleErrorMsg);
                } else {
                    if(json.redirectUrl != "") {
                        redirect(json.redirectUrl);
                    }
                }
                YpMessage.hideLoadingMessageOnly(paymentLoadDiv);
                $("#payment_btn").removeAttr("disabled");
            }, "json");
            return false;
        }
    },
    
    checkTransferForm : function(minAmount) {
        var transferMsgDiv = $("#transfer_wrong_msg_div");
        var transferLoadDiv = $("#transfer_loading_div");
        var amount = $.trim($("#transfer_amount").val());
        var title = $.trim($("#transfer_title").val());
        var transferName = $.trim($("#transfer_name").val());
        var transferEmail = $.trim($("#transfer_email").val());
        if(transferName == ""){
            $("#transfer_name").focus();
            MessageShow.showWrongMessage(Lang.get("TRANSFER_PAY_请输入收款人姓名"));
            return false;
        }
        if(transferEmail == ""){
            $("#transfer_email").focus();           
            MessageShow.showWrongMessage(Lang.get("TRANSFER_PAY_请输入收款人邮件地址"));
            return false;
        }
        var emailRegex = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,8}$/i;
        if(!emailRegex.test(transferEmail)){
            $("#transfer_email").focus();
            transferMsgDiv.html(Lang.get("TRANSFER_PAY_请输入合法的邮件地址"));
            transferMsgDiv.show();
            Lang.get("TRANSFER_PAY_请输入收款人邮件地址")
            return false;
        }
        if(amount == ""){
            $("#transfer_amount").focus();
            MessageShow.showWrongMessage(Lang.get("TRANSFER_PAY_请输入转款金额"));
            return false;
        }
        var numberRegex =  /^\d+(\.\d{0,2})?$/;
        if(!numberRegex.test(amount)){
            $("#transfer_amount").focus();
            MessageShow.showWrongMessage(Lang.get("TRANSFER_PAY_请输入合法的金额"));
            return false;
        }
        if(numberRegex.test(amount)){
            if(amount<minAmount){
                $("#transfer_amount").focus();
                MessageShow.showWrongMessage(Lang.get("TRANSFER_PAY_最低转款金额为X元", minAmount+''));
                return false;
            }
        }
        if(title == ""){
            $("#transfer_title").focus();
            MessageShow.showWrongMessage(Lang.get("TRANSFER_PAY_请输入转款事由"));
            return false;
        }
        MessageShow.showLoadingMessage();
        
        return true;
    }
}


/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */


var MessageShow={
    hiddenNoticeMessage:function(){
        $('.noticeMessage').hide();
        $('.successMessage').hide();
        $('.wrongMessage').hide();
        $('.loadingMessage').hide();
    },
    showWrongMessage:function(msg,id,range){
        if(!range||range.length<1){//rang 防止一个页面中出现两个错误信息提示
            range='';
        }
        $(range+' .noticeMessage').show();
        $(range+' .wrongMessage').show();
        $(range+' .wrongMessage').html(msg);
        if(id!=null){
            $('#'+id).val('');
            $('#'+id).focus();
        }
    },
    showPopWrongMessage:function(range,msg,id){//range 防止pop up出错时 底层页面也同时显示错误信息
        $(range+' .noticeMessage').show();
        $(range+' .wrongMessage').show();
        $(range+' .wrongMessage').html(msg);
        if(id!=null){
            $('#'+id).val('');
            $('#'+id).focus();
        }
    },
    showLoadingMessage:function(){
        $('.wrongMessage').hide();
        $('.successMessage').hide();
        $('.noticeMessage').show();
        $('.loadingMessage').show();
    },
    showPopLoadingMessage:function(range){
        $(range+' .wrongMessage').hide();
        $(range+' .successMessage').hide();
        $(range+' .noticeMessage').show();
        $(range+' .loadingMessage').show();
    },
    showSuccessMessage:function(msg){
        $('.wrongMessage').hide();
        $('.loadingMessage').hide();
        $('.noticeMessage').show();
        $('.successMessage').show().html(msg)
    }
}


//#################################################################
var language = {
    doSetChinese:function(force){
        $.post("/public/z_set_lang", 
        {
            a:"SET_LANG", 
            lang:"zh",
            force:force
        } ,
        function(response) {
            redirectSelf();
        }
        );
    },
    doSetEnglish:function(force){
        $.post("/public/z_set_lang", 
        {
            a:"SET_LANG", 
            lang:"en",
            force:force
        } ,
        function(response) {
            redirectSelf();
        }
        );
    }
}
var YoopayLink={
    initHeaderTips : function() {
        if (document.getElementById('header_yoopay_link') != null){
            $('#header_yoopay_link').qtip({
                content: {
                    text: $('#header_yoopay_link_contents').html(),
                    title: {
                        text: $('#header_yoopay_link_title').html(),
                        button: true
                    }
                },
                position: {
                    my: 'top center', // ...at the center of the viewport
                    at: 'bottom center',
                    target: $('#header_yoopay_link')
                },
                show: {
                    event: 'mouseover' // Show it on click...
                },
                hide: false, // Don't specify a hide event either!
                style: {
                    classes: 'qtip-shadow  qtip-rounded qtip-green'
                }
            });
        }
    },
    closeHeaderTips : function() {
        $(".bt-wrapper").hide("slow");
    }
}
var SignupCompanyAccountTipDialog= {
    _init:false,
    open:function(){
        if(!SignupCompanyAccountTipDialog._init){
            $('#signup_company_account_tip_dialog').dialog({
                autoOpen: false, 
                width: 600,
                show: 'fade',
                hide: 'fade',
                modal: true,
                title: Lang.get("ACCOUNT_TIP_怎样注册公司组织账户")
            });   
            SignupCompanyAccountTipDialog._init = true;
        }
        $('#signup_company_account_tip_dialog').dialog('open');
    },
    close:function(){
        $('#signup_company_account_tip_dialog').dialog('close');
    }
}

var templateListDialog = {
    _init:false,
    loadTemplate:function(){
        var wrongMsgDiv = $("#template_list_wrong_msg");
        var checkedRadios = $("input:radio[name='template_selected_webId']:checked");
        if(checkedRadios.length == 0) {
            YpMessage.showWrongMessage(wrongMsgDiv, Lang.get("COLLECT_EDIT_请选择活动模板"));
        } else {
            var templateWebId = checkedRadios.first().val();
            redirect("/collect/create/event?templateWebId="+templateWebId);
        }
    },
    close:function(){
        $('#templateListDialog').dialog('close');
    },
    open:function(){
        if(!templateListDialog._init){
            $('#templateListDialog').dialog({
                autoOpen: false, 
                width: 600,
                show: 'fade',
                hide: 'fade',
                modal: true,
                title: Lang.get("COLLECT_EDIT_选择活动模板")
            });   
            templateListDialog._init = true;
        }
        $('#templateListDialog').dialog('open');
        templateListDialog.loadTemplateList();
    },
    loadTemplateList:function(){
        var loadingDiv = $("#template_list_loading_div");
        var wrongMsgDiv = $("#template_list_wrong_msg");
        YpMessage.showLoadingMessage(loadingDiv);
        $.post("/collect/template_list", 
            function(json) {
                if(json.success){
                    var templateList = json.list;
                    var tbodyEle = $("#template_list_tbody");
                    tbodyEle.empty();
                    $.each(templateList, function(index,template) {
                        var trClassName = null;
                        if(index%2!=0){
                            trClassName = "white";
                        }
                        var trEle = YpElement.createTr(trClassName);
                        var tdtitle = YpElement.createTd(template.title);
                        
                        var radio = YpElement.createRadioButton("template_selected_webId", template.webId);
                        var tdRadioBtn = YpElement.createTd("");
                        tdRadioBtn.append(radio);
                        trEle.append(tdRadioBtn);
                        trEle.append(tdtitle);
                        tbodyEle.append(trEle);
                    });
                    $("#template_list_table").show();
                } else {
                    YpMessage.showWrongMessage(wrongMsgDiv, json.singleErrorMsg);
                }
                YpMessage.hideLoadingMessage(loadingDiv);
            },
            "json"
            );
    }
}

var loginDialog = {
    _init:false,
    open:function(defaultEmail, payid){
        //this.addEventInfo();//未登录 活动支付时添加price num信息
        if(!loginDialog._init){
            $('#loginDialog').dialog({
                autoOpen: false, 
                width: 600,
                show: 'fade',
                hide: 'fade',
                modal: true,
                title: Lang.get("ACCOUNT_LOGIN_请登录")
            });   
            loginDialog._init = true;
        }
        if(defaultEmail != null){
            this.setDefaultEmail(defaultEmail);
            signupDialog.setDefaultEmail(defaultEmail,payid);
        }
        $("#pop_login_msg").hide();
        $('#loginDialog').dialog('open');
    },
    close:function(){
        $('#loginDialog').dialog('close');
    },
    setDefaultEmail : function(email) {
        var popLoginEmail =  $("#pop_login_email");
        popLoginEmail.val(email);
        popLoginEmail.attr("readonly", "readonly");
        popLoginEmail.css("color","#9D9D9D");
    },
    doLogin:function(){
        if(UserLogin.checkPopLoginForm()) {
            $.post("/account/z_login_dialog", 
                $('#loginForm').serialize() ,
                function(json) {
                    if(json.success){
                        var pathname = $(location).attr('pathname');
                        if(pathname == "/public/index" || pathname == "/"){
                            redirect("/account/overview");
                        } else {
                            var redirectUrl = $("#login_redirect_url_field").val();
                            redirect(redirectUrl);
                        }
                    } else {
                        var wrongMsgConainer = $("#pop_login_msg");
                        YpMessage.showWrongMessage(wrongMsgConainer, json.singleErrorMsg);
                    }
                    $("#pop_login_loading_div").hide();
                    $("#pop_login_submit_btn").attr("disabled", false);
                },
                "json"
                );
        }
    
    }
}
var signupDialog = {
    _init:false,
    open:function(){
        if(!signupDialog._init){
            $('#signupDialog').dialog({
                autoOpen: false, 
                width: 600,
                show: 'fade',
                hide: 'fade',
                modal: true,
                title: Lang.get("ACCOUNT_SIGNUP_请注册")
            });   
            signupDialog._init = true;
        }
        $('#signupDialog').dialog('open');
    },
    close:function(){
        $('#signupDialog').dialog('close');
    },
    setDefaultEmail : function(email,payid) {
        var popSignUpEmail =  $("#pop_signup_email");
        popSignUpEmail.val(email);
        popSignUpEmail.attr("readonly", "readonly");
        popSignUpEmail.css("color","#9D9D9D");
        $("#pop_signup_payid").val(payid);
    },
    doSignup:function(){
        //loginDialog.addEventInfo('signup');//未登录 活动支付时添加price num信息
        if(UserSignup.checkPopSignupForm()) {
            $('#signupDialog').load("/account/z_signup_dialog", 
                $('#signupForm').serialize() ,
                function(response) {
                    //                    var ajaxReturn = eval($(response).find('div[title="ajaxReturn"]').text());
                    //                    if(ajaxReturn){
                    //                        var pathname = $(location).attr('pathname');
                    //                        if(pathname == "/public/index"){
                    //                            redirect("/account/overview");
                    //                        } else {
                    //                            var redirectUrl = $("#login_redirect_url_field").val();
                    //                            redirect(redirectUrl);
                    //                        }
                    //                    }
                    redirectSelf();
                }
                );
        }
    }
}

var verifyDialog = {
    _init:false,
    open:function(){
        if(!verifyDialog._init){
            $('#verifyDialog').dialog({
                autoOpen: false, 
                width: 600,
                show: 'fade',
                hide: 'fade',
                modal: true,
                title:Lang.get("ACCOUNT_VERIFY_请验证您的注册邮箱地址")
            });   
            verifyDialog._init = true;
        }
        $("#send_verify_email_msg").show();
        $("#send_verify_email_success").hide();
        $('#verifyDialog').dialog('open');
    },
    close:function(){
        $('#verifyDialog').dialog('close');
    },
    doVerify:function(){
        UserVerify.sendVerifyEmail();
    }
}

var TicketCustomServiceDialog = {
    _init:false,
    open:function(){
        if(!TicketCustomServiceDialog._init){
            $('#ticket_custom_service_dialog').dialog({
                autoOpen: false, 
                width: 600,
                show: 'fade',
                hide: 'fade',
                modal: true
            });   
            TicketCustomServiceDialog._init = true;
        }
        $('#ticket_custom_service_dialog').dialog('open');
    },
    close:function(){
        $('#ticket_custom_service_dialog').dialog('close');
    }
}


var allowPayGateDialog = {
    _init:false,
    open:function(gType,sourceEle){
        $(sourceEle).attr("checked",false);
        if(!allowPayGateDialog._init){
            $('#allowPayGateDialog').dialog({
                autoOpen: false, 
                width: 600,
                show: 'fade',
                hide: 'fade',
                modal: true
            });   
            allowPayGateDialog._init = true;
        }
        $('#allowPayGateDialog').dialog('open');
    },
    close:function(){
        $('#allowPayGateDialog').dialog('close');
    }
}
var invoiceFaPiao = {
    _init:false,
    open:function(eId){
        var letYoopayInvoiceFaPiao = $("#" + eId);
        if(!letYoopayInvoiceFaPiao.attr("checked")) {
            return; 
        } else {
            letYoopayInvoiceFaPiao.attr("checked",false);
        }
        if(!invoiceFaPiao._init){
            $('#invoiceFaPiao').dialog({
                autoOpen: false, 
                width: 600,
                show: 'fade',
                hide: 'fade',
                modal: true
            });   
            invoiceFaPiao._init = true;
        }
        $('#invoiceFaPiao').dialog('open');
    },
    close:function(){
        $('#invoiceFaPiao').dialog('close');
    },
    confirm:function(){
        invoiceFaPiao.close();
        $('#letYoopayInvoiceFaPiao').attr("checked", true);
        if($('#letYoopayInvoiceFaPiao').attr("checked") && $('#hostInvoiceFaPiao').attr("checked")){
            $('#hostInvoiceFaPiao').attr("checked", false);
        }
    },
    invoiceProviderOnclick:function(){
        if($('#letYoopayInvoiceFaPiao').attr("checked") && $('#hostInvoiceFaPiao').attr("checked")){
            $('#letYoopayInvoiceFaPiao').attr("checked", false);
        }
    }
}
var allowBankTransferPayGateDialog = {
    _init:false,
    open:function(eId){
        var allowPaygateTypeCreditcard = $("#" + eId);
        if(!allowPaygateTypeCreditcard.attr("checked")) {
            return; 
        }
        else {
            allowPaygateTypeCreditcard.attr("checked",false);
        }
        if(!allowBankTransferPayGateDialog._init){
            $('#allowBankTransferPayGateDialog').dialog({
                autoOpen: false, 
                width: 600,
                show: 'fade',
                hide: 'fade',
                modal: true
            });   
            allowBankTransferPayGateDialog._init = true;
        }
        $('#allowBankTransferPayGateDialog').dialog('open');
    },
    close:function(){
        $('#allowBankTransferPayGateDialog').dialog('close');
    }
}
var OverviewCollectDialog = {
    open:function(webId,cType){
        $("#overview_c_webid").val(webId);
        var text = "";
        if(cType == "EVENT") {
            text = Lang.get("COLLECT_TYPE_PART_活动");
        } else if(cType == "MEMBER") {
            text = Lang.get("COLLECT_TYPE_PART_会员费");
        }else if(cType == "PRODUCT") {
            text = Lang.get("COLLECT_TYPE_PART_产品");
        }else if(cType == "SERVICE") {
            text = Lang.get("COLLECT_TYPE_PART_服务");
        }else if(cType == "DONATION") {
            text = Lang.get("COLLECT_TYPE_PART_募捐");
        }
        $('#account_overview_text_hide_msg').html(text);
        $('#overviewCollectDialog').dialog({
            autoOpen: false, 
            width: 650,
            show: 'fade',
            hide: 'fade',
            modal: true,
            title: Lang.get("ACCOUNT_OVERVIEW_DIALOG_隐藏")
        });
        $('#overviewCollectDialog').dialog('open');
    },
    close:function(){
        $('#overviewCollectDialog').dialog('close');
    },
    submit:function(){
        var webId = $.trim($("#overview_c_webid").val());
        MessageShow.showLoadingMessage();
        $.getJSON("/collect/remove_overview_collect", {
            webId : webId
        } ,function(json){
            if(json.success){
                MessageShow.hiddenNoticeMessage();
                $("#set_yplink_msg").hide();
                $("#set_yplink_success").show();
                redirect("/account/overview");
            } else {
                MessageShow.showWrongMessage(json.singleErrorMsg, "yplink_msg");
                $("#yplink_loading_div").hide();
            }
        })
    }

}

var attendeeEditDialog = {
    _init:false,
    open:function(){
        if(!attendeeEditDialog._init){
            $('#attendeeEditDialog').dialog({
                autoOpen: false, 
                width: 600,
                show: 'fade',
                hide: 'fade',
                modal: true,
                title: Lang.get("ACCOUNT_TICKT_编辑参会人信息")
            });   
            attendeeEditDialog._init = true;
        }
        $('#attendeeEditDialog').dialog('open');
    },
    close:function(){
        $('#attendeeEditDialog').dialog('close');
    },
    submit:function(){
        //$('#edit_loading_'+ticketId).show();
        $('#attendeeEditDialogContent').load("/account/z_edit_attendee_dialog",            
            $('#edit_attendee_form').serialize(),
            function(response) {
                var ajaxReturn = eval($(response).find('div[title="ajaxReturn"]').text());
                if(ajaxReturn){
                    attendeeEditDialog.open();
                }else{
                }
            //$('#edit_loading_'+ticketId).hide();
            }
            );
    },
    loadDialog:function(ticketId){
        $('#edit_loading_'+ticketId).show();
        $('#attendeeEditDialogContent').load("/account/z_edit_attendee_dialog",            
        {
            'ticketId':ticketId
        },
        function(response) {
            var ajaxReturn = eval($(response).find('div[title="ajaxReturn"]').text());
            if(ajaxReturn){
                attendeeEditDialog.open();
            }else{
            }
            $('#edit_loading_'+ticketId).hide();
        }
        );
    }
}
var yplinkDialog = {
    _init:false,
    open:function(){
        if(!yplinkDialog._init){
            $('#yplinkDialog').dialog({
                autoOpen: false, 
                width: 600,
                show: 'fade',
                hide: 'fade',
                modal: true,
                title: Lang.get("ACCOUNT_YPLINK_请选择您的友付链接")
            });   
            yplinkDialog._init = true;
        }
        $('#yplinkDialog').dialog('open');
    },
    close:function(){
        $('#yplinkDialog').dialog('close');
    },
    submit:function(){
        var yplink = $.trim($("#yplink_input").val());
        if(yplink == ""){
            $("#yplink_input").focus();
            MessageShow.showWrongMessage(Lang.get("ACCOUNT_YPLINK_请输入链接名称"), "yplink_msg");
            return;
        }
        MessageShow.showLoadingMessage();
        $.getJSON("/account/set_yplinkid", {
            yplink_id : yplink
        } ,function(json){
            if(json.success){
                MessageShow.hiddenNoticeMessage();
                $("#set_yplink_msg").hide();
                $("#set_yplink_success").show();
                redirect("/account/overview");
            } else {
                MessageShow.showWrongMessage(json.singleErrorMsg, "yplink_msg");
                $("#yplink_loading_div").hide();
            }
        })
    }
}
/**************Utils*********************/
var YpCookie = {
    getCookie : function (c_name)
    {
        if (document.cookie.length>0)
        {
            var c_start=document.cookie.indexOf(c_name + "=")
            if (c_start!=-1)
            { 
                c_start=c_start + c_name.length+1 
                var c_end=document.cookie.indexOf(";",c_start)
                if (c_end==-1) c_end=document.cookie.length
                return unescape(document.cookie.substring(c_start,c_end))
            } 
        }
        return ""
    },
    
    setCookie :function (c_name,value,expiredays){
        var exdate=new Date()
        exdate.setDate(exdate.getDate()+expiredays)
        document.cookie=c_name+ "=" +escape(value)+
        ((expiredays==null) ? "" : ";expires="+exdate.toGMTString())
    },
    removeCookie:function(c_name,c_path){
        document.cookie=c_name+ "=" +escape(null)+";expires="+new Date().toGMTString() + ";path="+c_path;
    }
}

var YpDate = {
    /**
     * 初始化DatePicker(年月日)
     */
    setDatePicker : function(jeleInputStart, jeleInputEnd, sync) {
        var locale = "en-us"; //zh-CN
        if(Lang.getLanguage() == "zh") {
            locale = "zh-CN";
        }
        $.datepicker.setDefaults($.datepicker.regional[locale]);
        jeleInputStart.datepicker({
            onSelect: function (selectedDateTime){
                var start = $(this).datepicker('getDate');
                jeleInputStart.css("color","black");
                jeleInputEnd.datepicker('option', 'minDate', new Date(start.getTime()) );
                if(sync == true ) {
                    jeleInputEnd.val(jeleInputStart.val());
                    jeleInputEnd.css("color","black");
                } 
            }
        });
        jeleInputEnd.datepicker({
            onSelect: function (selectedDateTime){
                jeleInputEnd.css("color","black");
            }
        });
    
    },
    /**
     * 初始化时间下拉列表 00:00->23:30(间隔30分钟)
     */
    setTimeSelect : function(jeleSelectStart, jeleSelectEnd) {
        var eData;
        var date = new Date();
        date.setHours(00);
        date.setMinutes(00);
        for(var i=0;i<48;i++) {
            if(i!=0){
                if(date.getMinutes() == 0) {
                    date.setMinutes(30);
                } else {
                    date.setMinutes(0);
                    date.setHours(date.getHours()+1);
                }
            }
            var hour = date.getHours() < 10 ? "0" + date.getHours() : date.getHours();
            var minute = date.getMinutes() < 10 ? "0" + date.getMinutes() : date.getMinutes();
            var time = hour + ":" + minute;
            var option = $("<option></option>");
            option.val(time);
            option.html(time);
            jeleSelectStart.append(option);
            jeleSelectEnd.append(option.clone());
        }
        var startDateEle =  jeleSelectStart.prev("input");
        var expireDateEle =  jeleSelectEnd.prev("input");
        //同一天内，结束时间要晚于开始时间
        jeleSelectStart.change(function(event) {
            
            if(startDateEle.val() == expireDateEle.val()){
                //Select Element
                var e = $(event.target);
                eData = e;
                var selectedIndex = e.attr("selectedIndex"); //From 0
                var options = jeleSelectEnd.children("option"); //Expire time options
                
                for(var i=0;i<options.length;i++) {
                    if(i<=selectedIndex) {
                        if(selectedIndex==i&&selectedIndex+1==options.length){
                            $(options[i]).attr("disabled", false);
                            $(options[i]).attr("selected", true);
                        } else{
                            $(options[i]).attr("disabled", true);
                        }
                    } else{
                        $(options[i]).attr("disabled", false);
                        if(i==selectedIndex+1) {
                            $(options[i]).attr("selected", true);
                        }
                    }
                }
            } else {
                options = jeleSelectEnd.children("option[disabled=true]");
                for(var i=0;i<options.length;i++) {
                    $(options[i]).attr("disabled", false);
                }
            }
        });
        jeleSelectEnd.mousedown(function(){
            if(eData != null && startDateEle.val() == expireDateEle.val()){
                //Select Element
                var e = eData;
                var selectedIndex = e.attr("selectedIndex"); //From 0
                var options = jeleSelectEnd.children("option"); //Expire time options
                
                for(var i=0;i<options.length;i++) {
                    if(i<=selectedIndex) {
                        if(selectedIndex==i&&selectedIndex+1==options.length){
                            $(options[i]).attr("disabled", false);
                        } else{
                            $(options[i]).attr("disabled", true);
                        }
                    } else{
                        $(options[i]).attr("disabled", false);
                    }
                }
            } else {
                options = jeleSelectEnd.children("option[disabled=true]");
                for(var i=0;i<options.length;i++) {
                    $(options[i]).attr("disabled", false);
                }
            }
        });
    }
/**
     * 
     */
}
/**
 * Author:Swang
 * 特效工具类
 */
var YpEffects = {
    /**
     * 表单元素默认文字focus和blus特效
     * Eg:onfocus:YpEffects.toggleFocus([eId],"focus",'Please input your name...','','black')
     *    onblur:YpEffects.toggleFocus([eId],"blur",'Please input your name...','','#909ea4')
     **/
    toggleFocus : function(eId, type, initShowMsg, initHideMsg, styleColor){
        var e = $("#" + eId);
        this.toggleFocus4Ele(e[0], type, initShowMsg, initHideMsg, styleColor);
    
    },
    toggleFocus4Ele : function(ele, type, initShowMsg, initHideMsg, styleColor){
        var e = $(ele);
        var eVal = $.trim(e.val());
        if(type=="focus") {
            if(eVal == initShowMsg){
                e.val(initHideMsg);
                e.css("color", styleColor);
            }
        } else {
            if(eVal == initHideMsg) {
                e.val(initShowMsg);
                e.css("color", styleColor);
            }
        }
    }
}    
/**
 * Author:Swang
 */
var YpValid = {
    checkImgType : function(value){
        var ext = value.substring(value.lastIndexOf(".")+1).toUpperCase();
        if(ext=="JPG" || ext=="JPEG" || ext=="GIF" || ext=="PNG") {
            return true;
        }
        return false;
    },
    checkTextType : function(value){
        var ext = value.substring(value.lastIndexOf(".")+1).toUpperCase();
        if(ext=="txt" || ext=="doc" || ext=="docx") {
            return true;
        }
        return false;
    },
    checkFormValueNull: function(ele) {
        if($.trim(ele.val()) == "") {
            return true;
        }
        return false;
    }, 
    checkFormValueEmail : function(ele) {
        var emailRegex = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,8}$/i;  
        return emailRegex.test($.trim(ele.val()));
    },
    checkFormValueNullAndEqual: function(ele, evalue) {
        var val = $.trim(ele.val());
        if(val == "") {
            return true;
        }
        if(val == evalue) {
            return true;
        }
        return false;
    }, 
    checkFormArrayValueNull : function(eles) {
        var flag = true;
        eles.each(function(index) {
            if(!YpValid.checkFormValueNull($(this))) {
                flag = false;
                return false;
            }
        })
        return flag;
    }
}
/**
 * Author:Swang
 */
var YpMessage = {
    showMessageAndFocusEle : function(container, message, ele) {
        this.showMessage(container, message);
        ele.focus();
    }, 
    showWrongMessageAndFocusEle : function(container, message, ele) {
        container.removeClass('successMessage');  
        container.addClass('wrongMessage');
        this.showMessage(container, message);
        ele.focus();
    }, 
    showWrongMessageAndBorderEle : function(container, message, ele) {
        this.showMessage(container, message);
        ele.css("border", "1px red solid");
    },
    showMessage : function(container, message) {
        container.html(message);
        container.show();
        var parentContainer = container.parent("div.noticeMessage");
        if(parentContainer.length > 0) {
            parentContainer.show();
        }
    },
    showLoadingMessage : function(container) {
        container.show();
        var parentContainer = container.parent("div.noticeMessage");
        if(parentContainer.length > 0) {
            parentContainer.show();
        }
    }, 
    hideLoadingMessage : function(container) {
        container.hide();
        var parentContainer = container.parent("div.noticeMessage");
        if(parentContainer.length > 0) {
            parentContainer.hide();
        }
    }, 
    hideLoadingMessageOnly : function(container) {
        container.hide();
    },
    showSuccessMessage : function(container, message) {
        container.removeClass('wrongMessage');  
        container.addClass('successMessage');
        this.showMessage(container, message);
    },
    showWrongMessage : function(container, message) {
        container.removeClass('successMessage');  
        container.addClass('wrongMessage');
        this.showMessage(container, message);
    },
    hideMessage : function(container) {
        container.empty();
        container.hide();
    }
}

var YpElement = {
    createTr : function(className) {
        var trEle = $("<tr></tr>");
        if(className != null){
            trEle.attr("class", className);
        }
        return trEle;
    },
    createTd : function(content) {
        var tdEle = $("<td></td>");
        tdEle.html(content);
        return tdEle;
    },
    createRadioButton : function(name,value) {
        return $("<input type='radio' />").attr("name", name).val(value);
    },
    createHiddenInput : function(name,value) {
        return $("<input type='hidden' />").attr("name", name).val(value);
    },
    createCheckboxInput : function(name,value) {
        return $("<input type='checkbox' />").attr("name", name).val(value);
    },
    preventUnCheck: function(ele) {
        if(ele.attr("checked") == "false") {
            ele.attr("checked","true");
        }
    },
    selectAllCB : function(containerId) {
        var container = $("#"+containerId);
        var cbs = container.find("input[type=checkbox]");
        cbs.attr("checked",true);
    },
    toggleAllCB : function(containerId, src) {
        var container = $("#"+containerId);
        var cbs = container.find("input[type=checkbox]");
        
        if(src.checked == true){
            cbs.attr("checked",true);
        }
        else {
            cbs.attr("checked",false);
        }
    
    
    }
}

function redirectAtNewWindow(url){
    //$("#redirect_blank_href").attr("href", url);
    //$("#redirect_blank_href")[0].click();
    $("#redirect_blank_form").attr("action", url);
    $("#redirect_blank_form").submit();
}
function redirect(url){
    //window.location也能做跳转，但在IE下有问题，jQuery已经处理了底层的不同，所以使用jQuery的做法。
    $(location).attr('href', url);
}

function redirectSelf(){
    var url = $(location).attr('href');
    redirect(url);
}

function keepSession(){
    var d = (new Date()).getTime();
    $.ajax({
        url: '/public/z_keep_session?t='+d,
        type: 'GET',
        error: function(xhr) {
        },
        success: function(msg){
        }
    }); 
}

var Lang = {
    _translate:function(string, args){
        if (typeof args == "string") {
            args = [args];
        }
        var tokens = string.match(/{\d+}/g);
        if(tokens != null) {
            for (var i=0;i<tokens.length;i++) {
                //if(typeof tokens[i] == "string" && tokens[i].indexOf("{")==0) {
                string = string.replace(tokens[i], args[tokens[i].match(/\d+/)]);
            //}
            }
        }
        
        return string;
    },
    _getCookie:function(name){
        var arr = document.cookie.match(new RegExp("(^| )"+name+"=([^;]*)(;|$)"));
        if(arr != null) 
            return unescape(arr[2]);
        return null;
    },
    getLanguage: function(){
        return Lang._getCookie('COOKIE_LANG');
    }, 
    /*  使用例子：
     *  没有参数： Lang.get("ACCOUNT_LOGIN_请输入邮件地址");
     *  有一个参数： Lang.get("ACCOUNT_LOGIN_请输入邮件地址", user.getFirstName());
        有多个参数： Lang.get("ACCOUNT_LOGIN_请输入邮件地址", [emailField.value, "e-mail address"]);
     */
    get:function(key, args){
        var lang = Lang._getCookie('COOKIE_LANG');
        if(lang == null){
            lang = "en";
        }
        return Lang._translate(Lang._bundle[key][lang], args);
    },
    _bundle:{
        /* GLOBAL 公用 */
        "GLOBAL_删除":{
            "zh":"删除",
            "en":"Remove"
        },
        "GLOBAL_发送中":{
            "zh":"发送中",
            "en":"Sending"
        },
        "GLOBAL_发送成功":{
            "zh":"发送成功",
            "en":"Sent Successfully"
        },
        "GLOBAL_处理成功":{
            "zh":"处理成功",
            "en":"Process complete"
        },
        "GLOBAL_操作成功":{
            "zh":"操作成功",
            "en":"Operation Succeed"
        },
        "GLOBAL_操作失败":{
            "zh":"操作失败",
            "en":"Operation Failed"
        },
        "GLOBAL_列表为空":{
            "zh":"列表为空",
            "en":"No data"
        },
        "GLOBAL_查看详情":{
            "zh":"查看详情",
            "en":"Details"
        },
        "GLOBAL_隐藏详情":{
            "zh":"隐藏详情",
            "en":"Details"
        },
        "GLOBAL_确定删除":{
            "zh":"确定删除?",
            "en":"Are you sure to delete this?"
        },
        "GLOBAL_名称":{
            "zh":"名称",
            "en":"Description"
        },
        "GLOBAL_BUTTON_付款":{
            "zh":"付款",
            "en":"Pay"
        },
        "GLOBAL_BUTTON_捐款":{
            "zh":"捐款",
            "en":"Donate"
        },
        "GLOBAL_BUTTON_报名":{
            "zh":"报名",
            "en":"Register"
        },
        "GLOBAL_BUTTON_订购":{
            "zh":"订购",
            "en":"Order"
        },
        "GLOBAL_BUTTON_转款":{
            "zh":"转款",
            "en":"Transfer"
        },
        "GLOBAL_BUTTON_提交":{
            "zh":"提交",
            "en":"Submit"
        },
        "GLOBAL_MSG_PARAM_INVALID":{
            "zh":"参数无效",
            "en":"Invalid Information"
        },
        "GLOBAL_元":{
            "zh":"元",
            "en":"RMB"
        },
        "GLOBAL_美元":{
            "zh":"美元",
            "en":"USD"
        },
        "GLOBAL_MSG_PARAM_购买失败":{
            "zh":"购买失败",
            "en":"Payment Fail"
        },
        "GLOBAL_MSG_SEARCH_KEYWORD_BLANK":{
            "zh":"搜索关键字不能为空",
            "en":"Search keyword can not be blank"
        },
        "GLOBAL_浏览器版本过低" :{
            "zh":"您使用的浏览器版本过低，网站的部分功能可能会失效。我们建议您使用最新版本的IE、Chrome或Firefox浏览器。",
            "en":"Your browser version is too old. You may not utilize full functionality of this site. Please use the latest IE, Chrome or Firefox."
        },
        /*INDEX*/
        "INDEX_IMG_HEAD_1":{
            "zh":"\"友付的线上报名注册功能，让我们可以提前确认参会者身份和需求!\"",
            "en":"\"Yoopay is the perfect solution for our large scale corporate event!\""
        },
        //"INDEX_IMG_CONTENT_1":{
        //    "zh":"西蒙·洛伊德<br/>全球人力资源总监<br/>凯宾斯基酒店集团",
        //    "en":"Simon Lloyd<br/>Global HR Director<br/>Kempinski Hotel Group"
        //},
        "INDEX_IMG_CONTENT_1":{
            "zh":"西蒙·洛伊德, 凯宾斯基酒店集团",
            "en":"Simon Lloyd, Kempinski Hotel Group"
        },
        "INDEX_IMG_HEAD_2":{
            "zh":"<span>\"</span><span>友付</span>符合大型国际会议的要求和标准!<span>\"</span>",
            "en":"<span>\"</span><span>Yoopay</span> is the perfect solution for our large scale corporate event<span>\"</span>"
        },
        "INDEX_IMG_CONTENT_2":{
            "zh":"叶艳平<br/>副部长<br/>北京股权投资基金协会",
            "en":"Yanping Ye<br/>Director of Operations<br/> Beijing Private Equity Association"
        },
        "INDEX_IMG_HEAD_3":{
            "zh":"<font size='5'>“</font><font size='5'>友付</font>让活动规模翻倍，收入也翻倍！<font size='5'>“</font>",
            "en":"<font size='5'>\"</font><font size='5'>Yoopay</font> helps us to sell a lot more tickets in China!<font size='5'>\"</font> "
        },
        "INDEX_IMG_CONTENT_3":{
            "zh":"乔丹·巴菲尔德<br/>副总裁<br/>国际旅游协会",
            "en":"Jordan Baronfield<br/>Vice President<br/>Go China Summit"
        },
        "INDEX_IMG_HEAD_4":{
            "zh":"<font size='5'>“</font><font size='5'>友付</font>让校友会的活动组织工作更轻松！<font size='5'>“</font>",
            "en":"<font size='5'>\"</font>Using <font size='5'>Yoopay</font> really is effortless, and saved us a lot of work!<font size='5'>\"</font>"
        },
        "INDEX_IMG_CONTENT_4":{
            "zh":"孙玉红<br/>副会长<br/>哈佛大学北京校友会",
            "en":"Frances Sun<br/>Vice President<br/>Harvard Alumni Club of Beijing"
        },
        "INDEX_IMG_HEAD_5":{
            "zh":"<span>“</span><span>友付</span>使用起来非常简单，减轻了活动组织的很多负担！<span>“</span>",
            "en":"<span>\"</span><span>Yoopay</span> is easy to use, taking a big burden off event organizer's shoulders!<span>\"</span>"
        },
        //"INDEX_IMG_CONTENT_5":{
        //    "zh":"郭基梅<br/>秘书长<br/>亚杰商会",
        //    "en":"May Guo<br/>Secretary-General<br/>AAMA"
        //},
        "INDEX_IMG_CONTENT_5":{
            "zh":"——郭基梅,亚杰商会",
            "en":"——May Guo,AAMA"
        },
        "INDEX_IMG_HEAD_6":{
            "zh":"\"友付，我衷心向所有活动组织者推荐!\"",
            "en":"\"I recommended Yoopay for all professional and social event organizers!\""
        },
        "INDEX_IMG_CONTENT_6":{
            "zh":"薛景耀, 麦士福体育创始人",
            "en":"Yoyao Hsueh, Mashup"
        },
        "INDEX_IMG_HEAD_8":{
            "zh":"<font size='5'>“</font><font size='5'>友付</font>为我们的活动提供专业的报名、注册、及收款功能！<font size='5'>“</font>",
            "en":"<font size='5'>\"</font><font size='5'>Yoopay</font> provides registration, ticketing, and payment service for our event!<font size='5'>\"</font>"
        },
        "INDEX_IMG_CONTENT_8":{
            "zh":"赵兰玉<br/>2012中国 IT 领袖峰会",
            "en":"Yulan Zhao<br/>2012 China IT Summit"
        },
        "INDEX_IMG_HEAD_9":{
            "zh":"<font size='5'>“</font><font size='5'>友付</font>，既安全又容易使用！<font size='5'>“</font>",
            "en":"<font size='5'>\"</font><font size='5'>Yoopay</font> is secure and easy to use!<font size='5'>\"</font>"
        },
        "INDEX_IMG_CONTENT_9":{
            "zh":"林文佳<br/>2012中国鞋服行业<br/>电子商务峰会组委会",
            "en":"Wenjia Lin<br/>2012 China Shoes & Apparel Industry E-commerce Summit"
        },
        "INDEX_IMG_HEAD_10":{
            "zh":"苹果产业链大会",
            "en":"Macworld | iWorld Conference 2012"
        },
        "INDEX_IMG_CONTENT_10":{
            "zh":"姜丽萍, 亚洲苹果大会",
            "en":"Lydia Jiang, MacWorld Asia"
        },
        "INDEX_IMG_HEAD_11":{
            "zh":"\"友付，让校友会的活动组织工作更轻松!\"",
            "en":"\"Using Yoopay is really effortless, and save us a lot of work!\""
        },
        "INDEX_IMG_CONTENT_11":{
            "zh":"Lily Kam, MIT校友会",
            "en":"Lily Kam, MIT Alumni"
        },
        "INDEX_IMG_HEAD_12":{
            "zh":"<font size='5'>\"</font><font size='5'>友付</font>，的服务高效而可靠!<font size='5'>\"</font>",
            "en":"<font size='5'>\"</font><font size='5'>Yoopay</font>'s service is effective and reliable!<font size='5'>\"</font>"
        },
        "INDEX_IMG_CONTENT_12":{
            "zh":"林文佳<br/>2012中国鞋服行业<br/>电子商务峰会组委会",
            "en":"Wenjia Lin<br/>2012 China Shoes & Apparel Industry E-commerce Summit"
        },
        "INDEX_IMG_HEAD_13":{
            "zh":"\"友付，让我们的美食聚会更完美!\"",
            "en":"\"Yoopay make our opening party a perfect event!\""
        },
        "INDEX_IMG_CONTENT_13":{
            "zh":"Allan Wong, 隐泉之语",
            "en":"Allan Wong, Haiku Restaurant Group"
        },
        "INDEX_IMG_HEAD_14":{
            "zh":"\"友付，让本次活动的报名与推广更轻松有效!\"",
            "en":"\"Yoopay makes the event's promotion and registration so easy!\""
        },
        "INDEX_IMG_CONTENT_14":{
            "zh":"Hsu Li, 兰溪沙龙",
            "en":"Hsu Li, Lanxi Club"
        },
        "INDEX_IMG_HEAD_15":{
            "zh":"2012 ChinaVenture 中国投资年会",
            "en":"2012 ChinaVenture Annual Conference"
        },
        "INDEX_IMG_HEAD_16":{
            "zh":"第六届中欧校友私募论坛",
            "en":"6th CEIBS PE Forum"
        },
        "INDEX_IMG_HEAD_17":{
            "zh":"《30岁前别结婚》陈愉分享会",
            "en":"''Do Not Marry Before 30'' - An Afternoon with Author Joy Chen"
        },
        "INDEX_IMG_HEAD_18":{
            "zh":"2012 哈佛校友会新年晚宴",
            "en":"2012 Harvard Club Beijing Annual Appreciation Dinner"
        },
        "INDEX_IMG_HEAD_19":{
            "zh":"饮泉之语开幕晚宴",
            "en":"Haiku @ Jinqiao Opening Party!"
        },
        "INDEX_IMG_HEAD_20":{
            "zh":"2012最美呼伦贝尔大草原7日游",
            "en":"7 Days on the Hulun Buir"
        },
        "INDEX_IMG_HEAD_21":{
            "zh":"麦士福体育联盟",
            "en":"mashup sport league"
        },
        "ADD_FUND_请输入充值金额":{
            "zh":"请输入充值金额",
            "en":"Please enter amount"
        },
        /* ACCOUNT 模块 */
        "ACCOUNT_TIP_怎样注册公司组织账户":{
            "zh":"注册公司账户",
            "en":"Register company account"
        },
        "ACCOUNT_LOGIN_请登录":{
            "zh":"请登录",
            "en":"Please login"
        },
        "ACCOUNT_SIGNUP_请注册":{
            "zh":"请注册",
            "en":"Please signup"
        },
        "ACCOUNT_LOGIN_请输入邮件地址":{
            "zh":"请输入邮件地址",
            "en":"Please enter email address"
        },
        "ACCOUNT_LOGIN_请输入合法的邮件地址":{
            "zh":"请输入合法的邮件地址",
            "en":"Please enter a valid email"
        },
        "ACCOUNT_LOGIN_请输入手机号码":{
            "zh":"请输入手机号码",
            "en":"Please enter mobile phone number"
        },
        "ACCOUNT_LOGIN_请输入合法的手机号码":{
            "zh":"请输入合法的手机号码",
            "en":"Please enter a valid mobile phone number"
        },
        "ACCOUNT_LOGIN_请输入密码":{
            "zh":"请输入密码",
            "en":"Please enter password"
        },
        "ACCOUNT_SIGNUP_请输入姓名":{
            "zh":"请输入姓名",
            "en":"Please enter name"
        },
        "ACCOUNT_SIGNUP_密码长度至少6位":{
            "zh":"密码长度至少6位，请选择新密码",
            "en":"Password must be at least 6 characters long"
        },
        "ACCOUNT_SIGNUP_请输入重复密码":{
            "zh":"请输入重复密码",
            "en":"Please enter the password again"
        },
        "ACCOUNT_SIGNUP_两次密码输入不一致":{
            "zh":"两次密码输入不一致",
            "en":"Passwords do not match"
        },
        "ACCOUNT_SIGNUP_请输入公司名称":{
            "zh":"请输入公司名称",
            "en":"Please enter company name"
        },
        "ACCOUNT_SIGNUP_请输入手机":{
            "zh":"请输入手机",
            "en":"Please enter your mobile"
        },
        "ACCOUNT_SIGNUP_请输入职位":{
            "zh":"请输入职位",
            "en":"Please enter your title"
        },
        "ACCOUNT_SEAL_请上传头像":{
            "zh":"请上传头像",
            "en":"Please upload your profile photo"
        },
        "ACCOUNT_SEAL_请上传正确的头像格式":{
            "zh":"请上传正确的头像格式",
            "en":"Please update a correct format"
        },
        "ACCOUNT_SEAL_请输入姓名":{
            "zh":"请输入姓名",
            "en":"Please enter your name"
        },
        "ACCOUNT_SEAL_请输入邮箱":{
            "zh":"请输入邮箱",
            "en":"Please enter email address"
        },
        "ACCOUNT_SEAL_请输入手机号码":{
            "zh":"请输入手机号码",
            "en":"Please enter mobile phone number"
        },
        "ACCOUNT_SEAL_请选择证件类型":{
            "zh":"请选择证件类型",
            "en":"Please select ID types"
        },
        "ACCOUNT_SEAL_请输入证件号码":{
            "zh":"请输入证件号码",
            "en":"Please enter the ID numbers"
        },
        "ACCOUNT_SEAL_请上传证件扫描件":{
            "zh":"请上传证件扫描件",
            "en":"Please upload scanned copy of the ID"
        },
        "ACCOUNT_SEAL_请上传正确的证件图片格式":{
            "zh":"请上传正确的证件图片格式",
            "en":"Please update a correct format"
        },
        "ACCOUNT_SEAL_请上传公司或团体logo":{
            "zh":"请上传公司或团体logo",
            "en":"Please upload the company or organization's logo"
        },
        "ACCOUNT_SEAL_请上传正确的logo格式":{
            "zh":"请上传正确的logo格式",
            "en":"Please update a correct format"
        },    
        "ACCOUNT_SEAL_请输入公司团体名称":{
            "zh":"请输入公司团体名称",
            "en":"Please enter the company or organization's name"
        },
        "ACCOUNT_SEAL_请输入官方网址":{
            "zh":"请输入官方网址",
            "en":"Please enter official web site"
        },
        "ACCOUNT_SEAL_请选择预计年收款额":{
            "zh":"请选择预计年收款额",
            "en":"Please enter estimated annual billing amount"
        },
        "ACCOUNT_SEAL_请输入地址":{
            "zh":"请输入地址",
            "en":"Please enter address"
        },
        "ACCOUNT_SEAL_请输入电话":{
            "zh":"请输入电话",
            "en":"Please enter telephone number"
        },
        "ACCOUNT_SEAL_请输入传真":{
            "zh":"请输入传真",
            "en":"Please enter fax number"
        },
        "ACCOUNT_VERIFY_请验证您的注册邮箱地址":{
            "zh":"请验证您的注册邮箱地址",
            "en":"Please verify your email address"
        },
        "ACCOUNT_YPLINK_请选择您的友付链接":{
            "zh":"请选择您的友付链接",
            "en":"Please choose your yoopay link"
        },
        "ACCOUNT_TICKT_编辑参会人信息":{
            "zh":"编辑参会人信息",
            "en":"Edit attendee info"
        },
        "ACCOUNT_YPLINK_请输入链接名称":{
            "zh":"请输入链接名称",
            "en":"Please entry link"
        },
        "ACCOUNT_FEEDBACK_给友付提建议":{
            "zh":"给友付提建议",
            "en":"Have suggestion for Yoopay?"
        },
        "ACCOUNT_FEEDBACK_请输入意见或建议":{
            "zh":"请输入意见或建议",
            "en":"Please enter your comment"
        },
        "ACCOUNT_REGINFO_请输入您的姓名":{
            "zh":"请输入您的姓名",
            "en":"Please enter your name"
        },
        "ACCOUNT_REGINFO_请输入您的职位":{
            "zh":"请输入您的职位",
            "en":"Please enter your title"
        },
        "ACCOUNT_MODIFYPWD_请输入原密码":{
            "zh":"请输入原密码",
            "en":"Please enter old password"
        },
        "ACCOUNT_MODIFYPWD_请输入新密码":{
            "zh":"请输入新密码",
            "en":"Please enter new password"
        },
        "ACCOUNT_MODIFYPWD_请重复新密码":{
            "zh":"请重复新密码",
            "en":"Please enter password again"
        },
        "ACCOUNT_MODIFYPWD_两次密码输入不一致":{
            "zh":"两次密码输入不一致",
            "en":"Passwords does not match"
        },
        "ACCOUNT_RESETPWD_请输入您的注册邮箱":{
            "zh":"请输入您的注册邮箱",
            "en":"Please enter your registered email"
        },
        "ACCOUNT_RESETPWD_请输入验证码":{
            "zh":"请输入验证码",
            "en":"Please enter verification codes"
        },
        "ACCOUNT_OVERVIEW_DIALOG_不再显示":{
            "zh":"不再显示",
            "en":"Remove"
        },
        "ACCOUNT_OVERVIEW_DIALOG_隐藏":{
            "zh":"隐藏",
            "en":"Hide"
        },
        /* COLLECTION 模块 */
        "COLLECT_CHECKIN_DIALOG_设置密码":{
            "zh":"设置密码",
            "en":"Set Password"
        },
        "COLLECT_CHECKIN_请先设置密码":{
            "zh":"请先设置密码",
            "en":"Please Set Password"
        },
        "COLLECT_CHECKIN_您无权此操作":{
            "zh":"您无权此操作",
            "en":"No Permission"
        },
        "COLLECT_CHECKIN_两次密码不一致":{
            "zh":"两次密码不一致",
            "en":"Passwords Does Not Match"
        },
        "COLLECT_CHECKIN_密码长度至少6位":{
            "zh":"密码长度至少6位",
            "en":"Password should be at 6 digits long"
        },
        "COLLECT_CHECKIN_密码不能为空":{
            "zh":"密码不能为空",
            "en":"Please enter password"
        },
        "COLLECT_TYPE_PART_活动":{
            "zh":"不再在<span style='color:#2BA8DD'>我的活动</span>中显示此活动的更新信息。但您仍然可以在<a href='/collect/list/event'>活动列表</a>中查看相关信息。<br/>注意：这对活动报名页面本身没有任何影响。",
            "en":"This will remove the event from the <span style='color:#2BA8DD'>my event</span> list. \n But you can still check information from the <a href='/collect/list/event'>Event List</a>.<br/>Note: The is does NOT affect the event registration page itself."
        },
        "COLLECT_TYPE_PART_服务":{
            "zh":"不再在<span style='color:#2BA8DD'>我的服务</span>中显示此服务的更新信息。但您仍然可以在<a href='/collect/list/service'>服务列表</a>中查看相关信息。<br/>注意：这对活动报名页面本身没有任何影响。",
            "en":"This will remove the service from the <span style='color:#2BA8DD'>my service</span> list. \n But you can still check information from the <a href='/collect/list/service'>Service List</a>.<br/>Note: The is does NOT affect the event registration page itself."
        },
        "COLLECT_TYPE_PART_产品":{
            "zh":"不再在<span style='color:#2BA8DD'>我的产品</span>中显示此产品的更新信息。但您仍然可以在<a href='/collect/list/product'>产品列表</a>中查看相关信息。<br/>注意：这对活动报名页面本身没有任何影响。",
            "en":"This will remove the product from the <span style='color:#2BA8DD'>my product</span> list. \n But you can still check information from the <a href='/collect/list/product'>Product List</a>.<br/>Note: The is does NOT affect the event registration page itself."
        },
        "COLLECT_TYPE_PART_会员费":{
            "zh":"不再在<span style='color:#2BA8DD'>我的会员费</span>中显示此会员费的更新信息。但您仍然可以在<a href='/collect/list/member'>会员费列表</a>中查看相关信息。<br/>注意：这对活动报名页面本身没有任何影响。",
            "en":"This will remove the membership from the <span style='color:#2BA8DD'>my membership</span> list. \n But you can still check information from the <a href='/collect/list/member'>Membership List</a>.<br/>Note: The is does NOT affect the event registration page itself."
        },
        "COLLECT_TYPE_PART_募捐":{
            "zh":"不再在<span style='color:#2BA8DD'>我的募捐</span>中显示此募捐的更新信息。但您仍然可以在<a href='/collect/list/donation'>募捐列表</a>中查看相关信息。<br/>注意：这对活动报名页面本身没有任何影响。",
            "en":"This will remove the billing from the <span style='color:#2BA8DD'>my billing</span> list. \n But you can still check information from the <a href='/collect/list/donation'>Billing List</a>.<br/>Note: The is does NOT affect the event registration page itself."
        },
        "COLLECT_TYPE_活动":{
            "zh":"活动",
            "en":"event"
        },
        "COLLECT_TYPE_服务":{
            "zh":"服务",
            "en":"service"
        },
        "COLLECT_TYPE_产品":{
            "zh":"产品",
            "en":"product"
        },
        "COLLECT_TYPE_会员费":{
            "zh":"会员费",
            "en":"membership"
        },
        "COLLECT_TYPE_募捐":{
            "zh":"募捐",
            "en":"billing"
        },
        "COLLECT_TYPE_我的活动":{
            "zh":"我的活动",
            "en":"my event"
        },
        "COLLECT_TYPE_我的服务":{
            "zh":"我的服务",
            "en":"my service"
        },
        "COLLECT_TYPE_我的产品":{
            "zh":"我的产品",
            "en":"my product"
        },
        "COLLECT_TYPE_我的会员费":{
            "zh":"我的会员费",
            "en":"my membership"
        },
        "COLLECT_TYPE_我的募捐":{
            "zh":"我的募捐",
            "en":"my billing"
        },
        "COLLECT_LIST_活动列表":{
            "zh":"活动列表",
            "en":"Event List"
        },
        "COLLECT_LIST_服务列表":{
            "zh":"服务列表",
            "en":"Service List"
        },
        "COLLECT_LIST_产品列表":{
            "zh":"产品列表",
            "en":"Product List"
        },
        "COLLECT_LIST_会员费列表":{
            "zh":"会员费列表",
            "en":"Membership List"
        },
        "COLLECT_LIST_募捐列表":{
            "zh":"募捐列表",
            "en":"Billing List"
        },
        "COLLECT_TICKET_CUSTOM_收起":{
            "zh":"完成",
            "en":"Done"
        },
        "COLLECT_TICKET_CUSTOM_编辑":{
            "zh":"编辑",
            "en":"Edit"
        },
        
        "COLLECT_EDIT_收款":{
            "zh":"收款",
            "en":"Donation"
        },
        
        "COLLECT_EDIT_募捐":{
            "zh":"募捐",
            "en":"Donation"
        },
        "COLLECT_EDIT_请输入金额":{
            "zh":"请输入金额",
            "en":"Please enter amount"
        },
        "COLLECT_EDIT_金额必须为数字":{
            "zh":"金额必须为数字",
            "en":"Amount must be a number"
        },
        "COLLECT_EDIT_金额最多保留两位小数":{
            "zh":"金额最多保留两位小数",
            "en":"Maximum 2 digits after decimal point"
        },
        "COLLECT_EDIT_金额最少为XX元":{
            "zh":"金额最少为 {0} 元",
            "en":"The minimum billing amount is {0} Yuan"
        },
        "COLLECT_EDIT_请选择收款方式":{
            "zh":"请选择收款方式",
            "en":"请选择收款方式eng"
        },
        "COLLECT_EDIT_请添加新种类":{
            "zh":"请添加新种类",
            "en":"Please add new type"
        },
        "COLLECT_EDIT_请输入理由":{
            "zh":"请输入理由",
            "en":"Please enter reason"
        },
        "COLLECT_EDIT_您真的要删除吗？":{
            "zh":"您真的要删除吗？",
            "en":"Do you really want to delete?"
        },
        "COLLECT_SEND_请输入手机号码":{
            "zh":"请输入手机号码",
            "en":"Please enter the phone number"
        },
        "COLLECT_SEND_请输入短信内容":{
            "zh":"请输入短信内容",
            "en":"Please enter the message content"
        },
        "COLLECT_SEND_文本内容X条短信":{
            "zh":"文字内容共计{0}条短信",
            "en":"Text {0} message" 
        },
        "COLLECT_SEND_输入邮件地址,以逗号或换行分隔":{
            "zh":"输入邮件地址,以逗号或换行分隔...",
            "en":"Please add the email addresses, separated by comma or new line"
        },
        "COLLECT_SEND_请输入邮件地址":{
            "zh":"请输入邮件地址",
            "en":"Please add the email adresses"
        },
        "COLLECT_SEND_请输入发件人姓名":{
            "zh":"请输入发件人姓名",
            "en":"Please enter sender name"
        },
        "COLLECT_SEND_请输入回复邮箱":{
            "zh":"请输入回复邮箱",
            "en":"Please enter reply-to email"
        },
        "COLLECT_SEND_请输入合法的邮箱地址":{
            "zh":"请输入合法的邮箱格式",
            "en":"Please enter a valid email"
        },
        "COLLECT_SEND_请输入主题":{
            "zh":"请输入主题",
            "en":"Please enter email subject"
        },
        "COLLECT_SEND_请输入邮件内容":{
            "zh":"请输入邮件内容",
            "en":"Please enter email content "
        },
        "COLLECT_SEND_无未付款用户":{
            "zh":"无未付款用户",
            "en":"No unpaid recipient"
        },
        "COLLECT_EDIT_请输入活动名称":{
            "zh":"请输入活动名称",
            "en":"Please enter the name of the event"
        },
        "COLLECT_EDIT_请输入服务名称":{
            "zh":"请输入服务名称",
            "en":"Please enter service name"
        },
        "COLLECT_EDIT_请输入产品名称":{
            "zh":"请输入产品名称",
            "en":"Please enter product name"
        },
        "COLLECT_EDIT_请输入会员费名称":{
            "zh":"请输入会员费名称",
            "en":"Plese enter the membership name"
        },
        "COLLECT_EDIT_请输入活动开始时间":{
            "zh":"请输入活动开始时间",
            "en":"Please enter the start time of the event"
        },
        "COLLECT_EDIT_请输入活动结束时间":{
            "zh":"请输入活动结束时间",
            "en":"Please enter the end time of the event"
        },
        "COLLECT_EDIT_请输入活动地点":{
            "zh":"请输入活动地点",
            "en":"Please enter the location of the event"
        },
        "COLLECT_EDIT_不能存在两个相同的价格":{
            "zh":"不能存在两个相同的价格",
            "en":"Ticket price must be unique"
        },
        "COLLECT_EDIT_请输入票价":{
            "zh":"请输入票价",
            "en":"Please enter the ticket price"
        },
        "COLLECT_EDIT_请输入服务票价":{
            "zh":"请输入价格",
            "en":"Please enter the price"
        },
        "COLLECT_EDIT_请输入产品票价":{
            "zh":"请输入价格",
            "en":"Please enter the price"
        },
        "COLLECT_EDIT_请输入会员费票价":{
            "zh":"请输入费用",
            "en":"Please enter the fee amount"
        },
        "COLLECT_EDIT_MSG_价格有效期开始时间不能晚于活动结束时间":{
            "zh":"价格有效期开始时间不能晚于活动结束时间",
            "en":"Ticket price expiration date can not behind event end date"
        },
        "COLLECT_EDIT_MSG_价格有效期结束时间不能晚于活动结束时间":{
            "zh":"价格有效期结束时间不能晚于活动结束时间",
            "en":"Ticket price expiration date can not behind event end date"
        },
        "COLLECT_EDIT_折扣码应至少为六位的数字字母组合":{
            "zh":"折扣码应为数字字母组合，至少6位",
            "en":"The discount code can be letters or digits, at least 6 characters long"
        },
        "COLLECT_EDIT_服务折扣码应至少为六位的数字字母组合":{
            "zh":"折扣码应为数字字母组合，至少6位",
            "en":"The discount code can be letters or digits, at least 6 characters long"
        },
        "COLLECT_EDIT_产品折扣码应至少为六位的数字字母组合":{
            "zh":"折扣码应为数字字母组合，至少6位",
            "en":"The discount code can be letters or digits, at least 6 characters long"
        },
        "COLLECT_EDIT_会员费折扣码应至少为六位的数字字母组合":{
            "zh":"折扣码应为数字字母组合，至少6位",
            "en":"The discount code can be letters or digits, at least 6 characters long"
        },
        "COLLECT_EDIT_折扣次数限制应为数字":{
            "zh":"请填写一个合理的折扣码次数限制",
            "en":"Please enter a valid discount usage limit"
        },
        "COLLECT_EDIT_折扣应为0到100间的数字":{
            "zh":"请填写一个合理的折扣",
            "en":"Please enter a valid discount number"
        },
        "COLLECT_EDIT_产品折扣应为0到100间的数字":{
            "zh":"请填写一个合理的折扣",
            "en":"Please enter a valid discount number"
        },
        "COLLECT_EDIT_服务折扣应为0到100间的数字":{
            "zh":"请填写一个合理的折扣",
            "en":"Please enter a valid discount number"
        },
        "COLLECT_EDIT_会员费折扣应为0到100间的数字":{
            "zh":"请填写一个合理的折扣",
            "en":"Please enter a valid discount number"
        },
        "COLLECT_EDIT_不能存在两个相同的折扣码":{
            "zh":"不能存在两个相同的折扣码",
            "en":"Discount code must be unique"
        },
        "COLLECT_EDIT_产品不能存在两个相同的折扣码":{
            "zh":"不能存在两个相同的折扣码",
            "en":"Discount code must be unique"
        },
        "COLLECT_EDIT_服务不能存在两个相同的折扣码":{
            "zh":"不能存在两个相同的折扣码",
            "en":"Discount code must be unique"
        },
        "COLLECT_EDIT_会员费不能存在两个相同的折扣码":{
            "zh":"不能存在两个相同的折扣码",
            "en":"Discount code must be unique"
        },
        "COLLECT_EDIT_请输入折扣码":{
            "zh":"请输入折扣码",
            "en":"Please enter discount code"
        },
        "COLLECT_EDIT_请输入产品折扣码":{
            "zh":"请输入折扣码",
            "en":"Please enter discount code"
        },
        "COLLECT_EDIT_请输入会员费折扣码":{
            "zh":"请输入折扣码",
            "en":"Please enter discount code"
        },
        "COLLECT_EDIT_请输入服务折扣码":{
            "zh":"请输入折扣码",
            "en":"Please enter discount code"
        },
        
        "COLLECT_EDIT_请输入折扣":{
            "zh":"请输入折扣",
            "en":"Please enter the discount"
        },
        "COLLECT_EDIT_请输入产品折扣":{
            "zh":"请输入折扣",
            "en":"Please enter the discount"
        },
        "COLLECT_EDIT_请输入会员费折扣":{
            "zh":"请输入折扣",
            "en":"Please enter the discount"
        },
        "COLLECT_EDIT_请输入服务折扣":{
            "zh":"请输入折扣",
            "en":"Please enter the discount"
        },
        "COLLECT_EDIT_选择活动模板":{
            "zh":"选择活动模板",
            "en":"Please select a template"
        },
        "COLLECT_EDIT_请输入票价名称":{
            "zh":"请输入票价种类",
            "en":"Please enter a ticket name"
        },
        "COLLECT_EDIT_请输入服务票价名称":{
            "zh":"请输入服务种类",
            "en":"Please enter a service type"
        },
        "COLLECT_EDIT_请输入产品票价名称":{
            "zh":"请输入产品种类",
            "en":"Please enter a product type"
        },
        "COLLECT_EDIT_请输入会员费票价名称":{
            "zh":"请输入会员费种类",
            "en":"Please enter a membership type"
        },
        "COLLECT_EDIT_请输入折扣码名称":{
            "zh":"请输入折扣码名称",
            "en":"Please enter a description for the discount code"
        },
        "COLLECT_EDIT_请输入产品折扣码名称":{
            "zh":"请输入折扣码名称",
            "en":"Please enter a description for the discount code"
        },
        "COLLECT_EDIT_请输入会员费折扣码名称":{
            "zh":"请输入折扣码名称",
            "en":"Please enter a description for the discount code"
        },
        "COLLECT_EDIT_请输入服务折扣码名称":{
            "zh":"请输入折扣码名称",
            "en":"Please enter a description for the discount code"
        },
        "COLLECT_EDIT_折扣":{
            "zh":"折扣",
            "en":"Discount"
        },
        "COLLECT_EDIT_本活动折扣码":{
            "zh":"本活动折扣码",
            "en":"Discount Code for the Event"
        },
        "COLLECT_EDIT_请选择活动模板":{
            "zh":"请选择活动模板",
            "en":"Please select a template"
        },
        "COLLECT_EDIT_不能存在两个相同的票价":{
            "zh":"不能存在两个相同的票价",
            "en":"Ticket price must be unique"
        },
        "COLLECT_EDIT_不能存在两个相同的服务票价":{
            "zh":"不能存在两个相同的价格",
            "en":"Service fee must be unique"
        },
        "COLLECT_EDIT_不能存在两个相同的会员费票价":{
            "zh":"不能存在两个相同的会员费",
            "en":"Membership fee must be unique"
        },
        "COLLECT_EDIT_不能存在两个相同的产品票价":{
            "zh":"不能存在两个相同的产品价格",
            "en":"Product price must be unique"
        },
        "COLLECT_EDIT_详情输入内容过大":{
            "zh":"详细内容输入过大",
            "en":"The maximum length of the description is 64,000 words"
        },
        "COLLECT_EDIT_折扣码折扣不能大于对应的票价":{
            "zh":"折扣不能大于对应的票价",
            "en":"Dicount cannot be greater than price itself"
        },
        "COLLECT_EDIT_请选择折扣码对应的票价":{
            "zh":"请选择折扣码对应的价格",
            "en":"Please choose corresponding price for the discount code"
        },
        "COLLECT_EDIT_附件名称":{
            "zh":"附件名称",
            "en":"Description"
        },
        "COLLECT_EDIT_票价种类":{
            "zh":"门票种类",
            "en":"Ticket Type"
        },
        "COLLECT_EVENT_EDIT_票价种类名称":{
            "zh":"票种名称",
            "en":"Ticket Type"
        },
        "COLLECT_SERVICE_EDIT_票价种类名称":{
            "zh":"服务种类名称",
            "en":"Service Type"
        },
        "COLLECT_PRODUCT_EDIT_票价种类名称":{
            "zh":"产品种类名称",
            "en":"Product Type"
        },
        "COLLECT_MEMBER_EDIT_票价种类名称":{
            "zh":"费用种类名称",
            "en":"Membership Type"
        },
        "COLLECT_EDIT_ACTION_展开":{
            "zh":"设置▼",
            "en":"Setting▼"
        },
        "COLLECT_EDIT_ACTION_收起":{
            "zh":"设置▲",
            "en":"Setting▲"
        },
        "COLLECT_CONTACT_联系方式":{
            "zh":"联系方式",
            "en":"Contact Information"
        },
        "COLLECT_CONTACT_发票信息":{
            "zh":"发票信息",
            "en":"Invoice Information"
        },
        "COLLECT_SEND_收款链接已发出":{
            "zh":"付款提醒已发出",
            "en":"Payment reminder has been sent out."
        
        },
        "COLLECT_EDIT_退款金额不能为零":{
            "zh":"退款金额不能为零",
            "en":"The refund amount cannot be zero"
        },
        "COLLECT_EDIT_退款金额不能大于可退金额":{
            "zh":"退款金额不能大于原金额",
            "en":"The refund amount cannot be greater than the original amount"
        },
        "COLLECT_REFUND_退款":{
            "zh":"退款",
            "en":"Refund"
        
        },
        "COLLECT_EDIT_年月日":{
            "zh":"年/月/日",
            "en":"Month/Day/Year"
        },
        "COLLECT_EDIT_请输入正确的日期格式":{
            "zh":"请输入正确的日期格式",  
            "en":"Please enter the correct date format"
        },
        "COLLECT_EDIT_链接不能为空":{
            "zh":"链接不能为空",  
            "en":"Please select a link"
        },
        "COLLECT_EDIT_链接错误":{
            "zh":"链接可以是数字、字母、或减号的组合，长度为8-50个字符",  
            "en":"The link can only contain letters, numbers, or dashes, and 8-20 characters long"
        },
        "COLLECT_EDIT_名称":{
            "zh":"名称",  
            "en":"Description"
        },
        "COLLECT_EDIT_该链接可用":{
            "zh":"该链接可用",  
            "en":"The link is available"
        },
        "COLLECT_DIY_DIALOG_请至少选择一个票价":{
            "zh":"请至少选择一个票种",
            "en":"Please select at least one ticket type"
        },
        "COLLECT_TICKET_DIY_DIALOG_将覆盖第x张票":{
            "zh":"你的选择将会覆盖第{0}张票种的门票背景图，你确认吗？",
            "en":"Your selection will overwrite the {0} ticket's backgound image. Confirm?" 
        },
        "COLLECT_TICKET_DIY_DIALOG_自定义门票海报图片":{
            "zh":"门票背景图",
            "en":"Ticket Backgound Image"
        },
        "COLLECT_TICKET_DIY_DIALOG_请至少选择一个票价":{
            "zh":"请至少选择一个票种",
            "en":"Please select at least one ticket type"
        },
        "COLLECT_TICKET_DIY_DIALOG_默认图片":{
            "zh":"/images/collection/default_ticket_poster_image_zh.png",
            "en":"/images/collection/default_ticket_poster_image_en.png"
        },
        "COLLECT_TICKET_DIY_DIALOG_请上传文件":{
            "zh":"请上传文件",
            "en":"Please upload a file"
        },
        "COLLECT_DIY_DIALOG_报名信息收集":{
            "zh":"报名信息收集",  
            "en":"Collect Custom Information"
        },
        "COLLECT_DIY_DIALOG_请输入问题标题":{
            "zh":"请输入问题标题",  
            "en":"Please enter the title for your question"
        },
        "COLLECT_DIY_DIALOG_请输入答案种类":{
            "zh":"请输入答案种类",  
            "en":"Please select the type of answer for this question"
        },
        "COLLECT_DIY_DIALOG_请输入同意书":{
            "zh":"请输入条款书",  
            "en":"Please enter waiver content"
        },
        "COLLECT_DIY_DIALOG_请选择展现形式":{
            "zh":"请选择展现形式",  
            "en":"Please select the type of multiple choice"
        },
        "COLLECT_DIY_必须勾选此选项":{
            "zh":"必须勾选此选项",  
            "en":"This option must be selected"
        },
        "COLLECT_DIY_DIALOG_请输入至少一个答案":{
            "zh":"请输入至少一个答案",  
            "en":"Please enter at least one answer"
        },
        "COLLECT_EDIT_请输入正确的总票数":{
            "zh":"请输入正确格式的总票数",  
            "en":"Please enter correct format for the Total Quantity"
        },
        "COLLECT_EDIT_最小张数不能大于总票数":{
            "zh":"最少张数不能大于总票数",  
            "en":"The Minimum Per Order can not be greater than the Total Quantity"
        },
        "COLLECT_EDIT_最大张数不能大于最小张数":{
            "zh":"最多张数不能小于最少张数",  
            "en":"The Maximum Per Order can not be less than the Minimum Per Order"
        },
        "COLLECT_EDIT_请输入渠道码":{
            "zh":"请输入渠道码",  
            "en":"Please enter referral code"
        },
        "COLLECT_EDIT_渠道码应至少为六位的数字字母组合":{
            "zh":"渠道码应为至少六位的数字字母组合",  
            "en":"The referral code can be letter or digit, at least 6 characters"
        },
        "COLLECT_EDIT_请输入渠道码名称":{
            "zh":"请输入渠道码名称",  
            "en":"Please enter referral code name"
        },
        "COLLECT_EDIT_不能存在两个相同的渠道码":{
            "zh":"不能存在两个相同的渠道码",
            "en":"Referral code must be unique"
        },
        "COLLECT_EDIT_请至少选择一种支付方式":{
            "zh":"请至少选择一种支付方式",  
            "en":"Please select at least one payment method"
        },
        "COLLECT_APPROVAL_OPERATION_DIALOG_操作":{
            "zh":"操作",
            "en":"Operation"
        },
        "COLLECT_APPROVAL_OPERATION_DIALOG_操作成功":{
            "zh":"操作成功",
            "en":"Operation Succeed"
        },
        "COLLECT_APPROVAL_OPERATION_DIALOG_操作失败":{
            "zh":"操作失败",
            "en":"Operation Failed"
        },
        "COLLECT_APPROVAL_OPERATION_DIALOG_详细信息":{
            "zh":"详细信息",
            "en":"Detailed information"
        },
        "COLLECT_DETAIL_LABEL_TEXT_搜索灰字":{
            "zh":"姓名、公司、职务、邮箱、手机等",
            "en":"Name, Company, Position, Email, Mobile and etc."
        },
        "COLLECT_CALENDAR_PROMPT_至少选择一个":{
            "zh":"请至少选择一个主办方",
            "en":"Please select at least one host"
        },
        "COLLECT_CALENDAR_PROMPT_请输入搜索内容":{
            "zh":"请输入主办方姓名或公司组织名称",
            "en":"Please enter host's name or the company/organization name."
        },
        "COLLECT_CALENDAR_TEXT_搜索灰字":{
            "zh":"主办者姓名或公司/组织名称",
            "en":"Host's name or the company/organization name"
        },
        "CALENDAR_TEXT_更多":{
            "zh":"更多>>",
            "en":"View More"
        },
        "CALENDAR_TEXT_详情":{
            "zh":"详情>>",
            "en":"Detail>>"
        },
        /* PAYMENT 模块 */
        "PAYMENT_PAY_门票":{
            "zh":"门票",
            "en":"Ticket"
        },
        "PAYMENT_PAY_参加人":{
            "zh":"参加人",
            "en":"Attendee"
        },
        "PAYMENT_PAY_已完成支付":{
            "zh":"已完成支付",
            "en":"Payment complete"
        },
        "PAYMENT_PAY_以下门票信息相同":{
            "zh":"以下门票信息相同",
            "en":"Apply attendee information to all tickets below"
        },
        "PAYMENT_PAY_请填写捐款金额":{
            "zh":"请填写捐款金额",
            "en":"Please enter donation amount"
        },
        "PAYMENT_PAY_捐款金额必须为数字":{
            "zh":"捐款金额必须为数字",
            "en":"Please enter a number"
        },
        "PAYMENT_PAY_捐款金额最少为X元":{
            "zh":"捐款金额最少为{0}元",
            "en":"The minimum amount Is {0}"
        },
        "PAYMENT_PAY_给收款人留言...":{
            "zh":"请补充您需要对方知道的任何信息...",
            "en":"Please enter any additional information..."
        },
        "PAYMENT_PAY_给发起人留言...":{
            "zh":"请补充您需要对方知道的任何信息...",
            "en":"Please enter any additional information..."
        },
        "PAYMENT_GATEWAY_请输入支付宝账号登录":{
            "zh":"请输入支付宝账号登录",
            "en":"Please enter your Alipay account ID"
        },      
        "PAYMENT_GATEWAY_请输入PALPAY账号登录":{
            "zh":"请输入Paypal账号登录",
            "en":"Please enter your Paypal account ID"
        },
        "PAYMENT_GATEWAY_请选择支付方式":{
            "zh":"请选择支付方式",
            "en":"Please select a payment option"
        },
        "PAYMENT_PAY_支付":{
            "zh":"支付",
            "en":"Payment"
        },
        "PAYMENT_GATEWAY_请输入卡号":{
            "zh":"请输入卡号",
            "en":"Please enter the card number"
        },  
        "PAYMENT_GATEWAY_请输入有效期":{
            "zh":"请输入有效期",
            "en":"Please enter the expiration date"
        }, 
        "PAYMENT_GATEWAY_请输入验证码":{
            "zh":"请输入验证码",
            "en":"Please enter the verification codes"
        },
        "PAYMENT_GATEWAY_请输入姓名":{
            "zh":"请输入姓名",
            "en":"Please enter the name"
        },
        
        "PAYMENT_GATEWAY_请输入地址":{
            "zh":"请输入地址",
            "en":"Please enter the address"
        },
        "PAYMENT_GATEWAY_请输入邮编":{
            "zh":"请输入邮编",
            "en":"Please enter the postal codes"
        },
        "PAYMENT_GATEWAY_请输入国家":{
            "zh":"请输入国家",
            "en":"Plesae enter the country"
        },
        "PAYMENT_GATEWAY_请输入城市":{
            "zh":"请输入城市",
            "en":"Plesae enter the city"
        },
        "PAYMENT_GATEWAY_请输入州/省":{
            "zh":"请输入州/省",
            "en":"Please enter the State/Province"
        },
        "PAYMENT_GATEWAY_请选择银行":{
            "zh":"请选择银行",
            "en":"Plese select the bank"
        },
        "PAYMENT_PAY_请选择数量":{
            "zh":"请选择数量",
            "en":"Please select quantity"
        },
        "PAYMENT_PAY_审批票与非审批票不能同时购买":{
            "zh":"请单独订购需主办方审批的门票",
            "en":"Ticket that require host's approval must be ordered seperately"
        },
        "PAYMENT_PAY_请勾选同意条款":{
            "zh":"请勾选同意条款",
            "en":"eng请勾选同意条款"
        },
        
        "PAYMENT_PAY_请填写姓名":{
            "zh":"请填写您的姓名",
            "en":"Please enter your name"
        }, 
        "PAYMENT_PAY_请填写手机号码":{
            "zh":"请填写您的手机号码",
            "en":"Please enter your mobile phone number"
        },
        "PAYMENT_PAY_请填写职位":{
            "zh":"请填写您在公司/组织的职务",
            "en":"Please enter your position at your company/organization"
        },
        "PAYMENT_PAY_请填写您所在公司/组织的名称":{
            "zh":"请填写您公司/组织的名称",
            "en":"Please enter the name of your company/organization"
        },
        "PAYMENT_PAY_请填写您的邮箱":{
            "zh":"请填写您的邮箱",
            "en":"Please enter your email adresses"
        },
        "PAYMENT_PAY_请输入发票抬头":{
            "zh":"请输入发票抬头",
            "en":"Please enter the title of the invoice"
        },
        "PAYMENT_PAY_请输入收件人姓名":{
            "zh":"请输入收件人姓名",
            "en":"Please enter the name of the recipent"
        },
        "PAYMENT_PAY_请输入地址":{
            "zh":"请输入邮寄地址",
            "en":"Please the mailing address"
        },
        "PAYMENT_PAY_请输入电话号码":{
            "zh":"请输入收件人电话号码",
            "en":"Please enter the recipient's phone number"
        },
        "PAYMENT_PAY_请输入省市":{
            "zh":"请输入城市名称",
            "en":"Please enter the names of the city"
        },
        "PAYMENT_PAY_请输入邮编":{
            "zh":"请输入邮编",
            "en":"Please enter the postal code"
        },
        "PAYMENT_PAY_请填写必填项":{
            "zh":"请填写必填项",
            "en":"Please enter the required field"
        },
        "PAYMENT_WIDGET_复制成功":{
            "zh":"复制成功",
            "en":"Copy success"
        },
        "PAYMENT_GATEWAY_请输入银行卡号":{
            "zh":"请填写汇款所用银行账号/卡号",
            "en":"Please enter bank account or card number"
        },
        "PAYMENT_GATEWAY_请输入银行卡持有者姓名":{
            "zh":"请填写银行账户名称",
            "en":"Please enter the acount name"
        },
        "PAYMENT_GATEWAY_请输入银行名称":{
            "zh":"请填写开户银行名称",
            "en":"Please enter the bank name"
        },
        "PAYMENT_GATEWAY_请输入联系电话":{
            "zh":"请输入您的联系电话",
            "en":"Please enter your phone number"
        },
        "PAYMENT_EDIT_付款":{
            "zh":"付款",
            "en":"Pay"
        },
        "PAYMENT_EDIT_报名":{
            "zh":"报名",
            "en":"Register"
        },
        "PAYMENT_EDIT_请选择":{
            "zh":"请选择...",
            "en":"Please select..."
        },
        "PAYMENT_EDIT_针对所有票价":{
            "zh":"针对所有价格",
            "en":"Apply to all prices"
        },
        "PAYMENT_EDIT_针对以下票价优惠":{
            "zh":"针对： ",
            "en":"Apply to:"
        },
        /* TRANSFER 模块 */
        "TRANSFER_PAY_请选择转款方式....":{
            "zh":"请选择转款方式....",
            "en":"Please select the transfer method..."
        },
        "TRANSFER_PAY_请选择支付网关....":{
            "zh":"请选择支付方式...",
            "en":"Please select the payment method.."
        },
        "TRANSFER_PAY_请输入收款人姓名":{
            "zh":"请输入收款人姓名",
            "en":"Please enter recipient's name"
        },
        "TRANSFER_PAY_请输入收款人邮件地址":{
            "zh":"请输入收款人邮件地址",
            "en":"Please enter recipient's Email address"
        },
        "TRANSFER_PAY_请输入合法的邮件地址":{
            "zh":"请输入合法的邮件地址",
            "en":"Please enter a valid email address"
        },
        "TRANSFER_PAY_请输入转款金额":{
            "zh":"请输入转款金额",
            "en":"Please enter the amount"
        },
        "TRANSFER_PAY_请输入合法的金额":{
            "zh":"请输入合法的金额",
            "en":"Please enter a valid amount"
        },
        "TRANSFER_PAY_最低转款金额为X元":{
            "zh":"最低转款金额为{0}元",
            "en":"The minimum transfer amount is {0}"
        },
        "TRANSFER_PAY_请输入转款事由":{
            "zh":"请输入转款事由",
            "en":"Please enter a reason"
        }, 
        "LINK_TRANSFER_PAY_请输入金额":{
            "zh":"请输入金额",
            "en":"Please enter the amount"
        },
        "LINK_TRANSFER_PAY_请输入事由":{
            "zh":"请输入事由",
            "en":"Please enter a reason"
        }, 
        /* WITHDROW 模块 */
        "WITHDRAW_请输入提款金额":{
            "zh":"请输入提款金额",
            "en":"Please enter withdraw amount"
        },
        "WITHDRAW_金额必须为数字":{
            "zh":"金额必须为数字",
            "en":"The amount must be a number"
        },
        "WITHDRAW_小数点后最多保留两位":{
            "zh":"小数点后最多保留两位",
            "en":"Maximum 2 digits after the decimal point"
        },
        "WITHDRAW_请给这个账户加个标签":{
            "zh":"请给这个账户加个标签...",
            "en":"Please add a label for this account"
        },
        "WITHDRAW_请输入账户名称":{//账户标签 别名
            "zh":"请给这个账户加个标签",
            "en":"Please add a label for this account"
        },
        "WITHDRAW_请输入您的姓名":{
            "zh":"请输入开户人名称",
            "en":"Please enter the Account Holder Name"
        },
        "WITHDRAW_请输入卡号":{
            "zh":"请输入卡号",
            "en":"Please enter the Card Number"
        },
        "WITHDRAW_请输入支付宝账户":{
            "zh":"请输入支付宝账号",
            "en":"Please enter the Alipay Account ID"
        },
        "WITHDRAW_请输入PALPAY账号":{
            "zh":"请输入PALPAY账号",
            "en":"Please enter the Paypal Account ID"
        },
        "WITHDRAW_请输入银行名称":{
            "zh":"请输入银行名称",
            "en":"Please enter the Bank Name"
        },
        "WITHDRAW_请输入支行名称":{
            "zh":"请输入支行名称",
            "en":"Please enter the Branch Name"
        },
        "WITHDRAW_请输入银行卡号":{
            "zh":"请输入银行卡号",
            "en":"Please enter the Account Number"
        },
        "WITHDRAW_请输入INT账户名称":{
            "zh":"请输入开户人名称",
            "en":"Please enter the Account Holder Name"
        },
        "WITHDRAW_请输入INT开户人地址":{
            "zh":"请输入开户人地址",
            "en":"Please enter the Account Holder Address"
        },
        "WITHDRAW_请输入INT开户行":{
            "zh":"请输入开户行名称",
            "en":"Please enter the Bank Name"
        },
        "WITHDRAW_请输入INT账户号码":{
            "zh":"请输入账户号码",
            "en":"Please enter the Account Number"
        },
        "WITHDRAW_请输入INT开户行地址":{
            "zh":"请输入开户行地址",
            "en":"Please enter the Bank Address"
        },
        "WITHDRAW_请输入INTTransit Number":{
            "zh":"请输入 Transit Number 或者 Wire Routing Number",
            "en":"Please enter the Transit Number or Wire Routing Number"
        },
        "WITHDRAW_请输入INTSWIFT code":{
            "zh":"请输入 SWIFT Code",
            "en":"Please enter the SWIFT Code"
        },
        "WITHDRAW_CREDIT_CARD_请输入开户银行名称":{
            "zh":"请输入开户银行名称",
            "en":"Please enter the Bank Name"
        },
        "WITHDRAW_CREDIT_CARD_请输入支行名称":{
            "zh":"请输入支行名称",
            "en":"Please enter the Branch Name"
        },
        "WITHDRAW_必填项目不能为空":{
            "zh":"必填项目不能为空",
            "en":"Please fill in the required fields"
        },
        "WITHDRAW_确定要删除？":{
            "zh":"确定要删除？",
            "en":"Are you sure to delete this?"
        },
        "WITHDRAW_选择账户名称":{
            "zh":"请选择提款账户",
            "en":"Please select account"
        },
        
        /* HISTORY 模块 */
        /*CLEDIT 插件*/
        "BLOB":{
            "zh":"粗体",
            "en":"Blob"
        },
        "ITALIC":{
            "zh":"斜体",
            "en":"Italic"
        },
        "UNDERLINE":{
            "zh":"下划线",
            "en":"Underline"
        },
        "FONT":{
            "zh":"字体",
            "en":"Font"
        },
        "FONT_SIZE":{
            "zh":"字号",
            "en":"Font Size"
        },
        "STYLE":{
            "zh":"样式",
            "en":"Style"
        },
        "FONT_COLOR":{
            "zh":"字体颜色",
            "en":"Font Color"
        },
        "TEXT_HIGHLIGHT_COLOR":{
            "zh":"字体背景色",
            "en":"Text Highlight Color"
        },
        "BULLETS":{
            "zh":"段落",
            "en":"Bullets"
        },
        "NUMBERING":{
            "zh":"数字",
            "en":"Numbering"
        },
        "ALIGN_TEXT_LEFT":{
            "zh":"左对齐",
            "en":"Align Text Left"
        },
        "ALIGN_TEXT_CENTER":{
            "zh":"居中",
            "en":"Center"
        },
        "ALIGN_TEXT_Right":{
            "zh":"右对齐",
            "en":"Align Text Right"
        },
        "JUSTIFY":{
            "zh":"两边对齐",
            "en":"Justify"
        },
        "INSERT_HYPERLINK":{
            "zh":"插入链接",
            "en":"Insert Hyperlink"
        },
        "REMOVE_HYPERLINK":{
            "zh":"删除链接",
            "en":"Remove Hyperlink"
        },
        "请先选中需要添加链接的字段":{
            "zh":"请先选中需要添加链接的字段",
            "en":"A selection is required when inserting a link"
        },
        "ENTER_URL":{
            "zh":"输入URL",
            "en":"Enter URL"
        },
        "SUBMIT":{
            "zh":"确定",
            "en":"Submit"
        },
        "SHOW_SOURCE":{
            "zh":"源码",
            "en":"Show Source"
        },
        "ADDFUND_DIALOG_标题":{
            "zh":"充值",
            "en":"Add Fund"
        },
        /* 其他模块*/
        "HAHAHAHAHA_ZZZZZZ":{
            "zh":"没有用，占位置的",
            "en":"HAAHAHHAHA"
        }
    }
}
