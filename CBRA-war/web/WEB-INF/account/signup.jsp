<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html>
    <head>
        <jsp:include page="/WEB-INF/public/z_header.jsp"/>
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
                <div class="Title"><a href="/account/signup" id="ind-reg-b">个人入会申请</a><a href="/account/signup_c">企业入会申请</a></div>
                <div id="step1">
                    <div class="Title-reg">基本信息<a style=" margin-left:10px; font-size:12px; color:#e8a29a; font-weight:normal;">(*为必填项)</a></div>
                    <table width="914" border="0" align="center" style="margin:0 auto; border-bottom:2px #dddddd solid; padding-bottom:20px;">
                        <tr>
                            <td class="reg-1"><b style="color:#e8a29a;">*</b>中文姓名</td>
                            <td class="reg-2"><input type="text" name="accountName" id="accountName" class="Input-1" /></td>
                            <td class="reg-1">英文姓名</td>
                            <td><input type="text" name="accountEnName" id="accountEnName" class="Input-1" /></td>
                        </tr>
                        <tr>
                            <td class="reg-1"><b style="color:#e8a29a;">*</b>手机
                            </td>
                            <td class="reg-2" style="line-height:10px;height: 63px;"><input type="text" name="account" id="account" class="Input-1" /><br/><br/><span style="font-size:11px">作为账户登录，请使用有效号码</span></td>
                            <td class="reg-1"><b style="color:#e8a29a;">*</b>EMAIL</td>
                            <td style="line-height:10px;height: 63px;"><input type="text" name="email" id="email" class="Input-1" /><br/><br/><span style="font-size:11px">邮箱作为接收筑誉活动渠道，请填写常用邮箱</span></td>
                        </tr>
                        <tr>
                            <td class="reg-1"><b style="color:#e8a29a;">*</b>从业年限</td>
                            <td class="reg-2"><input type="text" name="workingYear" id="workingYear" class="Input-1" />（年）</td>
                            <td class="reg-1">目前就职公司</td>
                            <td><input type="text" name="company" id="company" class="Input-1" /></td>
                        </tr>
                        <tr>
                            <td class="reg-1"><b style="color:#e8a29a;">*</b>邮寄地址</td>
                            <td class="reg-2"><input type="text" name="address" id="address" class="Input-1" /></td>
                            <td class="reg-1"><b style="color:#e8a29a;">*</b>邮编</td>
                            <td><input type="text" name="zipCode" id="zipCode" class="Input-1" /></td>
                        </tr>
                        <tr>
                            <td class="reg-1"><b style="color:#e8a29a;">*</b>职务</td>
                            <td class="reg-2" style="line-height: 22px;">
                                <span style="padding-right: 15px;">
                                    <select id="position" name="position" class="Input-1">
                                        <option value="">请选择</option>
                                        <c:forEach var="position" items="${positions}">
                                            <option value="${position.name()}">${position.mean}</option>
                                        </c:forEach>
                                        <option value="others">其他</option>
                                    </select>
                                </span>   
                            </td>
                            <td class="reg-1" id="others_td_1" style="display: none">其他</td>
                            <td id="others_td_2" style="display: none"><input type="text" name="others" id="others" class="Input-1"/></td>
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
                    <input type="hidden" id="workExperience_hidden" name="workExperience" value="" />
                    <input type="hidden" id="projectExperience_hidden" name="projectExperience" value="" />
                </form>
                <div id="step2" style="display: none">
                    <div class="Title-reg">实名认证</div>
                    <table width="914" border="0" style="margin:0 auto; border-bottom:2px #dddddd solid; padding-bottom:20px;">
                        <tr>
                        <form id="reg_front_form" method="post" enctype="multipart/form-data" target="iframe1" action="/account/z_iframe_upload_pc?type=front">
                            <input type="hidden" name="a" value="upload_person_card" />
                            <td align="center" style="width:457px;">
                                <div class="reg-img">
                                    <div id="reg_front_div">
                                        <br><br><br><p>上传身份证正面</p><p>上传图片大小不得超过2MB
                                            支持JPG、PNG图片格式</p>
                                    </div>
                                    <img id="reg_front_img" src="" width="300" height="190" style="display: none" />
                                    <input id="reg_front_button" type="button" style=" width:98px; height:26px; background:#bbbbbb; color:#FFF; border:0; border-radius:5px; cursor:pointer;" value="选择图片路径">
                                    <p id="reg_front_result"></p>
                                </div>
                                <input id="reg_front_submit" type="button" style=" width:110px; height:32px; background:#52853d; color:#FFF; border:0; border-radius:5px; cursor:pointer;" value="上传图片">
                                <input style="display: none" id="reg_front" type="file" name="reg_front_file" onchange="document.getElementById('reg_front_result').innerHTML = this.value" />
                            </td>
                        </form>
                        <form id="reg_back_form" method="post" enctype="multipart/form-data" target="iframe1" action="/account/z_iframe_upload_pc?type=back">
                            <input type="hidden" name="a" value="upload_person_card"  />
                            <td id="reg_back_td" align="center" style="width:457px;">
                                <div class="reg-img">
                                    <div id="reg_back_div">
                                        <br><br><br><p>上传身份证背面</p><p>上传图片大小不得超过2MB
                                            支持JPG、PNG图片格式</p>
                                    </div>
                                    <img id="reg_back_img" src="" width="300" height="190" style="display: none" />
                                    <input id="reg_back_button" type="button" style=" width:98px; height:26px; background:#bbbbbb; color:#FFF; border:0; border-radius:5px; cursor:pointer;" value="选择图片路径">
                                    <p id="reg_back_result"></p>
                                </div>
                                <input id="reg_back_submit" type="button" style=" width:110px; height:32px; background:#52853d; color:#FFF; border:0; border-radius:5px; cursor:pointer;" value="上传图片">
                                <input style="display: none" id="reg_back" type="file" name="reg_back_file" onchange="document.getElementById('reg_back_result').innerHTML = this.value" />
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
                                <input id="step2_before" type="button" style=" width:130px; height:42px; background:#52853d; color:#FFF; border:0; border-radius:5px; font-size:14px; cursor:pointer;" value="上一步" />&nbsp&nbsp
                                <input id="step2_next" type="button" style=" width:130px; height:42px; background:#52853d; color:#FFF; border:0; border-radius:5px; font-size:14px; cursor:pointer;" value="下一步" />
                            </td>
                            <td style="width: 300px;">
                            </td>
                        </tr>
                    </table>
                </div>
                <div id="step3" style="display: none">
                    <div class="Title-reg">工作履历</div>

                    <table width="914" border="0" style="margin:0 auto; border-bottom:2px #dddddd solid; padding-bottom:20px;">
                        <tr>
                            <td align="center" ><textarea id="workExperience" style="width:910px; height:150px; border:1px #e6e6e6 solid;"></textarea></td>
                        </tr>
                    </table>
                    <table width="914" border="0" style="margin:20px auto; padding-bottom:20px;">
                        <tr>
                            <td style="width: 300px;" align="right">
                                <div align="center" id="signup_msg_3" style="width: 120px;" class="wrongMessage"><c:if test="${not empty postResult.singleErrorMsg}">${postResult.singleErrorMsg}</c:if></div>
                            </td>
                            <td align="center" >
                                <input id="step3_before" type="button" style=" width:130px; height:42px; background:#52853d; color:#FFF; border:0; border-radius:5px; font-size:14px; cursor:pointer;" value="上一步" />&nbsp&nbsp
                                <input id="step3_next" type="button" style=" width:130px; height:42px; background:#52853d; color:#FFF; border:0; border-radius:5px; font-size:14px; cursor:pointer;" value="下一步" />
                            </td>
                            <td style="width: 300px;">
                            </td>
                        </tr>
                    </table>
                </div>
                <div id="step4" style="display: none">
                    <div class="Title-reg">项目经验</div>
                    <table width="914" border="0" style="margin:0 auto; border-bottom:2px #dddddd solid; padding-bottom:20px;">
                        <tr>
                            <td align="center" ><textarea id="projectExperience" style="width:910px; height:150px; border:1px #e6e6e6 solid;"></textarea></td>
                        </tr>
                    </table>
                    <table width="914" border="0" style="margin:20px auto; padding-bottom:20px;">
                        <tr>
                            <td style="width: 300px;" align="right">
                                <div align="center" id="signup_msg_4" style="width: 120px;" class="wrongMessage"><c:if test="${not empty postResult.singleErrorMsg}">${postResult.singleErrorMsg}</c:if></div>
                            </td>
                            <td align="center" >
                                <input id="step4_before" type="button" style=" width:130px; height:42px; background:#52853d; color:#FFF; border:0; border-radius:5px; font-size:14px; cursor:pointer;" value="上一步" />&nbsp&nbsp
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
                        CBRAMessage.showWrongMessageAndBorderEle($("#signup_msg_1"), "请输入中文姓名", $("#accountName"));
                        return;
                    }
                    if (!CBRAValid.checkFormValueMobile($("#account"))) {
                        CBRAMessage.showWrongMessageAndBorderEle($("#signup_msg_1"), "请输入合法手机", $("#account"));
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
                                CBRAMessage.showWrongMessageAndBorderEle($("#signup_msg_1"), "请输入合法邮件", $("#email"));
                                return;
                            }
                            if (CBRAValid.checkFormValueNull($("#workingYear"))) {
                                CBRAMessage.showWrongMessageAndBorderEle($("#signup_msg_1"), "请输入从业年限", $("#workingYear"));
                                return;
                            }
                            if (isNaN($('#workingYear').val())) {
                                CBRAMessage.showWrongMessageAndBorderEle($("#signup_msg_1"), "从业年限必须是数字", $("#workingYear"));
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
                            if ($("#position").val() == '') {
                                CBRAMessage.showWrongMessageAndBorderEle($("#signup_msg_1"), "请选择职务", $("#position"));
                                return;
                            }
                            if ($("#position").val() == 'others' && CBRAValid.checkFormValueNull($("#others"))) {
                                CBRAMessage.showWrongMessageAndBorderEle($("#signup_msg_1"), "请输入其他职务", $("#others"));
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
                        CBRAMessage.showMessage($("#signup_msg_2"), "请上传文件");
                        return;
                    }
                    $("#step2").hide();
                    $("#step3").show();
                    $("#signup_msg_2").html("");
                });
                $("#step3_next").click(function () {
                    $("#signup_msg_3").html("");
                    if ($.trim($("#workExperience").val()) == "") {
                        CBRAMessage.showMessage($("#signup_msg_3"), "请输入内容");
                        return;
                    }
                    $("#step3").hide();
                    $("#step4").show();
                    $("#signup_msg_3").html("");
                });
                $("#step4_next").click(function () {
                    $("#signup_msg_3").html("");
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
                $("#step4_before").click(function () {
                    $("#step4").hide();
                    $("#step3").show();
                });
                $("#reg_front_button").click(function () {
                    $("#reg_front").click();
                });
                $("#reg_back_button").click(function () {
                    $("#reg_back").click();
                });
                $("#reg_front_submit").click(function () {
                    $("#signup_msg_3").html("");
                    $("#signup_msg_2").html("");
                    if ($("#reg_front").val() == '') {
                        CBRAMessage.showWrongMessageAndBorderEle($("#signup_msg_2"), "请选择图片路径", $("#reg_front"));
                        return;
                    }
                    $("#reg_front_form").submit();
                });
                $("#reg_back_submit").click(function () {
                    $("#signup_msg_3").html("");
                    $("#signup_msg_2").html("");
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
