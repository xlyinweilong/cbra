<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!--top-->
<div class="top-top">
    <!--页眉-->
    <div class="Header">

        <div class="top-main">

            <!--微信/联系方式-->
            <div class="weix-lianx">
                <a class="ico-weixin weixin" onmouseout="showWeixinMenu(this)" onmouseover="showWeixinMenu(this, true)" href="javascript:;">官方微信</a>
                <a class="ico-weixin lianx">联系我们</a>
            </div>
            <!--微信下拉二维码-->
            <div id="WeixinMenu" class="weixin-menu" style="display: none;">
                <div class="weixin-bd">
                    <p><img src="images/weixin.jpg"><span style="font-size:12px;"> 扫一扫，关注<span style="color:#e53333;">筑誉微信</span>，共同分享有建设性价值的商业思索、见闻和感悟</span></p>
                </div>
            </div>
            <!--登录/注册/会员中心/中英文-->
            <div class="right-gn">
                <a href="Registration.html">会员登录</a>  |  <a href="ind-reg.asp">快速注册</a>　　<a href="gr-mc.asp?id=30" >个人会员中心</a>  |  <a href="qy-mc.asp?id=30" >企业会员中心</a>  |  <a href="#">English</a>   |   <a href="#">中文</a>   |   <a href="error-c.asp">报错页面连接，知道后程序去掉</a>
            </div>

        </div>

    </div>
    <!--页眉 end-->
    <!--logo-->
    <div class="LOGO">
        <div class="LOGO-l"><a href="/public/index"><img src="images/logo.png"></a></div>
        <div class="LOGO-r">
            <p>咨询热线：021-61550302</p>
            <input type="text" class="Input-k"><input type="button" class="button-a" value="搜索" onclick="location.href = 'Search.asp'">
        </div>
        <div style=" clear:both;"></div>
    </div>
    <!--logo end-->

    <!--导航-->
    <div class="nav-wrap">
        <ul id="HJ_Nav" class="nav">
            <!--首页-->
            <li id="nav_item_1" class="nav-item"><a class="nav-txt" target="" onmouseover="M(this, 1)"  href="/public/index">筑誉首页</a></li>
            <!--首页 end-->

            <!--走进筑誉-->
            <li id="nav_item_2" class="nav-item"><a class="nav-txt" target="" onmouseover="M(this, 2)" href="into-zyln.asp?id=1">走进筑誉</a>
                <div class="nav-menu clearfix" id="HJ_Menu_2" style="width: 630px; display: none;">
                    <ul class="fl nav-channel">
                        <li><a href="into-zyln.asp?id=1" >筑誉理念</a></li>
                        <li><a href="into-ywgj.asp?id=2" >业务格局</a></li>
                        <li><a href="into-fzlc.asp?id=3" >发展历程</a></li>
                        <li><a href="into-hzzc.asp?id=4" >会长致辞</a></li>
                        <li><a href="into-lsxy.asp?id=5" >理事宣言</a></li>
                        <li><a href="into-lxwm.asp?id=6" >联系我们</a></li>
                    </ul>
                    <span class="nav-menu-line" style="height:292px;margin-right:30px">&nbsp;</span>
                    <div class="fl hui" style="width:410px">
                        <p><img src="ls/3591G05OQF_m.jpg" width="410" height="247" alt=""><br> 和君集团的基本业务格局为：和君咨询+和君资本+和君商学，即以管理咨询为主体，以资本和商学教育为两翼的“一体两翼”模式。</p></div>
                </div>
            </li>
            <!--走进筑誉 end-->
            <!--新闻中心-->
            <li id="nav_item_3" class="nav-item"><a class="nav-txt" target="" onmouseover="M(this, 3)" href="news.asp">新闻中心</a>
                <div class="nav-menu clearfix" id="HJ_Menu_3" style="width: 560px; display: none;">
                    <ul class="fl nav-channel" id="menu-news-switch" onmouseover="inittab( & #39; menu - news - switch & #39; , & #39; li & #39; , & #39; div & #39; )">
                        <li><a href="news.asp">筑誉新闻</a></li>
                        <li><a href="news-1.asp">行业新闻</a></li>
                    </ul>
                    <span class="nav-menu-line" style="height:202px"></span>
                    <div class="fl" id="menu-news-switch-body" style="width:380px">
                        <span class="blank10"></span>
                        <div>
                            <h4><a href="news.asp" target="_blank">筑誉动态</a></h4>
                            <span class="blank10"></span>
                            <ul class="list list-f12-autoheight">
                                <li><a href="detailed.asp" target="_blank">资源互动，价值共享 ——和君集团幸福养老咨询团队精彩亮相</a></li>
                                <li><a href="detailed.asp" target="_blank">和君集团党的群众路线教育实践活动总结大会圆满结束</a></li>
                                <li><a href="detailed.asp" target="_blank">资源互动，价值共享 ——和君集团幸福养老咨询团队精彩亮相</a></li>
                            </ul>
                            <h4><a href="news.asp" target="_blank">媒体报道</a></h4>
                            <span class="blank10"></span>
                            <ul class="list list-f12-autoheight">
                                <li><a href="detailed.asp" target="_blank">资源互动，价值共享 ——和君集团幸福养老咨询团</a></li>
                                <li><a href="detailed.asp" target="_blank">和君集团党的群众路线教育实践活动总结大会圆满结束</a></li>
                                <li><a href="detailed.asp" target="_blank">资源互动，价值共享 ——和君集团幸福养老咨询团队精彩亮相</a></li>
                            </ul>
                            <span class="blank10"></span>
                            <span class="more fr"><a href="news.asp" target="_blank">更多</a></span>
                        </div>
                        <div style="display:none">
                            <h4><a href="#" target="_blank">行业新闻</a></h4>
                            <span class="blank10"></span>
                            <ul class="list list-f12-autoheight">
                                <li><a href="detailed.asp" target="_blank">和君咨询发起中国首个人才经纪人联盟</a></li>
                                <li><a href="detailed.asp" target="_blank">“中国在线教育之都”发布暨首届在线教育投融资峰会</a></li>
                                <li><a href="detailed.asp" target="_blank">和君资本合伙人李文明：上市公司主导医药行业并购整合将成潮</a></li>
                                <li><a href="detailed.asp" target="_blank">团中央官网报道和君"幸福茶农"启动仪式</a></li>
                                <li><a href="detailed.asp" target="_blank">五粮液再次携手和君咨询展开白酒并购</a></li>
                            </ul>
                            <span class="blank10"></span>
                            <span class="more fr"><a href="news-1.asp" target="_blank">更多</a></span>
                        </div>
                    </div>
                </div>
            </li>
            <!--新闻中心 end-->


            <!--活动讲座-->
            <li id="nav_item_4" class="nav-item"><a class="nav-txt" target="" onmouseover="M(this, 4)" href="hd-jq.asp">活动讲座</a>
                <div class="nav-menu clearfix" id="HJ_Menu_4" style="min-height: inherit; width: 700px; left: -95px; display: none;">
                    <ul class="fl nav-channel">
                        <li><a href="hd-jq.asp">近期活动</a></li>
                        <li><a href="hd-wq.asp">往期活动</a></li>
                        <li><a href="hd-hzhb.asp">合作伙伴活动</a></li>
                    </ul>
                    <span class="nav-menu-line" style="height:240px;margin-right:40px"></span>
                    <div class="fl hui" style="width:200px;padding-top:10px;overflow:hidden">
                        <p><a target="_blank" href="#"><img src="ls/S765GG2KOC_m.jpg" ></a></p>
                        <p>&nbsp;</p><p>封面专题：建设幸福企业</p>
                        <p>对于企业家和管理来说，如何营造让员工感到幸福的工作环境，将企业做好，为国家做贡献，给社会带来帮助，这些才是最重要的。</p>
                    </div>
                    <span class="nav-menu-line" style="height:240px;margin-right:40px"></span>
                    <div class="fl hui" style="width:200px;padding-top:10px;overflow:hidden;" >
                        <p><a href="#" target="_blank"><img src="ls/201406112030yyfp.jpg"></a></p>
                        <p>&nbsp;</p>
                        <p>你需要的不是向日葵和马，你真正需要的是凡高的向日葵和徐悲鸿的马！<br>你需要的不是平庸的咨询服务，你真正需要的是高手做出来的咨询服务！</p>
                    </div>
                </div>
            </li>
            <!--活动讲座 end-->

            <!--专题培训-->
            <li id="nav_item_5" class="nav-item"><a class="nav-txt" target="" onmouseover="M(this, 5)" href="st-pxln.asp?id=7">专题培训</a>
                <div class="nav-menu clearfix" id="HJ_Menu_5" style="left:-206px; width: 700px; display: none;">
                    <ul class="fl nav-channel">
                        <li><a href="st-pxln.asp?id=7" >培训理念</a></li>
                        <li><a href="st-jqpx.asp?id=8" >近期培训</a></li>
                        <li><a href="st-wqpx.asp?id=9" >往期培训</a></li>
                        <li><a href="st-jstd.asp?id=10" >讲师团队</a></li>
                    </ul>
                    <span class="nav-menu-line" style="height:240px;margin-right:40px"></span>
                    <div class="fl hui" style="width:220px;padding-top:10px;overflow:hidden">
                        <p><a href="http://www.hejun.com/channel.php?channelid=748" target="_blank"><img src="ls/201406191736qfmb.jpg"></a></p>
                        <p>&nbsp;</p>
                        <p><strong>成长在和君&nbsp;<br>
                            </strong>有目标、沉住气、踏实干。拒绝喧嚷、拒绝浮躁、拒绝摆秀、拒绝浮名、拒绝速成，慢慢地蓄深养厚，最终把事业搞辉煌，把自己搞平淡。</p>
                    </div>
                    <span class="nav-menu-line" style="height:240px;margin-right:40px"></span>
                    <div class="fl hui" style="width:220px;padding-top:10px;overflow:hidden">
                        <p><a href="http://www.hejun.com/channel.php?channelid=749" target="_blank"><img src="ls/201406191739ozeg.jpg"></a></p>
                        <p>&nbsp;</p>
                        <p><strong>我们的生活&nbsp;<br>
                            </strong>经历各种行业、各个地域、各种人生、各类故事，吃百家饭，阅人无数，踏遍千山万水，览尽世间万象，看透人生百态。</p>
                    </div>
                </div>
            </li>
            <!--专题培训 end-->

            <!--认证体系-->
            <li id="nav_item_9" class="nav-item"><a class="nav-txt" target="" onmouseover="M(this, 9)" href="auth-per.asp">认证体系</a>
                <div class="nav-menu clearfix" id="HJ_Menu_9" style="width:300px; left:3px; display: none;">
                    <div class="fl" style="width:100px">
                        <h4>个人认证</h4>
                        <span class="blank6"></span>
                        <ul class="nav-sub-channel">
                            <li><a href="auth-per.asp?id=34" >设计</a></li>
                            <li><a href="auth-per.asp?id=34" >施工</a></li>
                            <li><a href="auth-per.asp?id=34" >质量</a></li>
                            <li><a href="auth-per.asp?id=34" >安全</a></li>
                        </ul>
                    </div>
                    <span class="nav-menu-line" style="margin-right:35px;margin-left:25px"></span>
                    <div class="fl" style="width:100px">
                        <h4>企业认证</h4>
                        <span class="blank6"></span>
                        <ul class="nav-sub-channel">
                            <li><a href="auth-bus.asp?id=35" >品质认证</a></li>
                            <li><a href="auth-bus.asp?id=35" >安全认证</a></li>
                        </ul>
                    </div>
                </div>
            </li>
            <!--认证体系 end-->

            <!--团队风采-->
            <li id="nav_item_6" class="nav-item"><a class="nav-txt" target="" onmouseover="M(this, 6)" href="team-lscy.asp?id=11" >团队风采</a>
                <div class="nav-menu clearfix" id="HJ_Menu_6" style="left: auto;  width: 410px; left: -138px;  display: none;">
                    <ul class="fl nav-channel">
                        <li><a href="team-lscy.asp?id=11">理事成员</a></li>
                        <li><a href="team-wyh.asp?id=12">委员会</a></li>
                        <li><a href="team-gdfh.asp?id=13">各地分会</a></li>
                        <li><a href="team-lyzj.asp?id=14">领域专家</a></li>
                        <li><a href="team-bffh.asp?id=15">部分会员风采</a></li>
                    </ul>
                    <span class="nav-menu-line" style="height:240px;margin-right:40px"></span>
                    <div class="fl hui" style="width:220px;padding-top:10px;overflow:hidden">
                        <p><a href="#" target="_blank"><img style="height:131px;width:206px;" src="ls/201409121234mjj8.jpg"></a></p>
                        <p>实现党建工作与企业经营管理的互动，努力为集团各项工作的健康发展提供坚强的组织保证<br></p>
                    </div>
                </div>
            </li>
            <!--团队风采 end-->

            <!--资讯专区-->
            <li id="nav_item_7" class="nav-item"><a class="nav-txt" target="" onmouseover="M(this, 7)" href="info-a.asp">资讯专区</a>
                <div class="nav-menu clearfix" id="HJ_Menu_7" style="width:450px; left: -289px; display: none;">
                    <div class="fl" style="width:100px">
                        <h4>人力资源信息</h4>
                        <span class="blank6"></span>
                        <ul class="nav-sub-channel">
                            <li><a href="into-rlzy.asp?id=16">企业人才需求</a></li>
                            <li><a href="into-zyrc.asp?id=17">筑誉人才库</a></li>
                        </ul>
                    </div>
                    <span class="nav-menu-line" style="margin-right:35px;margin-left:25px"></span>
                    <div class="fl" style="width:100px">
                        <h4>资源信息</h4>
                        <span class="blank6"></span>
                        <ul class="nav-sub-channel">
                            <li><a href="into-cggq.asp?id=18">采购供求信息</a></li>
                            <li><a href="into-hwgc.asp?id=19">海外工程合作</a></li>
                            <li><a href="into-jzcy.asp?id=20">建筑产业化合作</a></li>
                            <li><a href="into-yldc.asp?id=21">养老地产合作</a></li>
                        </ul>
                    </div>
                    <span class="nav-menu-line" style="margin-right:35px;margin-left:25px"></span>
                    <div class="fl" style="width:100px">
                        <h4>前沿领域信息</h4>
                        <span class="blank6"></span>
                        <ul class="nav-sub-channel">
                            <li><a href="into-xclxjs.asp?id=22">新材料新技术</a></li>
                            <li><a href="into-jzcyh.asp?id=23" >建筑产业化</a></li>
                            <li><a href="into-lsjz.asp?id=24" >绿色建筑</a></li>
                            <li><a href="into-bimjs.asp?id=25" >BIM技术</a></li>
                        </ul>
                    </div>
                </div>
            </li>
            <!--资讯专区 end-->

            <!--加入筑誉-->
            <li id="nav_item_8" class="nav-item"><a class="nav-txt" onmouseover="M(this, 8)" href="join-ind-reg.asp?id=26" >加入筑誉</a>
                <div class="nav-menu clearfix" id="HJ_Menu_8" style="left: -670px; width: 720px; display: none;">
                    <ul class="fl nav-channel">
                        <li><a href="join-ind-reg.asp?id=26" >会员申请</a></li>
                        <li><a href="join-zygw.asp?id=27" >筑誉岗位</a></li>
                        <li><a href="join-zjzm.asp?id=28" >专家招募</a></li>
                        <li><a href="join-hzhb.asp?id=29" >合作伙伴招募</a></li>
                    </ul>
                    <span class="nav-menu-line" style="height:240px;margin-right:40px"></span>
                    <div class="fl hui" style="width:220px;padding-top:10px;overflow:hidden">
                        <p><a href="#" target="_blank"><img src="ls/201406191736qfmb.jpg"></a></p>
                        <p><strong>成长在和君&nbsp;<br></strong>有目标、沉住气、踏实干。拒绝喧嚷、拒绝浮躁、拒绝摆秀、拒绝浮名、拒绝速成，慢慢地蓄深养厚，最终把事业搞辉煌，把自己搞平淡。</p>
                    </div>
                    <span class="nav-menu-line" style="height:240px;margin-right:40px"></span>
                    <div class="fl hui" style="width:220px;padding-top:10px;overflow:hidden">
                        <p><a href="#" target="_blank"><img src="ls/201406191739ozeg.jpg"></a></p>
                        <p><strong>我们的生活&nbsp;<br></strong>经历各种行业、各个地域、各种人生、各类故事，吃百家饭，阅人无数，踏遍千山万水，览尽世间万象，看透人生百态。</p>
                    </div>
                </div>
            </li>
            <!--加入筑誉 end-->

        </ul>
    </div>
    <!--导航 end-->
</div>