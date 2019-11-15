<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag trimDirectiveWhitespaces="true" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ attribute name="id" type="java.lang.String" required="true" description="ID"%>
<%@ attribute name="name" type="java.lang.String" required="false" description="名称"%>
<%@ attribute name="width" type="java.lang.String" required="false" description="宽度"%>
<%@ attribute name="localData" type="java.lang.String" required="false" description="本地选择项数据(JSON格式)"%>
<%@ attribute name="remoteData" type="java.lang.String" required="false" description="远程选择项数据(JSON格式)"%>
<%@ attribute name="multiSelect" type="java.lang.String" required="false" description="是否多选"%>
<%@ attribute name="multiValue" type="java.lang.String" required="false" description="值1,值2,值3"%>
<%@ attribute name="required" type="java.lang.String" required="false" description="是否必输"%>
<%@ attribute name="disabled" type="java.lang.String" required="false" description="是否禁用"%>
<%@ attribute name="readonly" type="java.lang.String" required="false" description="是否只读"%>
<%@ attribute name="cssStyle" type="java.lang.String" required="false" description="css样式"%>
<span id="@span_checkbox_${id}" style="${cssStyle}"></span>
<input type="hidden" id="${id}" flagType="checkBox" name="${empty name ? id : name}"/>
<script>
$(document).ready(function(){
	var required = ${empty required or required eq 'false' ? 'false' : 'true'};
	var readonlyFlag = ${empty readonly or readonly eq 'false' ? 'false' : 'true'};
	
	var initFlag = false;
	var localData = '${fns:replaceQuote(localData, "\\'")}';
	if (localData != "") {
		var data = eval("(" + localData + ")");
		initCheckBoxs("${id}", data, "${multiSelect}", "${multiValue}", readonlyFlag);
	} else if ("${remoteData}" != "") {
		var parameterData = {"id":"${remoteData}", "@webPageId":$("#\\@webPageId").val()};
		$.post("${ctx}/webpage/getDropDownListData", parameterData, function(strData) {
			var data = eval("(" + strData + ")");
			initCheckBoxs("${id}", data, "${multiSelect}", "${multiValue}", readonlyFlag);
		});
	}
});
</script>
