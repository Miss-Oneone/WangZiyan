/******************************************************************************
 * 功能描述: 返回浏览器Body区域的高度
 * 参数　　: 无
 * 返回值　: 高度
 ******************************************************************************/
function getBodyHeight() {
	var bodyHeight = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
	return bodyHeight;
}

/******************************************************************************
 * 功能描述: 计算表格可设置的高度
 * 参数　　: 无
 * 返回值　: 高度
 ******************************************************************************/
function calcTableHeight() {
	var defaultOffset = 82;
	var panelHeight = 0;
	if ($(".panel").length > 0) {
		panelHeight = $(".panel").offset().top + $(".panel").height();
	}
	if ($(".panel_show").length > 0) {
		if (panelHeight == 0) {
			panelHeight = $(".panel").offset().top + $(".panel").height();
		} else {
			panelHeight += $(".panel_show").height();
		}
	}
	return getBodyHeight() - defaultOffset - panelHeight;
}

/******************************************************************************
 * 功能描述: 计算内容区域高度
 * 参数　　: 无
 * 返回值　: 高度
 ******************************************************************************/
function getWindowHeight() {
	var offset = 118;
	if (parent && parent.window) {
		return $(parent.window).height() - offset;
	} else {
		return $(window).height() - offset;
	}
}

/******************************************************************************
 * 功能描述: 计算表格可设置的高度
 * 参数　　: 无
 * 返回值　: 高度
 ******************************************************************************/
var myFormSearchHeight;

function calcDatatableHeight() {

	var tableHeight = getWindowHeight() - $(".nav-tabs").height() - 90;

	if ($(".oms-fieldset").length > 0) {
		tableHeight -= $(".oms-fieldset").closest("div").height();
	} else {
		tableHeight -= $(".form-search").height();
	}

	if ($("tfoot").length > 0) {
		tableHeight = tableHeight - 35;
	}
	if ($("#messageBox").height() != null) {
		tableHeight = tableHeight - 44;
	}

	return tableHeight;
}

/******************************************************************************
 * 功能描述: 设置页面不能点击
 * 参数　　: bShow 是否显示
 * 返回值　: 无
 ******************************************************************************/
function setPageDisabled(bShow) {
	if(bShow) {
		//top.$.jBox.tip("<h1>页面不能点击了！！！！</h1>");
		$("#fullbg").show();
	}else {
		//top.$.jBox.tip("<h1>随便点击！！！！！！！！！！</h1>");
		$("#fullbg").hide();
	}
}

$(document).ready(function() {
	
	jQuery.fn.dataTable.defaults.bLengthChange = false;
	jQuery.fn.dataTable.defaults.bFilter = false;
	jQuery.fn.dataTable.defaults.oLanguage.sUrl = ctxStatic + "/datatables/language/zh_CN.txt";
	jQuery.fn.dataTable.defaults.sPaginationType = "full_numbers";
	jQuery.fn.dataTable.defaults.sScrollYInner = "";
	jQuery.fn.dataTable.defaults.sScrollY = calcDatatableHeight();
	jQuery.fn.dataTable.defaults.sScrollX = "100%";
	jQuery.fn.dataTable.defaults.sScrollXInner = "110%";
	jQuery.fn.dataTable.defaults.aaSorting = [];
	jQuery.fn.dataTable.defaults.iDisplayLength = 100;
	jQuery.fn.dataTable.defaults.aLengthMenu = pageSizeStr.split(",");
	jQuery.fn.dataTable.defaults.bLengthChange = true;
	myFormSearchHeight = $(".form-search").outerHeight(true); //记录条件部高度
	jQuery.fn.dataTable.defaults.fnInitComplete = function() { //表格生成后
		
		myFormSearchHeight = $(".form-search").outerHeight(true); //记录条件部高度
		insertDatatablesBtnDiv(); //插入按钮事件
	};
	jQuery.fn.dataTable.defaults.fnCreatedRow = function( nRow, aData, iDataIndex , iStart){ //生成行后
    	$('th:eq(0)',nRow).html(iStart + iDataIndex + 1);
    };

	$(parent.window).bind('resize', function () {
		if (window) {
			$("#navTab iframe", window.parent.document).each(function() {
				$(this).height(getWindowHeight());
			});
		}
		$(".dataTables_scrollBody").height(calcDatatableHeight());
		$(".dataTables_scrollBody").each(function() {
			initDatatablesHead($(this).children("table").first().attr("id"));
		});
		if (typeof(resizeTable) != "undefined") {
			resizeTable();
		}
		if (typeof(resizeTree) != "undefined") {
			resizeTree();
		}
	});

	//为遮罩层添加高度和宽度
	$("#fullbg").width($(document).width()).height(getWindowHeight() - 20);
	
	//为条件部添加隐藏功能span
	//createSearchCondition();
	createSelectCondition();
	createMyConditionList();
	//实现input的div的tabs
	setInputDivTabs();
	
	$("#messageBox .close").click(function() {
		setTimeout(function() {$(".dataTables_scrollBody").height(calcDatatableHeight());}, 100);
	});
});

$(document).keydown(function(e) {
	disableBackSpaceKey(e);
});

$($("iframe", window.parent.document).contents()).keydown(function(e) {
	disableBackSpaceKey(e);
});

function disableBackSpaceKey(e) {
	var eventObj = e || event;
	var eventTarget = eventObj.srcElement || eventObj.target;
	if (eventObj.keyCode == 8) {
		if (((eventTarget.tagName.toUpperCase()=="INPUT" && eventTarget.getAttribute("type")) &&
            (eventTarget.getAttribute("type").toUpperCase() == "TEXT" || eventTarget.getAttribute("type").toUpperCase() == "FILE" || eventTarget.getAttribute("type").toUpperCase() == "PASSWORD") ||
               (eventTarget.tagName.toUpperCase()=="TEXTAREA")) && !eventTarget.disabled && !eventTarget.readOnly) {
			return true;
		} else {
			try {
				eventObj.preventDefault();
				return false;
			} catch(e) {
				eventObj.returnValue = false;
			}
		}
	}
}

//绑定隐藏条件部按钮事件
$(document).delegate("#flip","click", function(){
	if($(".panel").css("display") != "none") {
		$(".panel").hide("normal", function(){
			$("#flip").attr("class","icon-chevron-down");
			var divHeight = $(".dataTables_scrollBody").height() + $(".panel").height();
			var divWidth = $(".dataTables_scrollBody").width();
			$(".dataTables_scrollBody").animate({height:divHeight + "px",width:divWidth+"px"},"normal");
		});
	}else {
		$("#flip").attr("class","icon-chevron-up");
		var divHeight = $(".dataTables_scrollBody").height() - $(".panel").height();
		var divWidth = $(".dataTables_scrollBody").width();
		$(".dataTables_scrollBody").animate({height:divHeight + "px",width:divWidth+"px"},"normal", function(){
			$(".panel").show("normal");
		});
	}
});

//绑定head的checkbox选中事件
$(document).delegate(".dataTables_scrollHead input[type='checkbox']:eq(0)","click", function(e){
	
	if($(this).prop("checked")) {
		$(this).closest(".dataTables_scroll").find(".dataTables_scrollBody tr").addClass("selected");
	}else {
		$(this).closest(".dataTables_scroll").find(".dataTables_scrollBody tr").removeClass("selected");
	}
	countCheckedNum($(this));
});

//绑定body的checkbox选中显示条数的事件
$(document).delegate(".dataTables_scrollBody input[type='checkbox']","click", function(e){
	
	//获取选中count
	countCheckedNum($(this));
	
	if($(this).prop("checked")) {
		$(this).closest("tr").addClass("selected");
	}else {
		$(this).closest("tr").removeClass("selected");
	}
	
	//阻止事件冒泡
	e.stopPropagation();
});

//绑定行选中事件
$(document).delegate(".dataTables_scrollBody tbody tr","click", function(){
	
	//清除其他行样式
	$(".dataTables_scrollBody tbody tr").each(function(){
		$(this).removeClass("selected");
		$(this).find("input[type='checkbox']").prop("checked",false);
	})
	
	//添加选中行样式
	$(this).addClass("selected");
	$(this).find("input[type='checkbox']").prop("checked",true);
	
	if($(this).find("input[type='checkbox']").length > 0) {
		countCheckedNum($(this).find("input[type='checkbox']"));
	}
});

//计算选中个数
function countCheckedNum(obj) {
	
	var count = $(obj).closest(".dataTables_scroll").find(".dataTables_scrollBody input[type='checkbox']:checked").map(function(){
		return 1;
	}).length;

	//设置div id值,用来区别不同的table
	var idStr = $(obj).closest(".dataTables_wrapper").attr("id");
	
	//显示选中几条
	if($("#checkedCount_" + idStr).length > 0) {
		$("#checkedCount_" + idStr).html("当前选中 " + count + " 条");
	}else {
		var htmlStr = '<div id="checkedCount_' + idStr + '" style="float: left;margin-top: 5px;margin-left: 30px;">当前选中 ' + count + ' 条</div>';
		$(obj).closest(".dataTables_wrapper").find(".dataTables_length").before(htmlStr);
	}
}

//向表格中插入供放置按钮的div
function insertDatatablesBtnDiv() {
	
	$(".dataTables_pageDiv").each(function(){
		var divHtml = "<div class='dataTables_btnDiv'></div>";
		$(this).find(".dataTables_info").after(divHtml);
		addDataTablesBtn($(this).closest(".dataTables_wrapper").attr("id").replace("_wrapper",""), $(this).find(".dataTables_btnDiv"));
	});
}

function addDataTablesBtn(tableId, btnObj) {

	$(btnObj).prepend($("#" + tableId + "Button").children());

	$(".oms-button").hover(function() {
		$(this).addClass("oms-button-hover");
	}, function(){
		$(this).removeClass("oms-button-hover");
	});
}

function initDatatablesHead(idStr) {
	
	$("#" + idStr + "_wrapper").find(".dataTables_scrollBody").each(function(){
		
		//重新计算标题宽度
		var headObj = $(this).closest(".dataTables_scroll").find(".dataTables_scrollHead table");
		$(headObj).width($(this)[0].scrollWidth);

		//重新计算各列宽度
		var bodyObj = $(this).closest(".dataTables_scroll").find(".dataTables_scrollBody tbody tr:eq(0)");
		$(bodyObj).children().each(function(i) {

			if(!$(this).is("th")) {
				$(headObj).find("tr:eq(0)").children().eq(i).width($(this).width());
			}
		})
	});
	
}

//插入条件部 隐藏span
function createSearchCondition(){ 
	
	$(".oms-search-fieldset").each(function(){
		
		//添加条件部的legend
		var legendHtml = "";
		legendHtml += '<legend style="border: 0px;cursor: pointer;" class="condition_name">';
		legendHtml += '<span class="ui-icon-circlesmall ui-icon-circlesmall-minus" style="cursor:pointer;float: left;"></span>';
		legendHtml += '查询条件';
		legendHtml += '</legend>';
		$(this).prepend(legendHtml);
	
		//为legend绑定事件
		$(this).delegate("legend","click",function(){
	
			var tableHeight = $(".dataTables_scrollBody").height();
			var tableWidth = $(".dataTables_scrollBody").width();
			
			var obj = $(this);//下面方法用
			var height=$(".ui-jqgrid-view").height();
			//显示或隐藏div及切换样式
			if($(this).hasClass("ui-icon-circlesmall-plus")) {
				$(this).removeClass("ui-icon-circlesmall-plus");
				$(this).addClass("ui-icon-circlesmall-minus");
				tableHeight -= myFormSearchHeight;
				height-=myFormSearchHeight;
				
				$(".ui-jqgrid-view").height(height);
				$(obj).closest("fieldset").find("form").closest("div").show();
			}else {
				$(this).removeClass("ui-icon-circlesmall-minus");
				$(this).addClass("ui-icon-circlesmall-plus");
				$(this).closest("fieldset").find("form").closest("div").hide();
				height+=myFormSearchHeight;
				
				$(".ui-jqgrid-view").height(height);
			}
		});
	})
}

//实现明细画面的tabs
function setInputDivTabs() {
	
	//隐藏所有div，显示标签对应div
	if($(".oms-tabs .oms-tabs-active").index() >= 0) {
		showInputDiv($(".oms-tabs .oms-tabs-active").index());
	}
	
	$(".oms-tabs li").on("click",function(){
		$(".oms-tabs .oms-tabs-active").removeClass("oms-tabs-active");
		$(this).addClass("oms-tabs-active");
		showInputDiv($(this).index());
	})
}

//隐藏所有oms-input-div, 显示index对应的div
function showInputDiv(index){
	$(".oms-input-div").each(function(i){
		if(i==index){
			$(this).show();
		}else{
			$(this).hide();
		}
	})
}

var dtNumberRender = function(n) {
	return function(data, type, row) {
		return formatNumber(data, n);
	};
};

function dtCurrencyRender(data, type, row) {
	return formatNumber(data, 2);
}

function formatNumber(s, n) {
	n = n >= 0 && n <= 20 ? n : 2;
	s = parseFloat((s + "").replace(/[^\d\.-]/g, "")).toFixed(n) + "";
	if (n == 0) {
		return s;
	}
	var l = s.split(".")[0].split("").reverse(), r = s.split(".")[1];
	t = "";
	for (i = 0; i < l.length; i++) {
		t += l[i] + ((i + 1) % 3 == 0 && (i + 1) != l.length ? "," : "");
	}
	return t.split("").reverse().join("") + "." + r;
}

/**
 * 格式化数字显示方式
 * @param numObj 数字控件
 * @param precision 小数位数
 */
function formatDecimal(numObj, precision) {
	
	if (numObj.value == "" || numObj.readOnly || numObj.disabled) {
		return;
	}

	var pnumber = numObj.value;
	if (isNaN(pnumber)) {
		numObj.value = "";
		return;
	}

	var snum = new String(pnumber);
	var sec = snum.split('.');
	var whole = parseFloat(sec[0]);
	var result = '';

	if (sec.length > 1) {
		var dec = new String(sec[1]);
		dec = String(parseFloat(sec[1]) / Math.pow(10, (dec.length - precision)));
		dec = String(whole + Math.round(parseFloat(dec)) / Math.pow(10, precision));
		if (precision > 0) {
			var dot = dec.indexOf('.');
			if (dot == -1) {
				dec += '.';
				dot = dec.indexOf('.');
			}
			while (dec.length <= dot + precision) {
				dec += '0';
			}
		}
		result = dec;
	} else {
		var dot;
		var dec = new String(whole);
		if (precision > 0) {
			dec += '.';
			dot = dec.indexOf('.');
			while (dec.length <= dot + precision) {
				dec += '0';
			}
		}
		result = dec;
	}
	if (isNaN(result)) {
		result = "";
	}
	numObj.value = result;
	return;
}

function setColumnDefs(columnDefs) {
	var defaultColumnDefs = [
	    {"bSortable":false,"sCellType": "th","aTargets":[0]},
	    {"sWidth":"10px","aTargets":[0]}
	];
	if (typeof(columnDefs) != "undefined") {
		for (var i = 0; i < columnDefs.length; i++) {
			if (typeof(columnDefs[i].aTargets) != "undefined") {
				for (var j = 0; j < columnDefs[i].aTargets.length; j++) {
					columnDefs[i].aTargets[j] = columnDefs[i].aTargets[j] + 1;
				}
			}
			defaultColumnDefs.push(columnDefs[i]);
		}
	}
	return defaultColumnDefs;
}

function setColumns(columns) {
	var defaultColumns = [{"mData": function (data,type,row){
		return 1;
	}}];
	if (typeof(columns) != "undefined") {
		for (var i = 0; i < columns.length; i++) {
			defaultColumns.push(columns[i]);
		}
	}
	return defaultColumns;
}

function doBackCommon() {
	$(".ui-icon-closethick:visible:last", window.parent.document).click();
}

function moveSelectedOptions(from, to) {
	if (arguments.length > 3) {
		var regex = arguments[3];
		if (regex != "") {
			unSelectMatchingOptions(from, regex);
		}
	}
	for (var i = 0; i < from.options.length; i++) {
		var o = from.options[i];
		if (o.selected) {
			to.options[to.options.length] = new Option(o.text, o.value, false,
					false);
		}
	}
	for (var i = (from.options.length - 1); i >= 0; i--) {
		var o = from.options[i];
		if (o.selected) {
			from.options[i] = null;
		}
	}
	if ((arguments.length < 3) || (arguments[2] == true)) {
		sortSelect(from);
		sortSelect(to);
	}
	from.selectedIndex = -1;
	to.selectedIndex = -1;
}

function moveAllOptions(from, to) {
	selectAllOptions(from);
	if (arguments.length == 2) {
		moveSelectedOptions(from, to);
	} else if (arguments.length == 3) {
		moveSelectedOptions(from, to, arguments[2]);
	} else if (arguments.length == 4) {
		moveSelectedOptions(from, to, arguments[2], arguments[3]);
	}
}

function selectAllOptions(obj) {
	for (var i = 0; i < obj.options.length; i++) {
		obj.options[i].selected = true;
	}
}

function sortSelect(obj) {
	var o = new Array();
	if (obj.options == null) {
		return;
	}
	for (var i = 0; i < obj.options.length; i++) {
		o[o.length] = new Option(obj.options[i].text, obj.options[i].value,
				obj.options[i].defaultSelected, obj.options[i].selected);
	}
	if (o.length == 0) {
		return;
	}
	o = o.sort(function(a, b) {
		if ((a.text + "") < (b.text + "")) {
			return -1;
		}
		if ((a.text + "") > (b.text + "")) {
			return 1;
		}
		return 0;
	});
	for (var i = 0; i < o.length; i++) {
		obj.options[i] = new Option(o[i].text, o[i].value,
				o[i].defaultSelected, o[i].selected);
	}
}

$.fn.serializeObject = function() {
   var o = {};
   var a = this.serializeArray();
   $.each(a, function() {
       if (o[this.name]) {
           if (!o[this.name].push) {
               o[this.name] = [o[this.name]];
           }
           o[this.name].push(this.value || '');
       } else {
           o[this.name] = this.value || '';
       }
   });
   return o;
}

function floatAdd(arg1, arg2) {
    var r1, r2, m;
    try {
    	r1 = arg1.toString().split(".")[1].length;
    } catch(e) {
    	r1 = 0;
    }
    try {
    	r2=arg2.toString().split(".")[1].length;
    } catch(e) {
    	r2 = 0;
    }
    m = Math.pow(10,Math.max(r1,r2));
    n = (r1 >= r2) ? r1 : r2;
    
    return ((arg1 * m + arg2 * m) / m).toFixed(n);
}

function floatSub(arg1, arg2) {
   var r1, r2, m, n;
   try {
	   r1 = arg1.toString().split(".")[1].length;
	} catch(e) {
		r1 = 0;
	}
   try {
	   r2 = arg2.toString().split(".")[1].length;
	} catch(e) {
		r2 = 0;
	}
   m = Math.pow(10, Math.max(r1, r2));
   n = (r1 >= r2) ? r1 : r2;
   
   return ((arg1 * m - arg2 * m) / m).toFixed(n);
}

function floatMul(arg1, arg2) {
   var m = 0, s1 = arg1.toString(), s2 = arg2.toString();
   try{
	   m += s1.split(".")[1].length;
	} catch(e) {
	}
   try {
	   m += s2.split(".")[1].length;
	} catch(e){}
	
   return Number(s1.replace(".", "")) * Number(s2.replace(".", "")) / Math.pow(10, m);
}

function floatDiv(arg1, arg2) {
     var t1 = 0, t2 = 0, r1, r2;
     try{
    	 t1 = arg1.toString().split(".")[1].length;
     } catch(e) {}
     try{
    	 t2 = arg2.toString().split(".")[1].length;
     }catch(e) {}

     r1 = Number(arg1.toString().replace(".", ""));
     r2 = Number(arg2.toString().replace(".", ""));

     return (r1 / r2) * Math.pow(10, t2 - t1);
}

function creatIframeFromSub(href,titleName){
	var topWindow = $(window.top.document);
	var show_nav=topWindow.find('#min_title_list');
	show_nav.find('li').removeClass("active");
	var iframe_box=topWindow.find('#iframe_box');
	var srciframeLen = top.$("#min_title_list li").length;
	srciframeLen = srciframeLen+1;
	show_nav.append('<li class="active" iframeIndex="'+srciframeLen+'"><span data-href="'+href+'">'+titleName+'</span><i></i><em></em></li>');
	tabNavallwidthFromSub();
	var iframeBox=iframe_box.find('.show_iframe')
	iframeBox.hide();
	iframe_box.append('<div class="show_iframe"><div class="loading"></div><div class="overFlowIframe" id="overFlowIframe'+srciframeLen+'"><iframe frameborder="0" src='+href+'></iframe></div></div>');
	var showBox=iframe_box.find('.show_iframe:visible')
	showBox.find('iframe').attr("src",href).load(function(){
        showBox.find('.loading').hide();
    });
}

 function tabNavallwidthFromSub(){
	var taballwidth=0,
		$tabNav = $(".acrossTab", top.document),
		$tabNavWp = $(".Hui-tabNav-wp", top.document),
		$tabNavitem = $(".acrossTab li", top.document),
		$tabNavmore =$(".Hui-tabNav-more", top.document);
	if (!$tabNav[0]){return;}
	$tabNavitem.each(function(index, element) {
        taballwidth+=Number(parseFloat($(this).width()+60));
    });
	$tabNav.width(taballwidth+25);
	var w = $tabNavWp.width();
	if (taballwidth+25>w) {
		$tabNavmore.show();
	} else {
		$tabNavmore.hide();
		$tabNav.css({left:0});
	}
}
 
function pinyinMatcher(term, text) {
	if (text.toPinYin != undefined) {
		return text.toPinYin().indexOf(term.toUpperCase()) >= 0 ? true : text
				.toUpperCase().indexOf(term.toUpperCase()) >= 0;
	}
	return text.toUpperCase().indexOf(term.toUpperCase()) >= 0;
}

function initSelect2ForChosen(name, width) {
	if (typeof width == "undefined" || width == "" || width == null) {
		$(name).select2({
			matcher : function(term, text) {
				return pinyinMatcher(term, text);
			}
		});
	} else {
		$(name).select2({
			width : width,
			matcher : function(term, text) {
				return pinyinMatcher(term, text);
			}
		});
	}
}

function creatIframeFromSub(href,titleName, orderNoAll,iframeId){
    var topWindow = $(window.top.document);
    var show_nav=topWindow.find('#min_title_list');
    show_nav.find('li').removeClass("active");
    var iframe_box=topWindow.find('#iframe_box');
    var srciframeLen = top.$("#min_title_list li").length;
    srciframeLen = srciframeLen+1;
    show_nav.append('<li class="active" iframeIndex="'+srciframeLen+'"><span data-href="'+href+'">'+titleName+'</span><i></i><em></em></li>');
    tabNavallwidthFromSub();
    var iframeBox=iframe_box.find('.show_iframe')
    iframeBox.hide();
    var id = new Date();
    iframe_box.append('<div class="show_iframe"><div class="loading"></div><div class="overFlowIframe" id="overFlowIframe'+srciframeLen+'"><iframe id="'+iframeId+'" data-extra="' + orderNoAll + '" frameborder="0" src='+href+'></iframe></div></div>');
    var showBox=iframe_box.find('.show_iframe:visible')
    showBox.find('iframe').attr("src",href).load(function(){
        showBox.find('.loading').hide();
    });
}