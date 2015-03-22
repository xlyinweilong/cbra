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
                var KeditorEn;
                $(function () {
                $("#saveBtn").click(function () {
                var rules = {
        <c:if test="${plate.plateKey == 'NEWS' || plate.plateKey == 'COMMITTEE'}">
                "title": {required: true},
                        "introduction": {required: true},
                        "content": {required: true},
        </c:if>
                <c:if test="${plate.plateType == 'AD'}">
                    "title": {required: true},
                </c:if>
                "pushDate": {required: true}
                };
                        var messages = {
                         <c:if test="${plate.plateKey == 'NEWS' || plate.plateKey == 'COMMITTEE'}">
                            "title": {required: "必须填写！"},
                            "introduction": {required: "简介必须填写！"},
                             "content": {required: "内容必须填写！"},
                        </c:if>
                        <c:if test="${plate.plateType == 'AD'}">
                            "title": {required: "必须填写！"},
                        </c:if>
                            "pushDate": {required: "发布时间必须填写！"}
                        };
                        //初始化验证框架
                        FormSave("form1", rules, messages);
                        $("#form1").attr("action", "/admin/plate/plate_info_info");
//                Keditor.html('');
                if(Keditor != null){
                     Keditor.sync();
                }
        <c:if test="${plate.plateKey == 'ABOUT' || plate.plateKey == 'CONTACT_US'}">
                KeditorEn.sync();
        </c:if>
                $("#form1").submit();
                });
                        $("#gobackBtn").click(function () {
                window.location.href = "/admin/plate/plate_info_list?plateId=${plate.id}";
                });
                });
    </script>
    <body>
        <div class="formbody">
            <div class="formtitle"><span>${plate.name}</span></div>
            <form id="form1" name="form1" method="post" enctype="multipart/form-data">
                <input type="hidden" name="a" value="PLATE_INFO_CREATE_OR_UPDATE" />
                <input type="hidden" name="id" value="${plateInfo.id}" />
                <input type="hidden" name="plateId" value="${plate.id}" />
                <ul class="forminfo">
                    <c:if test="${plate.plateKey == 'NEWS'}">
                        <li><label>标题<b>*</b></label>
                            <input type="text" class="dfinput" style="width: 350px;" name="title" value="${plateInfo.title}" maxlength="100" />
                        </li>
                    </c:if>
                    <c:if test="${plate.plateKey == 'COMMITTEE'}">
                        <li><label>姓名<b>*</b></label>
                            <input type="text" class="dfinput" style="width: 350px;" name="title" value="${plateInfo.title}" maxlength="100" />
                        </li>
                    </c:if>
                    <c:if test="${plate.plateType == 'AD'}">
                        <li><label>名称<b>*</b></label>
                            <input type="text" class="dfinput" style="width: 350px;" name="title" value="${plateInfo.title}" maxlength="100" />
                        </li>
                        <li>
                            <label>图片</label>
                            <input type="file" class="dfinput" style="width: 350px;" name="image" />
                            <c:if test="${not empty plateInfo.picUrl}"><a href="${plateInfo.picUrl}" target="_blank">查看</a></c:if>
                        </li>
                        <li>
                            <label>链接</label>
                            <input type="text" class="dfinput" style="width: 350px;" name="navUrl" value="${plateInfo.navUrl}" maxlength="100" />
                        </li> 
                    </c:if>
                    <c:if test="${plate.plateKey == 'NEWS' || plate.plateKey == 'COMMITTEE'}">
                        <li><label>简介<b>*</b></label>
                            <textarea name="introduction" class="dfinput"  style="width: 350px;height: 150px">${plateInfo.introduction}</textarea>
                        </li>
                        <li>
                            <label>介绍图片</label>
                            <input type="file" class="dfinput" style="width: 350px;" name="image" />
                            <c:if test="${not empty plateInfo.picUrl}"><a href="${plateInfo.picUrl}" target="_blank">查看</a></c:if>
                        </li> 
                        <li>
                            <label>链接</label>
                            <input type="text" class="dfinput" style="width: 350px;" name="navUrl" value="${plateInfo.navUrl}" maxlength="100" />
                        </li> 
                    </c:if>
                    <c:if test="${plate.plateKey == 'HOME_ABOUT' || plate.plateKey == 'TOP_INTO' || plate.plateKey == 'TOP_EVENT' || plate.plateKey == 'TOP_TRAIN' || plate.plateKey == 'TOP_STYLE' || plate.plateKey == 'TOP_JOIN'}">
                        <li><label>简介<b>*</b></label>
                            <textarea name="introduction" class="dfinput"  style="width: 350px;height: 150px">${plateInfo.introduction}</textarea>
                        </li>
                    </c:if>
                    <c:if test="${plate.plateType != 'AD'}">
                        <li><label><c:if test="${plate.plateKey == 'ABOUT'}">中文</c:if>内容<b>*</b></label>
                            <textarea name="content" id="htmlKeditor" style="width: 600px;height: 600px">${plateInfo.plateInformationContent.content}</textarea>
                        </li>
                    </c:if>
                    <c:if test="${plate.plateKey == 'ABOUT' || plate.plateKey == 'CONTACT_US'}">
                        <li><label>英文内容<b>*</b></label>
                            <textarea name="contentEn" id="htmlKeditorEn" style="width: 600px;height: 600px">${plateEnInfo.plateInformationContent.content}</textarea>
                        </li>
                    </c:if>
                    <c:if test="${plate.plateKey == 'NEWS' || plate.plateKey == 'COMMITTEE' || plate.plateType == 'AD'}">
                        <li><label>语言类型<b>*</b></label>
                            <select name="languageType" class="dfinput" style="width: 354px;">
                                <c:forEach var="languageType" items="${languageTypeList}">
                                    <option value="${languageType.name()}" <c:if test="${languageType == plateInfo.language}">selected="selected"</c:if>>
                                        ${languageType.languageMean}
                                    </option>
                                </c:forEach>
                            </select>
                        </li>
                    </c:if>
                    <li><label>发布时间<b>*</b></label>
                        <input type="text" class="dfinput" style="width: 350px;" name="pushDate" onclick="WdatePicker({dateFmt: 'yyyy-MM-dd HH:mm:ss'})" value="<fmt:formatDate value='${plateInfo.pushDate}' pattern='yyyy-MM-dd HH:mm:ss' type='date' dateStyle='long' />" maxlength="25" />
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
            <c:if test="${plate.plateKey == 'ABOUT' || plate.plateKey == 'CONTACT_US'}">
                KeditorEn = createKindEditor("htmlKeditorEn", 0, null, null);
            </c:if>
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
