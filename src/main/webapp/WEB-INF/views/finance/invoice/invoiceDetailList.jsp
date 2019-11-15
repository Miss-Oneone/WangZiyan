<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<meta name="decorator" content="default"/>
<%@ include file="/WEB-INF/views/finance/invoice/invoiceDetailListJs.jsp"%>
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
		<input id="print" type="button" class="btn btn-primary" value="打印" />
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
				<tags:hidden id="invoiceId" value="${invoiceModel.id}" />
				<tags:hidden id="invoiceType" value="${invoiceModel.invoiceType}" />
				<tags:hidden id="feeType" value="${invoiceModel.feeType}" />
				<div class="row cl">
					<!-- 票据号-->
					<div class="col-1">
						<label><tags:label key="票据号" /></label>
					</div>
					<div class="col-3">
						<tags:text id="invoiceNo" value="${invoiceModel.invoiceNo}" readonly="true"/>
					</div>
					<!-- 金额-->
					<div class="col-1">
						<label><tags:label key="金额" /></label>
					</div>
					<!-- 符号-->
					<div class="col-1">
						<tags:singleselect id="sign" localData="${fns:getOptionList('getDownList','SIGN')}" required="true" width="85"/>
					</div>
					<div class="col-2">
						<tags:text id="billAmount" cssStyle="width:110px"/>
					</div>
					<!-- 票据状态-->
					<div class="col-1">
						<label><tags:label key="票据状态" /></label>
					</div>
					<div class="col-3">
						<tags:text id="invoiceNo" value="${invoiceModel.invoiceStatusName}" readonly="true"/>
					</div>
				</div>
				<div class="row cl">
					<!-- 票据日期-->
					<div class="col-1">
						<label><tags:label key="票据日期" /></label>
					</div>
					<div class="col-3">
						<tags:text id="invoiceDate" value="${invoiceModel.invoiceDate}" readonly="true"/>
					</div>
					<div class="col-1">
						<label><tags:label key="往来单位" /></label>
					</div>
					<div class="col-3">
						<tags:text id="compySname" value="${invoiceModel.compySname}" readonly="true"/>
					</div>
					<div class="col-1">
						<label><tags:label key="finance.businessDate" /></label>
					</div>
					<div class="col-3">
						<tags:date id="businessDateFrom" width="100"/>
						-
						<tags:date id="businessDateTo" width="100"/>
					</div>
				</div>
				<div class="row cl">
					<div class="col-1">
						<label><tags:label key="finance.businessNo1" /></label>
					</div>
					<div class="col-3">
						<tags:text id="businessNo1" value="${businessNo1}"/>
					</div>
					<div class="col-1">
						<label><tags:label key="finance.businessNo2" /></label>
					</div>
					<div class="col-3">
						<tags:text id="businessNo2"  value="${businessNo2}"/>
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
				<tags:label key="票据总金额" />
			</div>
			<div class="col-2">
				<tags:text id="detailAmountSum" width="120" readonly="true" cssStyle="text-align:right" value="${invoiceModel.amount}"></tags:text>
			</div>
			<div class="col-1">
				<tags:label key="应收总金额" />
			</div>
			<div class="col-2">
				<tags:text id="detailRevAmountSum" width="120" readonly="true" cssStyle="text-align:right" value="0.00"></tags:text>
			</div>
			<div class="col-1">
				<tags:label key="应付总金额" />
			</div>
			<div class="col-2">
				<tags:text id="detailPayAmountSum" width="120" readonly="true" cssStyle="text-align:right" value="0.00"></tags:text>
			</div>
			<div class="col-1">
				<tags:label key="核销总金额" />
			</div>
			<div class="col-2">
				<tags:text id="fiDoneAmoutnSum" width="120" readonly="true" cssStyle="text-align:right" value="${invoiceModel.fiDoneAmount}"></tags:text>
			</div>
		</div>
	</div>
</body>

</html>