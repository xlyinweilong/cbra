<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<c:if test="${empty fundCollection || fundCollection.weiboSharable}">
    <div id="divFenxiang" class="WeibaoShare">
        <p><fmt:message key='PULIC_Z_WEIBOFOLLOW_分享' bundle='${bundle}'/></p>
        <a href="javascript:void(0)" onclick="WeiBo.shareToSinaWB('${fundCollection.webId}')"><img src="/images/weibo/xinlang32.png" alt="分享到新浪微博" width="32" height="32"/></a>
        <a href="javascript:void(0)" onclick="WeiBo.shareToTengxunWB('${fundCollection.webId}')"><img src="/images/weibo/tengxun32.png" alt="分享到腾讯微博" width="32" height="32"/></a>
        <a href="javascript:void(0)" onclick="WeiBo.shareToRenrenWB('${fundCollection.webId}')"><img src="/images/weibo/renren32.png" alt="分享到人人" width="32" height="32"/></a>
    </div>
    <script type="text/javascript"> 
        window.onscroll=function(){
            var oDiv = document.getElementById('divFenxiang');
            var scrollTop = document.documentElement.scrollTop + document.body.scrollTop + 42;//处理浏览器兼容问题
            if(scrollTop>250-42){
                oDiv.style.top = scrollTop  + 'px';
            }
            if(scrollTop<250-42){
                oDiv.style.top = 250  + 'px';
            }
        }
    </script>
</c:if>