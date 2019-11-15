<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag trimDirectiveWhitespaces="true" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ attribute name="id" type="java.lang.String" required="true" description="ID"%>
<%@ attribute name="name" type="java.lang.String" required="false" description="名称"%>
<%@ attribute name="multiValue" type="java.lang.String" required="false" description="值1,值2,值3"%>
<%@ attribute name="width" type="java.lang.String" required="false" description="宽度"%>
<%@ attribute name="localData" type="java.lang.String" required="false" description="本地下拉选项数据(JSON格式)"%>
<%@ attribute name="remoteData" type="java.lang.String" required="false" description="远程下拉选项数据(JSON格式)"%>
<%@ attribute name="required" type="java.lang.String" required="false" description="是否必输"%>
<%@ attribute name="disabled" type="java.lang.String" required="false" description="是否禁用"%>
<%@ attribute name="readonly" type="java.lang.String" required="false" description="是否只读"%>
<%@ attribute name="onchange" type="java.lang.String" required="false" description="值变更事件"%>
<select id="@multiselect_${id}" name="@multiselect_${empty pageScope.name ? pageScope.id : pageScope.name}" 
 ${empty readonly or readonly eq 'false' ? '' : 'readonly=\"readonly\"'} 
multiple="multiple" defaultValue="${multiValue}" onchange="${onchange}">
</select>
<c:if test="${(empty readonly or readonly eq 'false') and (empty disabled or disabled eq 'false')}">
<img id="${id}Img" src="${ctxStatic}/sunsail/images/refresh.png" width="24" height="24" onclick="${id}Refresh()" style="cursor:pointer;"/>
</c:if>
<input type="hidden" id="${id}" name="${empty name ? id : name}"/>
<script>
$("#" + "${id}Img").parent().css({position:"relative"});
$("#" + "${id}Img").css({position:"absolute", top:"2px"});

$(document).ready(function(){
	${id}LoadData();
});
function ${id}LoadData() {
	var required = ${empty required or required eq 'false' ? 'false' : 'true'};
	var initFlag = false;
	if ("${multiValue}" != "" ) {
		initFlag = true;
	}
	if (required) {
		$("#\\@multiselect_${id}").bind("change", function() {
			if ($(this).val() == null) {
				$("#s2id_\\@multiselect_${id} input").attr("required", "required");
				$("#${id}").val("");
			} else {
				$("#s2id_\\@multiselect_${id} input").removeAttr("required");
				$("#${id}").val($(this).val());
			}
		});
	}
	$("#\\@multiselect_${id}").bind("change", function() {
		if ($(this).val() == null) {
			$("#${id}").val("");
		} else {
			var value = "";
			for (var i = 0; i < $(this).val().length; i++) {
				if (i == 0) {
					value += "'" + $(this).val()[i] + "'";
				} else {
					value += ",'" + $(this).val()[i] + "'";
				}
			}
			$("#${id}").val(value);
		}
	});
	var localData = '${fns:replaceQuote(localData, "\\'")}';
	if (localData != "") {
		var data = eval("(" + localData + ")");
		initMultiSelect("\\@multiselect_${id}", data, initFlag, required, ${empty readonly or readonly eq 'false' ? 'false' : 'true'}, ${empty disabled or disabled eq 'false' ? 'true' : 'false'}, ${empty width ? 200 : width}, "${multiValue}");
	} else if ("${remoteData}" != "") {
		var parameterData = {"id":"${remoteData}", "@webPageId":$("#\\@webPageId").val()};
		$.post("${ctx}/webpage/getDropDownListData", parameterData, function(strData) {
			var data = eval("(" + strData + ")");
			initMultiSelect("\\@multiselect_${id}", data, initFlag, required, ${empty readonly or readonly eq 'false' ? 'false' : 'true'}, ${empty disabled or disabled eq 'false' ? 'true' : 'false'}, ${empty width ? 200 : width}, "${multiValue}");
		});
	}
}
function ${id}Refresh() {
	${id}LoadData();
	$("#${id}").trigger("change");
	showTip("刷新完成！", 800);
}
</script>
