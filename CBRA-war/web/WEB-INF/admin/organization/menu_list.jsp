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
                    window.location.href = "/admin/organization/menu_info?pid=${pid}";
                });
                //删除所选设备信息
                $("#deleteBtn").click(function () {
                    $.fn.delete_items("ids", "/admin/organization/menu_list?a=MENU_DELETE&id=${pid}");
                    $.fn.refreshtree();
                });
                //排序
                $("#sortBtn").click(function () {
                    parent.parent.tipsWindown('菜单排序', 'iframe:/admin/organization/menu_sort_list?id=${pid}', '350', '400', 'true', '', 'true', '', 'no');
                    parent.parent.$("#windown-close").bind('click', function () {
                        window.location.href = "/admin/organization/menu_list?id=${pid}";
                    });
                });
                $(".tiptop a").click(function () {
                    $(".tip").fadeOut(200);
                });
            });
            //显示修改界面
            $.fn.edit = function (sid) {
                window.location.href = "/admin/organization/menu_info?id=" + sid + "&pid=${pid}";
            };
            //删除单个设备信息
            $.fn.deleteItem = function (sid) {
                var url = "/admin/organization/menu_list?a=MENU_DELETE&pid=${pid}&ids=" + sid;
                if (confirm("您确定要删除这条信息吗？")) {
                    $.post(url, "", function (data) {
                        window.location.href = window.location.href;
                    });
                    $.fn.refreshtree();
                }
            };
            $.fn.refreshtree = function () {
                parent.treeFrame.location.href = "/admin/organization/menu_tree";
            }
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
                        <li class="click" id="sortBtn">
                            <span><img src="<%=path%>/background/images/leftico01.png" width="20" height="20" /> </span>排序
                        </li>
                    </ul>
                    <ul class="toolbar1">
                    </ul>
                </div>
                <table class="tablelist">
                    <thead>
                        <tr>
                            <th align="center" width="30px">
                                <input name="cbk_all" id="cbk_all" type="checkbox" value="0" />
                            </th>
                            <th>
                                菜单名称
                            </th>
                            <th>
                                权限类型
                            </th>
                            <th>
                                链接地址
                            </th>
                            <th>
                                操作
                            </th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="menu" items="${menuList}">
                            <tr>
                                <td>
                                    <input name="ids" type="checkbox" value="${menu.id}" />
                                </td>
                                <td>
                                    ${menu.name}
                                </td>
                                <td>
                                    ${menu.popedomStr}
                                </td>
                                <td>
                                    ${menu.url}
                                </td>
                                <td>
                                    <a href="javascript:$.fn.edit('${menu.id}');" class="tablelink">修改</a>
                                    <a href="javascript:$.fn.deleteItem('${menu.id}');" class="tablelink">删除</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </form>
        <script type="text/javascript">
            <c:if test = "${reflashTreeFrameUrl != null}" >$.fn.refreshtree();</c:if>
        </script>
    </body>
</html>