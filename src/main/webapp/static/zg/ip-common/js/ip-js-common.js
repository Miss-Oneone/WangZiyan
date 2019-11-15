window.onload = function() {
	// 禁止后退键,作用于Firefox、Opera
	document.onkeypress = banBackSpace;
	// 禁止后退键 ,作用于IE、Chrome
	document.onkeydown = banBackSpace;
}

/**
 * 禁止后退键(Backspace),密码或单行、多行文本框除外
 */
function banBackSpace(e) {
	// 获取event对象
	var ev = e || window.event;
	// 获取事件源
	var obj = ev.target || ev.srcElement;
	// 获取事件源类型
	var type = obj.type || obj.getAttribute('type');

	// 获取作为判断条件的事件类型
	var vReadOnly = obj.readOnly;
	var vDisabled = obj.disabled;

	// 处理undefined值情况
	vReadOnly = (vReadOnly == undefined) ? false : vReadOnly;
	vDisabled = (vDisabled == undefined) ? true : vDisabled;

	// 当敲Backspace键时，事件源类型为密码或单行、多行文本的，
	// 并且readOnly属性为true或disabled属性为true的，则退格键失效
	var flag1 = ev.keyCode == 8
			&& (type == "password" || type == "text" || type == "textarea")
			&& (vReadOnly == true || vDisabled == true);

	// 当敲Backspace键时，事件源类型非密码或单行、多行文本的，则退格键失效
	var flag2 = ev.keyCode == 8 && type != "password" && type != "text"
			&& type != "textarea";

	// 判断
	if (flag1 || flag2) {
		return _stopIt(ev);
	}
}
function _stopIt(e) {
	if (e.returnValue) {
		e.returnValue = false;
	}
	if (e.preventDefault) {
		e.preventDefault();
	}
	return false;
}

/**
 * 全选/全清表格中复选框
 * 
 * @param p_headCboxID
 *            表头中复选框的ID属性值
 * @param p_rowCboxName
 *            表格中行复选框name属性值
 * 
 * @author Ernest
 * @version 2013-11-21
 */
function selAllCboxToggle(p_headCboxID, p_rowCboxName) {
	var headCboxID = document.getElementById(p_headCboxID);
	if (headCboxID.checked == false) {
		$("input[name =" + p_rowCboxName + "]").each(function() {
			$(this).attr("checked", false);
		});
	} else {
		$("input[name =" + p_rowCboxName + "]").each(function() {
			$(this).attr("checked", true);
		});
	}
}

/**
 * 筛选出表格中被选中行的ID主键值，并计数
 * 
 * @param p_rowCboxName
 *            表格中行复选框name属性值
 * @returns 1.选中的数目；2.被选中的ID主键值
 * 
 * @author Ernest
 * @version 2013-11-21
 */
function selIdsCount(p_rowCboxName) {
	// 用于返回
	var retnArr = new Array();
	// 累计被选中复选框的的数目
	var countID = 0;
	// 选中行的ID主键值字符串
	var ids = "";
	var selCboxes = document.getElementsByName(p_rowCboxName);
	for ( var j = 0; j < selCboxes.length; j++) {
		if (selCboxes[j].checked == true) {
			// 用逗号串联所有选中行的ID主键值
			ids += $(selCboxes[j]).next().val() + ",";
			countID += 1;
		}
	}
	// 包含选中行数目和选中行的ID主键值的数组
	retnArr[0] = countID;
	retnArr[1] = ids;
	return retnArr;
}

/**
 * 将Enter键改为Tab键的效果
 * 
 * @param id为在最后一个input
 *            text点击Enter键后需要跳到的下一个组件的id
 * @returns
 * 
 * @author Andy
 * @version 2013-11-21
 */
function changeEnter(id) {
	$('input:text:first').focus();
	$('input:text:first').select();
	var $inp = $('input:text');
	$inp.bind('keydown', function(e) {
		var key = e.which;
		if (key == 13) {
			e.preventDefault();
			var nxtIdx = $inp.index(this) + 1;
			var lastIdx = $inp.index($inp.last());
			if (nxtIdx > lastIdx) {
				$("#" + id).focus();
			} else {
				$(":input:text:eq(" + nxtIdx + ")").focus();
				$(":input:text:eq(" + nxtIdx + ")").select();
			}
		}
	});
}

/**
 * 添加分组控件，并插入到最后一个组的table之后
 * 
 * @param parentID:为添加组的父容器id
 * @param tableClass:复制元素的class属性
 * @param listName:list名称
 * @param treeID:tree控件ID前缀，可为空
 */
function addGroup(parentID, tableClass, listName, treeID) {

	var replaceContent = listName;

	var index = $("." + tableClass + ":last").find("input[name='index']").val();
	var newIndex = parseInt(index) + 1;
	var oldContent = replaceContent + index;
	var newContent = replaceContent + newIndex;

	// 获取模板HTML
	var model = $("." + tableClass + ":last").html();

	// 替换实体控件索引
	var faceName = eval("/\\[" + index + "]/g");
	model = model.replace(faceName, "[" + newIndex + "]");

	var f = eval("/\auditorDeptTree" + index + "/g");
	model = model.replace(f, "auditorDeptTree" + newIndex);

	model = model.replace("h.find(\"iframe\")[1]", "h.find(\"iframe\")[0]");

	model = "<table class='" + tableClass + "' style='width: auto;'> " + model
			+ " </table>";

	// 添加模板
	$("#" + parentID).append(model);
	// 替换隐藏控件索引
	$("." + tableClass + ":last").find("input[name='index']").val(newIndex);

	// 清空元素value
	var it = $("." + tableClass + ":last").find(":input");
	$.each(it, function() {
		if ($(this).attr("name") != "index")
			$(this).val("");
	});
}

/**
 * 删除当前选择控件组table
 * 
 * @param e:当前择控件组
 */
function delGroup(e) {
	// 累计删除table的个数
	var delCount = 0;
	// 该区域table总个数
	var table = $(e).parents("table").parent().find("table");
	$.each(table, function() {
		var display = $(this).css("display");
		if (display == "none")
			delCount++;
	});

	if (table.length == delCount + 1) {
		top.$.jBox.alert("最后一组数据不能删除！", "提示");
	} else {
		var delFlag = $(e).parents("table").find("input[name$='delFlag']");
		$.each(delFlag, function() {
			$(this).val("1");
		});

		$(e).parents("table").css("display", "none");
	}
}

/**
 * 验证金额输入
 */
function formatMoney() {
	$("input[class*='money']").each(function() {
		var str = $(this).val();
		$(this).keyup(function(evt) {
			str = $(this).val();
			evt = (evt) ? evt : ((window.event) ? window.event : "") // 兼容IE和Firefox获得keyBoardEvent对象
			var key = evt.keyCode ? evt.keyCode : evt.which; // 兼容IE和Firefox获得keyBoardEvent对象的键值
			if (key >= 33 && key <= 40) {
				evt.preventDefault();
				evt.returnValue = false;
				return false;
			}
			$(this).val(Convert(str));
		});

		if (str != "") {
			$(this).val(Convert(str));
		}
	});
}

/**
 * 选择输入金额添加千分符
 * 
 * @param amtStr:金额字符串
 */
function Convert(amtStr) {
	var a, renum = '';
	var j = 0;
	var a1 = '', a2 = '', a3 = '';
	var tes = /^-/;
	a = amtStr.replace(/,/g, "");
	a = a.replace(/[^-\.,0-9]/g, ""); // 删除无效字符
	a = a.replace(/(^\s*)|(\s*$)/g, ""); // trim
	if (tes.test(a))
		a1 = '-';
	else
		a1 = '';
	a = a.replace(/-/g, "");
	if (a != "0" && a.substr(0, 2) != "0.")
		a = a.replace(/^0*/g, "");
	j = a.indexOf('.');
	if (j < 0)
		j = a.length;
	a2 = a.substr(0, j);
	a3 = a.substr(j);
	j = 0;
	for (i = a2.length; i > 3; i = i - 3) {
		renum = "," + a2.substr(i - 3, 3) + renum;
		j++;
	}
	renum = a1 + a2.substr(0, a2.length - j * 3) + renum + a3;

	return renum;
}

//对Date的扩展，将 Date 转化为指定格式的String
//月(M)、日(d)、小时(h)、分(m)、秒(s)、季度(q) 可以用 1-2 个占位符，
//年(y)可以用 1-4 个占位符，毫秒(S)只能用 1 个占位符(是 1-3 位的数字)
//例子：
//(new Date()).Format("yyyy-MM-dd hh:mm:ss.S") ==> 2006-07-02 08:09:04.423
//(new Date()).Format("yyyy-M-d h:m:s.S")      ==> 2006-7-2 8:9:4.18
//author: meizz
Date.prototype.Format = function(fmt)
{
	var o = {
		"M+" : this.getMonth()+1,                 //月份 
		"d+" : this.getDate(),                    //日 
		"h+" : this.getHours(),                   //小时 
		"m+" : this.getMinutes(),                 //分 
		"s+" : this.getSeconds(),                 //秒 
		"q+" : Math.floor((this.getMonth()+3)/3), //季度 
		"S"  : this.getMilliseconds()             //毫秒 
	};
	if(/(y+)/.test(fmt))
		fmt=fmt.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length));
	for(var k in o)
		if(new RegExp("("+ k +")").test(fmt))
			fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length)));
	return fmt;
}

function calDate(str, millisecond, fmt) {
	str =  str.replace(/-/g,"/");
	var utc = Date.parse(str);
	var d = new Date(utc+millisecond);
	return d.Format(fmt);
}

function gotoPage(href, str) {
	top.$("#min_title_list .active").html("<span data-href='"+href+"'><font class='menu-offset'>"+str+"</font></span><i></i><em></em>");
	top.$('#min_title_list').width("auto");
	
	this.location.href = href;
}

/**
 * 校验11位集装箱号的对错
 * 正确的返回true，错误的返回false
 * 
 * @param strCode:11位集装箱号
 */
function VerifyContainerCode(strCode) {
	strCode=strCode.trim().toUpperCase();
	var Charcode = "0123456789A?BCDEFGHIJK?LMNOPQRSTU?VWXYZ";
	if (strCode.length != 11)
	{
		return false;
	}
	var result = true;
	var num = 0;
	for (var i = 0; i < 10; i++) {
		var idx = Charcode.indexOf(strCode[i]);
		if (idx == -1 || Charcode[idx] == '?') {
			result = false;
			break;
		}
		idx = idx * Math.pow(2, i);
		num += idx;
	}
	if(result){
		num = (num % 11) % 10;
		result = parseInt(strCode[10]) == num;
	}
	return result;
}