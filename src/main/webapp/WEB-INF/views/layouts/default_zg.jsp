<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<!DOCTYPE html>
<html style="overflow-x:hidden;overflow-y:auto;">
	<head>
		<title><sitemesh:title/> - <fmt:message key="system.name"/></title>
		<%@include file="/WEB-INF/views/include/head_zg.jsp" %>
		<sitemesh:head/>
	</head>
	<body>
		<sitemesh:body/>
		<%@include file="/WEB-INF/views/include/footer_sunsail.jsp" %>
	</body>
</html>
