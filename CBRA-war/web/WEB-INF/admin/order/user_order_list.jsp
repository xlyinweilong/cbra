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
            //显示修改界面
            $.fn.edit = function (oid) {
                window.location.href = "/admin/order/order_info?oid=" + oid;
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
                    <a href="#">会费支付管理</a>
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
                            <c:forEach var="s" items="${statusList}">
                                <option <c:if test="${s == status}">selected="selected"</c:if> value="${s}">
                                        ${s.mean}
                                    </option>
                            </c:forEach>
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
                                订单金额
                            </th>
                            <th>
                                订单号
                            </th>
                            <th>
                                订单状态
                            </th>
                            <th>
                                最后支付网关
                            </th>
                            <th>
                                用户名称
                            </th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="order" items="${resultList}">
                            <tr>
                                <td>
                                    ${order.amount}
                                </td>
                                <td>
                                    ${order.serialId}
                                </td>
                                <td>
                                    ${order.status.meanNoPending}
                                </td>
                                <td>
                                    ${order.lastGatewayPayment.gatewayType.mean}
                                </td>
                                <td>
                                    ${order.owner.name}
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