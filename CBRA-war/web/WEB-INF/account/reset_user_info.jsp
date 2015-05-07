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
        <jsp:include page="/WEB-INF/account/z_account_banner.jsp" />
        <!-- 主体 -->
        <div class="mc-main">
            <table width="1000" border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td valign="top" class="fl-nav">
                        <jsp:include page="/WEB-INF/account/z_left.jsp"><jsp:param name="page" value="1" /></jsp:include>
                        </td>
                        <td valign="top" class="fr-c">
                            <div class="top-xx">
                                <div class="img">
                                <c:choose>
                                    <c:when test="${empty user.headImageUrl}"><img src="/ls/ls-26.jpg"></c:when>
                                    <c:otherwise><img style="width: 100px; height: 100px;" src="${user.headImageUrl}"></c:otherwise>
                                </c:choose>
                            </div>
                            <form id="infoform" action="/account/reset_user_info" method="post" enctype="multipart/form-data">
                                <div class="hyxx">
                                    <div class="hy-tit"><fmt:message key="GLOBAL_欢迎回来" bundle="${bundle}"/><span>${user.name}</span></div>
                                    <div class="hy-titxx"><fmt:message key="GLOBAL_入会时间" bundle="${bundle}"/>：<span><fmt:formatDate value="${user.createDate}" pattern="yyyy-MM-dd" type="date" dateStyle="long" /></span>　　　<fmt:message key="GLOBAL_入会年限" bundle="${bundle}"/>：<span>${user.createYear}</span> <fmt:message key="GLOBAL_年" bundle="${bundle}"/>　　　<fmt:message key="GLOBAL_已报名活动" bundle="${bundle}"/>：<span>${user.enrolledCount}</span>　　　<fmt:message key="GLOBAL_已参加活动" bundle="${bundle}"/>：<span>${user.joinedCount}</span></div>
                                    <div class="hy-titrz"><fmt:message key="GLOBAL_头像" bundle="${bundle}"/>：<input type="file" name="headImage"/></div>
                                        <%--
                                        <div class="hy-titrz"><span class="rzimg-1">实名认证</span><span class="rzimg-2">营业执照认证</span><span class="rzimg-3">手机认证</span><span class="rzimg-4">邮箱认证</span></div>--%>
                                </div>
                        </div>
                        <div class="noticeMessage">
                            <div id="successMessage" class="successMessage"><c:if test="${not empty postResult.singleSuccessMsg}">${postResult.singleSuccessMsg}</c:if></div>
                            <div id="wrongMessage" class="wrongMessage"><c:if test="${not empty postResult.singleErrorMsg}">${postResult.singleErrorMsg}</c:if></div>
                            </div>
                            <input type="hidden" name="a" value="reset_user_info" />
                        <c:choose>
                            <c:when test="${user.type == 'USER'}">
                                <table width="760" border="0" cellpadding="0" cellspacing="1" style="background:#ebebeb; margin-top:20px;">
                                    <tr>
                                        <td class="hyzl-1"><fmt:message key="GLOBAL_中文姓名" bundle="${bundle}"/></td>
                                        <td class="hyzl-2">${user.name}</td>
                                        <td class="hyzl-1"><fmt:message key="GLOBAL_英文姓名" bundle="${bundle}"/></td>
                                        <td class="hyzl-2"><input id="enName" class="Input-1" type="text" name="enName" value="${user.enName}" style="height: 30px; width: 200px;" /></td>
                                    </tr>
                                    <tr>
                                        <td class="hyzl-1"><fmt:message key="GLOBAL_手机" bundle="${bundle}"/></td>
                                        <td class="hyzl-2">${user.account}</td>
                                        <td class="hyzl-1">EMAIL</td>
                                        <td class="hyzl-2"><input id="email" class="Input-1" type="text" value="${user.email}" name="email" style="height: 30px; width: 200px;" /></td>
                                    </tr>
                                    <tr>
                                        <td class="hyzl-1"><fmt:message key="GLOBAL_行业从业时间" bundle="${bundle}"/></td>
                                        <td class="hyzl-2"><input id="workingYear" class="Input-1" type="text" value="${user.workingYear}" name="workingYear" style="height: 30px; width: 180px;" />&nbsp;<fmt:message key="GLOBAL_年" bundle="${bundle}"/></td>
                                        <td class="hyzl-1"><fmt:message key="GLOBAL_目前就职公司" bundle="${bundle}"/></td>
                                        <td class="hyzl-2"><input id="company" class="Input-1" type="text" value="${user.company}" name="company" style="height: 30px; width: 200px;" /></td>
                                    </tr>
                                    <tr>
                                        <td class="hyzl-1"><fmt:message key="GLOBAL_职务" bundle="${bundle}"/></td>
                                        <td class="hyzl-2">
                                            <span style="padding-right: 15px;">
                                                <select id="position" name="position" class="Input-1" style="height: 30px; width: 200px;">
                                                    <c:forEach var="position" items="${positions}">
                                                        <option <c:if test="${position == user.position}">selected="selected"</c:if> value="${position.name()}">${position.mean}</option>
                                                    </c:forEach>
                                                    <option value="others"><fmt:message key="GLOBAL_其他" bundle="${bundle}"/></option>
                                                </select>
                                            </span>
                                        </td>
                                        <td id="others_td_1" class="hyzl-1" <c:if test="${empty user.positionOthers}">style="display: none"</c:if>><fmt:message key="GLOBAL_其他" bundle="${bundle}"/></td>
                                        <td id="others_td_2" class="hyzl-2" <c:if test="${empty user.positionOthers}">style="display: none"</c:if>>
                                                <input id="others" class="Input-1" type="text" name="others" style="height: 30px; width: 200px;" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="hyzl-1"><fmt:message key="GLOBAL_邮寄地址" bundle="${bundle}"/></td>
                                            <td class="hyzl-2"><input id="address" class="Input-1" type="text" value="${user.address}" name="address" style="height: 30px; width: 200px;" /></td>
                                        <td class="hyzl-1"><fmt:message key="GLOBAL_邮编" bundle="${bundle}"/></td>
                                        <td class="hyzl-2"><input id="zipCode" class="Input-1" type="text" value="${user.zipCode}" name="zipCode" style="height: 30px; width: 200px;" /></td>
                                    </tr>
                                </table>
                                <table width="760" border="0" cellpadding="0" cellspacing="1" style="background:#ebebeb; margin-top:20px;">
                                    <tr>
                                        <td class="hyzl-1"><fmt:message key="GLOBAL_产业链位置" bundle="${bundle}"/></td>
                                        <td class="hyzl-3">
                                            <c:forEach var="icPosition" items="${icPositions}">
                                                <input type="checkbox" <c:if test="${positionList.contains(icPosition.key)}">checked="checked"</c:if> name="icPositions" value="${icPosition.key}" />${icPosition.name}&nbsp&nbsp&nbsp&nbsp
                                            </c:forEach>
                                        </td>
                                    </tr>
                                </table>
                                <table width="760" border="0" cellpadding="0" cellspacing="1" style="background:#ebebeb; margin-top:20px;">
                                    <tr>
                                        <td class="hyzl-1"><fmt:message key="GLOBAL_工作履历" bundle="${bundle}"/></td>
                                        <td class="hyzl-3">
                                            <textarea id="workExperience" name="workExperience" style="width:600px; height:150px; border:1px #e6e6e6 solid;">${user.workExperience}</textarea>
                                        </td>
                                    </tr>
                                </table>
                                <table width="760" border="0" cellpadding="0" cellspacing="1" style="background:#ebebeb; margin-top:20px;">
                                    <tr>
                                        <td class="hyzl-1"><fmt:message key="GLOBAL_项目经验" bundle="${bundle}"/></td>
                                        <td class="hyzl-3">
                                            <textarea id="projectExperience" name="projectExperience" style="width:600px; height:150px; border:1px #e6e6e6 solid;">${user.projectExperience}</textarea>
                                        </td>
                                    </tr>
                                </table>
                            </c:when>
                            <c:when test="${user.type == 'COMPANY'}">
                                <table width="760" border="0" cellpadding="0" cellspacing="1" style="background:#ebebeb; margin-top:20px;">
                                    <tr>
                                        <td class="hyzl-1"><fmt:message key="GLOBAL_企业全称" bundle="${bundle}"/></td>
                                        <td class="hyzl-2">${user.name}</td>
                                        <td class="hyzl-1"><fmt:message key="GLOBAL_营业执照注册号" bundle="${bundle}"/></td>
                                        <td class="hyzl-2">${user.account}</td>
                                    </tr>
                                    <tr>
                                        <td class="hyzl-1"><fmt:message key="GLOBAL_企业邮箱" bundle="${bundle}"/></td>
                                        <td class="hyzl-2"><input id="email" class="Input-1" type="text" value="${user.email}" name="email" style="height: 30px; width: 200px;" /></td>
                                        <td class="hyzl-1"><fmt:message key="GLOBAL_创立时间" bundle="${bundle}"/></td>
                                        <td class="hyzl-2"><fmt:formatDate value="${user.companyCreateDate}" pattern="yyyy-MM-dd" type="date" dateStyle="long" /></td>
                                    </tr>
                                    <tr>
                                        <td class="hyzl-1"><fmt:message key="GLOBAL_企业法人" bundle="${bundle}"/></td>
                                        <td class="hyzl-2">${user.legalPerson}</td>
                                        <td class="hyzl-1"><fmt:message key="GLOBAL_企业人数" bundle="${bundle}"/></td>
                                        <td class="hyzl-2">
                                            <select id="scale" name="scale" class="Input-1" style="height: 30px; width: 200px;">
                                                <c:forEach var="companyScaleEnum" items="${companyScaleEnums}">
                                                    <option <c:if test="${companyScaleEnum == user.scale}">selected="selected"</c:if> value="${companyScaleEnum.name()}">${companyScaleEnum.mean}</option>
                                                </c:forEach>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="hyzl-1"><fmt:message key="GLOBAL_企业性质" bundle="${bundle}"/></td>
                                        <td class="hyzl-2" colspan="3">${user.getNatureString(bundle)}</td>
                                    </tr>
                                    <tr>
                                    <tr>
                                        <td class="hyzl-1"><fmt:message key="GLOBAL_企业地址" bundle="${bundle}"/></td>
                                        <td class="hyzl-2"><input id="address" class="Input-1" type="text" value="${user.address}" name="address" style="height: 30px; width: 200px;" /></td>
                                        <td class="hyzl-1"><fmt:message key="GLOBAL_邮编" bundle="${bundle}"/></td>
                                        <td class="hyzl-2"><input id="zipCode" class="Input-1" type="text" value="${user.zipCode}" name="zipCode" style="height: 30px; width: 200px;" /></td>
                                    </tr>
                        </tr>
                    </table>
                    <table width="760" border="0" cellpadding="0" cellspacing="1" style="background:#ebebeb; margin-top:20px;">
                        <tr>
                            <td class="hyzl-1"><fmt:message key="GLOBAL_产业链位置" bundle="${bundle}"/></td>
                            <td class="hyzl-3">
                                <c:forEach var="icPosition" items="${icPositions}">
                                    <input type="checkbox" <c:if test="${positionList.contains(icPosition.key)}">checked="checked"</c:if> name="icPositions" value="${icPosition.key}" />${icPosition.name}&nbsp&nbsp&nbsp&nbsp
                                </c:forEach>
                            </td>
                        </tr>
                    </table>
                    <c:if test="${not empty subCompanyAccountList}">
                        <table width="760" border="0" cellpadding="0" cellspacing="1" style="background:#ebebeb; margin-top:20px;">
                            <c:forEach var="subCompanyAccount" items="${subCompanyAccountList}">
                                <tr>
                                    <td class="hyzl-1"><fmt:message key="GLOBAL_登录代表信息" bundle="${bundle}"/></td>
                                    <td class="hyzl-3"><fmt:message key="GLOBAL_登录代表帐号" bundle="${bundle}"/>：${subCompanyAccount.account}<br></td>
                                </tr>
                            </c:forEach>
                        </table>
                    </c:if>
                </c:when>
            </c:choose>
        </form>
        <div style="text-align:center; margin:10px auto;">
            <input id="submitFormButton" type="button" style=" width:130px; height:42px; line-height:42px; background:#52853d; color:#FFF; border:0; border-radius:5px; font-size:14px; cursor:pointer;" value="<fmt:message key="GLOBAL_提交" bundle="${bundle}"/>">
        <c:if test="${user.type == 'USER'}"><input onclick="location.href='/account/overview'" type="button" style=" width:130px; height:42px; line-height:42px; background:#52853d; color:#FFF; border:0; border-radius:5px; font-size:14px; cursor:pointer;" value="<fmt:message key="GLOBAL_取消" bundle="${bundle}"/>"></c:if>
        <c:if test="${user.type != 'USER'}"><input onclick="location.href='/account/overview_c'" type="button" style=" width:130px; height:42px; line-height:42px; background:#52853d; color:#FFF; border:0; border-radius:5px; font-size:14px; cursor:pointer;" value="<fmt:message key="GLOBAL_取消" bundle="${bundle}"/>"></c:if>
        </div>
    </td>
</tr>
</table>
<div style="clear:both;"></div>
</div>
<!-- 主体 end -->
<jsp:include page="/WEB-INF/public/z_end.jsp"/>
<script type="text/javascript">
    <c:if test="${user.type == 'USER'}">
            $(document).ready(function () {
                $("#position").change(function () {
                    if ($("#position").val() === 'others') {
                        $("#others_td_1").show();
                        $("#others_td_2").show();
                    } else {
                        $("#others_td_1").hide();
                        $("#others_td_2").hide();
                    }
                });
                $("#submitFormButton").click(function () {
                    $("#successMessage").html("");
                    $("#wrongMessage").html("");
                    if (CBRAValid.checkFormValueNull($("#email"))) {
                        CBRAMessage.showWrongMessageAndBorderEle($("#wrongMessage"), "<fmt:message key="GLOBAL_请输入邮箱" bundle="${bundle}"/>", $("#email"));
                        return;
                    }
                    if (CBRAValid.checkFormValueNull($("#workingYear"))) {
                        CBRAMessage.showWrongMessageAndBorderEle($("#wrongMessage"), "<fmt:message key="GLOBAL_请输入从业年限" bundle="${bundle}"/>", $("#workingYear"));
                        return;
                    }
                    if (isNaN($('#workingYear').val())) {
                        CBRAMessage.showWrongMessageAndBorderEle($("#wrongMessage"), "<fmt:message key="GLOBAL_从业年限必须是数字" bundle="${bundle}"/>", $("#workingYear"));
                        return;
                    }
                    if (CBRAValid.checkFormValueNull($("#company"))) {
                        CBRAMessage.showWrongMessageAndBorderEle($("#wrongMessage"), "<fmt:message key="GLOBAL_请输入就职公司" bundle="${bundle}"/>", $("#company"));
                        return;
                    }
                    if ($("#position").val() == '') {
                        CBRAMessage.showWrongMessageAndBorderEle($("#wrongMessage"), "<fmt:message key="GLOBAL_请选择职务" bundle="${bundle}"/>", $("#position"));
                        return;
                    }
                    if ($("#position").val() == 'others' && CBRAValid.checkFormValueNull($("#others"))) {
                        CBRAMessage.showWrongMessageAndBorderEle($("#signup_msg_1"), "<fmt:message key="GLOBAL_请输入其他职务" bundle="${bundle}"/>", $("#others"));
                        return;
                    }
                    if (CBRAValid.checkFormValueNull($("#address"))) {
                        CBRAMessage.showWrongMessageAndBorderEle($("#wrongMessage"), "<fmt:message key="GLOBAL_请输入邮寄地址" bundle="${bundle}"/>", $("#address"));
                        return;
                    }
                    if (CBRAValid.checkFormValueNull($("#zipCode"))) {
                        CBRAMessage.showWrongMessageAndBorderEle($("#wrongMessage"), "<fmt:message key="GLOBAL_请输入邮编" bundle="${bundle}"/>", $("#zipCode"));
                        return;
                    }
                    if ($.trim($("#workExperience").val()) == "") {
                        CBRAMessage.showMessage($("#wrongMessage"), "<fmt:message key="GLOBAL_请输入工作履历" bundle="${bundle}"/>");
                        return;
                    }
                    if ($.trim($("#projectExperience").val()) == "") {
                        CBRAMessage.showMessage($("#wrongMessage"), "<fmt:message key="GLOBAL_请输入项目经验" bundle="${bundle}"/>");
                        return;
                    }
                    $("#infoform").submit();
                });
            });
    </c:if>
    <c:if test="${user.type == 'COMPANY'}">
            $(document).ready(function () {
                $("#submitFormButton").click(function () {
                    $("#successMessage").html("");
                    $("#wrongMessage").html("");
                    if (CBRAValid.checkFormValueNull($("#email"))) {
                        CBRAMessage.showWrongMessageAndBorderEle($("#wrongMessage"), "<fmt:message key="GLOBAL_请输入邮箱" bundle="${bundle}"/>", $("#email"));
                        return;
                    }
                    if (CBRAValid.checkFormValueNull($("#address"))) {
                        CBRAMessage.showWrongMessageAndBorderEle($("#wrongMessage"), "<fmt:message key="GLOBAL_请输入企业地址" bundle="${bundle}"/>", $("#address"));
                        return;
                    }
                    if (CBRAValid.checkFormValueNull($("#zipCode"))) {
                        CBRAMessage.showWrongMessageAndBorderEle($("#wrongMessage"), "<fmt:message key="GLOBAL_请输入邮编" bundle="${bundle}"/>", $("#zipCode"));
                        return;
                    }
                    $("#infoform").submit();
                });
            });
    </c:if>
</script>
</body>
</html>
