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
        <jsp:include page="/WEB-INF/public/z_top.jsp" />
        <jsp:include page="/WEB-INF/public/z_banner.jsp"/>
        <!-- 主体 -->
        <div class="ind-reg">
            <!-- 标题 -->
            <div class="Title"><a href="/account/signup"><fmt:message key="GLOBAL_个人入会申请" bundle="${bundle}"/></a><a href="/account/signup_c" id="ind-reg-b"><fmt:message key="GLOBAL_企业入会申请" bundle="${bundle}"/></a></div>
            <form id="reg_form" method="post" action="/account/signup_c">
                <input type="hidden" name="a" value="SIGNUP_C" />
                <input id="bl_hidden" type="hidden" name="bl" value="" />
                <input id="qc_hidden" type="hidden" name="qc" value="" />
                <div id="step1">
                    <div class="Title-reg"><fmt:message key="GLOBAL_基本信息" bundle="${bundle}"/><a style=" margin-left:10px; font-size:12px; color:#e8a29a; font-weight:normal;">(<fmt:message key="GLOBAL_*为必填项" bundle="${bundle}"/>)</a></div>
                    <table width="914" border="0" align="center" style="margin:0 auto; border-bottom:2px #dddddd solid; padding-bottom:20px;">
                        <tr>
                            <td class="reg-1"><fmt:message key="GLOBAL_企业全称" bundle="${bundle}"/><b style="color:#e8a29a;">*</b></td>
                            <td colspan="3" class="reg-2"><input type="text" class="Input-1" id="accountName" name="accountName" value="${companyAccount.name}" /></td>
                        </tr>
                        <tr>
                            <td class="reg-1"><fmt:message key="GLOBAL_营业执照注册号" bundle="${bundle}"/><b style="color:#e8a29a;">*</b></td>
                            <td class="reg-2" style="line-height:10px;height: 63px;"><input type="text" class="Input-1" id="account" name="account" value="${companyAccount.account}" /><br/><br/><span style="font-size:11px"><fmt:message key="GLOBAL_作为账户登录" bundle="${bundle}"/></span></td>
                            <td class="reg-1"><fmt:message key="GLOBAL_企业邮箱" bundle="${bundle}"/><b style="color:#e8a29a;">*</b></td>
                            <td style="line-height:10px;height: 63px;"><input type="text" class="Input-1" id="email" name="email" value="${companyAccount.email}" /><br/><br/><span style="font-size:11px"><fmt:message key="GLOBAL_邮箱作为接收筑誉活动渠道，请填写常用邮箱" bundle="${bundle}"/></span></td>
                        </tr>
                        <tr>
                            <td class="reg-1"><fmt:message key="GLOBAL_创立时间" bundle="${bundle}"/><b style="color:#e8a29a;">*</b></td>
                            <td class="reg-2"><input type="text" class="Input-1" id="companyCreateDate" name="companyCreateDate" onclick="WdatePicker({dateFmt: 'yyyy-MM-dd'})" value="<fmt:formatDate value='${companyAccount.companyCreateDate}' pattern='yyyy-MM-dd' type='date' dateStyle='long' />" /></td>
                            <td class="reg-1"><fmt:message key="GLOBAL_企业法人" bundle="${bundle}"/><b style="color:#e8a29a;">*</b></td>
                            <td><input type="text" class="Input-1" id="legalPerson" name="legalPerson" value="${companyAccount.legalPerson}" /></td>
                        </tr>
                        <tr>
                            <td class="reg-1"><fmt:message key="GLOBAL_企业性质" bundle="${bundle}"/><b style="color:#e8a29a;">*</b></td>
                            <td class="reg-2">
                                <select id="companyNature" name="companyNature" class="Input-1">
                                    <option value=""><fmt:message key="GLOBAL_请选择" bundle="${bundle}"/></option>
                                    <c:forEach var="companyNatureEnum" items="${companyNatureEnums}">
                                        <option <c:if test="${companyNatureEnum == companyAccount.nature}">selected="selected"</c:if>  value="${companyNatureEnum.name()}">${companyNatureEnum.getMean(bundle.resourceBundle)}</option>
                                    </c:forEach>
                                </select>
                            </td>
                            <td id="natureOthers_td_1" style="<c:if test="${empty companyAccount.natureOthers}">display: none</c:if>" class="reg-1"><fmt:message key="GLOBAL_其他" bundle="${bundle}"/></td>
                            <td id="natureOthers_td_2" style="<c:if test="${empty companyAccount.natureOthers}">display: none</c:if>">
                                <input type="text" class="Input-1" id="natureOthers" name="natureOthers" value="${companyAccount.natureOthers}" />
                            </td>
                        </tr>
                        <tr>
                            <td class="reg-1"><fmt:message key="GLOBAL_企业人数" bundle="${bundle}"/><b style="color:#e8a29a;">*</b></td>
                            <td class="reg-2" colspan="3">
                                <select id="companyScale" name="companyScale" class="Input-1">
                                    <option value=""><fmt:message key="GLOBAL_请选择" bundle="${bundle}"/></option>
                                    <c:forEach var="companyScaleEnum" items="${companyScaleEnums}">
                                        <option <c:if test="${companyScaleEnum == companyAccount.scale}">selected="selected"</c:if> value="${companyScaleEnum.name()}">${companyScaleEnum.getMean(bundle.resourceBundle)}</option>
                                    </c:forEach>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td class="reg-1"><fmt:message key="GLOBAL_企业地址" bundle="${bundle}"/><b style="color:#e8a29a;">*</b></td>
                            <td class="reg-2"><input type="text" name="address" id="address" class="Input-1" value="${companyAccount.address}" /></td>
                            <td class="reg-1"><fmt:message key="GLOBAL_邮编" bundle="${bundle}"/><b style="color:#e8a29a;">*</b></td>
                            <td><input type="text" name="zipCode" id="zipCode" class="Input-1" value="${companyAccount.zipCode}" /></td>
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
                    <div id="step2" style="display: none">
                        <div class="Title-reg"><a style=" margin-left:10px; font-size:12px; color:#e8a29a; font-weight:normal;">(<fmt:message key="GLOBAL_选填项" bundle="${bundle}"/>)</a></div>
                        <table width="914" border="0" align="center" style="margin:0 auto; border-bottom:2px #dddddd solid; padding-bottom:20px;">
                            <tr>
                                <td class="reg-3"><fmt:message key="GLOBAL_企业网址" bundle="${bundle}"/></td>
                                <td class="reg-4"><input type="text" class="Input-1" id="webSide" name="webSide" value="${companyAccount.webSide}" /></td>
                            <td class="reg-3"><fmt:message key="GLOBAL_资质证书编号" bundle="${bundle}"/></td>
                            <td><input type="text" class="Input-1" id="qalityCode" name="qalityCode" value="${companyAccount.qalityCode}" /></td>
                        </tr>
                        <tr>
                            <td class="reg-3"><fmt:message key="GLOBAL_企业资质等级" bundle="${bundle}"/></td>
                            <td class="reg-4"><input type="text" class="Input-1" id="enterpriseQalityGrading" name="enterpriseQalityGrading" value="${companyAccount.enterpriseQalityGrading}" /></td>
                            <td class="reg-3"><fmt:message key="GLOBAL_主项资质发证时间" bundle="${bundle}"/></td>
                            <td><input type="text" class="Input-1" id="authenticationDate" name="authenticationDate" onclick="WdatePicker({dateFmt: 'yyyy-MM-dd'})" value="<fmt:formatDate value='${companyAccount.authenticationDate}' pattern='yyyy-MM-dd' type='date' dateStyle='long' />" /></td>
                        </tr>
                        <tr>
                            <td class="reg-3"><fmt:message key="GLOBAL_安全生产许可证编号" bundle="${bundle}"/></td>
                            <td class="reg-4"><input type="text" class="Input-1" id="productionLicenseNumber" name="productionLicenseNumber"  value="${companyAccount.productionLicenseNumber}" /></td>
                            <td class="reg-3"></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td class="reg-3"><fmt:message key="GLOBAL_安全生产许可证有效期(起始)" bundle="${bundle}"/></td>
                            <td class="reg-4"><input type="text" class="Input-1" id="productionLicenseValidDateStart" name="productionLicenseValidDateStart" onclick="WdatePicker({dateFmt: 'yyyy-MM-dd'})" value="<fmt:formatDate value='${companyAccount.productionLicenseValidDateStart}' pattern='yyyy-MM-dd' type='date' dateStyle='long' />" /></td>
                            <td class="reg-3"><fmt:message key="GLOBAL_安全生产许可证有效期(结束)" bundle="${bundle}"/></td>
                            <td><input type="text" class="Input-1" id="productionLicenseValidDate" name="productionLicenseValidDate" onclick="WdatePicker({dateFmt: 'yyyy-MM-dd'})" value="<fmt:formatDate value='${companyAccount.productionLicenseValidDate}' pattern='yyyy-MM-dd' type='date' dateStyle='long' />" /></td>
                        </tr>
                        <tr>
                            <td class="reg-3"><fmt:message key="GLOBAL_目标客户或擅长领域" bundle="${bundle}"/></td>
                            <td colspan="3" ><textarea style="width:600px; height:40px; margin-top:20px; border:1px #e6e6e6 solid;" id="field" name="field">${companyAccount.field}</textarea></td>
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
                    <input type="hidden" name="businessLicenseUrl" id="businessLicenseUrl" value="" />
                    <input type="hidden" name="" id="" value="" />
                </form>
                <div id="step3" style="display: none">
                    <div class="Title-reg"><fmt:message key="GLOBAL_相关证明" bundle="${bundle}"/></div>
                    <table width="914" border="0" style="margin:0 auto; border-bottom:2px #dddddd solid; padding-bottom:20px;">
                        <tr>
                        <form id="reg_bl_form" method="post" enctype="multipart/form-data" target="iframe1" action="/account/z_iframe_upload_pc?type=bl">
                            <input type="hidden" name="a" value="upload_person_card" />
                            <td align="center" style="width:457px;">
                                <div class="reg-img">
                                    <div id="reg_bl_div"><br/><br/>
                                        <p><fmt:message key="GLOBAL_上传企业营业执照副本" bundle="${bundle}"/></p>
                                        <p><fmt:message key="GLOBAL_加盖公章" bundle="${bundle}"/><br><fmt:message key="GLOBAL_上传图片大小不得超过5MB支持JPG/PNG图片格式" bundle="${bundle}"/></p>
                                    </div>
                                    <img id="reg_bl_img" src="" width="300" height="190" style="display: none" />
                                    <div class="new-contentarea tc">
                                        <a href="javascript:void(0)" class="upload-img"><label for="reg_bl"><fmt:message key="GLOBAL_选择图片路径" bundle="${bundle}"/></label></a>
                                        <input id="reg_bl" type="file" class="" name="reg_bl_file" onchange="document.getElementById('reg_bl_result').innerHTML = this.value;
                                                checkImgType(this);" />
                                    </div>
                                    <p id="reg_bl_result"></p>
                                </div>
                                <input id="reg_bl_submit" type="button" style=" width:110px; height:32px; background:#52853d; color:#FFF; border:0; border-radius:5px; cursor:pointer;" value="<fmt:message key="上传图片" bundle="${bundle}"/>">
                            </td>
                        </form>
                        <form id="reg_qc_form" method="post" enctype="multipart/form-data" target="iframe1" action="/account/z_iframe_upload_pc?type=qc">
                            <input type="hidden" name="a" value="upload_person_card"  />
                            <td id="reg_qc_td" align="center" style="width:457px;">
                                <div class="reg-img">
                                    <div id="reg_qc_div"><br/><br/>
                                        <p><fmt:message key="GLOBAL_上传企业资质证书" bundle="${bundle}"/></p><p><fmt:message key="GLOBAL_加多个请打包成文件" bundle="${bundle}"/><br><fmt:message key="GLOBAL_上传文件大小不得超过5MB" bundle="${bundle}"/></p>
                                    </div>
                                    <img id="reg_qc_img" src="" width="300" height="190" style="display: none" />
                                    <div class="new-contentarea tc">
                                        <a href="javascript:void(0)" class="upload-img"><label for="reg_qc"><fmt:message key="GLOBAL_选择文件路径" bundle="${bundle}"/></label></a>
                                        <input id="reg_qc" type="file" class="" name="reg_bl_file" onchange="document.getElementById('reg_qc_result').innerHTML = this.value;
                                                checkImgType(this);" />
                                    </div>
                                    <p id="reg_qc_result"></p>
                                </div>
                                <input id="reg_qc_submit" type="button" style=" width:110px; height:32px; background:#52853d; color:#FFF; border:0; border-radius:5px; cursor:pointer;" value="<fmt:message key="GLOBAL_上传文件" bundle="${bundle}"/>">
                            </td>
                        </form>
                        </tr>
                    </table>
                    <table width="914" border="0" style="margin:20px auto; padding-bottom:20px;">
                        <tr>
                        <table width="914" border="0" style="margin:20px auto; padding-bottom:20px;">
                            <tr>
                                <td style="width: 300px;" align="right">
                                    <div align="center" id="signup_msg_3" style="width: 120px;" class="wrongMessage"><c:if test="${not empty postResult.singleErrorMsg}">${postResult.singleErrorMsg}</c:if></div>
                                </td>
                                <td align="center" >
                                    <input id="step3_before" type="button" style=" width:130px; height:42px; background:#52853d; color:#FFF; border:0; border-radius:5px; font-size:14px; cursor:pointer;" value="<fmt:message key="GLOBAL_上一步" bundle="${bundle}"/>" />&nbsp&nbsp
                                    <input id="step3_next" type="button" style=" width:130px; height:42px; background:#52853d; color:#FFF; border:0; border-radius:5px; font-size:14px; cursor:pointer;" value="<fmt:message key="GLOBAL_提交" bundle="${bundle}"/>" />
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
                $("#companyNature").change(function () {
                    if ($("#companyNature").val() == 'OTHERS') {
                        $("#natureOthers_td_1").show();
                        $("#natureOthers_td_2").show();
                    } else {
                        $("#natureOthers_td_1").hide();
                        $("#natureOthers_td_2").hide();
                    }
                });
                $.ajaxSetup({//ie中防止加载缓存中内容
                    cache: false
                });
                $("#step1_next").click(function () {
                    $("#signup_msg_3").html("");
                    if (CBRAValid.checkFormValueNull($("#accountName"))) {
                        CBRAMessage.showWrongMessageAndBorderEle($("#signup_msg_1"), "<fmt:message key="GLOBAL_请输入企业全称" bundle="${bundle}"/>", $("#accountName"));
                        return;
                    }
                    if (CBRAValid.checkFormValueNull($("#account"))) {
                        CBRAMessage.showWrongMessageAndBorderEle($("#signup_msg_1"), "<fmt:message key="GLOBAL_请输入营业执照注册号" bundle="${bundle}"/>", $("#account"));
                        return;
                    }
                    //发送ajax
                    $.post("/account/signup_c", {
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
                            if (CBRAValid.checkFormValueNull($("#companyCreateDate"))) {
                                CBRAMessage.showWrongMessageAndBorderEle($("#signup_msg_1"), "<fmt:message key="GLOBAL_请输入创立时间" bundle="${bundle}"/>", $("#companyCreateDate"));
                                return;
                            }
                            if (CBRAValid.checkFormValueNull($("#legalPerson"))) {
                                CBRAMessage.showWrongMessageAndBorderEle($("#signup_msg_1"), "<fmt:message key="GLOBAL_企业法人" bundle="${bundle}"/>", $("#legalPerson"));
                                return;
                            }
                            if ($("#companyNature").val() == '') {
                                CBRAMessage.showWrongMessageAndBorderEle($("#signup_msg_1"), "<fmt:message key="GLOBAL_请选择企业性质" bundle="${bundle}"/>", $("#companyNature"));
                                return;
                            }
                            if ($("#companyNature").val() == 'OTHERS' && CBRAValid.checkFormValueNull($("#natureOthers"))) {
                                CBRAMessage.showWrongMessageAndBorderEle($("#signup_msg_1"), "<fmt:message key="GLOBAL_请输入其他职务" bundle="${bundle}"/>", $("#natureOthers"));
                                return;
                            }
                            if ($("#companyScale").val() == '') {
                                CBRAMessage.showWrongMessageAndBorderEle($("#signup_msg_1"), "<fmt:message key="GLOBAL_请选择企业人数" bundle="${bundle}"/>", $("#companyScale"));
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
                            $("#step1").hide();
                            $("#step2").show();
                            $("#signup_msg_1").html("");
                        }
                    }, "json");
                });
                $("#step2_next").click(function () {
                    $("#signup_msg_3").html("");
//                    if (CBRAValid.checkFormValueNull($("#webSide"))) {
//                        CBRAMessage.showWrongMessageAndBorderEle($("#signup_msg_2"), "请输入企业网址", $("#webSide"));
//                        return;
//                    }
//                    if (CBRAValid.checkFormValueNull($("#enterpriseQalityGrading"))) {
//                        CBRAMessage.showWrongMessageAndBorderEle($("#signup_msg_2"), "请输入企业资质等级", $("#enterpriseQalityGrading"));
//                        return;
//                    }
//                    if (CBRAValid.checkFormValueNull($("#authenticationDate"))) {
//                        CBRAMessage.showWrongMessageAndBorderEle($("#signup_msg_2"), "请输入主项资质发证时间", $("#authenticationDate"));
//                        return;
//                    }
//                    if (CBRAValid.checkFormValueNull($("#productionLicenseNumber"))) {
//                        CBRAMessage.showWrongMessageAndBorderEle($("#signup_msg_2"), "请输入安全生产许可证编号", $("#productionLicenseNumber"));
//                        return;
//                    }
//                    if (CBRAValid.checkFormValueNull($("#productionLicenseValidDateStart"))) {
//                        CBRAMessage.showWrongMessageAndBorderEle($("#signup_msg_2"), "请输入安全生产许可证有效期(起始时间)", $("#productionLicenseValidDateStart"));
//                        return;
//                    }
//                    if (CBRAValid.checkFormValueNull($("#productionLicenseValidDate"))) {
//                        CBRAMessage.showWrongMessageAndBorderEle($("#signup_msg_2"), "请输入安全生产许可证有效期(结束时间)", $("#productionLicenseValidDate"));
//                        return;
//                    }
//                    if (CBRAValid.checkFormValueNull($("#field"))) {
//                        CBRAMessage.showWrongMessageAndBorderEle($("#signup_msg_2"), "请输入目标客户或擅长领域", $("#field"));
//                        return;
//                    }
                    $("#step2").hide();
                    $("#step3").show();
                    $("#signup_msg_2").html("");
                });
                $("#step3_next").click(function () {
                    $("#signup_msg_3").html("");
                    if ($.trim($("#bl_hidden").val()) == "") {
                        CBRAMessage.showMessage($("#signup_msg_3"), "<fmt:message key="GLOBAL_上传企业营业执照副本" bundle="${bundle}"/>");
                        return;
                    }
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
                $("#reg_bl_submit").click(function () {
                    $("#signup_msg_3").html("");
                    if ($("#reg_bl").val() == '') {
                        CBRAMessage.showWrongMessageAndBorderEle($("#signup_msg_3"), "<fmt:message key="GLOBAL_选择图片路径" bundle="${bundle}"/>", $("#reg_bl"));
                        return;
                    }
                    $("#reg_bl_form").submit();
                });
                $("#reg_qc_submit").click(function () {
                    $("#signup_msg_3").html("");
                    if ($("#reg_qc").val() == '') {
                        CBRAMessage.showWrongMessageAndBorderEle($("#signup_msg_3"), "<fmt:message key="GLOBAL_选择文件路径" bundle="${bundle}"/>", $("#reg_qc"));
                        return;
                    }
                    $("#reg_qc_form").submit();
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
                                alert("<fmt:message key="GLOBAL_上传的文件大小不能超过5M" bundle="${bundle}"/>");
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
