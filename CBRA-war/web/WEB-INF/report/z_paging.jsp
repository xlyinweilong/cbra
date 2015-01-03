<%-- 
    Document   : slide_paging
    Created on : Dec 19, 2008, 4:10:07 PM
    Author     : Neo Hu
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>

<script>
    var Paging = {
        pagination: function(page){
            $("#page_num").val(page);
            $("#search_form").submit();
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
    String baseUrl = request.getParameter("baseUrl") + "?"; //TODO...

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

<a style="cursor:pointer" onclick="Paging.pagination('<%=first%>')">首页</a>
<a style="cursor:pointer" onclick="Paging.pagination('<%=previous%>')">前页</a>
<%
    Iterator it = set.iterator();
    for (; it.hasNext();) {
        int p = ((Integer) it.next()).intValue();
%>
<a style="cursor:pointer" onclick="Paging.pagination('<%=p%>')" <%if (p == pageIndex) {%>class="curp"<%}%> ><%=p%></a>
<%
    }
%>
<a style="cursor:pointer" onclick="Paging.pagination('<%=next%>')">后页</a>
<a style="cursor:pointer" onclick="Paging.pagination('<%=last%>')"> 末页</a>
<%
    }
%>
<% if (totalPageCount > 0) {%><span class="stylevPagging">共<%=totalPageCount%>页</span><% }%>
