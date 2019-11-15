
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<meta name="decorator" content="default"/>
	<%@ include file="/WEB-INF/views/modules/mst/oilManagement/oilDetailJs.jsp"%>
	<style type="text/css">
		.space {
			margin-top: 20px;
		}
		#remarks {
			width: 60%;
		}
	</style>
</head>
<body>
<!-- 挡板效果 -->
<div id="over" class="over"></div>
<div id="layout" class="layout"><img src="${ctx}/static/sunsail/images/loading_072.gif" /></div>
<!-- 挡板效果 -->
<div class="content-button">
	<input id="back" class="btn btn-primary" type="button" value="返回">
	<input id="save" class="btn btn-warning" type="button" value="保存">
	<c:if test="${oilSearchModel.seqNo == '' || oilSearchModel.seqNo == null}">
		<input id="saveAndNext" class="btn btn-warning" type="button" value="保存并下一笔">
	</c:if>
</div>
<div id="">
		<form id="saveForm"  method="post" action="">
			<!-- 箱ID -->
			<tags:hidden id="seqNo" value="${oilSearchModel.seqNo}"></tags:hidden>
			<tags:hidden id="thePrice" value="${oilSearchModel.thePrice}"></tags:hidden>
			<tags:hidden id="tankStorage" value="1.00"></tags:hidden>
			<div class="row cl space">
				<div class="col-2">
					<tags:label key="油库类型" required="true"/>
				</div>
				<div class="col-4">
					<tags:checkboxs id="innerFlagY" localData="[{'text':'车场加油','value':'Y'}]" multiValue="${oilSearchModel.innerFlag == 'Y' ? 'Y' : ''}"></tags:checkboxs>
					<tags:checkboxs id="innerFlagN" localData="[{'text':'油卡加油','value':'Y'}]" multiValue="${oilSearchModel.innerFlag == 'N' ? 'Y' : '' }"></tags:checkboxs>
					<tags:hidden id="innerFlag" value="${oilSearchModel.innerFlag}"></tags:hidden>
				</div>
				<div class="col-2">
					<tags:label key="加油时间" required="true"/>
				</div>
				<div class="col-4">
					<tags:datetime id="operationTime" name="operationTime" formmat="yyyy-MM-dd HH:mm"  value="${oilSearchModel.operationTime}" startDate="%y-%M-%d 08:00:00"/>
				</div>
			</div>
			<div class="row cl space">
				<div class="col-2">
					<tags:label key="车牌号" required="true"/>
				</div>
				<div class="col-4">
					<tags:singleselect id="plateNum" name="plateNum" localData="${fns:getOptionList('getTruckPlateNo','')}"
									   value="${oilSearchModel.plateNum}" onchange="trailerChange()"></tags:singleselect>
				</div>
				<div class="col-2">
					<tags:label key="油卡号" required="true"/>
				</div>
				<div class="col-4">
					<tags:text id="cardNo" name="cardNo" maxlength="30" value="${oilSearchModel.cardNo}" readonly="true"></tags:text>
				</div>
			</div>
			<div class="row cl space">
				<div class="col-2">
					<tags:label key="司机" required="true"/>
				</div>
				<div class="col-4">
					<tags:singleselect id="driver" name="driverCode" onchange="driverChange()"
									   localData="${fns:getOptionList('getDriverList','')}"
									   value="${oilSearchModel.driverCode}"></tags:singleselect>
				</div>
				<div class="col-2">
					<tags:label key="加油站" required="true"/>
				</div>
				<div class="col-4">
					<tags:text id="station" name="station" maxlength="30" value="${oilSearchModel.station}" readonly="true"></tags:text>
				</div>
			</div>
			<div class="row cl space">
				<div class="col-2">
					<tags:label key="燃油类型" required="true"/>
				</div>
				<div class="col-4">
					<tags:singleselect id="fuelType" name="fuelType"
									   localData="${fns:getOptionList('getDownList','OIL_TYPE')}"
									   value="${oilSearchModel.fuelType}"></tags:singleselect>
				</div>
				<div class="col-2">
					<tags:label key="加油量（升）" required="true"/>
				</div>
				<div class="col-4">
					<tags:text id="addLiters" name="addLiters" maxlength="30" value="${oilSearchModel.addLiters}" onKeyup="return ValidateNumber(this,value)" onblur="changeNum(this, 0)"></tags:text>
				</div>
			</div>
			<div class="row cl space">
				<div class="col-2">
					<tags:label key="单价（元）" required="true"/>
				</div>
				<div class="col-4">
					<tags:text id="unitPrice" name="unitPrice" maxlength="30" value="${oilSearchModel.unitPrice}" onKeyup="return ValidateNumber(this,value)" onblur="changeNum(this, 1)"></tags:text>
					<span style="padding-left: 10px">金额：<span id="amount"></span></span>
				</div>
			</div>
			<div class="row cl space">
				<div class="col-2">
					<tags:label key="备注"/>
				</div>
				<div class="col-8">
					<tags:textarea id="remarks" name="remarks" value="${oilSearchModel.remarks}" maxlength="200"></tags:textarea>
				</div>
			</div>
		</form>
</div>
</body>

</html>