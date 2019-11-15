
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<meta name="decorator" content="default"/>
	<%@ include file="/WEB-INF/views/modules/mst/contn/contnDetailJs.jsp"%>
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
		<!-- 箱ID -->
		<tags:hidden id="id" value="${contnModel.id}"></tags:hidden>
		<div class="row cl space">
			<div class="col-2">
				<tags:label key="箱号" required="true"/>
			</div>
			<div class="col-4">
				<tags:text id="contnNo" value="${contnModel.contnNo}"/>
			</div>
			<div class="col-2">
				<tags:label key="箱类型" required="true"/>
			</div>
			<div class="col-4">
				<tags:singleselect id="contnType" name="contnType" localData="${fns:getOptionList('getDownList','CONTN_TYPE')}"
								   value="${contnModel.contnType}"></tags:singleselect>
			</div>
		</div>
		<div class="row cl space">
			<div class="col-2">
				<tags:label key="特殊箱类型"/>
			</div>
			<div class="col-4">
				<tags:singleselect id="specialContnType" name="specialContnType" localData="${fns:getOptionList('getSpecialContnType','')}" value="${contnModel.specialContnType}" ></tags:singleselect>
			</div>
			<div class="col-2">
				<tags:label key="箱主" />
			</div>
			<div class="col-4">
				<tags:singleselect id="contnOwnerId" name="contnOwnerId" localData="${fns:getOptionList('getContnOwner','')}"
								   value="${contnModel.contnOwnerId}"></tags:singleselect>
			</div>
		</div>
		<div class="row cl space">
			<div class="col-2">
				<tags:label key="有效标志" required="true"/>
			</div>
			<div class="col-4">
				<tags:singleselect id="activeFlag" name="activeFlag" localData="${fns:getOptionList('getDownList','ACTIVE_FLAG')}"
								   value="${contnModel.activeFlag}"></tags:singleselect>
			</div>
		</div>
		<div class="row cl space">
			<div class="col-2">
				<tags:label key="备注"/>
			</div>
			<div class="col-10">
				<tags:textarea id="remarks" name="remarks" value="${contnModel.remarks}" maxlength="200"></tags:textarea>
			</div>
		</div>
	</form>
</div>
</body>

</html>