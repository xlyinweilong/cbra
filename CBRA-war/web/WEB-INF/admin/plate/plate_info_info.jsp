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
                    "pushDate": {required: true}
                };
                var messages = {
                    "pushDate": {required: "发布时间必须填写！"}
                };
                //初始化验证框架
                FormSave("form1", rules, messages);
                $("#form1").attr("target", "iframe1");
                $("#form1").attr("action", "/admin/plate/plate_info_info");
//                Keditor.html('');
		Keditor.sync();
                $("#form1").submit();
            });
            $("#gobackBtn").click(function () {
                $("#form2").attr("target", "");
                $("#form2").attr("action", "/admin/plate/plate_info_list");
                $("#form2").submit();
            });
        });
    </script>
    <body>
        <div class="formbody">
            <div class="formtitle"><span>${plate.name}</span></div>
            <form id="form1" name="form1" method="post">
                <input type="hidden" name="a" value="PLATE_INFO_CREATE_OR_UPDATE" />
                <input type="hidden" name="id" value="${plateInfo.id}" />
                <input type="hidden" name="plateId" value="${plate.id}" />
                <ul class="forminfo">
                    <li><label>内容</label>
                        <textarea name="content" class="htmlKeditor" style="width: 600px;height: 600px">${plateInfo.plateInformationContent.content}</textarea>
                    </li>
                    <li><label>语言类型</label>
                        <select name="languageType" class="dfinput" style="width: 354px;">
                            <c:forEach var="languageType" items="${languageTypeList}">
                                <option value="${languageType.name()}" <c:if test="${languageType == plateInfo.language}">selected="selected"</c:if>>
                                    ${languageType.languageMean}
                                </option>
                            </c:forEach>
                        </select>
                    </li>
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
                KindEditor.ready(function (K) {
                    Keditor = createKindEditor("htmlKeditor", 0, null, null);
                    function createKindEditor(className, resizeType, width, height) {
                        return K.create('textarea[class="' + className + '"]', {
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
