<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag trimDirectiveWhitespaces="true" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ attribute name="id" type="java.lang.String" required="true" description="ID"%>
<%@ attribute name="name" type="java.lang.String" required="false" description="名称"%>
<%@ attribute name="value" type="java.lang.String" required="false" description="值"%>
<%@ attribute name="width" type="java.lang.String" required="false" description="宽度"%>
<%@ attribute name="cssClass" type="java.lang.String" required="false" description="css样式"%>
<%@ attribute name="cssStyle" type="java.lang.String" required="false" description="css样式"%>
<%@ attribute name="required" type="java.lang.String" required="false" description="是否必输"%>
<%@ attribute name="disabled" type="java.lang.String" required="false" description="是否禁用"%>
<%@ attribute name="readonly" type="java.lang.String" required="false" description="是否只读"%>
<%@ attribute name="onchange" type="java.lang.String" required="false" description="变更事件" %>
<%@ attribute name="formmat" type="java.lang.String" required="false" description="日期格式化"%>
<%@ attribute name="startDate" type="java.lang.String" required="false" description="开始时间"%>
<input type="text" id="${id}" name="${empty pageScope.name ? pageScope.id : pageScope.name}" class="Wdate input-text form-text ${cssClass}" 
	maxlength="${empty maxlength ? 20 : maxlength}" style="width: ${empty width ? 200 : width}px;${cssStyle}" value="${value}"
	${empty disabled or disabled eq 'false' ? '' : 'disabled=\"disabled\"'}
	${empty readonly or readonly eq 'false' ? '' : 'readonly=\"readonly\"'}
	${empty required or required eq 'false' ? '' : 'required=\"required\"'}
	onclick="wdatePicker_${id}()"
	onchange="change()"
	/>
<script>
function wdatePicker_${id}(){
	if(!document.getElementById("${id}").readOnly){
		//格式化时间不能yyyy-MM-dd HH:mm:ss 否则ie不支持
		WdatePicker({lang:'${fns:getLanguage()}',dateFmt:'${empty formmat ? 'yyyy/MM/dd HH:mm:ss' : formmat}',startDate:'${empty startDate ? '' : startDate}',readOnly:true,onpicked:function(){
				//解决选择时间后若无失去 焦点无法再次弹出选择框问题(与控件只读属性冲突).
				document.getElementById("${id}").blur();
			},oncleared:function(){
				//解决清空日期后若无失去 焦点无法再次弹出选择框问题(与控件只读属性冲突).
				document.getElementById("${id}").blur();
			}
	});
		
	}

}
function change() {
    formatDate($("#${id}")[0], '${empty formmat ? 'yyyy-MM-dd HH:mm:ss' : formmat}')
	<%=onchange%>
}
</script>