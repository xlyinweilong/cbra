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
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>无标题文档</title>
		<link rel="stylesheet" href="<%=path%>/admin/css/style.css"
			type="text/css" />
		<link rel="stylesheet"
			href="<%=path%>/admin/js/validate/tip-yellowsimple/tip-yellowsimple.css"
			type="text/css" />
		<link rel="stylesheet"
			href="<%=path%>/admin/js/validate/tip-green/tip-green.css"
			type="text/css" />
		<script type="text/javascript" src="<%=path%>/admin/js/jquery.js"></script>
		<script type="text/javascript"
			src="<%=path%>/admin/js/validate/jquery.poshytip.js"></script>
		<script type="text/javascript"
			src="<%=path%>/admin/js/validate/jquery.validate.js"></script>
		<script type="text/javascript"
			src="<%=path%>/admin/js/common/common.js"></script>

	</head>
	<script type="text/javascript">
	$(function() {
  		$.fn.initpage();
  		$("#saveBtn").click(function() {
			var rules={
				"geneCategory.name": {required: true}
			};
			var messages={
				"geneCategory.name": {required: "名称必须填写！"},
			};
			//初始化验证框架
			FormSave("form1",rules, messages);
			$("#form1").attr("target", "iframe1");
			$("#form1").attr("action", "geneCategoryAction!saveGeneCategory.action");
            $("#form1").submit();
            parent.treeFrame.location.href="./geneCategoryAction!showRootGeneCategoryList.action";
        });
  		$.fn.goback();
  	});
	/**
  	 * 保存
  	 */
	$.fn.save = function(){
		
     }
	
	/**
	 * 返回
	 */
 	$.fn.goback = function(){
 		$("#gobackBtn").click(function(){
  			window.location.href="./geneCategoryAction!showGeneCategoryList.action?parentId="+$("#parentId").val();
  		});
	}

	/**
	 * 初始化页面
	 */
	$.fn.initpage = function(){
		$("#txt_geneCategoryName").focus();
	}
</script>
	<body>
		<div class="formbody">
			<div class="formtitle">
				<span>基本信息</span>
			</div>
			<s:form id="form1" name="form1" method="post" theme="simple">
				<s:hidden id="regionId" name="geneCategory.id"></s:hidden>
				<s:hidden id="sortNum" name="geneCategory.sortNum"></s:hidden>
				<s:hidden id="parentId" name="parentId"></s:hidden>
				<ul class="forminfo">
					<li>
						<label>
							分类名称
							<b>*</b>
						</label>
						<s:textfield id="txt_geneCategoryName" name="geneCategory.name"
							cssClass="dfinput" cssStyle="width: 350px;" maxlength="25"></s:textfield>
						<i>名称不能超过25个汉字，必填项</i>
					</li>
					<li>
						<label>
							&nbsp;
						</label>
						<input id="saveBtn" name="saveBtn" type="button" class="btn"
							value="保存" />
						<input id="gobackBtn" name="gobackBtn" type="button" class="btn"
							value="返回" />
					</li>
				</ul>
			</s:form>
		</div>
		<iframe name="iframe1" id="iframe1" width="1px" height="1px"></iframe>
	</body>
</html>
