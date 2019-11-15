<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<meta name="decorator" content="default"/>
	<%@ include file="/WEB-INF/views/finance/bill/billListJs.jsp"%>
	<style type="text/css">
	.a-info{
		color: blue !important;
	}
	</style>
</head>
<body>
	<!-- 挡板效果 -->
    <div id="over" class="over"></div>
    <div id="layout" class="layout"><img src="${ctx}/static/sunsail/images/loading_072.gif" /></div>
    <!-- 挡板效果 -->
    
   	<div class="content-button">

		<!-- 账单导出 -->
		<input id="billExport2"  type="button" class="btn btn-primary" value="账单导出"/>
		<!-- 账单详细 -->
		<input id="billDetail"  type="button" class="btn btn-primary" value="账单详细"/>
		<!-- 账单编辑 -->
		<input id="billEdit"  type="button" class="btn btn-warning" value="账单编辑"/>
		<!-- 对账开始-->
		<input id="billStart"  type="button" class="btn btn-warning" value="对账开始"  />
		<!-- 对账完成 -->
		<input id="billComplete"  type="button" class="btn btn-warning" value="对账完成" />
		<!-- 生成票据 -->
		<input id="invoiceCreate"  type="button" class="btn btn-warning" value="生成票据" />
		<!-- 状态回退 -->
		<input id="billCompleteCancel"  type="button" class="btn btn-warning" value="状态回退"  />
		<!-- 账单删除 -->
		<input id="billDelete"  type="button" class="btn btn-danger" value="账单删除"  />
	    <b id="condition" isOpen="true" style="font-size:20px;float: right;margin-right: 15px;cursor:pointer">-</b>
	    <!-- 查询 -->
		<input id="billSearch"  type="button" class="btn btn-secondary" value="查询" style="float: right;margin-right: 15px;" />
   	</div>
	<form id="exportForm" method="post" ></form>
   	<div id="selectCondition">
   		<div class="content-head">
	   		<form id="searchForm"  method="post" action="${ctxZG}/bill">
		    	<div class="row cl">
		    	    <!--账单生成时间-->
					<div class="col-1">
						<label><tags:label key="账单日期" /></label>
					</div>
				    <div class="col-3">
						<tags:date id="billTimeFrom" value="${billTimeFrom}" width="95"/>
					    -
					    <tags:date id="billTimeTo" value="${billTimeTo}" width="95"/>
					</div>
					<!-- 往来单位-->
					<div class="col-1">
						<label><tags:label key="往来单位" /></label>
					</div>
					<div class="col-3">
						<tags:singleselect id="relatedCompyCode" localData = "${fns:getOptionList('getComList','')}" >
						</tags:singleselect>
					</div>
		    	    <!--直接间接-->
		    	    <div class="col-1">
						<label><tags:label key="业务" /></label>
					</div>
				    <div class="col-3">
						 <tags:singleselect id="feeType" localData = "${fns:getOptionList('getDownList','FEE_TYPE')}" >
						</tags:singleselect>
					</div>
				</div>
				<div class="row cl">
					<!-- 账单状态-->
					<div class="col-1">
						<label><tags:label key="账单状态" /></label>
					</div>
					<div class="col-3">
						<div class="col-3">
							<tags:checkboxs id="billStatus"  multiValue="0,1,2" localData="${fns:getOptionList('getDownList','BILL_STATUS')}" />
						</div>
					</div>
					<!-- 应收应付 -->
					<div class="col-1">
						<label><tags:label key="类型" /></label>
					</div>
					<div class="col-3">
						<tags:singleselect id="paymentType"  localData = "${fns:getOptionList('getDownList','PAYMENT_TYPE')}"  >
						</tags:singleselect>
					</div>
					<!--创建人-->
					<div class="col-1">
						<label><tags:label key="创建人" /></label>
					</div>
				    <div class="col-3">
					    <tags:singleselect id="createBy" localData = "${fns:getOptionList('getCreatePsnList','')}"
										   value="${createBy}">
						</tags:singleselect>
					</div>
				</div>
				<div class="row cl">
					<!--账单号-->
					<div class="col-1">
						<label><tags:label key="账单号" /></label>
					</div>
					<div class="col-3">
						<tags:text id="billNo" value="${billNo}"/>
					</div>
					<!-- 票据号-->
					<div class="col-1">
						<label><tags:label key="票据号" /></label>
					</div>
					<div class="col-3">
					    <tags:text id="invoiceNo"  />
					</div>
					<!--备注-->
					<div class="col-1">
						<label><tags:label key="备注" /></label>
					</div>
					<div class="col-3">
				    	<tags:text id="remarks"  />
					</div>
				</div>
				<div class="row cl">
					<!-- 票据号-->
					<div class="col-1">
						<label><tags:label key="finance.businessNo1" /></label>
					</div>
					<div class="col-3">
						<tags:text id="businessNo1"  />
					</div>
					<!-- 票据号-->
					<div class="col-1">
						<label><tags:label key="finance.businessNo2" /></label>
					</div>
					<div class="col-3">
						<tags:text id="businessNo2"  />
					</div>
					<!-- 金额-->
					<div class="col-1">
						<label><tags:label key="金额" /></label>
					</div>
					<!-- 符号-->
					<div class="col-3">
						<tags:singleselect id="sign" localData="${fns:getOptionList('getDownList','SIGN')}" required="true" width="85"/>
						<tags:text id="billAmount" cssStyle="width:110px"/>
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
			    <tags:label key="未对账金额" />
			</div>
			<div class="col-3">
			    <tags:text id="unAmount" width="100" readonly="true" cssStyle="text-align:right"></tags:text>
			</div>
			<div class="col-1">
			   <tags:label key="对账中金额" />
			</div> 
			<div class="col-3">
			    <tags:text id="beginAmount" width="100" readonly="true" cssStyle="text-align:right"></tags:text>
			</div>
			<div class="col-1">
			   <tags:label key="对账完成金额" />
			</div> 
			<div class="col-3">
			    <tags:text id="finishAmount" width="100" readonly="true" cssStyle="text-align:right"></tags:text>
			</div>
	    </div>
		<div class="row cl">
			<div class="col-1">
				<tags:label key="生成票据金额" />
			</div>
			<div class="col-3">
				<tags:text id="invoiceAmount" width="100" readonly="true" cssStyle="text-align:right"></tags:text>
			</div>
			<div class="col-1">
				<tags:label key="核销金额" />
			</div>
			<div class="col-3">
				<tags:text id="fiDoneAmount" width="100" readonly="true" cssStyle="text-align:right"></tags:text>
			</div>
		</div>
	</div>
</body>

</html>