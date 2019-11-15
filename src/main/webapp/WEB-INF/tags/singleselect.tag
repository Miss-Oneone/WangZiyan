<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag trimDirectiveWhitespaces="true" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ attribute name="id" type="java.lang.String" required="true" description="ID"%>
<%@ attribute name="name" type="java.lang.String" required="false" description="名称"%>
<%@ attribute name="value" type="java.lang.String" required="false" description="值"%>
<%@ attribute name="width" type="java.lang.String" required="false" description="宽度"%>
<%@ attribute name="localData" type="java.lang.String" required="false" description="本地下拉选项数据(JSON格式)"%>
<%@ attribute name="remoteData" type="java.lang.String" required="false" description="远程下拉选项数据(JSON格式)"%>
<%@ attribute name="sysControlData" type="java.lang.String" required="false" description="系统控制表配置下拉选项数据(JSON格式)"%>
<%@ attribute name="required" type="java.lang.String" required="false" description="是否必输"%>
<%@ attribute name="disabled" type="java.lang.String" required="false" description="是否禁用"%>
<%@ attribute name="readonly" type="java.lang.String" required="false" description="是否只读"%>
<%@ attribute name="onchange" type="java.lang.String" required="false" description="值变更事件"%>
<select id="${id}" name="${empty pageScope.name ? pageScope.id : pageScope.name}" onchange="${onchange}">
	${empty required or required eq 'false' ? '<option value=""></option>' : ''}
</select>
<script>
$("#" + "${id}Img").parent().css({position:"relative"});
$("#" + "${id}Img").css({position:"absolute", top:"2px"});

$(document).ready(function() {
	${id}LoadData();
});
function ${id}LoadData() {
	var initFlag = false;
	if ("${value}" != "") {
		initFlag = true;
	}
	var localData = '${fns:replaceQuote(localData, "\\'")}';
	$.ajaxSetup({ async : false });  //设置成同步
	try{
		if (localData != '') {//使用单引号
			var data = eval('(' + localData + ')');
			initSelect("${id}", data, initFlag, ${empty required or required eq 'false' ? 'false' : 'true'}, ${empty readonly or readonly eq 'false' ? 'false' : 'true'}, ${empty disabled or disabled eq 'false' ? 'true' : 'false'}, ${empty width ? 200 : width}, "${value}");
		} else if ("${remoteData}" != "") {
			var parameterData = {"id":"${remoteData}", "@webPageId":$("#\\@webPageId").val()};
			$.post("${ctx}/webpage/getDropDownListData", parameterData, function(strData) {
				var data = eval("(" + strData + ")");
				initSelect("${id}", data, initFlag, ${empty required or required eq 'false' ? 'false' : 'true'}, ${empty readonly or readonly eq 'false' ? 'false' : 'true'}, ${empty disabled or disabled eq 'false' ? 'true' : 'false'}, ${empty width ? 200 : width}, "${value}");
			});
		} else if ("${sysControlData}" != "") {
			var parameterData = {"key":"${sysControlData}"};
			$.post("${ctx}/webpage/getDropDownListDataFromSysControl", parameterData, function(strData) {
				var data = eval("(" + strData + ")");
				initSelect("${id}", data, initFlag, ${empty required or required eq 'false' ? 'false' : 'true'}, ${empty readonly or readonly eq 'false' ? 'false' : 'true'}, ${empty disabled or disabled eq 'false' ? 'true' : 'false'}, ${empty width ? 200 : width}, "${value}");
			});
		}
	}catch(e){
		$.ajaxSetup({ async : true });  //设置成异步
	}
	$.ajaxSetup({ async : true });  //设置成异步
}

</script>
