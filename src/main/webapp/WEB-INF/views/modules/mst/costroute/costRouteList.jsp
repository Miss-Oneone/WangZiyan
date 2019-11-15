
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<meta name="decorator" content="default"/>
	<%@ include file="/WEB-INF/views/modules/mst/costroute/costRouteListJs.jsp"%>
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
	<input id="export" class="btn btn-primary" type="button" value="导出" style="${hide}">
	<input id="add" class="btn btn-primary" type="button" value="新增" style="${hide}">
	<input id="edit" class="btn btn-primary" type="button" value="编辑" style="${hide}">
	<%--<input id="export" class="btn btn-primary" type="button" value="导出" style="${hide}">--%>
	<b id="condition" isOpen="true" style="font-size:20px;float: right;margin-right: 15px;cursor:pointer">-</b>
	<input id="search" class="btn btn-secondary" type="button" value="查询" style="float: right;margin-right: 15px;">
</div>
<div id="selectCondition">
	<div class="content-head">
		<form id="searchForm"  method="post" action="">
			<div class="row cl">
				<div class="col-1">
					<tags:label key="起始地区" />
				</div>
				<div class="col-4">
					<tags:regionallinkageselect id="fromAdrs" initNames="initSelectNames()" getInfo="getInfo()" defaultCheck="setDefaultCheck()"
												localData="${fns:getOptionList('getProvinceName','')}"  width="100">
					</tags:regionallinkageselect>
				</div>
				<div class="col-1">
					<tags:label key="有效状态"/>
				</div>
				<div class="col-3">
					<tags:singleselect id="validFlag" value="Y" localData="${fns:getOptionList('getDownList','EFFECTIVE_STATUS')}"
									   width="120"/>
				</div>
			</div>
			<div class="row cl">
				<div class="col-1">
					<tags:label key="到达地区" />
				</div>
				<div class="col-4">
					<tags:regionallinkageselect id="toAdrs" initNames="toInitSelectNames()" getInfo="getInfo()" defaultCheck="setToAdrsDefaultCheck()"
												localData="${fns:getOptionList('getProvinceName','')}"  width="100">
					</tags:regionallinkageselect>
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