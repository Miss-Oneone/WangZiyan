<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag trimDirectiveWhitespaces="true" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ attribute name="id" type="java.lang.String" required="true" description="ID"%>
<%@ attribute name="name" type="java.lang.String" required="false" description="名称"%>
<%@ attribute name="width" type="java.lang.String" required="false" description="宽度"%>
<%@ attribute name="remoteData" type="java.lang.String" required="true" description="远程下拉选项数据(JSON格式)"%>
<%@ attribute name="linkSrcId" type="java.lang.String" required="true" description="联动源对象ID"%>
<%@ attribute name="required" type="java.lang.String" required="false" description="是否必输"%>
<%@ attribute name="disabled" type="java.lang.String" required="false" description="是否禁用"%>
<%@ attribute name="defaultValue" type="java.lang.String" required="false" description="默认值"%>
<%@ attribute name="readonly" type="java.lang.String" required="false" description="是否只读"%>
<%@ attribute name="onchange" type="java.lang.String" required="false" description="值变更事件"%>
<%@ attribute name="value" type="java.lang.String" required="false" description="值"%>
<select id="${id}" name="${empty pageScope.name ? pageScope.id : pageScope.name}" onchange="${onchange}" defaultValue="${defaultValue}" flagType="linkSelect" >
	${empty required or required eq 'false' ? '<option value=""></option>' : ''}
</select>
<c:if test="${(empty readonly or readonly eq 'false') and (empty disabled or disabled eq 'false')}">
<img id="${id}Img" src="${ctxStatic}/sunsail/images/refresh.png" width="24" height="24" onclick="${id}Refresh()" style="cursor:pointer;position:absolute;top:2px;"/>
</c:if>
<script>
$("#" + "${id}Img").parent().css({position:"relative"});
$("#" + "${id}Img").css({position:"absolute", top:"2px"});

$(document).ready(function(){
	${id}LoadData();
});
function ${id}LoadData() {
	var initFlag = false;
	if ("${value}" != "") {
		initFlag = true;
	}
	var required = ${empty required or required eq 'false' ? 'false' : 'true'};
	$("#${id}").select2({
		 width: ${empty width ? 200 : width}
		,allowClear: !required
	});
	$("#${id}").select2("readonly", ${empty readonly or readonly eq 'false' ? 'false' : 'true'});
	$("#${id}").select2("enable", ${empty disabled or disabled eq 'false' ? 'true' : 'false'});
	if ($("#${linkSrcId}").val() != null) {
		var parameterData = {"id":"${remoteData}", "@webPageId":$("#\\@webPageId").val(), "${linkSrcId}":$("#${linkSrcId}").val()};
		$.ajaxSetup({ async : false });  //设置成同步
		$.post("${ctx}/webpage/getDropDownListData", parameterData, function(strData) {
			var data = eval("(" + strData + ")");
			initLinkSelect("${id}", data, initFlag, required, ${empty width ? 200 : width}, "${value}");
		});
		$.ajaxSetup({ async : true });  //设置成异步
	}
	$("#${linkSrcId}").bind("change", function() {
		if ($("#${linkSrcId}").val() != null && $("#${linkSrcId}").val() != "") {
			var parameterData = {"id":"${remoteData}", "@webPageId":$("#\\@webPageId").val(), "${linkSrcId}":$("#${linkSrcId}").val()};
			//设成同步,否则联动下拉无法设置初始值
			$.ajaxSetup({ async : false });  //设置成同步
			$.post("${ctx}/webpage/getDropDownListData", parameterData, function(strData) {
				var data = eval("(" + strData + ")");
				initLinkSelect("${id}", data, initFlag, required, ${empty width ? 200 : width});
			});
			$.ajaxSetup({ async : true });  //设置成异步
		} else {
			$("#${id}").empty();
			//$("#${id}").select2("val", "");
			$("#${id}").select2({
				 width: ${empty width ? 200 : width}
				,allowClear: !required
			});
			$("#${id}").trigger("change");
		}
	});
}
function ${id}Refresh() {
	${id}LoadData();
	showTip("刷新完成！", 800);
}
</script>
