/*浏览器对象*/
var sunsail_browser = {
	language:(navigator.browserLanguage || navigator.language).toLowerCase(),
	isMobile:function(){//是否为移动终端
		if(navigator.userAgent.toLowerCase().indexOf("mobile") > -1) {
			return true;
		}else{
			return false;
		}
	}(),
	isIpad:function(){//是否是ipad移动终端
		if(navigator.userAgent.toLowerCase().indexOf("ipad") > -1) {
			return true;
		}else{
			return false;
		}
	}(),
	isAndroid:function(){//android终端
		if(navigator.userAgent.toLowerCase().indexOf("android") > -1) {
			return true;
		}else{
			return false;
		}
	}()
}
if (!HTMLFormElement.prototype.reportValidity) {
	HTMLFormElement.prototype.reportValidity = function() {
		var result = false;
		var formId = $(this).attr("id");
		if ($("#" + formId)[0].checkValidity()) {
			result = true;
		} else {
			$("#" + formId).append(
					"<button id=\"tmp_submit\" type=\"submit\" /> ");
			var newBtnObj = $("#" + formId + " #tmp_submit");
			newBtnObj.css("display", "none").click().remove();
		}
		return result;
	}
}

function showSlideMenu(id, thisObj) {
	$("#slideMenu").html($("#" + id).html());
	$.Huifold(".menu_dropdown dl dt", ".menu_dropdown dl dd", "fast", 2,
			"click");
	$("#Hui-nav ul li").each(function() {
		$(this).css("background", "none");
	});
	$(thisObj).parent("li")
			.css("background-color", "rgba(160, 192, 214, 0.32)");
}

function showFormMsg(resultType, resultMsg) {
	if (resultType < 0) {
		$("#message").html(
				'<div class="Huialert Huialert-danger formMsg">' + resultMsg
						+ '</div>');
	} else {
		if (resultMsg != '') {
			$("#message").html(
					'<div class="Huialert Huialert-success formMsg">'
							+ resultMsg + '</div>');
		} else {
			$("#message")
					.html(
							'<div class="Huialert Huialert-success formMsg">&nbsp;</div>');
		}
	}
}

function showTip(msg, time) {
	var displayTime = 1000;
	if (typeof (time) != "undefined") {
		displayTime = time;
	}
	layer.msg(msg, {
		icon : 1,
		time : displayTime
	});
}

function showAlert(msg) {
	layer.alert(msg, {
		icon : 1
	});
}

function showError(msg) {
	layer.alert(msg, {
		icon : 2
	});
}

function showSuccess(msg) {
	layer.alert(msg, {
		icon : 1
	});
}

String.prototype.endWith = function(s) {
	if (s == null || s == "" || this.length == 0 || s.length > this.length)
		return false;
	if (this.substring(this.length - s.length) == s)
		return true;
	else
		return false;
	return true;
}

String.prototype.startWith = function(s) {
	if (s == null || s == "" || this.length == 0 || s.length > this.length)
		return false;
	if (this.substr(0, s.length) == s)
		return true;
	else
		return false;
	return true;
}

String.prototype.format = function(args) {
    var result = this;
    if (arguments.length > 0) {
        if (arguments.length == 1 && typeof (args) == "object") {
            for (var key in args) {
                if(args[key]!=undefined){
                    var reg = new RegExp("({" + key + "})", "g");
                    result = result.replace(reg, args[key]);
                }
            }
        }
        else {
            for (var i = 0; i < arguments.length; i++) {
                if (arguments[i] != undefined) {
                    var reg = new RegExp("({[" + i + "]})", "g");
                    result = result.replace(reg, arguments[i]);
                }
            }
        }
    }
    return result.toString();
}

/**
 * 格式化数字显示方式
 * 
 * @param numObj
 *            数字控件
 * @param precision
 *            小数位数
 */
function formatDecimal(numObj, precision) {

	if (numObj.value == "") {
		return;
	}

	var pnumber = numObj.value;
	if (isNaN(pnumber)) {
		numObj.value = 0; // 默认值置为0
		return;
	}

	var snum = new String(pnumber);
	var sec = snum.split('.');
	var whole = parseFloat(sec[0]);
	var result = '';

	if (sec.length > 1) {
		var dec = new String(sec[1]);
		dec = String(parseFloat(sec[1])
				/ Math.pow(10, (dec.length - precision)));
		dec = String(whole + Math.round(parseFloat(dec))
				/ Math.pow(10, precision));
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

function validateForm(selector) {
	if ($(selector)[0].reportValidity()) {
		return true;
	}
	return false;
}

function initSelect(id, data, initFlag, requiredFlag, readonlyFlag, enableFlag, width, defaultValue) {
	$("#" + id + " > option[value!='']").remove();
	for (var i = 0; i < data.length; i++) {
		if (initFlag && defaultValue == data[i].value) {
			$("#" + id).append('<option value="' + data[i].value + '" selected>' + data[i].text + '</option>');
		} else {
			$("#" + id).append('<option value="' + data[i].value + '">' + data[i].text + '</option>');
		}
	}
	$("#" + id).select2({
		width : width,
		allowClear : !requiredFlag,
		matcher : function(term, text) {
			return pinyinMatcher(term, text);
		}
	});
	$("#" + id).select2("readonly", readonlyFlag);
	$("#" + id).select2("enable", enableFlag);
	if (requiredFlag) {
		$("#" + id).trigger("change");
	}
}

function initPageSelect(id, url, parameterData, initFlag, requiredFlag, readonlyFlag, enableFlag, width, defaultValue) {
	var pageSize = 50;
	$("#" + id).select2({
		width : width,
		ajax: {
			type: "POST",
			url: url,
			dataType: 'json',
			quietMillis: 250,
			data: function (term, page) {
				parameterData.searchText = term;
				parameterData.pageNo = page;
				parameterData.pageSize = pageSize;
				parameterData.precise = "";
				return parameterData;
			},
			results: function (data, page) {
				var more = (page * pageSize) < data.count;
				if (!requiredFlag && page == 1) {
					data.list.unshift({"text":"","value":""});
				}
				return { results: data.list, more: more };
			}
		},
		id: function(data) {
			return data.value;
		},
		initSelection : function (element, callback) {
			var value = $(element).val();
			var defaultId = value;
			var defaultText = "";
			parameterData.searchText = value;
			if(value || value == 0 || requiredFlag){
				parameterData.searchText = value;
				parameterData.pageNo = 1;
				parameterData.pageSize = 1;
				if(requiredFlag){
					parameterData.precise = "";
				}else{
					parameterData.precise = "1";
				}
				$.ajaxSetup({ async : false });  //设置成同步
				$.post(url, parameterData, function(result) {
					var resultJson = JSON.parse(result);
					if (resultJson.count > 0) {
						defaultId = resultJson.list[0].value;
						defaultText = resultJson.list[0].text;
						//必输时将第一行数据的值放入隐藏的input中
						$("#" + id).val(defaultId);
					}
				});
				$.ajaxSetup({ async : true });  //设置成异步
			}
			var data = {value: defaultId, text: defaultText};
			callback(data);
		}
	});
	$("#" + id).select2("val", defaultValue);
	//select2中对于 val为空,undefined 等不触发initSelection方法，所以需要手动触发
	$("#" + id).trigger("change");
	$("#" + id).select2("readonly", readonlyFlag);
	$("#" + id).select2("enable", enableFlag);
}

function initMultiSelect(id, data, initFlag, requiredFlag, readonlyFlag, enableFlag, width, defaultMultiValue) {
	$("#" + id + " > option[value!='']").remove();
	var isMultiValue = false;// 是否有多个默认值
	var valueArray = '';
	if (defaultMultiValue) { // 有多个默认值
		valueArray = defaultMultiValue.split(",");
		if (valueArray.length > Number(1)) {
			isMultiValue = true;
		}
	}
	
	outerloop:
	for (var i = 0; i < data.length; i++) {
		if(initFlag){
			if(!isMultiValue){
				if(defaultMultiValue == data[i].value){
					$("#" + id).append('<option value="' + data[i].value + '" selected>' + data[i].text + '</option>');
					continue outerloop;
				}
			}else{
				for (var j = 0; j < valueArray.length; j++) {
					if (valueArray[j] == data[i].value) {
						$("#" + id).append('<option value="' + data[i].value + '" selected>' + data[i].text + '</option>');
						continue outerloop;
					}
				}
			}
		}
		$("#" + id).append('<option value="' + data[i].value + '">' + data[i].text + '</option>');
	}
	$("#" + id).select2({
		width : width,
		matcher : function(term, text) {
			return pinyinMatcher(term, text);
		}
	});
	$("#" + id).select2("readonly", readonlyFlag);
	$("#" + id).select2("enable", enableFlag);
	if (requiredFlag && $("#" + id).val() == null) {
		$("#s2id_" + id + " input").attr("required", "required");
	}
	if (initFlag) {
		$("#" + id).trigger("change");
	}
}

function initPageMultiSelect(id, url, parameterData, initFlag, requiredFlag, readonlyFlag, enableFlag, width, defaultValue) {
	var pageSize = 50;
	var idSelector = "#\\@multiselect_" + id;
	$(idSelector).select2({
		width : width,
		ajax: {
			type: "POST",
			url: url,
			dataType: 'json',
			quietMillis: 250,
			data: function (term, page) {
				parameterData.searchText = term;
				parameterData.pageNo = page;
				parameterData.pageSize = pageSize;
				parameterData.precise = "";
				return parameterData;
			},
			results: function (data, page) {
				var more = (page * pageSize) < data.count;
				if (!requiredFlag && page == 1) {
					data.list.unshift({"text":"","value":""});
				}
				return { results: data.list, more: more };
			}
		},
		id: function(data) {
			return data.value;
		},
		multiple: true,
		initSelection : function (element, callback) {
			
			var value = $(element).val();
			var valueArray = value.split(",");
			var defaultId = "";
			var defaultText = "";
			data = [];
			for (var i = 0; i < valueArray.length; i++) {
				defaultId = valueArray[i];
				parameterData.searchText = defaultId;
				parameterData.pageNo = 1;
				parameterData.pageSize = 1;
				parameterData.precise = "1";
				$.ajaxSetup({ async : false });  //设置成同步
				$.post(url, parameterData, function(result) {
					var resultJson = JSON.parse(result);
					if (resultJson.count > 0) {
						defaultText = resultJson.list[0].text;
					}
				});
				$.ajaxSetup({ async : true });  //设置成异步
				data[i] = {value: defaultId, text: defaultText};
			}
			
			if(requiredFlag && data.length == 1 && data[0].value == ""){
				parameterData.searchText = "";
				parameterData.pageNo = 1;
				parameterData.pageSize = 1;
				parameterData.precise = "";
				$.ajaxSetup({ async : false });  //设置成同步
				$.post(url, parameterData, function(result) {
					var resultJson = JSON.parse(result);
					if (resultJson.count > 0) {
						defaultId = resultJson.list[0].value;
						defaultText = resultJson.list[0].text;
					}
					data = {value: defaultId, text: defaultText};
				});
				$.ajaxSetup({ async : true });  //设置成异步
			}
			callback(data);
		}
	});
	
	if(defaultValue || defaultValue == 0){
		var defaultArray = defaultValue.split(",");
		$(idSelector).select2("val", defaultArray);
	}else{
		$(idSelector).select2("val", "".split(","));
	}
	$(idSelector).trigger("change");
	
	$(idSelector).select2("readonly", readonlyFlag);
	$(idSelector).select2("enable", enableFlag);
}

function initLinkSelect(id, data, initFlag, requiredFlag, width, defaultValue) {
	$("#" + id).empty();
	if (!requiredFlag) {
		$("#" + id).append('<option value=""></option>');
	}
	for (var i = 0; i < data.length; i++) {
		if (initFlag && defaultValue == data[i].value) {
			$("#" + id).append(
					'<option value="' + data[i].value + '" selected>'
							+ data[i].text + '</option>');
		} else {
			$("#" + id).append(
					'<option value="' + data[i].value + '">' + data[i].text
							+ '</option>');
		}
	}
	$("#" + id).select2({
		width : width,
		allowClear : !requiredFlag,
		matcher : function(term, text) {
			return pinyinMatcher(term, text);
		}
	});
	// $("#" + id).select2("val", "");
	$("#" + id).trigger("change");
}

function initCheckBoxs(id, data,multiSelect,defaultMultiValue,readonlyFlag) {

	var isMultiValue = false;// 是否有多个默认值
	var hasDefault = false;
	var valueArray = '';
	if (defaultMultiValue) { // 有多个默认值
		hasDefault = true;
		valueArray = defaultMultiValue.split(",");
		if (valueArray.length > Number(1)) {
			isMultiValue = true;
		}
	}
	var idSpanCheckbox = "\\@span_checkbox_" + id;
	
	outerloop:
	for (var i = 0; i < data.length; i++) {
		var checkedFlag;
		if(data[i].checked == "false"){
			checkedFlag = '' 	
		}else{
			checkedFlag = '" checked="checked">' 
		}
		if(hasDefault) {
			if(!isMultiValue){
				if(defaultMultiValue == data[i].value){
					$("#" + idSpanCheckbox).append('<input type="checkbox" '
							+'id="@checkbox_'+id + '_'+ i
							+'" name="@checkbox_' + id
							+'" value="' + data[i].value 
							+ checkedFlag 
							+ '<label for="@checkbox_'+id + '_' + i+'">'+data[i].text + '</label>'
							+ '</input>&nbsp;&nbsp;');
					continue outerloop;
				}
			}else{
				for (var j = 0; j < valueArray.length; j++) {
					if (valueArray[j] == data[i].value) {
						$("#" + idSpanCheckbox).append('<input type="checkbox" '
								+'id="@checkbox_'+id + '_'+ i
								+'" name="@checkbox_' + id
								+'" value="' + data[i].value 
								+ checkedFlag
								+ '<label for="@checkbox_'+id + '_' + i+'">'+data[i].text + '</label>'
								+ '</input>&nbsp;&nbsp;');
						continue outerloop;
					}
				}
			}
		} 
		
		$("#" + idSpanCheckbox).append('<input type="checkbox" '
				+'id="@checkbox_'+id + '_'+ i
				+'" name="@checkbox_' + id
				+'" value="' + data[i].value + '">' 
				+ '<label for="@checkbox_'+id + '_' + i+'">'+data[i].text + '</label>'
				+ '</input>&nbsp;&nbsp;');
	}
	
	var idCheckbox = "@checkbox_" + id;
	if(readonlyFlag) {
		$(document).on("click",'[name="'+idCheckbox+'"]:checkbox', function() {
			return false;
		});
		if (hasDefault) {
			var value = defaultMultiValue.replace(/\,/g, "','")
			$("#"+id).val("'"+value+"'");
		}
	} else {
		$(document).on("change",'[name="'+idCheckbox+'"]:checkbox', function() {
			var value = "";
			$('[name="'+idCheckbox+'"]:checkbox').each(function () {
				
	            if ($(this).is(":checked")) {
	            	value += ",'" + $(this).attr("value") + "'";
	            }
	        });
			$("#"+id).val(value.substring(1));
		});
		if (hasDefault) {
			$('[name="'+idCheckbox+'"]:checkbox').trigger("change");
		}
	}
}

function changeCheckBoxsValue(id,value) {
	var idCheckbox = "@checkbox_" + id;
	$("input:checkbox[value='"+value+"'][name='"+idCheckbox+"']")[0].checked = true;
}

function checkBoxReadOnly(id,isReadOnly){
	var idCheckbox = "@checkbox_" + id;
	$(document).off("click",'[name="'+idCheckbox+'"]:checkbox');
	if(!isReadOnly){
		$(document).on("click",'[name="'+idCheckbox+'"]:checkbox', function() {
			return false;
		});
	}
}

function pinyinMatcher(term, text) {
	if (text.toPinYin != undefined) {
		return text.toPinYin().indexOf(term.toUpperCase()) >= 0 ? true : text
				.toUpperCase().indexOf(term.toUpperCase()) >= 0;
	}
	return text.toUpperCase().indexOf(term.toUpperCase()) >= 0;
}

Date.prototype.pattern = function(fmt) {
	var o = {
		"M+" : this.getMonth() + 1, // 月份
		"d+" : this.getDate(), // 日
		"h+" : this.getHours() % 12 == 0 ? 12 : this.getHours() % 12, // 小时
		"H+" : this.getHours(), // 小时
		"m+" : this.getMinutes(), // 分
		"s+" : this.getSeconds(), // 秒
		"q+" : Math.floor((this.getMonth() + 3) / 3), // 季度
		"S" : this.getMilliseconds()
	// 毫秒
	};
	if (/(y+)/.test(fmt)) {
		fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "")
				.substr(4 - RegExp.$1.length));
	}
	for ( var k in o) {
		if (new RegExp("(" + k + ")").test(fmt)) {
			fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k])
					: (("00" + o[k]).substr(("" + o[k]).length)));
		}
	}
	return fmt;
}

function formatDate(dateObj, format) {
	if (dateObj.value == "") {
		return;
	}
	dateObj.value = (new Date(dateObj.value)).pattern(format);
}

function doTransfer(transferType, content, parameterMap, autoInit, buttonName) {
	var mainFormObj = arrayToObject($("#mainForm").serializeArray());
	var parameterStr = filterParameterStr($("#mainForm").serializeArray(),
			parameterMap, mainFormObj);
	var buttonText = $("#" + buttonName).text();
	transferPage(parameterStr, transferType, content, autoInit,buttonText);
}

function doGridTransfer(gridId, transferType, atContent, parameterMap, autoInit, buttonName, subGridId) {
	var buttonText = $("#" + buttonName).text();
	if (typeof (autoInit) == "undefined" || autoInit == undefined
			|| autoInit == null || autoInit == 'false') {
		var ids = getGridIds(gridId);
		var rowData = $("#" + gridId).jqGrid("getRowData", ids[0]);
		var parameterStr = getGridTransferParameterStr(rowData,
				parameterMap, subGridId);
		transferPage(parameterStr, transferType, atContent, autoInit, buttonText);
	} else {
		var ids = getGridIds(gridId);
		if (ids.length == 0) {
			showError(noDataSelectedMsg);
			layer.close(layerLoadIndex);
			return;
		}
		if (ids.length > 1) {
			showError(choseOneDataMsg);
			layer.close(layerLoadIndex);
			return;
		} else {
			var rowData = $("#" + gridId).jqGrid("getRowData", ids[0]);
			var parameterStr = getGridTransferParameterStr(rowData,
					parameterMap, subGridId);
			transferPage(parameterStr, transferType, atContent, autoInit, buttonText);
		}
	}
}

function doFormTransfer(formId, transferType, atContent, parameterMap, autoInit, buttonName, subGridId) {
	var buttonText = $("#" + buttonName).text();
	var rowData = arrayToObject($("#" + formId).serializeArray());
	var parameterStr = getGridTransferParameterStr(rowData,
			parameterMap, subGridId);
	transferPage(parameterStr, transferType, atContent, autoInit, buttonText);
}

function getGridTransferParameterStr(rowData, parameterMap, subGridId) {
	var parameterData = {};
	var mainFormObj = arrayToObject($("#mainForm").serializeArray());
	var mainTableObj = getMainTableData();
	var subMainTableObj = getSubMainTableData(subGridId);
	parameterData = filterParameter(rowData, parameterMap, mainFormObj,
			mainTableObj, subMainTableObj);
	var parameterStr = jsonToUrlParameter(parameterData);
	return parameterStr;
}

function getMainTableData() {
	var ids = getGridIds("mainTable");
	var rowData = $("#mainTable").jqGrid("getRowData", ids[0]);
	return rowData;
}

function getSubMainTableData(subGridId) {
	var ids = getGridIds(subGridId);
	var rowData = $("#" + subGridId).jqGrid("getRowData", ids[0]);
	return rowData;
}

function getGridIds(gridId) {
	var ids = [];
	if ($("#" + gridId).jqGrid("getGridParam", "multiselect")) {
		ids = $("#" + gridId).jqGrid("getGridParam", "selarrrow");
	} else {
		if ($("#" + gridId).jqGrid("getGridParam", "selrow") != null) {
			ids[0] = $("#" + gridId).jqGrid("getGridParam", "selrow");
		}
	}
	return ids;
}

function doButtonAction(id, confirmMsg, buttonId, actionType, parameterMap) {
	if (validateForm("#mainForm")) {
		if (typeof (confirmMsg) !== "undefined" && confirmMsg != null
				&& confirmMsg != "") {
			var mainFormObj = arrayToObject($("#mainForm").serializeArray());
			confirmMsg = confirmMsgParamReplace(confirmMsg, mainFormObj);
			//对单引号和双引号进行解码
			confirmMsg = decodeURIComponent(confirmMsg);
			layer.confirm(confirmMsg, function() {
				buttonActionOper(id,buttonId, actionType, parameterMap);
			})
		} else {
			buttonActionOper(id,buttonId, actionType, parameterMap);
		}
	}
}

// 参数替换
function confirmMsgParamReplace(confirmMsg, formData, parameterMap,
		mainFormObj, mainTableObj, subMainTableObj) {
	if (typeof (confirmMsg) != "undefined" && confirmMsg != "") {
		var leftIndex = Number(confirmMsg.indexOf("#{"));
		var rightIndex = Number(confirmMsg.indexOf("}"));
		if (Number(leftIndex) >= 0 && Number(rightIndex) > 0
				&& Number(leftIndex) < Number(rightIndex)) {
			var msgHead = confirmMsg.substring(0, leftIndex);
			var msgParam = confirmMsg.substring(leftIndex, rightIndex + 1);
			msgParam = getParamValueByKey(msgParam, formData,
					mainFormObj, mainTableObj ,subMainTableObj);
			var msgEnd = confirmMsg.substring(rightIndex + 1);
			msgEnd = confirmMsgParamReplace(msgEnd, formData, parameterMap,
					mainFormObj, mainTableObj ,subMainTableObj);
			return msgHead + msgParam + msgEnd;
		} else {
			return confirmMsg;
		}
	} else {
		return "";
	}
}

function buttonActionOper(buttonKey,buttonId, actionType, parameterMap) {
	layerLoadIndex = layer.load(1, {
		shade : [ 0.8, '#fff' ],
		scrollbar : false
	});
	callBackBtnKey = buttonKey;
	$("#\\@buttonId").val(buttonId);
	$("#\\@actionType").val(actionType);
	var url = ctx + "/webpage/customAction";
	var mainFormObj = arrayToObject($("#mainForm").serializeArray());
	var parameterStr = filterParameterStr($("#mainForm").serializeArray(),
			parameterMap, mainFormObj);
	if(buttonKey.indexOf("_") > 0 &&  buttonKey.length>2){
		buttonKey = buttonKey.substring(buttonKey.indexOf("_")+1); /*button code 生成时候会加前缀xxx_，如mbtn_pro_sp001。后台数据只需要pro_sp001真实的code*/
	}
	url = url + "?" + parameterStr+"&@buttonKey="+buttonKey;
	$.post(url, function(data) {
		var result = JSON.parse(data);
		if (result.resultType > 0) {
			showTip(result.resultMsg);
		} else {
			showError(result.resultMsg);
		}
		layer.close(layerLoadIndex);
		if (result.resultType > 0) {

			if (typeof doCallBack === 'function') {
				doCallBack(result, callBackBtnKey);
			}
			if (typeof doSearch === 'function') {
				doSearch(true);
			}
		}
	});
}


function doUploadFileButtonAction(id, confirmMsg, buttonId, actionType, parameterMap){
	if (validateForm("#mainForm")) {
		if (typeof (confirmMsg) !== "undefined" && confirmMsg != null
				&& confirmMsg != "") {
			var mainFormObj = arrayToObject($("#mainForm").serializeArray());
			confirmMsg = confirmMsgParamReplace(confirmMsg, mainFormObj);
			//对单引号和双引号进行解码
			confirmMsg = decodeURIComponent(confirmMsg);
			layer.confirm(confirmMsg, function() {
				buttonUploadAction(id,buttonId, actionType, parameterMap);
			})
		} else {
			buttonUploadAction(id,buttonId, actionType, parameterMap);
		}
	}
}
function buttonUploadAction(buttonKey,buttonId, actionType, parameterMap){
	layerLoadIndex = layer.load(1, {
		shade : [ 0.8, '#fff' ],
		scrollbar : false
	});
	var url = ctx + "/webpage/customUploadFileAction";
	$("#\\@buttonId").val(buttonId);
	$("#\\@actionType").val(actionType);
	var mainFormObj = arrayToObject($("#mainForm").serializeArray());
	var globObj = getGlobObj(mainFormObj);
	var parameterData = filterParameter(mainFormObj,
			parameterMap, mainFormObj);
	$.extend(parameterData,globObj);
	if(buttonKey.indexOf("_") > 0 &&  buttonKey.length>2){
		buttonKey = buttonKey.substring(buttonKey.indexOf("_")+1); /*button code 生成时候会加前缀xxx_，如mbtn_pro_sp001。后台数据只需要pro_sp001真实的code*/
	}
	parameterData["@buttonKey"] = buttonKey;
	var parameterStr = jsonToUrlParameter(parameterData);
	url = url + "?" + parameterStr;
	var uploadId = getUploadElemId("mainForm");
	$.ajaxFileUpload({
        //处理文件上传操作的服务器端地址(可以传参数,已亲测可用)
        url: url,
        secureuri:false,                           //是否启用安全提交,默认为false   
        fileElementId : uploadId,               //文件选择框的id属性  
        dataType:'json',                           //服务器返回的格式,可以是json或xml等  
        success:function(data, status){         //服务器响应成功时的处理函数  
        	var result = data;
    		if (result.resultType > 0) {
    			showTip(result.resultMsg);
    		} else {
    			showError(result.resultMsg);
    		}
    		layer.close(layerLoadIndex);
    		if (result.resultType > 0) {
    			if (typeof doSearch === 'function') {
    				doSearch(true);
    			}
    		}
        },  
        error:function(data, status, e){ //服务器响应失败时的处理函数  
        	var errorMsg = errorProcessFailure.replace(/\{0\}/,sysFailure);
			showError(errorMsg);
        }  
	});  
}

function getGlobObj(obj){
	var formData = {};
	for ( var p in obj) {
		if ( typeof ( obj [ p ]) == " function " ){
		}else{
			if(p.indexOf("@") == 0){
				formData[p] = obj [ p ];
			}
		} 
	}
	return formData;
}


function getUploadElemId(gridId){
	var uploadList = $("#" + gridId).find("[type=file]");
	var uploadId = new Array();
	if(uploadList != null && uploadList.length > 0){
		var uploadObj = null;
		for(var i = 0;i < uploadList.length; i++ ){
			uploadObj = uploadList[i];
			if($(uploadObj).attr("id")){
				uploadId.push($(uploadObj).attr("id"));
			}else if($(uploadObj).attr("name")){
				uploadId.push($(uploadObj).attr("name"));
			}
		}
	}
	return uploadId;
}


function doGridButtonAction(gridId, confirmMsg, id, buttonId, actionType,
		parameterMap,subGridId) {
	layerLoadIndex = layer.load(1, {
		shade : [ 0.8, '#fff' ],
		scrollbar : false
	});
	var ids = [];
	ids = getGridIds(gridId);
	if (ids.length == 0) {
		showError(noDataSelectedMsg);
		layer.close(layerLoadIndex);
		return;
	}
	var mainFormObj = arrayToObject($("#mainForm").serializeArray());
	var mainTableObj = getMainTableData();
	var subMainTableObj = getSubMainTableData(subGridId);
	if (actionType == "1" || actionType == "2") { // actionType为SQL或SP时，只能选一行数据
		if (ids.length > 1) {
			showError(choseOneDataMsg);
			layer.close(layerLoadIndex);
			return;
		} else {
			var rowData = $("#" + gridId).jqGrid("getRowData", ids[0]);
			var parameterData = {};
			if (typeof (confirmMsg) !== "undefined" && confirmMsg != null
					&& confirmMsg != "") {
				confirmMsg = confirmMsgParamReplace(confirmMsg, rowData,
						parameterMap, mainFormObj, mainTableObj, subMainTableObj);
				//对单引号和双引号进行解码
				confirmMsg = decodeURIComponent(confirmMsg);
				layer.confirm(confirmMsg, function() {
					gridButtonActionOper(buttonId, actionType, rowData,
							parameterMap, mainFormObj, mainTableObj, subMainTableObj,id);
				})
				layer.close(layerLoadIndex);
			} else {
				gridButtonActionOper(buttonId, actionType, rowData,
						parameterMap, mainFormObj, mainTableObj, subMainTableObj,id);
			}
		}
	} else {
		var rowDataMsg = $("#" + gridId).jqGrid("getRowData", ids[0]);
		if (typeof (confirmMsg) !== "undefined" && confirmMsg != null
				&& confirmMsg != "") {
			confirmMsg = confirmMsgParamReplace(confirmMsg, rowDataMsg,
					parameterMap, mainFormObj, mainTableObj, subMainTableObj);
			//对单引号和双引号进行解码
			confirmMsg = decodeURIComponent(confirmMsg);
			layer.confirm(confirmMsg, function() {
				gridMutliButtonActionOper(id,buttonId, actionType, gridId,
						parameterMap, mainFormObj, mainTableObj, subMainTableObj);
			});
			layer.close(layerLoadIndex);
		} else {
			gridMutliButtonActionOper(id,buttonId, actionType, gridId,
					parameterMap, mainFormObj, mainTableObj, subMainTableObj);
		}
	}
}

function doFormButtonAction(FormId, confirmMsg, buttonId, actionType,
		parameterMap,subGridId,id ){
	if (validateForm("#" + FormId)) {
		layerLoadIndex = layer.load(1, {
			shade : [ 0.8, '#fff' ],
			scrollbar : false
		});
		var mainFormObj = arrayToObject($("#mainForm").serializeArray());
		var mainTableObj = getMainTableData();
		var subMainTableObj = getSubMainTableData(subGridId);
		var rowData = arrayToObject($("#" + FormId).serializeArray());
		if (typeof (confirmMsg) !== "undefined" && confirmMsg != null
				&& confirmMsg != "") {
			confirmMsg = confirmMsgParamReplace(confirmMsg, rowData,
					parameterMap, mainFormObj, mainTableObj, subMainTableObj);
			//对单引号和双引号进行解码
			confirmMsg = decodeURIComponent(confirmMsg);
			layer.confirm(confirmMsg, function() {
				gridButtonActionOper(buttonId, actionType, rowData,
						parameterMap, mainFormObj, mainTableObj, subMainTableObj,id);
			})
			layer.close(layerLoadIndex);
		} else {
			gridButtonActionOper(buttonId, actionType, rowData,
					parameterMap, mainFormObj, mainTableObj, subMainTableObj,id);
		}
	}
}

function doUplodFileFormButtonAction(FormId, confirmMsg, buttonId, actionType,
		parameterMap,subGridId,id ){
	if (validateForm("#" + FormId)) {
		layerLoadIndex = layer.load(1, {
			shade : [ 0.8, '#fff' ],
			scrollbar : false
		});
		var mainFormObj = arrayToObject($("#mainForm").serializeArray());
		var mainTableObj = getMainTableData();
		var subMainTableObj = getSubMainTableData(subGridId);
		var rowData = arrayToObject($("#" + FormId).serializeArray());
		if (typeof (confirmMsg) !== "undefined" && confirmMsg != null
				&& confirmMsg != "") {
			confirmMsg = confirmMsgParamReplace(confirmMsg, rowData,
					parameterMap, mainFormObj, mainTableObj, subMainTableObj);
			//对单引号和双引号进行解码
			confirmMsg = decodeURIComponent(confirmMsg);
			layer.confirm(confirmMsg, function() {
				gridUplodFileButtonActionOper(FormId,buttonId, actionType, rowData,
						parameterMap, mainFormObj, mainTableObj, subMainTableObj,id);
			})
			layer.close(layerLoadIndex);
		} else {
			gridUplodFileButtonActionOper(FormId,buttonId, actionType, rowData,
					parameterMap, mainFormObj, mainTableObj, subMainTableObj,id);
		}
	}
}

function gridMutliButtonActionOper(buttonKey,buttonId, actionType, gridId, parameterMap,
		mainFormObj, mainTableObj, subMainTableObj) {
	var gridDataList = [];
	ids = getGridIds(gridId);
	for ( var i in ids) {
		var rowData = $("#" + gridId).jqGrid("getRowData", ids[i]);
		var parameterData = filterParameterNotEncodeURI(rowData, parameterMap, mainFormObj,
				mainTableObj, subMainTableObj);
		gridDataList.push(parameterData);
	}

	var submitData;
	if (ids.length == 1) {
		submitData = filterParameter(rowData, parameterMap, mainFormObj,
				mainTableObj, subMainTableObj);
	} else {
		submitData = {};
	}
	submitData["@webPageId"] = $("#\\@webPageId").val();
	submitData["@buttonId"] = buttonId;
	if(buttonKey.length > 5){
		buttonKey = buttonKey.substring(5); 
	}
	submitData["@buttonKey"] = buttonKey;
	submitData["@actionType"] = actionType;
	submitData["@gridDataList"] = encodeURI(encodeURIComponent(JSON.stringify(gridDataList)));
	
	var parameterStr = jsonToUrlParameter(submitData);

	var url = ctx + "/webpage/customAction?" + parameterStr;
	$.post(url, function(data) {
		var result = JSON.parse(data);
		if (result.resultType > 0) {
			showTip(result.resultMsg);
		} else {
			showError(result.resultMsg);
		}
		layer.close(layerLoadIndex);
		if (result.resultType > 0) {
			if (typeof doSearch === 'function') {
				doSearch(true);
			}
		}
	});
}

function gridButtonActionOper(buttonId, actionType, rowData, parameterMap,
		mainFormObj, mainTableObj, subMainTableObj,buttonKey) {
	parameterData = filterParameter(rowData, parameterMap, mainFormObj,
			mainTableObj, subMainTableObj);
	parameterData["@webPageId"] = $("#\\@webPageId").val();
	parameterData["@buttonId"] = buttonId;
	parameterData["@actionType"] = actionType;
	if(buttonKey.indexOf("_") > 0 &&  buttonKey.length>2){
		buttonKey = buttonKey.substring(buttonKey.indexOf("_")+1); /*button code 生成时候会加前缀xxx_，如mbtn_pro_sp001。后台数据只需要pro_sp001真实的code*/
	}
	parameterData["@buttonKey"] = buttonKey;
	var parameterStr = jsonToUrlParameter(parameterData);
	var url = ctx + "/webpage/customAction?" + parameterStr;
	
	$.post(url, function(data) {
		var result = JSON.parse(data);
		if (result.resultType > 0) {
			showTip(result.resultMsg);
		} else {
			showError(result.resultMsg);
		}
		layer.close(layerLoadIndex);
		if (typeof doSearch === 'function') {
			doSearch(true);
		}
	});
}

function gridUplodFileButtonActionOper(FormId,buttonId, actionType, rowData, parameterMap,
		mainFormObj, mainTableObj, subMainTableObj,buttonKey) {
	parameterData = filterParameter(rowData, parameterMap, mainFormObj,
			mainTableObj, subMainTableObj);
	parameterData["@webPageId"] = $("#\\@webPageId").val();
	parameterData["@buttonId"] = buttonId;
	parameterData["@actionType"] = actionType;
	if(buttonKey.indexOf("_") > 0 &&  buttonKey.length>2){
		buttonKey = buttonKey.substring(buttonKey.indexOf("_")+1); /*button code 生成时候会加前缀xxx_，如mbtn_pro_sp001。后台数据只需要pro_sp001真实的code*/
	}
	parameterData["@buttonKey"] = buttonKey;
	var parameterStr = jsonToUrlParameter(parameterData);
	var url = ctx + "/webpage/customUploadFileAction?"+ parameterStr;
	
	
	var uploadId = getUploadElemId(FormId);
	$.ajaxFileUpload({
        //处理文件上传操作的服务器端地址(可以传参数,已亲测可用)
        url: url,
        secureuri:false,                           //是否启用安全提交,默认为false   
        fileElementId : uploadId,               //文件选择框的id属性  
        dataType:'json',                           //服务器返回的格式,可以是json或xml等  
        success:function(data, status){         //服务器响应成功时的处理函数  
        	var result = data;
    		if (result.resultType > 0) {
    			showTip(result.resultMsg);
    		} else {
    			showError(result.resultMsg);
    		}
    		layer.close(layerLoadIndex);
    		if (result.resultType > 0) {
    			if (typeof doSearch === 'function') {
    				doSearch(true);
    			}
    		}
        },  
        error:function(data, status, e){ //服务器响应失败时的处理函数  
        	var errorMsg = errorProcessFailure.replace(/\{0\}/,sysFailure);
			showError(errorMsg);
			layer.close(layerLoadIndex);
        }  
	});  
}


function doGridEditAction(gridId,rowObj,actionType,
		parameterMap,subGridId,id) {
	layerLoadIndex = layer.load(1, {
		shade : [ 0.8, '#fff' ],
		scrollbar : false
	});
	
	var mainTableObj = {};
	var subMainTableObj = {};
	var ids = [];
	if(gridId != "mainTable"){
		ids = getGridIds("mainTable");
		if (ids.length == 0) {
			showError(noDataSelectedMsg);
			layer.close(layerLoadIndex);
			return;
		}else{
			mainTableObj = getMainTableData();
		}
	}
	
	if(subGridId && subGridId != 0){
		ids = getGridIds(subGridId);
		if (ids.length == 0) {
			showError(noDataSelectedMsg);
			layer.close(layerLoadIndex);
			return;
		}else{
			subMainTableObj = getSubMainTableData(subGridId);
		}
	}
	
	var mainFormObj = arrayToObject($("#mainForm").serializeArray());
	
	var result = gridEditActionOper(gridId, actionType, rowObj,
			parameterMap, mainFormObj, mainTableObj, subMainTableObj,id);
	
	return result;
}


function gridEditActionOper(gridId, actionType, rowObj,
		parameterMap, mainFormObj, mainTableObj, subMainTableObj,id){
	parameterData = filterParameter(rowObj, parameterMap, mainFormObj,
			mainTableObj, subMainTableObj);
	parameterData["@webPageId"] = $("#\\@webPageId").val();
	parameterData["@gridId"] = gridId;
	parameterData["@actionType"] = actionType;
	$.extend(parameterData,rowObj);
	
	var resultFlag = false;
	var resultObj = {result:false};
	var parameterStr = jsonToUrlParameter(parameterData);
	var url = ctx + "/webpage/gridEditAction?" + parameterStr;
	$.ajaxSetup({ async : false });  //设置成同步
	$.post(url, function(data) {
		var result = JSON.parse(data);
		if (result.resultType > 0) {
			showTip(result.resultMsg);
			resultObj.result = true;
			resultObj["insertId"] = result.insertId;
			resultObj.dataModel = result.dataModel;
		} else {
			if(result.exceptId){
				resultObj["exceptId"] = result.exceptId;
			}
			showError(result.resultMsg);
		}
		layer.close(layerLoadIndex);
	});
	$.ajaxSetup({ async : true });  //设置成同步
	return resultObj;
}


function filterParameterNotEncodeURI(orgData, parameterMap, mainFormObj, mainTableObj, subMainTableObj) {
	var parameterData = {};
	for ( var key in parameterMap) {
		var value = getParamValueByKey(parameterMap[key], orgData,
				mainFormObj, mainTableObj, subMainTableObj);
		value = value;
		parameterData[key] = value;
	}
	return parameterData;
}

function filterParameter(orgData, parameterMap, mainFormObj, mainTableObj, subMainTableObj) {
	var parameterData = {};
	for ( var key in parameterMap) {
		var value = getParamValueByKey(parameterMap[key], orgData,
				mainFormObj, mainTableObj, subMainTableObj);
		value = encodeURI(encodeURIComponent(value));
		parameterData[key] = value;
	}
	return parameterData;
}

function filterParameterStr(orgDataArray, parameterMap, mainFormObj,
		mainTableObj) {
	var parameterStr = "";
	var formData = {};
	for ( var i in orgDataArray) {
		formData[orgDataArray[i].name] = orgDataArray[i].value;
		if (orgDataArray[i].name.indexOf("@") == 0) {
			parameterStr += "&" + orgDataArray[i].name + "="
					+ encodeURI(encodeURI(orgDataArray[i].value));
		}
	}
	for ( var key in parameterMap) {
		var value = getParamValueByKey(parameterMap[key], formData,
				mainFormObj, mainTableObj);
		value = encodeURI(encodeURIComponent(value));
		parameterStr += "&" + key + "=" + value;
	}
	if (parameterStr != "") {
		parameterStr = parameterStr.substring(1);
	}
	return parameterStr;
}

function arrayToObject(array) {
	var obj = {};
	for ( var i in array) {
		obj[array[i].name] = array[i].value;
	}
	return obj;
}

function objectToArray(object) {
	var array = new Array();
	for ( var i in object) {
		var obj = {
			"name" : i,
			"value" : object[i]
		};
		array.push(obj);
	}
	return array;
}

function getObjValueByKey(objData, key) {
	var value = "";
	if (objData instanceof Object) {
		value = typeof (objData[key]) == "undefined" ? "" : objData[key];
	}
	return value;
}

function getParamValueByKey(key, formData, mainFormObj,
		mainTableObj , subMainTableObj) {
	var value = "";
	if (typeof (key) != "undefined") {
		if (key.indexOf("#{") == 0) {
			var formKey = key.substring(2, key.length - 1);
			if (formKey.indexOf("mainForm.") == 0) {
				formKey = formKey.substring(9);
				value = getObjValueByKey(mainFormObj, formKey);
			} else if (formKey.indexOf("mainTable.") == 0) {
				formKey = formKey.substring(10);
				value = getObjValueByKey(mainTableObj, formKey);
			} else if (formKey.indexOf("subMainTable.") == 0) {
				formKey = formKey.substring(13);
				value = getObjValueByKey(subMainTableObj, formKey);
			} else {
				value = typeof (formData[formKey]) == "undefined" ? ""
						: formData[formKey];
			}
		} else {
			value = key;
		}
	}
	return value;
}

function filterGridParameterStr(gridId, orgDataArray, parameterMap) {
	var parameterStr = "";
	var formData = {};
	for ( var i in orgDataArray) {
		formData[orgDataArray[i].name] = orgDataArray[i].value;
		if (orgDataArray[i].name.indexOf("@") == 0) {
			parameterStr += "&" + orgDataArray[i].name + "="
					+ encodeURI(encodeURI(orgDataArray[i].value));
		}
	}

	for ( var key in parameterMap) {
		var value;
		if (parameterMap[key].indexOf("#{") == 0) {
			var formKey = parameterMap[key].substring(2,
					parameterMap[key].length - 1);
			var gridValue = getObjValueByKey(gridId, formKey);
			value = encodeURI(encodeURI(gridValue));
		} else {
			var gridValue = getObjValueByKey(gridId, formKey);
			value = encodeURI(encodeURI(gridValue));
		}
		parameterStr += "&" + key + "=" + value;
	}
	if (parameterStr != "") {
		parameterStr = parameterStr.substring(1);
	}
	return parameterStr;
}

function filterPrintGridParameterStr(gridId, orgDataObj, parameterMap) {
	var parameterStr = "";
	var ids = getGridIds(gridId);
	if (ids.length == 1) {
		var rowData = $("#" + gridId).jqGrid("getRowData", ids[0]);
		var rowDataAray = objectToArray(rowData);
		orgDataObj = orgDataObj.concat(rowDataAray);
	}
	var mainTableObj = getMainTableData();
	var mainFormObj = arrayToObject($("#mainForm").serializeArray());
	parameterStr = filterParameterStr(orgDataObj, parameterMap, mainFormObj,
			mainTableObj);
	var arrayParam = {};
	arrayParam = filterPrintGridListParamStr(gridId, parameterMap);
	if (arrayParam != "") {
		arrayParam = encodeURI(encodeURI(arrayParam));
		if (parameterStr != "") {
			parameterStr += "&RESULT_LIST=" + arrayParam;
		} else {
			parameterStr = "RESULT_LIST=" + arrayParam;
		}
	}
	return parameterStr;
}

function filterPrintGridParameterObj(gridId, orgDataArray, parameterMap, subGridId,formObj) {
	var ids = getGridIds(gridId);
	var orgDataObj = {};
	if (ids.length == 1) {
		var rowData = $("#" + gridId).jqGrid("getRowData", ids[0]);
		orgDataObj = rowData;
	}
	if(formObj instanceof Object){
		orgDataObj = formObj;
	}
	var paraObj = {};
	for ( var i in orgDataArray) {
		if (orgDataArray[i].name.indexOf("@") == 0) {
			paraObj[orgDataArray[i].name] = orgDataArray[i].value;
		}
	}
	var arrayParam = {};
	var mainFormObj = arrayToObject($("#mainForm").serializeArray());
	var mainTableObj = getMainTableData();
	var subMainTableObj = getSubMainTableData(subGridId);
	parameterData = filterParameterNotEncodeURI(orgDataObj, parameterMap, mainFormObj,
			mainTableObj, subMainTableObj);
	arrayParam = filterPrintGridListParamStr(gridId, parameterMap);
	combinationObj(paraObj,parameterData);
	
	if (arrayParam != "") {
		paraObj["RESULT_LIST"] = arrayParam;
	}
	return paraObj;
}

var combinationObj=function(o,n){
	for ( var p in n){
		if (n.hasOwnProperty(p) && !o.hasOwnProperty(p)){
			o[p] = n[p];
		}
	}
};

function filterPrintGridListParamStr(gridId, parameterMap) {
	var ids = getGridIds(gridId);
	var arrayParam = new Array();
	for ( var id in ids) {
		var rowData = $("#" + gridId).jqGrid("getRowData", ids[id]);
		var obj = {};
		for ( var key in parameterMap) {
			if (parameterMap[key].indexOf("#{") == 0) {
				var formKey = parameterMap[key].substring(2,
						parameterMap[key].length - 1);
				if (formKey.indexOf("mainForm.") == 0
						|| formKey.indexOf("mainTable.") == 0
						|| formKey.indexOf("subMainTable.") == 0) {
					continue;
				} else {
					value = typeof (rowData[formKey]) == "undefined" ? ""
							: rowData[formKey];
				}
			} else {
				value = parameterMap[key];
			}
			obj[key] = value;
		}
		arrayParam.push(obj);
	}
	var arrayStr = JSON.stringify(arrayParam);
	return arrayStr;
}

function jsonToUrlParameter(jsonData) {
	var resultStr = "";
	for ( var key in jsonData) {
		resultStr += "&" + key + "=" + jsonData[key];
	}
	resultStr = resultStr.substring(1);
	return resultStr;
}

function openLayerDetail(atContent, parameterStr, autoInit, width, height, fullFlag) {
	var index = layer.open({
		type : 2,
		maxmin : true,
		area : [ width + 'px', height + 'px' ],
		title : ' ',
		content : ctx + "/webpage/" + atContent + "?" + parameterStr + "&_autoInit=" + autoInit,
		cancel : function() {
			// 点击关闭按钮时触发当前页面的查询按钮。
			parent.$(".layui-layer-title").show();
			parent.$(".layui-layer-setwin").show();
			//parent.$("iframe").css("height",top.$("#iframe_box").height() - parent.$(".layui-layer-title").height());
			if (typeof doSearch === 'function') {
				doSearch(true);
			}
		}
	});
	if (fullFlag) {
		layer.full(index);
	}
}

function openLayer(atContent, parameterStr, autoInit, width, height, fullFlag) {
	openLayerDetail(atContent, parameterStr, autoInit, width, height, fullFlag);
}

function openExternalLayer(atContent, parameterStr, autoInit, width, height, fullFlag) {
	openExternalLayerDetail(atContent, parameterStr, autoInit, width, height, fullFlag);
}

function openExternalLayerDetail(atContent, parameterStr, autoInit, width, height, fullFlag) {
	var index = layer.open({
		type : 2,
		maxmin : true,
		area : [ width + 'px', height + 'px' ],
		title : ' ',
		content : ctx + atContent + "?"
				+ parameterStr + "&_autoInit=" + autoInit,
		cancel : function() {
			// 点击关闭按钮时触发当前页面的查询按钮。
			parent.$(".layui-layer-title").show();
			parent.$(".layui-layer-setwin").show();
			//parent.$("iframe").css("height",top.$("#iframe_box").height() - parent.$(".layui-layer-title").height()  );
			if (typeof doSearch === 'function') {
				doSearch(true);
			}
		}
	});
	if (fullFlag) {
		layer.full(index);
	}
}

function transferPage(parameterStr, transferType, atContent, autoInit,buttonText) {
	var width = 800;
	var height = 480;
	if (transferType == "2") {
		if (typeof (autoInit) == "undefined" || autoInit == undefined
				|| autoInit == null) {
			autoInit = "";
		}
		if(!isNaN(atContent) && atContent != null){
			//系统配置页面
			$.ajax({
				url : ctx + "/webpage/count/" + atContent,
				data : parameterStr,
				type : "post",
				dataType : "json",
				success : function(data) {
					if (data.result > 0) {
						openLayer(atContent, parameterStr, autoInit, width, height, true);
					} else {
						showError(data.errorMsg);
					}
				},
				error : function() {
					var errorMsg = errorProcessFailure.replace(/\{0\}/,sysFailure);
					showError(errorMsg);
				}
			});
		}else{
			openExternalLayer(atContent, parameterStr, autoInit, width, height, true);
		}

		//防止多个窗口叠在一起时，父窗口的title显示在子窗口的上面
		//parent.$(".layui-layer").css("height",top.$("#iframe_box").height() );
		//parent.$("iframe").css("height",top.$("#iframe_box").height() );
		parent.$(".layui-layer-title").hide();
		parent.$(".layui-layer-setwin").hide();
	}
	if (transferType == "3") {
		if (atContent.indexOf("?") > 0) {
			atContent = atContent + "&" + parameterStr;
		} else {
			atContent = atContent + "?" + parameterStr;
		}
		top.addTabs(buttonText, atContent);
	}
}

function doExport(postData, isMain, tabId, exportColumnList, pageName) {
	if (validateForm("#mainForm")) {
		postData["@exportPageName"] = pageName;
		postData["@exportColumnList"] = JSON.stringify(exportColumnList);
		postData["@isMain"] = isMain;
		postData["@tabId"] = tabId;
		layer.confirm(exportConfirmMsg, function() {
			$.ajax({
				url : ctx + "/webpage/export",
				data : postData,
				type : "post",
				success : function(data) {
					var result = JSON.parse(data);
					if (result.resultType > 0) {
						showAlert(result.resultMsg, 3000);
					} else {
						showError(result.resultMsg);
					}
				},
				error : function() {
					showError(exportFailureMsg);
				}
			});
		});
	}
}

function doImport(pageId, buttonId,actionType) {
	var width = 800;
	var height = 480;
	var parameterStr = "@pageId=" + pageId + "&@buttonId=" + buttonId +"&actionType=" +actionType;
	var index = layer.open({
		type : 2,
		maxmin : true,
		area : [ width + 'px', height + 'px' ],
		title : ' ',
		content : ctx + "/sys/importFile" + "?" + parameterStr,
		cancel : function() {
			// 点击关闭按钮时触发当前页面的查询按钮。
			if (typeof doSearch === 'function') {
				doSearch(true);
			}
		}
	});
	layer.full(index);
}

function doPrint(buttonId, printTitle, parameterMap) {
	if (validateForm("#mainForm")) {
		var width = 800;
		var height = 480;
		$("#\\@buttonId").val(buttonId);
		var parameter = {
			"name" : "@webPageName",
			"value" : printTitle
		};
		var arrayObj = $("#mainForm").serializeArray();
		arrayObj.push(parameter);
		var url = ctx + "/sys/print";
		var mainFormObj = arrayToObject($("#mainForm").serializeArray());
		var parameterStr = filterParameterStr(arrayObj, parameterMap,
				mainFormObj);

		url = url + "?" + parameterStr;
		addTabs(printTitle, url);
	}
}

function doGridPrint(gridId, buttonId, printTitle, parameterMap) {
	var width = 800;
	var height = 480;
	$("#\\@buttonId").val(buttonId);
	var parameter = {
		"name" : "@webPageName",
		"value" : printTitle
	};
	var arrayObj = $("#mainForm").serializeArray();
	arrayObj.push(parameter);
	var url = ctx + "/sys/print";

	var ids = getGridIds(gridId);
	if (ids.length == 0) {
		showError(noDataSelectedMsg);
		layer.close(layerLoadIndex);
		return;
	}

	var parameterStr = filterPrintGridParameterStr(gridId, arrayObj,
			parameterMap);
	url = url + "?" + parameterStr;
	addTabs(printTitle, url);
}

function doGridPrintByPost(gridId, buttonId, printTitle, parameterMap, subGridId) {
	var width = 800;
	var height = 480;
	$("#\\@buttonId").val(buttonId);
	var parameter = {
		"name" : "@webPageName",
		"value" : printTitle
	};
	var arrayObj = $("#mainForm").serializeArray();
	arrayObj.push(parameter);
	var url = ctx + "/sys/print";

	var ids = getGridIds(gridId);
	if (ids.length == 0) {
		showError(noDataSelectedMsg);
		layer.close(layerLoadIndex);
		return;
	}
	var obj = filterPrintGridParameterObj(gridId, arrayObj, parameterMap, subGridId);
	addTabsByPost(printTitle, url,obj);
}

function doFormPrintByPost(formId, buttonId, printTitle, parameterMap, subGridId) {
	var width = 800;
	var height = 480;
	$("#\\@buttonId").val(buttonId);
	var parameter = {
		"name" : "@webPageName",
		"value" : printTitle
	};
	var arrayObj = $("#" + formId).serializeArray();
	arrayObj.push(parameter);
	var url = ctx + "/sys/print";
	var formObj = arrayToObject($("#" + formId).serializeArray());
	var obj = filterPrintGridParameterObj("", arrayObj, parameterMap, subGridId, formObj);
	addTabsByPost(printTitle, url,obj);
}

function doBack() {
	var index = parent.layer.getFrameIndex(window.name);
	// 返回时触发父窗口查询按钮，需要在当前页面关闭前调用。
	parent.parent.$(".layui-layer-title").show();
	parent.parent.$(".layui-layer-setwin").show();
	//parent.parent.$("iframe").css("height",top.$("#iframe_box").height() - parent.parent.$(".layui-layer-title").height()  );
	if(typeof(parent.doSearch) == 'function'){
		parent.doSearch(true);
	}
	parent.layer.close(index);
}

function huifoldInit(obj, openLi, speed) {
	if (typeof (openLi) == "undefined" || openLi == undefined || openLi == null) {
		openLi = [];
	}
	if (typeof (speed) == "undefined" || speed == undefined || speed == null) {
		speed = "fast";
	}
	var liAry = $(obj);
	for (var i = 0; i < liAry.length; i++) {
		var index = $.inArray(i + 1, openLi);
		if (index == -1) {
			$(liAry[i]).next().slideUp(speed).end().removeClass("selected");
			$(liAry[i]).find("b").html("+");
		} else {
			$(liAry[i]).next().slideDown(speed).end().addClass("selected");
			$(liAry[i]).find("b").html("-");
		}
	}
}

/*条件折叠*/
var countShow = 1;
function selectorMore(){
	var bStopIndex = +top.$("#min_title_list li[class='active']").attr("iframeIndex");
	if($(".moreInfo").is(":visible")){
		$(".moreInfo").hide();
		$("#selectorMore").show();
		$("#selectorPack").hide();
		/*if(top.$("body").attr("class")==='big-page' && sunsail_browser.isMobile){
			screenResize();
			initGridSize("mainTable", "mainPager");
		}*/
		if(navigator.userAgent.toLowerCase().indexOf("webkit/6") > 0 && sunsail_browser.isMobile){//对内核6，滚动条失效进行特殊处理了
			top.$("div#overFlowIframe"+bStopIndex).css("overflow-y","hidden");
		}
		
	}
	else{
		if(navigator.userAgent.toLowerCase().indexOf("webkit") > 0 && sunsail_browser.isMobile){//对webkit，滚动条失效进行特殊处理了
			top.$("div#overFlowIframe"+bStopIndex).css("overflow-x","hidden");
			top.$("div#overFlowIframe"+bStopIndex).css("overflow-y","visible");
			top.$("div#overFlowIframe"+bStopIndex).css("-webkit-overflow-scrolling","touch");
		}
		
		$(".moreInfo").show();
		$("#selectorMore").hide();
		$("#selectorPack").show();
		
		if(navigator.userAgent.toLowerCase().indexOf("webkit/6") > 0 && sunsail_browser.isMobile){//对内核6，滚动条失效进行特殊处理了
			if(countShow ==1 || top.$("body").attr("class")==='big-page' ){
				var bStopIndex = +top.$("#min_title_list li[class='active']").attr("iframeIndex");
				var iframe_box=top.$("#iframe_box");
				iframe_box.find(".show_iframe").hide();
				setTimeout(function() {
					top.$("div#overFlowIframe"+bStopIndex).parent(".show_iframe").show();
				}, 10);
				countShow = countShow+1;
			}
		}
	}
	$(window).resize();
}


function tabHeightInit(tabHeight) {
	$("#tab .tabCon").each(function() {
		$(this).height(tabHeight);
	})
}
function conAreaResizeForAutoGen(){
	/*
	 * <div class="col-4"><span></span><input/></div>
	 * 条件部分根据不同的浏览器分辨率进行特殊处理
	 * 取条件的标签长度、页面一开始的宽度最小值最为span，input的宽度
	 * */
	var formWidth = $("#mainForm").width();//条件部form表单宽度
	//if(window.screen.width){
	$("#mainForm span").each(function(){//span指的是年龄：
	    var parentDivClassVal = $(this).parent("div").attr("class"); //如col-4
	    if(parentDivClassVal && parentDivClassVal.length > 4){
	    	if(parentDivClassVal.length ==5){
	    		var numOfDiv = parseFloat(parentDivClassVal.substring(4,5)); //每个条件所在div所占的份数,col-后面的数值
	    	}else if(parentDivClassVal.length ==6){
	    		var numOfDiv = parseFloat(parentDivClassVal.substring(4,6)); //每个条件所在div所占的份数,col-后面的数值
	    	}
	    	
	    	if(!isNaN(numOfDiv)){
	    		var conditionWidth = numOfDiv/12*formWidth;//整个条件的宽度
		    	var oriConPrePartWidth = $(this).width();//条件标签原来的宽度(如年龄：的宽度)
		    	var oriConBehindPartWidth = $(this).next().width();//条件值原来的宽度(如年龄：后面的输入框的宽度)
		    	var calculatedConPrePartWidth = conditionWidth*0.30;
		    	calculatedConPrePartWidth.toFixed(1);
		    	var calculatedBehindPartWidth = conditionWidth*0.6;
		    	calculatedBehindPartWidth.toFixed(1);
		    	if(oriConPrePartWidth >calculatedConPrePartWidth ){//取最小值
		    		$(this).width(calculatedConPrePartWidth);
		    	}
		    	if(oriConBehindPartWidth >calculatedBehindPartWidth ){//取最小值
		    		$(this).next().width(calculatedBehindPartWidth);
		    	}
		    	
	    	}
	    }
	 });
	//}
	
}

var countShowForChar = 1;
function overflowProcessInChart(e){
	if( $(e).hasClass("selected") ){ ////展开时调用
		setTimeout(function() {
			overflowOpenProForAppleWebKit();
        }, 200);
	}else{
		setTimeout(function() {
			overflowCloseProForAppleWebKit();
        }, 200);
	}
}
function overflowCloseProForAppleWebKit(){
	if(navigator.userAgent.toLowerCase().indexOf("webkit/6") > 0 && sunsail_browser.isMobile){//对内核6，滚动条失效进行特殊处理了
		var bStopIndex = +top.$("#min_title_list li[class='active']").attr("iframeIndex");
		countShowForChar = 1;
		if(top.$("div#overFlowIframe"+bStopIndex).css("-webkit-overflow-scrolling") === "touch" ){
			top.$("div#overFlowIframe"+bStopIndex).css("overflow-y","hidden");
			top.$("div#overFlowIframe"+bStopIndex).css("-webkit-overflow-scrolling","");
		}
	}
}
function overflowOpenProForAppleWebKit(){
	var bStopIndex = +top.$("#min_title_list li[class='active']").attr("iframeIndex");
	if(navigator.userAgent.toLowerCase().indexOf("webkit") > 0 && sunsail_browser.isMobile){//对内核6，滚动条失效进行特殊处理了
		if(top.$("div#overFlowIframe"+bStopIndex).css("-webkit-overflow-scrolling") != "touch" ){
			top.$("div#overFlowIframe"+bStopIndex).css("overflow-x","hidden");
			top.$("div#overFlowIframe"+bStopIndex).css("overflow-y","visible");
			top.$("div#overFlowIframe"+bStopIndex).css("-webkit-overflow-scrolling","touch");
		}
	}
	if(navigator.userAgent.toLowerCase().indexOf("webkit/6") > 0 && sunsail_browser.isMobile){//对内核6，滚动条失效进行特殊处理了
		if(countShowForChar ==1 || top.$("body").attr("class")==='big-page' ){
			var iframe_box=top.$("#iframe_box");
			iframe_box.find(".show_iframe").hide();
			setTimeout(function() {
				top.$("div#overFlowIframe"+bStopIndex).parent(".show_iframe").show();
			}, 10);
			countShowForChar = countShowForChar+1;
		}
	}
}
function screenResize() {

	var windowHeight = window.innerHeight
			|| document.documentElement.clientHeight
			|| document.body.clientHeight;
	/*$("body").height(windowHeight - 50);
	$("body").css("overflow-x","hidden");
	if(sunsail_browser.isMobile){
		$("body").css("overflow-y","scroll");
	}else{
		$("body").css("overflow-y","visible");
	}*/
	var tabH = 0;
	var tabObj = $(".content-tab");
	if (tabObj.length > 0) {
		tabH = tabObj.height();
	}
	var btnH = 0;
	var buttonObj = $(".content-button");
	if (buttonObj.length > 0) {
		btnH = buttonObj.height();
	}
	
	var conditionHeight = 0 ;
	if(!$(".content-head").is(":hidden")){//条件部区显示。
		 conditionHeight = $("#mainForm div[class='row cl']").length*36;//条件部区的高度一行36px
			if($(".selector").height()){
				conditionHeight = conditionHeight+36;
			}
	}
	var conditionLabelSpanLen = $(".labelSpan").length;//自动生成的页面条件部的label是放在span里
	if(sunsail_browser.isMobile || conditionLabelSpanLen === 0 ){//是移动端   
		if(!$(".content-head").is(":hidden")){//条件部区显示
			conditionHeight = $(".content-head").height();
		}
	}
	var h = $(".header").height() + btnH +  conditionHeight + tabH;
	var paddingHeight = 38;
	if($(".content-head").is(":hidden")){//条件部区隐藏
		paddingHeight = 23;
	}
	var gridH = windowHeight - paddingHeight - h;//38px是所有的padding总和
	if (gridH < 115) {
		gridH = 115;
	}

	if ($(".content-detail .Huifold").length > 0) {
		$(".content-detail .Huifold .item .info > div").height(gridH - 86);
	} else {
		$(".jqGrid_wrapper").height(gridH);
	}
}

function initForm(resultType, resultMsg, closeDialogFlag,seachFunName,param) {
	if (resultType < 0) {
		$("#message").html(
				'<div class="Huialert Huialert-danger formMsg">' + resultMsg
						+ '</div>');
	} else {
		if (resultMsg != '') {
			$("#message").html(
					'<div class="Huialert Huialert-success formMsg">'
							+ resultMsg + '</div>');
			if (resultType == '6') {
				// 更新或新增成功，并刷新表格，必须在关闭当前窗口前调用
				if(typeof(seachFunName)  == "function"){
					if(param instanceof Array ){							
						//之后改进
						if(param.length == 2){
							seachFunName(param[0],param[1]);
						}else{
							seachFunName(param[0]);
						}
					}else{
						seachFunName(param);
					}
				}
				if (closeDialogFlag) {
					var index = parent.layer.getFrameIndex(window.name); // 获取窗口索引
					parent.layer.close(index);
				}
				return;
			}
			// 更新或新增成功，并刷新表格，必须在关闭当前窗口前调用
			if(typeof(seachFunName)  == "function"){
				if(param instanceof Array ){							
					//之后改进
					if(param.length == 2){
						seachFunName(param[0],param[1]);
					}else{
						seachFunName(param[0]);
					}
				}else{
					seachFunName(param);
				}
			}
		} else {
			$("#message").html('<div class="Huialert Huialert-success formMsg">&nbsp;</div>');
		}
	}
}

function initFormExeCallFun(resultType, resultMsg, callBackModel) {
	if (resultType < 0) {
		$("#message").html('<div class="Huialert Huialert-danger formMsg">' + resultMsg + '</div>');
	} else {
		if (resultMsg != '') {
			$("#message").html('<div class="Huialert Huialert-success formMsg">' + resultMsg + '</div>');
			if(resultType == '6'){
				//更新或新增成功，并刷新表格
				if(callBackModel){
					if(callBackModel.fun){  //有传成功的回调函数
						if(callBackModel.params){
							callBackModel.fun.call(this,callBackModel.params);
						}else{
							callBackModel.fun.call(this);
						}
					}
				}
			}
		} else {
			$("#message").html('<div class="formMsg">&nbsp;</div>');
		}
	}
}

function doResetSelect2(formName){
	var obj = $("#"+formName)[0];
	var selectList = $(obj).find("select");
	var length = selectList.length;
	//清除多选下拉框中的数据
	$('#'+ formName +'  .select2-container.select2-container-multi ').select2('val', '');
	
	for(var i = 0 ;i < length; i++){
		var selectObj = selectList[i];
		var id = selectObj.id;
		
		if(id != null && typeof(id) != 'undefined' && id.indexOf("@multiselect_") == 0){
			var defaultValue = $("#\\"+id).attr("defaultValue");
			if(typeof defaultValue != "undefined" && defaultValue !=null && defaultValue != ""){
				var selectedValues = defaultValue.split(',');
				$("#\\"+id).select2("val",selectedValues);
				//触发change事件,(重置时改变隐藏input值)
				$("#\\" + id).trigger("change");
			}
		}else{
			//联动下拉框需要获取默认初始值
			var defaultValue = $("#"+id).attr("defaultValue");
			if(defaultValue != null && typeof(defaultValue) != "undefined" ){
				$("#"+id).select2("val",defaultValue);
			}else{
				$("#"+id).select2("val", $("#"+id).find(':selected').val());
			}
			$("#"+id).change();
		}
	}
	
	doResetSinglePageSelect(obj);
}

function doSetSinglePageSelect(id,value){
	$("#"+id).select2("val",value);
	$("#" + id).trigger("change");
};

function doResetSinglePageSelect(obj){
	var selectPageList = $(obj).find("input[class='singlepageselect']");
	var length = selectPageList.length;
	for(var i = 0 ;i < length; i++){
		var selectObj = selectPageList[i];
		var id = selectObj.id;
		var defaultValue = $("#"+id).attr("defaultValue");
		if(defaultValue != null && typeof(defaultValue) != "undefined" ){
			$("#"+id).select2("val",defaultValue);
		}else{
			$("#"+id).select2("val", "");
		}
		$("#" + id).trigger("change");
	}
	
	//多选分页
	var multiSelectPageList = $(obj).find("input[class='multipageselect']");
	var multiLength = multiSelectPageList.length;
	for(var i = 0 ;i < multiLength; i++){
		var selectObj = multiSelectPageList[i];
		var id = selectObj.id;
		var defaultValue = $("#\\"+id).attr("defaultValue");
		if(defaultValue != null && typeof(defaultValue) != "undefined"  && defaultValue != ""){
			var selectedValues = defaultValue.split(',');
			$("#\\"+id).select2("val",selectedValues);
		}else{
			$("#\\"+id).select2("val", "".split(','));
		}
		$("#\\" + id).trigger("change");
	}
}

function doResetCheckBoxs(formName){
	var obj = $("#"+formName)[0];
	$(obj).find(":checkbox").trigger("change");
}

function doResetForm(formName){
	if ($("#" + formName).length > 0) {
		$("#" + formName)[0].reset();
		doResetSelect2(formName);
		doResetCheckBoxs(formName);
	}
}

function setSelectedId(targetTable) {
	var selectedId;
	if ($("#" + targetTable).jqGrid("getGridParam", "multiselect")) {
		selectedId = $("#" + targetTable).jqGrid("getGridParam", "selarrrow");
	} else {
		selectedId = $("#" + targetTable).jqGrid("getGridParam", "selrow");
	}
	if(typeof(selectedId) != 'undefined'){
		$("#" + targetTable).attr("selectedID",selectedId);
		var page = $("#mainTable").getGridParam('page');
		$("#" + page).attr("page",page);
	}
}

function removeSelectedId(targetTable){
	$("#" + targetTable).removeAttr("selectedID");
}

function setPage(targetTable){
	var page = $("#"+targetTable).getGridParam('page');
	$("#"+targetTable).attr("page",page);
}

function jqGridSetSelectionAndFocus(obj){
	var selectedID = $(obj).attr('selectedID');
	if(typeof(selectedID) != "undefined"){
		/********** modify by wzf (20170213) start **********/
		//$(obj).jqGrid('setSelection', selectedID)
		var selectedIdArray = selectedID.split(",");
		for (var i = 0; i < selectedIdArray.length; i++) {
			$(obj).jqGrid('setSelection', selectedIdArray[i]);
		}
		/********** modify by wzf (20170213) end **********/
		$("#" + $(obj).jqGrid('getGridParam', 'selrow')).focus();
	}
}

function getPage(targetTable){
	var page = $("#" + targetTable).attr(
			"page");
	if(isNaN(page)){
		page = 1;
	}
	return page;
}
/*要解决的问题：文本框是readonly时，safari浏览器点击时还是有光标*/
function readonlyProForSafari(e){
	$(e).blur();
}
/*将readonly的inpout框样式恢复*/
function clearReadonlyComponentStyle(){
	$("form input[readonly=readonly]").each(function(){
		$(this).attr("class",$(this).attr("class").replace("focus",""));
	});
}
/*条件部收缩*/
function createSelectCondition(defaultParam,path,nodename){
	var obj = document.getElementById('selectCondition');
	var objb = document.getElementById('condition');
	if(objb) {
		objb.onclick = function(){
			chooseSelectCondition(obj);
			screenResize();
			initGridSize("mainTable", "mainPager");
		};
	}
	if (defaultParam=="none"){
		chooseSelectCondition(obj);
		screenResize();
		initGridSize("mainTable", "mainPager");
	}
}

//显示隐藏查询条件
function chooseSelectCondition(obj,form,defaultParam){
	$(obj).find("div").first().toggle();
	if($("#condition").attr("isOpen") ==='true'){
		$("#condition").attr("isOpen","false");
		$("#condition").html("+");
	}else{
		$("#condition").attr("isOpen","true");
		$("#condition").html("-");
	}
	var overflowx = $(obj).closest("html").css("overflow-x");
	var overflowy = $(obj).closest("html").css("overflow-y");
	$(obj).closest("html").css("overflow-x", "hidden");
	$(obj).closest("html").css("overflow-y", "hidden");
	$(obj).closest("html").css("overflow-x", overflowx);
	$(obj).closest("html").css("overflow-y", overflowy);
    $(window).trigger('resize');
}

/*条件部收缩 webpage-4使用*/
function createSelectConditionNotResize(defaultParam,path,nodename){
	var obj = document.getElementById('selectCondition');
	var objb = document.getElementById('condition');
	if(objb) {
		objb.onclick = function(){
			chooseSelectCondition(obj);
		};
	}
	if (defaultParam=="none"){
		chooseSelectCondition(obj);
	}
}

function selectConditionOpened(obj){
  return $("span.tree-wrap-ltr", obj).hasClass("ui-icon-circlesmall-minus");
}

function openValueList(id,pageId,listName){
	var widgetValue = $("#"+id).val();
	var url = ctx + "/valueList?pageId=" + pageId + "&widgetCode=" + id;
    if(widgetValue.length>0){
    	url = url + "&widgetValue="+widgetValue;	
	}
	layer_show(listName,url,900, 400);
}

function setMultiSelectPage(id,value){
	if(value){
		var selectedValues = value.split(',');
		$("#\\@multiselect_"+id).select2("val",selectedValues);
		$("#\\@multiselect_" + id).trigger("change");
	}
}


formatGridEdit = function(pageId,columId){
	var obj = {};
	obj["@webPageId"] = pageId;
	obj["@columId"] = columId;
	$.ajaxSetup({ async : false });  //设置成同步
	var url = ctx + "/webpage/gridEditSelectFormatData";
	var selectFormat = "";
	$.post(url, obj, function(data) {
		if(data){
			var selectArray = JSON.parse(data);
			if(selectArray !=null && selectArray.length > 0 ){
				$.each(selectArray,function(n,selectObj) {
					if(n != 0){
						selectFormat += ";";
					}
					selectFormat += selectObj.value + ":" + selectObj.text;
				});  
			}
		}
	});
	return selectFormat;
	$.ajaxSetup({ async : true });  //设置成同步
}

getGridEditBySql = function(pageId,columId){
	var obj = {};
	obj["@webPageId"] = pageId;
	obj["@columId"] = columId;
	$.ajaxSetup({ async : false });  //设置成同步
	var url = ctx + "/webpage/gridEditSelectFormatData";
	var selectArray = new Array();
	$.post(url, obj, function(data) {
		if(data){
			selectArray = JSON.parse(data);
		}
	});
	return selectArray;
	$.ajaxSetup({ async : true });  //设置成同步
}

function resetGridEdit(gridId,resetArray){
	if(resetArray != null && resetArray.length > 0){
		for(var i=0;i<resetArray.length;i++){
			$("#"+gridId).jqGrid("restoreRow",resetArray[i]);
			$("#"+gridId).jqGrid("editRow",resetArray[i]);
		}
	}
}

function updateGridEditFun(gridId,inlineArray,actionType,
		parameterMap,subGridId,id){
	var obj = {};
	var changeArray = new Array();
	var changeId;
	for(var i=0;i<inlineArray.length;i++){
		changeId = inlineArray[i];
		var rowObj = $("#"+gridId).jqGrid("getRowData", changeId);
		$("#"+gridId).find("#"+changeId +" input,select").each(function () {
            var name = this.name;
            var value = $(this).val();
            if(this.type == "checkbox"){
				if(!this.checked){
					value = this.getAttribute("offval");
				}
			}
            rowObj[name]=value;
		});
		changeArray.push(rowObj);
	}
	obj["@gridDataList"] = JSON.stringify(changeArray);
	obj["@gridEditOper"] = "update";
	
	//清除错误背景色提示
	$("#" + gridId +" .gridEdit-error").removeClass("gridEdit-error");
	
	var result = doGridEditAction(gridId,obj,actionType,
			{'condition1':'\#{mainTable.condition1}'},subGridId,id);
	if(!result.result){
		if(result.exceptId){
			$("#" + gridId +" #"+result.exceptId).addClass("gridEdit-error");
		}
	}
	return result;
}

function downLoadCustomFile(buttonId) {
	var webPageId =  $("#\\@webPageId").val();
	var parameterData = {};
	parameterData["@webPageId"] = webPageId;
	parameterData["@buttonId"] = buttonId;
	$.ajax({
		url : ctx + "/webpage/checkFileIsExist",
		type : "post",
		data : parameterData,
		success : function(data) {
			var result = JSON.parse(data);
			if(result.resultType > 0){
				window.location.href = ctx + "/webpage/downLoadFile?@webPageId=" + webPageId +"&@buttonId=" + buttonId ;
			}else{
				showError(result.resultMsg);
			}
		},
		error:function(){
			showError('<tags:msg key="error.downLoadFileNotExsit"/>')
		}
	});
}

function listAndSetValue(valueListId){
	var webPageId =  $("#\\@webPageId").val();
	var widgetValue = $("#"+valueListId).val();
	var parameterData = {};
	parameterData["pageId"] = webPageId;
	parameterData["widgetCode"] = valueListId;
	parameterData[valueListId] = widgetValue;
	$.ajax({
		url :  ctx + "/valueList/listAndSetValue",
		type : "post",
		data : parameterData,
		success : function(data) {
			var result = JSON.parse(data);
			if(result.resultType == "1"){
				var obj = result.dataModel;
				for ( var key in obj) {
					if (obj.hasOwnProperty(key) === true){  
						$("#"+key).val(obj[key]);
					}
				}
			}
		}
	});
}

function keyPressBind(gridId) {
	$("#"+gridId).on("keyup","input,select",function(e) {
		// 兼容FF和IE和Opera
		var theEvent = e || window.event;
		var code = theEvent.keyCode || theEvent.which || theEvent.charCode;
		if (code == 13) {
			var inputArray = $("#"+gridId+" input,select[role='select']");
			var countInput = inputArray.length;
			if (countInput > 0 ) {
				var index = $("#"+gridId+" input ").index(this);
				if (index + Number(1) > countInput - Number(1) ) {
					index = 0;
				} else {
					index ++;
				}
				inputArray.eq(index).focus();
			}
		}
	});
}

function getArrayObj(arrPerson,objPropery,objValue) {
	return $.grep(arrPerson, function(cur,i) {
		return cur[objPropery]==objValue;
	});
}

function serializeArrayToJson(jsonObj, array) {
    for (var key in jsonObj) {
       jsonObj[key] = encodeURI(jsonObj[key]);
    }
    for (var i in array) {
       jsonObj[array[i].name] = encodeURI(encodeURI(array[i].value));
    }
    return jsonObj;
}


/** 解决jQuery1.9以后取消$.browser后导致的不兼容问题 **/
(function(jQuery) {

	if (jQuery.browser)
		return;

	jQuery.browser = {};
	jQuery.browser.mozilla = false;
	jQuery.browser.webkit = false;
	jQuery.browser.opera = false;
	jQuery.browser.msie = false;

	var nAgt = navigator.userAgent;
	jQuery.browser.name = navigator.appName;
	jQuery.browser.fullVersion = '' + parseFloat(navigator.appVersion);
	jQuery.browser.majorVersion = parseInt(navigator.appVersion, 10);
	var nameOffset, verOffset, ix;

	// In Opera, the true version is after "Opera" or after "Version"
	if ((verOffset = nAgt.indexOf("Opera")) != -1) {
		jQuery.browser.opera = true;
		jQuery.browser.name = "Opera";
		jQuery.browser.fullVersion = nAgt.substring(verOffset + 6);
		if ((verOffset = nAgt.indexOf("Version")) != -1)
			jQuery.browser.fullVersion = nAgt.substring(verOffset + 8);
	}
	// In MSIE, the true version is after "MSIE" in userAgent
	else if ((verOffset = nAgt.indexOf("MSIE")) != -1) {
		jQuery.browser.msie = true;
		jQuery.browser.name = "Microsoft Internet Explorer";
		jQuery.browser.fullVersion = nAgt.substring(verOffset + 5);
	}
	// In Chrome, the true version is after "Chrome"
	else if ((verOffset = nAgt.indexOf("Chrome")) != -1) {
		jQuery.browser.webkit = true;
		jQuery.browser.name = "Chrome";
		jQuery.browser.fullVersion = nAgt.substring(verOffset + 7);
	}
	// In Safari, the true version is after "Safari" or after "Version"
	else if ((verOffset = nAgt.indexOf("Safari")) != -1) {
		jQuery.browser.webkit = true;
		jQuery.browser.name = "Safari";
		jQuery.browser.fullVersion = nAgt.substring(verOffset + 7);
		if ((verOffset = nAgt.indexOf("Version")) != -1)
			jQuery.browser.fullVersion = nAgt.substring(verOffset + 8);
	}
	// In Firefox, the true version is after "Firefox"
	else if ((verOffset = nAgt.indexOf("Firefox")) != -1) {
		jQuery.browser.mozilla = true;
		jQuery.browser.name = "Firefox";
		jQuery.browser.fullVersion = nAgt.substring(verOffset + 8);
	}
	// In most other browsers, "name/version" is at the end of userAgent
	else if ((nameOffset = nAgt.lastIndexOf(' ') + 1) < (verOffset = nAgt
			.lastIndexOf('/'))) {
		jQuery.browser.name = nAgt.substring(nameOffset, verOffset);
		jQuery.browser.fullVersion = nAgt.substring(verOffset + 1);
		if (jQuery.browser.name.toLowerCase() == jQuery.browser.name
				.toUpperCase()) {
			jQuery.browser.name = navigator.appName;
		}
	}
	// trim the fullVersion string at semicolon/space if present
	if ((ix = jQuery.browser.fullVersion.indexOf(";")) != -1)
		jQuery.browser.fullVersion = jQuery.browser.fullVersion
				.substring(0, ix);
	if ((ix = jQuery.browser.fullVersion.indexOf(" ")) != -1)
		jQuery.browser.fullVersion = jQuery.browser.fullVersion
				.substring(0, ix);

	jQuery.browser.majorVersion = parseInt('' + jQuery.browser.fullVersion, 10);
	if (isNaN(jQuery.browser.majorVersion)) {
		jQuery.browser.fullVersion = '' + parseFloat(navigator.appVersion);
		jQuery.browser.majorVersion = parseInt(navigator.appVersion, 10);
	}
	jQuery.browser.version = jQuery.browser.majorVersion;
})(jQuery);

function setTabVisible(tabId, index, isVisible) {

	var titleObj = $("#" + tabId + " .tabBar span:eq(" + index + ")");

	if (isVisible) {
		$("#" + tabId).parent().removeClass("hide");
		$("#" + tabId).removeClass("hide");
		titleObj.show();
	} else {
		titleObj.hide();
		if (titleObj.hasClass("current")) {
			$("#" + tabId + " .tabBar span:visible:first").click();
		}
	}
}

document.addEventListener("fullscreenchange", function(e) {
	escExitFullScreen()
});
document.addEventListener("mozfullscreenchange", function(e) {
	escExitFullScreen()
});
document.addEventListener("webkitfullscreenchange", function(e) {
	escExitFullScreen()
});
document.addEventListener("msfullscreenchange", function(e) {
	escExitFullScreen()
});

function escExitFullScreen() {
	var isFullscreen = document.fullscreenEnabled || window.fullScreen || document.mozFullScreen
		|| document.webkitIsFullScreen || document.msFullscreenEnabled;
	if (!isFullscreen) {
		exitFullScreen();
	}
}

function viewFullScreen() {

	var successFlag = true;
	var docElm = document.getElementById("mainContent");
	if (docElm.requestFullscreen) {
		docElm.requestFullscreen();
	} else if (docElm.msRequestFullscreen) {
		docElm.msRequestFullscreen();
	} else if (docElm.mozRequestFullScreen) {
		docElm.mozRequestFullScreen();
	} else if (docElm.webkitRequestFullScreen) {
		docElm.webkitRequestFullScreen();
	} else {
		successFlag = false;
		alert("当前浏览器不支持全屏化操作！");
	}
	if (successFlag) {
		$("#viewFullScreen").hide();
		$("#exitFullScreen").show();
		if (!$(".pngfix").hasClass("open")) {
			displaynavbar($(".pngfix")[0]);
		}
	}
}

function exitFullScreen() {

	var successFlag = true;
	if (document.exitFullscreen) {
		document.exitFullscreen();
	} else if (document.msExitFullscreen) {
		document.msExitFullscreen();
	} else if (document.mozCancelFullScreen) {
		document.mozCancelFullScreen();
	} else if (document.webkitCancelFullScreen) {
		document.webkitCancelFullScreen();
	} else {
		successFlag = false;
		alert("当前浏览器不支持全屏化操作！");
	}
	if (successFlag) {
		viewFullScreenFlag = false;
		$("#viewFullScreen").show();
		$("#exitFullScreen").hide();
		if ($(".pngfix").hasClass("open")) {
			displaynavbar($(".pngfix")[0]);
		}
	}
}
function openLoading() {
	if (document.getElementById("over")) {

		document.getElementById("over").style.display = "block";
	}
	if (document.getElementById("layout")) {

		document.getElementById("layout").style.display = "block";
	}
}
function closeLoading() {
	if (document.getElementById("over")) {

		document.getElementById("over").style.display = "none";
	}
	if (document.getElementById("layout")) {

		document.getElementById("layout").style.display = "none";
	}
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

function formatnumber(value, num) {
	var a, b, c, i;
    a = value.toString();
    b = a.indexOf(".");
    c = a.length;
    
    if (num == 0) {
        if (b != -1) {
            a = a.substring(0, b);
        }
    } else {//如果没有小数点
        if (b == -1) {
            a = a + ".";
            for (i = 1; i <= num; i++) {
                a = a + "0";
            }
        } else {//有小数点，超出位数自动截取，否则补0
            a = a.substring(0, b + num + 1);
            for (i = c; i <= b + num; i++) {
                a = a + "0";
            }
        }
    }
    
    return a;
}

function formatCurrency(num) {
    if(isNaN(num))
        num = "0.00";
    num = Number(num).toFixed(2);
    var numStart = num.split(".")[0].replace(/\d{1,3}(?=(\d{3})+(\.\d*)?$)/g,'$&,');
    var numEnd = num.split(".")[1];
    return numStart + "." + numEnd;
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

function clearNoNum(obj){
    obj.value = obj.value.replace(/[^\d.-]/g,"");  //清除“数字”和“.”以外的字符
    obj.value = obj.value.replace(/^\./g,"");  //验证第一个字符是数字而不是.
    obj.value = obj.value.replace(/\.{2,}/g,"."); //只保留第一个. 清除多余的.
    obj.value = obj.value.replace(".","$#$").replace(/\./g,"").replace("$#$",".");
    obj.value = obj.value.replace(/\.\d{4,}$/,obj.value.substr(obj.value.indexOf('.'),5));//只保留小数点后两位小数
}

function checkFinalOrdInputGroup(ids){
    var finalOrdInputGroupFlag = true;
    var compySname = "";

	var mainTable = $("#mainTable");
	if(mainTable.length==0){
        mainTable = $("#mainGrid");
	}

    for(var i=0;i<ids.length;i++){
        var id = ids[i];
        var obj = mainTable.jqGrid('getRowData', id);
        if(isBlank(obj.finalOrdInputGroup)) {
            finalOrdInputGroupFlag = false;
            if (typeof(obj.compyName) == "undefined") {
                if (compySname.indexOf(obj.compySname) >= 0)
                    continue;
                compySname += "," + obj.compySname;
            } else {
                if (compySname.indexOf(obj.compyName) >= 0)
                    continue;
                compySname += "," + obj.compyName;
            }
        }
    }
    compySname = compySname.substring(1);
    if(!finalOrdInputGroupFlag){
        var index = layer.confirm("【"+compySname+"】无法确定结算单位，请选择", {
            btn: ['兆冠','运道','取消'], //按钮
            icon: 8,
            closeBtn:0
        }, function () {
            setFinalOrdInputGroup(ids,BizConstant.BELONG_COMPY.ZG_BELONG_COMPY_CODE
				,BizConstant.BELONG_COMPY.ZG_BELONG_COMPY_NAME);
            parent.showAlert("设置成功,请重新提交！")
            layer.close(index)
        }, function () {
            setFinalOrdInputGroup(ids,BizConstant.BELONG_COMPY.YD_BELONG_COMPY_CODE
                ,BizConstant.BELONG_COMPY.YD_BELONG_COMPY_NAME);
            parent.showAlert("设置成功,请重新提交！")
        }, function () {

        });
    }

    return finalOrdInputGroupFlag;

}

function setFinalOrdInputGroup(ids,finalOrdInputGroup,finalOrdInputGroupName) {
    var mainTable = $("#mainTable");
    if(mainTable.length==0){
        mainTable = $("#mainGrid");
    }
    for(var i=0;i<ids.length;i++){
        var id = ids[i];
        var obj = mainTable.jqGrid('getRowData', id);
        if(isBlank(obj.finalOrdInputGroup)){
            mainTable.jqGrid("setCell",id,"finalOrdInputGroup",finalOrdInputGroup);
            mainTable.jqGrid("setCell",id,"finalOrdInputGroupName",finalOrdInputGroupName);
        }
    }
}

function setSessionStorageItem(fieldName,fieldValue) {
    if(!window.sessionStorage){
        console.log("浏览器不支持sessionStorage");
        return false;
    }else {
        window.sessionStorage.setItem(fieldName,fieldValue);
    }
}

function getSessionStorageItem(fieldName) {
    if(!window.sessionStorage){
        console.log("浏览器不支持sessionStorage");
        return false;
    }else {
        var fieldValue = window.sessionStorage.getItem(fieldName);
        if(!isBlank(fieldValue)) {
            return fieldValue;
        } else {
            return '';
        }
    }
}

function removeSessionStorageItem(fieldName) {
    if(!window.sessionStorage){
        console.log("浏览器不支持sessionStorage");
        return false;
    }else {
        window.sessionStorage.removeItem(fieldName);
    }
}

//非空判断
function isBlank(obj){
    return(!obj || $.trim(obj) == "");
}

//layer关闭自身窗口
function closeSelfLayer() {
    var index = parent.layer.getFrameIndex(window.name);
    parent.layer.close(index);
}

function trim(obj) {
    obj.value = obj.value.replace(/(^\s*)|(\s*$)/g, "");
    obj.value = obj.value.replace(/[^\u4E00-\u9FFF\x21-\x7E\’]/g, "");
}