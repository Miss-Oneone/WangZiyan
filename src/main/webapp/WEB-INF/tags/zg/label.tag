<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ attribute name="id" type="java.lang.String" required="false" description="ID"%>
<%@ attribute name="key" type="java.lang.String" required="true" description="消息ID"%>
<%@ attribute name="required" type="java.lang.String" required="false" description="是否必填"%>
<%@ attribute name="delimiter" type="java.lang.String" required="false" description="是否显示符号(冒号)"%>
<%@ attribute name="symbol" type="java.lang.String" required="false" description="符号"%>
<%@ attribute name="cssClass" type="java.lang.String" required="false" description="css样式"%>
<%@ attribute name="cssStyle" type="java.lang.String" required="false" description="css样式"%>
<%@ attribute name="align" type="java.lang.String" required="false" description="对齐方向"%>
<label id="${id}" style="text-align:${empty align ? 'right' : align};">${not empty required && required eq 'true' ? '<span style=\"color: red\">*</span>&nbsp;' : ''}<fmt:message key="${key}"/>${empty delimiter ? '：' : ''}</label>
