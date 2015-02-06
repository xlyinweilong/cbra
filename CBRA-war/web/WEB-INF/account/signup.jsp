<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html>
    <head>
        <jsp:include page="/WEB-INF/public/z_header.jsp"/>
    </head>
    <body>
        <jsp:include page="/WEB-INF/public/z_top.jsp"></jsp:include>
        <jsp:include page="/WEB-INF/public/z_banner.jsp"/>
        <!-- 主体 -->
        <div class="ind-reg">
            <!-- 标题 -->
            <div class="Title"><a href="/account/signup" id="ind-reg-b">个人入会申请</a><a href="/account/signup_c">企业入会申请</a></div>

            <div class="Title-reg">基本信息<a style=" margin-left:10px; font-size:12px; color:#e8a29a; font-weight:normal;">(基本信息全部为必填项)</a></div>

            <table width="914" border="0" align="center" style="margin:0 auto; border-bottom:2px #dddddd solid; padding-bottom:20px;">
                <tr>
                    <td class="reg-1">中文姓名</td>
                    <td class="reg-2"><input type="text" class="Input-1"></td>
                    <td class="reg-1">英文姓名</td>
                    <td><input type="text" class="Input-1"></td>
                </tr>
                <tr>
                    <td class="reg-1">手机</td>
                    <td class="reg-2"><input type="text" class="Input-1"></td>
                    <td class="reg-1">EMAIL</td>
                    <td><input type="text" class="Input-1"></td>
                </tr>
                <tr>
                    <td class="reg-1">行业从业时间</td>
                    <td class="reg-2"><input type="text" class="Input-1"></td>
                    <td class="reg-1">目前就职公司</td>
                    <td><input type="text" class="Input-1"></td>
                </tr>
                <tr>
                    <td class="reg-1">产业链位置</td>
                    <td class="reg-2"><select class="Input-1"><option>请选择</option></select></td>
                </tr>
                <tr>
                    <td class="reg-1">职务</td>
                    <td class="reg-2"><input type="radio">职务1  <input type="radio">职务1   <input type="radio">职务1   <input type="radio">职务1  <input type="radio">职务1  <input type="radio">职务1 </td>
                    <td class="reg-1">其他</td>
                    <td><input type="text" class="Input-1"></td>
                </tr>
                <tr>
                    <td class="reg-1">邮寄地址</td>
                    <td class="reg-2"><input type="text" class="Input-1"></td>
                    <td class="reg-1">邮编</td>
                    <td><input type="text" class="Input-1"></td>
                </tr>
            </table>

            <div class="Title-reg">实名认证</div>

            <table width="914" border="0" style="margin:0 auto; border-bottom:2px #dddddd solid; padding-bottom:20px;">
                <tr>
                    <td align="center" style="width:457px;"><div class="reg-img"><br><br><br><p>上传身份证证面</p><p>上传图片大小不得超过200K
                                支持JPG、PNG图片格式</p><input type="button" style=" width:98px; height:26px; background:#bbbbbb; color:#FFF; border:0; border-radius:5px; cursor:pointer;" value="选择图片路径"></div><input type="button" style=" width:110px; height:32px; background:#52853d; color:#FFF; border:0; border-radius:5px; cursor:pointer;" value="上传图片"></td>
                    <td align="center" style="width:457px;"><div class="reg-img"><br><br><br><p>上传身份证背面</p><p>上传图片大小不得超过200K
                                支持JPG、PNG图片格式</p><input type="button" style=" width:98px; height:26px; background:#bbbbbb; color:#FFF; border:0; border-radius:5px; cursor:pointer;" value="选择图片路径"></div><input type="button" style=" width:110px; height:32px; background:#52853d; color:#FFF; border:0; border-radius:5px; cursor:pointer;" value="上传图片"></td>
                </tr>
            </table>

            <div class="Title-reg">工作履历</div>

            <table width="914" border="0" style="margin:0 auto; border-bottom:2px #dddddd solid; padding-bottom:20px;">
                <tr>
                    <td align="center" ><textarea style="width:910px; height:60px; border:1px #e6e6e6 solid;"></textarea></td>
                </tr>
            </table>

            <div class="Title-reg">项目经验</div>

            <table width="914" border="0" style="margin:0 auto; border-bottom:2px #dddddd solid; padding-bottom:20px;">
                <tr>
                    <td align="center" ><textarea style="width:910px; height:60px; border:1px #e6e6e6 solid;"></textarea></td>
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
