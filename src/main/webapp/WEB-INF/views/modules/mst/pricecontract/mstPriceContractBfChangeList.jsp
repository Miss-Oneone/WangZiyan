
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<meta name="decorator" content="default"/>
	<%@ include file="/WEB-INF/views/modules/mst/pricecontract/mstPriceContractBfChangeListJs.jsp"%>
	<style type="text/css">
		.a-info {
			color: blue!important;
		}
		#gbox_mainTable table th:nth-of-type(2),
		 #gbox_mainTable table td:nth-of-type(2){
			 /*display: none;*/
		 }
		#gbox_mainTable2 table th:nth-of-type(2),
		#gbox_mainTable2 table td:nth-of-type(2){
			/*display: none;*/
		}
	</style>
</head>
<body>
<!-- 挡板效果 -->
<div id="over" class="over"></div>
<div id="layout" class="layout"><img src="${ctx}/static/sunsail/images/loading_072.gif" /></div>
<!-- 挡板效果 -->
<div class="content-button">
	<input id="export" class="btn btn-primary" type="button" value="导出" style="${hide}">
	<b id="condition" isOpen="true" style="font-size:20px;float: right;margin-right: 15px;cursor:pointer">-</b>
	<input id="search" class="btn btn-secondary" type="button" value="查询" style="float: right;margin-right: 15px;">
</div>
<div id="selectCondition">
	<div class="content-head">
		<form id="searchForm"  method="post" action="">
			<div class="row cl">
				<div class="col-1">
					<tags:label key="创建时间"/>
				</div>
				<div class="col-3">
					<tags:date id="beginTime" width="100"></tags:date>-
					<tags:date id="endTime" width="100"></tags:date>
				</div>
				<div class="col-1">
					<tags:label key="协议名称"/>
				</div>
				<div class="col-3">
					<tags:singleselect id="priceContractNo"
									   localData="${fns:getOptionList('getPriceContractNo','Y')}" />
				</div>

				<div class="col-1">
					<tags:label key="业务类型"/>
				</div>
				<div class="col-3">
					<tags:singleselect id="binsType"  localData="${fns:getOptionList('getDownList','BINS_TYPE')}"
									   width="100"/>
					<tags:singleselect id="ioType"  localData="${fns:getOptionList('getDownList','IO_TYPE')}"
									   width="100"/>
				</div>
			</div>
			<div class="row cl">
				<div class="col-1">
					<tags:label key="地区" />
				</div>
				<div class="col-3">
					<tags:regionallinkageselect id="provinceCodeCopy" initNames="initSelectNames()" getInfo="getInfo()"
												localData="${fns:getOptionList('getProvinceName','')}"  width="100">
					</tags:regionallinkageselect>
				</div>
				<div class="col-1">
					<tags:label key="变动类型" />
				</div>
				<div class="col-3">
					<tags:checkboxs id="changeType" multiValue="2" localData="[{'text':'新增门点','value':'0'},{'text':'改变价格','value':'2'}]"></tags:checkboxs>
				</div>
				<div class="col-1">
					<tags:label key="计费方式"/>
				</div>
				<div class="col-3">
					<tags:singleselect id="chargingType" localData="${fns:getOptionList('getDownList','CHARGING_TYPE')}"
									   required="true" width="100" />
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