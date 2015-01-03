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

		<script type="text/javascript">
$(function(){
	$('.tablelist tbody tr:odd').addClass('odd');
	$.fn.CheckAllClick("cbk_all");
	$.fn.UnCheckAll("ids","cbk_all");

	//显示添加界面
	$("#addBtn").click(function(){
		window.location.href="./openAddCompanyAction.action?regionId="+$("#regionId").val();
	});
	
	//删除所选设备信息
	$("#deleteBtn").click(function(){
		$.fn.delete_items("ids","./deleteCompanyAction.action");
	});
	
	
	$(".tiptop a").click(function(){
	  $(".tip").fadeOut(200);
	});
});
//显示修改界面
$.fn.edit = function(sid){
	window.location.href="./openModifyCompanyAction.action?company.id=" + sid + "&regionId=" + $("#regionId").val();
};
//删除单个设备信息
$.fn.deleteItem = function(sid){
	//$(".tip").fadeIn(200);
	//$(".tip").fadeOut(100);
	var url = "./deleteCompanyAction.action?ids="+sid;
	if(confirm("您确定要删除这条信息吗？")){
		$.post(url, "", function(data){window.location.href=window.location.href;});
	}
};
</script>
	</head>
	<body>
		<form id="form1" name="form1" method="post">
			<s:hidden name="regionId" id="regionId"/>
			<div class="rightinfo">

				<div class="tools">

					<ul class="toolbar">
						<li class="click" id="addBtn">
							<span><img src="<%=path %>/admin/images/t01.png" />
							</span>添加
						</li>
						<li class="click" id="deleteBtn">
							<span><img src="<%=path %>/admin/images/t03.png" />
							</span>删除
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
								公司名称
							</th>
							<th>
								公司地址
							</th>
							<th>
								公司电话
							</th>
							<th>
								公司传真
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
									<s:property value="companyName" />
								</td>
								<td>
									<s:property value="address" />
								</td>
								<td>
									<s:property value="phone" />
								</td>
								<td>
									<s:property value="fax" />
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
						<!-- 
				        <tr>
				        <td><input name="" type="checkbox" value="" /></td>
				        <td>山东章丘公车进饭店景点将自动向监控系统报警</td>
				        <td>山东滨州山东章丘公车进饭店景点将自动向监控系统报警山东章丘公车进饭店景点将自动向监控系统报警山东章丘公车进饭店景点将自动向监控系统报警</td>
				        <td>2013-09-01 10:26</td>
						<td>2013-09-01 10:26</td>
				        <td><a href="#" class="tablelink">修改</a>     <a href="#" class="tablelink">删除</a></td>
				        </tr>        
				         -->
					</tbody>
				</table>
				<!-- 
			    <div class="pagin">
			    	<div class="message">共<i class="blue">1256</i>条记录，当前显示第&nbsp;<i class="blue">2&nbsp;</i>页</div>
			        <ul class="paginList">
			        <li class="paginItem"><a href="javascript:;"><span class="pagepre"></span></a></li>
			        <li class="paginItem"><a href="javascript:;">1</a></li>
			        <li class="paginItem current"><a href="javascript:;">2</a></li>
			        <li class="paginItem"><a href="javascript:;">3</a></li>
			        <li class="paginItem"><a href="javascript:;">4</a></li>
			        <li class="paginItem"><a href="javascript:;">5</a></li>
			        <li class="paginItem more"><a href="javascript:;">...</a></li>
			        <li class="paginItem"><a href="javascript:;">10</a></li>
			        <li class="paginItem"><a href="javascript:;"><span class="pagenxt"></span></a></li>
			        </ul>
			    </div>
			    -->
				<div class="pagin">
					<div class="paginList">
						<page:pages currentPage="pagination.currentPage"
							totalPages="pagination.totalPages"
							totalRows="pagination.totalRows" styleClass="page" theme="text"></page:pages>
					</div>
				</div>
				<!-- page:PageBar pageUrl="" pageAttrKey="pageObject"></--page:PageBar-->
			</div>
			
			<!-- 保留 -->
			<div class="tip">
				<div class="tiptop">
					<span>提示信息</span><a></a>
				</div>
				<div class="tipinfo">
					<span><img src="<%=path %>/admin/images/ticon.png" />
					</span>
					<div class="tipright">
						<p>
							是否确认对信息的修改 ？
						</p>
						<cite>如果是请点击确定按钮 ，否则请点取消。</cite>
					</div>
				</div>
				<div class="tipbtn">
					<input name="sure" type="button" class="sure" value="确定" onclick="$('.tip').fadeOut(100)";/>
					&nbsp;
					<input name="cancel" type="button" class="cancel" value="取消" onclick="$('.tip').fadeOut(100)";/>
				</div>
			</div>
		</form>
	</body>
</html>