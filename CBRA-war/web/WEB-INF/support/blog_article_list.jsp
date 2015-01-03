<%-- 
    Document   : blog_article_list
    Created on : Nov 30, 2012, 2:26:37 PM
    Author     : wangshuai
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
    request.setAttribute("mainMenuSelection", "BLOG_ARTICLE_LIST");
    request.setAttribute("subMenuSelection", "");
%>

<%@include file="/WEB-INF/support/z_header.jsp"%>

<script type="text/javascript">
    function editArticle(aId) {
        redirect("/support/blog_article_post/" + aId);
    }
    
    function deleteArticle(aId) {
        if(confirm("Are you sure delete the article?")) {
            $.getJSON('/support/blog_article_list', 
            { a: "DELETE_BLOG_ARTICLE",aId: aId },
            function(json) {
                if(json.success) {
                    $("#msgDiv").text("SUCCESS!");
                    setTimeout(function(){document.location.href = "/support/blog_article_list"},1000);
                } else {
                    alert(json.message)
                }
            });
        }
    }
</script>
<div class="support-content">
    <div id="msgDiv">
        <c:if test="${!empty postResult.singleErrorMsg}"> 
            ${postResult.singleErrorMsg}
        </c:if> 
        <c:if test="${postResult.success}"> 
            ${postResult.singleSuccessMsg}
        </c:if> 
    </div>
    <div style="margin-top: 10px;margin-bottom: 10px;text-align: right"><a href="/support/blog_article_post">Post New Article</a></div>
    <c:choose>
        <c:when test="${not empty articleList}">  
            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="history_table">
                <tr>
                    <td>时间</td>
                    <td style="width:40px">排序ID</td>
                    <td style="width:40px">作者</td>
                    <td style="width:100px">标题</td>
                    <td style="width:30px">显示</td>
                    <td>内容</td>
                    <td style="width:120px">操作</td>
                </tr>                        
                <c:forEach var="article" items="${articleList}" varStatus="status">
                    <tr <c:if test="${status.count%2!=0}">style="background-color: #DBDBDB"</c:if>>
                        <td><fmt:formatDate value='${article.createDate}'type='date' pattern='yyyy.MM.dd'/></td>
                        <td>${article.listOrder}</td>
                        <td>${article.account.name}</td>
                        <td>${article.title}</td>
                        <td>
                            <c:choose>
                                <c:when test="${article.visible}">是</c:when>
                                <c:otherwise>否</c:otherwise>
                            </c:choose>
                        </td>
                        <td>${article.content}</td>
                        <td>
                            <input type="button" value="Edit" onclick="editArticle(${article.id})"/>
                            <input type="button" value="Delete" onclick="deleteArticle(${article.id})"/></td>
                    </tr>
                </c:forEach>
                </body>
            </table>
            <div class="vPagging">
                <jsp:include page="/WEB-INF/support/z_paging.jsp">
                    <jsp:param name="totalCount" value="${articleList.getTotalCount()}" />
                    <jsp:param name="maxPerPage" value="${articleList.getMaxPerPage()}" />
                    <jsp:param name="pageIndex" value="${articleList.getPageIndex()}" />
                </jsp:include>
            </div>
        </c:when>
        <c:otherwise>
            <h3 class="nolist">列表为空</h3>
        </c:otherwise>
    </c:choose>
</div>
<jsp:include page="/WEB-INF/support/z_footer.jsp"/>

