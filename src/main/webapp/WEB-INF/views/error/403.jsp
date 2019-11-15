<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>403 - <tags:msg key="error.403"/></title>
	<%@include file="/WEB-INF/views/include/head_base.jsp" %>
</head>
<body>
	<div class="container-fluid">
		<div class="page-header"><h1><tags:msg key="error.403"/></h1></div>
		<div style="display:none;"><a href="javascript:" onclick="history.go(-1);" class="btn">返回上一页</a></div>
		<script>try{$.jBox.closeTip();}catch(e){}</script>
	</div>
</body>
</html>