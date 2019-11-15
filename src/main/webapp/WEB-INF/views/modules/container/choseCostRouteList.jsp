
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<meta name="decorator" content="default"/>
	<%@ include file="/WEB-INF/views/modules/container/choseCostRouteListJs.jsp"%>
	<style type="text/css">
		.a-info {
			color: blue!important;
		}

	</style>
</head>
<body>
<!-- 挡板效果 -->
<div id="over" class="over"></div>
<div id="layout" class="layout"><img src="${ctx}/static/sunsail/images/loading_072.gif" /></div>
<!-- 挡板效果 -->
<div id="selectCondition">
	<div class="content-head">
		<form id="searchForm"  method="post" action="">
			<tags:hidden id="ids" value="${ids}"></tags:hidden>
			<tags:hidden id="plateNum" value="${plateNum}"></tags:hidden>
			<tags:hidden id="fromAdrs" value="${fromAdrs}"></tags:hidden>
			<tags:hidden id="toAdrs" value="${toAdrs}"></tags:hidden>
		</form>
	</div>
</div>
<div class="ui-layout-center">
	<table id="mainTable" class="ui-pg-table"></table>
	<div id="mainPager"></div>
</div>
</body>

</html>