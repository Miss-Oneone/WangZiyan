
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<meta name="decorator" content="default"/>
	<%@ include file="/WEB-INF/views/modules/relateCompany/relateCompanyListJs.jsp"%>
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
	<input id="Add" class="btn btn-primary" type="button" value="新增" style="${hide}">
	<input id="edit" class="btn btn-primary" type="button" value="编辑" style="${hide}">
	<input id="export" class="btn btn-primary" type="button" value="导出" style="${hide}">
	<b id="condition" isOpen="true" style="font-size:20px;float: right;margin-right: 15px;cursor:pointer">-</b>
	<input id="search" class="btn btn-secondary" type="button" value="查询" style="float: right;margin-right: 15px;">
</div>
<div id="selectCondition">
	<div class="content-head">
		<form id="searchForm"  method="post" action="/comeAndGoCompany/relateCompany">
			<tags:hidden id="objs"/>
			<div class="row cl">
				<div class="col-1">
					<tags:label key="简称"/>
				</div>
				<div class="col-3">
					<tags:text id="compySname" name="compySname" maxlength="30"></tags:text>
				</div>
					<div class="col-1">
						<tags:label key="全称"/>
					</div>
					<div class="col-3">
						<tags:text id="compyFname" name="compyFname" maxlength="200"></tags:text>
					</div>
					<div class="col-1">
						<tags:label key="类型"/>
					</div>
					<div class="col-3">
						<tags:singleselect id="relatedCompyType" name="relatedCompyType" localData="${fns:getOptionList('getCompanyType','')}" ></tags:singleselect>
					</div>
				</div>
			<div class="row cl">
				<div class="col-1">
					<tags:label key="有效标志"/>
				</div>
				<div class="col-3">
					<tags:singleselect id="activeFlag" name="activeFlag" localData="${fns:getOptionList('getvalidFlag','')}" value="Y"></tags:singleselect>
				</div>
				<div class="col-1">
					<tags:label key="联系人"/>
				</div>
				<div class="col-3">
					<tags:text id="psnName" name="psnName" maxlength="30"></tags:text>
				</div>
				<div class="col-1">
					<tags:label key="联系方式"/>
				</div>
				<div class="col-3">
					<tags:text id="psnPhone" name="psnPhone" maxlength="30"></tags:text>
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