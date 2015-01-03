<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="page" uri="/page-tags"%>
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
		<link href="<%=path %>/admin/css/style.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="<%=path %>/admin/js/jquery.js"></script>
		<script type="text/javascript" src="<%=path %>/admin/js/validate/jquery.validate.js"></script>
		<script type="text/javascript" src="<%=path %>/admin/js/common/common.js"></script>
		<script type="text/javascript" src="<%=path %>/admin/js/tipswindow/tipswindow.js"></script>
		<link href="<%=path %>/admin/js/tipswindow/tipswindow.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
	$(function() {
		$('.tablelist tbody tr:odd').addClass('odd');
		$.fn.CheckAllClick("cbk_all");
		$.fn.UnCheckAll("ids", "cbk_all");

		//显示添加界面
		$("#addBtn")
				.click(
						function() {
							window.location.href = "./districtAction!showDistrictInfo.action?district.id=&cityId=<s:property value="cityId"/>";
						});

		//删除所选设备信息
		$("#deleteBtn").click(function() {
			$.fn.delete_items("ids", "./districtAction!deleteDistrict.action");
		});

		$(".tiptop a").click(function() {
			$(".tip").fadeOut(200);
		});
		//区域排序
		$("#sortBtn").click(function() {
			parent.parent.tipsWindown('区域排序','iframe:./districtAction!sortDistrictList.action?district.id=&cityId=<s:property value="cityId"/>','350','400','true','','true','','no');
			parent.parent.$("#windown-close").bind('click',function(){
				window.location.href="districtAction!showDistrictList.action?cityId=" + $("#cityId").val();
			});
		});
	});
	//显示修改界面
	$.fn.edit = function(sid) {
		window.location.href = "./districtAction!showDistrictInfo.action?district.id=" + sid + "&cityId=<s:property value="cityId"/>";
	};
	//删除单个设备信息
	$.fn.deleteItem = function(sid) {
		var url = "./districtAction!deleteDistrict.action?ids=" + sid;
		if (confirm("您确定要删除这条信息吗？")) {
			$.post(url, "", function(data) {
				window.location.href = window.location.href;
			});
		}
	};
</script>
	</head>
	<body>
		<form id="form1" name="form1" method="post">
			<s:hidden name="cityId" id="cityId"></s:hidden>
			<div class="rightinfo">
				<div class="tools">
					<ul class="toolbar">
						<li class="click" id="addBtn">
							<span><img src="<%=path %>/admin/images/t01.png" /> </span>添加
						</li>
						<li class="click" id="deleteBtn">
							<span><img src="<%=path %>/admin/images/t03.png" /> </span>删除
						</li>
						<li class="click" id="sortBtn">
							<span><img src="<%=path %>/admin/images/leftico01.png" width="20" height="20" /> </span>排序
						</li>

					</ul>
					<ul class="toolbar1">
					</ul>

				</div>

				<table class="tablelist">
					<thead>
						<tr>
							<th>
								<input name="cbk_all" id="cbk_all" type="checkbox" value="1" />
							</th>
							<th>
								区域名称
							</th>
							<th>
								区域编码
							</th>
							<th>
								操作
							</th>
						</tr>
					</thead>
					<tbody>
						<s:iterator value="pagination.data" status="obj">
							<tr>
								<td align="center" width="30px">
									<s:checkbox id="%{#obj.id}" name="ids" fieldValue="%{id}" value="false" theme="simple" />
								</td>
								<td>
									<s:property value="name" />
								</td>
								<td>
									<s:property value="code" />
								</td>
								<td>
									<a href="javascript:$.fn.edit('<s:property value="id"/>');" class="tablelink">修改</a>
									<a href="javascript:$.fn.deleteItem('<s:property value="id"/>');" class="tablelink">删除</a>
								</td>
							</tr>
						</s:iterator>
					</tbody>
				</table>
				<div class="pagin">
					<div class="paginList">
						<page:pages currentPage="pagination.currentPage" totalPages="pagination.totalPages" totalRows="pagination.totalRows" styleClass="page" theme="text"></page:pages>
					</div>
				</div>
			</div>
		</form>
	</body>
</html>
