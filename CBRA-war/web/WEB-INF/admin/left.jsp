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
        <link href="${pageContent.request.contextPath}/background/css/style.css" rel="stylesheet" type="text/css" />
        <script language="JavaScript" src="${pageContent.request.contextPath}/background/js/jquery.js"></script>
        <script type="text/javascript">
            $(function () {
                //导航切换
                $(".menuson li").click(function () {
                    $(".menuson li.active").removeClass("active")
                    $(this).addClass("active");
                });

                $('.title').click(function () {
                    var $ul = $(this).next('ul');
                    if ($ul.html() != null) {
                        $('dd').find('ul').slideUp();
                        if ($ul.is(':visible')) {
                            $(this).next('ul').slideUp();
                        } else {
                            $(this).next('ul').slideDown();
                        }
                    }
                });
            })
        </script>
    </head>
    <body style="background: #f0f9fd;">
        <div class="lefttop">
            <span></span>平台菜单
        </div>
        <dl class="leftmenu">
            <c:forEach var="menu" items="${menuList}">
                <dd>
                    <div class="title">
                        <span><img src="${pageContent.request.contextPath}/background/images/leftico01.png" /> </span>
                        ${menu.name}
                    </div>
                    <ul class="menuson">
                        <c:forEach var="subMenu" items="${subMenuList}">
                            <c:if test="${subMenu.parentMenu != null && subMenu.parentMenu.id == menu.id}">
                            <li>
                                <cite></cite><a href="${subMenu.url}" target="rightFrame">${subMenu.name}</a><i></i>
                            </li>
                            </c:if>
                        </c:forEach>
                    </ul>
                </dd>
            </c:forEach>
        </dl>
    </body>
</html>
