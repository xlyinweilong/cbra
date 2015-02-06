<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html>
    <head>
        <jsp:include page="/WEB-INF/public/z_header.jsp"/>

    </head>

    <body>

        <jsp:include page="/WEB-INF/public/z_top.jsp" />

        <div class="two-loc">
            <div class="two-loc-c">当前位置：<a href="index.asp">筑誉首页</a> > 个人会员中心</div>
        </div>

        <!-- 主体 -->
        <div class="mc-main">

            <table width="1000" border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td valign="top" class="fl-nav">

                        <jsp:include page="/WEB-INF/account/z_left.jsp"><jsp:param name="page" value="5" /></jsp:include>

                    </td>

                    <td valign="top" class="fr-c">
                        <div class="top-xx">
                            <div class="img"><img src="ls/ls-26.jpg"></div>
                            <div class="hyxx">
                                <div class="hy-tit">欢迎回来<span>会员名</span>　　会员编号<span>201502022253</span></div>
                                <div class="hy-titxx">入会时间：<span>2015-01-30</span>　　　入会年限：<span>1</span> 年　　　已报名活动：<span>7</span>　　　已参加活动：<span>45</span></div>
                                <div class="hy-titrz"><span class="rzimg-1">实名认证</span><span class="rzimg-2">营业执照认证</span><span class="rzimg-3">手机认证</span><span class="rzimg-4">邮箱认证</span></div>
                            </div>
                        </div>

                        <table width="760" border="0" cellpadding="0" cellspacing="1" style="background:#ebebeb; margin-top:20px;">
                            <tr>
                                <td class="hyzl-1">企业全称</td>
                                <td class="hyzl-2">筑誉建筑联合会</td>
                                <td class="hyzl-1">营业执照注册号</td>
                                <td class="hyzl-2">20150215132456</td>
                            </tr>
                            <tr>
                                <td class="hyzl-1">企业邮箱</td>
                                <td class="hyzl-2">zylhh@zylhh.com</td>
                                <td class="hyzl-1">创立时间</td>
                                <td class="hyzl-2">2000-11-11</td>
                            </tr>
                            <tr>
                                <td class="hyzl-1">企业法人</td>
                                <td class="hyzl-2">林小姐</td>
                                <td class="hyzl-1">企业性质</td>
                                <td class="hyzl-2">建筑</td>
                            </tr>
                            <tr>
                                <td class="hyzl-1">企业规模</td>
                                <td class="hyzl-2">2000-5000人</td>
                                <td class="hyzl-1">产业链位置</td>
                                <td class="hyzl-2">产品经理</td>
                            </tr>
                            <tr>
                                <td class="hyzl-1">企业地址</td>
                                <td class="hyzl-2">吉林省长春市绿园区</td>
                                <td class="hyzl-1">邮编</td>
                                <td class="hyzl-2">130000</td>
                            </tr>
                        </table>
                        <table width="760" border="0" cellpadding="0" cellspacing="1" style="background:#ebebeb; margin-top:20px;">
                            <tr>
                                <td class="hyzl-1">登录代表信息</td>
                                <td class="hyzl-3">登录代表帐号：15512349876<br>登录代表密码：dengludaib121245<br></td>
                            </tr>
                            <tr>
                                <td class="hyzl-1">登录代表信息</td>
                                <td class="hyzl-3">登录代表帐号：18878945612<br>登录代表密码：yirandaib852741<br></td>
                            </tr>
                        </table>
                        <div style="text-align:center; margin:10px auto;"><input type="button" style=" width:130px; height:42px; line-height:42px; background:#52853d; color:#FFF; border:0; border-radius:5px; font-size:14px; cursor:pointer;" value="修改资料" onclick="location.href = '#'" ></div>

                    </td>

                </tr>
            </table>



            <div style="clear:both;"></div>
        </div>
        <!-- 主体 end -->

        <jsp:include page="/WEB-INF/public/z_end.jsp"/>

    </body>
</html>

