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
            <form id="reg_form" method="post" enctype="multipart/form-data" action="/account/signup">
                <input type="hidden" name="a" value="SIGNUP" />
                <input id="front_hidden" type="hidden" name="front" value="" />
                <input id="back_hidden" type="hidden" name="back" value="" />
                <div class="Title"><a href="/account/signup" id="ind-reg-b">个人入会申请</a><a href="/account/signup_c">企业入会申请</a></div>
                <div id="step1">
                    <div class="Title-reg">基本信息<a style=" margin-left:10px; font-size:12px; color:#e8a29a; font-weight:normal;">(基本信息全部为必填项)</a></div>
                    <table width="914" border="0" align="center" style="margin:0 auto; border-bottom:2px #dddddd solid; padding-bottom:20px;">
                        <tr>
                            <td class="reg-1">中文姓名</td>
                            <td class="reg-2"><input type="text" name="" value="" class="Input-1"/></td>
                            <td class="reg-1">英文姓名</td>
                            <td><input type="text" class="Input-1"></td>
                        </tr>
                        <tr>
                            <td class="reg-1">手机</td>
                            <td class="reg-2"><input type="text" name="" value="" class="Input-1"/></td>
                            <td class="reg-1">EMAIL</td>
                            <td><input type="text" class="Input-1"></td>
                        </tr>
                        <tr>
                            <td class="reg-1">行业从业时间</td>
                            <td class="reg-2"><input type="text" name="" value="" class="Input-1"/></td>
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
                    <table width="914" border="0" style="margin:20px auto; padding-bottom:20px;">
                        <tr>
                            <td align="center" >
                                <input id="step1_next" type="button" style=" width:130px; height:42px; background:#52853d; color:#FFF; border:0; border-radius:5px; font-size:14px; cursor:pointer;" value="下一步" />
                            </td>
                        </tr>
                    </table>
                </div>
            </form>
            <div id="step2" style="display: none">
                <div class="Title-reg">实名认证</div>
                <table width="914" border="0" style="margin:0 auto; border-bottom:2px #dddddd solid; padding-bottom:20px;">
                    <tr>
                    <form id="reg_front_form" method="post" enctype="multipart/form-data" target="iframe1" action="/account/z_iframe_upload_pc?type=front">
                        <input type="hidden" name="a" value="upload_person_card" />
                        <td align="center" style="width:457px;">
                            <div class="reg-img">
                                <div id="reg_front_div">
                                    <br><br><br><p>上传身份证正面</p><p>上传图片大小不得超过2MB
                                        支持JPG、PNG图片格式</p>
                                </div>
                                <img id="reg_front_img" src="" width="300" height="190" style="display: none" />
                                <input id="reg_front_button" type="button" style=" width:98px; height:26px; background:#bbbbbb; color:#FFF; border:0; border-radius:5px; cursor:pointer;" value="选择图片路径">
                                <p id="reg_front_result"></p>
                            </div>
                            <input id="reg_front_submit" type="button" style=" width:110px; height:32px; background:#52853d; color:#FFF; border:0; border-radius:5px; cursor:pointer;" value="上传图片">
                            <input style="display: none" id="reg_front" type="file" name="reg_front_file" onchange="document.getElementById('reg_front_result').innerHTML = this.value" />
                        </td>
                    </form>
                    <form id="reg_back_form" method="post" enctype="multipart/form-data" target="iframe1" action="/account/z_iframe_upload_pc?type=back">
                        <input type="hidden" name="a" value="upload_person_card"  />
                        <td id="reg_back_td" align="center" style="width:457px;">
                            <div class="reg-img">
                                <div id="reg_back_div">
                                    <br><br><br><p>上传身份证背面</p><p>上传图片大小不得超过2MB
                                        支持JPG、PNG图片格式</p>
                                </div>
                                <img id="reg_back_img" src="" width="300" height="190" style="display: none" />
                                <input id="reg_back_button" type="button" style=" width:98px; height:26px; background:#bbbbbb; color:#FFF; border:0; border-radius:5px; cursor:pointer;" value="选择图片路径">
                                <p id="reg_back_result"></p>
                            </div>
                            <input id="reg_back_submit" type="button" style=" width:110px; height:32px; background:#52853d; color:#FFF; border:0; border-radius:5px; cursor:pointer;" value="上传图片">
                            <input style="display: none" id="reg_back" type="file" name="reg_back_file" onchange="document.getElementById('reg_back_result').innerHTML = this.value" />
                        </td>
                    </form>
                    </tr>
                </table>
                <table width="914" border="0" style="margin:20px auto; padding-bottom:20px;">
                    <tr>
                        <td align="center" >
                            <input id="step2_before" type="button" style=" width:130px; height:42px; background:#52853d; color:#FFF; border:0; border-radius:5px; font-size:14px; cursor:pointer;" value="上一步" />&nbsp&nbsp
                            <input id="step2_next" type="button" style=" width:130px; height:42px; background:#52853d; color:#FFF; border:0; border-radius:5px; font-size:14px; cursor:pointer;" value="下一步" />
                        </td>
                    </tr>
                </table>
            </div>
            <div id="step3" style="display: none">
                <div class="Title-reg">工作履历</div>

                <table width="914" border="0" style="margin:0 auto; border-bottom:2px #dddddd solid; padding-bottom:20px;">
                    <tr>
                        <td align="center" ><textarea id="workExperience" style="width:910px; height:150px; border:1px #e6e6e6 solid;"></textarea></td>
                    </tr>
                </table>
                <table width="914" border="0" style="margin:20px auto; padding-bottom:20px;">
                    <tr>
                        <td align="center" >
                            <input id="step3_before" type="button" style=" width:130px; height:42px; background:#52853d; color:#FFF; border:0; border-radius:5px; font-size:14px; cursor:pointer;" value="上一步" />&nbsp&nbsp
                            <input id="step3_next" type="button" style=" width:130px; height:42px; background:#52853d; color:#FFF; border:0; border-radius:5px; font-size:14px; cursor:pointer;" value="下一步" />
                        </td>
                    </tr>
                </table>
            </div>
            <div id="step4" style="display: none">
                <div class="Title-reg">项目经验</div>
                <table width="914" border="0" style="margin:0 auto; border-bottom:2px #dddddd solid; padding-bottom:20px;">
                    <tr>
                        <td align="center" ><textarea id="projectExperience" style="width:910px; height:150px; border:1px #e6e6e6 solid;"></textarea></td>
                    </tr>
                </table>
                <table width="914" border="0" style="margin:20px auto; padding-bottom:20px;">
                    <tr>
                        <td align="center" >
                            <input id="step4_before" type="button" style=" width:130px; height:42px; background:#52853d; color:#FFF; border:0; border-radius:5px; font-size:14px; cursor:pointer;" value="上一步" />&nbsp&nbsp
                            <input id="step4_next" type="button" style=" width:130px; height:42px; background:#52853d; color:#FFF; border:0; border-radius:5px; font-size:14px; cursor:pointer;" value="提 交" />
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        <iframe id="iframe1" name="iframe1" style="display:none;"></iframe>
        <!-- 主体 end -->
        <jsp:include page="/WEB-INF/public/z_end.jsp"/>
        <script type="text/javascript">
            $(document).ready(function () {
                $("#step1_next").click(function () {
                    $("#step1").hide();
                    $("#step2").show();
                });
                $("#step2_next").click(function () {
                    if($("#front_hidden").val() == "" || $("#back_hidden").val() == ""){
                        alert("请上传文件");
                        return;
                    }
                    $("#step2").hide();
                    $("#step3").show();
                });
                $("#step3_next").click(function () {
                    if($.trim($("#workExperience").val()) == ""){
                        alert("请输入内容");
                        return;
                    }
                    $("#step3").hide();
                    $("#step4").show();
                });
                $("#step4_next").click(function () {
                    if($.trim($("#projectExperience").val()) == ""){
                        alert("请输入内容");
                        return;
                    }
                    //submit
                });
                $("#step2_before").click(function () {
                    $("#step2").hide();
                    $("#step1").show();
                });
                $("#step3_before").click(function () {
                    $("#step3").hide();
                    $("#step2").show();
                });
                $("#step4_before").click(function () {
                    $("#step4").hide();
                    $("#step3").show();
                });
                $("#reg_front_button").click(function () {
                    $("#reg_front").click();
                });
                $("#reg_back_button").click(function () {
                    $("#reg_back").click();
                });
                $("#reg_front_submit").click(function () {
                    if($("#reg_front").val() == ''){
                        alert("请选择图片路径！");
                        return;
                    }
                    $("#reg_front_form").submit();
                });
                $("#reg_back_submit").click(function () {
                    if($("#reg_back").val() == ''){
                        alert("请选择图片路径！");
                        return;
                    }
                    $("#reg_back_form").submit();
                });
            })
        </script>
    </body>
</html>
