<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:if test="${empty bundle}">
    <fmt:setLocale value="${SESSION_ATTRIBUTE_LOCALE}" scope="session" />
    <fmt:setBundle basename="message" scope="session" var="bundle"/>
</c:if>
<%-- 设置语言要在输出任何response之前 --%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<title>筑誉建筑联合会</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords" content="筑誉建筑联合会 CBRA"/> 
<meta name="description" content="筑誉建筑联合会（简称CBRA）是由建筑行业专家学者，资深从业人员及相关企业自愿组成的为会员和行业提供优质服务为宗旨的全产业链合作平台。CBRA以“构筑建筑行业信誉，推动中国建筑行业进步”为使命，致力于打造中国建筑行业最具公信力的专业平台。 价值： 诚实守信，平等互助，透明规范 口号： 善筑者，誉天下！"/> 
<link rel="shortcut icon" href="/favicon.ico" /> 
<link href="/css/master.css" rel="stylesheet" type="text/css"><!--top-->
<link href="/jquery-ui/css/ui-lightness/jquery-ui-1.10.4.custom.min.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="/jquery-ui/js/jquery-1.10.2.js"></script>
<script type="text/javascript" src="/jquery-ui/js/jquery-ui-1.10.4.custom.min.js"></script>
<script type="text/javascript" src="/js/base.js"></script><!--导航 -->
<script type="text/javascript" src="/js/common.js"></script>
<script type="text/javascript" src="/background/js/My97DatePicker/WdatePicker.js"></script>

