<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ attribute name="id" type="java.lang.String" required="true" description="ID"%>
<%@ attribute name="key" type="java.lang.String" required="true" description="消息ID"%>
<%@ attribute name="type" type="java.lang.String" required="false" description="类型"%>
<%@ attribute name="onclick" type="java.lang.String" required="false" description="点击事件"%>
<%@ attribute name="cssClass" type="java.lang.String" required="false" description="css样式"%>
<%@ attribute name="cssStyle" type="java.lang.String" required="false" description="css样式"%>
<%@ attribute name="disabled" type="java.lang.String" required="false" description="是否禁用"%>
<input id="${id}" type="${not empty type && type eq 'submit' ? 'submit' : 'button'}"
	class="btn ${not empty type && type eq 'submit' ? 'btn-primary' : ''} ${cssClass}"
	value="<fmt:message key='${key}'/>" onclick="${onclick}" style='${cssStyle}'
	${not empty disabled && disabled eq 'true' ? 'disabled' : ''}/>
