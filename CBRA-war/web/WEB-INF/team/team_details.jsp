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
        <jsp:include page="/WEB-INF/team/z_team_banner.jsp"><jsp:param name="page" value="1" /></jsp:include>
        <!-- 主体 -->
        <div class="two-main">
            <!-- 左侧导航 -->
            <jsp:include page="/WEB-INF/team/z_left.jsp"><jsp:param name="page" value="1" /></jsp:include>
            <!-- 左侧导航 end -->
            <!-- 右侧内容 -->
            <div class="fm-list">
                <div class="title"><span><a id="title-span">讲师介绍</a></span></div>
                <div class="jsjs">
                    <div class="img"><img src="ls/ls-24.jpg"></div>
                    <div class="detailed"><h1>单鹏安</h1>
                        和君集团高级合伙人<br>
                        和君集团医药医疗事业部总经理<br>
                        中国医科大学医学硕士<br><br>

                        <strong>个人特点与工作简历</strong><br>
                        和君集团高级合伙人、医药医疗事业部总经理，医药企业营销及战略问题专家。曾在多家医药企业从事市场营销工作，历任医药代表、销售经理、产品经理、高级产品经理、市场总监、营销管理委员会副主任、事业部副总经理等职。近十年来一直致力于医药和医疗领域的管理咨询工作，先后为国内外数十家医药企业、医疗机构提供营销策划、销售管理、战略规划、组织变革和人力资源管理等方面的咨询服务。<br><br>

                        能力领域<br>
                        营销策划<br>
                        销售管理<br>
                        战略规划<br>
                        组织变革<br>
                        人力资源 <br><br>

                        <strong>经手案例（选摘）</strong><br>
                        康恩贝集团：重点产品策划、十一五发展战略<br>
                        双鹤药业：北京降压O号营销宝典策划<br>
                        神威药业：营销战略、产品组合管理、营销模式设计<br>
                        华北制药：普药渠道再造、深度营销方案、品牌战略规划<br>
                        东北制药：营销整合、组织变革与人力资源管理<br>
                        石药集团：成药事业部营销战略规划<br>
                        沃森生物：营销体系构建、营销业务托管<br>
                        鲁抗医药：大制剂战略制订与落实<br>
                        新华制药：十一五发展战略、营销诊断与业务<br>
                        辽宁成大：集团战略诊断、成大生物、成大方圆战略规划<br>
                        奥鸿制药：重点产品策划、专业学术推广、市场精细化管理<br>
                        金活医药：营销战略规划、重点产品策划、渠道变革与商务管理<br>
                        ……
                    </div>
                    <div style="clear:both;"></div>
                </div>
            </div>
            <!-- 右侧内容 end -->
            <div style="clear:both;"></div>
        </div>
        <!-- 主体 end -->
        <jsp:include page="/WEB-INF/public/z_end.jsp"/>
    </body>
</html>
