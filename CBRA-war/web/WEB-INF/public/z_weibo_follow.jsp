<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div id="divGuanzhu"  class="WeibaoFollow">
    <p><fmt:message key='PULIC_Z_WEIBOFOLLOW_关注' bundle='${bundle}'/></p>
<a href="http://e.weibo.com/yoopaycn" target="_blank" onclick="WeiBo.followUsWithSinaWB()"><img src="/images/weibo/xinlang32.png" alt="关注我们" width="32" height="32"/></a>
<a href="http://t.qq.com/yoopay" target="_blank" onclick="WeiBo.followUsWithTengxunWB()"><img src="/images/weibo/tengxun32.png" alt="关注我们" width="32" height="32"/></a>
    <%-- <a href="javascript:void(0)" target="_blank" onclick="WeiBo.followUsWhihRenrenWB()"><img src="/images/weibo/renren32.png" alt="关注我们" width="32" height="32"/></a>
    --%>
</div>
<script type="text/javascript"> 
    window.onscroll=function(){
        var oDiv = document.getElementById('divGuanzhu');
        var scrollTop = document.documentElement.scrollTop + document.body.scrollTop;//处理浏览器兼容问题
        if(scrollTop>92){
            oDiv.style.top = scrollTop  + 'px';
        }
        if(scrollTop<92){
            oDiv.style.top = 92  + 'px';
        }
    }
</script>