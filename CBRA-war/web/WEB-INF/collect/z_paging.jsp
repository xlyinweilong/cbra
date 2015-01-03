<%@page import="cn.yoopay.support.Tools"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%-- 
    Document   : z_paging
    Created on : Apr 18, 2011, 2:39:20 PM
    Author     : HUXIAOFENG
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<script>
    var Paging = {
        pagination: function(page){
            $("#page_num").val(page);
            $("#form").submit();
        },
        paginationById : function(page, formId, pageNumFieldId) {
            $('#'+pageNumFieldId).val(page);
            $('#'+formId).submit();
        }
    }
</script>
<%
    int totalCount = Integer.valueOf(request.getParameter("totalCount"));
    int maxPerPage = Integer.valueOf(request.getParameter("maxPerPage"));
    int pageIndex = Integer.valueOf(request.getParameter("pageIndex"));
    String formId = request.getParameter("formId");
    String pageId = request.getParameter("pageId");

    int totalPageCount = (int) Math.ceil((double) totalCount / (double) maxPerPage);

    int first = 1;
    int last = totalPageCount;

    int previous = 1;
    if (pageIndex > 1) {
        previous = pageIndex - 1;
    }

    int next = totalPageCount;
    if (pageIndex < totalPageCount) {
        next = pageIndex + 1;
    }

//TODO... PAGE NUMBER AND LINK
    int maxLink = 5;
    TreeSet set = new TreeSet();
    for (int i = 0; i < maxLink; i++) {
        if (pageIndex + i > 0 && pageIndex + i <= totalPageCount && set.size() < maxLink) {
            set.add(pageIndex + i);
        }
        if (pageIndex - i > 0 && pageIndex - i <= totalPageCount && set.size() < maxLink) {
            set.add(pageIndex - i);
        }
    }

    if (totalPageCount > 0) {

%>

<a style="cursor:pointer" onclick="Paging.paginationById('<%=first%>','<%=formId%>','<%=pageId%>')"><fmt:message key='GLOBAL_PAGING_FIRST' bundle='${bundle}'/></a>
<a style="cursor:pointer" onclick="Paging.paginationById('<%=previous%>','<%=formId%>','<%=pageId%>')"><fmt:message key='GLOBAL_PAGING_BACK' bundle='${bundle}'/></a>
<%
    Iterator it = set.iterator();
    for (; it.hasNext();) {
        int p = ((Integer) it.next()).intValue();
%>
<a style="cursor:pointer" onclick="Paging.paginationById('<%=p%>','<%=formId%>','<%=pageId%>')" <%if (p == pageIndex) {%>class="curp"<%}%> ><%=p%></a>
<%
    }
%>
<a style="cursor:pointer" onclick="Paging.paginationById('<%=next%>','<%=formId%>','<%=pageId%>')"><fmt:message key='GLOBAL_PAGING_NEXT' bundle='${bundle}'/></a>
<a style="cursor:pointer" onclick="Paging.paginationById('<%=last%>','<%=formId%>','<%=pageId%>')"><fmt:message key='GLOBAL_PAGING_LAST' bundle='${bundle}'/></a>
<%
    }
%>
<% if (totalPageCount > 0) {%><span class="stylevPagging"><fmt:message key="GLOBAL_PAGING_TOTAL" bundle="${bundle}"><fmt:param value="<%=totalPageCount%>"/></fmt:message><% }%>