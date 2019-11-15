<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<meta name="decorator" content="default"/>
	<%@include file="/WEB-INF/views/modules/expenseManagement/batchRecPayCheckJs.jsp" %>
	<style type="text/css">
		button{
			color:#FFFFFF;
			margin-left:10px;
			height:20px;
			width:120px;
		}
		.select2-results {
			max-height: 150px;
		}
	</style>
</head>
<body>
<!-- 挡板效果 -->
<div id="over" class="over"></div>
<div id="layout" class="layout"><img src="${ctx}/static/sunsail/images/loading_072.gif" /></div>
<div class="content-button" id="btnRow">
	<input id="cancel" class="btn btn-primary" type="button" value="取消">
	<input id="save" class="btn btn-warning" type="button" value="确定">
	<b id="condition" isOpen="true" style="font-size:20px;float: right;margin-right: 15px;cursor:pointer">-</b>
</div>
<div id="selectCondition">
	<div class="content-head">
		<form id="searchForm" method="post" action="">
			<tags:hidden id="orderNo"></tags:hidden>
			<tags:hidden id="selectOrderNos"></tags:hidden>
			<tags:hidden id="feeStatus" value="${recPay.feeStatus}"></tags:hidden>
			<tags:hidden id="paymentType" value="${recPay.paymentType}"></tags:hidden>
			<tags:hidden id="piCode" value="${recPay.piCode}"></tags:hidden>
			<tags:hidden id="compyCode" value="${recPay.compyCode}"></tags:hidden>
			<tags:hidden id="expDate" value="${recPay.expDate}"></tags:hidden>
			<tags:hidden id="remarks" value="${recPay.remarks}"></tags:hidden>
			<div class="row cl">
				<div class="col-2">
					<tags:label key="新增费用"></tags:label>
				</div>
				<div class="col-4">
					<tags:text id="selectedOrderNum" value="${recPay.selectedOrderNum}" readonly="true"></tags:text>
				</div>
				<div class="col-2">
					<tags:label key="金额（元）"></tags:label>
				</div>
				<div class="col-4">
					<tags:text id="amount" value="${recPay.amount}" readonly="true"></tags:text>
				</div>
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