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
		<link rel="stylesheet" href="<%=path %>/admin/css/style.css" type="text/css" />
		<link rel="stylesheet" href="<%=path %>/admin/js/validate/tip-yellowsimple/tip-yellowsimple.css" type="text/css" />
		<link rel="stylesheet" href="<%=path %>/admin/js/validate/tip-green/tip-green.css" type="text/css" />
		<script type="text/javascript" src="<%=path %>/admin/js/jquery.js"></script>
		<script type="text/javascript" src="<%=path %>/admin/js/validate/jquery.poshytip.js"></script>
		<script type="text/javascript" src="<%=path %>/admin/js/validate/jquery.validate.js"></script>
		<script type="text/javascript" src="<%=path %>/admin/js/common/common.js"></script>

	</head>
	<script type="text/javascript">
	$(function() {
  		$("#saveBtn").click(function() {
			var rules={
				"oldPassword": {required: true},
				"user.userName": {required: true},
				"newPassword":{equalTo:"#validPassword"}
			};
			var messages={
				"oldPassword": {required: "原密码必须填写！"},
				"user.userName": {required: "中文姓名必须填写！"},
				"newPassword":{equalTo:"新密码与校验密码不一致！"}
			};
			//初始化验证框架
			FormSave("form1",rules, messages);
			$("#form1").attr("target", "iframe1");
			$("#form1").attr("action", "saveOrUpdateMyInfoAction.action");
            $("#form1").submit();
        });
  		$.fn.goback();
  	});
	
	/**
	 * 返回
	 */
 	$.fn.goback = function(){
 		$("#gobackBtn").click(function(){
  			window.location.href="./logonRightAction.action";
  		});
	}

</script>
	<body>
		<div class="formbody">
			<div class="formtitle">
				<span>账号设置</span>
			</div>
			<s:form id="form1" name="form1" method="post" theme="simple">
				<s:hidden id="userId" name="user.id"></s:hidden>
				<ul class="forminfo">
					<li>
						<label>
							登录用户名
						</label>
						<s:label name="user.username" />
						<i></i>
					</li>
					<li>
						<label>
							原密码
							<b>*</b>
						</label>
						<s:password id="oldPassword" name="oldPassword" cssClass="dfinput" cssStyle="width: 350px;" maxlength="16"></s:password>
						<i>原密码必须填写</i>
					</li>
					<li>
						<label>
							中文姓名
							<b>*</b>
						</label>
						<s:textfield id="txt_userName" name="user.userName" cssClass="dfinput" cssStyle="width: 350px;" maxlength="10"></s:textfield>
						<i>中文姓名不能超过10个汉字，必填项</i>
					</li>
					<li>
						<label>
							新密码
						</label>
						<s:password id="newPassword" name="newPassword" cssClass="dfinput" value="" cssStyle="width: 350px;" maxlength="16"></s:password>
						<i>密码长度不超过16位</i>
					</li>
					<li>
						<label>
							校验密码
						</label>
						<s:password id="validPassword" name="validPassword" cssClass="dfinput" value="" cssStyle="width: 350px;" maxlength="16"></s:password>
						<i>要与新密码一致</i>
					</li>
					<li>
						<label>
							角色
						</label>
						<s:property value="roleName" />
						<s:label value="超级用户" />
						<i></i>
					</li>
					<li>
						<label>
							生日
						</label>
						<s:textfield id="txt_birthday" name="user.birthday" cssClass="dfinput" cssStyle="width: 350px;" maxlength="25"></s:textfield>
						<i></i>
					</li>
					<li>
						<label>
							手机号
						</label>
						<s:textfield id="txt_phone" name="user.phone" cssClass="dfinput" cssStyle="width: 350px;" maxlength="25"></s:textfield>
						<i></i>
					</li>
					<li>
						<label>
							办公电话
						</label>
						<s:textfield id="txt_officePhone" name="user.officePhone" cssClass="dfinput" cssStyle="width: 350px;" maxlength="25"></s:textfield>
						<i></i>
					</li>
					<li>
						<label>
							QQ
						</label>
						<s:textfield id="txt_qq" name="user.qq" cssClass="dfinput" cssStyle="width: 350px;" maxlength="25"></s:textfield>
						<i></i>
					</li>
					<li>
						<label>
							&nbsp;
						</label>
						<input id="saveBtn" name="saveBtn" type="button" class="btn" value="保存" />
						<input id="gobackBtn" name="gobackBtn" type="button" class="btn" value="返回" />
					</li>
				</ul>
			</s:form>
			<iframe name="iframe1" id="iframe1" width="1px" height="1px"></iframe>
		</div>
	</body>
</html>
