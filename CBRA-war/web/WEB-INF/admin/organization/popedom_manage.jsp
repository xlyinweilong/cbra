<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
    response.addHeader("Cache-Control", "no-store,no-cache,must-revalidate");
    response.addHeader("Cache-Control", "post-check=0,pre-check=0");
    response.addHeader("Expires", "0");
    response.addHeader("Pragma", "no-cache");
    response.setCharacterEncoding("utf-8");
    String path = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
    <head>
        <title></title>
        <link href="<%=path %>/background/css/style.css" rel="stylesheet" type="text/css" />
        <script type="text/javascript" src="<%=path %>/background/js/jquery.js"></script>
        <script type="text/javascript" src="<%=path %>/background/js/validate/jquery.validate.js"></script>
        <script type="text/javascript" src="<%=path %>/background/js/common/common.js"></script>
        <script type="text/javascript">
            $(document).ready(function () {
                $("#treeFrame").css("height", $("#rightFrame", parent.document).height() - $(".place").height());
                $("#listFrame").css("height", $("#rightFrame", parent.document).height() - $(".place").height());
            });
        </script>
    </head>
    <body>
        <div class="place">
            <span>位置：</span>
            <ul class="placeul">
                <li>
                    <a href="#">首页</a>
                </li>
                <li>
                    <a href="#">组织机构</a>
                </li>
                <li>
                    <a href="#">授权管理</a>
                </li>
            </ul>
        </div>
        <table style="width:100%;">
            <tr>
                <td style="border-right: 1px solid #dedede;width:200px;"><iframe id="treeFrame" name="treeFrame" src="/admin/organization/popedom_menu" frameborder="0" scrolling="auto" style="width:100%; height:100%"></iframe></td>
                <td><iframe id="listFrame" name="listFrame" src="about:blank" frameborder="0" scrolling="auto" style="width:100%; height:100%"></iframe></td>
            </tr>
        </table>
    </body>
</html>
