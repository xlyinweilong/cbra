<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="fl-nav">
    <h1>专题培训</h1>
    <ul>
        <li><a href="/train/idea_train" <c:if test="${param.page == '1'}">id="fl-nav-hover"</c:if>>培训理念</a></li>
        <li><a href="/train/near_future_train" <c:if test="${param.page == '2'}">id="fl-nav-hover"</c:if>>近期培训</a></li>
        <li><a href="/train/period_train" <c:if test="${param.page == '3'}">id="fl-nav-hover"</c:if>>往期培训</a></li>
        <li><a href="/train/lecturers" <c:if test="${param.page == '4'}">id="fl-nav-hover"</c:if>>讲师团队</a></li>
    </ul>
</div>