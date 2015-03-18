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
        var Keditor;
        $(function () {
            $("#saveBtn").click(function () {
                var rules = {
                    "title": {required: true},
                    "statusBeginDate": {required: true},
                    "statusEndDate": {required: true},
                    "eventBeginDate": {required: true},
                    "eventEndDate": {required: true},
                    "checkinDate": {required: true}
                };
                var messages = {
                    "title": {required: "标题必须填写！"},
                    "statusBeginDate": {required: "报名开始时间必须填写！"},
                    "statusEndDate": {required: "报名结束时间必须填写！"},
                    "eventBeginDate": {required: "活动开始时间必须填写！"},
                    "eventEndDate": {required: "活动结束时间必须填写！"},
                    "checkinDate": {required: "签到时间必须填写！"}
                };
                if (Keditor != null) {
                    Keditor.sync();
                }
                //初始化验证框架
                FormSave("form1", rules, messages);
                $("#form1").attr("action", "/admin/plate/event_info");
                $("#form1").submit();
            });
            $("#gobackBtn").click(function () {
                window.location.href = "/admin/plate/event_list?plateId=${plate.id}";
            });
        });
    </script>
    <body>
        <div class="formbody">
            <div class="formtitle"><span>${plate.name}</span></div>
            <form id="form1" name="form1" method="post" enctype="multipart/form-data">
                <input type="hidden" name="a" value="EVENT_CREATE_OR_UPDATE" />
                <input type="hidden" name="id" value="${fundCollection.id}" />
                <input type="hidden" name="plateId" value="${plate.id}" />
                <ul class="forminfo">
                    <li>
                        <label>手机介绍图片</label>
                        <input type="file" class="dfinput" style="width: 350px;" name="mobileImage" /><c:if test="${not empty fundCollection.introductionImageUrl}"><a href="${fundCollection.introductionImageUrl}"  target="_blank">查看</a></c:if>
                    </li> 
                    <li>
                        <label>手机介绍简介</label>
                        <textarea name="mobileIntroduction" class="dfinput"  style="width: 350px;height: 150px">${fundCollection.introduction}</textarea>
                    </li>
                    <li>
                        <label>介绍图片</label>
                        <input type="file" class="dfinput" style="width: 350px;" name="image" /><c:if test="${not empty fundCollection.imageUrl}"><a href="${fundCollection.imageUrl}"  target="_blank">查看</a></c:if>
                        </li> 
                        <li><label>标题<b>*</b></label>
                            <input type="text" class="dfinput" style="width: 350px;" name="title" value="${fundCollection.title}" maxlength="100" />
                    </li>
                    <li><label>报名开始时间<b>*</b></label>
                        <input type="text" class="dfinput" style="width: 350px;" name="statusBeginDate" onclick="WdatePicker({dateFmt: 'yyyy-MM-dd HH:mm:ss'})" value="<fmt:formatDate value='${fundCollection.statusBeginDate}' pattern='yyyy-MM-dd HH:mm:ss' type='date' dateStyle='long' />" maxlength="25" />
                    </li>
                    <li><label>报名结束时间<b>*</b></label>
                        <input type="text" class="dfinput" style="width: 350px;" name="statusEndDate" onclick="WdatePicker({dateFmt: 'yyyy-MM-dd HH:mm:ss'})" value="<fmt:formatDate value='${fundCollection.statusEndDate}' pattern='yyyy-MM-dd HH:mm:ss' type='date' dateStyle='long' />" maxlength="25" />
                    </li>
                    <li><label>活动开始时间<b>*</b></label>
                        <input type="text" class="dfinput" style="width: 350px;" name="eventBeginDate" onclick="WdatePicker({dateFmt: 'yyyy-MM-dd HH:mm:ss'})" value="<fmt:formatDate value='${fundCollection.eventBeginDate}' pattern='yyyy-MM-dd HH:mm:ss' type='date' dateStyle='long' />" maxlength="25" />
                    </li>
                    <li><label>活动结束时间<b>*</b></label>
                        <input type="text" class="dfinput" style="width: 350px;" name="eventEndDate" onclick="WdatePicker({dateFmt: 'yyyy-MM-dd HH:mm:ss'})" value="<fmt:formatDate value='${fundCollection.eventEndDate}' pattern='yyyy-MM-dd HH:mm:ss' type='date' dateStyle='long' />" maxlength="25" />
                    </li>
                    <li><label>签到时间<b>*</b></label>
                        <input type="text" class="dfinput" style="width: 350px;" name="checkinDate" onclick="WdatePicker({dateFmt: 'yyyy-MM-dd HH:mm:ss'})" value="<fmt:formatDate value='${fundCollection.checkinDate}' pattern='yyyy-MM-dd HH:mm:ss' type='date' dateStyle='long' />" maxlength="25" />
                    </li>
                    <li><label>会议地点</label>
                        <input type="text" class="dfinput" style="width: 350px;" name="eventLocation" value="${fundCollection.eventLocation}" maxlength="100" />
                    </li>
                    <li><label>游客价格</label>
                        <input type="text" class="dfinput" style="width: 350px;" name="touristPrice" value="${fundCollection.touristPrice}" maxlength="100" />元
                    </li>
                    <li><label>个人会员价格</label>
                        <input type="text" class="dfinput" style="width: 350px;" name="userPrice" value="${fundCollection.userPrice}" maxlength="100" />元
                    </li>
                    <li><label>企业会员价格</label>
                        <input type="text" class="dfinput" style="width: 350px;" name="companyPrice" value="${fundCollection.companyPrice}" maxlength="100" />元
                    </li>
                    <li><label>企业会员免费数</label>
                        <input type="text" class="dfinput" style="width: 350px;" name="eachCompanyFreeCount" value="${fundCollection.eachCompanyFreeCount}" maxlength="100" />
                    </li>
                    <li><label>游客权限</label>
                        <select name="touristAuth" class="dfinput" style="width: 354px;">
                            <c:forEach var="plateAuthEnum" items="${plateAuthEnumList}">
                                <option value="${plateAuthEnum.name()}" <c:if test="${plateAuthEnum == fundCollection.touristAuth}">selected="selected"</c:if>>
                                    ${plateAuthEnum.authMean}
                                </option>
                            </c:forEach>
                        </select>
                    </li>
                    <li><label>个人会员权限</label>
                        <select name="userAuth" class="dfinput" style="width: 354px;">
                            <c:forEach var="plateAuthEnum" items="${plateAuthEnumList}">
                                <option value="${plateAuthEnum.name()}" <c:if test="${plateAuthEnum == fundCollection.userAuth}">selected="selected"</c:if>>
                                    ${plateAuthEnum.authMean}
                                </option>
                            </c:forEach>
                        </select>
                    </li>
                    <li><label>公司会员权限</label>
                        <select name="companyAuth" class="dfinput" style="width: 354px;">
                            <c:forEach var="plateAuthEnum" items="${plateAuthEnumList}">
                                <option value="${plateAuthEnum.name()}" <c:if test="${plateAuthEnum == fundCollection.companyAuth}">selected="selected"</c:if>>
                                    ${plateAuthEnum.authMean}
                                </option>
                            </c:forEach>
                        </select>
                    </li>
                    <li><label>允许的参加者<b>*</b></label>
                        <select name="allowAttendee" class="dfinput" style="width: 354px;">
                            <c:forEach var="allowAttendeeEnum" items="${allowAttendeeEnumList}">
                                <option value="${allowAttendeeEnum.name()}" <c:if test="${allowAttendeeEnum == fundCollection.allowAttendee}">selected="selected"</c:if>>
                                    ${allowAttendeeEnum.mean}
                                </option>
                            </c:forEach>
                        </select>
                    </li>
                    <li><label>描述</label>
                        <textarea name="detailDescHtml" id="htmlKeditor" style="width: 600px;height: 600px">${fundCollection.detailDescHtml}</textarea>
                    </li>
                    <li><label>语言类型<b>*</b></label>
                        <select name="languageType" class="dfinput" style="width: 354px;">
                            <c:forEach var="languageType" items="${languageTypeList}">
                                <option value="${languageType.name()}" <c:if test="${languageType == fundCollection.eventLanguage}">selected="selected"</c:if>>
                                    ${languageType.mean}
                                </option>
                            </c:forEach>
                        </select>
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
                    KindEditor.ready(function (K) {
                        Keditor = createKindEditor("htmlKeditor", 0, null, null);
                        function createKindEditor(className, resizeType, width, height) {
                            return K.create('textarea[id="' + className + '"]', {
                                resizeType: resizeType,
                                uploadJson: '/admin/ke_upload',
                                fileManagerJson: '/admin/ke_manager',
                                delFile: '/admin/ke_del',
                                allowFileManager: true,
                                width: width,
                                height: height
                            });
                        }
                    });
                });
        </script>
    </body>
</html>
