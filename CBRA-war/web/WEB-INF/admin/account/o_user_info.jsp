<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
        <link rel="stylesheet" href="<%=path%>/background/css/style.css" type="text/css" />
        <link rel="stylesheet" href="<%=path%>/background/js/validate/tip-yellowsimple/tip-yellowsimple.css" type="text/css" />
        <link rel="stylesheet" href="<%=path%>/background/js/validate/tip-green/tip-green.css" type="text/css" />
        <script type="text/javascript" src="<%=path%>/background/js/jquery.js"></script>
        <script type="text/javascript" src="<%=path%>/background/js/validate/jquery.poshytip.js"></script>
        <script type="text/javascript" src="<%=path%>/background/js/validate/jquery.validate.js"></script>
        <script type="text/javascript" src="<%=path%>/background/js/common/common.js"></script>
    </head>
    <script type="text/javascript">
        $(function () {
            $("#saveBtn").click(function () {
                var rules = {
                    "roleName": {required: true}
                };
                var messages = {
                    "roleName": {required: "角色名称必须填写！"}
                };
                //初始化验证框架
                FormSave("form1", rules, messages);
                $("#form1").attr("target", "iframe1");
                $("#form1").attr("action", "/admin/organization/role_info");
                $("#form1").submit();
            });
            $.fn.goback();
        });

        /**
         * 返回
         */
        $.fn.goback = function () {
            $("#gobackBtn").click(function () {
                window.location.href = "/admin/organization/role_list";
            });
        }
    </script>
    <body>
        <div class="place">
            <span>位置：</span>
            <ul class="placeul">
                <li><a href="#">首页</a></li>
                <li><a href="#">用户管理</a></li>
                <li><a href="#">个人账户管理</a></li>
            </ul>
        </div>
        <div class="formbody">
            <div class="formtitle"><span>基本信息</span></div>
            <form id="form1" name="form1" method="post" theme="simple" action="/admin/account/o_user_list">
                <input type="hidden" name="id" value="${userAccount.id}" />
                <input id="form_action" type="hidden" name="a" value="" />
                <ul class="forminfo">
                    <li><label>账户(手机)<b>*</b></label><input type="text" class="dfinput" style="width: 350px;" name="roleName" value="${userAccount.account}" maxlength="25" /></li>
                    <li><label>中文名称<b>*</b></label><input type="text" class="dfinput" style="width: 350px;" name="roleName" value="${userAccount.name}" maxlength="25" /></li>
                    <li><label>英文名称</label><input type="text" class="dfinput" style="width: 350px;" name="roleName" value="${userAccount.enName}" maxlength="25" /></li>
                    <li><label>邮箱<b>*</b></label><input type="text" class="dfinput" style="width: 350px;" name="roleName" value="${userAccount.email}" maxlength="50" /></li>
                    <li><label>行业从业时间</label><input type="text" class="dfinput" style="width: 350px;" name="roleName" value="${userAccount.name}" maxlength="50" /></li>
                    <li><label>目前就职公司</label><input type="text" class="dfinput" style="width: 350px;" name="roleName" value="${userAccount.name}" maxlength="50" /></li>
                    <li><label>产业链位置</label><input type="text" class="dfinput" style="width: 350px;" name="roleName" value="${userAccount.name}" maxlength="50" /></li>
                    <li><label>职务</label><input type="text" class="dfinput" style="width: 350px;" name="roleName" value="${userAccount.name}" maxlength="50" /></li>
                    <li><label>邮寄地址</label><input type="text" class="dfinput" style="width: 350px;" name="roleName" value="${userAccount.address}" maxlength="200" /></li>
                    <li><label>邮编</label><input type="text" class="dfinput" style="width: 350px;" name="roleName" value="${userAccount.zipCode}" maxlength="50" /></li>
                    <li style="height: 210px;">
                        <labe style="width:800px">
                            &nbsp;
                            </label>
                            <div class="infoleft" style="width:330px;height:220px;">
                                <div class="listtitle"><a href="${userAccount.personCardFront}" class="more1" target="_blank">查看大图</a>身份证正面照片</div>    
                                <ul class="newlist">
                                    <img align="center" width="300px" height="150px" src="${pageContent.request.contextPath}${userAccount.personCardFront}" />
                                </ul>   
                            </div>
                            <div class="infoleft" style="width:330px;height:220px;">
                                <div class="listtitle"><a href="${userAccount.personCardBack}" class="more1" target="_blank">查看大图</a>身份证反面照片</div>    
                                <ul class="newlist">
                                    <img align="center" width="300px" height="150px" src="${pageContent.request.contextPath}${userAccount.personCardBack}" />
                                </ul>   
                            </div>
                    </li>
                    <li style="margin-top: 35px;">
                        <label style="display: block;float : left;line-height : 34px;padding:10px; ">
                            工作履历:
                        </label>
                        <textarea name="house.otherInformation" style="border:1px solid #999;font-size:12px;padding:1px;overflow:auto;text-align:left; padding:5px;width: 700px; height: 120px;">${userAccount.workExperience}</textarea>
                    </li>
                    <li style="margin-top: 15px;">
                        <label style="display: block;float : left;line-height : 34px;padding:10px; ">
                            项目经验:
                        </label>
                        <textarea name="house.otherInformation" style="border:1px solid #999;font-size:12px;padding:1px;overflow:auto;text-align:left; padding:5px;width: 700px; height: 120px;">${userAccount.projectExperience}</textarea>
                    </li>
                </ul>
                <c:if test="${userAccount.status == 'PENDING_FOR_APPROVAL'}">
                    <ul class="forminfo">
                        <li>
                            <labe style="height:20px;">&nbsp;</label>
                        </li>
                    </ul>
                    <span style="padding-left: 20px;">审批</span>
                    <div style="display: block; margin-top: 0px; width: 700px; height: 1px; background-color: black; margin-left: 20px;"></div>
                    <ul class="forminfo">
                        <li></li>
                        <li>
                            <label>
                                审批说明
                            </label>
                            <textarea name="house.otherInformation" style="border:1px solid #999;font-size:12px;padding:1px;overflow:auto;text-align:left; padding:5px;width: 700px; height: 120px;">${userAccount.projectExperience}</textarea>
                            <i></i>
                        </li>
                    </ul>
                </c:if>
                <li><label>&nbsp;</label>
                    <input id="saveBtn" name="saveBtn" type="button" class="btn" value="修改"/>
                    <input id="gobackBtn" name="gobackBtn" type="button" class="btn" value="返回"/>
                    <c:if test="${userAccount.status == 'PENDING_FOR_APPROVAL'}">
                        <input id="passBtn" name="passBtn" type="button" class="btn" value="审批通过" onclick="$.fn.valid(0);"/>
                        <input id="noPassBtn" name="noPassBtn" type="button" class="btn" value="审批不通过" onclick="$.fn.valid(1);"/>
                    </c:if>
                </li>
                </ul>
            </form>
            <iframe name="iframe1" id="iframe1" width="1px" height="1px"></iframe>
        </div>
    </body>
</html>
