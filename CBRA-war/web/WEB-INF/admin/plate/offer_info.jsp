<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    response.addHeader("Cache-Control", "no-store,no-cache,must-revalidate");
    response.addHeader("Cache-Control", "post-check=0,pre-check=0");
    response.addHeader("Expires", "0");
    response.addHeader("Pragma", "no-cache");
    response.setCharacterEncoding("utf-8");
    String path = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>无标题文档</title>
        <link rel="stylesheet" href="<%=path%>/background/css/style.css" type="text/css" />
        <link rel="stylesheet" href="<%=path%>/background/js/validate/tip-yellowsimple/tip-yellowsimple.css" type="text/css" />
        <link rel="stylesheet" href="<%=path%>/background/js/validate/tip-green/tip-green.css" type="text/css" />
        <script type="text/javascript" src="<%=path%>/background/js/jquery.js"></script>
        <script type="text/javascript" src="<%=path%>/background/js/validate/jquery.poshytip.js"></script>
        <script type="text/javascript" src="<%=path%>/background/js/validate/jquery.validate.js"></script>
        <script type="text/javascript" src="<%=path%>/background/js/My97DatePicker/WdatePicker.js"></script>
        <script type="text/javascript" src="<%=path%>/background/js/common/common.js"></script>
        <script type="text/javascript" src="<%=path%>/kindeditor-4.1.2/kindeditor.js"></script>
    </head>
    <script type="text/javascript">
        $(function () {
            $("#saveBtn").click(function () {
                var rules = {
                    "pushDate": {required: true}
                };
                var messages = {
                    "pushDate": {required: "发布时间必须填写！"}
                };
                //初始化验证框架
                FormSave("form1", rules, messages);
                $("#form1").attr("action", "/admin/plate/offer_info");
                $("#form1").submit();
            });
            $("#gobackBtn").click(function () {
                window.location.href = "/admin/plate/offer_list?plateId=${plate.id}";
            });
            $("#position").change(function () {
                if ($("#position").val() === 'others') {
                    $("#others").show();
                } else {
                    $("#others").hide();
                }
            });
        });
    </script>
    <body>
        <div class="formbody">
            <div class="formtitle"><span>${plate.name}</span></div>
            <form id="form1" name="form1" method="post" enctype="multipart/form-data">
                <input type="hidden" name="a" value="OFFER_CREATE_OR_UPDATE" />
                <input type="hidden" name="id" value="${offer.id}" />
                <input type="hidden" name="plateId" value="${plate.id}" />
                <ul class="forminfo">
                    <c:if test="${plate.plateKey == 'OFFER'}">
                        <c:if test="${plate.id == 30}">
                            <li><label>职位名称<b>*</b></label>
                                <input type="text" class="dfinput" style="width: 350px;" name="position" value="${offer.position}" maxlength="100" />
                            </li>
                            <li><label>部门</label>
                                <input type="text" class="dfinput" style="width: 350px;" name="depart" value="${offer.depart}" maxlength="100" />
                            </li>
                            <li><label>工作地区</label>
                                <input type="text" class="dfinput" style="width: 350px;" name="city" value="${offer.city}" maxlength="100" />
                            </li>
                            <li><label>岗位类别</label>
                                <input type="text" class="dfinput" style="width: 350px;" name="station" value="${offer.station}" maxlength="100" />
                            </li>
                            <li><label>招聘人数</label>
                                <input type="text" class="dfinput" style="width: 350px;" name="count" value="${offer.count}" maxlength="100" />
                            </li>
                            <li><label>月薪</label>
                                <input type="text" class="dfinput" style="width: 350px;" name="monthly" value="${offer.monthly}" maxlength="100" />
                            </li>
                            <li><label>职位描述</label>
                                <textarea name="description" class="dfinput"  style="width: 350px;height: 150px">${offer.description}</textarea>
                            </li>
                            <li><label>岗位职责</label>
                                <textarea name="duty" class="dfinput"  style="width: 350px;height: 150px">${offer.duty}</textarea>
                            </li>
                            <li><label>任职资格</label>
                                <textarea name="competence" class="dfinput"  style="width: 350px;height: 150px">${offer.competence}</textarea>
                            </li>
                            <li><label>年龄</label>
                                <input type="text" class="dfinput" style="width: 350px;" name="age" value="${offer.age}" maxlength="100" />
                            </li>
                            <li><label>性别</label>
                                <input type="text" class="dfinput" style="width: 350px;" name="gender" value="${offer.gender}" maxlength="100" />
                            </li>
                            <li><label>英语等级</label>
                                <input type="text" class="dfinput" style="width: 350px;" name="englishLevel" value="${offer.englishLevel}" maxlength="100" />
                            </li>
                            <li><label>学历</label>
                                <input type="text" class="dfinput" style="width: 350px;" name="education" value="${offer.education}" maxlength="100" />
                            </li>
                        </c:if>
                        <c:if test="${plate.id == 31}">
                            <li><label>中文姓名</label>
                                <input type="text" class="dfinput" style="width: 350px;" name="name" value="${offer.name}" maxlength="100" />
                            </li>
                            <li><label>英文名称</label>
                                <input type="text" class="dfinput" style="width: 350px;" name="enName" value="${offer.enName}" maxlength="100" />
                            </li>
                            <li><label>手机</label>
                                <input type="text" class="dfinput" style="width: 350px;" name="mobile" value="${offer.mobile}" maxlength="100" />
                            </li>
                            <li><label>email</label>
                                <input type="text" class="dfinput" style="width: 350px;" name="email" value="${offer.email}" maxlength="100" />
                            </li>
                            <li><label>从业年限</label>
                                <input type="text" class="dfinput" style="width: 350px;" name="obtain" value="${offer.obtain}" maxlength="100" />年
                            </li>
                            <li><label>目前就职公司</label>
                                <input type="text" class="dfinput" style="width: 350px;" name="company" value="${offer.company}" maxlength="100" />
                            </li>
                            <li><label>居住地址</label>
                                <input type="text" class="dfinput" style="width: 350px;" name="address" value="${offer.address}" maxlength="100" />
                            </li>
                            <li><label>邮编</label>
                                <input type="text" class="dfinput" style="width: 350px;" name="zipCode" value="${offer.zipCode}" maxlength="100" />
                            </li>
                            <li><label>职务</label><select id="position" name="positionEnum" class="dfinput">
                                    <c:forEach var="position" items="${positions}">
                                        <option <c:if test="${position == offer.positionEnum}">selected="selected"</c:if> value="${position.name()}">${position.mean}</option>
                                    </c:forEach>
                                    <option <c:if test="${not empty offer.positionOthers}">selected="selected"</c:if> value="others">其他</option>
                                    </select>
                                </li>
                                <li id="others" style="<c:if test="${empty offer.positionOthers}">display: none</c:if>"><label>其他</label><input type="text" class="dfinput" style="width: 350px;" name="others" value="${offer.positionOthers}" /></li>
                                <li><label>产业链位置</label>
                                <c:forEach var="accountIcPosition" items="${accountIcPositionList}">
                                    <input <c:if test="${positionList.contains(accountIcPosition.key)}">checked="checked"</c:if> type="checkbox" name="accountIcPosition" value="${accountIcPosition.key}" />${accountIcPosition.name}&nbsp;&nbsp;
                                </c:forEach>
                            </li>
                            <li><label>岗位职责</label>
                                <textarea name="duty" class="dfinput"  style="width: 350px;height: 150px">${offer.duty}</textarea>
                            </li>
                            <li><label>项目经验</label>
                                <textarea name="description" class="dfinput"  style="width: 350px;height: 150px">${offer.description}</textarea>
                            </li>
                            <li><label>简历</label>
                                <textarea name="competence" class="dfinput"  style="width: 350px;height: 150px">${offer.competence}</textarea>
                            </li>
                        </c:if>
                    </c:if>
                    <li><label>语言类型<b>*</b></label>
                        <select name="languageType" class="dfinput" style="width: 354px;">
                            <c:forEach var="languageType" items="${languageTypeList}">
                                <option value="${languageType.name()}" <c:if test="${languageType == offer.languageType}">selected="selected"</c:if>>
                                    ${languageType.languageMean}
                                </option>
                            </c:forEach>
                        </select>
                    </li>
                    <li><label>发布时间<b>*</b></label>
                        <input type="text" class="dfinput" style="width: 350px;" name="pushDate" onclick="WdatePicker({dateFmt: 'yyyy-MM-dd HH:mm:ss'})" value="<fmt:formatDate value='${offer.pushDate}' pattern='yyyy-MM-dd HH:mm:ss' type='date' dateStyle='long' />" maxlength="25" />
                    </li>
                    <li><label>&nbsp;</label>
                        <input id="saveBtn" name="saveBtn" type="button" class="btn" value="保存"/>
                        <c:if test="${showBackBtn}"><input id="gobackBtn" name="gobackBtn" type="button" class="btn" value="返回"/></c:if>
                        </li>
                    </ul>
                </form>
            </div>
            <iframe name="iframe1" id="iframe1" width="1px" height="1px"></iframe>
            <script type="text/javascript">
                $(document).ready(function () {
            <c:if test="${postResult.singleSuccessMsg != null}">alert("${postResult.singleSuccessMsg}");</c:if>
            <c:if test="${postResult.singleErrorMsg != null}">alert("${postResult.singleErrorMsg}");</c:if>
                });
        </script>
    </body>
</html>
