<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
        <script type="text/javascript" src="<%=path%>/background/js/My97DatePicker/WdatePicker.js"></script>
        <script type="text/javascript" src="<%=path%>/background/js/common/common.js"></script>
    </head>
    <script type="text/javascript">
        $(function () {
            $("#position").change(function(){
                if($("#position").val() === 'others'){
                    $("#others").show();
                }else{
                    $("#others").hide();
                }
            });
            $("#saveBtn").click(function () {
                var rules = {
                    "companyAccount.account": {required: true},
                    "companyAccount.name": {required: true},
                    "companyAccount.email": {required: true}
                };
                var messages = {
                    "companyAccount.account": {required: "账户必须填写！"},
                    "companyAccount.name": {required: "名称必须填写！"},
                    "companyAccount.email": {required: "邮箱必须填写！"}
                };
                //初始化验证框架
                FormSave("form1", rules, messages);
                $("#form_action").val("UPDATE_COMPANY_ACCOUNT");
                $("#form1").attr("action", "/admin/account/c_user_info");
                $("#form1").submit();
            });
            $.fn.goback();
        });
        
        /**
         * 返回
         */
        $.fn.goback = function () {
            $("#gobackBtn").click(function () {
                window.location.href = "/admin/account/c_user_list";
            });
        }
        $.fn.approval = function (type) {
            $("#form_type").val(type);
            $("#form_action").val("ACCOUNT_APPROVAL");
            $("#form1").attr("action", "/admin/account/c_user_info");
            $("#form1").submit();
        }
    </script>
    <body>
        <div class="place">
            <span>位置：</span>
            <ul class="placeul">
                <li><a href="#">首页</a></li>
                <li><a href="#">用户管理</a></li>
                <li><a href="#">公司用户管理</a></li>
            </ul>
        </div>
        <div class="formbody">
            <div class="formtitle"><span>状态：${companyAccount.status.mean}</span></div>
            <form id="form1" name="form1" method="post" theme="simple">
                <input type="hidden" name="id" value="${companyAccount.id}" />
                <input id="form_action" type="hidden" name="a" value="" />
                <input id="form_type" type="hidden" name="type" value="" />
                <ul class="forminfo">
                    <li><label>账户(营业执照注册号)<b>*</b></label><input type="text" class="dfinput" style="width: 350px;" name="account" value="${companyAccount.account}" maxlength="25" /></li>
                    <li><label>密码</label><input type="text" class="dfinput" style="width: 350px;" name="passwd" value="" maxlength="25" />(不填写不修改)</li>
                    <li><label>企业全称<b>*</b></label><input type="text" class="dfinput" style="width: 350px;" name="name" value="${companyAccount.name}" maxlength="25" /></li>
                    <li><label>邮箱<b>*</b></label><input type="text" class="dfinput" style="width: 350px;" name="email" value="${companyAccount.email}" maxlength="50" /></li>
                    <li><label>创立时间</label><input type="text" class="dfinput" style="width: 350px;" name="companyCreateDate" onclick="WdatePicker({dateFmt: 'yyyy-MM-dd HH:mm:ss'})" value="<fmt:formatDate value='${companyAccount.companyCreateDate}' pattern='yyyy-MM-dd HH:mm:ss' type='date' dateStyle='long' />" maxlength="25" /></li>
                    <li><label>企业法人</label><input type="text" class="dfinput" style="width: 350px;" name="legalPerson" value="${companyAccount.legalPerson}" maxlength="100" /></li>
                    <li><label>企业网址</label><input type="text" class="dfinput" style="width: 350px;" name="webSide" value="${companyAccount.webSide}" maxlength="100" /></li>
                    <li><label>企业资质等级</label><input type="text" class="dfinput" style="width: 350px;" name="enterpriseQalityGrading" value="${companyAccount.enterpriseQalityGrading}" maxlength="100" /></li>
                    <li><label>主项资质发证时间</label><input type="text" class="dfinput" style="width: 350px;" name="authenticationDate" onclick="WdatePicker({dateFmt: 'yyyy-MM-dd HH:mm:ss'})" value="<fmt:formatDate value='${companyAccount.authenticationDate}' pattern='yyyy-MM-dd HH:mm:ss' type='date' dateStyle='long' />" maxlength="25" /></li>
                    <li><label>安全生产许可证编号</label><input type="text" class="dfinput" style="width: 350px;" name="productionLicenseNumber" value="${companyAccount.productionLicenseNumber}" maxlength="100" /></li>
                    <li><label>安全生产许可证有效期</label><input type="text" class="dfinput" style="width: 350px;" name="productionLicenseValidDate" onclick="WdatePicker({dateFmt: 'yyyy-MM-dd HH:mm:ss'})" value="<fmt:formatDate value='${companyAccount.productionLicenseValidDate}' pattern='yyyy-MM-dd HH:mm:ss' type='date' dateStyle='long' />" maxlength="25" /></li>
                    <li><label>产业链位置</label>
                        <c:forEach var="accountIcPosition" items="${accountIcPositionList}">
                            <input <c:if test="${positionList.contains(accountIcPosition.key)}">checked="checked"</c:if> type="checkbox" name="accountIcPosition" value="${accountIcPosition.key}" />${accountIcPosition.name}&nbsp;&nbsp;
                        </c:forEach>
                    </li>
                    <li><label>企业性质</label><select id="nature" name="nature" class="dfinput">
                                        <c:forEach var="companyNatureEnum" items="${companyNatureEnums}">
                                            <option <c:if test="${companyNatureEnum == companyAccount.nature}">selected="selected"</c:if> value="${companyNatureEnum.name()}">${companyNatureEnum.mean}</option>
                                        </c:forEach>
                                    </select>
                    </li>
                    <li id="others" style="<c:if test="${empty companyAccount.natureOthers}">display: none</c:if>"><label>其他</label><input type="text" class="dfinput" style="width: 350px;" name="natureOthers" value="${companyAccount.natureOthers}" maxlength="200" /></li>
                    <li><label>企业人数</label><select id="scale" name="scale" class="dfinput">
                                        <c:forEach var="companyScaleEnum" items="${companyScaleEnums}">
                                            <option <c:if test="${companyScaleEnum == companyAccount.scale}">selected="selected"</c:if> value="${companyScaleEnum.name()}">${companyScaleEnum.mean}</option>
                                        </c:forEach>
                                    </select>
                    </li>
                    <li><label>邮寄地址</label><input type="text" class="dfinput" style="width: 350px;" name="address" value="${companyAccount.address}" maxlength="200" /></li>
                    <li><label>邮编</label><input type="text" class="dfinput" style="width: 350px;" name="zipCode" value="${companyAccount.zipCode}" maxlength="50" /></li>
                    <li style="height: 210px;">
                        <labe style="width:800px">
                            &nbsp;
                            </label>
                            <div class="infoleft" style="width:330px;height:220px;">
                                <div class="listtitle"><a href="${companyAccount.businessLicenseUrl}" class="more1" target="_blank">查看大图</a>上传企业营业执照副本（彩色加盖公章）</div>    
                                <ul class="newlist">
                                    <img align="center" width="300px" height="150px" src="${pageContent.request.contextPath}${companyAccount.businessLicenseUrl}" />
                                </ul>   
                            </div>
                            <div class="infoleft" style="width:330px;height:220px;">
                                <div class="listtitle"><a href="${companyAccount.qualificationCertificateUrl}" class="more1" target="_blank">下载文件</a>资质证书打包文件</div>    
                            </div>
                    </li>
                    <li style="margin-top: 15px;">
                        <label style="display: block;float : left;line-height : 34px;padding:10px; ">
                            目标客户或擅长领域:
                        </label>
                        <textarea name="field" style="border:1px solid #999;font-size:12px;padding:1px;overflow:auto;text-align:left; padding:5px;width: 700px; height: 120px;">${companyAccount.field}</textarea>
                    </li>
                </ul>
                <c:if test="${companyAccount.status == 'PENDING_FOR_APPROVAL'}">
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
                            <textarea name="message" style="border:1px solid #999;font-size:12px;padding:1px;overflow:auto;text-align:left; padding:5px;width: 700px; height: 120px;">${companyAccount.approvalInformation}</textarea>
                            <i></i>
                        </li>
                    </ul>
                </c:if>
                <li><label>&nbsp;</label>
                    <input id="saveBtn" name="saveBtn" type="button" class="btn" value="修改"/>
                    <input id="gobackBtn" name="gobackBtn" type="button" class="btn" value="返回"/>
                    <c:if test="${companyAccount.status == 'PENDING_FOR_APPROVAL'}">
                        <input id="passBtn" name="passBtn" type="button" class="btn" value="审批通过" onclick="$.fn.approval('ASSOCIATE_MEMBER');"/>
                        <input id="noPassBtn" name="noPassBtn" type="button" class="btn" value="审批不通过" onclick="$.fn.approval('APPROVAL_REJECT');"/>
                    </c:if>
                </li>
                </ul>
            </form>
            <script type="text/javascript">
                $(document).ready(function () {
                <c:if test="${postResult.singleSuccessMsg != null}">alert("${postResult.singleSuccessMsg}");</c:if>
                <c:if test="${postResult.singleErrorMsg != null}">alert("${postResult.singleErrorMsg}");</c:if>
                    });
            </script>
        </div>
    </body>
</html>
