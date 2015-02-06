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
        <jsp:include page="/WEB-INF/public/z_account_banner.jsp" />
        <!-- 主体 -->
        <div class="mc-main">
            <table width="1000" border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td valign="top" class="fl-nav">
                        <jsp:include page="/WEB-INF/account/z_left.jsp"><jsp:param name="page" value="1" /></jsp:include>
                        </td>
                        <td valign="top" class="fr-c">
                            <div class="top-xx">
                                <div class="img"><img src="/ls/ls-26.jpg"></div>
                                <div class="hyxx">
                                    <div class="hy-tit">欢迎回来<span>会员名</span>　　会员编号<span>201502022253</span></div>
                                    <div class="hy-titxx">入会时间：<span>2015-01-30</span>　　　入会年限：<span>1</span> 年　　　已报名活动：<span>7</span>　　　已参加活动：<span>45</span></div>
                                    <div class="hy-titrz"><span class="rzimg-1">实名认证</span><span class="rzimg-2">营业执照认证</span><span class="rzimg-3">手机认证</span><span class="rzimg-4">邮箱认证</span></div>
                                </div>
                            </div>
                            <table width="760" border="0" cellpadding="0" cellspacing="1" style="background:#ebebeb; margin-top:20px;">
                                <tr>
                                    <td class="hyzl-1">中文姓名</td>
                                    <td class="hyzl-2">张小白</td>
                                    <td class="hyzl-1">英文姓名</td>
                                    <td class="hyzl-2">white</td>
                                </tr>
                                <tr>
                                    <td class="hyzl-1">手机</td>
                                    <td class="hyzl-2">15044112236</td>
                                    <td class="hyzl-1">EMAIL</td>
                                    <td class="hyzl-2">1838762@qq.com</td>
                                </tr>
                                <tr>
                                    <td class="hyzl-1">行业从业时间</td>
                                    <td class="hyzl-2">7年</td>
                                    <td class="hyzl-1">目前就职公司</td>
                                    <td class="hyzl-2">网络科技有限公司</td>
                                </tr>
                                <tr>
                                    <td class="hyzl-1">产业链位置</td>
                                    <td class="hyzl-2">不到啊</td>
                                    <td class="hyzl-1">职务</td>
                                    <td class="hyzl-2">产品经理</td>
                                </tr>
                                <tr>
                                    <td class="hyzl-1">邮寄地址</td>
                                    <td class="hyzl-2">吉林省长春市绿园区</td>
                                    <td class="hyzl-1">邮编</td>
                                    <td class="hyzl-2">130000</td>
                                </tr>
                            </table>
                            <table width="760" border="0" cellpadding="0" cellspacing="1" style="background:#ebebeb; margin-top:20px;">
                                <tr>
                                    <td class="hyzl-1">工作履历</td>
                                    <td class="hyzl-3">我们本着构筑行业信誉，推动中国建筑行业进步的使命，怀着成为建筑业最具公信力专业平台的协会愿景以及为了体现诚实守信，平等互助和透明规范的协会价值，在21世纪全球聚焦中国迅速发展的今天成立我们的专业行业协会，任重而道远！回顾过去的建筑发展历程</td>
                                </tr>
                            </table>
                            <table width="760" border="0" cellpadding="0" cellspacing="1" style="background:#ebebeb; margin-top:20px;">
                                <tr>
                                    <td class="hyzl-1">项目经验</td>
                                    <td class="hyzl-3">我们本着构筑行业信誉，推动中国建筑行业进步的使命，怀着成为建筑业最具公信力专业平台的协会愿景以及为了体现诚实守信，平等互助和透明规范的协会价值，在21世纪全球聚焦中国迅速发展的今天成立我们的专业行业协会，任重而道远！回顾过去的建筑发展历程</td>
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
