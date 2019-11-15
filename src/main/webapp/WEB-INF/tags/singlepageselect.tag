<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag trimDirectiveWhitespaces="true" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ attribute name="id" type="java.lang.String" required="true" description="ID"%>
<%@ attribute name="name" type="java.lang.String" required="false" description="名称"%>
<%@ attribute name="value" type="java.lang.String" required="false" description="值"%>
<%@ attribute name="width" type="java.lang.String" required="false" description="宽度"%>
<%@ attribute name="remoteData" type="java.lang.String" required="false" description="远程下拉选项数据(JSON格式)"%>
<%@ attribute name="required" type="java.lang.String" required="false" description="是否必输"%>
<%@ attribute name="disabled" type="java.lang.String" required="false" description="是否禁用"%>
<%@ attribute name="defaultValue" type="java.lang.String" required="false" description="默认值"%>
<%@ attribute name="readonly" type="java.lang.String" required="false" description="是否只读"%>
<%@ attribute name="onchange" type="java.lang.String" required="false" description="值变更事件"%>
<input type="hidden" id="${pageScope.id}" class="singlepageselect" name="${empty pageScope.name ? pageScope.id : pageScope.name}" defaultValue="${pageScope.defaultValue}"   style="width:${empty pageScope.width ? 200 : pageScope.width}px" onchange="${onchange}"/>
<script>
$(document).ready(function() {
	var initFlag = false;
	if ("${value}" != "") {
		initFlag = true;
	}
	$.ajaxSetup({ async : false });  //设置成同步
	try {
		var parameterData = {"id":"${remoteData}", "@webPageId":$("#\\@webPageId").val()};
		var url = "${ctx}/webpage/getDropDownListDataPage";
		//$.post("${ctx}/webpage/getDropDownListData", parameterData, function(strData) {
			//var data = eval("(" + strData + ")");
		initPageSelect("${id}", url, parameterData, initFlag, ${empty required or required eq 'false' ? 'false' : 'true'}, ${empty readonly or readonly eq 'false' ? 'false' : 'true'}, ${empty disabled or disabled eq 'false' ? 'true' : 'false'}, ${empty width ? 200 : width}, "${value}");
		//});
	} catch(e) {
		$.ajaxSetup({ async : true });  //设置成异步
	}
	$.ajaxSetup({ async : true });  //设置成异步
});
</script>
