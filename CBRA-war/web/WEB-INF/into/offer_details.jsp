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
        <jsp:include page="/WEB-INF/into/z_into_banner.jsp"><jsp:param name="page" value="8" /></jsp:include>
            <!-- 主体 -->
            <div class="two-main">
                <!-- 左侧导航 -->
            <jsp:include page="/WEB-INF/into/z_left.jsp"><jsp:param name="page" value="8" /></jsp:include>
                <!-- 左侧导航 end -->
                <!-- 右侧内容 -->
                <div class="fr-con">
                    <div class="title"><span><a id="title-span">职位详细信息</a></span></div>
                    <div class="con-single">
                        <div style="padding-left:40px;">
                            <strong>职位名称：</strong>　　助理咨询师　　　<strong>职位编码：</strong><br>	
                            <strong>部门：</strong>　　　　和君咨询　　　　<strong>发布日期：</strong>　　2015-01-29<br>	
                            <strong>工作地区：</strong>　　北京市　　　　　<strong>岗位类别：</strong>　　咨询顾问 <br>
                            <strong>招聘人数：</strong>　　不限　　　　　　<strong>月薪：</strong>　　　　面谈<br>
                            <strong>职位描述：</strong><br>
                            管理咨询类职位（战略、组织、人力资源、品牌、企业文化、市场营销等）<br>
                            【职位名称】  助理咨询师 （全职、实习均可）<br>
                            <strong>岗位职责：</strong><br>
                            1. 在项目经理安排和指导下开展咨询工作；<br>
                            2. 负责项目所需各种数据、信息和资料的收集整理工作；<br>
                            3. 参与咨询项目的文案资料编制和修稿；<br>
                            4. 协助参与咨询项目的行业研究与分析；<br>
                            5. 协助参与咨询项目的调研与访谈；<br>
                            6. 公司安排的其他工作。<br>

                            <strong>任职资格：</strong><br>

                            1. 全日制大学本科以上学历，硕士、MBA优先；<br>
                            2. 专业不限，有研究经验或相关实习经验者优先；<br>
                            3. 熟练应用Word、PPT、Excel等计算机常用软件；<br>
                            4. 具备良好的逻辑思维能力与沟通表达能力，善于快速学习与团队协作；<br>
                            5. 理解咨询行业工作特点，能适应随项目经常性出差。<br>


                            <strong>职位要求：</strong><br>
                            <strong>年龄：</strong>　　　　20~30岁　　　　<strong>性别：</strong>　　　　不限<br>
                            <strong>英语等级：</strong>	 　　四级	 　　　　　<strong>学历：</strong>	 本科-博士 

                            <div class="fenxiang">
                                <div class="bshare-custom "><a title="分享到QQ空间" class="bshare-qzone"></a><a title="分享到新浪微博" class="bshare-sinaminiblog"></a><a title="分享到人人网" class="bshare-renren"></a><a title="分享到腾讯微博" class="bshare-qqmb"></a><a title="分享到网易微博" class="bshare-neteasemb"></a><a title="更多平台" class="bshare-more bshare-more-icon more-style-addthis"></a><span class="BSHARE_COUNT bshare-share-count">0</span></div>
                            </div>

                        </div>
                    </div>
                </div>
                <!-- 右侧内容 end -->
                <div style="clear:both;"></div>
            </div>
            <!-- 主体 end -->
        <jsp:include page="/WEB-INF/public/z_end.jsp"/>
        <script type="text/javascript" charset="utf-8" src="http://static.bshare.cn/b/buttonLite.js#style=-1&amp;uuid=&amp;pophcol=2&amp;lang=zh"></script>
        <script type="text/javascript" charset="utf-8" src="http://static.bshare.cn/b/bshareC0.js"></script>
    </body>
</html>
