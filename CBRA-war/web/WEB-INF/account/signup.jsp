<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html>
    <head>
        <jsp:include page="/WEB-INF/public/z_header.jsp"/>
        <style>
            .new-contentarea {
                width: 100%;
                overflow:hidden;
                margin: 0 auto;
                position:relative;
            }
            .new-contentarea label {
                width:100%;
                height:100%;
                display:block;
            }
            .new-contentarea input[type=file] {
                width:98px;
                height:26px;
                background:#333;
                margin: 0 auto;
                position:absolute;
                right:50%;
                margin-right:-94px;
                top:0;
                right/*\**/:0px\9;
                margin-right/*\**/:0px\9;
                width/*\**/:10px\9;
                opacity:0;
                filter:alpha(opacity=0);
                z-index:2;
            }
            a.upload-img{
                width:98px;
                display: inline-block;
                margin-bottom: 10px;
                height:26px;
                line-height: 26px;
                font-size: 13px;
                color: #FFFFFF;
                background-color: #bbbbbb;
                border-radius: 3px;
                text-decoration:none;
                cursor:pointer;
            }
            a.upload-img:hover{
                background-color: #52853d;
            }

            .tc{text-align:center;}
        </style>
    </head>
    <body>
        <jsp:include page="/WEB-INF/public/z_top.jsp"></jsp:include>
        <jsp:include page="/WEB-INF/public/z_banner.jsp"/>
        <!-- 主体 -->
        <div class="ind-reg">
            <!-- 标题 -->
            <form id="reg_form" method="post" action="/account/signup">
                <input type="hidden" name="a" value="SIGNUP" />
                <input id="front_hidden" type="hidden" name="front" value="" />
                <input id="back_hidden" type="hidden" name="back" value="" />
                <div class="Title"><a href="/account/signup" id="ind-reg-b"><fmt:message key="GLOBAL_个人入会申请" bundle="${bundle}"/></a><a href="/account/signup_c"><fmt:message key="GLOBAL_企业入会申请" bundle="${bundle}"/></a></div>
                <div id="step1">
                    <div class="Title-reg"><fmt:message key="GLOBAL_基本信息" bundle="${bundle}"/><a style=" margin-left:10px; font-size:12px; color:#e8a29a; font-weight:normal;">(<fmt:message key="GLOBAL_*为必填项" bundle="${bundle}"/>)</a></div>
                    <table width="914" border="0" align="center" style="margin:0 auto; border-bottom:2px #dddddd solid; padding-bottom:20px;">
                        <tr>
                            <td class="reg-1"><b style="color:#e8a29a;">*</b><fmt:message key="GLOBAL_中文姓名" bundle="${bundle}"/></td>
                            <td class="reg-2"><input type="text" name="accountName" id="accountName" value="${userAccount.name}" class="Input-1" /></td>
                            <td class="reg-1"><fmt:message key="GLOBAL_英文姓名" bundle="${bundle}"/></td>
                            <td><input type="text" name="accountEnName" id="accountEnName" value="${userAccount.enName}" class="Input-1" /></td>
                        </tr>
                        <tr>
                            <td class="reg-1"><b style="color:#e8a29a;">*</b><fmt:message key="GLOBAL_手机" bundle="${bundle}"/>
                            </td>
                            <td class="reg-2" style="line-height:10px;height: 63px;"><input type="text" name="account" value="${userAccount.account}" id="account" class="Input-1" /><br/><br/><span style="font-size:11px"><fmt:message key="GLOBAL_作为账户登录，请使用有效号码" bundle="${bundle}"/></span></td>
                            <td class="reg-1"><b style="color:#e8a29a;">*</b>EMAIL</td>
                            <td style="line-height:10px;height: 63px;">
                                <input type="text" name="email" id="email" value="${userAccount.email}" class="Input-1" /><br/><br/><span style="font-size:11px"><fmt:message key="GLOBAL_邮箱作为接收筑誉活动渠道，请填写常用邮箱" bundle="${bundle}"/></span></td>
                        </tr>
                        <tr>
                            <td class="reg-1"><b style="color:#e8a29a;">*</b><fmt:message key="GLOBAL_从业年限" bundle="${bundle}"/></td>
                            <td class="reg-2"><input type="text" name="workingYear" value="${userAccount.workingYear}" id="workingYear" class="Input-1" />（<fmt:message key="GLOBAL_年" bundle="${bundle}"/>）</td>
                            <td class="reg-1"><fmt:message key="GLOBAL_目前就职公司" bundle="${bundle}"/></td>
                            <td><input type="text" name="company" value="${userAccount.company}" id="company" class="Input-1" /></td>
                        </tr>
                        <tr>
                            <td class="reg-1"><b style="color:#e8a29a;">*</b><fmt:message key="GLOBAL_邮寄地址" bundle="${bundle}"/></td>
                            <td class="reg-2"><input type="text" name="address" value="${userAccount.address}" id="address" class="Input-1" /></td>
                            <td class="reg-1"><b style="color:#e8a29a;">*</b><fmt:message key="GLOBAL_邮编" bundle="${bundle}"/></td>
                            <td><input type="text" name="zipCode" id="zipCode" value="${userAccount.zipCode}" class="Input-1" /></td>
                        </tr>
                        <tr>
                            <td class="reg-1"><b style="color:#e8a29a;">*</b><fmt:message key="GLOBAL_职务" bundle="${bundle}"/></td>
                            <td class="reg-2" style="line-height: 22px;">
                                <span style="padding-right: 15px;">
                                    <select id="position" name="position" class="Input-1">
                                        <option value=""><fmt:message key="GLOBAL_请选择" bundle="${bundle}"/></option>
                                        <c:forEach var="position" items="${positions}">
                                            <option <c:if test="${position == userAccount.position}">selected="selected"</c:if> value="${position.name()}">${position.getMean(bundle.resourceBundle)}</option>
                                        </c:forEach>
                                        <option <c:if test="${not empty userAccount.positionOthers}">selected="selected"</c:if> value="others"><fmt:message key="GLOBAL_其他" bundle="${bundle}"/></option>
                                        </select>
                                    </span>   
                                </td>
                                <td class="reg-1" id="others_td_1" style="<c:if test="${empty userAccount.positionOthers}">display: none</c:if>"><fmt:message key="GLOBAL_其他" bundle="${bundle}"/></td>
                            <td id="others_td_2" style="<c:if test="${empty userAccount.positionOthers}">display: none</c:if>"><input type="text" name="others" id="others"  value="${userAccount.positionOthers}" class="Input-1"/></td>
                            </tr>
                            <tr>
                                <td class="reg-1"><fmt:message key="GLOBAL_产业链位置" bundle="${bundle}"/></td>
                                <td class="reg-2" colspan="3" style="line-height: 22px;">
                                <c:forEach var="icPosition" items="${icPositions}">
                                    <input <c:if test="${positionList.contains(icPosition.key)}">checked="checked"</c:if> type="checkbox" name="icPositions" value="${icPosition.key}" /><fmt:message key="${icPosition.name}" bundle="${bundle}"/>&nbsp&nbsp&nbsp&nbsp
                                </c:forEach>
                            </td>
                        </tr>
                    </table>
                    <table width="914" border="0" style="margin:20px auto; padding-bottom:20px;">
                        <tr>
                            <td style="width: 350px;" align="right">
                                <div align="center" id="signup_msg_1" style="width: 120px;" class="wrongMessage"><c:if test="${not empty postResult.singleErrorMsg}">${postResult.singleErrorMsg}</c:if></div>
                                </td>
                                <td align="center" >
                                    <input id="step1_next" type="button" style=" width:130px; height:42px; background:#52853d; color:#FFF; border:0; border-radius:5px; font-size:14px; cursor:pointer;" value="<fmt:message key="GLOBAL_下一步" bundle="${bundle}"/>" />
                                </td>
                                <td style="width: 350px;">
                                </td>
                            </tr>
                        </table>
                    </div>
                    <input type="hidden" id="workExperience_hidden" name="workExperience" value="" />
                    <input type="hidden" id="projectExperience_hidden" name="projectExperience" value="" />
                </form>
                <div id="step2" style="display: none">
                    <div class="Title-reg"><fmt:message key="GLOBAL_实名认证" bundle="${bundle}"/></div>
                    <table width="914" border="0" style="margin:0 auto; border-bottom:2px #dddddd solid; padding-bottom:20px;">
                        <tr>
                        <form id="reg_front_form" method="post" enctype="multipart/form-data" target="iframe1" action="/account/z_iframe_upload_pc?type=front">
                            <input type="hidden" name="a" value="upload_person_card" />
                            <td align="center" style="width:457px;">
                                <div class="reg-img">
                                    <div id="reg_front_div">
                                        <br><br><br><p><fmt:message key="GLOBAL_上传身份证正面" bundle="${bundle}"/></p><p><fmt:message key="GLOBAL_上传图片大小不得超过2MB支持JPG/PNG图片格式" bundle="${bundle}"/></p>
                                    </div>
                                    <img id="reg_front_img" src="" width="300" height="190" style="display: none" />
                                    <div class="new-contentarea tc">
                                        <a href="javascript:void(0)" class="upload-img"><label for="reg_front"><fmt:message key="GLOBAL_选择图片路径" bundle="${bundle}"/></label></a>
                                        <input id="reg_front" type="file" class="" name="reg_front_file" onchange="document.getElementById('reg_front_result').innerHTML = this.value;checkImgType(this);" />
                                    </div>
                                    <p id="reg_front_result"></p>
                                </div>
                                <input id="reg_front_submit" type="button" style=" width:110px; height:32px; background:#52853d; color:#FFF; border:0; border-radius:5px; cursor:pointer;" value="<fmt:message key="GLOBAL_上传图片" bundle="${bundle}"/>">
                            </td>
                        </form>
                        <form id="reg_back_form" method="post" enctype="multipart/form-data" target="iframe1" action="/account/z_iframe_upload_pc?type=back">
                            <input type="hidden" name="a" value="upload_person_card"  />
                            <td id="reg_back_td" align="center" style="width:457px;">
                                <div class="reg-img">
                                    <div id="reg_back_div">
                                        <br><br><br><p><fmt:message key="GLOBAL_上传身份证背面" bundle="${bundle}"/></p><p><fmt:message key="GLOBAL_上传图片大小不得超过2MB支持JPG/PNG图片格式" bundle="${bundle}"/></p>
                                    </div>
                                    <img id="reg_back_img" src="" width="300" height="190" style="display: none" />
                                    <div class="new-contentarea tc">
                                        <a href="javascript:void(0)" class="upload-img"><label for="reg_back"><fmt:message key="GLOBAL_选择图片路径" bundle="${bundle}"/></label></a>
                                        <input id="reg_back" type="file" class="" name="reg_back_file" onchange="document.getElementById('reg_back_result').innerHTML = this.value;checkImgType(this);" />
                                    </div>
                                    <p id="reg_back_result"></p>
                                </div>
                                <input id="reg_back_submit" type="button" style=" width:110px; height:32px; background:#52853d; color:#FFF; border:0; border-radius:5px; cursor:pointer;" value="<fmt:message key="上传图片" bundle="${bundle}"/>">
                            </td>
                        </form>
                        </tr>
                    </table>
                    <table width="914" border="0" style="margin:20px auto; padding-bottom:20px;">
                        <tr>
                            <td style="width: 300px;" align="right">
                                <div align="center" id="signup_msg_2" style="width: 120px;" class="wrongMessage"><c:if test="${not empty postResult.singleErrorMsg}">${postResult.singleErrorMsg}</c:if></div>
                            </td>
                            <td align="center" >
                                <input id="step2_before" type="button" style=" width:130px; height:42px; background:#52853d; color:#FFF; border:0; border-radius:5px; font-size:14px; cursor:pointer;" value="<fmt:message key="GLOBAL_上一步" bundle="${bundle}"/>" />&nbsp&nbsp
                                <input id="step2_next" type="button" style=" width:130px; height:42px; background:#52853d; color:#FFF; border:0; border-radius:5px; font-size:14px; cursor:pointer;" value="<fmt:message key="GLOBAL_下一步" bundle="${bundle}"/>" />
                            </td>
                            <td style="width: 300px;">
                            </td>
                        </tr>
                    </table>
                </div>
                <div id="step3" style="display: none">
                    <div class="Title-reg"><fmt:message key="GLOBAL_工作履历" bundle="${bundle}"/></div>

                    <table width="914" border="0" style="margin:0 auto; border-bottom:2px #dddddd solid; padding-bottom:20px;">
                        <tr>
                            <td align="center" ><textarea id="workExperience" style="width:910px; height:150px; border:1px #e6e6e6 solid;">${userAccount.workExperience}</textarea></td>
                    </tr>
                </table>
                <table width="914" border="0" style="margin:20px auto; padding-bottom:20px;">
                    <tr>
                        <td style="width: 300px;" align="right">
                            <div align="center" id="signup_msg_3" style="width: 120px;" class="wrongMessage"><c:if test="${not empty postResult.singleErrorMsg}">${postResult.singleErrorMsg}</c:if></div>
                            </td>
                            <td align="center" >
                                <input id="step3_before" type="button" style=" width:130px; height:42px; background:#52853d; color:#FFF; border:0; border-radius:5px; font-size:14px; cursor:pointer;" value="<fmt:message key="GLOBAL_上一步" bundle="${bundle}"/>" />&nbsp&nbsp
                                <input id="step3_next" type="button" style=" width:130px; height:42px; background:#52853d; color:#FFF; border:0; border-radius:5px; font-size:14px; cursor:pointer;" value="<fmt:message key="GLOBAL_下一步" bundle="${bundle}"/>" />
                            </td>
                            <td style="width: 300px;">
                            </td>
                        </tr>
                    </table>
                </div>
                <div id="step4" style="display: none">
                    <div class="Title-reg"><fmt:message key="GLOBAL_项目经验" bundle="${bundle}"/></div>
                    <table width="914" border="0" style="margin:0 auto; border-bottom:2px #dddddd solid; padding-bottom:20px;">
                        <tr>
                            <td align="center" ><textarea id="projectExperience" style="width:910px; height:150px; border:1px #e6e6e6 solid;">${userAccount.projectExperience}</textarea></td>
                    </tr>
                </table>
                <table width="914" border="0" style="margin:20px auto; padding-bottom:20px;">
                    <tr>
                        <td style="width: 300px;" align="right">
                            <div align="center" id="signup_msg_4" style="width: 120px;" class="wrongMessage"><c:if test="${not empty postResult.singleErrorMsg}">${postResult.singleErrorMsg}</c:if></div>
                            </td>
                            <td align="center" >
                                <input id="step4_before" type="button" style=" width:130px; height:42px; background:#52853d; color:#FFF; border:0; border-radius:5px; font-size:14px; cursor:pointer;" value="<fmt:message key="GLOBAL_上一步" bundle="${bundle}"/>" />&nbsp&nbsp
                                <input id="step4_next" type="button" style=" width:130px; height:42px; background:#52853d; color:#FFF; border:0; border-radius:5px; font-size:14px; cursor:pointer;" value="提 交" />
                            </td>
                            <td style="width: 300px;">
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <iframe id="iframe1" name="iframe1" style="display:none;"></iframe>
            <!-- 主体 end -->
        <jsp:include page="/WEB-INF/public/z_end.jsp"/>
        <script type="text/javascript">
            $(document).ready(function () {
                $("#position").change(function () {
                    if ($("#position").val() == 'others') {
                        $("#others_td_1").show();
                        $("#others_td_2").show();
                    } else {
                        $("#others_td_1").hide();
                        $("#others_td_2").hide();
                    }
                });
                $.ajaxSetup({//ie中防止加载缓存中内容
                    cache: false
                });
                $("#step1_next").click(function () {
                    $("#signup_msg_3").html("");
                    if (CBRAValid.checkFormValueNull($("#accountName"))) {
                        CBRAMessage.showWrongMessageAndBorderEle($("#signup_msg_1"), "<fmt:message key="GLOBAL_请输入中文姓名" bundle="${bundle}"/>", $("#accountName"));
                        return;
                    }
                    if (!CBRAValid.checkFormValueMobile($("#account"))) {
                        CBRAMessage.showWrongMessageAndBorderEle($("#signup_msg_1"), "<fmt:message key="GLOBAL_请输入合法手机" bundle="${bundle}"/>", $("#account"));
                        return;
                    }
                    //发送ajax
                    $.post("/account/signup", {
                        a: "ACCOUNT_IS_EXIST",
                        account: $("#account").val()
                    }, function (json) {
                        if (!json.success) {
                            CBRAMessage.showWrongMessageAndBorderEle($("#signup_msg_1"), json.singleErrorMsg, $("#account"));
                        }
                        else {
                            //call back
                            if (!CBRAValid.checkFormValueEmail($("#email"))) {
                                CBRAMessage.showWrongMessageAndBorderEle($("#signup_msg_1"), "<fmt:message key="GLOBAL_请输入合法邮件" bundle="${bundle}"/>", $("#email"));
                                return;
                            }
                            if (CBRAValid.checkFormValueNull($("#workingYear"))) {
                                CBRAMessage.showWrongMessageAndBorderEle($("#signup_msg_1"), "<fmt:message key="GLOBAL_请输入从业年限" bundle="${bundle}"/>", $("#workingYear"));
                                return;
                            }
                            if (isNaN($('#workingYear').val())) {
                                CBRAMessage.showWrongMessageAndBorderEle($("#signup_msg_1"), "<fmt:message key="GLOBAL_从业年限必须是数字" bundle="${bundle}"/>", $("#workingYear"));
                                return;
                            }
                            if (CBRAValid.checkFormValueNull($("#address"))) {
                                CBRAMessage.showWrongMessageAndBorderEle($("#signup_msg_1"), "<fmt:message key="GLOBAL_请输入邮寄地址" bundle="${bundle}"/>", $("#address"));
                                return;
                            }
                            if (CBRAValid.checkFormValueNull($("#zipCode"))) {
                                CBRAMessage.showWrongMessageAndBorderEle($("#signup_msg_1"), "<fmt:message key="GLOBAL_请输入邮编" bundle="${bundle}"/>", $("#zipCode"));
                                return;
                            }
                            if ($("#position").val() == '') {
                                CBRAMessage.showWrongMessageAndBorderEle($("#signup_msg_1"), "<fmt:message key="GLOBAL_请选择职务" bundle="${bundle}"/>", $("#position"));
                                return;
                            }
                            if ($("#position").val() == 'others' && CBRAValid.checkFormValueNull($("#others"))) {
                                CBRAMessage.showWrongMessageAndBorderEle($("#signup_msg_1"), "<fmt:message key="GLOBAL_请输入其他职务" bundle="${bundle}"/>", $("#others"));
                                return;
                            }
                            $("#step1").hide();
                            $("#step2").show();
                            $("#signup_msg_1").html("");
                        }
                    }, "json");
                });
                $("#step2_next").click(function () {
                    $("#signup_msg_3").html("");
                    if ($("#front_hidden").val() == "" || $("#back_hidden").val() == "") {
                        CBRAMessage.showMessage($("#signup_msg_2"), "<fmt:message key="GLOBAL_请上传文件" bundle="${bundle}"/>");
                        return;
                    }
                    $("#step2").hide();
                    $("#step3").show();
                    $("#signup_msg_2").html("");
                });
                $("#step3_next").click(function () {
                    $("#signup_msg_3").html("");
                    if ($.trim($("#workExperience").val()) == "") {
                        CBRAMessage.showMessage($("#signup_msg_3"), "<fmt:message key="GLOBAL_请输入内容" bundle="${bundle}"/>");
                        return;
                    }
                    $("#step3").hide();
                    $("#step4").show();
                    $("#signup_msg_3").html("");
                });
                $("#step4_next").click(function () {
                    $("#signup_msg_3").html("");
                    if ($.trim($("#projectExperience").val()) == "") {
                        CBRAMessage.showMessage($("#signup_msg_4"), "<fmt:message key="GLOBAL_请输入内容" bundle="${bundle}"/>");
                        return;
                    }
                    $("#workExperience_hidden").val($("#workExperience").val());
                    $("#projectExperience_hidden").val($("#projectExperience").val());
                    //submit
                    $("#reg_form").submit();
                });
                $("#step2_before").click(function () {
                    $("#step2").hide();
                    $("#step1").show();
                });
                $("#step3_before").click(function () {
                    $("#step3").hide();
                    $("#step2").show();
                });
                $("#step4_before").click(function () {
                    $("#step4").hide();
                    $("#step3").show();
                });
                $("#reg_front_submit").click(function () {
                    $("#signup_msg_3").html("");
                    $("#signup_msg_2").html("");
                    if ($("#reg_front").val() == '') {
                        CBRAMessage.showWrongMessageAndBorderEle($("#signup_msg_2"), "<fmt:message key="GLOBAL_选择图片路径" bundle="${bundle}"/>", $("#reg_back"));
                        return;
                    }
                    $("#reg_front_form").submit();
                });
                $("#reg_back_submit").click(function () {
                    $("#signup_msg_3").html("");
                    $("#signup_msg_2").html("");
                    if ($("#reg_back").val() == '') {
                        CBRAMessage.showWrongMessageAndBorderEle($("#signup_msg_2"), "<fmt:message key="GLOBAL_选择图片路径" bundle="${bundle}"/>", $("#reg_back"));
                        return;
                    }
                    $("#reg_back_form").submit();
                });
            });
            function checkImgType(this_) {
                try {
                    var filepath = $(this_).val();
                    var file_size = 0;
                    if ($.support.msie) {
                        var img = new Image();
                        img.src = filepath;
                        if (img.fileSize > 0) {
                            if (img.fileSize > 5 * 1024) {
                                alert("<fmt:message key="GLOBAL_上传的文件大小不能超过5M" bundle="${bundle}"/>。");
                                $(this_).focus();
                                this_.select();
                                document.execCommand("delete");
                                return false;
                            }
                        }
                    } else {
                        file_size = this_.files[0].size;
                        var size = file_size / 1024 / 1024;
                        if (size > 5) {
                            alert("<fmt:message key="GLOBAL_上传的文件大小不能超过5M" bundle="${bundle}"/>");
                            $(this_).focus();
                            $(this_).val("");
                            return false;
                        }
                    }
                } catch (e) {
                }
                return true;
            }
        </script>
    </body>
</html>
