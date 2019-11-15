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
<input id="${id}" name="${name}" type="text" class="input-small Wdate ${cssClass}"
	maxlength="20"  value="${value}" readonly="readonly" style="${cssStyle}" 
	onclick="WdatePicker({dateFmt:'${empty dateFormat ? 'yyyy-MM-dd' : dateFormat}',isShowClear:${empty isShowClear ? 'true' : isShowClear}});disableKey();"/>
<script>
function disableKey() {
	$($("div[lang='zh-cn'] > iframe", window.parent.document).contents()).keydown(function(e) {
		disableBackSpaceKey(e);
	});
}
</script>
