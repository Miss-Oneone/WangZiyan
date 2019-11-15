<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ attribute name="path" type="java.lang.String" required="true" description="路径"%>
<%@ attribute name="id" type="java.lang.String" required="false" description="ID"%>
<%@ attribute name="name" type="java.lang.String" required="false" description="名称"%>
<%@ attribute name="value" type="java.lang.String" required="false" description="值"%>
<%@ attribute name="maxlength" type="java.lang.String" required="false" description="最大长度"%>
<%@ attribute name="cssClass" type="java.lang.String" required="false" description="css样式"%>
<%@ attribute name="cssStyle" type="java.lang.String" required="false" description="css样式"%>
<%@ attribute name="disabled" type="java.lang.String" required="false" description="是否禁用"%>
<%@ attribute name="readonly" type="java.lang.String" required="false" description="是否只读"%>
<%@ attribute name="onblur" type="java.lang.String" required="false" description="光标移开事件"%>
<form:input path="${path}" id="${empty id ? path : id}" name="${empty name ? path : name}" 
	htmlEscape="false" maxlength="${empty maxlength ? 30 : maxlength}" 
	class="input-small ${cssClass}" style="${cssStyle}"
	value="${value}" disabled="${empty disabled ? false : disabled}"
	readonly="${empty readonly ? false : readonly}" onblur="${onblur}"/>
