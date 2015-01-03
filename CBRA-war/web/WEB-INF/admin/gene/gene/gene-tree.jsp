<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
    response.addHeader("Cache-Control", "no-store,no-cache,must-revalidate");
    response.addHeader("Cache-Control", "post-check=0,pre-check=0");
    response.addHeader("Expires", "0");
    response.addHeader("Pragma", "no-cache");
    response.setCharacterEncoding("utf-8");
    String path = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title></title>
<script type="text/javascript" src="<%=path %>/admin/js/jquery.js"></script>
<link rel="stylesheet" href="<%=path %>/admin/js/zTreeStyle/zTreeStyle.css" type="text/css" />
<script type="text/javascript" src="<%=path %>/admin/js/zTreeStyle/jquery.ztree.core-3.5.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		var setting = {
			data : {
				simpleData : {
					enable : true
				}
			}
		};
		var zNodes =[
		    		{id:'0', pId:'0', name:"分类列表", open:true, url:"", target : "listFrame"}
		    		<s:iterator value="geneCategoryList">
		    		,{id:'<s:property value="id"/>', pId:'<s:property value="parentId"/>', name:"<s:property value="name" escape="false"/>", open:true, url:"./geneAction!showGeneList.action?geneCategoryId=<s:property value="id"/>", target: "listFrame",icon:"<%=path %>/admin/js/zTreeStyle/img/diy/city.png"}
		    		</s:iterator>
		    	];

		$(document).ready(function() {
			$.fn.zTree.init($("#regionTree"), setting, zNodes);
		});
	});
</script>

<style type="text/css">
.ztree li span.button.pIcon01_ico_open {
	margin-right: 2px;
	background: url(<%=path %>/admin/js/zTreeStyle/img/diy/1_open.png) no-repeat
		scroll 0 0 transparent;
	vertical-align: top;
	*vertical-align: middle
}

.ztree li span.button.pIcon01_ico_close {
	margin-right: 2px;
	background: url(<%=path %>/admin/js/zTreeStyle/img/diy/1_close.png) no-repeat
		scroll 0 0 transparent;
	vertical-align: top;
	*vertical-align: middle
}

.ztree li span.button.pIcon02_ico_open,.ztree li span.button.pIcon02_ico_close
	{
	margin-right: 2px;
	background: url(<%=path %>/admin/js/zTreeStyle/img/diy/2.png) no-repeat scroll
		0 0 transparent;
	vertical-align: top;
	*vertical-align: middle
}

.ztree li span.button.icon01_ico_docu {
	margin-right: 2px;
	background: url(<%=path %>/admin/js/zTreeStyle/img/diy/3.png) no-repeat scroll
		0 0 transparent;
	vertical-align: top;
	*vertical-align: middle
}

.ztree li span.button.icon02_ico_docu {
	margin-right: 2px;
	background: url(<%=path %>/admin/js/zTreeStyle/img/diy/4.png) no-repeat scroll
		0 0 transparent;
	vertical-align: top;
	*vertical-align: middle
}

.ztree li span.button.icon03_ico_docu {
	margin-right: 2px;
	background: url(<%=path %>/admin/js/zTreeStyle/img/diy/5.png) no-repeat scroll
		0 0 transparent;
	vertical-align: top;
	*vertical-align: middle
}

.ztree li span.button.icon04_ico_docu {
	margin-right: 2px;
	background: url(<%=path %>/admin/js/zTreeStyle/img/diy/6.png) no-repeat scroll
		0 0 transparent;
	vertical-align: top;
	*vertical-align: middle
}

.ztree li span.button.icon05_ico_docu {
	margin-right: 2px;
	background: url(<%=path %>/admin/js/zTreeStyle/img/diy/7.png) no-repeat scroll
		0 0 transparent;
	vertical-align: top;
	*vertical-align: middle
}

.ztree li span.button.icon06_ico_docu {
	margin-right: 2px;
	background: url(<%=path %>/admin/js/zTreeStyle/img/diy/8.png) no-repeat scroll
		0 0 transparent;
	vertical-align: top;
	*vertical-align: middle
}
</style>

</head>


<body>

	<ul id="regionTree" class="ztree"></ul>

</body>

</html>
