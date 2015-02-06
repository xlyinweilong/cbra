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
        <jsp:include page="/WEB-INF/public/z_banner.jsp"/>

        <!-- 主体 -->
        <div class="ind-reg">
            <!-- 标题 -->
            <div class="Title"><a href="/account/signup">个人入会申请</a><a href="/account/signup_c" id="ind-reg-b">企业入会申请</a></div>

            <div class="Title-reg">基本信息<a style=" margin-left:10px; font-size:12px; color:#e8a29a; font-weight:normal;">(必填项)</a></div>

            <table width="914" border="0" align="center" style="margin:0 auto; border-bottom:2px #dddddd solid; padding-bottom:20px;">
                <tr>
                    <td class="reg-1">企业全称</td>
                    <td colspan="3" class="reg-2"><input type="text" class="Input-1"></td>
                </tr>
                <tr>
                    <td class="reg-1">营业执照注册号</td>
                    <td class="reg-2"><input type="text" class="Input-1"></td>
                    <td class="reg-1">企业邮箱</td>
                    <td><input type="text" class="Input-1"></td>
                </tr>
                <tr>
                    <td class="reg-1">创立时间</td>
                    <td class="reg-2"><input type="text" class="Input-1"></td>
                    <td class="reg-1">企业法人</td>
                    <td><input type="text" class="Input-1"></td>
                </tr>
                <tr>
                    <td class="reg-1">企业性质</td>
                    <td colspan="3" class="reg-2"><input type="checkbox">企业性质　<input type="checkbox">企业性质　<input type="checkbox">企业性质　<input type="checkbox">企业性质　</td>
                </tr>
                <tr>
                    <td class="reg-1">企业规模</td>
                    <td class="reg-2"><select class="Input-1"><option>请选择</option></select></td>
                    <td class="reg-1">产业链位置</td>
                    <td><input type="text" class="Input-1"></td>
                </tr>
                <tr>
                    <td class="reg-1">企业地址</td>
                    <td class="reg-2"><input type="text" class="Input-1"></td>
                    <td class="reg-1">邮编</td>
                    <td><input type="text" class="Input-1"></td>
                </tr>
            </table>


            <div class="Title-reg"><a style=" margin-left:10px; font-size:12px; color:#e8a29a; font-weight:normal;">(选填项)</a></div>

            <table width="914" border="0" align="center" style="margin:0 auto; border-bottom:2px #dddddd solid; padding-bottom:20px;">
                <tr>
                    <td class="reg-3">企业网址</td>
                    <td colspan="3" class="reg-2"><input type="text" class="Input-1"></td>
                </tr>
                <tr>
                    <td class="reg-3">企业资质等级</td>
                    <td class="reg-4"><input type="text" class="Input-1"></td>
                    <td class="reg-3">主项资质发证时间</td>
                    <td><input type="text" class="Input-1"></td>
                </tr>
                <tr>
                    <td class="reg-3">安全生产许可证编号</td>
                    <td class="reg-4"><input type="text" class="Input-1"></td>
                    <td class="reg-3">安全生产许可证有效期</td>
                    <td><input type="text" class="Input-1"></td>
                </tr>
                <tr>
                    <td class="reg-3">目标客户或擅长领域</td>
                    <td colspan="3" ><textarea style="width:600px; height:40px; margin-top:20px; border:1px #e6e6e6 solid;"></textarea></td>
                </tr>


            </table>

            <div class="Title-reg">相关证明</div>

            <table width="914" border="0" style="margin:0 auto; border-bottom:2px #dddddd solid; padding-bottom:20px;">
                <tr>
                    <td align="center" style="width:457px;"><div class="reg-img"><br><br><br><p>上传企业营业执照副本</p><p>彩色加盖公章<br>上传图片大小不得超过200K，支持JPG、PNG图片格式</p><input type="button" style=" width:98px; height:26px; background:#bbbbbb; color:#FFF; border:0; border-radius:5px; cursor:pointer;" value="选择图片路径"></div><input type="button" style=" width:110px; height:32px; background:#52853d; color:#FFF; border:0; border-radius:5px; cursor:pointer;" value="上传图片"></td>
                    <td align="center" style="width:457px;"><div class="reg-img"><br><br><br><p>上传企业资质证书</p><p>可添加多个<br>上传图片大小不得超过200K，支持JPG、PNG图片格式</p><input type="button" style=" width:98px; height:26px; background:#bbbbbb; color:#FFF; border:0; border-radius:5px; cursor:pointer;" value="选择图片路径"></div><input type="button" style=" width:110px; height:32px; background:#52853d; color:#FFF; border:0; border-radius:5px; cursor:pointer;" value="上传图片"></td>
                </tr>
            </table>



            <table width="914" border="0" style="margin:20px auto; padding-bottom:20px;">
                <tr>
                    <td align="center" ><input type="button" style=" width:130px; height:42px; background:#52853d; color:#FFF; border:0; border-radius:5px; font-size:14px; cursor:pointer;" value="提交"></td>
                </tr>
            </table>

        </div>
        <!-- 主体 end -->

        <jsp:include page="/WEB-INF/public/z_end.jsp"/>

    </body>
</html>
