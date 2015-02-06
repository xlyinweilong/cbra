<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html>
    <head>
        <jsp:include page="/WEB-INF/public/z_header.jsp"/>
        <style>
            .bac-error { width:326px; height:192px; background:url(/images/cuo.jpg) no-repeat top; margin:50px auto; padding:163px 0 0 255px;}
            .bac-error .kuang { width:195px; height:70px; }
            .bac-error .kuang h1 { font-size:16px; font-family:"微软雅黑"; margin:10px auto auto 10px;}
            .bac-error .kuang p { font-size:12px; font-family:"微软雅黑"; margin:5px auto auto 10px;}
        </style>
    </head>
    <body>
        <div class="bac-error">
            <div class="kuang">
                <h1>出错啦</h1>
                <p>非常抱歉，页面加载失败。</p>
            </div>
        </div>
    </body>
</html>