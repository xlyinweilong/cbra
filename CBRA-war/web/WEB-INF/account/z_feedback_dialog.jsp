
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
        
        <form id="feedback" method="post">  
            <input type="hidden" name="a" value="feedback"/>
           <%-- <table cellspacing="0" cellpadding="0" border="0" width="500">
                <tbody>
                    <tr>
                        <td>
                            <div id="main4">
                                <h2><span>主题</span><label><input type="text" name="subject" id="subject"/></label><span style="color:red" id="subject_notice"></span><div class="clear"></div></h2>		
                                <h2><span style="height:120px" align="top">内容</span><label><textarea style="border:2px solid #ccc;width:390px;height:120px;color:#505050;float:left;margin:0 5px 0 0;" name="message" id="message"></textarea></label><span style="color:red" id="message_notice"></span><div class="clear"></div></h2>		
                                
                                <h1>
                                    <label>
                                        <input type="button" name="Submit" value="提交" onclick="Feedback.sendFeedback();" class="collection_button" />
                                    </label>
                                    <span><a href="javascript:Feedback.close();">取消</a></span> 
                                    <div class="clear"></div>
                                </h1>				
                            </div>
                        </td>                        
                    </tr>
                </tbody>
            </table>--%> 
           <div class="FeedbackDialog">
               <span class="notice_box" >
            <div class="noticeMessage" id="notice"style="display:none;line-height:30px; height:30px;">
                <div id="success" style="font-size:14px; font-weight:bold;padding:0px 10px;background:#E7F6E3; color:#4FB039;display:none"></div>
                <div id="wrong" style="font-size:14px; font-weight:bold;padding:0px 10px;background:#F8E1E1; color:#BD2C2C;display:none">${postResult.singleErrorMsg}</div>
                <div id="loading" style="font-size:14px; font-weight:bold;padding:0px 10px;display:none;background:#FFF8D9; color:#A75C25;"><fmt:message key="ACCOUNT_Z_FEEDBACK_DIALOG_TEXT_请稍侯" bundle="${bundle}"/><img alt="" src="/images/032.gif"></div>
            </div>
        </span> 
             <div class="sk-item2">
                <label class="sk-label2"><fmt:message key="ACCOUNT_Z_FEEDBACK_DIALOG_TEXT_主题" bundle="${bundle}"/></label>
                <input type="text" value="" name="subject" class="Input380" id="subject"/>
             </div>
             <div class="sk-item2">
                <label class="sk-label2"><fmt:message key="ACCOUNT_Z_FEEDBACK_DIALOG_TEXT_内容" bundle="${bundle}"/></label>
                <textarea style="border:2px solid #ccc;width:364px;height:120px;color:#505050;" name="message" id="message"></textarea>
             </div>
             <div class="sk-item2"> 
                 <label class="sk-label2">&nbsp;</label> 
                 <a href="javascript:Feedback.close();"><fmt:message key="GLOBAL_取消" bundle="${bundle}"/></a>
                 <input type="button" onclick="Feedback.sendFeedback();" class="collection_button" value="<fmt:message key='ACCOUNT_SEND_RESET_PASSWD_提交' bundle='${bundle}'/>" name="Submit"/>         
                 
            </div>
           </div>
        </form>
        <div class="underlay"></div>
    </div>
  
</div>
