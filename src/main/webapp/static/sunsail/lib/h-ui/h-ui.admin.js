/*H-ui.admin.js v2.3.1 date:15:42 2015.08.19 by:guojunhui*/
/*获取顶部选项卡总长度*/
function tabNavallwidth(){
	var taballwidth=0,
		$tabNav = $(".acrossTab"),
		$tabNavWp = $(".Hui-tabNav-wp"),
		$tabNavitem = $(".acrossTab li"),
		$tabNavmore =$(".Hui-tabNav-more");
	if (!$tabNav[0]){return}
	$tabNavitem.each(function(index, element) {
        taballwidth+=Number(parseFloat($(this).width()+60))});
	$tabNav.width(taballwidth+25);
	var w = $tabNavWp.width();
	if(taballwidth+25>w){
		$tabNavmore.show()}
	else{
		$tabNavmore.hide();
		$tabNav.css({left:0})}
}

/*左侧菜单响应式*/
function Huiasidedisplay(){
	if($(window).width()>=768){
		$(".Hui-aside").show()
	} 
}

function getskincookie(){
	var v = getCookie("Huiskin");
	if(v==null||v==""){
		v="blue";
	}
	$("#skin").attr("href", "static/sunsail/skin/"+v+"/skin.css");
}

/*弹出层*/
/*
	参数解释：
	title	标题
	url		请求的url
	id		需要操作的数据id
	w		弹出层宽度（缺省调默认值）
	h		弹出层高度（缺省调默认值）
*/
function layer_show(title,url,w,h){
	if (title == null || title == '') {
		title=false;
	};
	if (url == null || url == '') {
		url="404.html";
	};
	if (w == null || w == '') {
		w=800;
	};
	if (h == null || h == '') {
		h=($(window).height() - 50);
	};
	var index =layer.open({
		type: 2,
		area: [w+'px', h +'px'],
		fix: false, //不固定
		maxmin: true,
		shade:0.4,
		title: title,
		content: url
	});
	
	/**
	 * 对分辨率是1024*768的进行特殊处理
	 */
	if(window.screen.width <= 1024){
		console.log($("#layui-layer-shade"+index).width());
		if(w>600){/*ipad  弹出窗大于600显示就不太正常*/
			$("#layui-layer"+index).width($("#layui-layer-shade"+index).width()-20);
			$("#layui-layer"+index).css("left",20/2);
		}
	}
	return index;
}

/*关闭弹出框口*/
function layer_close(){
	var index = parent.layer.getFrameIndex(window.name);
	parent.layer.close(index);
}

function min_titleList(){
	var topWindow=$(window.parent.document);
	var show_nav=topWindow.find("#min_title_list");
	var aLi=show_nav.find("li");
}

function creatIframe(href,titleName){
	var topWindow=$(window.parent.document);
	var show_nav=topWindow.find('#min_title_list');
	show_nav.find('li').removeClass("active");
	var iframe_box=topWindow.find('#iframe_box');
	
	var srciframeLen = top.$("#min_title_list li").length;
	srciframeLen = srciframeLen+1;
	/*show_nav.append('<li class="active"><span data-href="'+href+'">'+titleName+'</span><i></i><em></em></li>');*/
	show_nav.append('<li class="active" iframeIndex="'+srciframeLen+'"><span data-href="'+href+'">'+titleName+'</span><i></i><em></em></li>');
	tabNavallwidth();
	var iframeBox=iframe_box.find('.show_iframe');
	iframeBox.hide();
	//iframe上面再加一个div用于支持ipad滚动条的实现;
	//iframe_box.append('<div class="show_iframe"><div class="loading"></div><iframe frameborder="0" src='+href+'></iframe></div>');
	iframe_box.append('<div class="show_iframe"><div class="loading"></div><div class="overFlowIframe" id="overFlowIframe'+srciframeLen+'"><iframe frameborder="0" src='+href+'></iframe></div></div>');
	var showBox=iframe_box.find('.show_iframe:visible');
	showBox.find('iframe').attr("src",href).load(function(){
		showBox.find('.loading').hide();
	});
}

function creatIframeByPost(href,titleName,params){
	var topWindow=$(window.parent.document);
	var show_nav=topWindow.find('#min_title_list');
	show_nav.find('li').removeClass("active");
	var iframe_box=topWindow.find('#iframe_box');
	
	var srciframeLen = top.$("#min_title_list li").length;
	srciframeLen = srciframeLen+1;
	show_nav.append('<li class="active" iframeIndex="'+srciframeLen+'"><span data-href="'+href+'">'+titleName+'</span><i></i><em></em></li>');
	tabNavallwidth();
	var iframeBox=iframe_box.find('.show_iframe');
	iframeBox.hide();
	var iframeName = "iframeId"+new Date().getTime();
	iframe_box.append('<div class="show_iframe"><div class="loading"></div><div class="overFlowIframe" id="overFlowIframe'+srciframeLen+'"><iframe frameborder="0" name='+iframeName+'></iframe></div></div>');
	var showBox=iframe_box.find('.show_iframe:visible');
	
	post(href, params, "post",iframeName);
}

function post(path, params, method, iframeId) {
    method = method || "post"; // Set method to post by default if not specified.

    // The rest of this code assumes you are not using a library.
    // It can be made less wordy if you use one.
    var form = document.createElement("form");
    form.setAttribute("method", method);
    form.setAttribute("action", path);
    form.setAttribute("target",iframeId);

    for(var key in params) {
        if(params.hasOwnProperty(key)) {
            var hiddenField = document.createElement("input");
            hiddenField.setAttribute("type", "hidden");
            hiddenField.setAttribute("name", key);
            hiddenField.setAttribute("value", params[key]);

            form.appendChild(hiddenField);
         }
    }

    document.body.appendChild(form);
    form.submit();
    form.remove();
}

$(function(){
	//getskincookie();
	//layer.config({extend: 'extend/layer.ext.js'});
	Huiasidedisplay();
	var resizeID;
	$(window).resize(function(){
		clearTimeout(resizeID);
		resizeID = setTimeout(function(){
			Huiasidedisplay();
		},500);
	});
	
	$(".Hui-nav-toggle").click(function(){
		$(".Hui-aside").slideToggle();
	});
	$(".Hui-aside").on("click",".menu_dropdown dd li a",function(){
		if($(window).width()<768){
			$(".Hui-aside").slideToggle();
		}
	});
	/*左侧菜单*/
	$.Huifold(".menu_dropdown dl dt",".menu_dropdown dl dd","fast",3,"click");
	
	/*选项卡导航*/
	$(".Hui-aside").on("click",".menu_dropdown a",function(){
		if($(this).attr('_href')){
			var bStop=false;
			var bStopIndex=0;
			var _href=$(this).attr('_href');
			var _titleName=$(this).html();
			var topWindow=$(window.parent.document);
			var show_navLi=topWindow.find("#min_title_list li");
			show_navLi.each(function() {
				if($(this).find('span').attr("data-href")==_href){
					bStop=true;
					bStopIndex=show_navLi.index($(this));
					return false;
				}
			});
			if(!bStop){
				creatIframe(_href,_titleName);
				min_titleList();
			}
			else{
				show_navLi.removeClass("active").eq(bStopIndex).addClass("active");
				var iframe_box=topWindow.find("#iframe_box");
				iframe_box.find(".show_iframe").hide().eq(bStopIndex).show().find("iframe").attr("src",_href);
			}
		}
	});
	var num=0;
	var oUl=$("#min_title_list");
	var hide_nav=$("#Hui-tabNav");
	$(document).on("click","#min_title_list li",function(){
		var bStopIndex=$(this).index();
		var iframe_box=$("#iframe_box");
		$("#min_title_list li").removeClass("active").eq(bStopIndex).addClass("active");
		iframe_box.find(".show_iframe").hide().eq(bStopIndex).show();
	});
	$(document).on("click","#min_title_list li i",function(){
		var aCloseIndex=$(this).parents("li").index();
		$(this).parent().remove();
		$('#iframe_box').find('.show_iframe').eq(aCloseIndex).remove();	
		num==0?num=0:num--;
		tabNavallwidth();
	});
	$(document).on("dblclick","#min_title_list li",function(){
		var aCloseIndex=$(this).index();
		var iframe_box=$("#iframe_box");
		if(aCloseIndex>0){
			$(this).remove();
			$('#iframe_box').find('.show_iframe').eq(aCloseIndex).remove();	
			num==0?num=0:num--;
			$("#min_title_list li").removeClass("active").eq(aCloseIndex-1).addClass("active");
			iframe_box.find(".show_iframe").hide().eq(aCloseIndex-1).show();
			tabNavallwidth();
		}else{
			return false;
		}
	});
	tabNavallwidth();
	
	$('#js-tabNav-next').click(function(){
		num==oUl.find('li').length-1?num=oUl.find('li').length-1:num++;
		toNavPos();
	});
	$('#js-tabNav-prev').click(function(){
		num==0?num=0:num--;
		toNavPos();
	});
	
	function toNavPos(){
		oUl.stop().animate({'left':-num*100},100);
	}
	
	/*换肤*/
	$("#Hui-skin .dropDown-menu a").click(function(){
		var v = $(this).attr("data-val");
		setCookie("Huiskin", v);
		$("#skin").attr("href", "static/sunsail/skin/"+v+"/skin.css");
	});
	
});

/*
 * 添加tab方法
 * @param title 标题
 * @param url 页面url
 * @param parameter 参数
 */
 function addTabs(title,url){
     var bStop=false;
	 var bStopIndex=0;
	 var _href=url;
	 var _titleName=title;
	 var topWindow=$(window.parent.document);
	 var show_navLi=topWindow.find("#min_title_list li");
	 show_navLi.each(function() {
	     if($(this).find('span').attr("data-href")==_href){
		     bStop=true;
		     bStopIndex=show_navLi.index($(this));
			 return false;
			}
	 });
	 if(!bStop){
		 window.parent.creatIframe(_href,_titleName);
	     min_titleList();
	 }else{
	     show_navLi.removeClass("active").eq(bStopIndex).addClass("active");
	     var iframe_box=topWindow.find("#iframe_box");
	     iframe_box.find(".show_iframe").hide().eq(bStopIndex).show().find("iframe").attr("src",_href);
	}
 }
 
 function addTabsByPost(title,url,params){
     var bStop=false;
	 var bStopIndex=0;
	 var _href=url;
	 var _titleName=title;
	 var topWindow=$(window.parent.document);
	 var show_navLi=topWindow.find("#min_title_list li");
	 show_navLi.each(function() {
	     if($(this).find('span').attr("data-href")==_href){
		     bStop=true;
		     bStopIndex=show_navLi.index($(this));
			 return false;
			}
	 });
	 if(!bStop){
		 window.parent.creatIframeByPost(_href,_titleName,params);
	     min_titleList();
	 }else{
	     show_navLi.removeClass("active").eq(bStopIndex).addClass("active");
	     var iframe_box=topWindow.find("#iframe_box");
	     var iframeName = iframe_box.find(".show_iframe").eq(bStopIndex).find("iframe").attr("name");
	     
	     if(typeof(iframeName) == 'undefined' || iframeName == ""){
	    	 iframeName = "iframeId"+new Date().getTime();
	    	 iframe_box.find(".show_iframe").eq(bStopIndex).find("iframe").attr("name",iframeName);
	     }
	     post(url, params, "post",iframeName);
	     iframe_box.find(".show_iframe").hide().eq(bStopIndex).show();
	}
 }
