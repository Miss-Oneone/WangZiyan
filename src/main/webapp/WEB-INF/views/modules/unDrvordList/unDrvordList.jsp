<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<html>
<head>
	<meta name="decorator" content="default"/>
	<style type="text/css">
		.border-top{border-top:1px solid #555555}
		.border-bottom{border-bottom:1px solid #555555}
		.border-left{border-left:1px solid #555555}
		.border-right{border-right:1px solid #555555}
		.in-line{overflow: hidden;white-space: nowrap;text-overflow: ellipsis}
		.dr-color{
			background-color:#C8FAFA;
		}
		.fi-color{
			background-color:#60CBD3;
		}
	</style>
	<%@ include file="/WEB-INF/views/modules/unDrvordList/unDrvordListJs.jsp" %>
</head>
<body>
<!-- 挡板效果 -->
<div id="over" class="over"></div>
<div id="layout" class="layout"><img src="${ctx}/static/sunsail/images/loading_072.gif"/></div>
<!-- 挡板效果 -->
<div class="content-button">
	<!-- 新增联系履历 -->
	<input id="createContact" type="button" class="btn btn-primary" value="新增联系履历"/>
	<b id="condition" isOpen="true" style="font-size: 20px; float: right; margin-right: 15px; cursor: pointer">-</b>
	<!-- 查询 -->
	<input id="search" type="button" class="btn btn-secondary"
		   value="<fmt:message key="btn_query"/>"
		   style="float: right; margin-right: 15px;"/>
</div>
<div id="selectCondition">
	<form id="searchForm" method="post" action="${ctxZG}/unDrvordList/search">
		<div class="content-head">
			<div class="row cl">
				<div class="col-1">
					<label><tags:label key="调度分组"/></label>
				</div>
				<div class="col-2">
					<tags:singleselect id="controlGroup" name="controlGroup" localData="${fns:getOptionList('getControlGroup','')}" width="120" value="${unDrvordListModel.controlGroup}"></tags:singleselect>
				</div>
				<div class="col-2">
					<tags:checkboxs id="unOverDay" name="unOverDay" multiValue="${unDrvordListModel.unOverDay}" localData="[{'text':'未超期','value':'true'}]" ></tags:checkboxs>
					<tags:checkboxs id="overDay" name="overDay" multiValue="${unDrvordListModel.overDay}" localData="[{'text':'已超期','value':'true'}]"></tags:checkboxs>
					<tags:checkboxs id="unScheduling" name="unScheduling" multiValue="${unDrvordListModel.unScheduling}" localData="[{'text':'未预排','value':'true'}]"></tags:checkboxs>
					<tags:checkboxs id="scheduling" name="scheduling" multiValue="${unDrvordListModel.scheduling}" localData="[{'text':'已预排','value':'true'}]"></tags:checkboxs>
				</div>
				<div class="col-1">
					<label><tags:label key="联系人"/></label>
				</div>
				<div class="col-2">
					<tags:text id="contact" name="contact" width="100" value="${unDrvordListModel.contact}"></tags:text>
				</div>
				<div class="col-1">
					<label><tags:label key="电话"/></label>
				</div>
				<div class="col-2">
					<tags:text id="contactTel" name="contactTel" width="150" value="${unDrvordListModel.contactTel}" onchange="checkTel(this)" cssStyle="text-align: right"></tags:text>
				</div>
			</div>
			<div class="row cl">

			</div>
		</div>
	</form>
</div>
<div class="ui-layout-center">
	<table id="mainTable" class="ui-pg-table"></table>
	<div id="mainPager"></div>
</div>
</body>
</html>