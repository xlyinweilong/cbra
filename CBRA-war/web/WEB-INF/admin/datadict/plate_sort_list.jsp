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

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title></title>
        <link href="<%=path%>/background/style/soft.css" rel="stylesheet" type="text/css" />
        <script type="text/javascript" src="<%=path%>/background/js/jquery.js"></script>
        <script type="text/javascript" src="<%=path%>/background/js/validate/jquery.validate.js"></script>
        <script type="text/javascript" src="<%=path%>/background/js/common/common.js"></script>
        <script type="text/javascript">
            $(function () {
            });
            //保存排序
            $.fn.btnSave = function () {
                var oListbox = document.getElementById("ids");
                if (oListbox.length > 0) {
                    for (var i = 0; i < oListbox.length; i++) {
                        oListbox.options[i].selected = true;
                    }
                    document.forms[0].action = "/admin/datadict/plate_sort_list";
                    document.forms[0].submit();
                } else {
                    alert("暂无可排序的内容！");
                }
            }
            function btnTop_OnClick() {
                var oListbox = document.getElementById("ids");
                for (var i = 0; i < oListbox.length; i++) {
                    if (oListbox.options[i].selected) {
                        if (oListbox.options[i].index == 0) {
                            break;
                        }
                        shiftTop(oListbox, oListbox.options[i].index);
                    }
                }
            }
            function btnUp_OnClick() {
                var oListbox = document.getElementById("ids");

                for (var i = 0; i < oListbox.length; i++) {
                    if (oListbox.options[i].selected) {
                        if (oListbox.options[i].index == 0) {
                            break;
                        }
                        shiftUp(oListbox, oListbox.options[i].index);
                    }
                }
            }
            function btnDown_OnClick() {
                var oListbox = document.getElementById("ids");
                for (i = oListbox.length - 1; i >= 0; i--) {
                    if (oListbox.options[i].selected) {
                        var iIndex = oListbox.options[i].index;
                        if (iIndex == oListbox.length - 1) {
                            break;
                        }
                        shiftDown(oListbox, iIndex);
                    }
                }
            }
            function btnBottom_OnClick() {
                var oListbox = document.getElementById("ids");
                for (i = oListbox.length - 1; i >= 0; i--) {
                    if (oListbox.options[i].selected) {
                        var iIndex = oListbox.options[i].index;
                        if (iIndex == oListbox.length - 1) {
                            break;
                        }
                        shiftBottom(oListbox, iIndex);
                    }
                }
            }
            function shiftUp(oListbox, iIndex) {

                if (iIndex > 0) {
                    var oOption = oListbox.options[iIndex];
                    var oPrevOption = oListbox.options[iIndex - 1];
                    oListbox.insertBefore(oOption, oPrevOption);
                }
                oListbox.focus();
            }
            function shiftDown(oListbox, iIndex) {
                if (iIndex < oListbox.options.length - 1) {
                    var oOption = oListbox.options[iIndex];
                    var oNextOption = oListbox.options[iIndex + 1];
                    oListbox.insertBefore(oNextOption, oOption);
                }
                oListbox.focus();
            }
            function shiftTop(oListbox, iIndex) {
                if (iIndex > 0) {
                    var oOption = oListbox.options[iIndex];
                    var oTopOption = oListbox.options[0];
                    oListbox.insertBefore(oOption, oTopOption);
                }
                oListbox.focus();
            }
            function shiftBottom(oListbox, iIndex) {
                if (iIndex < oListbox.options.length) {
                    var oOption = oListbox.options[iIndex];
                    var oBottomOption = oListbox.options[oListbox.options.length];
                    oListbox.insertBefore(oOption, oBottomOption);
                }
                oListbox.focus();
            }
            /**
             * 准备工作
             */
            $(document).ready(function () {
                $.fn.initpage();
                $.fn.close();
            });
            /**
             * 关闭
             */
            $.fn.close = function () {
                $("#closeBtn").click(function () {
                    var message = $("#lb_message").html();
                    if (message != null && $.trim(message) != "") {
                    }
                    parent.$("#windown-close").click();
                });
            };
            /**
             * 初始化页面
             */
            $.fn.initpage = function () {
                //回显上传时的错误信息
                var uploadErr = $("#lb_error").html();
                if (uploadErr != null && $.trim(uploadErr) != "") {
                    alert(uploadErr);
                }
                var message = $("#lb_message").html();
                if (message != null && $.trim(message) != "") {
                    alert(message);
                    parent.$("#windown-close").click();
                }
            };
        </script>
    </head>
    <body>
        <form id="form1" name="form1" method="post" theme="simple">
            <span id="lb_message" style="display:none">${postResult.singleSuccessMsg}</span>
            <input type="hidden" name="a" value="PLATE_SORT" />
            <input type="hidden" name="pid" value="${pid}" />
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td style="padding: 10px;">
                        <table border="0" width="300px;" cellspacing="5" cellpadding="5">
                            <tr>
                                <td colspan="4">
                                    <table class="tablelist" border="0">
                                        <tr>
                                            <td align="right" nowrap>
                                                <span class="shadow"> <select id="ids" name="ids" size="20" style="width: 250px;" multiple="multiple">
                                                        <c:forEach var="plate" items="${plateList}">
                                                            <option value="${plate.id}">
                                                                ${plate.name}
                                                            </option>
                                                        </c:forEach>
                                                    </select> </span>
                                            </td>
                                            <td nowrap>
                                                <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
                                                    <tr>
                                                        <td align="right" valign="top">
                                                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                                <tr>
                                                                    <td>
                                                                        <input type="button" name="btnUp" value="↑置顶" onclick="btnTop_OnClick();" class="btn_2_3">
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td height="8">

                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>

                                                                        <input type="button" name="btnUp2" value="↑向上" onclick="btnUp_OnClick();" class="btn_2_3">
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td height="8">

                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <input type="button" name="btnDown" value="↓向下" onclick="btnDown_OnClick();" class="btn_2_3">
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td height="8">

                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <input type="button" name="btnDown2" value="↓置底" onclick="btnBottom_OnClick();" class="btn_2_3">
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td height="64">
                                                                        &nbsp;
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <input type="button" name="btnSave2" value="确定" onclick="$.fn.btnSave()" class="btn_2_3" />
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td height="8">

                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <input type="button" id="closeBtn" name="closeBtn" value="关闭" class="btn_2_3">
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td height="12">
                                                                        &nbsp;
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </form>
    </body>
</html>