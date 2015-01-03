<%-- 
    Document   : detail_seal
    Created on : May 27, 2011, 4:02:14 PM
    Author     : WangShuai
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<%
    request.setAttribute("mainMenuSelection", "");
    request.setAttribute("subMenuSelection", "");
%>

<%@include file="/WEB-INF/support/z_header.jsp"%>

<script type="text/javascript">
    function checkRejectSealForm(){
        var rejectMsg = $("#reject_msg").val();
        if("" == rejectMsg){
            alert("Please input the reject msg");
            return false;
        }
        return true;
    }
</script>

<div class="BlueBox">
    <div class="noticeMessage">
        <c:choose>
            <c:when test="${userAccountSeal.processStatus == 'PENDING'}">
                <div class="successMessage">认证中&nbsp;&nbsp;</div>
                <div style="float: left;margin-left: 200px">   
                    <form action="/support/detail_seal" method="POST">
                        <input type="hidden" name="seal_id" value="${userAccountSeal.id}" />
                        <input type="hidden" name="a" value="approve_seal" />
                        <input type="submit" value="Approve" />
                    </form>
                </div>
                <div style="float: left;margin-left: 50px">    
                    <form action="/support/detail_seal" method="POST" onsubmit="return checkRejectSealForm();">
                        <input type="submit" value="Reject" />
                        <input type="hidden" name="seal_id" value="${userAccountSeal.id}" />
                        <input type="hidden" name="a" value="reject_seal" />
                        <input type="text" name="reject_msg" value="" id="reject_msg"/>
                    </form>   
                </div>
                <div style="float: left;margin-left: 50px">    
                    <a href="/support/un_processed_seal_list">返回</a>
                </div>
            </c:when>
            <c:when test="${userAccountSeal.processStatus == 'APPROVE'}">
                <div class="successMessage"> 认证通过&nbsp;&nbsp;</div>
                <div style="float: left;margin-left: 200px">   
                    <form action="/support/detail_seal" method="POST">
                        <input type="hidden" name="seal_id" value="${userAccountSeal.id}" />
                        <input type="hidden" name="a" value="rollback_seal_to_pending" />
                        <input type="submit" value="Rollback to Pending" />
                    </form>
                </div>
            </c:when>
            <c:when test="${userAccountSeal.processStatus == 'APPROVE_OLD'}">
                <div class="successMessage"> 认证通过(旧认证)</div>
            </c:when>   
            <c:otherwise>
                <div class="wrongMessage">认证没有通过，原因：${userAccountSeal.processMsg}</div>
            </c:otherwise>
        </c:choose>
    </div>
    <c:if test="${lastAccountSeal!=null}"><div style="background-color: #DEF1FE">此认证为二次认证</div></c:if>
    <c:choose>
        <c:when test="${userAccountSeal.user.accountType == 'USER'}">
            <div class="Padding30">
                <div class="FloatLeft BlueBoxLeft"><img src="${userAccountSeal.logoImageUrl}" alt="logo"/></div>
                <div class="FloatLeft BlueBoxContent"> 
                    <div class="sk-item TextAlignLeft bold">
                        <label class="sk-label">姓名:</label>
                        ${userAccountSeal.userName}
                    </div>
                    <div class="sk-item TextAlignLeft bold">
                        <label class="sk-label">邮箱:</label>
                        ${userAccountSeal.userEmail}
                    </div>
                    <div class="sk-item TextAlignLeft bold">
                        <label class="sk-label">手机:</label>
                        ${userAccountSeal.userMobile}
                    </div>
                    <div class="sk-item TextAlignLeft bold"> 
                        <label class="sk-label">证件种类:</label>  
                        <c:choose>
                            <c:when test="${userAccountSeal.certificateType == 'IDENTITY_CARD'}">身份证</c:when>
                            <c:when test="${userAccountSeal.certificateType == 'PASSPORT'}">护照</c:when>
                            <c:when test="${userAccountSeal.certificateType == 'GAT_TWT'}">港澳台居民大陆通行证</c:when>
                            <c:when test="${userAccountSeal.certificateType == 'SOLDIER_IDENTITY_CARD'}">军官证</c:when>
                            <c:otherwise></c:otherwise>
                        </c:choose>
                    </div>
                    <div class="sk-item TextAlignLeft bold">
                        <label class="sk-label">号码:</label>
                        ${userAccountSeal.certificateNumber}
                    </div>
                    <c:if test="${not empty userAccountSeal.additionNotes}">
                        <div class="sk-item TextAlignLeft bold">
                            <label class="sk-label">补充说明:</label>
                            ${userAccountSeal.additionNotes}
                        </div>
                    </c:if>
                    <div class="sk-item TextAlignLeft bold">
                        <label class="sk-label">证件扫描件:</label>
                        <img src="${userAccountSeal.certificateImageUrl}" alt="cimg"/>
                    </div>
                </div>
                <c:if test="${userAccountSeal.processStatus == 'APPROVE'}">
                    <div class="FloatLeft"><img src="/images/yanzheng.gif"/></div>
                    </c:if>
                <div class="clear"></div>
            </div>
            <c:if test="${lastAccountSeal!=null}">     
                <div style="background-color: #DEF1FE">上次认证信息:</div>
                <div class="Padding30">
                    <div class="FloatLeft BlueBoxLeft"><img src="${lastAccountSeal.logoImageUrl}" alt="logo"/></div>
                    <div class="FloatLeft BlueBoxContent">
                        <div class="sk-item TextAlignLeft bold">
                            <label class="sk-label">姓名:</label>
                            ${userAccountSeal.userName}
                        </div>
                        <div class="sk-item TextAlignLeft bold">
                            <label class="sk-label">邮箱:</label>
                            ${userAccountSeal.userEmail}
                        </div>
                        <div class="sk-item TextAlignLeft bold">
                            <label class="sk-label">手机:</label>
                            ${userAccountSeal.userMobile}
                        </div>
                        <div class="sk-item TextAlignLeft bold"> 
                            <label class="sk-label">证件种类:</label>  
                            <c:choose>
                                <c:when test="${userAccountSeal.certificateType == 'IDENTITY_CARD'}">身份证</c:when>
                                <c:when test="${userAccountSeal.certificateType == 'PASSPORT'}">护照</c:when>
                                <c:when test="${userAccountSeal.certificateType == 'GAT_TWT'}">港澳台居民大陆通行证</c:when>
                                <c:when test="${userAccountSeal.certificateType == 'SOLDIER_IDENTITY_CARD'}">军官证</c:when>
                                <c:otherwise>其他</c:otherwise>
                            </c:choose>
                        </div>
                        <div class="sk-item TextAlignLeft bold">
                            <label class="sk-label">号码:</label>
                            ${lastAccountSeal.certificateNumber}
                        </div>
                        <c:if test="${not empty lastAccountSeal.additionNotes}">
                            <div class="sk-item TextAlignLeft bold">
                                <label class="sk-label">补充说明:</label>
                                ${lastAccountSeal.additionNotes}
                            </div>
                        </c:if>
                        <div class="sk-item TextAlignLeft bold">
                            <label class="sk-label">证件扫描件:</label>
                            <img src="${lastAccountSeal.certificateImageUrl}" alt="cimg"/>
                        </div>
                    </div>
                    <c:if test="${lastAccountSeal.processStatus == 'APPROVE'}">
                        <div class="FloatLeft"><img src="/images/yanzheng.gif"/></div>
                        </c:if>
                    <div class="clear"></div>
                </div>
            </c:if>

        </c:when>
        <c:otherwise>
            <div class="Padding30">
                <div class="FloatLeft BlueBoxLeft"><img src="${userAccountSeal.logoImageUrl}"  alt="logo"/></div>
                <div class="FloatLeft BlueBoxContent"> 
                    <div class="sk-item TextAlignLeft bold"> 
                        <label class="sk-label">公司团体名称:</label>${userAccountSeal.companyName}
                    </div>
                    <div class="sk-item TextAlignLeft bold">
                        <label class="sk-label">官方网址:</label>
                        <a href="${userAccountSeal.companyWeb}" target="_blank">${userAccountSeal.companyWeb}</a>
                    </div>
                    <div class="sk-item TextAlignLeft bold">
                        <label class="sk-label">预计年收款额：</label>
                        <c:choose>
                            <c:when test="${userAccountSeal.companyCollectScale=='LT50'}">
                                小于50万
                            </c:when>
                            <c:when test="${userAccountSeal.companyCollectScale=='GE50LT100'}">
                                50万-200万
                            </c:when>
                            <c:when test="${userAccountSeal.companyCollectScale=='GE200'}">
                                大于200万
                            </c:when>
                            <c:otherwise>
                                未填
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div class="sk-item TextAlignLeft bold">
                        <label class="sk-label">证件种类:</label>
                        <c:choose>
                            <c:when test="${userAccountSeal.certificateType == 'BUSINESS_LICENCE'}">营业执照</c:when>
                            <c:when test="${userAccountSeal.certificateType == 'ORGANIZATION_LICENCE'}">组织机构代码证</c:when>
                            <c:when test="${userAccountSeal.certificateType == 'ARTICLE_INCORPORATION'}">Article of Incorporation</c:when>
                            <c:otherwise>其他</c:otherwise>
                        </c:choose>
                    </div>
                    <div class="sk-item TextAlignLeft bold">
                        <label class="sk-label">证件号码:</label>
                        ${userAccountSeal.certificateNumber}
                    </div>
                    <div class="sk-item TextAlignLeft bold">
                        <label class="sk-label">证件扫描件:</label>
                        <img src="${userAccountSeal.certificateImageUrl}" alt="cimg"/>
                    </div>
                    <div class="sk-item TextAlignLeft bold">
                        <label class="sk-label">地址:</label>${userAccountSeal.companyAddress}
                    </div>
                    <div class="sk-item TextAlignLeft bold">
                        <label class="sk-label">电话:</label>${userAccountSeal.companyPhone}
                    </div>
                    <div class="sk-item TextAlignLeft bold">
                        <label class="sk-label">传真:</label>${userAccountSeal.companyFax}
                    </div>
                    <div class="sk-item TextAlignLeft bold">
                        <label class="sk-label">补充说明:</label>
                        <c:choose>
                            <c:when test="${not empty userAccountSeal.additionNotes}">
                                ${userAccountSeal.additionNotes}
                            </c:when>
                            <c:otherwise>
                                &nbsp;
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
                <c:if test="${userAccountSeal.processStatus == 'APPROVE'}">
                    <div class="FloatLeft"><img src="/images/yanzheng.gif"/></div>
                    </c:if>
                <div class="clear"></div>
            </div>
            <c:if test="${lastAccountSeal!=null}">     
                <div style="background-color: #DEF1FE">上次认证信息</div>
                <div class="Padding30">
                    <div class="FloatLeft BlueBoxLeft"><img src="${lastAccountSeal.logoImageUrl}" alt="logo"/></div>
                    <div class="FloatLeft BlueBoxContent"> 
                        <div class="sk-item TextAlignLeft bold"> 
                            <label class="sk-label">公司团体名称:</label>${lastAccountSeal.companyName}
                        </div>
                        <div class="sk-item TextAlignLeft bold">
                            <label class="sk-label">官方网址:</label>
                            <a href="${lastAccountSeal.companyWeb}" target="_blank">${lastAccountSeal.companyWeb}</a>
                        </div>
                        <div class="sk-item TextAlignLeft bold">
                            <label class="sk-label">预计年收款额：</label>
                            <c:choose>
                                <c:when test="${lastAccountSeal.companyCollectScale=='LT50'}">
                                    小于50万
                                </c:when>
                                <c:when test="${lastAccountSeal.companyCollectScale=='GE50LT100'}">
                                    50万-200万
                                </c:when>
                                <c:when test="${lastAccountSeal.companyCollectScale=='GE200'}">
                                    大于200万
                                </c:when>
                                <c:otherwise>
                                    未填
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="sk-item TextAlignLeft bold">
                            <label class="sk-label">证件种类:</label>
                            <c:choose>
                                <c:when test="${lastAccountSeal.certificateType == 'BUSINESS_LICENCE'}">营业执照</c:when>
                                <c:when test="${lastAccountSeal.certificateType == 'ORGANIZATION_LICENCE'}">组织机构代码证</c:when>
                                <c:when test="${lastAccountSeal.certificateType == 'ARTICLE_INCORPORATION'}">Article of Incorporation</c:when>
                                <c:otherwise>其他</c:otherwise>
                            </c:choose>
                        </div>
                        <div class="sk-item TextAlignLeft bold">
                            <label class="sk-label">证件号码:</label>
                            ${lastAccountSeal.certificateNumber}
                        </div>
                        <div class="sk-item TextAlignLeft bold">
                            <label class="sk-label">证件扫描件:</label>
                            <img src="${lastAccountSeal.certificateImageUrl}" alt="cimg"/>
                        </div>
                        <div class="sk-item TextAlignLeft bold">
                            <label class="sk-label">地址:</label>${lastAccountSeal.companyAddress}
                        </div>
                        <div class="sk-item TextAlignLeft bold">
                            <label class="sk-label">电话:</label>${lastAccountSeal.companyPhone}
                        </div>
                        <div class="sk-item TextAlignLeft bold">
                            <label class="sk-label">传真:</label>${lastAccountSeal.companyFax}
                        </div>
                        <c:if test="${not empty lastAccountSeal.additionNotes}">
                            <div class="sk-item TextAlignLeft bold">
                                <label class="sk-label">补充说明:</label>
                                ${lastAccountSeal.additionNotes}
                            </div>
                        </c:if>
                    </div>

                    <c:if test="${lastAccountSeal.processStatus == 'APPROVE'}">
                        <div class="FloatLeft"><img src="/images/yanzheng.gif"/></div>
                        </c:if>
                    <div class="clear"></div>
                </div>
            </c:if>
        </c:otherwise>
    </c:choose>
</div>
<jsp:include page="/WEB-INF/support/z_footer.jsp"/>
