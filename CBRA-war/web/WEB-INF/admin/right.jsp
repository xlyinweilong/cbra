<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
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
        <link href="<%=path%>/background/css/style.css" rel="stylesheet" type="text/css" />
        <script type="text/javascript" src="<%=path%>/background/js/jquery.js"></script>

    </head>


    <body>

        <div class="place">
            <span>位置：</span>
            <ul class="placeul">
                <li><a href="#">首页</a></li>
            </ul>
        </div>

        <div class="mainindex">


            <div class="welinfo">
                <span><img src="<%=path%>/background/images/man.jpg" width="20" height="24"/></span>
                <b><s:property value="#session.userSession.userName"/>，您好，欢迎登录云端房产网信息管理平台</b>
                <a href="./showMyInfoAction.action">帐号设置</a>
            </div>

            <div class="welinfo">
                <span><img src="<%=path%>/background/images/time.png" alt="时间" /></span>
                <i><s:property value="#session.userSession.lastLoginDesc"/></i> （不是您登录的？<a href="./logoutAction.action" target="_parent">请点这里</a>）
            </div>

            <!-- 
            <div class="xline"></div>
            <ul class="iconlist">
            
            <li><img src="<%=path%>/admin/images/ico01.png" /><p><a href="/" target="_blank">网站首页</a></p></li>
            <li><img src="<%=path%>/admin/images/ico02.png" /><p><a href="<%=path%>/admin/cms/content/info_manage.jsp">发布信息</a></p></li>
            <li><img src="<%=path%>/admin/images/ico04.png" /><p><a href="<%=path%>/admin/cms/content/info_check_manage.jsp">审核信息</a></p></li>
                    
            </ul>
            -->
            <!-- 
            <div class="ibox"><a class="ibtn"><img src="<%=path%>/admin/images/iadd.png" />添加新的快捷功能</a></div>
            -->

            <div class="xline"></div>
            <div class="box"></div>

            <div class="welinfo">
                <span><img src="<%=path%>/admin/images/dp.png" alt="提醒" /></span>
                <b>云端房产网信息管理平台使用指南</b>
            </div>

            <ul class="infolist">
                <li><span>您可以快速进行信息发布管理操作</span><a class="ibtn" href="<%=path%>/admin/cms/content/info_manage.jsp">发布或管理信息</a></li>
                <li><span>审核已发布的信息</span><a class="ibtn" href="<%=path%>/admin/cms/content/info_check_manage.jsp">审核信息</a></li>
                <li><span>您可以进行系统用户管理、密码修改等操作</span><a class="ibtn" href="<%=path%>/admin/organization/user_manage.jsp">用户管理</a></li>
            </ul>

            <div class="xline"></div>

            <div class="uimakerinfo"><b>云端房产网信息管理平台常见问题</b></div>

            <ul class="umlist">
                <li><a href="#">如何发布文章</a></li>
                <li><a href="#">如何访问网站</a></li>
                <li><a href="#">如何管理广告</a></li>
                <li><a href="#">后台用户设置(权限)</a></li>
                <li><a href="#">系统设置</a></li>
            </ul>


        </div>



    </body>

</html>
