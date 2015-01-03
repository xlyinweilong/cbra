<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
	response.addHeader( "Cache-Control", "no-store,no-cache,must-revalidate" );
	response.addHeader( "Cache-Control", "post-check=0,pre-check=0" );
	response.addHeader( "Expires", "0" );
	response.addHeader( "Pragma", "no-cache" );
	response.setCharacterEncoding( "utf-8" );
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<link rel="stylesheet" href="${pageContent.request.contextPath}/admin/css/style.css" type="text/css" />
<link rel="stylesheet" href="${pageContent.request.contextPath}/admin/js/validate/tip-yellowsimple/tip-yellowsimple.css" type="text/css" />
<link rel="stylesheet" href="${pageContent.request.contextPath}/admin/js/validate/tip-green/tip-green.css" type="text/css" />
<script type="text/javascript" src="${pageContent.request.contextPath}/admin/js/jquery.js"></script>
<script type="text/javascript" src="${pageContent.request.contextPath}/admin/js/validate/jquery.poshytip.js"></script>
<script type="text/javascript" src="${pageContent.request.contextPath}/admin/js/validate/jquery.validate.js"></script>
<script type="text/javascript" src="${pageContent.request.contextPath}/admin/js/common/common.js"></script>

</head>
<script type="text/javascript">
	$(function() {
  		$.fn.initpage();
  		$("#saveBtn").click(function() {
			var rules={
				"geneCategory.name": {required: true}
			};
			var messages={
				"geneCategory.name": {required: "类别名称必须填写！"}
			};
			//初始化验证框架
			FormSave("form1",rules, messages);
			$("#form1").attr("target", "iframe1");
			$("#form1").attr("action", "geneCategoryAction!save.action");
            $("#form1").submit();
        });
  		$.fn.goback();
  	});
	
	/**
	 * 返回
	 */
 	$.fn.goback = function(){
 		$("#gobackBtn").click(function(){
  			window.location.href="./geneCategoryAction!showList.action";
  		});
	}

	/**
	 * 初始化页面
	 */
	$.fn.initpage = function(){
		$("#txt_name").focus();
	}
</script>
<body>
	<div class="place">
    <span>位置：</span>
    <ul class="placeul">
    <li><a href="#">首页</a></li>
    <li><a href="#">数据字典</a></li>
    <li><a href="#">房源分类</a></li>
    </ul>
    </div>
    
    <div class="formbody">
    <div class="formtitle"><span>基本信息</span></div>
	<s:form id="form1" name="form1" method="post" theme="simple">
		<s:hidden id="geneCategoryId" name="geneCategory.id"></s:hidden>
	    <ul class="forminfo">
	    <li><label>类别名称<b>*</b></label><s:textfield id="txt_name" name="geneCategory.name" cssClass="dfinput" cssStyle="width: 350px;" maxlength="10"></s:textfield><i>房源分类名称不能超过10个汉字，必填项</i></li>
	    <li><label>&nbsp;</label>
	    	<input id="saveBtn" name="saveBtn" type="button" class="btn" value="保存"/>
	    	<input id="gobackBtn" name="gobackBtn" type="button" class="btn" value="返回"/>
	    </li>
	    </ul>
	</s:form>
	<iframe name="iframe1" id="iframe1" width="1px" height="1px"></iframe>
    </div>
</body>
</html>
