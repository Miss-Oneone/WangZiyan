
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<meta name="decorator" content="default"/>
	<%@ include file="/WEB-INF/views/modules/equipment/equipmentListJs.jsp"%>
	<style type="text/css">
		.table-col-5 {
			width: 41%;
			float: left;
		}
		.table-col-3 {
			width: 26%;
			float: left;
		}
		.table-col-4 {
			width: 33%;
			float: left;
		}
		#contnNoOptions{
			width: 198px;
			max-height: 250px;
			border: 1px solid #CCC6C6;
			background: white;
			position: absolute;
			top: 24px;
			z-index: 99999;
			box-shadow: 0 4px 5px rgba(0, 0, 0, .15);
			overflow-y: auto;
			display: none;
		}
		#contnNoOptions p {
			padding-left: 10px;
			margin-bottom: 0px;
			padding-bottom: 3px;
			padding-top: 3px;
		}
		#contnNoOptions p:hover {
			background: #0B61A4;
			color: white;
		}
	</style>
</head>
<body>
<!-- 挡板效果 -->
<div id="over" class="over"></div>
<div id="layout" class="layout"><img src="${ctx}/static/sunsail/images/loading_072.gif" /></div>
<!-- 挡板效果 -->
<div class="content-button">
	<!-- 导出 -->
	<input id="export" type="button" class="btn btn-primary" value="导出"/>
	<b id="condition" isOpen="true" style="font-size:20px;float: right;margin-right: 15px;cursor:pointer">-</b>
	<input id="search" class="btn btn-secondary" type="button" value="查询" style="float: right;margin-right: 15px;">
</div>
<div id="selectCondition">
	<div class="content-head">
		<form id="searchForm"  method="post" action="">
			<div class="row cl">
				<div class="col-1">
					<tags:label key="日期"/>
				</div>
				<div class="col-2">
					<tags:date id="dateFrom" name="dateFrom" width="93" value="${dateFrom}"></tags:date>-
					<tags:date id="dateTo" name="dateTo" width="93" value="${dateTo}"></tags:date>
				</div>
				<div class="col-1">
					<tags:label key="车牌号"/>
				</div>
				<div class="col-2">
					<%--<tags:text id="plateNum" name="plateNum" maxlength="30"></tags:text>--%>
					<tags:singleselect id="plateNum" name="plateNum" localData="${fns:getOptionList('getTruckPlateNo','')}"></tags:singleselect>
				</div>
				<div class="col-1">
					<tags:label key="车架号"/>
				</div>
				<div class="col-2">
					<%--<tags:text id="frameNum" name="frameNum" maxlength="30"></tags:text>--%>
					<tags:singleselect id="frameNo" name="frameNo" localData="${fns:getOptionList('getFrames','')}" onchange="searchframeNum(this.value)" width="115"></tags:singleselect>
					<tags:text id="frameNum" name="frameNum" readonly="true"  width="80"/>
				</div>
				<div class="col-1">
					<tags:label key="箱号"/>
				</div>
				<div class="col-2">
					<%--<tags:text id="contnNo" name="contnNo" maxlength="30"></tags:text>--%>
					<tags:text id="contnNo" name="contnNo" onKeyup="input(event)" onblur="closeContnNoOptions(event)" autocomplete="off"/>
					<div id="contnNoOptions">
					</div>
				</div>
			</div>
		</form>
	</div>
</div>
</div>
<div>
	<div class="ui-layout-center table-col-3">
		<table id="trailerMainTable" class="ui-pg-table"></table>
		<div id="trailerMainPager"></div>
	</div>
	<div class="ui-layout-center table-col-5">
		<table id="truckFrameMainTable" class="ui-pg-table"></table>
		<div id="truckFrameMainPager"></div>
	</div>
	<div class="ui-layout-center table-col-4">
		<table id="contnMainTable" class="ui-pg-table"></table>
		<div id="contnMainPager"></div>
	</div>
</div>
</body>

</html>