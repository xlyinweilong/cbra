<%-- 
    Document   : list
    Created on : Jan 16, 2013, 5:37:21 PM
    Author     : wangshuai
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:if test="${empty bundle}">
    <fmt:setLocale value="${SESSION_ATTRIBUTE_LOCALE}" scope="session" />
    <fmt:setBundle basename="message" scope="session" var="bundle"/>
</c:if>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" style="background:none">
    <head>    
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>
            <fmt:message key="GLOBAL_HEADER_TITLE" bundle="${bundle}"/>
        </title> 
        <meta name="keywords" content="友付 yoopay yoopay.cn 收款 活动 团体 捐款 转款 支付宝 银联 网银 贝宝 易宝 快钱 财付通 china event group donation payment unionpay alipay paypal visa mastercard american express amex yeepay 99bll tenpay "/> 
        <meta name="description" content="友付帮助用户轻松完成各种收款及转款需求，如：活动收款、团体收款、朋友转款、募捐；支持网银、支付宝、信用卡等多种支付方式和币种，并提供款项纪录和管理功能；"/> 
        <link rel="shortcut icon" href="/favicon.ico" /> 

        <%-- 在正式DEPLOY时，所有CSS和JAVASCRIPT文件，都需要设置BROWSWER SIDE CACHE，并且在登录前各页面做预加载。 --%>
        <link href="/css/style.css" rel="stylesheet" type="text/css" />
        <link href="/css/jquery-ui-1.9.1.custom.min.css" rel="stylesheet" type="text/css"/>
        <link href="/css/fullcalendar/fullcalendar.css" rel="stylesheet" type="text/css"/>
        <link href="/css/fullcalendar/viewmore.css" rel="stylesheet" type="text/css"/>
        <link href="/css/fullcalendar/formbubble.css" rel="stylesheet" type="text/css"/>
        <link href="/css/jquery.qtip.css" rel="stylesheet" type="text/css"/>
        <fmt:message key='GLOBAL_LANGUAGE_SPECIFIC_CSS' bundle='${bundle}'/>
        <%--<link href="/css/style.min.css" rel="stylesheet" type="text/css" />--%>
        <script type="text/javascript" src="/scripts/jquery-1.8.2.min.js"></script>
        <script type="text/javascript" src="/scripts/jquery-ui-1.9.1.custom.min.js"></script>
        <script type="text/javascript" src="/scripts/jquery.qtip.min.js"></script>
        <script type="text/javascript" src="/scripts/fullcalendar.js"></script>
        <script type="text/javascript" src="/scripts/fullcalendar.viewmore.js"></script>
        <script type="text/javascript" src="/scripts/jquery.formbubble.js"></script>
        <script type="text/javascript" src="/scripts/date.js"></script>
        <script type="text/javascript" src="/scripts/yoopay.js"></script>
        <style type='text/css'>
            body {
                margin-top: 140px;
                text-align: center;
                font-size: 14px;
                font-family: "Lucida Grande", Helvetica, Arial, Verdana, sans-serif;
            }
            #calendar {
                margin-top: 20px;
            }
            .eData {
                font-size:12px;
            }
            .eTitle {
                font-size:14px;
                font-weight:bold;
                margin-top:5px;
            }
            .eDate {
                margin-top:15px;
            }
            .eAddress {
                margin-top:15px;
            }
            .eBtn {
                font-size:14px;
                text-align: right;
                margin-top: 30px;
            }
            .fc-event-time {
                display: none;
            }
            .fc-today {
                background-image: none;
                background-color: #EAEAEA;
                border-width: 0px;
                border-color: #00CCFF;
            }
            .fc-button-prev,.fc-button-next {
                 background-image: none;
                 background-color: #ffffff;
                 border-width: 0px;
            }
            .fc-button-prev .ui-icon {
                background-image: url("/images/arrow_left.png");
            }
             .fc-button-next .ui-icon {
                background-image: url("/images/arrow_right.png");
            }
        </style>
    </head>

    <body style="padding:0px;margin:0px; background: none">
        <div class="container"> 
            <div>
                <div class="active_box">
                    <div class="clear"></div>
                    <div class="money_sail">
                        <div class="FloatLeft" style="width: 150px">
                            <fmt:message key="CALENDAR_DETAIL_TEXT_日历" bundle="${bundle}"/>
                        </div>

                        <div class="FloatRight" style="width:55px;"><a class="WidgetHeadLogo" href="https://yoopay.cn/" target="_blank"></a></div>
                        <div class="WidgetCHEN"> <a href="javascript:language.doSetChinese()">中文</a> | <a href="javascript:language.doSetEnglish()">English</a>
                        </div> 
                    </div>
                    <div id='calendar'></div>
                    <div class="money_sail_widget_footer">
                        <%--a target="_blank" href="https://yoopay.cn/"><div class="RightLogo" style="width:55px;"></div></a--%>
                        <div>
                            <fmt:message key="PULIC_Z_EVENT_FOOTER_TEXT_LEFT_WIDGET" bundle="${bundle}"/>　
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div id="event_detail_container" style="display: none">
            <div class='eData'>
                <div class='eTitle'>
                    <a target='_blank' class="eLink"></a>
                </div>
                <div class='eDate'></div>
                <div class='eAddress'></div>
                <div class='eBtn'><a target='_blank' class="eLink"></a></div>
            </div>
        </div>
        <script type='text/javascript'>
            function showEventInfo(element, event, jsEvent){ 
                var language = "${language}";
                //qtip
                var eventWebId = event.id;
                var eventTitle = event.fullTitle;
                var eventStartDate;
                var eventEndDate;
                if(language=="zh") {
                    eventStartDate = event.start.toString("yyyy/MM/dd HH:mm");
                    eventEndDate = event.end.toString("yyyy/MM/dd HH:mm");
                } else {
                    eventStartDate = event.start.toString("MM/dd/yyyy HH:mm");
                    eventEndDate = event.end.toString("MM/dd/yyyy HH:mm");
                }
                var weekday = event.start.getDay();
                var eventDateDescr = eventStartDate + " - " + eventEndDate;
                var eventLocation = event.location;
                var eventQtip = element.data("eqtip");
                if(eventQtip == null) {
                    var tipTextContainer = $("#event_detail_container");
                    tipTextContainer.find(".eTitle > a").html(eventTitle);
                    tipTextContainer.find(".eDate").html(eventDateDescr);
                    tipTextContainer.find(".eAddress").html(eventLocation);
                    tipTextContainer.find(".eLink").attr("href","/event/"+eventWebId);
                    tipTextContainer.find(".eBtn > a").html(Lang.get("CALENDAR_TEXT_详情"));
                    var tipText = tipTextContainer.html();
                    eventQtip = element.qtip({
                        content: {
                            text: tipText
                        },
				
                        hide: {
                            event: 'unfocus'
                        },
                        show: {
                            event: false, // Don't specify a show event...
                            ready: true // ... but show the tooltip when ready
                        },
                        position: {
                            my: 'bottom center',  // Position my top left...
                            at: 'top center', // at the bottom right of...
                            viewport: $(window)
                        },
                        style: {
                            classes: 'qtip-shadow qtip-light',
                            width : "500px",
                            height: "150px"
                        }
                    });
                    element.data("eqtip",eventQtip);
                } else {
                    eventQtip.qtip('show');
                }
		
                //$(this).children("div").css('backgroundColor', '#6CF');
            }
            $(document).ready(function() {
                var date = new Date(); //2013 1 15
                var d = date.getDate(); //15
                var m = date.getMonth(); //0
                var y = date.getFullYear();  //2013
		
                $('#calendar').fullCalendar({
                    //Defines the buttons and title at the top of the calendar.
                    header: {
                        left:   '',
                        center: 'prev,title,next',
                        right:  'today'
                    },
                    editable: false, //This determines if the events can be dragged and resized. 
                    theme: true, //Enables/disables use of jQuery UI theming.
                    aspectRatio:1.35, //Determines the width-to-height aspect ratio of the calendar.
                    selectable: false,
                    weekMode:"variable",
                    eventBackgroundColor:"#4A85E9",
                    eventBorderColor:"#4A85E9",
                    eventTextColor:"#000000",
                    buttonIcons:{
                        prev: 'yp-triangle-w',
                        next: 'yp-triangle-e'
                    },
                    //Styles
                    //eventBackgroundColor:"white",
                    //eventBorderColor:"white",
                    //eventTextColor:"black",
                    //Event
                    eventClick:function(event, jsEvent, view){ 
                        showEventInfo($(this), event, jsEvent);
                        //$(this).children("div").css('backgroundColor', '#6CF');
                    },
                    //i18n
                    //dayNames:['Sunday', 'Monday', 'Tuesday', 'Wednesday','Thursday', 'Friday', 'Saturday'],
            <c:choose>
                <c:when test="${language == 'zh'}">
                            dayNames:['星期日', '星期一', '星期二', '星期三','星期四', '星期五', '星期六'],
                            dayNamesShort:['星期日', '星期一', '星期二', '星期三','星期四', '星期五', '星期六'],
                            buttonText:{
                                today:'今天'
                            },
                            titleFormat:{
                                month: 'yyyy年M月'  //MMMM yyyy
                            },
                </c:when>
                <c:otherwise>
                            buttonText:{
                                today:'Today'
                            },
                </c:otherwise>
            </c:choose>
                   
                        events: function(start, end, callback) {
                            $.ajax({
                                url: '/calendar/event_agenda',
                                dataType: 'json',
                                data: {
                                    a:"FETCH_EVENTS",
                                    email:"${ownerEmail}",
                                    start: Math.round(start.getTime()),
                                    end: Math.round(end.getTime()),
                                    noCache : new Date().getTime()
                                },
                                success: function(data) {
                                    var events = [];
                                    $.each(data.events, function(i,event){
                                        var webId = event.webId;
                                        var title = event.title.substring(0,8);
                                        var fullTitle = event.title;
                                        var startDate = new Date();
                                        startDate.setTime(event.eventBeginDate);
                                        var endDate = new Date();
                                        endDate.setTime(event.eventEndDate);
                                        var wholeDay = event.eventDateWholeDay;
                                        var location = event.eventLocation;
                                        events.push({
                                            id:webId,
                                            fullTitle: fullTitle,
                                            title: title,
                                            start: startDate,
                                            end: endDate,
                                            location:location,
                                            allDay:wholeDay
                                        });
                                    });
                                    callback(events);
                                }
                            });
                        }
                    }).limitEvents(3);
		
                });

        </script>
        <script type="text/javascript">
            
            window.onload = function(){
                resizeIframeHeight();
            };
            
            function resizeIframeHeight() {
                parent.socket.postMessage(document.body.clientHeight || document.body.offsetHeight || document.body.scrollHeight);
                window.setTimeout("resizeIframeHeight()", 250);
            }
        </script>
    </body>
</html>
