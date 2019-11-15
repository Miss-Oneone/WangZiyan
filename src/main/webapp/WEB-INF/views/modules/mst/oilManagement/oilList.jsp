
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<meta name="decorator" content="default"/>
	<%@ include file="/WEB-INF/views/modules/mst/oilManagement/oilListJs.jsp"%>
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
	<input id="export" class="btn btn-primary" type="button" value="导出" style="${hide}">
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
					<tags:date id="operationTimeFrom" name="operationTimeFrom" width="93" value="${operationTimeFrom}"></tags:date>-
					<tags:date id="operationTimeTo" name="operationTimeTo" width="93" value="${operationTimeTo}"></tags:date>
				</div>
			</div>
			<div class="row cl">
				<div class="col-1">
					<tags:label key="油卡号"/>
				</div>
				<div class="col-3">
					<tags:text id="cardNo" name="cardNo" maxlength="30"></tags:text>
				</div>
				<div class="col-1">
					<tags:label key="加油站"/>
				</div>
				<div class="col-3">
					<tags:text id="station" name="station" maxlength="30"></tags:text>
				</div>
				<div class="col-1"></div>
				<div class="col-3">
					<tags:checkboxs id="innerFlagY" name="innerFlagY" localData="[{'text':'车场加油','value':'Y'}]" multiValue="${(oilSearchModel.own == '' || oilSearchModel.own == 'true') ? 'Y' : ''}"></tags:checkboxs>
					<tags:checkboxs id="innerFlagN" name="innerFlagN" localData="[{'text':'油卡加油','value':'Y'}]" multiValue="${(oilSearchModel.out == '' || oilSearchModel.out == 'true') ? 'Y' : ''}"></tags:checkboxs>
					<tags:hidden id="innerFlag"></tags:hidden>
				</div>
			</div>
			<div class="row cl">
				<div class="col-1">
					<tags:label key="备注"/>
				</div>
				<div class="col-3">
					<tags:text id="remarks" name="remarks" maxlength="200"></tags:text>
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