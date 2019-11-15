<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<meta name="decorator" content="default"/>
	<%@ include file="/WEB-INF/views/finance/cashJournal/cashJournalFiDoneDetailJs.jsp"%>
	<style type="text/css">
	</style>
</head>
<body>
<!-- 挡板效果 -->
<div id="over" class="over"></div>
<div id="layout" class="layout"><img src="${ctx}/static/sunsail/images/loading_072.gif" /></div>
<div class="content-button">
	<b id="condition" isOpen="true" style="font-size: 20px; float: right; margin-right: 15px; cursor: pointer">-</b>
	<!-- 打印 -->
	<input id="export" type="button" class="btn btn-primary" value="导出" />
	<!-- 查询 -->
	<input id="search" type="button" class="btn btn-secondary"
		   value="<fmt:message key="btn_query"/>"
		   style="float: right; margin-right: 15px;" />
</div>
<div id="selectCondition">
	<div class="content-head">
		<form id="searchForm" onsubmit="return false;" method="get" class="form-horizontal">
			<div class="row cl">
				<!-- 单据号-->
				<div class="col-1">
					<label><tags:label key="单据号" /></label>
				</div>
				<div class="col-3">
					<tags:text id="cashJournalNo" value="${cashJournalNo}" readonly="true"/>
				</div>
				<!-- 账单号-->
				<div class="col-1">
					<label><tags:label key="账单号" /></label>
				</div>
				<div class="col-3">
					<tags:text id="billNo" />
				</div>
				<!-- 票据号-->
				<div class="col-1">
					<label><tags:label key="票据号" /></label>
				</div>
				<div class="col-3">
					<tags:text id="invoiceNo" />
				</div>
			</div>
			<div class="row cl">
				<div class="col-1">
					<label><tags:label key="finance.businessNo1" /></label>
				</div>
				<div class="col-3">
					<tags:text id="businessNo1" />
				</div>
				<div class="col-1">
					<label><tags:label key="finance.businessNo2" /></label>
				</div>
				<div class="col-3">
					<tags:text id="businessNo2" />
				</div>
				<div class="col-1">
					<label><tags:label key="finance.businessDate"/></label>
				</div>
				<div class="col-3">
					<tags:date id="businessDateFrom" value="${businessDateFrom}" width="95" />
					-
					<tags:date id="businessDateTo" value="${businessDateTo}" width="95" />
				</div>
			</div>
		</form>
	</div>
</div>
<div class="ui-layout-center">
	<table id="mainTable" class="ui-pg-table"></table>
	<div id="mainPager"></div>
</div>
<div id="content-bottom"  style="padding-top: 5px;">
	<div class="row cl">
		<div class="col-1">
			<tags:label key="(应收)金额" />
		</div>
		<div class="col-2">
			<tags:text id="rAmount" width="120" readonly="true" cssStyle="text-align:right" value="0.00"></tags:text>
		</div>
		<div class="col-1">
			<tags:label key="核销金额" />
		</div>
		<div class="col-2">
			<tags:text id="rFiDoneAmount" width="120" readonly="true" cssStyle="text-align:right" value="0.00"></tags:text>
		</div>
		<div class="col-1">
			<tags:label key="(应付)金额" />
		</div>
		<div class="col-2">
			<tags:text id="pAmount" width="120" readonly="true" cssStyle="text-align:right" value="0.00"></tags:text>
		</div>
		<div class="col-1">
			<tags:label key="核销金额" />
		</div>
		<div class="col-2">
			<tags:text id="pFiDoneAmount" width="120" readonly="true" cssStyle="text-align:right" value="0.00"></tags:text>
		</div>
	</div>
</div>
</body>

</html>