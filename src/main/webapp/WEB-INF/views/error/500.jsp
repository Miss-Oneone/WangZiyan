<%@ page contentType="text/html;charset=UTF-8" isErrorPage="true" %>
<%@ page import="org.slf4j.Logger,org.slf4j.LoggerFactory" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%response.setStatus(200);%>
<%
	Throwable ex = null;
	if (exception != null)
		ex = exception;
	if (request.getAttribute("javax.servlet.error.exception") != null)
		ex = (Throwable) request.getAttribute("javax.servlet.error.exception");
	//记录日志
	if (ex!=null){
		Logger logger = LoggerFactory.getLogger("500.jsp");
		logger.error(ex.getMessage(), ex);
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>500 -<tags:msg key="error.500"/></title>
	<%@include file="/WEB-INF/views/include/head_base.jsp" %>
</head>
<body>
	<div class="container-fluid">
		<div class="page-header"><h1><tags:msg key="error.500"/></h1></div>
		<p>错误信息：</p><p>
		</p>
		<div style="display:none;"><a href="javascript:" onclick="history.go(-1);" class="btn">返回上一页</a></div>
		<script>try{$.jBox.closeTip();}catch(e){}</script>
	</div>
</body>
</html>