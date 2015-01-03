﻿<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
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
		<link href="${pageContent.request.contextPath}/admin/css/style.css" rel="stylesheet" type="text/css" />
		<script language="JavaScript" src="${pageContent.request.contextPath}/admin/js/jquery.js"></script>
		<script type="text/javascript">
	$(function() {
		//导航切换
		$(".menuson li").click(function() {
			$(".menuson li.active").removeClass("active")
			$(this).addClass("active");
		});

		$('.title').click(function() {
			var $ul = $(this).next('ul');
			if($ul.html()!=null){
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
			<!-- 
			
			<dd>
				<div class="title">
					<span><img src="${pageContent.request.contextPath}/admin/images/leftico01.png" />
					</span>组织机构
				</div>
				<ul class="menuson">
					<li class="active">
						<cite></cite><a href="${pageContent.request.contextPath}/admin/organization/region_manage.jsp" target="rightFrame">城市管理</a><i></i>
					</li>
					<li>
						<cite></cite><a href="${pageContent.request.contextPath}/admin/organization/district_manage.jsp" target="rightFrame">地区管理</a><i></i>
					</li>
					<li>
						<cite></cite><a href="${pageContent.request.contextPath}/admin/organization/company_manage.jsp" target="rightFrame">公司管理</a><i></i>
					</li>
					<li>
						<cite></cite><a href="./openRoleAction.action" target="rightFrame">角色管理</a><i></i>
					</li>
					<li>
						<cite></cite><a href="${pageContent.request.contextPath}/admin/organization/dept_manage.jsp" target="rightFrame">部门管理</a><i></i>
					</li>
					<li>
						<cite></cite><a href="${pageContent.request.contextPath}/admin/organization/user_manage.jsp" target="rightFrame">用户管理</a><i></i>
					</li>
					<li>
						<cite></cite><a href="${pageContent.request.contextPath}/admin/organization/menu_manage.jsp" target="rightFrame">菜单管理</a><i></i>
					</li>
					<li>
						<cite></cite><a href="${pageContent.request.contextPath}/admin/organization/popedom_manage.jsp" target="rightFrame">授权管理</a><i></i>
					</li>
				</ul>
			</dd>

			<dd>
				<div class="title">
					<span><img src="${pageContent.request.contextPath}/admin/images/leftico02.png" />
					</span>网站后台
				</div>
				<ul class="menuson">
					<li>
						<cite></cite><a href="${pageContent.request.contextPath}/admin/cms/section/section_manage.jsp" target="rightFrame">栏目管理</a><i></i>
					</li>
					<li>
						<cite></cite><a href="${pageContent.request.contextPath}/admin/cms/content/info_manage.jsp" target="rightFrame">信息管理</a><i></i>
					</li>
					<li>
						<cite></cite><a href="${pageContent.request.contextPath}/admin/cms/content/info_check_manage.jsp" target="rightFrame">信息审核</a><i></i>
					</li>
					<li>
						<cite></cite><a href="${pageContent.request.contextPath}/admin/cms/permission/permission_manage.jsp" target="rightFrame">栏目权限</a><i></i>
					</li>
				</ul>
			</dd>

			<dd>
				<div class="title">
					<span><img src="${pageContent.request.contextPath}/admin/images/leftico03.png" /> </span>业务功能
				</div>
				<ul class="menuson">
					<li>
						<cite></cite><a href="./brokerAction!openBrokerManage.action" target="rightFrame">全民经纪人</a><i></i>
					</li>
					<li>
						<cite></cite><a href="./brokerAction!openProfessionalBrokerManage.action" target="rightFrame">专业经纪人</a><i></i>
					</li>
					<li>
						<cite></cite><a href="./customerAction!openCustomerManage.action" target="rightFrame">客户管理</a><i></i>
					</li>
					<li>
						<cite></cite><a href="./brokerCommissionAction!openBrokerCommissionManage.action" target="rightFrame">佣金管理</a><i></i>
					</li>
					<li>
						<cite></cite><a href="./houseAction!openHouseManage.action" target="rightFrame">房源管理</a><i></i>
					</li>
					<li>
						<cite></cite><a href="./orderHouseAction!openManageOrderHouse.action" target="rightFrame">预约看房</a><i></i>
					</li>
					<li>
						<cite></cite><a href="./siteMessageAction!showList.action" target="rightFrame">消息管理</a><i></i>
					</li>
					<li>
						<cite></cite><a href="./onlineAction!showOnlineManage.action" target="rightFrame">在线咨询</a><i></i>
					</li>
				</ul>
			</dd>
			<dd>
				<div class="title">
					<span><img src="${pageContent.request.contextPath}/admin/images/leftico04.png" /> </span>数据字典
				</div>
				<ul class="menuson">
					<li>
						<cite></cite><a href="./houseCategoryAction!showList.action" target="rightFrame">房源分类</a><i></i>
					</li>
				</ul>
			</dd>
			<dd>
				<div class="title">
					<span><img src="${pageContent.request.contextPath}/admin/images/leftico02.png" /> </span>云端活动
				</div>
				<ul class="menuson">
					<li>
						<cite></cite><a href="${pageContent.request.contextPath}/admin/lottery/lottery_manage.jsp" target="rightFrame">抽奖设置</a><i></i>
					</li>
					<li>
						<cite></cite><a href="${pageContent.request.contextPath}/admin/lottery/lottery_draw_manage.jsp" target="rightFrame">领奖管理</a><i></i>
					</li>
				</ul>
			</dd>
			 -->
			<s:iterator value="menuList" id="menu">
				<dd>
					<div class="title">
						<span><img src="${pageContent.request.contextPath}/admin/images/leftico01.png" /> </span>
						<s:property value="menuName" />
					</div>
					<ul class="menuson">
						<s:iterator value="#menu.subMenuList" id="subMenu">
							<li>
								<cite></cite><a href="<s:property value="url" />" target="rightFrame"><s:property value="#subMenu.menuName" /> </a><i></i>
							</li>
						</s:iterator>
					</ul>
				</dd>
			</s:iterator>
			<dd>
				<div class="title">
					<span><img src="${pageContent.request.contextPath}/admin/images/leftico02.png" /> </span>数据字典
				</div>
				<ul class="menuson">
					<li>
						<cite></cite><a href="/admin/gene/category/gene_category_manage.jsp" target="rightFrame">基因分类</a><i></i>
					</li>
					<li>
						<cite></cite><a href="/admin/gene/gene/gene_manage.jsp" target="rightFrame">典型基因</a><i></i>
					</li>
				</ul>
			</dd>
		</dl>
	</body>
</html>
