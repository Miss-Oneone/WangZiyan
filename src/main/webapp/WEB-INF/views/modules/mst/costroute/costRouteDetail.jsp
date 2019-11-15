
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<meta name="decorator" content="default"/>
	<%@ include file="/WEB-INF/views/modules/mst/costroute/costRouteDetailJs.jsp"%>
	<style type="text/css">
		.space {
			margin-top: 20px;
		}
	</style>
</head>
<body>
<!-- 挡板效果 -->
<div id="over" class="over"></div>
<div id="layout" class="layout"><img src="${ctx}/static/sunsail/images/loading_072.gif" /></div>
<!-- 挡板效果 -->
<div class="content-button">
	<input id="save" class="btn btn-warning" type="button" value="保存">
	<input id="back" class="btn btn-primary" type="button" value="返回">
</div>
<div style="padding-left: 20px;padding-top: 2px">
	<form id="saveForm" class="form-horizontal">
		<tags:hidden id="id" value="${costRouteModel.id}"/>
		<div style="margin-left: 45px">
			<div class="row cl">
				<br>
				<div class="col-2">
					<tags:label key="起始地区" required="true"/>
				</div>
				<div class="col-10">
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
				<div class="col-10">
					<tags:regionallinkageselect  id="toAdrs" localData="${fns:getOptionList('getProvinceName','')}"
												 initNames="toInitSelectNames()" defaultCheck="setToAdrsDefaultCheck()"
												 getInfo="getInfo()" width="100" readonly = "${pageType =='edit'}">
					</tags:regionallinkageselect>
				</div>
			</div>
			<div class="row cl">
				<br>
				<div class="col-2">
					<tags:label key="核定公里数" required="true" />
				</div>
				<div class="col-3">
					<tags:text id="distanceAdjKm" name="distanceAdjKm" onKeyup="clearNoNum(this)" value="${costRouteModel.distanceAdjKm}" readonly = "${pageType =='edit'}"/>
				</div>
				<div class="col-2">
					<tags:label key="司机工资"/>
				</div>
				<div class="col-3">
					<tags:text id="stdDrvSalPrice" name="stdDrvSalPrice" onKeyup="clearNoNum(this)" value="${costRouteModel.stdDrvSalPrice}" readonly = "${pageType =='edit'}"/>
				</div>
			</div>
			<div class="row cl">
				<br>
				<div class="col-2">
					<tags:label key="有效标志" required="true" />
				</div>
				<div class="col-3">
					<tags:singleselect id="validFlag" value="${costRouteModel.validFlag}" localData="${fns:getOptionList('getDownList','EFFECTIVE_STATUS')}" width="120"/>
				</div>
				<div class="col-3">
					<tags:label key="运力类型" required="true"/>
				</div>
				<div class="col-3">
					<tags:singleselect id="trailerBelongType" value="${costRouteModel.trailerBelongType}" localData="${fns:getOptionList('getDownList','TRAILER_BELONG_TYPE')}" width="150"/>
				</div>
			</div>
			<div class="row cl">
				<br>
				<div class="col-2">
					<tags:label key="备注"/>
				</div>
				<div class="col-6">
					<tags:textarea id="remarks" name="remarks" value="${costRouteModel.remarks}" maxlength="200"/>
				</div>
			</div>
		</div>
	</form>
</div>
</body>

</html>