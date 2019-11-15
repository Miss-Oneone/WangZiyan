<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<meta name="decorator" content="default"/>
<%@ include file="/WEB-INF/views/finance/binsapproval/binsApprovalOrdJs.jsp"%>
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
		<input id="approval" class="btn btn-warning" type="button" value="审核通过">
		<b id="condition" isOpen="true" style="font-size:20px;float: right;margin-right: 15px;cursor:pointer">-</b>
		<input id="search" class="btn btn-secondary" type="button" value="查询" style="float: right;margin-right: 15px;">
	</div>
	<div id="selectCondition">
		<div class="content-head">
			<form id="searchForm" onsubmit="return false;" method="get" class="form-horizontal">
				<div class="row cl">
					<div class="col-1"><tags:label key="发车日期"></tags:label></div>
					<div class="col-3">
						<tags:date id="businessDateFrom"  value="${model.businessDateFrom}" width="100"/>
						-
						<tags:date id="businessDateTo" value="${model.businessDateTo}" width="100"/>
					</div>
					<!-- 往来单位-->
					<div class="col-1">
						<label><tags:label key="往来单位" /></label>
					</div>
					<div class="col-3">
						<tags:singleselect id="relatedCompyCode" localData = "${fns:getOptionList('getComList','')}" >
						</tags:singleselect>
					</div>
					
					<div class="col-1"><tags:label key="审核状态"></tags:label></div>
					<div class="col-3">
						<tags:singleselect id="binsApprovalFlag" value="${model.binsApprovalFlag}" localData="${fns:getOptionList('getDownList','BINS_APPROVAL_STATUS')}">
						</tags:singleselect>
					</div>
				</div>	
				<div class="row cl">
					<div class="col-1">
						<tags:label key="订单号" />
					</div>
					<div class="col-3">
						<tags:text id="orderNo" value="${model.orderNo}"/>
					</div>
				     <div class="col-1">
					     <tags:label key="提单号" />
					 </div>
					 <div class="col-3">	
					     <tags:text id="businessNo1" value="${model.businessNo1}"/>
					 </div>
					 <div class="col-1">
					     <tags:label key="柜号" />
					 </div>
					 <div class="col-3">		
					     <tags:text id="businessNo2" value="${model.businessNo2}"/>
					 </div>
				</div>		
				<div class="row cl">

					<div class="col-1"><tags:label key="客户"></tags:label></div>
					<div class="col-3">
						<tags:singleselect id="cusCode" localData="${fns:getOptionList('getComList','')}" value="${model.cusCode}"></tags:singleselect>
					</div>
					<div class="col-1">
						<tags:label key="柜型" />
					</div>
					<div class="col-3">
						<tags:singleselect id="containerType" localData="${fns:getOptionList('getContainerType','')}"/>
					</div>
				</div>	
				<div class="row cl">
					<div class="col-1"><tags:label key="创建人"></tags:label></div>
					<div class="col-3">
						<tags:singleselect id="createBy" localData="${fns:getOptionList('getCreatePsnList','')}" value="${model.createBy}">
						</tags:singleselect>
					</div>
					<!-- 预期毛利-->
					<div class="col-1">
						<label><tags:label key="预期毛利" /></label>
					</div>
					<div class="col-3">
					    <tags:text id="profitFrom" width="100" cssStyle="text-align:right"/>
					    -
					    <tags:text id="profitTo" width="100" cssStyle="text-align:right"/>
					</div>
				</div>
			</form>
		</div>
	</div>
	<div class="ui-layout-center">
		<table id="mainTable" class="ui-pg-table"></table>
		<div id="mainPager"></div>
	</div>
	<script>
        $(document).ready(function(){
            doSearch();
        })
	</script>
</body>

</html>