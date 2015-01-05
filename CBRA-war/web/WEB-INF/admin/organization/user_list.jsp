<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
        <link href="<%=path%>/background/css/style.css" rel="stylesheet" type="text/css" />
        <script type="text/javascript" src="<%=path%>/background/js/jquery.js"></script>
        <script type="text/javascript" src="<%=path%>/background/js/validate/jquery.validate.js"></script>
        <script type="text/javascript" src="<%=path%>/background/js/common/common.js"></script>
        <script type="text/javascript">
            $(function () {
                $('.tablelist tbody tr:odd').addClass('odd');
                $.fn.CheckAllClick("cbk_all");
                $.fn.UnCheckAll("ids", "cbk_all");
                //显示添加界面
                $("#addBtn").click(function () {
                    window.location.href = "./userAction!showUser.action?user.id=&deptId=" + $("#deptId").val();
                });
                //删除所选设备信息
                $("#deleteBtn").click(function () {
                    $.fn.delete_items("ids", "./userAction!delete.action");
                });
                $(".tiptop a").click(function () {
                    $(".tip").fadeOut(200);
                });
            });
            //显示修改界面
            $.fn.edit = function (sid) {
                window.location.href = "./userAction!showUser.action?user.id=" + sid + "&deptId=" + $("#deptId").val();
            };
            //删除单个设备信息
            $.fn.deleteItem = function (sid) {
                var url = "./userAction!delete.action?ids=" + sid;
                if (confirm("您确定要删除这条信息吗？")) {
                    $.post(url, "", function (data) {
                        window.location.href = window.location.href;
                    });
                }
            };
        </script>
    </head>
    <body>
        <form id="form1" name="form1" method="post">
            <div class="rightinfo">
                <div class="tools">
                    <ul class="toolbar">
                        <li class="click" id="addBtn">
                            <span><img src="<%=path%>/background/images/t01.png" />
                            </span>添加
                        </li>
                        <li class="click" id="deleteBtn">
                            <span><img src="<%=path%>/background/images/t03.png" />
                            </span>删除
                        </li>
                    </ul>
                    <ul class="toolbar1">
                    </ul>
                </div>
                <table class="tablelist">
                    <thead>
                        <tr>
                            <th>
                                <input name="cbk_all" id="cbk_all" type="checkbox" value="1" />
                            </th>
                            <th>
                                用户名
                            </th>
                            <th>
                                中文姓名
                            </th>
                            <th>
                                角色
                            </th>
                            <th>
                                手机
                            </th>
                            <th>
                                办公电话
                            </th>
                            <th>
                                QQ
                            </th>
                            <th>
                                生日
                            </th>
                            <th>
                                操作
                            </th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="user" items="${pagination.data}">
                            <tr>
                                <td align="center" width="30px">
                                </td>
                                <td>
                                </td>
                                <td>
                                </td>
                                <td>
                                </td>
                                <td>
                                </td>
                                <td>
                                </td>
                                <td>
                                </td>
                                <td>
                                    ${user.name}
                                </td>
                                <td>
                                    <a href="javascript:$.fn.edit('id');"
                                       class="tablelink">修改</a>
                                    <a
                                        href="javascript:$.fn.deleteItem('id');"
                                        class="tablelink">删除</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                <jsp:include page="/WEB-INF/admin/common/z_paging.jsp" flush="true"></jsp:include>
            </div>
        </form>
    </body>
</html>