function createGridList(gridId, pagerId, options) {
	var initWidth = 800;
	initWidth = $(".content-detail").width()-17;//初始化宽度为了解决分辨率较低，页面显示不流畅的问题
	var opt = $.extend({
	    datatype: "local",
	    url : typeof(getPostURL) == "undefined" ? "" : getPostURL(),
	    mtype : 'POST',
	    rowNum: 100,
	    rowList: [100, 500, 1000],
	    pager: pagerId,
	    viewrecords: true,
	    sortable:true,
		jsonReader : {
			id : options.id == null ? "id" : options.id,
			root : "rows",
			page : "page",
			total : "total",
			records : "records",
			repeatitems : false
		},
		rownumbers : true,
		rownumWidth : 50,
		multiselect : false,
		multiboxonly : true,
		width:initWidth,
		shrinkToFit : false,
//		beforeSelectRow : multiSelectHandler
/*
		loadComplete : function(xhr) {
			var r = $(gridId).getUserDataItem("result");
			if (r != "1"
					&& $(gridId).getGridParam("datatype") != "local") {
				xalert("数据加载失败["
						+ $(gridId).getUserDataItem("msg")
						+ "]");
			}
			//setPageDisabled(false);
			try {
				if (typeof (eval(gridId.substr(1)
						+ 'LoadComplete')) == 'function') {
					eval(gridId.substr(1) + 'LoadComplete()');
				}
			} catch (e) {
			}
		},
		loadError : function(xhr, status, error) {
			if (xhr.responseText.indexOf("loginForm") >= 0) {
				xalert("数据加载失败：会话已超时，请重新登录！");
				// 执行页面跳转
				if (self.frameElement
						&& self.frameElement.tagName == "IFRAME") {
					parent.location.reload();
				} else {
					location.reload();
				}
			} else {
				xalert("数据加载失败[" + status + "]" + error);
			}
		}
*/
	}, options);
	$(gridId).jqGrid(opt);
	$(gridId).jqGrid('setFrozenColumns');
	$(gridId).jqGrid('navGrid', pagerId, {
		add : typeof(options.navAdd) == "undefined" ? false : options.navAdd,
		edit : typeof(options.navEdit) == "undefined" ? false : options.navEdit,
		del : typeof(options.navDel) == "undefined" ? false : options.navDel,
		search : typeof(options.navSearch) == "undefined" ? false : options.navSearch,
		refresh : typeof(options.navRefresh) == "undefined" ? false : options.navRefresh
	});
	if (opt.customizeColumn) {
		$(gridId).jqGrid('navButtonAdd', pagerId, {
			caption : "",
			title : "Choose column",
			onClickButton : function() {
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
							result.show = show;
							result.hide = hide;
							alert(result);
							$.post(ctx + "/sys/gridItem/customizeSave", result);
						}
					}
				});
			}
		});
	}
}

function initGridBtn(pagerId, btnAreaId) {
	$(pagerId + "_left").attr("style","width:60%");
	if(window.screen.width <=1024 && sunsail_browser.isMobile){
		$(pagerId + "_right").attr("style","width:26%");//为了支持分辨率小于等于1024*768
	}else{
		$(pagerId + "_right").attr("style","width:20%");
	}
	$.each($(btnAreaId).children(), function() {
		$(pagerId + "_left").append($(this).prop("outerHTML"));
	});
	var $gridBtnSpanList = $($(pagerId + "_left").find(".gridBtnSpan")).not(".hide")
	var sumWidth=0;
	$gridBtnSpanList.each(function(){
		sumWidth = sumWidth + $(this).children().width();
		if(sumWidth > $(pagerId + "_left").width()){
			return false;
		}
	});
	var tableId = pagerId.substring(0,pagerId.length-5)+"Table";
	$( tableId ).on( "touchstart", function(){
		resizeFrozenTableBdiv(tableId);
    });
	$( tableId ).on( "focus", function(){
		resizeFrozenTableBdiv(tableId);
    });

	
}

function getData(resultModelStr) {
	if (typeof(resultModelStr) == "undefined" || resultModelStr == "") {
		return "";
	} else {
		return eval("(" + resultModelStr + ")").dataList;
	}
}
/*由于ipad上没有滚动条，所以冻结列的div的高度就不够，所以需要聚焦下，重新计算冻结列的div的高度 */
function resizeFrozenTableBdiv(selector){
	var frozenHeight = $(selector).parents(".ui-jqgrid-bdiv").height();
	if(frozenHeight){
		if(window.screen.width <= 1024 && sunsail_browser.isMobile){
			$(selector +"_frozen").parent().height(frozenHeight);
		}else{
			$(selector +"_frozen").parent().height(frozenHeight-16);
		}
	}
}
function initGridSize(selector, pagerId) {
	var gwrapperH = $("#gview_" + selector).parent().parent().height();
	var gwrapperW = $("#gview_" + selector).parent().parent().width();
	$("#gbox_" + selector).width(gwrapperW -17);
	$("#gview_" + selector).width(gwrapperW -17);
	var gviewTbl = $("#" + selector).parentsUntil("#gview_" + selector).parent();
	var ghdiv = gviewTbl.find(".ui-jqgrid-hdiv");
	var gbdiv = gviewTbl.find(".ui-jqgrid-bdiv");
	var gsdiv = gviewTbl.find(".ui-jqgrid-sdiv");
	var pagerH = $("#" + pagerId).height();
	if ($("#gview_" + selector).width() < gbdiv.width()) {
		//防止冻结列数时无效
		var w = $("#gview_" + selector).width();
		ghdiv.first().width(w);
		gbdiv.first().width(w);
		gsdiv.first().width(w);
		$("#" + pagerId).width($("#gview_" + selector).width());
	} else {
		var w = $("#gview_" + selector).width();
		ghdiv.first().width(w);
		gbdiv.first().width(w);
		gsdiv.first().width(w);
		$("#" + pagerId).width(w);
	}
	var gbdivH = gwrapperH - ghdiv.height() - gsdiv.height() - pagerH - 4;
	if (gwrapperW - 17 < gbdiv.width()) {
		gbdivH = gwrapperH - ghdiv.height() - gsdiv.height() - pagerH - 18;
	}
	//只设置表格高度，不设置冻结列高度.
	gbdiv.first().height(gbdivH);
	
	if(window.screen.width <= 1024 && sunsail_browser.isMobile){
		var frozenHeight = $("#"+ selector ).parents(".ui-jqgrid-bdiv").height();
		if(frozenHeight){
			$("#"+ selector +"_frozen").parent().height(frozenHeight);
		}
		//为了支持分辨率小于等于1024*768
	}else{
		//设置冻结列高度.
		$("#"+ selector +"_frozen").parent().height(gbdivH - 16);
	}
	
}

function multiSelectHandler(sid, e) {
	var grid = $(e.target).closest("table.ui-jqgrid-btable");
	var ts = grid[0], td = e.target;
	var scb = $(td).hasClass("cbox");
	if ((td.tagName == 'INPUT' && !scb) || td.tagName == 'A') {
		return true;
	}
	var sel = grid.getGridParam('selarrrow');
	var selected = $.inArray(sid, sel) >= 0;
	if (e.ctrlKey || (scb && (selected || !e.shiftKey))) {
		lastSid = sid;
		if (!grid[0].id.endWith("_frozen")) {
			grid.setSelection(sid, true);
		}
	} else {
		if (e.shiftKey) {
			var six = grid.getInd(sid);
			var min = six, max = six;
			$.each(sel, function() {
				// var ix = grid.getInd(this);
				var ix = six;
				if (typeof (lastSid) != "undefined") {
					ix = grid.getInd(lastSid);
				}
				if (ix < min)
					min = ix;
				if (ix > max)
					max = ix;
			});
			while (min <= max) {
				var row = ts.rows[min++];
				var rid = row.id;
				if (rid != sid && $.inArray(rid, sel) < 0) {
					if (!grid[0].id.endWith("_frozen")) {
						grid.setSelection(row.id, false);
					}
				}
			}
		} else if (!selected) {
			if (!grid[0].id.endWith("_frozen")) {
				grid.resetSelection();
			}
		}
		if (!selected) {
			lastSid = sid;
			if (!grid[0].id.endWith("_frozen")) {
				grid.setSelection(sid, true);
			}
		} else {
			var osr = grid.getGridParam('onSelectRow');
			if ($.isFunction(osr)) {
				osr(sid, true);
			}
		}
	}
	return true;
}

function getColNames(colNamesStr) {
	return eval(colNamesStr);
}

function getColModel(colModelStr) {
	return eval(colModelStr);
}

(function($){
	$.jgrid.extend({
		inlineNavById : function (elem, o) {
			o = $.extend(true,{
				edit: true,
				add: true,
				save: true,
				cancel: true,
				addParams : {addRowParams: {extraparam: {}}},
				editParams : {},
				restoreAfterSelect : true
			}, $.jgrid.nav, o ||{});
			return this.each(function(){
				if (!this.grid ) { return; }
				var $t = this, onSelect, gID = $.jgrid.jqID($t.p.id);
				$t.p._inlinenav = true;
				// detect the formatactions column
				if(o.addParams.useFormatter === true) {
					var cm = $t.p.colModel,i;
					for (i = 0; i<cm.length; i++) {
						if(cm[i].formatter && cm[i].formatter === "actions" ) {
							if(cm[i].formatoptions) {
								var defaults =  {
									keys:false,
									onEdit : null,
									onSuccess: null,
									afterSave:null,
									onError: null,
									afterRestore: null,
									extraparam: {},
									url: null
								},
								ap = $.extend( defaults, cm[i].formatoptions );
								o.addParams.addRowParams = {
									"keys" : ap.keys,
									"oneditfunc" : ap.onEdit,
									"successfunc" : ap.onSuccess,
									"url" : ap.url,
									"extraparam" : ap.extraparam,
									"aftersavefunc" : ap.afterSave,
									"errorfunc": ap.onError,
									"afterrestorefunc" : ap.afterRestore
								};
							}
							break;
						}
					}
				}
				if(o.add) {
					$($t).jqGrid('navButtonAddNotCss', elem,{
						caption : o.addtext,
						title : o.addtitle,
						buttonicon : o.addicon,
						id : $t.p.id+"_iladd",
						onClickButton : function () {
							$($t).jqGrid('addRow', o.addParams);
							if(!o.addParams.useFormatter) {
								$("#"+gID+"_ilsave").removeClass('ui-state-disabled');
								$("#"+gID+"_ilcancel").removeClass('ui-state-disabled');
								$("#"+gID+"_iladd").addClass('ui-state-disabled');
								$("#"+gID+"_iledit").addClass('ui-state-disabled');
							}
						}
					});
				}
				if(o.edit) {
					$($t).jqGrid('navButtonAddNotCss', elem,{
						caption : o.edittext,
						title : o.edittitle,
						buttonicon : o.editicon,
						id : $t.p.id+"_iledit",
						onClickButton : function () {
							var sr = $($t).jqGrid('getGridParam','selrow');
							if(sr) {
								$($t).jqGrid('editRow', sr, o.editParams);
								$("#"+gID+"_ilsave").removeClass('ui-state-disabled');
								$("#"+gID+"_ilcancel").removeClass('ui-state-disabled');
								$("#"+gID+"_iladd").addClass('ui-state-disabled');
								$("#"+gID+"_iledit").addClass('ui-state-disabled');
							} else {
								showError(noDataSelectedMsg);
							}
						}
					});
				}
				if(o.save) {
					$($t).jqGrid('navButtonAddNotCss', elem,{
						caption : o.savetext || '',
						title : o.savetitle || 'Save row',
						id : $t.p.id+"_ilsave",
						onClickButton : function () {
							var sr = $t.p.savedRow[0].id;
							if(sr) {
								var opers = $t.p.prmNames,
								oper = opers.oper, tmpParams = o.editParams;
								if($("#"+$.jgrid.jqID(sr), "#"+gID ).hasClass("jqgrid-new-row")) {
									o.addParams.addRowParams.extraparam[oper] = opers.addoper;
									tmpParams = o.addParams.addRowParams;
								} else {
									if(!o.editParams.extraparam) {
										o.editParams.extraparam = {};
									}
									o.editParams.extraparam[oper] = opers.editoper;
								}
								if( $($t).jqGrid('saveRow', sr, tmpParams) ) {
									$($t).jqGrid('showAddEditButtons');
								}
							} else {
								showError(noDataSelectedMsg);
							}
						}
					});
					$("#"+gID+"_ilsave").addClass('ui-state-disabled');
				}
				if(o.cancel) {
					$($t).jqGrid('navButtonAddNotCss', elem,{
						caption : o.canceltext || '',
						title : o.canceltitle || 'Cancel row editing',
						buttonicon : o.cancelicon,
						id : $t.p.id+"_ilcancel",
						onClickButton : function () {
							var sr = $t.p.savedRow[0].id, cancelPrm = o.editParams;
							if(sr) {
								if($("#"+$.jgrid.jqID(sr), "#"+gID ).hasClass("jqgrid-new-row")) {
									cancelPrm = o.addParams.addRowParams;
								}
								$($t).jqGrid('restoreRow', sr, cancelPrm);
								$($t).jqGrid('showAddEditButtons');
							} else {
								showError(noDataSelectedMsg);
							}
						}
					});
					$("#"+gID+"_ilcancel").addClass('ui-state-disabled');
				}
				if(o.restoreAfterSelect === true) {
					if($.isFunction($t.p.beforeSelectRow)) {
						onSelect = $t.p.beforeSelectRow;
					} else {
						onSelect =  false;
					}
					$t.p.beforeSelectRow = function(id, stat) {
						var ret = true;
						if($t.p.savedRow.length > 0 && $t.p._inlinenav===true && ( id !== $t.p.selrow && $t.p.selrow !==null) ) {
							if($t.p.selrow === o.addParams.rowID ) {
								$($t).jqGrid('delRowData', $t.p.selrow);
							} else {
								$($t).jqGrid('restoreRow', $t.p.selrow, o.editParams);
							}
							$($t).jqGrid('showAddEditButtons');
						}
						if(onSelect) {
							ret = onSelect.call($t, id, stat);
						}
						return ret;
					};
				}

			});
		},
		navButtonAddNotCss : function (elem, p) {
			p = $.extend({
				caption : "newButton",
				title: '',
				onClickButton: null,
				position : "last",
				cursor : 'pointer'
			}, p ||{});
			return this.each(function() {
				if( !this.grid)  {return;}
				if( typeof elem === "string" && elem.indexOf("#") !== 0) {elem = "#"+$.jgrid.jqID(elem);}
//				var findnav = $(".navtable",elem)[0], 
				$t = this;
//				if (findnav) {
//					if( p.id && $("#"+$.jgrid.jqID(p.id), findnav)[0] !== undefined )  {return;}
					$("#"+$.jgrid.jqID(p.id), $(elem)[0])
					.attr("title",p.title  || "")
					.click(function(e){
						if (!$(this).hasClass('ui-state-disabled')) {
							if ($.isFunction(p.onClickButton) ) {p.onClickButton.call($t,e);}
						}
						return false;
					})
					.hover(
						function () {
							if (!$(this).hasClass('ui-state-disabled')) {
								$(this).addClass('ui-state-hover');
							}
						},
						function () {$(this).removeClass("ui-state-hover");}
					);
//				}
			});
		}
	});
})(jQuery);


$.jgrid.extend({
	delRowData : function(rowid) {
		var success = false, rowInd, ia;
		this.each(function() {
			var $t = this;
			rowInd = $($t).jqGrid('getGridRowById', rowid);
			if(!rowInd) {return false;}
				$(rowInd).remove();
				$t.p.records--;
				$t.p.reccount--;
				$t.updatepager(true,false);
				success=true;
				if($t.p.multiselect) {
					ia = $.inArray(rowid,$t.p.selarrrow);
					if(ia !== -1) { $t.p.selarrrow.splice(ia,1);}
				}
				if ($t.p.multiselect && $t.p.selarrrow.length > 0) {
					$t.p.selrow = $t.p.selarrrow[$t.p.selarrrow.length-1];
				} else {
					if($t.p.selrow == rowid){
						$t.p.selrow = null;
					}
				}
			if($t.p.datatype === 'local') {
				var id = $.jgrid.stripPref($t.p.idPrefix, rowid),
				pos = $t.p._index[id];
				if(pos !== undefined) {
					$t.p.data.splice(pos,1);
					$t.refreshIndex();
				}
			}
			if( $t.p.altRows === true && success ) {
				var cn = $t.p.altclass;
				$($t.rows).each(function(i){
					if(i % 2 === 1) { $(this).addClass(cn); }
					else { $(this).removeClass(cn); }
				});
			}
		});
		return success;
	},

	showSaveCancelButtons : function()  {
		return this.each(function(){
			if (!this.grid ) { return; }
			var gID = $.jgrid.jqID(this.p.id);
			$("#"+gID+"_ilsave").removeClass('ui-state-disabled');
			$("#"+gID+"_ilcancel").removeClass('ui-state-disabled');
			$("#"+gID+"_iladd").addClass('ui-state-disabled');
			$("#"+gID+"_iledit").addClass('ui-state-disabled');
		});
	}
});
