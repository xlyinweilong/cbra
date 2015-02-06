function $$(o){if(document.getElementById&&document.getElementById(o)){return document.getElementById(o);}else if (document.all&&document.all(o)){return document.all(o);}else if (document.layers&&document.layers[o]){return document.layers[o];}else{return false;}} 
function setCls(o,c,f){if(!o)return;var oc=o.className=o.className.replace(new RegExp('( ?|^)'+c+'\\b'),'');if(!f)o.className=oc.length>0?(oc+' '+c):c}
function $Bind(A,B){var C=Array.prototype.slice.call(arguments).slice(2);return function(){return B.apply(A,C.concat(Array.prototype.slice.call(arguments)))}}
function CurrentStyle(A){return A.currentStyle||document.defaultView.getComputedStyle(A,null)}


function inittab(o,t,n,e,c){
	var tab = $('#'+o).get(0);
	if(!tab || tab.isinit) return ;
	tab.isinit = true;
	var ul = $('#'+ o + '-body').get(0);
	if(!tab || !ul)return;
	var tabs = tab.getElementsByTagName(t||'li');
	if(!tabs || tabs.length == 0)return;
	tab = tabs[0].parentNode;
	tab.uls = [];
	if(n && n.indexOf('.') > 0){
		var t = n.split('.');
		var els = ul.getElementsByTagName(t[0]);
		for(var i=0,len=els.length;i<len;i++){
			if(els[i].className.split(' ').indexOf(t[1]) >= 0) tab.uls.push(els[i]);
		}
	}else{
		n = n || 'ul';
		for(var i=0,len=ul.childNodes.length;i<len;i++){
			if(ul.childNodes[i].tagName && ul.childNodes[i].tagName.toLowerCase() == n) tab.uls.push(ul.childNodes[i]);
		}
	}
	if(!tab.uls)return;
	var cls=c||'act';
	e = e ? e : 'onmouseover';
	tab.lis = tabs;
	for(var i=0;i<tabs.length;i++){
		tabs[i].i=i;
		if(i > 0 && tab.uls[i]) tab.uls[i].style.display = 'none';
		tabs[i][e] = function(){
			var u = this.parentNode;
			var idx = u.act ? u.act : 0;
			$(u.lis[idx]).removeClass(cls);
			if(u.uls[idx])u.uls[idx].style.display = 'none';
			u.act = this.i;
			$(this).addClass(cls);
			if(u.uls[this.i])u.uls[this.i].style.display = '';
		}
	}
}


function Silder(cfg){
	cfg = cfg || {el:''};
	if(!cfg.el) return;
	this.el = $(cfg.el);
	if(!this.el.length) return ;
	this.autorun = cfg.autorun ===false ? false : true;
	this.delay = cfg.delay || 3000;
	this.imgs = this.el.children('.slider-bd:first');
	this.imgs_width = this.imgs.width();
	this.imgs = this.imgs.children('ul:first').addClass('slider-ul');
	var li = this.imgs.children('li').width(this.imgs_width);
	if(li.height()) this.imgs.parent().height(li.height());
	this.length = li.addClass('slider-li').length;
	li.children('.img').removeClass('img').addClass('slider-img');
	$('<span class="slider-mask"></span>').appendTo(this.el);
	if(this.length < 2) return;
	var em = '';
	for(var i=0;i<this.length;i++) em += '<em></em>';
	this.switcher = $('<span class="slider-switch">'+em+'</span>').appendTo(this.el);
	this.switcher = this.switcher.children('em');
	this.switcher.filter(':eq(0)').addClass('act')
	var tthis = this;
	this.switcher.mouseover(function(){tthis.run(tthis.switcher.index(this))});
	this.index = 0;
	this.overstart = cfg.overstart;
	if(this.overstart){
		this.imgs.hover(function(){this.isover=true;tthis.auto()}, function(){this.isover=false;tthis.stop()});
	}else{
		this.auto();	
	}
	this.overstop = cfg.overstop === false ? false : true;
	if(this.overstop){
		this.imgs.hover(function(){tthis.stop()}, function(){tthis.auto()});
	}
}

Silder.prototype={
	run:function(index){
		if(this.timer) window.clearTimeout(this.timer);
		index = index || 0;
		if(index == this.length) index = 0;
		if(this.index == index) return;
		var cls = 'act';
		this.switcher.filter(':eq('+this.index+')').removeClass(cls);
		this.index = index;
		this.switcher.filter(':eq('+index+')').addClass(cls);
		var l = this.imgs_width * index;
		this.imgs.stop().animate({left:-l});
		this.auto();
	},
	auto:function(){
		if(this.overstart && !this.isover) return ;
		if(this.autorun){
			var tthis = this;
			this.timer = window.setTimeout(function(){tthis.run(tthis.index+1)}, this.delay);
		}
	},
	stop:function(){
		if(this.timer) window.clearTimeout(this.timer);	
	}
};

// 导航菜单
var page_nav;
function M(el, id){
	el = $(el);
	var menu = el.data('menu');
	function showmenu(A,B,C){
		var cls = 'nav-txt-over';
		if(!page_nav){
			page_nav = A.parent().parent().find('a.nav-txt-act:first');
		}
		if(C){
			A.removeClass(cls);	
			B.hide();
			page_nav.addClass('nav-txt-act');
		}else{
			A.addClass(cls);
			B.show();
			page_nav.removeClass('nav-txt-act');
		}
	}
	
	if(!el.data('inited')){
		el.data('inited', true);
		menu = $('#HJ_Menu_' + id);
		if(menu.length){
			menu.insertAfter(el);
			el.data('menu', menu);
			el.on('mouseout', function(){
				showmenu(el,menu,true);
			});
			menu.hover(function(){
				showmenu(el,menu);
			}, function(){
				showmenu(el,menu,true);
			});
			showmenu(el,menu);
		}
		return ;
	}
	if(menu){
		showmenu(el,menu);
	}
}

function getContentInfo(A,B){
	$.get(B,{contentid:A},function(rs){
		if(rs.click){
			$('#content_click').text(rs.click).parent().show();
		}
	},'json');
}

$(function(){
	var N = $('#navItemValue');
	if(N.length){
		$('#nav_item_' + N.attr('value')).children('a:first').addClass('nav-txt-act');
	}
	
	new Silder({el:'#sliderHome',overstart:false});
	new Silder({el:'#sliderEl'});
});


function rendererVA(){
	var lis = $('#visionArticle').children('li');
	var s1 = '【', s2 = '】'
	var txt, ctxt, ctxt1, p;
	for(var i=0,len=lis.length;i<len;i++){
		var el = $(lis.get(i));
		txt = el.text();
		p = txt.indexOf(s2)
		if(p > 0){
			ctxt1 = txt.substr(1, p-1);
			if(ctxt1 != ctxt){
				ctxt = ctxt1;
				el.prepend('<br><strong class="th">' + ctxt + '</strong><br>');
			}
			el.children('a:first').text(txt.substr(p+1, txt.length));
		}else{
			el.prepend('<br>');
		}
	}
}

function setVisionPager(){
	var ct = $('#visionList');
	var el = ct.children('ul');
	var len = el.length;
	var pager = $('<div class="vision-list-pager"></div>');
	pager.appendTo(ct.parent());
	var prev = $('<a href="" class="prev"></a>');
	prev.appendTo(pager);
	var txt = $('<span>1 / '+len+'</span>');
	txt.appendTo(pager);
	var next = $('<a href="" class="next"></a>');
	next.appendTo(pager);
	var c = 1;
	var w = ct.parent().width();
	prev.click(function(e){
		e.preventDefault();
		if(c > 1){
			c--;
			ct.animate({marginLeft:-(c-1)*w});	
			txt.text(c+' / '+len);
		}
	});
	next.click(function(e){
		e.preventDefault();
		if(c <len){
			c++;
			ct.animate({marginLeft:-(c-1)*w});	
			txt.text(c+' / '+len);
		}
	});
}


function showWeixinMenu(A,B,Z){
	var el = $(A);
	var inited = el.data('inited');
	var menu = Z ?  $('#xiaobing'): $('#WeixinMenu');
	var cls = 'ico-weixin-act';
	if(Z) menu.css('right',0);
	if(!inited){
		el.data('inited', true);
		menu.mouseover(function(){
				if(A.timer) window.clearTimeout(A.timer);
				menu.show();
				el.addClass(cls);
			})
		.mouseout(function(){
			if(A.timer) window.clearTimeout(A.timer);
			A.timer = window.setTimeout(function(){menu.hide();el.removeClass(cls);},100);
			
		});
	}
	if(A.timer) window.clearTimeout(A.timer);
	if(!B){
		A.timer = window.setTimeout(function(){menu.hide();el.removeClass(cls);},100);
		return ;
	}
	menu.show();
	el.addClass(cls);
}

/**
 * 图文图片播放器
 * @param config
 */
var SliderPlayer = function(config){
	this.body = $('#'+config.body).get(0);
	if(!this.body) return;
	this.loading = $('#'+config.loadEl).get(0);
	this.init();
};
SliderPlayer.prototype = {
	index:0,
	init:function(){
		this.items = this.body.getElementsByTagName('li');
		this.total = this.items.length;
		this.img = document.createElement('img');
		var tthis = this;
		this.img.onload = function(){setCls(tthis.loading, 'loading',true)};
		this.items[0].parentNode.parentNode.appendChild(this.img);
		if(this.total > 1){
			var s = document.createElement('span');
			s.innerHTML = '<a class="gallery-prev" target="_self" hidefocus="true" href="javascript:;"></a><a class="gallery-next" target="_self" hidefocus="true" href="javascript:;"></a>'
			s.className = 'gallery-control';
			var tthis = this;
			var p = this.items[0].parentNode;
			p.parentNode.insertBefore(s, p);
			s.firstChild.onclick = $Bind(this, this.prev);
			s.lastChild.onclick = $Bind(this, this.next);
		}
		this.renderSwitcher();
		setCls(tthis.loading, 'loading',true);
	},
	renderSwitcher:function(){
		var sets = document.createElement('div'), p = this.body.parentNode, img, li, html='';
		sets.className = 'pt-switcher';
		sets.innerHTML = '<a href="javascript:;" class="prev"></a><div class="pt-list"><ul></ul></div><a href="javascript:;" class="next"></a>';
		this.body.nextSibling ? p.insertBefore(sets, this.body.nextSibling) : p.appendChild(sets);
		this.listct = sets.childNodes[1].childNodes[0];
		this._w = sets.childNodes[1].offsetWidth;
		this._fw = 0;
		var _w = parseInt(this._w / 2);
		for(var i=0;i<this.total;i++){
			img = this.items[i].getElementsByTagName('img')[0];
			this.items[i].src = this.items[i].getElementsByTagName('a')[0].href;
			li = document.createElement('li');
			li.index = i;
			li.innerHTML = '<span><a href="javascript:;"><img src="'+img.src+'" /></a><em><font>'+(i+1)+'</font></em></span>';
			this.listct.appendChild(li);
			li.target = _w - this._fw - parseInt(li.offsetWidth / 2);
			if(li.target > 0) li.target = 0;
			this._fw += li.offsetWidth;
		}
		this.run(0);
		var tthis = this;
		this.listct.onclick = $Bind(this, this.onSwicherEvent);
		if(this.total && this._fw > this._w){
			var a = sets.getElementsByTagName('a');
			sets.firstChild.onmousedown = function(){tthis.srollto='left';tthis.sroll()}
			sets.lastChild.onmousedown = function(){tthis.srollto='right';tthis.sroll()}
			sets.firstChild.onmouseup = sets.lastChild.onmouseup = function(){tthis.srollto=false}
		}
	},
	onSwicherEvent:function(e){
		e = window.event ? window.event.srcElement : e.target;
		if(e.tagName.toLowerCase()=='img'){
			var index = parseInt(e.parentNode.parentNode.parentNode.index);
			this.run(index);
		}
	},
	run: function(index) {
		setCls(this.loading, 'loading');
		if(this.timer) clearTimeout(this.timer);
		index = index || 0;
		index < 0 && (index = this.total - 1) || index >= this.total && (index = 0);
		setCls(this.listct.childNodes[this.index], 'current' ,1);
		this.listct.childNodes[this.index].childNodes[0].lastChild.firstChild.innerHTML = this.index + 1;
		this.img.src = this.items[index].src;
		setCls(this.listct.childNodes[index], 'current');
		this.listct.childNodes[index].childNodes[0].lastChild.firstChild.innerHTML = index + 1 + '/' + this.total;
		this.index = index;
		this.move();
		if(this.auto) this.timer = setTimeout($Bind(this, this.next), this.pause||3000);
	},
	prev: function(){this.run(this.index-1)},
	next: function(){this.run(this.index+1)},
	move:function(){
		if(this.listct.timer) clearTimeout(this.listct.timer);
		var B=this.listct, A=B.childNodes[this.index].target, C=parseInt(CurrentStyle(B)['marginLeft'])||0;
		if(A==C)return;
		var D=C<A?1:-1, E=D*(A-C), F=Math.ceil(E/3);
		C+=D*F;
		if((C+this._fw) < this._w) C = this._w - this._fw;
		if(C > 0) C = 0;
		this.listct.style.marginLeft = C + 'px';
		this.listct.timer = setTimeout($Bind(this, this.move), 10);
	},
	srollpx:30,
	_srollpx:30,
	sroll:function(){
		if(this.listct.timer) clearTimeout(this.listct.timer);
		if(!this.srollto){this._srollpx = this.srollpx;return}
		var l = parseInt(CurrentStyle(this.listct)['marginLeft']);
		if(isNaN(l)) l = 0;
		if((l == 0 && this.srollto == 'left') || (this.srollto == 'right' && this._fw && l == (this._w - this._fw))) return;
		l += this.srollto == 'right' ? -this._srollpx : this._srollpx;
		if(l > 0) l = 0;
		else if((l + this._fw) < this._w) l = this._w - this._fw;
		this.listct.style.marginLeft = l + 'px';
		this._srollpx = 10;
		this.listct.timer = setTimeout($Bind(this, this.sroll), 15);
	}
};

/**
 * 画廊控件
 * @param config
 */
var Gallery = function(config){
	this.body = $$(config.body);
	if(!this.body) return ;
	this.img = this.body.getElementsByTagName('img')[0];
	this.img.parentNode.insertBefore(document.createElement('i'), this.img);
	this.img.alt = '';
	this.at = $$(config.at);
	this.desc = $$(config.descEl);
	this.sets = $$(config.setEl);
	this.loading = $$(config.loadEl);
	this.items = this.sets.getElementsByTagName('li');
	this.total = this.items.length;
	var tthis = this;
	this._slider = this.items[0].parentNode;
	this.img.onload = function(){setCls(tthis.loading, 'loading',true)};
	if(this.total){
		var s = document.createElement('span');
		s.innerHTML = '<a class="gallery-prev" target="_self" hidefocus="true" href="javascript:;"></a><a class="gallery-next" target="_self" hidefocus="true" href="javascript:;"></a>'
		s.className = 'gallery-control';
		this.body.insertBefore(s, this.body.firstChild);
		s.firstChild.onclick = function(){tthis.prev()}
		s.lastChild.onclick = function(){tthis.next()}
	}
	this._w = this._slider.parentNode.offsetWidth;
	this._w2 = this._w / 2;
	for (var i=0;i<this.total;i++) this.items[i].index = i;
	this._slider.onclick = function(e){
		e = window.event ? window.event.srcElement : e.target;
		var n = e.tagName.toLowerCase(), index;
		if(n == 'img') index = e.parentNode.parentNode.index;
		else if(n == 'a') index = e.parentNode.index;
		else if(n == 'li') index = e.index;
		if(index != undefined) tthis.run(index);
	}
	this.countFullWidh();
	var index = location.href.indexOf('#I=');
	if (index) {
		index = location.href.substring(index + 3, location.href.length)
		if(!isNaN(index)) this.run(index - 1);
	}
	if(this.total && this._fw > this._w){
		var a = this.sets.getElementsByTagName('a');
		a[0].onmousedown = function(){tthis.srollto='right';tthis.sroll()}
		a[1].onmousedown = function(){tthis.srollto='left';tthis.sroll()}
		a[0].onmouseup = a[1].onmouseup = function(){tthis.srollto=false}
	}
	setCls(tthis.loading, 'loading',true);
};
Gallery.prototype = {
	_timer : null, //定时器
	index : 0, // 当前索引,
	change: 0,
	time: 1,
	srollpx:30,
	_srollpx:30,
	run: function(index) {
		//修正index
		setCls(this.loading, 'loading');
		index == undefined && (index = this.index);
		index < 0 && (index = this.total - 1) || index >= this.total && (index = 0);
		this.index = index;
		setCls(this.items[this.c_index||0], 'current' ,1);
		if(!this.items[this.index].src){
			var img = this.items[this.index].getElementsByTagName('img')[0];
			this.items[this.index].src = img.attributes['dataSrc'] && img.attributes['dataSrc'].value ? img.attributes['dataSrc'].value : img.src;
			this.items[this.index].desc = img.alt || '';
			var w  = 0, i = this.index - 1;
			while(i >= 0){
				w += this.items[i].offsetWidth + 6;
				i--;
			}
			w += this.items[this.index].offsetWidth / 2 + 3;
			if(w > this._w2) w -= this._w2; else w = 0;
			if((this._fw - w) < this._w) w = this._fw - this._w;
			if(w < 0) w = 0;
			this.items[this.index]._target = -parseInt(w);
		}
		this.img.src = this.items[this.index].src;
		this.desc.innerHTML = this.items[this.index].desc;
		this.c_index = this.index;
		if(this.at) this.at.innerHTML = this.index + 1;
		this._target = this.items[this.index]._target;
		setCls(this.items[this.index], 'current');
		this.move();
	},
	countFullWidh:function(){
		this._fw = 0;
		var w;
		for (var i = 0; i < this.total; i++) {
			w = this.items[i].offsetWidth;
			if(w < 3){
				w = 100;
				this.items[i].getElementsByTagName('a')[0].style.width = w + 'px';	
			}
			this._fw  += w + 6;
		}
	},
	move: function() {
		var A=this._target, B=this._slider, C=parseInt(CurrentStyle(B)['left'])||0;
		if(this._timer) clearTimeout(this._timer);
		if(A==C){this.auto && (this._timer = setTimeout($Bind(this, this.next), this.pause||3000));return}
		var D=C<A?1:-1, E=D*(A-C), F=Math.ceil(E/3);
		C+=D*F;
		this.moveto(C);
		var tthis = this;
		this._timer = setTimeout(function(){tthis.move()}, 10);
	},
	moveto: function(i){this._slider.style['left']=i+'px'},
	prev: function(){this.run(--this.index)},
	next: function(){this.run(++this.index)},
	sroll:function(){
		if (!this.srollto){this._srollpx = this.srollpx;return}
		var l = parseInt(CurrentStyle(this._slider)['left']);
		if(isNaN(l)) l = 0;
		if((l == 0 && this.srollto == 'left') || (this.srollto == 'right' && this._fw && l == (this._w - this._fw))) return;
		l += this.srollto == 'right' ? -this._srollpx : this._srollpx;
		if(l > 0) l = 0;
		else if((l + this._fw) < this._w) l = this._w - this._fw;
		this.moveto(l);
		this._srollpx = 10;
		this._timer = setTimeout($Bind(this, this.sroll), 15);
	},
	stop:function(){clearTimeout(this._timer);this.moveto(this._target)}
};
