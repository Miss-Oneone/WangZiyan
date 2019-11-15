
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<meta name="decorator" content="default"/>
	<%@ include file="/WEB-INF/views/modules/mst/oilManagement/oilBalanceListJs.jsp"%>
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
	<%--<input id="export" class="btn btn-primary" type="button" value="导出" style="${hide}">--%>
	<b id="condition" isOpen="true" style="font-size:20px;float: right;margin-right: 15px;cursor:pointer">-</b>
	<input id="search" class="btn btn-secondary" type="button" value="查询" style="float: right;margin-right: 15px;">
</div>
<div id="selectCondition">
	<div class="content-head">
		<form id="searchForm"  method="post" action="">
			<div class="row cl">
				<div class="col-1">
					<tags:label key="车牌号"/>
				</div>
				<div class="col-3">
					<tags:singleselect id="plateNum" name="plateNum" localData="${fns:getOptionList('getTruckPlateNo','')}"
									   value="${containerModel.plateNum}"></tags:singleselect>
				</div>
				<div class="col-1">
					<tags:label key="司机"/>
				</div>
				<div class="col-3">
					<tags:singleselect id="driverCode" name="driverCode"
									   localData="${fns:getOptionList('getDriverList','')}"
									   value="${containerModel.driverCode}"></tags:singleselect>
				</div>
				<div class="col-1">
					<tags:label key="加油时间"/>
				</div>
				<div class="col-3">
					<tags:date id="dateFrom" name="dateFrom" width="93" value="${dateFrom}"></tags:date>-
					<tags:date id="dateTo" name="dateTo" width="93" value="${dateTo}"></tags:date>
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