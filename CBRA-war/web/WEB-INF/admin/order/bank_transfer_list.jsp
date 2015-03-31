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
                    $.fn.delete_items("ids", "/admin/order/bank_transfer_list?a=BANK_TRANSFER_DELETE");
                });
                $(".tiptop a").click(function () {
                    $(".tip").fadeOut(200);
                });
            });
            //显示修改界面
            $.fn.edit = function (sid) {
                var url = "/admin/order/bank_transfer_list?a=BANK_TRANSFER_CONFIRM&id=" + sid;
                if (confirm("您确定要确认转账吗？")) {
                    $.post(url, "", function (data) {
                        window.location.href = window.location.href;
                    });
                }
            };
            //删除单个设备信息
            $.fn.deleteItem = function (sid) {
                var url = "/admin/order/bank_transfer_list?a=BANK_TRANSFER_DELETE&ids=" + sid;
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
                    <a href="#">未处理的银行转账</a>
                </li>
            </ul>
        </div>
        <form id="form1" name="form1" method="post">
            <div class="rightinfo">
                <div class="tools">
                    <ul class="toolbar">
                        订单状态:
                        <select name="status" class="dfinput" style="width: 154px;">
                            <option value="">
                                全部
                            </option>
                            <option <c:if test="${status == 'PENDING_PAYMENT_CONFIRM'}">selected="selected"</c:if> value="PENDING_PAYMENT_CONFIRM">
                                    待确认
                                </option>
                                <option <c:if test="${status == 'SUCCESS'}">selected="selected"</c:if> value="SUCCESS">
                                    已确认
                                </option>
                            </select>
                            <input type="submit"  class="btn" value="筛选" />
                        </ul>
                        <ul class="toolbar1">

                        </ul>
                    </div>
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
                                    活动名称
                                </th>
                                <th>
                                    状态
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
                                    ${transfer.orderCollection.amount}
                                </td>
                                <td>
                                    ${transfer.orderCollection.serialId}
                                </td>
                                <td>
                                    <a target="_blank" href="/event/event_details?id=${transfer.orderCollection.fundCollection.id}">${transfer.orderCollection.fundCollection.title}</a>
                                </td>
                                <td>
                                    ${transfer.orderCollection.status.mean}
                                </td>
                                <td>
                                    <a href="javascript:$.fn.edit('${transfer.id}');" class="tablelink">确认转账</a>
                                    <a href="javascript:$.fn.deleteItem('${transfer.id}');" class="tablelink">删除</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                <jsp:include page="/WEB-INF/admin/common/z_paging.jsp" flush="true">
                    <jsp:param name="totalCount" value="${resultList.getTotalCount()}" />
                    <jsp:param name="maxPerPage" value="${resultList.getMaxPerPage()}" />
                    <jsp:param name="pageIndex" value="${resultList.getPageIndex()}" />
                </jsp:include>
            </div>
        </form>
    </body>
</html>