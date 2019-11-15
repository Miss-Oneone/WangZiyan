function createGridList(gridId, pagerId, options) {
	var opt = $.extend({
	    datatype: "local",
	    url : typeof(getPostURL) == "undefined" ? "" : getPostURL(),
	    mtype : 'POST',
	    rowNum: 100,
	    rowList: [100, 500, 1000],
	    pager: pagerId,
	    viewrecords: true,
		jsonReader : {
			id : options.id == null ? "id" : options.id,
			root : "rows",
			page : "page",
			total : "total",
			records : "records",
			repeatitems : false
		},
		rownumbers : true,
		multiselect : false,
		multiboxonly : true,
		shrinkToFit : false,
		beforeSelectRow : multiSelectHandler
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
			title : "选择列",
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
	$.each($(btnAreaId).children(), function() {
		$(pagerId + "_left").append($(this).prop("outerHTML"));
	});
	//$(pagerId + "_left").append($("#spanBtnSave").prop("outerHTML"));
	//$("#mainPager_left").append($("#spanBtnDownload").prop("outerHTML"));
}

function getData(resultModelStr) {
	if (typeof(resultModelStr) == "undefined" || resultModelStr == "") {
		return "";
	} else {
		return eval("(" + resultModelStr + ")").dataList;
	}
}

function getGridWidth() {
	var offset = 5;
	var w = $(".content-detail").width() - offset;
	return w;
}

function getGridHeight() {
	var offset = 58;
	var bodyHeight = $(window).height() - offset;
	var h = bodyHeight - $(".content-detail").offset().top;
	return h;
}

function createGridList_hist(gridId, pagerId, options) {
	$("input:button, button", "div").button();
	var tblKey = "";
	if (options.tblKey)
		tblKey = options.tblKey;
	var opt = $.extend({
		datatype : "local",
		url : getPostURL(tblKey),
		mtype : 'POST',
		jsonReader : {
			id : options.id == null ? "id" : options.id,
			root : "rows",
			page : "page",
			total : "total",
			records : "records",
			repeatitems : false
		},
		rowNum : 100,
		rowList : [ 100, 500, 1000 ],
		rownumbers : true,
		viewrecords : true,
		multiselect : true,
		multiboxonly : true,
		shrinkToFit : false,
		pager : pagerId,
		beforeSelectRow : multiSelectHandler,
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
	}, options);
	$(gridId).jqGrid(opt);
	if (pagerId) {
		$(pagerId + "_right").width(140);
	}
	if (opt.customizeColumn) {
		$(gridId).jqGrid('navGrid', pagerId, {
			add : false,
			edit : false,
			del : false,
			search : false,
			refresh : false
		});
		$(gridId).jqGrid('navButtonAdd', pagerId, {
			caption : "",
			title : "选择列",
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
							$.post(ctx + "/sys/gridItem/customizeSave", result);
						}
					}
				});
			}
		});
	}

	if (options.showSelectedCount == true) {
		$("<td id='showSelectedCount' style='float:right;padding-top:6px;'><label>选中条数:</label><label id='selectedCount' style='width:300px;'></label></td>").insertAfter($(pagerId + "_left"));
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
		grid.setSelection(sid, true);
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
					grid.setSelection(row.id, false);
				}
			}
		} else if (!selected) {
			grid.resetSelection();
		}
		if (!selected) {
			lastSid = sid;
			grid.setSelection(sid, true);
		} else {
			var osr = grid.getGridParam('onSelectRow');
			if ($.isFunction(osr)) {
				osr(sid, true);
			}
		}
	}
}
