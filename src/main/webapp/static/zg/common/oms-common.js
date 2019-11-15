(function($) {
	$.fn.openWin = function(url, options, _return) {
		var opts = $.extend({
			name : "dialog-win",
			title : "",
			width : 400,
			modal : true,
			closeOnEscape : true,
			draggable : true,
			resizable : false // 不能设置为true
		}, options);
		removeDialog(opts.name);
		var html = '<div class="x-dialog" id="'
				+ opts.name
				+ '" name="'
				+ opts.name
				+ '">'
				+ ' <iframe src="'
				+ url
				+ '" frameBorder="0" style="border: 0; " id="x-dialog-frame" name="x-dialog-frame" scrolling="auto" width="100%" height="98%"></iframe>'
				+ '</div>';

		return $(html).dialog(opts);
	};

	$.fn.closeWin = function(name) {
		name = name ? "#" + name : "#dialog-win";
		$(name).dialog('close');
	};
})(jQuery);

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
				//var ix = grid.getInd(this);
				var ix = six;
				if (typeof(lastSid) != "undefined") {
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
					grid.setSelection(row.id, true);
				}
			}
		}
		if (!selected) {
			lastSid = sid;
			grid.setSelection(sid, true);
		} else {
			grid.setSelection(sid, true);
		}
	}
}

// 扩展关联函数
function removeDialog(dlgName) {
	try {
		var d = document.getElementById(dlgName);
		if (d) {
			var p = d.parentNode;
			if (pp = p.parentNode) {
				pp.removeChild(p);
			}
		}
	} catch (e) {
	}
}

function getWorkSpaceHeight() {
	var bodyHeight = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
	return bodyHeight;
}
