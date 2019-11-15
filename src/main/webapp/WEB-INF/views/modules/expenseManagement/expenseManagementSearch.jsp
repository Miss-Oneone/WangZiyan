<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<meta name="decorator" content="default"/>
	<%@ include file="/WEB-INF/views/modules/expenseManagement/expenseManagementSearchJs.jsp" %>
	<style type="text/css">
		#counttable tr td{
			border:1px #000000 solid;
			width:50px;
		}
		.a-info{
			color: blue !important;
		}
		fieldset {
			padding: 0;
			margin-bottom: 8px;
		}
		.ui-jqgrid tr.footrow-ltr td {
			background-color: rgb(255, 255, 255) !important;
		}
		.text-area{
			background-color: #eee;
		}
		.textarea-numberbar {
			display: none;
		}

	</style>
</head>
<body>
<!-- 挡板效果 -->
<div id="over" class="over"></div>
<div id="layout" class="layout"><img src="${ctx}/static/sunsail/images/loading_072.gif" /></div>
<div class="content-button" id="btnRow">
	<input id="preOne" class="btn btn-primary" type="button" value="上一条">
	<input id="nextOne" class="btn btn-primary" type="button" value="下一条">
	<b id="condition" isOpen="true" style="font-size:20px;float: right;margin-right: 15px;cursor:pointer">-</b>
</div>
<div id="selectCondition">
	<div class="content-head">
		<form id="searchForm" method="post"  style="height:auto;background: white;" action="">
			<tags:hidden id="cusCode" value="${order.cusCode}"/>
			<tags:hidden id="driverCode" value="${order.driverCode}"/>
			<tags:hidden id="orderNosKey" value="${orderNosKey}"/>
			<div>
				<div class="row cl">
					<div class="col-1">
						<tags:label key="订单号" />
					</div>
					<div class="col-2">
						<tags:text id="orderNo" name="orderNo" readonly="true" value="${order.orderNo}" width="190"></tags:text>
					</div>
					<div class="col-1">
						<tags:label key="客户" />
					</div>
					<div class="col-2">
						<tags:text id="cusName" name="cusName" readonly="true" value="${order.cusName}" width="190"></tags:text>
					</div>
					<div class="col-1">
						<tags:label key="柜号" />
					</div>
					<div class="col-2">
						<tags:text id="contnNo" name="contnNo" readonly="true" value="${order.contnNo}" width="190"></tags:text>
					</div>
					<div class="col-1">
						<tags:label key="封签号" />
					</div>
					<div class="col-2">
						<tags:text id="sealNo" name="sealNo" readonly="true" value="${order.sealNo}" width="190"></tags:text>
					</div>
				</div>
				<div class="row cl">
					<div class="col-1">
						<tags:label key="柜型" />
					</div>
					<div class="col-2">
						<tags:text id="containerType" name="containerType" readonly="true" value="${order.containerType}" width="190"></tags:text>
					</div>
					<div class="col-1">
						<tags:label key="单据号" />
					</div>
					<div class="col-2">
						<tags:text id="documentNo" name="documentNo" readonly="true" value="${order.documentNo}" width="190"></tags:text>
					</div>
					<div class="col-1">
						<tags:label key="批号" />
					</div>
					<div class="col-2">
						<tags:text id="batchNo" name="batchNo" readonly="true" value="${order.batchNo}" width="190"></tags:text>
					</div>
					<div class="col-1">
						<tags:label key="是否收单" />
					</div>
					<div class="col-2">
						<tags:text id="acceptOrderLabel" name="acceptOrderLabel" readonly="true" value="${order.acceptOrderLabel}" width="190"></tags:text>
					</div>
				</div>
				<div class="row cl">
					<div class="col-1">
						<tags:label key="发车日期" />
					</div>
					<div class="col-2">
						<tags:text id="drvordTime" name="drvordTime" readonly="true" value="${order.drvordTime}" width="190"></tags:text>
					</div>
					<div class="col-1">
						<tags:label key="司机" />
					</div>
					<div class="col-2">
						<tags:text id="driverName" name="driverName" readonly="true" value="${order.driverName}" width="190"></tags:text>
					</div>
					<div class="col-1">
						<tags:label key="车牌号" />
					</div>
					<div class="col-2">
						<tags:text id="plateNum" name="plateNum" readonly="true" value="${order.plateNum}" width="190"></tags:text>
					</div>
					<div class="col-1">
						<tags:label key="车架号" />
					</div>
					<div class="col-2">
						<tags:text id="frameCardId" name="frameCardId" readonly="true" value="${order.frameCardId}" width="90"></tags:text>
						<tags:text id="frameNum" name="frameNum" readonly="true" value="${order.frameNum}" width="96"></tags:text>
					</div>
				</div>
				<div class="row cl">
					<div class="col-1">
						<tags:label key="对内货物" />
					</div>
					<div class="col-2">
						<tags:text id="interGoods" name="interGoods" readonly="true" value="${order.interGoods}" width="190"></tags:text>
					</div>
					<div class="col-1">
						<tags:label key="对外货物" />
					</div>
					<div class="col-2">
						<tags:text id="exterGoods" name="exterGoods" readonly="true" value="${order.exterGoods}" width="190"></tags:text>
					</div>
					<div class="col-1">
						<tags:label key="单价" />
					</div>
					<div class="col-2">
						<tags:text id="unitPrice" name="unitPrice" readonly="true" value="${order.unitPrice}" width="190"></tags:text>
					</div>
					<div class="col-1">
						<tags:label key="吨/立方米" />
					</div>
					<div class="col-2">
						<tags:text id="quantity" name="quantity" readonly="true" value="${order.quantity}" width="190"></tags:text>
					</div>
				</div>
				<div class="row cl">
					<div class="col-1">
						<tags:label key="提单号" />
					</div>
					<div class="col-2">
						<tags:text id="blNo" name="blNo" readonly="true" value="${order.blNo}" width="190"></tags:text>
					</div>
					<div class="col-1">
						<tags:label key="运输方式" />
					</div>
					<div class="col-2">
						<tags:text id="transportType" name="transportType" readonly="true" value="${order.transportType}" width="190"></tags:text>
					</div>
					<div class="col-1">
						<tags:label key="计费模式" />
					</div>
					<div class="col-2">
						<tags:text id="chargingName" name="chargingName" readonly="true" value="${order.chargingName}" width="190"></tags:text>
					</div>
				</div>
				<div class="row cl">
					<div class="col-1">
						<tags:label key="起运地" />
					</div>
					<div class="col-2">
						<tags:textarea id="departurePlace" name="departurePlace" readonly="true" value="${order.departurePlace}" rows="3" cols="25" cssClass="text-area"></tags:textarea>
					</div>
					<div class="col-1">
						<tags:label key="到达地" />
					</div>
					<div class="col-2">
						<tags:textarea id="arrivalPlace" name="arrivalPlace" readonly="true" value="${order.arrivalPlace}" rows="3" cols="25" cssClass="text-area"></tags:textarea>
					</div>
					<div class="col-1">
						<tags:label key="备注" />
					</div>
					<div class="col-2">
						<tags:textarea id="remarks" name="remarks" readonly="true" value="${order.remarks}" rows="3" cols="25" cssClass="text-area"></tags:textarea>
					</div>
				</div>
			</div>
		</form>
	</div>
</div>
<div  class="oms-search-fieldset">
	<div class="ui-layout-center" id="revDiv" style="float: left">
		<table id="receivableTable" class="ui-pg-table"></table>
		<div id="receivablePager"></div>
	</div>
	<div class="ui-layout-center" id="payDiv" style="float: right">
		<table id="payTable" class="ui-pg-table"></table>
		<div id="payPager"></div>
	</div>
</div>
</body>
</html>