<%-- 
    Document   : cyanzheng
    Created on : May 23, 2011, 6:05:01 PM
    Author     : lining
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<jsp:include page="/WEB-INF/public/z_header.jsp"/>
<div class="BlueBox">
    <div class="IndexSearch">
        <form id="searchform" action="/collect/search/event/1" method="POST">
            <input id="keyword" name="keyword" type="text" class="Input410" />
        </form>
    </div>

    <script type="text/javascript">
        $(document).ready(function () {
            $('#keyword').focus();
        });
        var count = 0;
        var inputenable = true;
        $('#keyword').blur(function() {
            if (inputenable){
                setTimeout( function(){ $('#keyword')[0].focus(); }, 100 );
            }
        });
        $('#keyword').keypress(function(event) {
            if(!inputenable){
                event.preventDefault();
                return;
            }
            if(event.which >=48 && event.which<=57){
                count++; // only numbers
            }
            if(count==13){
                if (inputenable){
                    inputenable = false;
                    $('#keyword').attr("readonly", true); 
                    // search
                    var barcode = $('#keyword').val();
                    $('#inputvalue').html(barcode);
                    
                    // wait 5 senconds to eanble input.
                    setTimeout(function(){ 
                        $('#keyword').removeAttr("readonly");
                        $('#keyword').val('');
                        $('#inputvalue').html('');
                        $('#keyword')[0].focus();
                        count=0;inputenable=true
                    }, 5000 );
                }
            }
        });
    </script>
</div>
<div class="tishi"><fmt:message key="PAYMENT_API_LABEL_提示信息" bundle="${bundle}"/></div>
    
<div class="BlueBox">
        BarCode=<span id="inputvalue" ></span>
</div>
<jsp:include page="/WEB-INF/public/z_footer.jsp"/> <%@include file="/WEB-INF/public/z_footer_close.html" %> 



