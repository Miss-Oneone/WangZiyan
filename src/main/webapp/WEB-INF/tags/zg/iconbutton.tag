<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ attribute name="id" type="java.lang.String" required="false" description="ID"%>
<%@ attribute name="name" type="java.lang.String" required="false" description="名称"%>
<%@ attribute name="icon" type="java.lang.String" required="true" description="图标"%>
<%@ attribute name="key" type="java.lang.String" required="true" description="消息ID"%>
<%@ attribute name="onclick" type="java.lang.String" required="false" description="点击事件"%>
<%@ attribute name="cssClass" type="java.lang.String" required="false" description="css样式"%>
<%@ attribute name="cssStyle" type="java.lang.String" required="false" description="css样式"%>
<%@ attribute name="disabled" type="java.lang.String" required="false" description="是否禁用"%>
<button id='${id}' name='${name}' class='${cssClass}' style='${cssStyle}' onclick='${not empty onclick ? onclick : "return false;"}' ${not empty disabled && disabled eq 'true' ? 'disabled' : ''}><span class='ui-icon ui-icon-${icon}'></span><span class='oms-button-text'><fmt:message key="${key}"/></span></button>
