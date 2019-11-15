
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<meta name="decorator" content="default"/>
	<%@ include file="/WEB-INF/views/modules/mst/pricecontract/priceContractBfDetailJs.jsp"%>
	<style type="text/css">
	</style>
</head>
<body>
<!-- 挡板效果 -->
<div class="content-button" id="divOperate" style="${DisplayNoneOperate}">
	<input id="return" class="btn btn-primary size-M" type="button" value="返回" />
	<input id="save" class="btn btn-warning size-M" type="button" value="保存" />
</div>
<div style="padding-left: 20px;padding-top: 2px">
	<form id="detailForm" class="form-horizontal">
		<tags:hidden id="pageType" value="${pageType}"/>
		<tags:hidden id="id" value="${priceContractBfModel.id}"/>
		<div style="margin-left: 45px">
			<div class="row cl">
				<div class="col-2">
					<tags:label key="价格协议号" required="true"/>
				</div>
				<div class="col-3">
					<tags:singleselect id="priceContractNo" name="priceContractNo" localData="${fns:getOptionList('getBFPriceContractNo','')}"
									   value="${priceContractBfModel.priceContractNo}" disabled="${not empty priceContractBfModel.priceContractNo}"/>
				</div>
				<div class="col-2">
					<tags:label key="计费方式" required="true"/>
				</div>
				<div class="col-3">
					<tags:singleselect id="chargingType" localData="${fns:getOptionList('getDownList','CHARGING_TYPE')}"
									   value="${pageType != 'create' ? priceContractBfModel.chargingType : '1'}" disabled="${not empty priceContractBfModel.priceContractNo}"/>
				</div>
			</div>
			<div class="row cl">
				<br>
				<div class="col-2">
					<tags:label key="起始地区" required="true"/>
				</div>
				<div class="col-6">
					<tags:regionallinkageselect  id="fromAdrs" localData="${fns:getOptionList('getProvinceName','')}"
												 initNames="initSelectNames()" defaultCheck="setDefaultCheck()"
												 getInfo="getInfo()" width="100" readonly = "${pageType =='edit'}">
					</tags:regionallinkageselect>
				</div>
			</div>
			<div class="row cl">
				<br>
				<div class="col-2">
					<tags:label key="到达地区" required="true"/>
				</div>
				<div class="col-6">
					<tags:regionallinkageselect  id="toAdrs" localData="${fns:getOptionList('getProvinceName','')}"
												 initNames="toInitSelectNames()" defaultCheck="setToAdrsDefaultCheck()"
												 getInfo="getInfo()" width="100" readonly = "${pageType =='edit'}">
					</tags:regionallinkageselect>
				</div>
			</div>
			<div class="row cl" id="div_container">
				<br>
				<div class="col-2">
					<tags:label key="集装箱价格等级" required="true" />
				</div>
				<div class="col-3">
					<tags:singleselect id="containerType" name="containerType" localData="${fns:getOptionList('getDownList','CONTN_LEVEL')}"
									   value="${priceContractBfModel.containerType}" readonly = "${pageType =='edit'}"/>
				</div>
				<div class="col-2">
					<tags:label key="双程标志" required="true"/>
				</div>
				<div class="col-3">
					<tags:singleselect id="roundTripFlag" name="roundTripFlag" localData="${fns:getOptionList('getDownList','SYS_CONFIRM_FLAG')}"
									   value="${pageType == 'edit' ? priceContractBfModel.roundTripFlag : 'N'}" readonly = "${pageType =='edit'}"/>
				</div>
			</div>
			<div class="row cl">
				<br>
				<div class="col-2">
					<tags:label key="价格(元)" required="true"/>
				</div>
				<div class="col-3">
					<tags:text id="rCusBfPrice" name="rCusBfPrice" value="${priceContractBfModel.rCusBfPrice}" readonly = "${pageType =='edit'}"/>
				</div>
				<div class="col-2">
					<tags:label key="限重(吨)"/>
				</div>
				<div class="col-3">
					<tags:text id="limitWeight" name="limitWeight" value="${priceContractBfModel.limitWeight}" readonly = "${pageType =='edit'}"/>
				</div>
			</div>
			<div class="row cl">
				<br>
				<div class="col-2">
					<tags:label key="超重费用（元/每吨）"/>
				</div>
				<div class="col-3">
					<tags:text id="overweightPrice" name="overweightPrice" value="${priceContractBfModel.overweightPrice}" readonly = "${pageType =='edit'}"/>
				</div>
				<div class="col-2">
					<tags:label key="备注"/>
				</div>
				<div class="col-5">
					<tags:textarea id="remarks" name="remarks" value="${priceContractBfModel.remarks}" maxlength="200"/>
				</div>
			</div>
		</div>
	</form>
</div>
</body>
</html>