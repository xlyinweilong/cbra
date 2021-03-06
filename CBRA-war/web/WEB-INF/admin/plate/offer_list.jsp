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
                    window.location.href = "/admin/plate/offer_info?plateId=${plateId}";
                });
                //删除所选设备信息
                $("#deleteBtn").click(function () {
                    $.fn.delete_items("ids", "/admin/plate/offer_list?a=OFFER_DELETE&plateId=${plateId}");
                });
                $(".tiptop a").click(function () {
                    $(".tip").fadeOut(200);
                });
            });
            //显示修改界面
            $.fn.edit = function (sid) {
                window.location.href = "/admin/plate/offer_info?id=" + sid + "&plateId=${plateId}";
            };
            //删除单个设备信息
            $.fn.deleteItem = function (sid) {
                var url = "/admin/plate/offer_list?a=OFFER_DELETE&plateId=${plateId}&ids=" + sid;
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
                        <c:if test="${plateId == 31}">
                            职务：<select id="position" name="searchPositionEnum" class="dfinput" style="width: 130px;">
                                <c:forEach var="position" items="${positions}">
                                    <option <c:if test="${position == searchPositionEnum}">selected="selected"</c:if> value="${position.name()}">${position.mean}</option>
                                </c:forEach>
                                <option <c:if test="${not empty searchPositionEnumOthers}">selected="selected"</c:if> value="others">其他</option>
                                </select>
                                名称:<input type="text" class="dfinput" style="width: 250px;" name="searchName" value="${searchName}" maxlength="25" />
                            <input type="submit"  class="btn" value="搜索" />
                        </c:if>
                    </ul>
                </div>
                <table class="tablelist">
                    <thead>
                        <tr>
                            <th align="center" width="30px">
                                <input name="cbk_all" id="cbk_all" type="checkbox" value="0" />
                            </th>
                            <th>
                                <c:if test="${plateId == 30}">职位名称</c:if>
                                <c:if test="${plateId == 31}">姓名</c:if>
                                </th>
                            <c:if test="${plateId == 31}">
                                <th>
                                    从业时间(年)
                                </th>
                                <th>
                                    就职公司
                                </th>
                                <th>
                                    职务
                                </th>
                                <th>
                                    产业链位置
                                </th>
                            </c:if>
                            <th>
                                发布时间
                            </th>
                            <th>
                                操作
                            </th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="offer" items="${resultList}">
                            <tr>
                                <td>
                                    <input name="ids" type="checkbox" value="${offer.id}" />
                                </td>
                                <td>
                                    <c:if test="${plateId == 30}">${offer.position}</c:if>
                                    <c:if test="${plateId == 31}">${offer.name}</c:if>
                                    </td>
                                <c:if test="${plateId == 31}">
                                    <td>
                                        ${offer.obtain}
                                    </td>
                                    <td>
                                        ${offer.company}
                                    </td>
                                    <td>
                                        ${offer.getPositionEnmuWithOthers(bundle.resourceBundle)} 
                                    </td>
                                    <td>
                                        ${offer.getIcPositionString(bundle.resourceBundle)} 
                                    </td>
                                </c:if>
                                <td>
                                    <fmt:formatDate value="${offer.pushDate}" pattern="yyyy.MM.dd HH:mm:ss" type="date" dateStyle="long" />
                                </td>
                                <td>
                                    <a href="javascript:$.fn.edit('${offer.id}');" class="tablelink">修改</a>
                                    <a href="javascript:$.fn.deleteItem('${offer.id}');" class="tablelink">删除</a>
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