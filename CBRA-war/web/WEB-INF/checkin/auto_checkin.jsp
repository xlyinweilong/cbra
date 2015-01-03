<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="cn.yoopay.web.support.PostResult"%>
<%-- 
    Document   : auto_checkin
    Created on : Nov 14, 2012, 11:12:01 AM
    Author     : Yin.Weilong
--%>
<%
    request.setAttribute("mainMenuSelection", "AUTO_CHECKIN");
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/checkin/z_header.jsp"/>
<div <%--class="auto_checkin_title"--%> id="checkin_form_div">
    <span style="font-size:30px;font-weight:bold;margin-left:325px">已签到：<span id="checked_ticket_account">${checkedTicketAccount}</span>&nbsp;&nbsp;&nbsp;&nbsp;总票量：${ticketAccount}</span>
    <input style="float:right" type="text" id="checkin_text" autocomplete="off" />
    <div id="checkin_loading" style="display:none;text-align:center"><fmt:message key="GLOBAL_MSG_LOADING" bundle="${bundle}"/> <img src="/images/032.gif" width="100" height="9" /> </div>
    <input type="hidden" value="${fundCollection.webId}" name="webId" id="checkin_webId" />
</div>
<script type="text/javascript">
    $(document).ready(function() {
        $('#checkin_text').focus();
    });
    var count = 0;
    var inputenable = true;
    $('#checkin_text').blur(function() {
        if (inputenable){
            setTimeout( function(){ $('#checkin_text')[0].focus(); }, 100 );
        }
    });
    $('#checkin_text').keypress(function(event) {
        if(!inputenable){
            event.preventDefault();
            return;
        }
        if(event.which >=48 && event.which<=57){
            count++; // only numbers
        }
        if(count==12){
            if (inputenable){
                $('#checkin_result').html("");
                $('#checkin_loading').css("display", "");
                inputenable = false;
                $('#checkin_text').attr("readonly", true); 
                // search
                var barcode = $('#checkin_text').val() + (event.which - 48);
                $('#checkin_text').val(barcode);
                //post ajax
                var webId = $('#checkin_webId').val();
                var url = "/checkin/checkin_result/"+webId;
                var data = {
                    barcode : barcode,
                    checkin : 'true',
                    webId : webId
                };
                $("#checkin_result").load(url,data, function(response,status,xhr){
                    if(status == 'error'){
                        redirect(xhr.statusText);
                    }
                    $('#checkin_loading').css("display", "none");
                    if($('#checkin_result_flag').val() == 'success'){
                        $('#checked_ticket_account').html($('#update_checked_ticket_account').val());
                    }
                });
                // wait 5 senconds to eanble input.
                setTimeout(function(){ 
                    $('#checkin_text').removeAttr("readonly");
                    $('#checkin_text').val('');
                    $('#inputvalue').html('');
                    $('#checkin_text')[0].focus();
                    count=0;inputenable=true
                }, 5000 );
            }
        }
    });
</script>
<div id="checkin_result">
    <div id="Ready">
        <div class="header"><img src="/images/checkin/ready.jpg" />请扫描门票<br/><span></span></div>
    </div> 
</div>
<jsp:include page="/WEB-INF/checkin/z_footer.jsp"/>
