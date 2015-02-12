var CBRAValid = {
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
    checkFormValueMobile : function(ele) {
        var mobileRegex = /^((\+86)|(86))?(1)\d{10}$/i;
        return mobileRegex.test($.trim(ele.val()));
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

var CBRAMessage = {
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

var CBRAElement = {
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