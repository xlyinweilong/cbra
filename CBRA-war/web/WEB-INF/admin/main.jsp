<%@ page language="java" pageEncoding="UTF-8"%>
<%
    String path = request.getContextPath();
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>   
        <title>CBRA息管理平台</title>
        <link href="/background/css/style.css" rel="stylesheet" type="text/css" />
        <link rel="stylesheet" href="/background/js/tipswindown/css/tipswindown.css" type="text/css" media="all" />
        <script language="JavaScript" src="<%=path%>/background/js/tipswindown/js/jq.js"></script>
        <script type="text/javascript" src="<%=path%>/background/js/tipswindown/js/tipswindown.js"></script>
        <script type="text/javascript" src="<%=path%>/background/js/jquery.layout-latest.js"></script>
        <script type="text/javascript">
            var myLayout;
            $(document).ready(function () {
                myLayout = $("body").layout({
                    north__size: 88
                    , north__spacing_open: 0
                    , north__resizable: false
                    , south__size: 26
                    , south__spacing_open: 0
                    , south__resizable: false
                    , west__size: 187
                    , west__minSize: 187
                    , west__togglerLength_closed: 30
                    , west__togglerLength_open: 30
                    , center__minHeight: 200
                    , center__minWidth: '30%'
                    , spacing_closed: 0
                    , spacing_open: 0
                    , initClosed: false
                });
                //tipsWindown("标题","id:testID","300","200","true","","true","id");
            });
        </script>
    </head>
    <body style="margin: 0 auto;">
        <iframe id="topFrame" name="topFrame" class="ui-layout-north" src="${pageContext.request.contextPath}/logonTopAction.action" frameborder="0" scrolling="no"></iframe>
        <iframe id="leftFrame" name="leftFrame" class="ui-layout-west" src="${pageContext.request.contextPath}/logonLeftAction.action" frameborder="0" scrolling="no"></iframe>
        <iframe id="rightFrame" name="rightFrame" class="ui-layout-center" src="${pageContext.request.contextPath}/logonRightAction.action" frameborder="0" scrolling="auto"></iframe>
    </body>
</html>
