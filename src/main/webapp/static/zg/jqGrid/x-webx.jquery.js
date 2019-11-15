(function($){
	$.fn.jqForm = function(options) {
		var defualts = {
			rowCount: 1,
			colCount: 1,
			rowHeight: 25,
			colWidth: 60
		};
	    var opts = $.extend({}, defualts, options); 
		  var row;
	    return this.each(function(){ 
	      var tid = this.id;
        $(this).html("");
	      var i, j;
	      for(i = 0; i < opts.rowCount; i++){
	        row = "<tr id=\"" + tid + "_r" + i + "\" class=\"x-form-tr\"";
	        if(opts.rowHeight > 0) row += " height=\"" + opts.rowHeight + "\"";
	        row += ">";
	        for(j = 0; j < opts.colCount; j++){
	          row += "<td id=\"" + tid + "_cell" + i + "_" + j + "\" class=\"x-form-td\"";
	          if(opts.colWidth > 0) row += " width=\"" + opts.colWidth + "\"";
	          row += "></td>";
	      	}
	        row += "</tr>";
	        $(row).appendTo(this); 
	      }
		});
  };

  //--------------begin/end---------
  $.fn.jqForm_AddCtrl = function(ctl, options){
	    var defualts = {
				rowIdx: 1,
				colIdx: 1,
				rowSpan: 1,
				colSpan: 1,
				align:"left",
				width:0,
				height:0
			};
	    var opts = $.extend({}, defualts, options);
	    return this.each(function(){
	      var td = mergeCell(this.id, opts.rowIdx, opts.colIdx, opts.rowSpan, opts.colSpan);
	      td.css("text-align", opts.align).width(td.width * opts.colSpan);
	      var aCtrl = $(ctl);
	      //if(opts.width > 0) aCtrl.width(opts.width);
	      //if(opts.height > 0) aCtrl.height(opts.height);
	      td.append(aCtrl); 
	    });
	    function mergeCell(tid, rowIdx, colIdx, rowSpan, colSpan){
	      if(rowSpan > 1)
	        addRowSpan(tid, rowIdx, colIdx, rowSpan);
	      if(colSpan > 1)
	        addColSpan(tid, rowIdx, colIdx, colSpan);
	      //删除缺角
	      var i, j;
	      for(i = rowIdx + 1; i < rowIdx + rowSpan; i++)
	        for(j = colIdx + 1; j < colIdx + colSpan; j++)
	          deleCell(tid, i, j);
	      return $("#" + tid + "_cell" + rowIdx + "_" + colIdx);
	    }
	    function addRowSpan(tid, row, col, num){
	      var r = "#" + tid + "_cell" + row + "_" + col;
	      var i;
	      $(r).attr("rowSpan", num);
	      for(i = row + 1; i < row + num; i++)
	        deleCell(tid, i, col);
	    }
	    function addColSpan(tid, row, col, num){
	      var r = "#" + tid + "_cell" + row + "_" + col;
	      var i;
	      $(r).attr("colSpan", num);
	      for(i = col + 1; i < col + num; i++)
	        deleCell(tid, row, i);
	    }
	    function deleCell(tid, row, col){
	      var r = "#" + tid + "_cell" + row + "_" + col; 
	      $(r).remove();
	    };
  };
  //--------------begin/end---------
  $.fn.checkFormRule = function checkFormRule(aForm, options){
    var defualts = {
	  	onFaile: null
    };
    var opts = $.extend(defualts, options);
    var b = true;
	var v = "", bi = false;
    $("[rule]", aForm).each(function(i){ 
		//alert($(this).attr('rule'));
		v = $(this).val();
		bi = true;
		eval( 'rule = ' +$(this).attr('rule') + ';');
		if(v == ""){
			bi = (rule.ignore != null) && (rule.ignore == 1);
		}
		else if(rule.min != null && rule.min > 0 && v.length < rule.min){
			bi = false;
		}
		else if(rule.max != null && rule.max > 0 && v.length > rule.max){
			bi = false;
		}
		else if(rule.expr != null && rule.expr instanceof RegExp && !rule.expr.test(v)){
			bi = false; 
		}
		else if(rule.expr != null && rule.expr instanceof Function && !rule.expr(v, this)){			
			bi = false; 
		}
		if(!bi){
			if(opts.onFail != null) opts.onFail(this, rule.message); 
			b = bi;
		}
	});	
	return b;
  };
//--------------begin/end---------
$.fn.showTip = function(msg, options){
	var defualts = {
		type: "info",
		layout:"right",
		showText: false
	};
	var opts = $.extend(defualts, options);
		return this.each(function(){
			var _fld = $(this);  
			var spn = "span[for=\"" + this.id + "\"]";
			var _tip = $(spn);
			if(_tip.size() == 0){
				var _parent = _fld.parent();
				_parent.append("<span for=\"" + this.id + "\" class=\"x-tip\"></span>");
				_tip = $(spn);
			}
			var _pos = _fld.position();
			if(opts.layout == "right")
			  _pos.left = _pos.left + _fld.width() + 5;
			else if(opts.layout == "below")
			  _pos.top = _pos.top + _fld.height() + 2;
			if(opts.showText)
				_tip.html(msg).width(50);
			else
				_tip.html(" ").attr("title", msg).width(1);
			_tip.css({"background-image": "url(common/icons/tip/tip-" + opts.type + ".gif)", top: _pos.top, left: _pos.left}).fadeIn(); 
	});
};
 //--------------begin/end--------- 
  $.fn.clearTips = function(){
	  	return this.each(function(){
	  		$(this).css("display", "none");
	  	});
  };
  //--------------begin/end---------
  $.fn.hideTip = function(){
	  return this.each(function(){
	    	var spn = "span[for=\"" + this.id + "\"]";
	    	$(spn).css("display", "none");
	  });
  };
  //--------------begin/end---------
  $.fn.doRequestCheck = function(options, fnCallback){
	  	var defualts = {
	  			url:null,
		  		data: "",
		  		method:"POST"
		};
	  	var opts = $.extend(defualts, options);
	  	if(opts.url == null) return;
	  	return this.each(function(){
	  		var ctl = $(this); 
	  		try{
				$.ajax({
					type: opts.method,
					url: opts.url,			
					data: opts.data,
					dataType:"json",
					beforeSend:function(){
						ctl.showTip("", {type:"wait"});
					},
					success: function(data){
						ctl.hideTip();
						fnCallback(data);
					},
					error:function(o, msg){
						ctl.hideTip();
						//fnCallback(data);
            alert("数据请求失败！[doRequestCheck]" + msg);
				}
				});		
			}
			catch(e){
				alert("AJAX doRequest:" + e.message);
				if(fnCompleteHandler != null) fnCompleteHandler();
			}
	  	});	  	
  };
  //--------------begin/end---------

  $.fn.doRequestData = function(options, fnCallback){
	  	var defualts = {
			async: true,
			url:null,
			data: "",
			method:"POST",
			showTip: false
		};

	  	var opts = $.extend(defualts, options);
	  	if(opts.url == null) return;
	  	return this.each(function(){
	  		var ctl = $(this); 
	  		try{
				$.ajax({
					url: opts.url,			
					async: opts.async,
					type: opts.method,
					data: opts.data,
					dataType:"json",
					beforeSend:function(){
						if(opts.showTip) ctl.showTip("", {type:"wait"});
					},
					success: function(data){
						ctl.hideTip();
						fnCallback(data);
					},
					error:function(o, msg){
						if(opts.showTip) ctl.hideTip();
						alert("数据请求失败！[doRequestData]" + msg);
						//fnCallback(data);
				  }
				});		
			}
			catch(e){
				alert("AJAX doRequest:" + e.message);
				if(fnCompleteHandler != null) fnCompleteHandler();
			}
	  	});	  	
  };
  //--------------begin/end--------

  $.fn.initForm = function(values){
	  return this.each(function(){
		  for(var c in values){  //遍历
			var _t = $("#" + c, this); 
			if(_t.size() > 0){
				var cTag = _t[0].tagName.toLowerCase();
				var cType = _t[0].type;
				if(cType != null) cType = cType.toLowerCase();
				if(cTag == "span")
					_t.text(values[c]);
				else if(cType == "checkbox"){
					_t.attr("checked", values[c] != 0);}
				else
					_t.val(values[c]);
			}
		  }
	  });
  };
  //--------------begin/end---------
  $.fn.msgBox = function(msg, options, _return){
      var opts = $.extend({
        name:"dialog-win",
        type: "info",
        title: "消息", 
        width: 250, 
        height: "auto",
        modal: true,
        closeOnEscape: true,
        draggable: true,
        resizable: false,
        close:function(event, ui){
        	if(_return) _return($(this).attr("retval"));
        	//var cb = $(this).dialog("option", "getvalue"); 
        	//if(cb) {
        	//	eval( 'fnc = ' + cb + ';'); 
        	//	fnc($(this).attr("retval"));
        	//}
        }
      }, options);
      var btn = {};
      if(opts.type == "question"){
      	btn = {
      		"是":function(){$(this).attr("retval", "Y") ; $(this).dialog("close");},
      		"否":function(){$(this).attr("retval", "N") ; $(this).dialog("close");}
      	};
      }
      else {//if(opts.type == "info" || opts.type == "warning"){
      	btn = {"确定": function(){/*window.top.*/$(this).dialog("close");}};
      }
      opts = $.extend(opts, {buttons:btn});
      removeDialog(opts.name);
      var html =
        '<div class="x-dialog" id="' + opts.name + '" name="' + opts.name + '">' +
        	'<span class="x-dialog-icon x-dialog-icon-' + opts.type + '"></span>' +
       		'<span class="x-dialog-message">' + msg + '</span>' +
        '</div>';
      return /*window.top.*/$(html).dialog(opts);
  };
 //--------------begin/end---------
  $.fn.openWin = function(url, options, _return){
	  var opts = $.extend({
		  name:"dialog-win",
		  title: "",
		  width: 400, 
		  modal: true,		  
	      closeOnEscape: true,
	      draggable: true,
	      resizable: false	//不能设置为true
	      //close:function(event, ui){
	  	  	//if(_return) _return($(this).attr("retval"));
	  	  //}
	  }, options); 
	  //if(_return == null) opts.close = null;
	  removeDialog(opts.name);
	  var html =
      '<div class="x-dialog" id="' + opts.name + '" name="' + opts.name + '">' +
      ' <iframe src="' + url + '" frameBorder="0" style="border: 0; " id="x-dialog-frame" name="x-dialog-frame" scrolling="auto" width="100%" height="100%"></iframe>' +
      '</div>';
    return /*window.top.*/$(html).dialog(opts);
  };
  //--------------begin/end---------
  $.fn.closeWin = function(name){
    name = name?"#" + name:"#dialog-win";
    /*window.top.*/$(name).dialog('close');
  };
  //--------------begin/end---------
})(jQuery);

//扩展关联函数
function removeDialog(dlgName){
    try{
    	//var _p = window.top.$("#" + dlgName);
    	//_p.remove();
    	//_p.parent().remove();
     	//window.top.$("#" + dlgName).parent().remove();
     	var d = /*window.top.*/document.getElementById(dlgName);
		if (d) {
			var p = d.parentNode;
			if (pp = p.parentNode){
    			pp.removeChild(p);
			}
			//alert("deleted");
		}
		
     }catch(e){}
 }

function xconfirm(msg){
	return confirm(msg);
}

function xalert(msg){
	//$(window.top).msgBox(msg);
	alert(msg);
}

//初始化执行的函数
$(document).ready(function(){
  $(".x-toolbox-header").bind("dblclick", function(){
    //var o = $(this).next();
	//o.toggle("fast");
	//alertJSON(o);
  });
  $(".x-dateedit").datepicker({
    dateFormat:"yy-mm-dd"
  });

  $(".x-datetimeedit").datetimepicker({
    dateFormat:"yy-mm-dd",
	showTime:false,
	hourText:"时",
	minuteText:"分",
	secondText:"秒",
	currentText:"现在",
	closeText:"关闭"
  });
  
  $(":input[readOnly]").addClass("x-input-readonly");
  
  setTimeout(function(){
	  $("#btnSearch").bind({
	  	  mouseover:function(){
	  		$("#btnSearch").removeClass("ui-state-hover");
	  		$("#btnSearch").addClass("ui-button-text-only-search-hover");
	  		$("#btnSearch").removeClass("ui-state-hover");
	  		$("#btnSearch").addClass("ui-button-text-only-search-hover");
	  		},
	      mouseout:function(){
	    	  $("#btnSearch").removeClass("ui-button-text-only-search-hover");
	    	  $("#btnSearch").addClass("ui-button-text-only-search");;
	      }
	  });
  }, 0);
  //$(".x-toolbox-header").bind("onselectstart", function(){alert(1);});

  setDetailFormHeight();
});
