
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<meta name="decorator" content="default"/>
	<%@ include file="/WEB-INF/views/modules/mst/contn/contnListJs.jsp"%>
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
	<b id="condition" isOpen="true" style="font-size:20px;float: right;margin-right: 15px;cursor:pointer">-</b>
	<input id="search" class="btn btn-secondary" type="button" value="查询" style="float: right;margin-right: 15px;">
</div>
<div id="selectCondition">
	<div class="content-head">
		<form id="searchForm"  method="post" action="">
			<div class="row cl">
				<div class="col-1">
					<tags:label key="箱号"/>
				</div>
				<div class="col-2">
					<tags:text id="contnNo" name="contnNo" maxlength="30"></tags:text>
				</div>
				<div class="col-1">
					<tags:label key="箱类型"/>
				</div>
				<div class="col-2">
					<tags:singleselect id="contnType" name="contnType" localData="${fns:getOptionList('getDownList','CONTN_TYPE')}"
									   value="${contnModel.contnType}"></tags:singleselect>
				</div>
				<div class="col-1">
					<tags:label key="箱主"/>
				</div>
				<div class="col-2">
					<tags:singleselect id="contnOwnerId" name="contnOwnerId" localData="${fns:getOptionList('getContnOwner','')}"
									   value="${contnModel.contnOwnerId}"></tags:singleselect>
				</div>
				<div class="col-1">
					<tags:label key="有效标志"/>
				</div>
				<div class="col-2">
					<tags:singleselect id="activeFlag" name="activeFlag" localData="${fns:getOptionList('getDownList','ACTIVE_FLAG')}"
									   value="Y"></tags:singleselect>
				</div>
			</div>
			<div class="row cl" style="margin-top: 5px">
				<div class="col-1">
					<tags:label key="特殊箱类型"/>
				</div>
				<div class="col-2">
					<tags:singleselect id="specialContnType" name="specialContnType" localData="${fns:getOptionList('getSpecialContnType','')}" value="${contnModel.specialContnType}" ></tags:singleselect>
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