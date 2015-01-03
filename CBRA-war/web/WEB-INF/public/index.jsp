<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%-- 
    Document   : index
    Created on : Mar 29, 2011, 10:49:28 AM
    Author     : HUXIAOFENG
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/public/z_header.jsp"/>
<div class="IndexTop">
    <div class="IndexLeftTop FloatLeft" id="super">
        <img  border="0" src="/images/index/index_img_1.png" id="index_show_img"> 
        <div class="<fmt:message key='INDEX_TEXT' bundle='${bundle}'/>" id="index_show_img_text"><div id="index_show_img_head"></div><p id="index_show_img_content"></p></div>
        <ul class="slidenav" id="slidenav">
            <%--
            <li class="active"><img width="108" height="60" border="0" src="/images/index/index_img_1.png"></li>
            <li><img width="108" height="60" border="0" src="/images/index/index_img_2.png"></li>
            <li><img width="108" height="60" border="0" src="/images/index/index_img_3.png"></li> 
            <li><img width="108" height="60" border="0" src="/images/index/index_img_4.png"></li>
            <li><img width="108" height="60" border="0" src="/images/index/index_img_5.png"></li>
            --%>
        </ul>
    </div>
    <div class="IndexRightTop">
        <fmt:message key='INDEX_TEXT_做活动' bundle='${bundle}'/>
        <fmt:message key='INDEX_TEXT_发布' bundle='${bundle}'/>
        <div <fmt:message key='INDEX_TEXT_按钮' bundle='${bundle}'/>><span><a href="/account/signup_select"><img src="<fmt:message key='PUBLIC_INDEX_IMG_BUTTON' bundle='${bundle}'/>" width="222" height="49" alt="我要组织活动" /></a></span><span><fmt:message key='INDEX_TEXT_免费' bundle='${bundle}'/></span></div>
    </div>
    <div class="clear"></div>
</div>
<div class="IndexSearchTop">
    <p><fmt:message key='INDEX_TEXT_20,000多个活动' bundle='${bundle}'/></p>
<img src="../images/index/index_logo_wangyi.jpg" border="0" />
<img src="../images/index/index_logo_caixin.jpg" border="0" />
<img src="../images/index/index_logo_changjiang.jpg" border="0" />
<img src="../images/index/index_logo_mac.jpg" border="0" />
<img src="../images/index/index_logo_yale.jpg" border="0" />
<img src="../images/index/index_logo_36ke.jpg" border="0" />
</div>


<div class="IndexSearch">
    <form action="/collect/search/event/1" method="POST">
        <input name="keyword" type="text" class="Input410"/><input type="submit"  value="<fmt:message key='GLOBAL_搜索' bundle='${bundle}'/>" class="Input56"/>
    </form>
</div>

<div class="IndexEventList">
    <dl class="FloatLeft"><dt><fmt:message key='INDEX_TEXT_活动发布' bundle='${bundle}'/></dt><dd><fmt:message key='INDEX_TEXT_5分钟即可生成' bundle='${bundle}'/></dd></dl>  
    <dl class="FloatRight"><dd><img src="../images/index/img_1.jpg" /></dd></dl>
    <div class="clear"></div>
</div>
<div class="IndexEventList IndexEventListbg">
    <dl class="FloatLeft"><dd><img src="../images/index/img_2.jpg" ></dd></dl>  
    <dl class="FloatRight">
        <dt><fmt:message key='INDEX_TEXT_报名注册' bundle='${bundle}'/></dt><dd><fmt:message key='INDEX_TEXT_根据需求' bundle='${bundle}'/></dd>                
    </dl>
    <div class="clear"></div>
</div>
<div class="IndexEventList">
    <dl class="FloatLeft"><dt><fmt:message key='INDEX_TEXT_电子票务' bundle='${bundle}'/></dt><dd><fmt:message key='INDEX_TEXT_线上报名' bundle='${bundle}'/></dd></dl>  
    <dl class="FloatRight"><dd><img src="../images/index/img_3.png" /></dd>
    </dl>
    <div class="clear"></div>
</div>

<div class="IndexEventList IndexEventListbg">
    <dl class="FloatLeft"><dd><img src="../images/index/img_4.jpg" ></dd></dl>  
    <dl class="FloatRight">
        <dt><fmt:message key='INDEX_TEXT_推广营销' bundle='${bundle}'/></dt><dd><fmt:message key='INDEX_TEXT_一键式分享' bundle='${bundle}'/></dd>                
    </dl>
    <div class="clear"></div>
</div>
<div class="IndexEventList">
    <dl class="FloatLeft"><dt><fmt:message key='INDEX_TEXT_现场签到' bundle='${bundle}'/></dt><dd><fmt:message key='INDEX_TEXT_现场签到机' bundle='${bundle}'/></dd></dl>  
    <dl class="FloatRight"><dd><img src="../images/index/img_5.jpg" /></dd>
    </dl>
    <div class="clear"></div>
</div>
<div class="IndexEventList" style=" background:none">
    <dl class="FloatLeft"><dd><a href="/account/signup_select"><fmt:message key='INDEX_TEXT_BUTTON_我要组织活动' bundle='${bundle}'/></a></dd></dl>  
    <dl class="FloatRight">
        <dt><fmt:message key='INDEX_TEXT_20,000' bundle='${bundle}'/></dt><dd><fmt:message key='INDEX_TEXT_提高组织效率' bundle='${bundle}'/></dd>                
    </dl>
    <div class="clear"></div>
</div>

<%--
<c:choose>
<c:when test="${not empty eventSelectedList}">
<c:forEach var="eventSelected" items="${eventSelectedList}" varStatus="status">
<c:choose>
   <c:when test="${status.count%2!=0}">
       <div class="IndexEventList <c:if test="${status.count==7}">BorderNone</c:if>">
           <dl class="FloatLeft">
               <dt>
               <p><fmt:formatDate value="${eventSelected.eventStartDate}" type="date" pattern="${eventMonthDayParseStyle}"/></p>
               <p class="IndexEventColor"><fmt:formatDate value="${eventSelected.eventStartDate}" type="date" pattern="E"/></p>
               </dt>
               <dd class="Title"><a target="_blank" href="${eventSelected.eventUrl}">${eventSelected.eventTitle}</a></dd>
               <dd>${eventSelected.eventDateDesc}</dd>
               <dd>${eventSelected.eventLocation}</dd>
           </dl>
   </c:when>  
   <c:otherwise>
       <dl class="FloatRight">
           <dt><p><fmt:formatDate value="${eventSelected.eventStartDate}" type="date" pattern="${eventMonthDayParseStyle}"/></p>
           <p class="IndexEventColor"><fmt:formatDate value="${eventSelected.eventStartDate}" type="date" pattern="E"/></p>
           </dt>
           <dd class="Title"><a target="_blank" href="${eventSelected.eventUrl}">${eventSelected.eventTitle}</a></dd>
           <dd>${eventSelected.eventDateDesc}</dd>
           <dd>${eventSelected.eventLocation}</dd>
       </dl>
       <div class="clear"></div>
       </div>
   </c:otherwise>
</c:choose>
</c:forEach>
</c:when>
<c:otherwise>
<div class="IndexEventList">
<dl class="FloatLeft"><dt><p><fmt:message key="PULIC_INDEX_TEXT_活动时间左1" bundle="${bundle}"/></p><p class="IndexEventColor"><fmt:message key="PULIC_INDEX_TEXT_活动星期左1" bundle="${bundle}"/></p></dt><dd class="Title"><a target="_blank" href="https://yoopay.cn/event/macworldasia-2012"><fmt:message key="PULIC_INDEX_TEXT_活动标题1" bundle="${bundle}"/></a></dd><dd><fmt:message key="PULIC_INDEX_TEXT_时间" bundle="${bundle}"/><fmt:message key="PULIC_INDEX_TEXT_活动时间1" bundle="${bundle}"/></dd><dd><fmt:message key="PULIC_INDEX_TEXT_地点" bundle="${bundle}"/><fmt:message key="PULIC_INDEX_TEXT_活动地点1" bundle="${bundle}"/></dd></dl>  
<dl class="FloatRight"><dt><p><fmt:message key="PULIC_INDEX_TEXT_活动时间左2" bundle="${bundle}"/></p><p class="IndexEventColor"><fmt:message key="PULIC_INDEX_TEXT_活动星期左2" bundle="${bundle}"/></p></dt><dd class="Title"><a target="_blank" href="https://yoopay.cn/event/KempinskiCareerDay"><fmt:message key="PULIC_INDEX_TEXT_活动标题2" bundle="${bundle}"/></a></dd><dd><fmt:message key="PULIC_INDEX_TEXT_时间" bundle="${bundle}"/><fmt:message key="PULIC_INDEX_TEXT_活动时间2" bundle="${bundle}"/></dd><dd><fmt:message key="PULIC_INDEX_TEXT_地点" bundle="${bundle}"/><fmt:message key="PULIC_INDEX_TEXT_活动地点2" bundle="${bundle}"/></dd></dl>
<div class="clear"></div>
</div>
<div class="IndexEventList">
<dl class="FloatLeft"><dt><p>5月12日</p><p class="IndexEventColor">周六</p></dt><dd class="Title"><a target="_blank" href="https://yoopay.cn/EVENT/alumniball2012beijing">2012 Alumni Ball of Beijing</a></dd><dd>时间：2012年5月12日</dd><dd>地点：北京希尔顿酒店,东三环北路东方路1号</dd></dl>  
<dl class="FloatRight"><dt><p>7月7日</p><p class="IndexEventColor">周六</p></dt><dd class="Title"><a target="_blank" href="https://yoopay.cn/EVENT/92003460">《30岁前别结婚》陈愉分享会</a></dd><dd>时间：2012年7月7日</dd><dd>地点：北京南河沿大街111号欧美同学会报告厅</dd></dl>
<div class="clear"></div>
</div>

        <div class="IndexEventList BorderNone">
            <dl class="FloatLeft"><dt><p>5月18日</p><p class="IndexEventColor">周五</p></dt><dd class="Title"><a target="_blank" href="https://yoopay.cn/EVENT/Haiku-Jinqiao-Opening-Party">Haiku @ Jinqiao Opening Party!</a></dd><dd>时间：2012年5月18日</dd><dd>地点：601 Lantian Lu across from Megafit, Jinqiao </dd></dl>  
            <dl class="FloatRight"><dt><p>12月17日</p><p class="IndexEventColor">周六</p></dt><dd class="Title"><a target="_blank" href="https://yoopay.cn/event/20111217">野蛮成长VS理性成长 - AAMA亚杰商会2011年会</a></dd><dd>时间：2011年12月17日</dd><dd>地点：柏悦酒店（地址：建国门外大街2号，电话：010-85671234）</dd></dl>
            <div class="clear"></div>
        </div>
    </c:otherwise>
</c:choose> --%>

<div class="color1 MarginTop20" style=" margin-bottom: -23px;">
    <b class="b1"></b><b class="b2"></b><b class="b3"></b><b class="b4"></b> 
    <div class="divcontent1" style="height:45px;">  <img src="/images/index/card_bank.png" width="367" height="42" /></div>
    <b class="b5"></b><b class="b6"></b><b class="b7"></b><b class="b8"></b>    
</div>


<jsp:include page="/WEB-INF/public/z_footer.jsp"/>
<script type="text/javascript">  
    $(document).ready(function(){
        IndexImgs.init();
    });
</script>
<%@include file="/WEB-INF/public/z_weibo_follow.jsp" %>
<%@include file="/WEB-INF/public/z_footer_close.html" %> 