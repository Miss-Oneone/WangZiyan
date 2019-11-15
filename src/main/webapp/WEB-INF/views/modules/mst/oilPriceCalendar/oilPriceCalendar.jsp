<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<meta name="decorator" content="default"/>
<%@ include file="/WEB-INF/views/modules/mst/oilPriceCalendar/oilPriceCalendarJs.jsp"%>
<style type="text/css">
	.noSave{
		background-color:#F37B1D !important;
	}
	.completed{
		background-color:rgb(193, 193, 193) !important;
	}
</style>
</head>
<body>
	<!-- 挡板效果 -->
	<div id="over" class="over"></div>
	<div id="layout" class="layout"><img src="${ctx}/static/sunsail/images/loading_072.gif" /></div>
	<div class="content-button">
		<input id="add" class="btn btn-primary" type="button" value="新增">
		<input id="edit" class="btn btn-primary" type="button" value="编辑">
		<%--<input id="approval" class="btn btn-warning" type="button" value="审批">--%>
		<input id="del" class="btn btn-danger" type="button" value="删除">
		<b id="condition" isOpen="true" style="font-size:20px;float: right;margin-right: 15px;cursor:pointer">-</b>
		<input id="search" class="btn btn-secondary" type="button" value="查询" style="float: right;margin-right: 15px;">
	</div>
	<div id="selectCondition">
		<div class="content-head">
			<form id="searchForm" onsubmit="return false;" method="get" class="form-horizontal">
				<tags:hidden id="currentFinancialDate" value="${currentFinancialDate}"></tags:hidden>
				<div class="row cl">
					<div class="col-1"><tags:label key="录入时间"></tags:label></div>
					<div class="col-3">
						<tags:date id="createTimeFr"  value="${createTimeFr}" width="100"/>
						-
						<tags:date id="createTimeTo" value="${createTimeTo}" width="100"/>
					</div>
					<div class="col-1"><tags:label key="录入人"></tags:label></div>
					<div class="col-3">
						<tags:singleselect id="createBy" value="${createBy}"
										   localData="${fns:getOptionList('getCreatePsnList','')}">
						</tags:singleselect>
					</div>
				</div>
				<div class="row cl">
					<div class="col-1"><tags:label key="生效日期"></tags:label></div>
					<div class="col-3">
						<tags:date id="effectiveDateFr"  value="${effectiveDateFr}" width="100"/>
						-
						<tags:date id="effectiveDateTo" value="${effectiveDateTo}" width="100"/>
					</div>
					<%--<div class="col-1"><tags:label key="审批状态"></tags:label></div>--%>
					<%--<div class="col-3">--%>
						<%--<tags:singleselect id="approvalStatus"--%>
										   <%--localData="${fns:getOptionList('getFuelPriceApproval','')}">--%>
						<%--</tags:singleselect>--%>
					<%--</div>--%>
				</div>
			</form>
		</div>
	</div>
	<div class="ui-layout-center">
		<table id="mainTable" class="ui-pg-table"></table>
		<div id="mainPager"></div>
	</div>
</body>

</html>