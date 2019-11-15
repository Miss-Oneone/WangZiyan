<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag trimDirectiveWhitespaces="true" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ attribute name="id" type="java.lang.String" required="true" description="ID"%>
<%@ attribute name="name" type="java.lang.String" required="false" description="名称"%>
<%@ attribute name="value" type="java.lang.String" required="false" description="值1,值2,值3"%>
<%@ attribute name="width" type="java.lang.String" required="false" description="宽度"%>
<%@ attribute name="remoteData" type="java.lang.String" required="false" description="远程下拉选项数据(JSON格式)"%>
<%@ attribute name="required" type="java.lang.String" required="false" description="是否必输"%>
<%@ attribute name="disabled" type="java.lang.String" required="false" description="是否禁用"%>
<%@ attribute name="defaultValue" type="java.lang.String" required="false" description="默认值"%>
<%@ attribute name="readonly" type="java.lang.String" required="false" description="是否只读"%>
<%@ attribute name="onchange" type="java.lang.String" required="false" description="值变更事件"%>
<input type="hidden" id="@multiselect_${id}" class="multipageselect" name="@multiselect_${empty pageScope.name ? pageScope.id : pageScope.name}" style="width:${empty width ? 200 : width}px" defaultValue="${value}" onchange="${onchange}"/>
<input type="hidden" id="${id}" class="multipageselect" name="${empty name ? id : name}"/>
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
		initPageMultiSelect("${id}", url, parameterData, initFlag, ${empty required or required eq 'false' ? 'false' : 'true'}, ${empty readonly or readonly eq 'false' ? 'false' : 'true'}, ${empty disabled or disabled eq 'false' ? 'true' : 'false'}, ${empty width ? 200 : width}, "${value}");
		$("#\\@multiselect_${id}").bind("change", function() {
			if ($(this).val() == null || $(this).val() == "") {
				$("#${id}").val("");
			} else {
				var value = "";
				var valArray = $(this).val().split(",");
				for (var i = 0; i < valArray.length; i++) {
					if (i == 0) {
						value += "'" + valArray[i] + "'";
					} else {
						value += ",'" + valArray[i] + "'";
					}
				}
				$("#${id}").val(value);
			}
		});
		$("#\\@multiselect_${id}").select2("val", "${value}".split(","));
		$("#\\@multiselect_${id}").trigger("change");
		//});
	} catch(e) {
		$.ajaxSetup({ async : true });  //设置成异步
	}
	$.ajaxSetup({ async : true });  //设置成异步
});
</script>
