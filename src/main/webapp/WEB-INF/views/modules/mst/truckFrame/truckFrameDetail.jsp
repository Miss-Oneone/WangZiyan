
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<meta name="decorator" content="default"/>
	<%@ include file="/WEB-INF/views/modules/mst/truckFrame/truckFrameDetailJs.jsp"%>
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
<div id="">
		<form id="saveForm"  method="post" action="">
			<!-- 车架管理ID -->
			<tags:hidden id="id" value="${truckFrameModel.id}"></tags:hidden>
			<%--<div class="row cl space">--%>
				<%--<div class="col-2">--%>
					<%--<tags:label key="车架类型" required="true"/>--%>
				<%--</div>--%>
				<%--<div class="col-10">--%>
					<%--<tags:singleselect id="frameType" value="${truckFrameModel.frameTypeId}" onchange="getInternalCodes()"--%>
									   <%--localData="${fns:getOptionList('getFrameType', '')}" disabled="${truckFrameModel.disabledFlag}"/>--%>
				<%--</div>--%>
			<%--</div>--%>
			<%--<div class="row cl space">--%>
				<%--<div class="col-2">--%>
					<%--<tags:label key="是否套牌" required="true"/>--%>
				<%--</div>--%>
				<%--<div class="col-10">--%>
					<%--<tags:singleselect id="taopaiFlag" value="${truckFrameModel.taopaiFlag}" onchange="getInternalCodes()"--%>
									   <%--localData="[{text: '是', value: 'Y'}, {text: '否', value: 'N'}]" disabled="${truckFrameModel.disabledFlag}"/>--%>
				<%--</div>--%>
			<%--</div>--%>
			<div class="row cl space">
				<div class="col-2">
					<tags:label key="内部编码" required="true"/>
				</div>
				<div class="col-10">
					<tags:text id="frameCardId" value="${truckFrameModel.frameCardId}"/>
				</div>
			</div>
			<div class="row cl space">
				<div class="col-2">
					<tags:label key="车架序列号" />
				</div>
				<div class="col-10">
					<tags:text id="serialNo" value="${truckFrameModel.serialNo}" onblur="trim(this)"></tags:text>
				</div>
			</div>
			<div class="row cl space">
				<div class="col-2">
					<tags:label key="车架车牌号" required="true"/>
				</div>
				<div class="col-10">
					<tags:text id="frameNum" value="${truckFrameModel.frameNum}" onblur="trim(this)"></tags:text>
				</div>
			</div>
			<%--<div class="row cl space">--%>
				<%--<div class="col-2">--%>
					<%--<tags:label key="所属公司"/>--%>
				<%--</div>--%>
				<%--<div class="col-10">--%>
					<%--<tags:singleselect id="relatedCompyCode" value="${truckFrameModel.relatedCompyCode}"--%>
									   <%--localData="${fns:getOptionList('getBelongCompy','')}"/>--%>
				<%--</div>--%>
			<%--</div>--%>
			<div class="row cl space">
				<div class="col-2">
					<tags:label key="车头车牌号"/>
				</div>
				<div class="col-10">
					<%--<tags:text id="truckPlateNo" value="${truckFrameModel.truckPlateNo}" onblur="trim(this)"></tags:text>--%>
					<tags:singleselect id="plateNum" value="${truckFrameModel.plateNum}" onchange="clearScrapData()"
									   localData="${fns:getOptionList('getTruckPlateNo','')}"/>
				</div>
			</div>
			<div class="row cl space">
				<div class="col-2">
					<tags:label key="车架类型" required="true"/>
				</div>
				<div class="col-10">
					<tags:singleselect id="frameTypeId" value="${truckFrameModel.frameTypeId}" localData="${fns:getOptionList('getFrameType','')}" ></tags:singleselect>
				</div>
			</div>
		</form>
</div>
</body>

</html>