
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%-- 
    Document   : z_login_dialog
    Created on : Apr 20, 2011, 7:01:20 PM
    Author     : HUXIAOFENG
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div>
    <div title="ajaxReturn" style="display:none">${postResult.success}</div>
    <div class="yui-panel-container yui-dialog shadow" id="hzLoginSignupDialog_c" style="visibility: visible; left: 260px; top: 121px; z-index: 2;margin:0 auto; ">

        <form id="edit_attendee_form" method="post">  
            <input type="hidden" name="a" value="edit_attendee"/>
            <input type="hidden" name="ticketId" value="${ticket.id}"/>
            <input type="hidden" name="personalInfoId" value="${personalInfo.id}"/>

            <div class="FeedbackDialog">
                <c:choose >
                    <c:when test="${doEditTicketAttendee}">                                                            
                        <span class="notice_box" >
                            <div class="noticeMessage" id="notice" style="line-height:30px; height:30px;">
                                <c:choose >
                                    <c:when test="${postResult.success}">
                                        <div id="success" style="font-size:14px; font-weight:bold;padding:0px 10px;background:#E7F6E3; color:#4FB039;"><fmt:message key='ACCOUNT_REGINFO_MSG_修改成功' bundle='${bundle}'/></div>
                                    </c:when>     
                                    <c:otherwise>
                                        <div id="wrong" style="font-size:14px; font-weight:bold;padding:0px 10px;background:#F8E1E1; color:#BD2C2C;">${postResult.singleErrorMsg}</div>
                                    </c:otherwise>
                                </c:choose>
                                <div class="sk-item2"> 
                                    <label class="sk-label2">&nbsp;</label> 
                                    <input type="button" onclick="attendeeEditDialog.close();return false;" class="collection_button" value="<fmt:message key='GLOBAL_关闭' bundle='${bundle}'/>" name="Close"/>
                                </div>
                            </div>
                        </span> 
                    </c:when>
                    <c:otherwise>
                        <div class="sk-item2">
                            <label class="sk-label2"><fmt:message key="COLLECT_DETAIL_LABEL_姓名" bundle="${bundle}"/></label>
                            <input type="text" value="${personalInfo.name}" name="name" class="Input380" id="subject"/>
                        </div>
                        <div class="sk-item2">
                            <label class="sk-label2"><fmt:message key="COLLECT_DETAIL_LABEL_公司" bundle="${bundle}"/></label>
                            <input type="text" value="${personalInfo.company}" name="company" class="Input380" id="subject"/>
                        </div>
                        <div class="sk-item2">
                            <label class="sk-label2"><fmt:message key="COLLECT_DETAIL_LABEL_职务" bundle="${bundle}"/></label>
                            <input type="text" value="${personalInfo.position}" name="position" class="Input380" id="subject"/>
                        </div>
                        <div class="sk-item2">
                            <label class="sk-label2"><fmt:message key="COLLECT_DETAIL_LABEL_手机" bundle="${bundle}"/></label>
                            <input type="text" value="${personalInfo.mobilePhone}" name="mobilePhone" class="Input380" id="subject"/>
                        </div>
                        <div class="sk-item2">
                            <label class="sk-label2"><fmt:message key="COLLECT_DETAIL_LABEL_邮箱" bundle="${bundle}"/></label>
                            <input type="text" value="${personalInfo.email}" name="email" class="Input380" id="subject"/>
                        </div>
                        <div class="sk-item2"> 
                            <label class="sk-label2">&nbsp;</label> 
                            <a href="javascript:attendeeEditDialog.close();"><fmt:message key="GLOBAL_取消" bundle="${bundle}"/></a>
                            <input type="button" onclick="attendeeEditDialog.submit();" class="collection_button" value="<fmt:message key='ACCOUNT_SEND_RESET_PASSWD_提交' bundle='${bundle}'/>" name="Submit"/>         

                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </form>
        <div class="underlay"></div>
    </div>

</div>
