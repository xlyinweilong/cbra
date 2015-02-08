<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="two-loc">
    <c:if test="${param.page == '0'}"> <div class="two-loc-c">当前位置：<a href="/public/index">筑誉首页</a> > 资讯专区</div></c:if>
    <c:if test="${param.page == '1'}"><div class="two-loc-c">当前位置：<a href="/public/index">筑誉首页</a> > 走进筑誉 > 筑誉理念</div></c:if>
    <c:if test="${param.page == '2'}"><div class="two-loc-c">当前位置：<a href="/public/index">筑誉首页</a> > 走进筑誉 > 业务格局</div></c:if>
    <c:if test="${param.page == '3'}"><div class="two-loc-c">当前位置：<a href="/public/index">筑誉首页</a> > 走进筑誉 > 发展历程</div></c:if>
    <c:if test="${param.page == '4'}"><div class="two-loc-c">当前位置：<a href="/public/index">筑誉首页</a> > 走进筑誉 > 会长致辞</div></c:if>
    <c:if test="${param.page == '5'}"><div class="two-loc-c">当前位置：<a href="/public/index">筑誉首页</a> > 走进筑誉 > 理事宣言</div></c:if>
    <c:if test="${param.page == '6'}"><div class="two-loc-c">当前位置：<a href="/public/index">筑誉首页</a> > 走进筑誉 > 联系我们</div></c:if>
    <c:if test="${param.page == '7'}"><div class="two-loc-c">当前位置：<a href="/public/index">筑誉首页</a> > 资讯专区 > 企业人才需求</div></c:if>
    <c:if test="${param.page == '8'}"><div class="two-loc-c">当前位置：<a href="/public/index">筑誉首页</a> > 资讯专区 > 筑誉人才库</div></c:if>
    <c:if test="${param.page == '9'}"><div class="two-loc-c">当前位置：<a href="/public/index">筑誉首页</a> > 资讯专区 > 采购供求信息</div></c:if>
    <c:if test="${param.page == '10'}"><div class="two-loc-c">当前位置：<a href="/public/index">筑誉首页</a> > 资讯专区 > 海外工程合作</div></c:if>
    <c:if test="${param.page == '11'}"><div class="two-loc-c">当前位置：<a href="/public/index">筑誉首页</a> > 资讯专区 > 建筑产业化合作</div></c:if>
    <c:if test="${param.page == '12'}"><div class="two-loc-c">当前位置：<a href="/public/index">筑誉首页</a> > 资讯专区 > 养老地产合作</div></c:if>
    <c:if test="${param.page == '13'}"><div class="two-loc-c">当前位置：<a href="/public/index">筑誉首页</a> > 资讯专区 > 新材料新技术</div></c:if>
    <c:if test="${param.page == '14'}"><div class="two-loc-c">当前位置：<a href="/public/index">筑誉首页</a> > 资讯专区 > 建筑产业化</div></c:if>
    <c:if test="${param.page == '15'}"><div class="two-loc-c">当前位置：<a href="/public/index">筑誉首页</a> > 资讯专区 > 绿色建筑</div></c:if>
    <c:if test="${param.page == '16'}"><div class="two-loc-c">当前位置：<a href="/public/index">筑誉首页</a> > 资讯专区 > BIM技术</div></c:if>
</div>