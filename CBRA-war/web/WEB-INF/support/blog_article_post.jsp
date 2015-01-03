<%-- 
    Document   : blog_article_post
    Created on : Nov 30, 2012, 2:27:08 PM
    Author     : wangshuai
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
    request.setAttribute("mainMenuSelection", "BLOG_ARTICLE_LIST");
    request.setAttribute("subMenuSelection", "");
%>

<%@include file="/WEB-INF/support/z_header.jsp"%>

<div style="border: 1px #00ADEE solid">
    <div id="msgDiv">
        <c:if test="${!empty postResult.singleErrorMsg}"> 
            ${postResult.singleErrorMsg}
        </c:if> 
        <c:if test="${postResult.success}"> 
            ${postResult.singleSuccessMsg}
        </c:if> 
    </div>
    <form action="/support/blog_article_post" method="POST">
        <table width="100%" border="0" cellpadding="5" cellspacing="0" style="border-color: blue">
            <tr>
                <td align="center" style="width:200px;font-weight: bold">标题</td>
                <td><input type="text" name="title" value="${article.title}" style="width: 600px;height: 20px;border: solid black 1px"/></td>
            </tr>
            <tr>
                <td align="center" style="width:200px;font-weight: bold">日期</td>
                <td>
                    <input type="text" name="create_date" id="create_date" readonly="readonly"
                           value="<fmt:formatDate value='${article.createDate}' type='date' pattern='yyyy/MM/dd' />" style="width: 200px;border: solid black 1px">
                </td>
            </tr>
            <tr>
                <td align="center" style="width:200px;font-weight: bold">显示顺序</td>
                <td><input type="text" name="list_order" value="${article.listOrder == null ? 0 : article.listOrder}" style="width: 100px;border: solid black 1px"/>（默认为0,值越大,显示越靠前）</td>
            </tr>
            <tr>
                <td align="center" style="width:200px;font-weight: bold">是否显示</td>
                <td><input type="checkbox" name="visible" <c:if test="${empty article || article.visible}">checked="checked"</c:if>/></td>
            </tr>
            <tr>
                <td align="center" style="width:200px;font-weight: bold">内容</td>
                <td><textarea name="content" id="content" style="width:600px;height:500px" >${article.content}</textarea></td>
            </tr>
            <tr>
                <td colspan="2" align="center">
                    <c:if test="${not empty article}">
                        <input type="hidden" name="aId" value="${article.id}" />
                    </c:if>
                    <input type="hidden" name="a" value="POST_BLOG_ARTICLE" />
                    <input type="submit" value="提交" style="font-size: 16px"/>
                </td>
            </tr>
        </table>
    </form>
</div>
<script type="text/javascript">
    $(document).ready(function(){
        var locale = "zh-CN";
        $.datepicker.setDefaults($.datepicker.regional[locale]);
        $( "#create_date" ).datepicker();
        KindEditor.ready(function(K) {
            var item = ['source', '|', 'undo', 'redo', '|', 'preview', 'print', 'template', 'code', 'cut', 'copy', 'paste',
                'plainpaste', 'wordpaste', '|', 'justifyleft', 'justifycenter', 'justifyright',
                'justifyfull', 'insertorderedlist', 'insertunorderedlist', 'indent', 'outdent', 'subscript',
                'superscript', 'clearhtml', 'quickformat', 'selectall', '|', 'fullscreen', '/',
                'formatblock', 'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold',
                'italic', 'underline', 'strikethrough', 'lineheight', 'removeformat', '|', 'image', 'multiimage',
                'flash', 'media', 'insertfile', 'table', 'hr', 'emoticons', 'baidumap', 'pagebreak',
                'anchor', 'link', 'unlink'];
            K.create('textarea[id="content"]', {
                items:item, 
                langType:"zh_CN",
                resizeType : 1,
                uploadJson : '/collect/upload_json',
                fileManagerJson : '/collect/file_manager_json',
                delFile:'/collect/file_manager_del_json',
                allowFileManager : true,
                width : 700,
                height : 500
            });
        });
    });
</script>

<jsp:include page="/WEB-INF/support/z_footer.jsp"/>
