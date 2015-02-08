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
        <jsp:include page="/WEB-INF/into/z_into_banner.jsp"><jsp:param name="page" value="2" /></jsp:include>
            <!-- 主体 -->
            <div class="two-main">
                <!-- 左侧导航 -->
            <jsp:include page="/WEB-INF/into/z_left.jsp"><jsp:param name="page" value="2" /></jsp:include>
                <!-- 左侧导航 end -->
                <!-- 右侧内容 -->
                <div class="fr-con">

                    <div class="title"><span><a id="title-span">业务格局</a></span></div>

                    <div class="con-single">　　我们本着构筑行业信誉，推动中国建筑行业进步的使命，怀着成为建筑业最具公信力专业平台的协会愿景以及为了体现诚实守信，平等互助和透明规范的协会价值，在21世纪全球聚焦中国迅速发展的今天成立我们的专业行业协会，任重而道远！回顾过去的建筑发展历程， 中国建筑无论从设计理念的创新，建筑设计的优化，施工工艺的改良，新材料的应用以及建筑质量的维护都有了重大的突破！我们探讨了在过去建筑发展历程中所存在的一些不足以及未来建筑在新形势下发展的的目标和方向，决心为中国建筑的发展规范行业市场，构筑行业信誉，将中国建筑发展和国际并轨！<br>
　　我们认为，目前国内建筑市场，随着市场经济的快速发展，同行业之间的竞争日趋激烈，常常出现投标过程中的恶意竞标，施工过程中存在的质量，安全，进度管理问题，项目结束后的维保问题等；所有这些问题的解决，必须靠规范行业市场，提升建筑产业链上各企业的建筑服务意识，建立建筑诚信体系，加强各建筑产业链上的企业的品牌，信誉和口碑意识！<br>
　　我们主张要加大行业管理力度，企业信誉评估体系，创造公平竞争环境，规范市场经营行为，加强行业自律，不断提高标准化、工厂化、部品化、装配化水平，采用新工艺、新材料、新设备、新理念，提高企业核心竞争力。加强行业互动、企业交流、精英对话，媒体引导，舆论宣传，共同创造和谐的建筑市场环境。<br>
　　我们认为，目前国内建筑市场，随着市场经济的快速发展，同行业之间的竞争日趋激烈，常常出现投标过程中的恶意竞标，施工过程中存在的质量，安全，进度管理问题，项目结束后的维保问题等；所有这些问题的解决，必须靠规范行业市场，提升建筑产业链上各企业的建筑服务意识，建立建筑诚信体系，加强各建筑产业链上的企业的品牌，信誉和口碑意识！<br>
　　我们主张要加大行业管理力度，企业信誉评估体系，创造公平竞争环境，规范市场经营行为，加强行业自律，不断提高标准化、工厂化、部品化、装配化水平，采用新工艺、新材料、新设备、新理念，提高企业核心竞争力。加强行业互动、企业交流、精英对话，媒体引导，舆论宣传，共同创造和谐的建筑市场环境。</div>

                </div>
                <!-- 右侧内容 end -->
                <div style="clear:both;"></div>
            </div>
            <!-- 主体 end -->
        <jsp:include page="/WEB-INF/public/z_end.jsp"/>
    </body>
</html>
