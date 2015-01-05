<%-- 
    Document   : 分页
    Created on : Apr 18, 2011, 2:39:20 PM
    Author     : yin.weilong
--%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    int totalCount = Integer.valueOf(request.getParameter("totalCount"));
    int maxPerPage = Integer.valueOf(request.getParameter("maxPerPage"));
    int pageIndex = Integer.valueOf(request.getParameter("pageIndex"));
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
%>
<div class="pagin">
    <div class="paginList">
        <span class="page">
            共[ 3 ]条记录    
            <a onclick="turnOverPage(<%=first%>)">首　页</a>&nbsp;
            <a onclick="turnOverPage(<%=first%>)">上一页</a>&nbsp;
            <a onclick="turnOverPage(<%=previous%>)">下一页</a>&nbsp;
            <a onclick="turnOverPage(<%=last%>)">尾　页</a>&nbsp;
            <input id="gopage" type="text" maxlength="8" autoComplete="off" value="1" style="width:40px;height:18px;ime-mode:disabled;border:1px #CECABC solid;">
            <input type="button" onclick="gomypage();" value="跳 转" style="width:50px;height:20px;box-shadow: 1 #CECABC solid;">
            当前[<%=pageIndex%>/<%=totalPageCount%>]页
            <input id="currentPage" type="hidden" value="1" name="pagination.currentPage">
            <script language="javascript">
                $(document).ready(function () {
                    $("#gopage").keyup(function () {
                        var tmptxt = $(this).val();
                        $(this).val(tmptxt.replace(/\D|^0/g, ''));
                    }).bind("paste", function () {
                        var tmptxt = $(this).val();
                        $(this).val(tmptxt.replace(/\D|^0/g, ''));
                    }).css("ime-mode", "disabled");
                });
                function myonkeypress(event) {
                    var reg = /^\d+$/;
                    if (value.constructor === String) {
                        var re = value.match(reg);
                        return true;
                    }
                    return false;
                }
                function turnOverPage(no) {
                    if (no > 1) {
                        no = 1;
                    }
                    if (no < 1) {
                        no = 1;
                    }
                    document.forms[0].target = '';
                    document.getElementById("currentPage").value = no;
                    document.forms[0].submit();
                }
                function gomypage() {
                    var g = document.getElementById("gopage").value;
                    if (g != null && g != "") {
                        turnOverPage(g);
                    }
                }
            </script>
        </span>
    </div>
</div>
