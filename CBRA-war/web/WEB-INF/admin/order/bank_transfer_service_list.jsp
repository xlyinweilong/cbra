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
                //删除所选设备信息
                $("#deleteBtn").click(function () {
                    $.fn.delete_items("ids", "/admin/order/bank_transfer_service_list?a=BANK_TRANSFER_DELETE");
                });
                $(".tiptop a").click(function () {
                    $(".tip").fadeOut(200);
                });
            });
            //显示修改界面
            $.fn.edit = function (sid) {
                var url = "/admin/order/bank_transfer_service_list?a=BANK_TRANSFER_SERVICE_CONFIRM&id=" + sid;
                if (confirm("您确定要确认转账吗？")) {
                    $.post(url, "", function (data) {
                        window.location.href = window.location.href;
                    });
                }
            };
            //删除单个设备信息
            $.fn.deleteItem = function (sid) {
                var url = "/admin/order/bank_transfer_service_list?a=BANK_TRANSFER_DELETE&ids=" + sid;
                if (confirm("您确定要删除这条信息吗？")) {
                    $.post(url, "", function (data) {
                        window.location.href = window.location.href;
                    });
                }
            };
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
                    <a href="#">订单管理</a>
                </li>
                <li>
                    <a href="#">未处理的账户银行转账</a>
                </li>
            </ul>
        </div>
        <form id="form1" name="form1" method="post">
            <div class="rightinfo">
<!--                <div class="tools">
                    <ul class="toolbar">
                        <li class="click" id="deleteBtn">
                            <span><img src="<%=path%>/background/images/t03.png" />
                            </span>删除
                        </li>
                    </ul>
                    <ul class="toolbar1">
                    </ul>
                </div>-->
                <table class="tablelist">
                    <thead>
                        <tr>
                            <th>
                                金额
                            </th>
                            <th>
                                订单号
                            </th>
                            <th>
                                用户
                            </th>
                            <th>
                                操作
                            </th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="transfer" items="${resultList}">
                            <tr>
                                <td>
                                    ${transfer.orderCbraService.amount}
                                </td>
                                <td>
                                    ${transfer.orderCbraService.serialId}
                                </td>
                                <td>
                                    ${transfer.orderCbraService.owner.name}
                                </td>
                                <td>
                                    <a href="javascript:$.fn.edit('${transfer.id}');" class="tablelink">确认转账</a>
                                    <a href="javascript:$.fn.deleteItem('${transfer.id}');" class="tablelink">删除</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </form>
    </body>
</html>