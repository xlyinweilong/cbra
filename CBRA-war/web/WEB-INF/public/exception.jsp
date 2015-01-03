<%-- 
    Document   : exception
    Created on : Apr 1, 2011, 7:14:31 PM
    Author     : HUXIAOFENG
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/public/z_header.jsp"/>

<h1>出异常啦! <span class="btnGreen btnGreen-ok" onmouseover="this.className='btnGreen btnGreen-ok-hover';" onmouseout="this.className='btnGreen btnGreen-ok';"><input type="reset"  value="报告这个错误"/></span></h1>
<br/><br/>
<h2>名称: ${exceptionMessage}</h2>
<br/>
<h2>详细内容:</h2>
<div>
    <textarea name="" rows="20" cols="100">${exceptionStackTrace}
    </textarea>
    
</div>


<jsp:include page="/WEB-INF/public/z_footer.jsp"/> <%@include file="/WEB-INF/public/z_footer_close.html" %> 
