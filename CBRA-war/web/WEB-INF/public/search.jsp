<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html>
    <head>
        <jsp:include page="/WEB-INF/public/z_header.jsp"/>
    </head>

    <body>
        <jsp:include page="/WEB-INF/public/z_top.jsp" />
        <jsp:include page="/WEB-INF/public/z_banner.jsp" />
        <div class="two-loc">
            <div class="two-loc-c">当前位置：<a href="index.asp">筑誉首页</a> > 搜索</div>
        </div>

        <!-- 主体 -->
        <div class="two-main">
            <!-- 左侧导航 -->
            <div class="fl-nav">
                <h1>搜　索</h1>
                <ul>
                    <li><a href="/public/search" <c:if test="${empty p}">id="fl-nav-hover"</c:if>>全　站</a></li>
                    <li><a href="/public/search?p=news" <c:if test="${p == 'news'}">id="fl-nav-hover"</c:if>>新　闻</a></li>
                    <li><a href="/public/search?p=event" <c:if test="${p == 'event'}">id="fl-nav-hover"</c:if>>活　动</a></li>
                    <li><a href="/public/search?p=train" <c:if test="${p == 'train'}">id="fl-nav-hover"</c:if>>培　训</a></li>
                    <li><a href="/public/search?p=consult" <c:if test="${p == 'consult'}">id="fl-nav-hover"</c:if>>资　讯</a></li>
                    </ul>
                </div>
                <!-- 左侧导航 end -->
                <!-- 右侧内容 -->
                <form id="form1" action="/public/search" method="post">
                    <input type="hidden" id="page_num" name="page" value="${page}" />
                <input type="hidden" name="p" value="${p}" />
                <input type="hidden" id="searchTextHidden" name="search" value="${searchText}" />
                <div class="fm-list">
                    <div class="title"><span><a href="javascript:void(0);" id="title-span">搜索结果</a></span>
                        <div class="search"><input type="text" id="search_text_2" value="${searchText}" onkeypress="mykeypressSearchPage(event);" class="sousuok"><input type="button" onclick="form1Submit();" value="搜索" class="sousuoan"></div></div>
                    <ul>
                        <c:forEach var="searchIndex" items="${resultList}">
                            <li>
                                <div class="con-1"><a href="/public/search_info?id=${searchIndex.id}&plateId=${searchIndex.plateId}">
                                        <p class="pp1">${searchIndex.title}</p>
                                        <p class="pp2">${searchIndex.introduction}</p></a>
                                    <p class="pp2"><span class="span1"></span></p>
                                </div>
                                <div style="clear:both;"></div>
                            </li>
                        </c:forEach>
                    </ul>
                    <div style="clear:both;"></div>
                    <jsp:include page="/WEB-INF/public/z_paging.jsp">
                        <jsp:param name="totalCount" value="${resultList.getTotalCount()}" />
                        <jsp:param name="maxPerPage" value="${resultList.getMaxPerPage()}" />
                        <jsp:param name="pageIndex" value="${resultList.getPageIndex()}" />
                    </jsp:include>
                </div>
            </form>
            <!-- 右侧内容 end -->
            <div style="clear:both;"></div>
        </div>
        <!-- 主体 end -->
        <jsp:include page="/WEB-INF/public/z_end.jsp"/>
    </body>
    <script type="text/javascript">
        function mykeypressSearchPage(event) {
            var e = event || window.event || arguments.callee.caller.arguments[0];
            if (e && e.keyCode == 13) {
                form1Submit();
            }
        }
        function form1Submit() {
            $("#searchTextHidden").val($('#search_text_2').val());
            $("#form1").submit();
        }
    </script>
</html>

