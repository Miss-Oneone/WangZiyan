<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag trimDirectiveWhitespaces="true" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ attribute name="id" type="java.lang.String" required="true" description="ID"%>
<%@ attribute name="value" type="java.lang.String" required="false" description="值"%>
<%@ attribute name="defaultValue" type="java.lang.String" required="false" description="值"%>
<input type="hidden" id="${id}" name="${empty pageScope.name ? pageScope.id : pageScope.name}" value="${value}" defaultValue=${defaultValue}/>
