<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html>
    <head>
        <jsp:include page="/WEB-INF/public/z_header.jsp"/>
    </head>
    <body>
        <jsp:include page="/WEB-INF/public/z_top.jsp" />
        <jsp:include page="/WEB-INF/public/z_banner.jsp"/>
        <!-- 主体 -->
        <div class="ind-reg">
            <!-- 标题 -->
            <div class="Title"><a href="/account/signup">个人入会申请</a><a href="/account/signup_c" id="ind-reg-b">企业入会申请</a></div>
            <form id="reg_form" method="post" action="/account/signup_c">
                <div id="step1">
                    <div class="Title-reg">基本信息<a style=" margin-left:10px; font-size:12px; color:#e8a29a; font-weight:normal;">(必填项)</a></div>
                    <table width="914" border="0" align="center" style="margin:0 auto; border-bottom:2px #dddddd solid; padding-bottom:20px;">
                        <tr>
                            <td class="reg-1">企业全称</td>
                            <td colspan="3" class="reg-2"><input type="text" class="Input-1" id="accountName" name="accountName" /></td>
                        </tr>
                        <tr>
                            <td class="reg-1">营业执照注册号</td>
                            <td class="reg-2"><input type="text" class="Input-1" id="account" name="account" /></td>
                            <td class="reg-1">企业邮箱</td>
                            <td><input type="text" class="Input-1" id="email" name="email" /></td>
                        </tr>
                        <tr>
                            <td class="reg-1">创立时间</td>
                            <td class="reg-2"><input type="text" class="Input-1" id="companyCreateDate" name="companyCreateDate" onclick="WdatePicker({dateFmt: 'yyyy-MM-dd'})" /></td>
                            <td class="reg-1">企业法人</td>
                            <td><input type="text" class="Input-1" id="legalPerson" name="legalPerson" /></td>
                        </tr>
                        <tr>
                            <td class="reg-1">企业性质</td>
                            <td class="reg-2">
                                <select id="companyNature" name="companyNature" class="Input-1">
                                    <option value="">请选择</option>
                                    <c:forEach var="companyNatureEnum" items="${companyNatureEnums}">
                                        <option value="${companyNatureEnum.name()}">${companyNatureEnum.mean}</option>
                                    </c:forEach>
                                </select>
                            </td>
                            <td id="natureOthers_td_1" style="display: none" class="reg-1">其他</td>
                            <td id="natureOthers_td_2" style="display: none">
                                <input type="text" class="Input-1" id="natureOthers" name="natureOthers" />
                            </td>
                        </tr>
                        <tr>
                            <td class="reg-1">企业人数</td>
                            <td class="reg-2" colspan="3">
                                <select id="companyScale" name="companyScale" class="Input-1">
                                    <option value="">请选择</option>
                                    <c:forEach var="companyScaleEnum" items="${companyScaleEnums}">
                                        <option value="${companyScaleEnum.name()}">${companyScaleEnum.mean}</option>
                                    </c:forEach>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td class="reg-1">企业地址</td>
                            <td class="reg-2"><input type="text" name="address" id="address" class="Input-1" /></td>
                            <td class="reg-1">邮编</td>
                            <td><input type="text" name="zipCode" id="zipCode" class="Input-1" /></td>
                        </tr>
                        <tr>
                            <td class="reg-1">产业链位置</td>
                            <td class="reg-2" colspan="3" style="line-height: 22px;">
                                <c:forEach var="icPosition" items="${icPositions}">
                                    <input type="checkbox" name="icPositions" value="${icPosition.key}" />${icPosition.name}&nbsp&nbsp&nbsp&nbsp
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
                                    <input id="step1_next" type="button" style=" width:130px; height:42px; background:#52853d; color:#FFF; border:0; border-radius:5px; font-size:14px; cursor:pointer;" value="下一步" />
                                </td>
                                <td style="width: 350px;">
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div id="step2" style="display: none">
                        <div class="Title-reg"><a style=" margin-left:10px; font-size:12px; color:#e8a29a; font-weight:normal;">(选填项)</a></div>
                        <table width="914" border="0" align="center" style="margin:0 auto; border-bottom:2px #dddddd solid; padding-bottom:20px;">
                            <tr>
                                <td class="reg-3">企业网址</td>
                                <td colspan="3" class="reg-2"><input type="text" class="Input-1" id="webSide" name="webSide" /></td>
                            </tr>
                            <tr>
                                <td class="reg-3">企业资质等级</td>
                                <td class="reg-4"><input type="text" class="Input-1" id="enterpriseQalityGrading" name="enterpriseQalityGrading" /></td>
                                <td class="reg-3">主项资质发证时间</td>
                                <td><input type="text" class="Input-1" id="authenticationDate" name="authenticationDate" onclick="WdatePicker({dateFmt: 'yyyy-MM-dd'})" /></td>
                            </tr>
                            <tr>
                                <td class="reg-3">安全生产许可证编号</td>
                                <td class="reg-4"><input type="text" class="Input-1" id="productionLicenseNumber" name="productionLicenseNumber" /></td>
                                <td class="reg-3">安全生产许可证有效期</td>
                                <td><input type="text" class="Input-1" id="productionLicenseValidDate" name="productionLicenseValidDate" onclick="WdatePicker({dateFmt: 'yyyy-MM-dd'})" /></td>
                            </tr>
                            <tr>
                                <td class="reg-3">目标客户或擅长领域</td>
                                <td colspan="3" ><textarea style="width:600px; height:40px; margin-top:20px; border:1px #e6e6e6 solid;" id="field" name="field"></textarea></td>
                            </tr>
                        </table>
                        <table width="914" border="0" style="margin:20px auto; padding-bottom:20px;">
                            <tr>
                                <td style="width: 300px;" align="right">
                                    <div align="center" id="signup_msg_2" style="width: 120px;" class="wrongMessage"><c:if test="${not empty postResult.singleErrorMsg}">${postResult.singleErrorMsg}</c:if></div>
                                </td>
                                <td align="center" >
                                    <input id="step2_before" type="button" style=" width:130px; height:42px; background:#52853d; color:#FFF; border:0; border-radius:5px; font-size:14px; cursor:pointer;" value="上一步" />&nbsp&nbsp
                                    <input id="step2_next" type="button" style=" width:130px; height:42px; background:#52853d; color:#FFF; border:0; border-radius:5px; font-size:14px; cursor:pointer;" value="下一步" />
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
                    <div class="Title-reg">相关证明</div>
                    <table width="914" border="0" style="margin:0 auto; border-bottom:2px #dddddd solid; padding-bottom:20px;">
                        <tr>
                            <td align="center" style="width:457px;">
                                <div class="reg-img"><br><br><br>
                                    <p>上传企业营业执照副本</p>
                                    <p>彩色加盖公章<br>上传图片大小不得超过200K，支持JPG、PNG图片格式</p>
                                    <input type="button" style=" width:98px; height:26px; background:#bbbbbb; color:#FFF; border:0; border-radius:5px; cursor:pointer;" value="选择图片路径"></div><input type="button" style=" width:110px; height:32px; background:#52853d; color:#FFF; border:0; border-radius:5px; cursor:pointer;" value="上传图片">
                            </td>
                            <td align="center" style="width:457px;">
                                <div class="reg-img"><br><br><br>
                                    <p>上传企业资质证书</p><p>可添加多个<br>上传图片大小不得超过200K，支持JPG、PNG图片格式</p>
                                    <input type="button" style=" width:98px; height:26px; background:#bbbbbb; color:#FFF; border:0; border-radius:5px; cursor:pointer;" value="选择图片路径">
                                </div><input type="button" style=" width:110px; height:32px; background:#52853d; color:#FFF; border:0; border-radius:5px; cursor:pointer;" value="上传图片">
                            </td>
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
                                    <input id="step3_before" type="button" style=" width:130px; height:42px; background:#52853d; color:#FFF; border:0; border-radius:5px; font-size:14px; cursor:pointer;" value="上一步" />&nbsp&nbsp
                                    <input id="step3_next" type="button" style=" width:130px; height:42px; background:#52853d; color:#FFF; border:0; border-radius:5px; font-size:14px; cursor:pointer;" value="提 交" />
                                </td>
                                <td style="width: 300px;">
                                </td>
                            </tr>
                        </table>
                </div>
            </div>
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
                $("#step1_next").click(function () {
                    if (CBRAValid.checkFormValueNull($("#accountName"))) {
                        CBRAMessage.showWrongMessageAndBorderEle($("#signup_msg_1"), "请输入企业全称", $("#accountName"));
                        return;
                    }
                    if (CBRAValid.checkFormValueNull($("#account"))) {
                        CBRAMessage.showWrongMessageAndBorderEle($("#signup_msg_1"), "请输入营业执照注册号", $("#account"));
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
                                CBRAMessage.showWrongMessageAndBorderEle($("#signup_msg_1"), "请输入合法邮件", $("#email"));
                                return;
                            }
                            if (CBRAValid.checkFormValueNull($("#companyCreateDate"))) {
                                CBRAMessage.showWrongMessageAndBorderEle($("#signup_msg_1"), "请输入创立时间", $("#companyCreateDate"));
                                return;
                            }
                            if (CBRAValid.checkFormValueNull($("#legalPerson"))) {
                                CBRAMessage.showWrongMessageAndBorderEle($("#signup_msg_1"), "企业法人", $("#legalPerson"));
                                return;
                            }
                            if ($("#companyNature").val() == '') {
                                CBRAMessage.showWrongMessageAndBorderEle($("#signup_msg_1"), "请选择企业性质", $("#companyNature"));
                                return;
                            }
                            if ($("#companyNature").val() == 'OTHERS' && CBRAValid.checkFormValueNull($("#natureOthers"))) {
                                CBRAMessage.showWrongMessageAndBorderEle($("#signup_msg_1"), "请输入其他职务", $("#natureOthers"));
                                return;
                            }
                            if ($("#companyScale").val() == '') {
                                CBRAMessage.showWrongMessageAndBorderEle($("#signup_msg_1"), "请选择企业人数", $("#companyScale"));
                                return;
                            }
                            if (CBRAValid.checkFormValueNull($("#address"))) {
                                CBRAMessage.showWrongMessageAndBorderEle($("#signup_msg_1"), "请输入邮寄地址", $("#address"));
                                return;
                            }
                            if (CBRAValid.checkFormValueNull($("#zipCode"))) {
                                CBRAMessage.showWrongMessageAndBorderEle($("#signup_msg_1"), "请输入邮寄", $("#zipCode"));
                                return;
                            }
                            if ($("input[name=icPositions]:checked").length < 1) {
                                CBRAMessage.showMessage($("#signup_msg_1"), "请选择产业链位置");
                                return;
                            }
                            $("#step1").hide();
                            $("#step2").show();
                            $("#signup_msg_1").html("");
                        }
                    }, "json");
                });
                $("#step2_next").click(function () {
                    if (CBRAValid.checkFormValueNull($("#webSide"))) {
                        CBRAMessage.showWrongMessageAndBorderEle($("#signup_msg_2"), "请输入企业网址", $("#webSide"));
                        return;
                    }
                    if (CBRAValid.checkFormValueNull($("#enterpriseQalityGrading"))) {
                        CBRAMessage.showWrongMessageAndBorderEle($("#signup_msg_2"), "请输入企业资质等级", $("#enterpriseQalityGrading"));
                        return;
                    }
                    if (CBRAValid.checkFormValueNull($("#authenticationDate"))) {
                        CBRAMessage.showWrongMessageAndBorderEle($("#signup_msg_2"), "请输入主项资质发证时间", $("#authenticationDate"));
                        return;
                    }
                    if (CBRAValid.checkFormValueNull($("#productionLicenseNumber"))) {
                        CBRAMessage.showWrongMessageAndBorderEle($("#signup_msg_2"), "请输入安全生产许可证编号", $("#productionLicenseNumber"));
                        return;
                    }
                    if (CBRAValid.checkFormValueNull($("#productionLicenseValidDate"))) {
                        CBRAMessage.showWrongMessageAndBorderEle($("#signup_msg_2"), "请输入安全生产许可证有效期", $("#productionLicenseValidDate"));
                        return;
                    }
                    if (CBRAValid.checkFormValueNull($("#field"))) {
                        CBRAMessage.showWrongMessageAndBorderEle($("#signup_msg_2"), "请输入目标客户或擅长领域", $("#field"));
                        return;
                    }
                    $("#step2").hide();
                    $("#step3").show();
                    $("#signup_msg_2").html("");
                });
                $("#step3_next").click(function () {
                    if ($.trim($("#projectExperience").val()) == "") {
                        CBRAMessage.showMessage($("#signup_msg_4"), "请输入内容");
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
                $("#reg_front_button").click(function () {
                    $("#reg_front").click();
                });
                $("#reg_back_button").click(function () {
                    $("#reg_back").click();
                });
                $("#reg_front_submit").click(function () {
                    if ($("#reg_front").val() == '') {
                        CBRAMessage.showWrongMessageAndBorderEle($("#signup_msg_2"), "请选择图片路径", $("#reg_front"));
                        return;
                    }
                    $("#reg_front_form").submit();
                });
                $("#reg_back_submit").click(function () {
                    if ($("#reg_back").val() == '') {
                        CBRAMessage.showWrongMessageAndBorderEle($("#signup_msg_2"), "请选择图片路径", $("#reg_back"));
                        return;
                    }
                    $("#reg_back_form").submit();
                });
            });
        </script>
    </body>
</html>
