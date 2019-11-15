<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ attribute name="path" type="java.lang.String" required="true" description="路径"%>
<%@ attribute name="value" type="java.lang.String" required="false" description="值"%>
<form:hidden path="${path}" value="${value}"/>
