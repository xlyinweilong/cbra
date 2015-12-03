<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!-- 底部 -->
<div class="Bottom-nav">
    <div class="Bottom-nav-c">
        <ul>
            <li class="fl-Line"><h4><fmt:message key="INDEX_走进筑誉" bundle="${bundle}"/></h4><a href="/into/idea"><fmt:message key="INDEX_筑誉理念" bundle="${bundle}"/></a><br><a href="/into/pattern"><fmt:message key="INDEX_业务格局" bundle="${bundle}"/></a><br><a href="/into/course"><fmt:message key="INDEX_发展历程" bundle="${bundle}"/></a><br><a href="/into/speech"><fmt:message key="INDEX_会长致辞" bundle="${bundle}"/></a><br><a href="/into/declaration"><fmt:message key="INDEX_理事宣言" bundle="${bundle}"/></a><br><a href="/into/contact_us"><fmt:message key="INDEX_联系我们" bundle="${bundle}"/></a></li>
            <li><h4><fmt:message key="INDEX_新闻中心" bundle="${bundle}"/></h4><a href="/news/news_list"><fmt:message key="INDEX_筑誉新闻" bundle="${bundle}"/></a><br><a href="/news/industry_list"><fmt:message key="INDEX_行业新闻" bundle="${bundle}"/></a></li>
            <li><h4><fmt:message key="INDEX_活动讲座" bundle="${bundle}"/></h4><a href="/event/near_future"><fmt:message key="INDEX_近期活动" bundle="${bundle}"/></a><br><a href="/event/period"><fmt:message key="INDEX_往期活动" bundle="${bundle}"/></a><br><a href="/event/partners"><fmt:message key="INDEX_合作伙伴活动" bundle="${bundle}"/></a></li>
            <li><h4><fmt:message key="INDEX_专题培训" bundle="${bundle}"/></h4><a href="/train/idea_train"><fmt:message key="INDEX_培训理念" bundle="${bundle}"/></a><br><a href="/train/near_future_train"><fmt:message key="INDEX_近期培训" bundle="${bundle}"/></a><a href="/train/period_train"><fmt:message key="INDEX_往期培训" bundle="${bundle}"/></a><br><a href="/team/expert"><fmt:message key="INDEX_讲师团队" bundle="${bundle}"/></a></li>
            <li><h4><fmt:message key="INDEX_资讯专区" bundle="${bundle}"/></h4><a href="/into/three_party_offer"><fmt:message key="INDEX_人力资源信息" bundle="${bundle}"/></a><br><a href="/into/purchase"><fmt:message key="INDEX_资源信息" bundle="${bundle}"/></a><br><a href="/into/material"><fmt:message key="INDEX_前沿领域信息" bundle="${bundle}"/></a></li>
            <li><h4><fmt:message key="INDEX_加入筑誉" bundle="${bundle}"/></h4><a href="/join/membership_application"><fmt:message key="INDEX_会员申请" bundle="${bundle}"/></a><br><a href="/join/quarters"><fmt:message key="INDEX_筑誉岗位" bundle="${bundle}"/></a><br><a href="/join/recruit"><fmt:message key="INDEX_专家招募" bundle="${bundle}"/></a><br><a href="/join/cooperation"><fmt:message key="INDEX_合作伙伴招募" bundle="${bundle}"/></a></li>
        </ul>
        <div style=" clear:both;"></div>
    </div>
    <div class="Bottom-bq">
        <div class="Bottom-bq-c">
            <div class="fl">China Builder Ratings Association 筑誉建筑联合会<br>Suite 2108, 205 Maoming South Road, Ruijin Mansion,
                Huangpu District, Shanghai, 200020, P.R. China<br/>上海市黄浦区茂名南路205号瑞金大厦2108室</br>www.cbra.com wechat:cbra_cbra &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Cell:+86 177 01601027 Tel/Direct:(0086)-021-6155 6066</div>
            <div class="fr">沪ICP备14043363号-1</div>
            <div style=" clear:both;"></div>
        </div>
    </div>
</div>
<input type="hidden" value="${page}"  id="searchPage" />
<script type="text/javascript">
    function search(st) {
        var searchPage = $.trim($("#searchPage").val());
        if (searchPage != null) {
            location.href = "/public/search?page=" + searchPage + "&search=" + st;
        } else {
            location.href = "/public/search?search=" + st;
        }
    }
</script>
<!-- 底部 end -->