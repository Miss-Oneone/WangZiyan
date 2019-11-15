<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ attribute name="id" type="java.lang.String" required="true" description="ID"%>
<%@ attribute name="name" type="java.lang.String" required="true" description="名称"%>
<%@ attribute name="value" type="java.lang.String" required="false" description="值"%>
<%@ attribute name="dateFormat" type="java.lang.String" required="false" description="日期格式"%>
<%@ attribute name="isShowClear" type="java.lang.String" required="false" description="是否显示清空按钮"%>
<%@ attribute name="cssClass" type="java.lang.String" required="false" description="css样式"%>
<%@ attribute name="cssStyle" type="java.lang.String" required="false" description="css样式"%>
<%@ attribute name="disabled" type="java.lang.String" required="false" description="是否禁用"%>
<%@ attribute name="minDate" type="java.lang.String" required="false" description="最小日期"%>
<%@ attribute name="maxDate" type="java.lang.String" required="false" description="最大日期"%>
<input id="${id}" name="${name}" type="text" class="input-small Wdate ${cssClass}"
	maxlength="20"  value="${value}" readonly="readonly" style="${cssStyle}" minDate="${minDate}" maxDate="${maxDate}" 
	onclick="WdatePicker({dateFmt:'${empty dateFormat ? 'yyyy-MM-dd' : dateFormat}',isShowClear:${empty isShowClear ? 'true' : isShowClear}});disableKey();"/>
<script>
function disableKey() {
	$($("div[lang='zh-cn'] > iframe", window.parent.document).contents()).keydown(function(e) {
		disableBackSpaceKey(e);
	});
}

$(document).ready(function() {
	var id = "${id}";
	var minDate = "${minDate}";
	var maxDate = "${maxDate}";
	var clickEvent = $("#" + id).attr("onclick");
	var newEvent = clickEvent;
	var pre = "WdatePicker({";
	var len = pre.length;
	if (minDate != "" || maxDate != "") {
		if (maxDate != "") {
			var expr = 'maxDate:\'#F{$dp.$D(\\\'' + maxDate + '\\\')}\','
			if ($("#" + maxDate).length == 0) {
				expr = 'maxDate:\'#F{\\\'' + maxDate + '\\\'}\',';
			}
			var preIndex = newEvent.indexOf(pre);
			if (preIndex >= 0) {
				var pre = newEvent.substring(0, len);
				var suf = newEvent.substring(len);
				newEvent = pre + expr + suf;
			}
		}
		if (minDate != "") {
			var expr = 'minDate:\'#F{$dp.$D(\\\'' + minDate + '\\\')}\','
			if ($("#" + minDate).length == 0) {
				expr = 'minDate:\'#F{\\\'' + minDate + '\\\'}\',';
			}
			var preIndex = newEvent.indexOf(pre);
			if (preIndex >= 0) {
				var pre = newEvent.substring(0, len);
				var suf = newEvent.substring(len);
				newEvent = pre + expr + suf;
			}
		}
		
		$("#" + id).attr("onclick", newEvent);
	}
});
</script>
