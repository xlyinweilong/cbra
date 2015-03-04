<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!-- 底部 -->
<div class="Bottom-nav">
    <div class="Bottom-nav-c">
        <ul>
            <li class="fl-Line"><h4>走进筑誉</h4><a href="#">筑誉理念</a><br><a href="#">业务格局</a><br><a href="#">发展历程</a><br><a href="#">会长致辞</a><br><a href="#">理事宣言</a><br><a href="#">联系我们</a></li>
            <li><h4>新闻中心</h4><a href="#">筑誉新闻</a><br><a href="#">行业新闻</a></li>
            <li><h4>活动讲座</h4><a href="#">近期活动</a><br><a href="#">往期活动</a><br><a href="#">合作伙伴活动</a></li>
            <li><h4>专题培训</h4><a href="#">理事成员</a><br><a href="#">委员会</a><a href="#">各地分会</a><br><a href="#">领域专家</a><br><a href="#">部分会员风采</a></li>
            <li><h4>资讯专区</h4><a href="#">人力资源信息</a><br><a href="#">资源信息</a><br><a href="#">前沿领域信息</a></li>
            <li><h4>加入筑誉</h4><a href="#">会员申请</a><br><a href="#">筑誉岗位</a><br><a href="#">专家招募</a><br><a href="#">合作伙伴招募</a></li>
        </ul>
        <div style=" clear:both;"></div>
    </div>
    <div class="Bottom-bq">
        <div class="Bottom-bq-c">
            <div class="fl">Copyright © www.cbra.com All Rights Reserved<br>筑誉建筑联合会 版权所有<br>地址：上海市普陀区真光路1219号新长征中环大厦23层　电话：021-61550302　邮编：200333</div>
            <div class="fr">沪ICP备14043363号-1</div>
            <div style=" clear:both;"></div>
        </div>
    </div>
</div>
<input type="hidden" value="${page}"  id="searchPage" />
<script type="text/javascript">
    function search(st){
        var searchPage = $.trim($("#searchPage").val());
        if(searchPage != null){
            location.href = "/public/search?page=" + searchPage +"&search=" + st;
        }else{
            location.href = "/public/search?search="+st;
        }
    }
</script>
<!-- 底部 end -->