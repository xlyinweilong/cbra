<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
        <meta name="apple-mobile-web-app-capable" content="yes">
        <meta name="apple-mobile-web-app-status-bar-style" content="black">
        <title>筑誉建筑联合会</title>
        <script type="application/javascript" src="/js/jquery.min.js"></script>
        <script type="application/javascript" src="/js/iscroll-lite.js?v4"></script>
        <script type="text/javascript">
            var myScroll;
            function loaded() {
                myScroll = new iScroll('wrapper');
            }
            document.addEventListener('touchmove', function (e) {
                e.preventDefault();
            }, false);
            document.addEventListener('DOMContentLoaded', loaded, false);
        </script>
        <style type="text/css" media="all">
            body,ul,li {
                padding:0;
                margin:0;
                border:0;
            }
            body {
                font-size:12px;
                -webkit-user-select:none;
                -webkit-text-size-adjust:none;
                font-family:helvetica;
            }
            #wrapper {
                position:absolute; z-index:1;
                top:0; bottom:0; left:0;
                width:100%;
                background:#ffffff;
                overflow:auto;
            }
            #scroller {
                position:absolute; z-index:1;
                /*	-webkit-touch-callout:none;*/
                -webkit-tap-highlight-color:rgba(0,0,0,0);
                width:100%;
                padding:0;
            }
            #scroller ul {
                list-style:none;
                padding:0;
                margin:0;
                width:100%;
                text-align:left;
            }

            #scroller li {
                padding:0 10px;
                height:40px;
                line-height:40px;
                border-bottom:1px solid #ccc;
                border-top:1px solid #fff;
                background-color:#fafafa;
                font-size:14px;
            }
            #scroller .content { width:90%; height:auto; margin:2.5% auto; line-height:32px; font-size:16px; color:#6a6a6a;}
            #scroller .content h1 { width:100%; height: auto; line-height:72px; font-size:24px; color:#444444; font-family:"微软雅黑";}
            #scroller .content .status { width:100%; height:24px; line-height:24px; margin-bottom:2%;}
            #scroller .content .status .sta-l { float:left; color:#6a6a6a;}
            #scroller .content .status .sta-r { float:right; color:#ff6000;}
            #scroller .content .status-b { width:100%; height:24px; line-height:24px; margin-bottom:2%;color:#ff6000;}
            img{width: 100%;height: 100%;}
        </style>
    </head>
    <body>
        <div id="wrapper">
            <div id="scroller">
                <div class="content">
                    <h1>${fundCollection.title}</h1>
                    <div class="status"><span class="sta-l"><fmt:formatDate value='${fundCollection.eventBeginDate}' pattern='yyyy-MM-dd HH:mm' type='date' dateStyle='long' /> -- <fmt:formatDate value='${fundCollection.eventEndDate}' pattern='yyyy-MM-dd HH:mm' type='date' dateStyle='long' /></span></div>
                    <div  class="status-b">活动状态：${fundCollection.status}</div>
                    ${fundCollection.detailDescHtml}
                </div>
            </div>
        </div>
        <script type="text/javascript">
            $("#wrapper").find("img").each(function () {
                $(this).css("width", "100%");
            });
        </script>
    </body>
</html>
