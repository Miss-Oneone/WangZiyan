<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<!DOCTYPE html>
<html lang="zh">
	<head>
		<title><fmt:message key="system.name"/></title>
		<%@include file="/WEB-INF/views/include/head_new.jsp" %>
		<sitemesh:head/>
	</head>
	<body class="mainContent">
		<sitemesh:body/>
		<%@include file="/WEB-INF/views/include/footer_new.jsp" %>
	</body>
</html>
