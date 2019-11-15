
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<meta name="decorator" content="default"/>
	<%@ include file="/WEB-INF/views/modules/mst/truckFrame/truckFrameListJs.jsp"%>
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
<div class="content-button">
	<input id="add" class="btn btn-primary" type="button" value="新增" style="${hide}">
	<input id="edit" class="btn btn-primary" type="button" value="编辑" style="${hide}">
	<%--<input id="export" class="btn btn-primary" type="button" value="导出" style="${hide}">--%>
	<b id="condition" isOpen="true" style="font-size:20px;float: right;margin-right: 15px;cursor:pointer">-</b>
	<input id="search" class="btn btn-secondary" type="button" value="查询" style="float: right;margin-right: 15px;">
</div>
<div id="selectCondition">
	<div class="content-head">
		<form id="searchForm"  method="post" action="">
			<tags:hidden id="objs"/>
			<div class="row cl">
				<div class="col-1">
					<tags:label key="内部号牌"/>
				</div>
				<div class="col-3">
					<tags:text id="frameCardId" name="frameCardId" maxlength="30"></tags:text>
				</div>
				<div class="col-1">
					<tags:label key="车架车牌号"/>
				</div>
				<div class="col-3">
					<tags:text id="frameNum" name="frameNum" maxlength="200"></tags:text>
				</div>
			</div>
		</form>
	</div>
</div>
</div>
<div class="ui-layout-center">
	<table id="mainTable" class="ui-pg-table"></table>
	<div id="mainPager"></div>
</div>
</body>

</html>