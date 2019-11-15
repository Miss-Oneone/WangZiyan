<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<meta name="decorator" content="default"/>
	<%@ include file="/WEB-INF/views/finance/bill/billDetailListJs.jsp"%>
</head>
<body>
	<!-- 挡板效果 -->
    <div id="over" class="over"></div>
    <div id="layout" class="layout"><img src="${ctx}/static/sunsail/images/loading_072.gif" /></div>
    <!-- 挡板效果 -->
	<div class="content-button"  id="divSearch" style="${DisplaySearch}">
		<!-- 返回 -->
		<input id="back1"  type="button" class="btn btn-primary" value="<fmt:message key="btn_bill_back"/>"/>
   	    <!-- 头部保存 -->
		<input id="billHeaderUpdate"  type="button" class="btn btn-warning" value="<fmt:message key="btn_bill_save"/>"/>
   	</div>
   	<div class="content-button" id="divOperate" style="${DisplayNoneOperate}">
		<!-- 账单导出二级费用 -->
		<input id="billExport"  type="button" class="btn btn-primary" value="导出"  style="${urlHide}"/>
		<!-- 修改金额 -->
		<input id="billDetailUpdateAmount"  type="button" class="btn btn-warning" value="<fmt:message key="btn_bill_detail_update"/>"  style="${urlHide}"/>
		<!-- 增加账单明细-->
		<input id="billDetailAdd"  type="button" class="btn btn-warning" value="<fmt:message key="btn_bill_detail_add"/>"  style="${urlHide}"/>
		<!-- 账单拆分 -->
		<%--<input id="billDetailSeparate"  type="button" class="btn btn-warning" value="账单拆分"  style="${urlHide}"/>
		<!-- 标记 -->
		<input id="doRemark"  type="button" class="btn btn-warning" value="标记"  style="${urlHide}"/>
		<!-- 标记撤销 -->
		<input id="revoke"  type="button" class="btn btn-warning" value="标记撤销"  style="${urlHide}"/>--%>
		<!-- 从账单中移除 -->
		<input id="billDetailDelete"  type="button" class="btn btn-danger" value="<fmt:message key="btn_bill_detail_delete"/>"  style="${urlHide}"/>
		<b id="condition" isOpen="true" style="font-size:20px;float: right;margin-right: 15px;cursor:pointer">-</b>
		<!-- 查询 -->
		<input id="billDetailSearch"  type="button" class="btn btn-secondary" value="<fmt:message key="btn_bill_search"/>" style="float: right;margin-right: 15px;"/>
   	</div>
	<form id="exportForm" method="post" ></form>
   	<div id="selectCondition">
   		<div class="content-head">
	    	<form id="searchForm"  method="post" action="${ctxZG}/bill">
	    		<tags:hidden id="id" value="${billHeaderModel.id}"  />
	    		<tags:hidden id="relatedCompyCode" value="${billHeaderModel.relatedCompyCode}"  />
	    		<tags:hidden id="paymentType" value="${billHeaderModel.paymentType}" />
	    		<tags:hidden id="feeType" value="${billHeaderModel.feeType}" />
	    		<tags:hidden id="billStatus" value="${billHeaderModel.billStatus}" />
		    	<div class="row cl">
		    	    <!--账单号-->
		    	    <div class="col-1">
						<label><tags:label key="billModel.billNo" /></label>
					</div>
					<div class="col-3">
						<tags:text id="billNo" value="${billHeaderModel.billNo}"  readonly="true"/>
					</div>
					<!-- 应收应付 -->
					<div class="col-1">
						<label><tags:label key="billModel.paymentType" /></label>
					</div>
					<div class="col-3">
						<tags:text id="paymentName" value="${billHeaderModel.paymentName}"  readonly="true"/>
					</div>
					<!--直接间接-->
					<div class="col-1">
						<label><tags:label key="billModel.feeType" /></label>
					</div>
					<div class="col-3">
						<tags:text id="feeName" value="${billHeaderModel.feeName}" readonly="true"/>
					</div>
				</div>
				<div class="row cl">
					<!-- 账单状态-->
					<div class="col-1">
						<label><tags:label key="billModel.billStatus" /></label>
					</div>
					<div class="col-3">
						<tags:text id="billStatusName" value="${billHeaderModel.billStatusName}"  readonly="true"/>
					</div>
					<!-- 往来单位-->
					<div class="col-1">
						<label><tags:label key="billModel.relatedCompy" /></label>
					</div>
					<div class="col-3">
						<tags:text id="compySname" value="${billHeaderModel.compySname}"  readonly="true"/>
					</div>
					<!-- 账单金额-->
					<div class="col-1">
						<label><tags:label key="billModel.billAmount" /></label>
					</div>
					<div class="col-3">
						<tags:text id="billAmount" value="${billHeaderModel.billAmount}"  readonly="true"/>
					</div>
				</div>
				<div class="row cl">
					<!-- 费用条数-->
					<div class="col-1">
						<label><tags:label key="billModel.feeCount" /></label>
					</div>
					<div class="col-3">
						<tags:text id="feeCount" value="${billHeaderModel.feeCount}"  readonly="true"/>
					</div>
					<!-- 票据号-->
					<div class="col-1">
						<label><tags:label key="billModel.invoiceNo" /></label>
					</div>
					<div class="col-3">
						<tags:text id="invoiceNo" value="${billHeaderModel.invoiceNo}"  readonly="true"/>
					</div>
					<!-- 票据生成日期-->
					<div class="col-1">
						<label><tags:label key="billModel.invoiceDate" /></label>
					</div>
					<div class="col-3">
						<tags:text id="invoiceDate" value="${billHeaderModel.invoiceDate}"  readonly="true"/>
					</div>
				</div>
				<div class="row cl" style="display: ${readonly eq 'false' ? '' : 'none'}">
					<!-- 单位联系人-->
					<div class="col-1">
						<label><tags:label key="billModel.relatedPerson" /></label>
					</div>
					<div class="col-3">
						<tags:text id="relatedPerson" value="${billHeaderModel.relatedPerson}"  readonly="${readonly}"/>
					</div>
					<!-- 预计开票日期-->
					<div class="col-1">
						<label><tags:label key="billModel.expectInvoiceDate" /></label>
					</div>
					<div class="col-3">
						<tags:date id="expectInvoiceDate" value="${billHeaderModel.expectInvoiceDate}"  readonly="${readonly}"/>
					</div>
					<!-- 需要开票标志-->
					<div class="col-1">
						<label><tags:label key="开票标志" /></label>
					</div>
					<div class="col-3">
						<tags:singleselect id="invoiceIssueNeedFlag" value="${billHeaderModel.invoiceIssueNeedFlag}" localData="${fns:getOptionList('getDownList','INVOICE_ISSUE_FLAG')}" readonly="${readonly}"/>
					</div>
				</div>
				<div class="row cl" style="${DisplaySearch}">
					<!-- 备注-->
					<div class="col-1">
						<label><tags:label key="billModel.remarks" /></label>
					</div>
					<div class="col-11">
						<tags:textarea id="remarks" value="${billHeaderModel.remarks}" cssStyle="width:920px" readonly="${readonly}"/>
					</div>
				</div>
				<div class="row cl" style="${DisplayNoneOperate}">
					<div class="col-1">
						<label><tags:label key="finance.businessNo1" /></label>
					</div>
					<div class="col-3">
						<tags:text id="businessNo1"  readonly="false" value="${businessNo1}"/>
					</div>
					<div class="col-1">
						<label><tags:label key="finance.businessNo2" /></label>
					</div>
					<div class="col-3">
						<tags:text id="businessNo2" readonly="false" value="${businessNo2}"/>
					</div>
					<div class="col-1">
						<tags:label key="费用名称" />
					</div>
					<div class="col-3">
						<tags:singleselect id="piCode" localData = "${fns:getOptionList('getPiNameList','')}" readonly="false"></tags:singleselect>
					</div>
					<div class="col-1">
						<label><tags:label key="finance.businessDate" /></label>
					</div>
					<div class="col-3">
						<tags:date id="businessDateFrom"  width="95" readonly="false"/>
						-
						<tags:date id="businessDateTo"  width="95" readonly="false"/>
					</div>
					<!-- 标记-->
					<div class="col-1">
						<label><tags:label key="标记" /></label>
					</div>
					<div class="col-3">
						<tags:checkboxs id="tempRemark" multiValue="Y,N" localData="[{'text':'是','value':'Y'},{'text':'否','value':'N'}]" readonly="false"/>
					</div>
				</div>
			</form>
		</div>
	</div>
    <div class="ui-layout-center" id="divGrid" style="${DisplayNoneOperate}">
	    <table id="mainTable" class="ui-pg-table"></table>
	    <div id="mainPager"></div>
	</div>
	<div id="content-bottom"  style="${DisplayNoneOperate}">
		<div class="row cl">
			<div class="col-1">
				<tags:label key="总金额" />
			</div>
			<div class="col-2">
				<tags:text id="billAmountSum" width="200" readonly="true" cssStyle="text-align:right"></tags:text>
			</div>
			<div class="col-1">
				<tags:label key="已选金额" />
			</div>
			<div class="col-2">
				<tags:text id="billAmountSelected" width="200" readonly="true" cssStyle="text-align:right" value="0.00"></tags:text>
			</div>
			<%--<div class="col-5">
			</div>
			<div class="col-1">
				共<span id="totalCount" style="margin-left: 2px;margin-right: 2px"></span>条
			</div>--%>
		</div>
	</div>
</body>
</html>