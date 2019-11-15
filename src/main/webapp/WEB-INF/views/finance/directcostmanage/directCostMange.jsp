<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<meta name="decorator" content="default"/>
<%@ include file="/WEB-INF/views/finance/directcostmanage/directCostManageJs.jsp"%>
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
		<input id="export" class="btn btn-primary" type="button" value="导出">
		<input id="save" class="btn btn-warning" type="button" value="提交">
		<input id="generateBill" class="btn btn-warning" type="button" value="快速结算">
		<b id="condition" isOpen="true" style="font-size:20px;float: right;margin-right: 15px;cursor:pointer">-</b>
		<input id="search" class="btn btn-secondary" type="button" value="查询" style="float: right;margin-right: 15px;">
	</div>
	<div id="selectCondition">
		<div class="content-head">
			<form id="searchForm" onsubmit="return false;" method="post" class="form-horizontal">
				<div class="row cl">
                    <!--拖箱时间-->
					<div class="col-1"><tags:label key="发车日期"></tags:label></div>
					<div class="col-3">
						<tags:date id="businessDateFrom"  value="${businessDateFrom}" width="95"/>
						-
						<tags:date id="businessDateTo" value="${businessDateTo}" width="95"/>
					</div>
                    <!--往来单位-->
                    <div class="col-1"><tags:label key="往来单位"></tags:label></div>
                    <div class="col-3">
                        <tags:singleselect id="relatedCompyCode" value="${relatedCompyCode}"
                                           localData="${fns:getOptionList('getComList','')}">
                        </tags:singleselect>
                    </div>
					<!--托运人-->
					<div class="col-1"><tags:label key="客户"></tags:label></div>
					<div class="col-3">
						<tags:singleselect id="cusCode"
										   localData="${fns:getOptionList('getCusNameList','')}">
						</tags:singleselect>
					</div>
				</div>

				<div class="row cl">
                    <!--订单号-->
					<div class="col-1"><tags:label key="订单编号"></tags:label></div>
					<div class="col-3">
						<tags:text id="orderNo"></tags:text>	
					</div>
                    <!--提单号-->
					<div class="col-1"><tags:label key="提单号"></tags:label></div>
					<div class="col-3">
						<tags:text id="businessNo1"></tags:text>
					</div>
					<!--柜号-->
					<div class="col-1"><tags:label key="柜号"></tags:label></div>
					<div class="col-3">
						<tags:text id="businessNo2"></tags:text>
					</div>
				</div>

				<div class="row cl">
                    <!--费用名称-->
					<div class="col-1"><tags:label key="费用名称"></tags:label></div>
					<div class="col-3">
						<tags:singleselect id="piCode" name="piCode"
										   localData="${fns:getOptionList('getPiNameList','')}">
						</tags:singleselect>
					</div>
					<!--创建时间-->
					<div class="col-1"><tags:label key="创建时间"></tags:label></div>
					<div class="col-3">
						<tags:date id="createTimeFrom"  value="${createTimeFrom}" width="95"/>
						-
						<tags:date id="createTimeTo" value="${createTimeTo}" width="95"/>
					</div>
					<!--创建人-->
					<div class="col-1"><tags:label key="创建人"></tags:label></div>
					<div class="col-3">
						<tags:singleselect id="createPsn" value="${createBy}"
										   localData="${fns:getOptionList('getCreatePsnList','')}">
						</tags:singleselect>
					</div>
				</div>

				<div class="row cl">
					<!--费用名称-->
					<div class="col-1"><tags:label key="货物"></tags:label></div>
					<div class="col-3">
						<tags:singleselect id="interGoods" name="interGoods"
										   localData="${fns:getOptionList('getGoodsType','1')}">
						</tags:singleselect>
					</div>
					<!--车牌号-->
					<div class="col-1"><tags:label key="车牌号"></tags:label></div>
					<div class="col-3">
						<tags:singleselect id="plateNum" name="plateNum"
										   localData="${fns:getOptionList('getAllPlateNum','')}">
						</tags:singleselect>
					</div>
					<!--司机-->
					<div class="col-1"><tags:label key="司机"></tags:label></div>
					<div class="col-3">
						<tags:singleselect id="driverCode" name="driverCode"
										   localData="${fns:getOptionList('getAllDriverName','')}">
						</tags:singleselect>
					</div>
				</div>

				<div class="row cl">
					<!--柜型-->
					<div class="col-1"><tags:label key="柜型"></tags:label></div>
					<div class="col-3">
						<tags:singleselect id="containerType" name="containerType"
										   localData="${fns:getOptionList('getDownList','CONTAINER_TYPE')}">
						</tags:singleselect>
					</div>
					<!--收付类型-->
					<div class="col-1"><tags:label key="收付类型"></tags:label></div>
					<div class="col-3">
						<tags:checkboxs id="paymentType" multiValue="${paymentType}"
										localData="${fns:getOptionList('getDownList','PAYMENT_TYPE')}">
						</tags:checkboxs>
					</div>
					<!--费用状态-->
					<div class="col-1"><tags:label key="费用状态"></tags:label></div>
					<div class="col-3">
						<tags:checkboxs id="feeStatus" multiValue="${feeStatus}"
										localData="${fns:getOptionList('getDownList','FEE_STATUS')}">
						</tags:checkboxs>
					</div>
				</div>
				<%--<div class="row cl">
					<!--收付类型-->
					<div class="col-1"><tags:label key="收付类型"></tags:label></div>
					<div class="col-3">
						<tags:checkboxs id="paymentType" multiValue="${paymentType}"
										localData="${fns:getOptionList('getDownList','PAYMENT_TYPE')}">
						</tags:checkboxs>
					</div>
					<!--审核状态-->
					<div class="col-1"><tags:label key="审核状态"></tags:label></div>
					<div class="col-3">
						<tags:checkboxs id="binsApprovalFlag" multiValue="${binsApprovalFlag}"
										cssStyle="word-wrap: break-word;word-break: break-all;white-space: pre-wrap !important;"
										localData="${fns:getOptionList('getDownList','BINS_APPROVAL_STATUS')}">
						</tags:checkboxs>
					</div>
					<!--审批人-->
					<div class="col-1"><tags:label key="审批人"></tags:label></div>
					<div class="col-3">
						<tags:singleselect id="binsApprovalPsn"
										   localData="${fns:getOptionList('getCreatePsnList','')}">
						</tags:singleselect>
					</div>
				</div>
				<div class="row cl">
					<!--费用状态-->
					<div class="col-1"><tags:label key="费用状态"></tags:label></div>
					<div class="col-3">
						<tags:checkboxs id="feeStatus" multiValue="${feeStatus}"
										localData="${fns:getOptionList('getDownList','FEE_STATUS')}">
						</tags:checkboxs>
					</div>
					<div class="col-1">
						<tags:label key="核销状态" />
					</div>
					<div class="col-3">
						<tags:checkboxs id="fiDoneSts"  multiValue="1" localData="${fns:getOptionList('getDownList','FEE_FI_DONE_STATUS')}"/>
					</div>
					<!-- 金额-->
					<div class="col-1">
						<label><tags:label key="金额" /></label>
					</div>
					<!-- 符号-->
					<div class="col-3">
						<tags:singleselect id="sign" localData="${fns:getOptionList('getDownList','SIGN')}" required="true" width="85"/>
						<tags:text id="amount" cssStyle="width:110px"/>
					</div>
				</div>--%>
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
				<tags:label key="应收金额" />
			</div>
			<div class="col-1">
				<tags:text id="rAmount" width="100" readonly="true"  value="0.00" cssStyle="text-align:right"></tags:text>
			</div>
			<div class="col-1">
				<tags:label key="应付金额" />
			</div>
			<div class="col-1">
				<tags:text id="pAmount" width="80" readonly="true" value="0.00" cssStyle="text-align:right"></tags:text>
			</div>
			<%--<div class="col-1">
				<tags:label key="应收已对账金额" />
			</div>
			<div class="col-1">
				<tags:text id="rBillAmount" width="80" readonly="true"  value="0.00" cssStyle="text-align:right"></tags:text>
			</div>
			<div class="col-1">
				<tags:label key="应付已对账金额" />
			</div>
			<div class="col-1">
				<tags:text id="pBillAmount" width="80" readonly="true" value="0.00" cssStyle="text-align:right"></tags:text>
			</div>
			<div class="col-1">
				<tags:label key="应收未对账金额" />
			</div>
			<div class="col-1">
				<tags:text id="rUnBillAmount" width="80" readonly="true"  value="0.00" cssStyle="text-align:right"></tags:text>
			</div>
			<div class="col-1">
				<tags:label key="应付未对账金额" />
			</div>
			<div class="col-1">
				<tags:text id="pUnBillAmount" width="80" readonly="true" value="0.00" cssStyle="text-align:right"></tags:text>
			</div>--%>
		</div>
	</div>
</body>

</html>