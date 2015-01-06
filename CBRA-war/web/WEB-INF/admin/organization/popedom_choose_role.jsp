<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
    response.addHeader("Cache-Control", "no-store,no-cache,must-revalidate");
    response.addHeader("Cache-Control", "post-check=0,pre-check=0");
    response.addHeader("Expires", "0");
    response.addHeader("Pragma", "no-cache");
    response.setCharacterEncoding("utf-8");
    String path = request.getContextPath();
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title></title>
        <link href="<%=path%>/background/style/soft.css" rel="stylesheet" type="text/css" />
        <script type="text/javascript" src="<%=path%>/background/js/jquery.js"></script>
        <script type="text/javascript" src="<%=path%>/background/js/validate/jquery.validate.js"></script>
        <script type="text/javascript" src="<%=path%>/background/js/common/common.js"></script>
        <script type="text/javascript">
            $(document).ready(function () {
                $.fn.initpage();
            });
            function winclose()
            {
                parent.parent.$("#windown-close").click();
            }
            function gosubmit()
            {
                if ((form1.roleIds.value) == "") {
                    alert("请选择角色！");
                    return false;
                }
                form1.action = "/admin/organization/popedom_choose_role";
                form1.target = "iframe1";
                form1.submit();
            }
            /**
             * 初始化页面
             */
            $.fn.initpage = function () {

                var message = $("#lb_message").html();
                if (message != null && $.trim(message) != "") {
                    alert(message);
                    parent.parent.$("#windown-close").click();
                }
            };
        </script>
    </head>
    <body class="body">
        <form id="form1" name="form1" method="post" theme="simple">
            <span id="lb_message" style="display:none">${postResult.singleSuccessMsg}</span>
            <input type="hidden" name="a" value="CHOOSE_ROLE" />
            <input type="hidden" name="mid" value="${mid}" />
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td style="padding: 5px;">
                        <table border="0" width="100%" cellspacing="5" cellpadding="5">
                            <tr>
                                <td nowrap="nowrap">
                                    <table width="100%" border="0" cellpadding="1" cellspacing="5">
                                        <tr>
                                            <td align="center" nowrap="nowrap">
                                                <span class="shadow"> 
                                                    <select id="roleIds" name="roleIds" size="20" style="width: 280px;" multiple="multiple">
                                                        <c:forEach var="role" items="${roleList}">
                                                            <option value="${role.id}">
                                                                ${role.name}
                                                            </option>
                                                        </c:forEach>
                                                    </select>
                                                </span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="center" nowrap>
                                                <font color="red" style="font-size: 9pt;">注：多选时，请用鼠标拖拽，或按住Ctrl键！</font>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="center" nowrap height="20px">
                                                <input type="button" name="btnSave" value="确定" class="btn_2_3" onClick="gosubmit();">
                                                <input type="button" name="btnCancel" value="关闭" class="btn_2_3" onClick="winclose();">
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
        <iframe id="iframe1" name="iframe1" width="1px" height="1px" frameborder="0"></iframe>
    </body>
</html>
