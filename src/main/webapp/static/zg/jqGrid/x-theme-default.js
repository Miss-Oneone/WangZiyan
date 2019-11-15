function getNextDate(blnday){
  var dt = new Date();                       // 创建 Date 对象。
  var sY = dt.getFullYear();
  var sM = dt.getMonth() + 1;
  var sD = dt.getDate();
  if(blnday <= 0) //结算至上个月最后一天
    sD = 0;
  else if(sD > blnday)  //结算至本月的blnday
    sD = blnday;
  else{
    sM --;
    sD = blnday;
  }
  var s = sY + "/" + (sM.length == 1?"0"+sM:sM) + "/" + (sD.length == 1?"0"+sD:sD);        
  s = fmtDate2(new Date(s));
  return s;
}

function updateTips( t ) {
	var tips = $(".validateTips");
	tips.text(t).addClass( "ui-state-highlight" );
	setTimeout(function() {
		tips.removeClass( "ui-state-highlight", 1500);
	}, 500 );
}

function resetFormCheck(aForm){
	$(".x-tip").clearTips();
	$("[id]", aForm).removeClass("ui-state-error");
}
function checkForm(aForm, options){
	resetFormCheck(aForm);
	b = ($(aForm)).checkFormRule(aForm, {onFail:function(fld, msg){
		$(fld).addClass("ui-state-error").showTip(msg, {type:"error"});
	}});	
	if(!b) updateTips("填写不符合要求！");
	return b;
}

function frm_postComplete(){
	$("#btnsubmit").removeAttr("disabled");		
}

function showMsg(msg){
	$("#msgShow").html(msg);
}

function clearMsg(){
	$("#msgShow").html("");
}
function swap(oImg,oDiv){
	if (oDiv.style.display=='none'){
		oDiv.style.display='block';
		oImg.src="/image/minus.gif";
	}
	else{
		oDiv.style.display="none";
		oImg.src="/image/plus.gif";
	}
}

function openRpt(link){
	try{
		var tmpwin=window.open(link,"rptwin", "toolbar=0,resizable=1,scrollbars=1,menubar=0,dependent");
    tmpwin.moveTo(0,0);
    tmpwin.resizeTo(screen.availWidth,screen.availHeight);
		tmpwin.focus();
  }
	catch(e){}
}
function getDays(month, year) { 
  var daysInMonth = new Array(31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31); 
	if (1 == month) 
		return ((0 == year % 4) && (0 != (year % 100))) || (0 == year % 400) ? 29 : 28; 
	else 
		return daysInMonth[month]; 
} 

function submitchks(oBtn,act) {
  var fm = oBtn.form;
  if(!isCheck(fm.chks)){
    alert("没有选择要操作的内容，选择请勾选复选框");
  }
  else{
    if(!confirm("！！！\n确定要执行此操作吗？请谨慎\n！！！！")) {return false;}
    fm.hdnaction.value=act;
    fm.hdnid.value=getCheckValue(fm.chks);
    oBtn.disabled = true;
    fm.submit();
  }
}

function submitFormChks(btn, tblId, dataForm, fnCallback){
	var arr = getCheckIds("#" + tblId);
	if(arr.length == 0){
		xalert("至少选择一行！");
		return;
	}
	if(xconfirm("确定要" + $(btn).text() + "选择的" + arr.length + "个记录吗？")){
		dataForm.action="?act=" + $(btn).attr("act");
		$("#hdnvalues", dataForm).val(arr);
		doRequest(dataForm, 
      function(res){
        if(res.result == 1){
          xalert("操作成功！");
        }else{
          xalert(res.msg);
        }
        if(fnCallback)
          fnCallback();
        else
          $("#" + tblId).trigger("reloadGrid");
      }    
    );	
	}
}

function UpDown(caption,index, imgdir, order, dir){
	  var s = "<a href='javascript:setsort(" + index + ");'>" + caption + "</a>";
	  if(order==index)
	    if (dir==1)
	      s += "<img src='" + imgdir + "image/up.gif' border='0' align='absmiddle'>";
	    else
	      s += "<img src='" + imgdir + "image/down.gif' border='0' align='absmiddle'>";
	  document.write(s);
	}

/**
 * xmhong 2012.12.31，原文件名为selectCondition.js
 * 创建查询条件对象 defaultParam为默认值的是display还是none, (如果加号图片无法显示,则传入上下文路径做为参数)
 */
function createSelectCondition(defaultParam,path,nodename){
	var obj = document.getElementById('selectCondition');
	if(obj == null) return;
	//ie下fieldset默认就有圆角
	if($.browser.msie) {
		$(obj).removeClass("ui-corner-all");
	}
	var legend = document.createElement("legend");
	
	var span = document.createElement("span");
	span.className="ui-icon tree-wrap-ltr ui-icon-circlesmall-minus";
	span.style.cursor="pointer";
	span.style.styleFloat="left";
	span.setAttribute("style","cursor:pointer;float: left;");
	legend.appendChild(span);
	
	//legend.style="border: 0px;cursor: pointer";
	legend.setAttribute("style","border: 0px;cursor: pointer;");
	legend.appendChild(document.createTextNode(nodename==null?"查询条件":nodename));
	legend.className="condition_name";
	var childNodes = obj.childNodes;
	legend.onclick = function(){
		chooseSelectCondition(obj);
	};
	
	obj.insertBefore(legend,childNodes[0]);
	if (defaultParam=="none"){
		chooseSelectCondition(obj);
	}
}

//显示隐藏查询条件
function chooseSelectCondition(obj,form,defaultParam){
$(obj).find("div").first().toggle();
if($("span.tree-wrap-ltr").attr("class").indexOf("ui-icon-circlesmall-minus")>0){
	$("span.tree-wrap-ltr").removeClass("ui-icon-circlesmall-minus");
	$("span.tree-wrap-ltr").addClass("ui-icon-circlesmall-plus");
}else{
	$("span.tree-wrap-ltr").removeClass("ui-icon-circlesmall-plus");
	$("span.tree-wrap-ltr").addClass("ui-icon-circlesmall-minus");
}
var overflowx = $(obj).closest("html").css("overflow-x");
var overflowy = $(obj).closest("html").css("overflow-y");
$(obj).closest("html").css("overflow-x", "hidden");
$(obj).closest("html").css("overflow-y", "hidden");
$(window).trigger('resize');
$(obj).closest("html").css("overflow-x", overflowx);
$(obj).closest("html").css("overflow-y", overflowy);
}



/*
 * 可伸缩框共同方法
 * @Author:zhengrongwei
 * 
 * 伸缩框内name=“所需中文名”
 */
function createMyConditionList(){
	var obj1 = document.getElementById('MyCondition');
	if(obj1 != null){
		createMyCondition("",obj1.id,obj1.name,100);
		var obj1 = document.getElementById('MyCondition1');
		if(obj1 != null){
			createMyCondition("",obj1.id,obj1.name,100);
			var obj1 = document.getElementById('MyCondition2');
			if(obj1 != null){
				createMyCondition("",obj1.id,obj1.name,100);
				var obj1 = document.getElementById('MyCondition3');
				if(obj1 != null){
					createMyCondition("",obj1.id,obj1.name,100);
				}
			}
		}
	}
}

function createMyCondition(defaultParam,path,nodename,txtsize){
	var obj = document.getElementById(path);
	if(obj == null) return;
	//ie下fieldset默认就有圆角
	if($.browser.msie) {
		$(obj).removeClass("ui-corner-all");
	}
	var legend = document.createElement("legend");
	
	var span = document.createElement("span");
	span.className="ui-icon tree-wrap-ltr ui-icon-circlesmall-minus";
	span.style.cursor="pointer";
	span.style.styleFloat="left";
	span.setAttribute("style","cursor:pointer;float: left;width:10px;");
	legend.appendChild(span);
	
	//legend.style="border: 0px;cursor: pointer";
	legend.setAttribute("style","border: 0px;cursor: pointer;width:"+txtsize+"px;");
	legend.appendChild(document.createTextNode(nodename==null?"查询条件":nodename));
	legend.className="condition_name";
	var childNodes = obj.childNodes;
	legend.onclick = function(){
		chooseSelectCondition(obj);
	};
	
	obj.insertBefore(legend,childNodes[0]);
	if (defaultParam=="none"){
		chooseSelectCondition(obj);
	}
}


function selectConditionOpened(obj){
  return $("span.tree-wrap-ltr", obj).hasClass("ui-icon-circlesmall-minus");
}
//Grid支持函数
function getCheckIds(gridId){
	return selectedIds = $(gridId).jqGrid("getGridParam", "selarrrow");
}

function getSelectRowId(gridId){
	return $(gridId).jqGrid('getGridParam', 'selrow');
}

function getOnlyOneChecked(gridId){
	var arr = getCheckIds(gridId);
	if(arr.length != 1){
		return null;
	}
	return arr[0];
}

function clearGrid(gridId){
  //清空子表
  var ids = $(gridId).jqGrid('getDataIDs');
  for(var i=0;i < ids.length;i++){
    cl = ids[i]; 
    $(gridId).jqGrid("delRowData", cl);
  }
}

function createGridList(gridId, pagerId, options){
	$("input:button, button", "div" ).button();
	var tblKey = "";
	if(options.tblKey) tblKey = options.tblKey;
	var opt = $.extend({
		datatype: "local",
		url:getPostURL(tblKey),
		mtype:'POST',
		jsonReader:{
			id: options.id == null ? "id" : options.id,
			root: "rows", 
			page: "page", 
			total: "total", 
			records: "records", 
			repeatitems: false
		},
		//colNames:getColumnNames(tblKey),
		//colModel:getColumnModels(tblKey),
		rowNum:100,
	   	rowList:[100,500,1000],
		rownumbers:true,
	//	rowList:rowList,
		viewrecords: true,
		multiselect: true,
		multiboxonly:true,
		shrinkToFit: false,
		pager: pagerId,
		beforeSelectRow:multiSelectHandler,
		loadComplete:function(xhr){
			var r = $(gridId).getUserDataItem("result");
			if (r != "1" && $(gridId).getGridParam("datatype") != "local"){
				xalert("数据加载失败[" + $(gridId).getUserDataItem("msg") + "]");
			}
			setPageDisabled(false);
			try {
				if (typeof(eval(gridId.substr(1) + 'LoadComplete')) == 'function') {
					eval(gridId.substr(1) + 'LoadComplete()');
				}
			} catch (e) {
			}
		},
		loadError:function(xhr,status,error){
			if (xhr.responseText.indexOf("loginForm") >= 0) {
				xalert("数据加载失败：会话已超时，请重新登录！");
				// 执行页面跳转
				if (self.frameElement && self.frameElement.tagName == "IFRAME") {
					parent.location.reload();
				} else {
					location.reload();
				}
			} else {
				xalert("数据加载失败[" + status + "]" + error);
			}
		}
	},options);
	$(gridId).jqGrid(opt);	
	if(pagerId){
		$(pagerId + "_right").width(140);
	}
	if (opt.customizeColumn) {
		$(gridId).jqGrid('navGrid',pagerId,{add:true,edit:true,del:true,search:true,refresh:true});
		$(gridId).jqGrid('navButtonAdd',pagerId,{
		    caption: "",
		    title: "选择列",
		    onClickButton : function (){
		        $(gridId).jqGrid('columnChooser', {
					modal : true,
					width : 500,
			        done : function(perm) {
			            if (perm) {
			                this.jqGrid("remapColumns", perm, true);
			                var gwdth = this.jqGrid("getGridParam", "width");
			                this.jqGrid("setGridWidth", gwdth);

			                // 修改结果保存到数据库
				        	var result = {};
				            result.funcName = opt.customizeColumn;
				        	var show = new Array();
				        	var hide = new Array();
				        	var colModel = $(gridId).jqGrid("getGridParam", "colModel");
				        	for (var i = 2; i < colModel.length; i++) {
				        		if (colModel[i].hidden) {
				                	hide.push(colModel[i].name);
				        		} else {
				                	show.push(colModel[i].name);
				        		}
				        	}
				        	/*
				            $('option', select).each(function() {
				                if (this.selected) {
				                	show.push(colModel[counter].name);
				                	//result += "show:" + colModel[this.value].name + ";";
				                } else {
				                	hide.push(colModel[counter].name);
				                	//result += "hide:" + colModel[this.value].name + ";";
				                }
				                counter++;
				            });
				            */
				            result.show = show;
				            result.hide = hide;
				            //alert(result);
				            $.post(ctx + "/sys/gridItem/customizeSave", result);
			            }
			        }
		        });
		    }
		});
	}
	
	if(options.showSelectedCount == true) {
		$("<td id='showSelectedCount' style='float:right;padding-top:6px;'><label>选中条数:</label><label id='selectedCount' style='width:300px;'></label></td>").insertAfter($(pagerId + "_left"));
	}
}

function showSelectedCount(gridId) {
	var arr = getCheckIds(gridId);
	$("#selectedCount").text(arr.length);
}

function changeInlineButtonState(o, idx){
  if(idx == 0){
    $(o).attr("disabled", true);
    $(o).next().attr("disabled", false);
    $(o).next().next().attr("disabled", false);
  }
  else if(idx == 1){
    $(o).prev().attr("disabled", false);
    $(o).attr("disabled", true);
    $(o).next().attr("disabled", true);
  }
  else{
    $(o).prev().prev().attr("disabled", false);
    $(o).prev().attr("disabled", true);
    $(o).attr("disabled", true);
  }
}

function checkInLineSaved(xhr){
  eval( 'res = ' + xhr.responseText + ';'); 
  if(res.result == 1){    
    return true;
  }
  else{
    xalert(res.msg);
    return false;
  }
}
function createInLineButton(tblId, options){
  var ids = $(tblId).jqGrid('getDataIDs');
  var cl, s;
  for(var i=0;i < ids.length;i++){ 
    cl = ids[i]; 
    s = "";
    if(options.edit){
      s += "<input type='button' class='x-inlinebutton' value='改' onclick=\"changeInlineButtonState(this,0);$('" + tblId + "').editRow('"+cl+"');\" />"; 
      s += "<input type='button' class='x-inlinebutton' value='存' disabled onclick=\"var b = false;$('" + tblId + "').saveRow('"+cl+"'," +
           "{successfunc:function(res){b = checkInLineSaved(res); return true;}});if(b)changeInlineButtonState(this,1);else $('" + tblId + "').editRow('"+cl+"'); \" />"; 
      s += "<input type='button' class='x-inlinebutton' value='返' disabled onclick=\"changeInlineButtonState(this,2);$('" + tblId + "').restoreRow('"+cl+"');\" />"; 
    }
    if(options.del == true){
      s += "<input type='button' class='x-inlinebutton' value='删' onclick=\"$('" + tblId + "').deleteRow('"+cl+"');\"\" />"; 
    }
    $(tblId).jqGrid('setRowData',ids[i],{_action:s});
  }
}
function createPagerButtons(gridId, pagerId, options){
//  $(gridId).jqGrid("navGrid", pagerId, {  
//        addfunc : doGridAdd,
//        editfunc : doGridEdit,
//        delfunc : doGridDel,
//        alerttext : alertText 
//    },{},{},{},{
//        caption: "查找",  
//        Find: "Let's go!",  
//        multipleSearch: true,  
//        groupOps: [{ op: "AND", text: "全部" }],  
//    },{});  
}


//Tree支持函数

function beforeDrag(treeId, treeNodes) {
  for (var i=0,l=treeNodes.length; i<l; i++) {
    if (treeNodes[i].drag === false) {
      return false;
    }
  }
  return true;
}

function beforeDrop(treeId, treeNodes, targetNode, moveType) {
  if(targetNode){
    if(targetNode.getParentNode() == null && moveType != "inner")
      return false;
    else
      return targetNode.drop != false;
  }
  else
    return false;
}

function getTreeSelected(treeId){
	var zTree = $.fn.zTree.getZTreeObj(treeId);
	return zTree.getSelectedNodes();
}

function getTreeChecked(treeId){
	var zTree = $.fn.zTree.getZTreeObj(treeId);
	return zTree.getCheckedNodes();
}

function getTreeSingleSelected(treeId){
	var arr = getTreeSelected(treeId);
	if(arr.length != 1){
		return null;
	}
	return arr[0];

}

function setTreeSelected(treeId, nodeId){
	var treeObj = $.fn.zTree.getZTreeObj(treeId);
	treeObj.selectNode(treeObj.getNodeByTId(nodeId));
}

function expandTreeNode(treeId, nodeId){
	var treeObj = $.fn.zTree.getZTreeObj(treeId);
	var node = treeObj.getNodeByTId(nodeId);
	treeObj.selectNode(node);
	treeObj.expandNode(node);
}

function selectCode(obj, options, onOkCallBack){
	var opt = $.extend({width:350, height:450, title:"选择", code:'', multi:false, limit:0, complex:false}, options);
	var url = "codesel.xdo?code=" + opt.code + "&multi=" + opt.multi + "&complex=" + opt.complex + "&limit=" + opt.limit;
	$(window).openWin(url,	{
		name:"code-winc", width:opt.width, height:opt.height, title:opt.title, 
		buttons: [{
			text: "确定",
			"id": "btnOk",
			click: function () {
				var value = $("#x-dialog-frame", /*window.top.*/$("#code-winc"))[0].contentWindow.getData(); 
				$(window).closeWin("code-winc"); 
				if(onOkCallBack) onOkCallBack(value);
			}
	 
		}, {
			text: "取消",
			"id": "btnCancel",
			click: function () {
				$(window).closeWin("code-winc");
			}
		}]
    }
  );
}

function doSelect(obj, code, multi, complex){
  //判断全局变量
  try{
    if(editMode != null && !editMode) return;
  }
  catch(e){}
  var opt = {"code":code};
  if(multi) opt.multi = multi;
  if(complex) opt.complex = complex;
  selectCode(obj, opt,
    function(data){
      var ids = new Array(), names = new Array();
      for(var i = 0; i < data.length; i++){
        ids.push(data[i].no);
        names.push(data[i].name);
      }
      $(obj).val(names);
      var n = obj.id;
      n = "#" + n.substring(0, n.length - 1);
      $(n).val(ids); //同一级
    }
  );
}



function sendNotify(msg){
  /*window.top.*/doActionNotify(msg);
}

function sendNotifyEx(sender, receiver, msgId, msgObject){
  /*window.top.*/doActionNotifyEx(sender, receiver, msgId, msgObject);
}

function sendNotifyPd(sender, receiver, msgId, msgObject,qty){
	  /*window.top.*/doActionNotifyPd(sender, receiver, msgId, msgObject,qty);
	}

function xprompt(tip, value){
	return prompt(tip, value);
}


function selectList(url, options, onOkCallBack, onCancelCallBack){
  var opt = $.extend({name:"code-winl", width:350, height:450, title:"选择", multi:false, limit:0, showbtn:true}, options);
  if(opt.showbtn){
	opt = $.extend(opt, {
		buttons: [{
			text: "确定",
			"id": "btnOk",
			click: function () {
				var value = $("#x-dialog-frame", /*window.top.*/$("#" + opt.name))[0].contentWindow.getData(); 
				$(window).closeWin(opt.name); 
				if(onOkCallBack) onOkCallBack(value);
			}
	 
		}, {
			text: "取消",
			"id": "btnCancel",
			click: function () {
				$(window).closeWin(opt.name);
				if(onCancelCallBack) onCancelCallBack();
			}
		}],	
		close:function(event, ui){
			if(onCancelCallBack) onCancelCallBack();
	  	}
	});
  }  
  var _url = url + "&multi=" + opt.multi + "&limit=" + opt.limit;
  $(window).openWin(_url, opt);    
}

function selectTree(url, options, onOkCallBack){
	var opt = $.extend({width:350, height:450, title:"选择", code:'', multi:false, limit:0, complex:false}, options);
	var _url = url + "&multi=" + opt.multi + "&limit=" + opt.limit;
	$(window).openWin(_url,	{
		name:"code-winc", width:opt.width, height:opt.height, title:opt.title, 
		buttons: [{
			text: "确定",
			"id": "btnOk",
			click: function () {
				var value = $("#x-dialog-frame", /*window.top.*/$("#code-winc"))[0].contentWindow.getData(); 
				$(window).closeWin("code-winc"); 
				if(onOkCallBack) onOkCallBack(value);
			}
	 
		}, {
			text: "取消",
			"id": "btnCancel",
			click: function () {
				$(window).closeWin("code-winc");
			}
		}]
    }
  );
}
//以下为部分可直接使用的业务组件
function selectSingleDesigner(obj){
  selectList("person.xdo?act=qlist_designer",  {multi:false,width:400, height:500, title:"选择设计师"}, 
  function(data){
    if(data == null){
		data = {pid:"", pname:""};
	}
    $(obj).val(data.pname);
	var n = obj.id;
    n = "#" + n.substring(0, n.length - 1);
    $(n).val(data.pid);
  });		
}

function selectMultiDesigner(callBack){
	selectList("person.xdo?act=qlist_designer",  {multi:true,width:400, height:500, title:"选择设计师"}, 
	function(data){
		if(callBack) callBack(data);
	});		
}

function selectSingleChargeOp(obj, callBack){
  selectList("person.xdo?act=qlist_charge",  {multi:false,width:400, height:500, title:"选择主管"}, 
  function(data){
	if(callBack) callBack(data);
  });		
}

function selectMultiChargeOp(obj, callBack){
  selectList("person.xdo?act=qlist_charge",  {multi:true,width:400, height:500, title:"选择主管"}, 
  function(data){
	if(callBack) callBack(data);
  });		
}

function selectSinglePerson(obj, callBack){
  selectList("person.xdo?act=qlist",  {multi:false,width:400, height:500, title:"选择人员"}, 
  function(data){
	if(callBack) callBack(data);
  });		
}

function selectSingleChannel(obj, callBack){
  selectList("channel.xdo?act=qlist",  {multi:false,width:800, height:500, title:"选择店铺"}, 
  function(data){
	if(callBack) callBack(data);
  });		
}

function doSelectMultiChannel(obj, callBack){
  selectList("channel.xdo?act=qlist",  {multi:true,width:800, height:500, title:"选择店铺"}, 
  function(data){
	if(callBack) callBack(data);
  });		
}

function selectSingleBalanceChannel(obj, callBack, options){
	var opt = $.extend({co:""}, options);
	selectList("channelbln.xdo?act=qlist&tid=" + opt.co,  {width:800, height:500, multi:false, title:"选择渠道结算单"}, 				
		function(data){			
			if(callBack) callBack(data);		
		}
	);	
}

function selectSingleCustom(obj, callBack, options){
	var opt = $.extend({blnType:""}, options);
	selectList("custom.xdo?act=qlist&blntype=" + opt.blnType,  {multi:false,width:800, height:500, title:"选择客户"}, 
		function(data){
			if(callBack) callBack(data);
		}
	);  
}

function selectSingleSku(obj, callBack, options,warecode){
	var opt = $.extend({blnType:""}, options);
	selectList("sku.xdo?act=qlist&warecode="+warecode+"&blntype=" + opt.blnType,  {multi:false,width:600, height:400, title:"选择SKU"}, 
		function(data){
			if(callBack) callBack(data);
		}
	);  
}

function selectSingleCustomForBalance(obj, callBack){
	selectList("custom.xdo?act=balance",  {multi:false,width:800, height:600, title:"选择客户"}, 
	function(data){
		if(callBack) callBack(data);
	});  
}

function selectSingleBalanceCustom(obj, callBack, options){
	var opt = $.extend({co:""}, options);
	selectList("balance.xdo?cname=&act=qlistcustom&tid=" + opt.co,  {width:800, height:500, multi:false, title:"选择结算单"}, 				
		function(data){			
			if(callBack) callBack(data);		
		}
	);	
}

function selectSingleLogistics(obj, callBack){
	selectList("logistics.xdo?act=qlist",  {multi:false,width:780, height:600, title:"选择承运商"}, 
	function(data){
		if(callBack) callBack(data);
	});  
}

function selectSingleBalanceLogistics(obj, callBack, options){
	var opt = $.extend({co:""}, options);
	selectList("balance.xdo?act=qlistpost&tid=" + opt.co,  {width:800, height:500, multi:false, title:"选择快递结算单"}, 				
		function(data){			
			if(callBack) callBack(data);		
		}
	);
}
function doSelectProduct(obj, callBack, bMulti, bShowBtn, rcv){
	selectList("pd.xdo?act=qlist&rcv=" + rcv,  {multi:bMulti, width:780, height:440, title:"选择商品", showbtn: bShowBtn}, 
    function(data){			
		if(callBack) callBack(data);
    });	
}
//京东发货导入画面
function doUploadPage(obj, callBack, bMulti, bShowBtn){
	selectList("upload.xdo?act=upload",  {multi:bMulti, width:780, height:440, title:"导入订单", showbtn: bShowBtn}, 
    function(data){			
		if(callBack) callBack(data);
    });	
}

//采购单导入画面
function doUpload(url, obj, callBack, bMulti, bShowBtn,title){
	selectList(url,  {multi:bMulti, width:780, height:440, title:title, showbtn: bShowBtn}, 
    function(data){			
		if(callBack) callBack(data);
    });	
}

function doSelectSingleProduct(obj, callBack){
	doSelectProduct(obj, callBack, false, true, "");
}

function doSelectMultiProduct(obj, callBack){
	doSelectProduct(obj, callBack, true, true, "");
}

function doSelectProduct(obj, callBack, bMulti, bShowBtn, rcv, owner){
	
	selectList("pd.xdo?act=qlist&rcv=" + rcv +"&ownerno=" + owner,  {multi:bMulti, width:800, height:440, title:"选择商品", showbtn: bShowBtn}, 
    function(data){			
		if(callBack) callBack(data);
    });	
}

function doSelectProduct(obj, callBack, bMulti, bShowBtn, rcv, owner ,flag){
	selectList("pd.xdo?act=qlist&rcv=" + rcv +"&ownerno=" + owner +"&setflag="+flag, {multi:bMulti, width:800, height:440, title:"选择商品", showbtn: bShowBtn}, 
    function(data){			
		if(callBack) callBack(data);
    });	
}

function doSelectSingleProductCategory(obj, callBack){
	selectTree("pdgrp.xdo?act=qtree", {multi:false,width:400, height:500}, 
	function(data){			
		if(callBack) callBack(data);
    });	
}

function selectSingleContract(obj, callBack, options){
	var opt = $.extend({flow:"", co:""}, options);
	selectList("contract.xdo?act=qlist&flow=" + opt.flow + "&cname=" + opt.co,  {width:800, height:500, multi:false, title:"选择合同"}, 				
		function(data){			
			if(callBack) callBack(data);		
		});	
}

function selectSingleTrade(obj, callBack, options){
	var opt = $.extend({cmpl:true, stockok:true, co:""}, options);
	selectList("trade.xdo?act=qlist&stockok=" + (opt.stockok ? 2 : "") + "&custom=" + opt.co,  {width:800, height:500, multi:false, title:"选择销售单"}, 				
		function(data){			
			if(callBack) callBack(data);		
		});	
}

function doSelectSingleCode(grp, okBack, cancelBack){
	selectList("code.xdo?act=qlist&grp=" + grp,  {multi:false,width:400, height:500, title:"选择代码"}, 
		okBack,
		cancelBack
	);  
}

function doSelectMultiCode(grp, okBack, cancelBack){
	selectList("code.xdo?act=qlist&grp=" + grp,  {multi:true,width:400, height:500, title:"选择代码"}, 
		okBack,
		cancelBack
	);  
}

function doSelectOwnerCode(grp, okBack, cancelBack){

	selectList("ownerinfo.xdo?act=qlist&grp=" + grp,  {multi:false,width:400, height:400, title:"选择货主"}, 
		okBack,
		cancelBack
	); 
}
function doSelectWareHouseCode(grp, okBack, cancelBack){

	selectList("warehouse.xdo?act=qlist&grp=" + grp,  {multi:false,width:500, height:500, title:"选择所属仓库"}, 
		okBack,
		cancelBack
	);  
}
//
//function getColumnNames(id){
//  if(id == ""){
//    return [{*foreach from=$TableList.Names item=item*}'{*$item*}',{*/foreach*}];
//  }
//  else{
//    var tbls = new Array();
//    {*foreach from=$Tables key=key item=tbl*}
//    tbls['{*$key*}'] = [{*foreach from=$tbl.Names item=item*}'{*$item*}',{*/foreach*}];
//    {*/foreach*}
//    return tbls[id];
//  }
//	
//}
//function getColumnModels(id){
//  if(id == ""){
//    return [{*foreach from=$TableList.Models item=item*}{*$item*},{*/foreach*}];
//  }
//  else{
//    var tbls = new Array();
//    {*foreach from=$Tables key=key item=tbl*}
//    tbls['{*$key*}'] = [{*foreach from=$tbl.Models item=item*}{*$item*},{*/foreach*}];
//    {*/foreach*}
//    return tbls[id];
//  }
//}

function getGridWidth() {
	var w = $("body > .ui-layout-center").width() - 3;
	return w;
}

function getGridHeight() {
	var offset = 80;
	var conditionHeight = 0;
	var detailGridHeight = 0;
	if ($(".oms-search-fieldset")) {
		conditionHeight = $(".oms-search-fieldset").height();
	}
	if ($("#bodyGrid")) {
		detailGridHeight = $("#bodyGrid").height();
	}
	return getWorkSpaceHeight() - conditionHeight - detailGridHeight - offset;
}

function getDetailGridHeight() {
	var offset = 65;
	var bodyGridDivHeight = 100;
	if ($("#bodyGrid")) {
		bodyGridDivHeight = $("#bodyGrid").height();
	}
	return bodyGridDivHeight - offset;
}

function getDetailFooterGridHeight() {
	var footerHeight = 23;
	return getDetailGridHeight() - footerHeight;
}

function setDetailFormHeight() {

	var offset = 40;
	var bodyGridDivHeight = 100;
	if ($("#bodyGrid")) {
		bodyGridDivHeight = $("#bodyGrid").height();
	}
	var height = bodyGridDivHeight - offset;

	$("#bodyGrid > .oms-input-div > fieldset").each(function() {
		$(this).height(height);
	});
}
