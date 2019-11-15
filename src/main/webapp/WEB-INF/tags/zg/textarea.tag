<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ attribute name="path" type="java.lang.String" required="true" description="路径"%>
<%@ attribute name="maxlength" type="java.lang.String" required="false" description="最大长度"%>
<%@ attribute name="rows" type="java.lang.String" required="false" description="显示行数"%>
<%@ attribute name="cols" type="java.lang.String" required="false" description="显示列数"%>
<%@ attribute name="cssClass" type="java.lang.String" required="false" description="css样式"%>
<%@ attribute name="cssStyle" type="java.lang.String" required="false" description="css样式"%>
<%@ attribute name="disabled" type="java.lang.String" required="false" description="是否禁用"%>
<%@ attribute name="readonly" type="java.lang.String" required="false" description="是否只读"%>
<form:textarea path="${path}" htmlEscape="false" maxlength="${empty maxlength ? 100 : maxlength}"
	rows="${empty rows ? 3 : rows}" cols="${empty cols ? 30 : cols}"
	class="${cssClass}" style="${cssStyle}"
	disabled="${empty disabled ? false : disabled}"
	readonly="${empty readonly ? false : readonly}" />
