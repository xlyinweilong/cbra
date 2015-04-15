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
        <!-- 主体 -->
        <div class="two-main">
            <!-- 详细信息 -->
            <div id="containerAll" class="hd-detailed">
                <form id="form1" action="/order/sign_up_event" method="post">
                    <input type="hidden" name="a" value="CREATE_ORDER" />
                    <input type="hidden" name="collection_id" value="${fundCollection.id}" />
                    <div class="hfcz" id="hysf_div">
                        <div class="hysf">
                            <span>会员身份：</span>
                            <span>
                                <input checked="checked" type="radio" id="danx">
                                <c:choose>
                                    <c:when test="${userType == 0}">非会员(准会员)</c:when>
                                    <c:when test="${userType == 1}">个人会员</c:when>
                                    <c:when test="${userType == 2}">企业会员</c:when>
                                </c:choose>
                            </span>
                            <div style="clear:both;"></div></div>
                            <c:choose>
                                <c:when test="${userType == 0}">
                                <div class="hysf">
                                    <span>姓　　名：</span><input type="text" name="attendee[0].name" id="baom"><a></a><br>
                                    <span>所在企业：</span><input type="text" name="attendee[0].company" id="baom"><a></a><br>
                                    <span>职　　务：</span><input type="text" name="attendee[0].position" id="baom"><a></a><br>
                                    <span>手机号码：</span><input type="text" name="attendee[0].mobilePhone" id="baom"><a></a><br>
                                    <span>电子邮箱：</span><input type="text" name="attendee[0].email" id="baom"><a></a><br>
                                </div>
                            </c:when>
                            <c:when test="${userType == 1}">
                            </c:when>
                            <c:when test="${userType == 2}">
                                <div class="hysf"><span>参会人数：</span><input type="text" id="rens" value="1">人（提示：选择企业会员时显示该选项）</div>
                                <div class="hysf">
                                    <span>姓　　名：</span><input type="text" name="attendee[0].name" id="baom"><a></a><br>
                                    <span>所在企业：</span><input type="text" name="attendee[0].company" id="baom"><a></a><br>
                                    <span>职　　务：</span><input type="text" name="attendee[0].position" id="baom"><a></a><br>
                                    <span>手机号码：</span><input type="text" name="attendee[0].mobilePhone" id="baom"><a></a><br>
                                    <span>电子邮箱：</span><input type="text" name="attendee[0].email" id="baom"><a></a><br>
                                </div>
                                <div id="containerDiv"></div>
                            </c:when>
                        </c:choose>
                        <div style="clear:both;"></div>
                    </div>
                    <div class="hfcz">
                        <h1>支付金额：<span id="amount_span">
                                <c:choose><c:when test="${userType == 0}">¥${fundCollection.touristPrice}</c:when><c:when test="${userType == 1}">¥${fundCollection.userPrice}</c:when><c:when test="${userType == 2}"><c:choose><c:when test="${fundCollection.eachCompanyFreeCount > 0}">免费</c:when><c:otherwise>¥${fundCollection.companyPrice}</c:otherwise></c:choose></c:when></c:choose>
                                    </span>
                                </h1>
                                                    <p><strong>费用说明：</strong>企业会员：<c:if test="${fundCollection.eachCompanyFreeCount > 0}">免费${fundCollection.eachCompanyFreeCount}人 , </c:if>${fundCollection.companyPrice}元/人　　个人会员：每人${fundCollection.userPrice}元/人　　非会员：${fundCollection.touristPrice}元/人</p>
                        </div>
                        <div class="xiayy"><input type="button" id="next_button" class="xiayy-an" value="提交申请" style="margin-left: 600px;"></div>
                </div>
            </form>
            <div class="news-fr">
                <div class="ad-fr"><img src="/ls/ls-20.jpg"></div>
                <h1><fmt:message key="GLOBAL_热门点击" bundle="${bundle}"/></h1>
                <div class="top-hits">
                    <ul>
                    <c:forEach var="event" items="${hotEventList}">
                        <li><a target="_blank" href="/event/event_details?id=${event.id}">${event.titleIndexStr3}</a></li>
                        </c:forEach>
                </ul>
            </div>
        </div>
        <div style="clear:both;"></div>
    </div>
    <hr id="hiddenHr" style="display: none"/>
    <div id="hiddenDiv" class="hysf" style="display: none">
        <span>姓　　名：</span><input type="text" name="attendee[0].name" id="baom"><a></a><br>
        <span>所在企业：</span><input type="text" name="attendee[0].company" id="baom"><a></a><br>
        <span>职　　务：</span><input type="text" name="attendee[0].position" id="baom"><a></a><br>
        <span>手机号码：</span><input type="text" name="attendee[0].mobilePhone" id="baom"><a></a><br>
        <span>电子邮箱：</span><input type="text" name="attendee[0].email" id="baom"><a></a><br>
    </div>
    <!-- 主体 end -->
    <jsp:include page="/WEB-INF/public/z_end.jsp"/>
    <script type="text/javascript">
        $(function () {
            //文本框只能输入数字，并屏蔽输入法和粘贴  
            $.fn.numeral = function () {
                $(this).css("ime-mode", "disabled");
                this.bind("keypress", function (e) {
                    var code = (e.keyCode ? e.keyCode : e.which);  //兼容火狐 IE      
                    if (!$.browser.msie && (e.keyCode == 0x8))  //火狐下不能使用退格键     
                    {
                        return;
                    }
                    return code >= 48 && code <= 57;
                });
                this.bind("blur", function () {
                    if (this.value.lastIndexOf(".") == (this.value.length - 1)) {
                        this.value = this.value.substr(0, this.value.length - 1);
                    } else if (isNaN(this.value)) {
                        this.value = "";
                    }
                });
                this.bind("paste", function () {
                    var s = clipboardData.getData('text');
                    if (!/\D/.test(s))
                        ;
                    value = s.replace(/^0*/, '');
                    return false;
                });
                this.bind("dragenter", function () {
                    return false;
                });
                this.bind("keyup", function () {
                    if (/(^0+)/.test(this.value)) {
                        this.value = this.value.replace(/^0*/, '');
                    }
                });
            };
            //调用文本框的id  
            $("#rens").numeral();
        });
        var freeCount = ${fundCollection.eachCompanyFreeCount};
        var companyPrice = ${fundCollection.companyPrice};
        $(document).ready(function () {
            $("#next_button").click(function () {
                var isReturn = false;
                $("#containerAll").find("input[name^='attendee']").each(function(){
                    if($.trim($(this).val()) == ''){
                        var nextA = $(this).next("a");
                        nextA.html("请输入内容!");
                        isReturn = true;
                    }
                });
                if (isReturn) {
                    return;
                }
                $("#form1").submit();
            });
            $("#rens").blur(function () {
                //删除所有
                $("#containerDiv").html("");
                //初始化价钱
                if (freeCount > 0) {
                    $("#amount_span").html("免费");
                } else {
                    $("#amount_span").html("¥" + companyPrice);
                }
                if (!($("#rens").val() > 0)) {
                    $("#rens").val(1);
                    return;
                }
                var count = $("#rens").val();
                for (var i = 1; i < count; i++) {
                    var hiddenHr = $("#hiddenHr").clone();
                    var hiddenDiv = $("#hiddenDiv").clone();
                    hiddenHr.show();
                    hiddenDiv.show();
                    hiddenHr.removeAttr("id");
                    hiddenDiv.removeAttr("id");
                    hiddenDiv.find("input[name^='attendee']").each(function () {
                        var name = $(this).attr("name");
                        name = name.replace("0", i);
                        $(this).attr("name", name);
                    });
                    $("#containerDiv").append(hiddenHr);
                    $("#containerDiv").append(hiddenDiv);
                }
                //计算价钱
                if (count - freeCount > 0) {
                    var price = companyPrice * (count - freeCount);
                    $("#amount_span").html("¥" + price);
                } else {
                    $("#amount_span").html("免费");
                    ;
                }
            });
        });
    </script>
</body>
</html>
