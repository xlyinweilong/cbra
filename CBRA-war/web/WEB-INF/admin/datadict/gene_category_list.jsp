<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="page" uri="/page-tags"%>
<%
    response.addHeader("Cache-Control", "no-store,no-cache,must-revalidate");
    response.addHeader("Cache-Control", "post-check=0,pre-check=0");
    response.addHeader("Expires", "0");
    response.addHeader("Pragma", "no-cache");
    response.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>无标题文档</title>
		<link href="${pageContent.request.contextPath}/admin/css/style.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="${pageContent.request.contextPath}/admin/js/jquery.js"></script>
		<script type="text/javascript" src="${pageContent.request.contextPath}/admin/js/validate/jquery.validate.js"></script>
		<script type="text/javascript" src="${pageContent.request.contextPath}/admin/js/common/common.js"></script>
		<script type="text/javascript">
		$(function(){
			$('.tablelist tbody tr:odd').addClass('odd');
			$.fn.CheckAllClick("cbk_all");
			$.fn.UnCheckAll("ids","cbk_all");
		
			//显示添加界面
			$("#addBtn").click(function(){
				window.location.href="./geneCategoryAction!show.action";
			});
			
			//删除所选设备信息
			$("#deleteBtn").click(function(){
				$.fn.delete_items("ids","./geneCategoryAction!delete.action");
			});
			
			
			$(".tiptop a").click(function(){
			  $(".tip").fadeOut(200);
			});
			
			//区域排序
			$("#sortBtn").click(function() {
				parent.parent.tipsWindown('类别排序','iframe:./geneCategoryAction!showSortList.action','350','400','true','','true','','no');
				parent.parent.$("#windown-close").bind('click',function(){
					window.location.href="geneCategoryAction!showList.action";
				});
			});
		});
		//显示修改界面
		$.fn.edit = function(sid){
			window.location.href="./geneCategoryAction!show.action?geneCategory.id=" + sid;
		};
		//删除单个设备信息
		$.fn.deleteItem = function(sid){
			var url = "./geneCategoryAction!delete.action?ids="+sid;
			if(confirm("您确定要删除这条信息吗？")){
				$.post(url, "", function(data){window.location.href=window.location.href;});
			}
		};
		</script>
	</head>
	<body>
		<form id="form1" name="form1" method="post">
			<div class="place">
				<span>位置：</span>
				<ul class="placeul">
					<li>
						<a href="#">首页</a>
					</li>
					<li>
						<a href="#">数据字典</a>
					</li>
					<li>
						<a href="#">基因分类</a>
					</li>
				</ul>
			</div>

			<div class="rightinfo">

				<div class="tools">

					<ul class="toolbar">
						<li class="click" id="addBtn">
							<span><img src="${pageContent.request.contextPath}/admin/images/t01.png" />
							</span>添加
						</li>
						<li class="click" id="deleteBtn">
							<span><img src="${pageContent.request.contextPath}/admin/images/t03.png" />
							</span>删除
						</li>
						<li class="click" id="sortBtn">
							<span><img src="${pageContent.request.contextPath}/admin/images/leftico01.png" width="20" height="20" /> </span>排序
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
								分类名称
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
									<s:checkbox id="%{#obj.id}" name="ids" fieldValue="%{id}"
										value="false" theme="simple"/>
								</td>
								<td>
									<s:property value="name" />
								</td>
								<td>
									<a href="javascript:$.fn.edit('<s:property value="id"/>');"
										class="tablelink">修改</a>
									<a
										href="javascript:$.fn.deleteItem('<s:property value="id"/>');"
										class="tablelink">删除</a>
								</td>
							</tr>
						</s:iterator>
					</tbody>
				</table>
				<div class="pagin">
					<div class="paginList">
						<page:pages currentPage="pagination.currentPage"
							totalPages="pagination.totalPages"
							totalRows="pagination.totalRows" styleClass="page" theme="text"></page:pages>
					</div>
				</div>
			</div>
		</form>
	</body>
</html>