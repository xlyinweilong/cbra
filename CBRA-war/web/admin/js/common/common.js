function FormSave(fromId ,rules ,messages){
	var options = {
			submitHandler: function(form) {
				form.submit();
			},
			onfocusout: function(element) {
				if ( !this.checkable(element)) {
					this.element(element);
				}
			},
			errorPlacement: function(error, element) {
				var offsetY = 10;
				if(element.attr('type')=="select-one"){
					offsetY=26;
				}
				if (!error.is(':empty')) {
					element.poshytip('disable');
		            element.poshytip('destroy');
					element.poshytip({
						//className: 'tip-yellowsimple',
						className: 'tip-green',
						content: "<font color='red'><b>*</b></font>"+error.html(),
						showOn: 'focus',
						alignTo: 'target',
						alignY: 'inner-left',
						alignX: 'center',
						offsetX: 0,
						//offsetY: 5
						offsetY: offsetY
					});
				}else{
					element.poshytip('disable');
		            element.poshytip('destroy');
				}
				element.poshytip('show');
			},
			success: function(element) {
				element.poshytip('disable');
	            element.poshytip('destroy');
			}
	}
	options.rules= rules;
	options.messages=messages;
	$("#"+fromId).validate(options);
}

function FormClose(){
	parent.parent.$("#windown-close").click();
}

/**
 * 子复选框有一个处理非选中状态时，执行全选功能的复选框将置为非选中状态
 * @param subchkname
 * 子复选框的name
 * @param chkallid
 * 执行全选功能的复选框id
 */
$.fn.UnCheckAll = function (subchkname, chkallid) {
	$(":checkbox[name='" + subchkname + "']").click(function () {
		var l = $(":checkbox[name='" + subchkname + "'][disabled!='disabled']").length;
		if ($(this).attr("checked")!="checked") {
			$("#" + chkallid).attr("checked", false);
		} else {
			var i = 0;
			$(":checkbox[name='" + subchkname + "'][disabled!='disabled']").each(function () {
				if ($(this).attr("checked")=="checked") {
					i++;
				}
			});
			if (l == i) {
				$("#" + chkallid).attr("checked", "checked");
			}
		}
	});
};
/**
 * 点击选复选框时，执行全选/取消全选功能
 * @param chkallid
 * 执行全选功能的checkbox的id值
 */
$.fn.CheckAllClick = function (chkallid) {
	$("#" + chkallid).click(function () {
		var b = ($(this).attr("checked"));
		b= b=="checked" ? "checked" : false;
		$(":checkbox").each(function () {
			if( !$(this).attr("disabled") ){
				$(this).attr("checked", b);
			}
		});
	});
	if($(":checkbox[disabled!='disabled']").length == 1){
		$("#" + chkallid).attr("disabled","disabled");
	}
};































/**
 * 身份证验证
 */ 
$.validator.addMethod( "isIdcard", function(value, element){
	  var   aCity={11:"北京",12:"天津",13:"河北",14:"山西",15:"内蒙古",21:"辽宁",22:"吉林",23:"黑龙江",31:"上海",32:"江苏",33:"浙江",34:"安徽",35:"福建",36:"江西",37:"山东",41:"河南",42:"湖北",43:"湖南",44:"广东",45:"广西",46:"海南",50:"重庆",51:"四川",52:"贵州",53:"云南",54:"西藏",61:"陕西",62:"甘肃",63:"青海",64:"宁夏",65:"新疆",71:"台湾",81:"香港",82:"澳门",91:"国外"}
      var   iSum=0
      var   info="";
	  value=value.toUpperCase();
	  if(value == null || value ==""){
		  return true;
	  }
      if(!/(^\d{15}$)|(^\d{17}([0-9]|X)$)/.test(value)){
          return false;
      }else{
	      if(value.length==15){
		      value=converttonew(value);
		  }
          value=value.replace(/x$/i,"a");
          if(aCity[parseInt(value.substr(0,2))]==null){
              return false;
          }else{
             sBirthday=value.substr(6,4)+"-"+Number(value.substr(10,2))+"-"+Number(value.substr(12,2));
             var   d=new   Date(sBirthday.replace(/-/g,"/"))
             if(sBirthday!=(d.getFullYear()+"-"+   (d.getMonth()+1)   +   "-"   +   d.getDate())){
                 return false;
             }else{
                 for(var   i   =   17;i>=0;i   --)   iSum   +=   (Math.pow(2,i)   %   11)   *   parseInt(value.charAt(17   -   i),11)
                 if(iSum%11!=1){
                     return false;
                 }else{
                      return true;
                 }
             }
          }	 
	  }
 }, "身份证号码有误"); 
/**
 * 将15位身份证转换为18位
 */
function converttonew(x){
    var s="0",i,r;
    var id_w=new Array (0,2,4,8,5,10,9,7,3,6,1,2,4,8,5,10,9,7);
    var id_c=new Array ('1','0','X','9','8','7','6','5','4','3','2');
    s=x.substr(0,6);		//地区
    s+='19'+x.substr(6,6);	//年月日
    s+=x.substr(12,3);		//县内编码
    r=0;
    for (i=0;i<17;i++) r+=(s.charCodeAt(i)-48)*id_w[17-i];
        r=id_c[r % 11];
    return s+r;
}
$.validator.addMethod("isNotNegativeNum", function(value, element){
	  if(value != null && value != ""){
	   	var a = /^\d+$/.test(value);        //验证正数
	  	var b = /^\d+\.\d+$/.test(value);   //验证正小数
	  	if(!(a || b)){
	          return  false;
		}
	  }
	     return true;
	 },"请输入非负数");
$.validator.addMethod("isPositiveNum", function(value, element){
  if(value != null && value != ""){
   	var a = /^\d+$/.test(value);        //验证正数
  	if(!a){
          return  false;
	}
  }
     return true;
 },"请输入正整数");

/**
 * 验证文件类型
 */
$.validator.addMethod("filetype",function(value,element,param){
    var fileType = value.substring(value.lastIndexOf(".") + 1).toLowerCase(); 
    return this.optional(element) || $.inArray(fileType, param) != -1;
}, $.validator.format("文件类型错误"));

/**
 * 删除所有
 */
$.fn.delete_items = function(d_checkbox_name, d_url){
	/*
	var chknum = $(":checkbox[name='"+ d_checkbox_name +"']:'disabled'='disabled'").length ;
	if( chknum == 0 ){
		alert("暂无可操作的信息！");
		return false;
	}
	*/
	var chkchecknum = $(":checkbox[name='"+d_checkbox_name+"']:checked='checked'").length;
	if( chkchecknum == 0 ){
		alert("请选择要操作的信息！");
		return false;
	}
	if(confirm("确定要删除所选记录吗？")){
		document.forms[0].action = d_url;
		document.forms[0].submit();
	}
}