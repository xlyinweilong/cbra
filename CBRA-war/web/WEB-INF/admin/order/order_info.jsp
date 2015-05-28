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
        <link rel="stylesheet" href="<%=path%>/background/css/style.css" type="text/css" />
        <link rel="stylesheet" href="<%=path%>/background/js/validate/tip-yellowsimple/tip-yellowsimple.css" type="text/css" />
        <link rel="stylesheet" href="<%=path%>/background/js/validate/tip-green/tip-green.css" type="text/css" />
        <script type="text/javascript" src="<%=path%>/background/js/jquery.js"></script>
        <script type="text/javascript" src="<%=path%>/background/js/validate/jquery.poshytip.js"></script>
        <script type="text/javascript" src="<%=path%>/background/js/validate/jquery.validate.js"></script>
        <script type="text/javascript" src="<%=path%>/background/js/common/common.js"></script>
    </head>
    <script type="text/javascript">
        $(function () {
            $("#saveBtn").click(function () {
                var rules = {
                    "content": {required: true}
                };
                var messages = {
                    "content": {required: "回复内容必须填写！"}
                };
                //初始化验证框架
                FormSave("form1", rules, messages);
                $("#form1").attr("action", "/admin/order/order_info");
                $("#form1").submit();
            });
            $.fn.goback();
        });
        /**
         * 返回
         */
        $.fn.goback = function () {
            $("#gobackBtn").click(function () {
                window.location.href = "/admin/order/order_list";
            });
        }
        $.fn.approval = function (type) {
            $("#form_type").val(type);
            $("#form_action").val("ORDER_APPROVAL");
            $("#form1").attr("action", "/admin/order/order_info");
            $("#form1").submit();
        }
    </script>
    <body>
        <div class="formbody">
            <div class="formtitle"><span>订单详情</span></div>
            <form id="form1" name="form1" method="post">
                <input type="hidden" id="form_action" name="a" value="" />
                <input type="hidden" name="id" value="${orderCollection.id}" />
                <input type="hidden" id="form_type" name="type" value="" />
                <ul class="forminfo">
                    <li>
                        <table class="tablelist">
                            <thead>
                                <tr>
                                    <th>
                                        参会者名字
                                    </th>
                                    <th>
                                        参会者电话
                                    </th>
                                    <th>
                                        参会者邮箱
                                    </th>
                                    <th>
                                        参会者公司
                                    </th>
                                    <th>
                                        参会者职位
                                    </th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="attendee" items="${attendeeList}">
                                    <tr>
                                        <td>
                                            ${attendee.name}
                                        </td>
                                        <td>
                                            ${attendee.mobilePhone}
                                        </td>
                                        <td>
                                            ${attendee.email}
                                        </td>
                                        <td>
                                            ${attendee.company}
                                        </td>
                                        <td>
                                            ${attendee.position}
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </li>
                    <li><label>订单状态：</label>
                        <span style="padding-top: 10px;">${orderCollection.status.mean}</span>
                    </li>
                    <li><label>类型：</label>
                        <span style="padding-top: 10px;">${orderCollection.userStr}</span>
                    </li>
                    <c:if test="${orderCollection.owner != null}">
                        <li><label>订单拥有者：</label>
                            <span style="padding-top: 10px;">${orderCollection.owner.name}</span>
                        </li>
                    </c:if>
                    <li><label>&nbsp;</label>
                        <c:if test="${orderCollection.status == 'PENDING_FOR_APPROVAL'}">
                            <!--<input id="passBtn" name="passBtn" type="button" class="btn" value="审批通过" onclick="$.fn.approval('PENDING_PAYMENT');"/>-->
                            <!--<input id="noPassBtn" name="noPassBtn" type="button" class="btn" value="审批不通过" onclick="$.fn.approval('APPROVAL_REJECT');"/>-->
                        </c:if>
                    </li>
                </ul>
            </form>
        </div>
        <iframe name="iframe1" id="iframe1" width="1px" height="1px"></iframe>
        <script type="text/javascript">
            $(document).ready(function () {
            <c:if test="${postResult.singleSuccessMsg != null}">alert("${postResult.singleSuccessMsg}");</c:if>
            <c:if test="${postResult.singleErrorMsg != null}">alert("${postResult.singleErrorMsg}");</c:if>
                });
        </script>
    </body>
</html>
