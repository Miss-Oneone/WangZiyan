
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<meta name="decorator" content="default"/>
	<%@ include file="/WEB-INF/views/modules/mst/zxaddress/zxAddressListJs.jsp"%>
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
		.gps-ok {
			background-color: #8DFA69;
			width: 59px;
			text-align: center;
		}
		.gps-ng {
			background-color: #e51c23;
			width: 59px;
			text-align: center;
			color: #ffffff!important;
		}
	</style>
</head>
<body>
<!-- 挡板效果 -->
<div id="over" class="over"></div>
<div id="layout" class="layout"><img src="${ctx}/static/sunsail/images/loading_072.gif" /></div>
<!-- 挡板效果 -->
<div class="content-button">
	<input id="addressAdd" class="btn btn-primary" type="button" value="新增">
	<input id="save" class="btn btn-primary" type="button" value="确定">
	<input id="addressDelete" class="btn btn-danger" type="button" value="删除">
	<b id="condition" isOpen="true" style="font-size:20px;float: right;margin-right: 15px;cursor:pointer">-</b>
	<input id="search" class="btn btn-secondary" type="button" value="查询" style="float: right;margin-right: 15px;">
</div>
<div id="selectCondition">
	<div class="content-head">
		<form id="searchForm"  method="post" action="/mst/address/zxAddress">
			<div style="display: none">
				<tags:text id="cusCode" name="cusCode"></tags:text>
			</div>
			<div class="row cl">
				<!--时间-->
				<div class="col-1">
					<tags:label key="名称" />
				</div>
				<div class="col-3">
					<tags:text id="name" name="name"></tags:text>
				</div>
				<div class="col-8 cl">
					<div class="col-1">
						<tags:label key="地区" />
					</div>
					<div class="col-7">
						<tags:regionallinkageselect  id="provinceCodeCopy"
													 localData="${fns:getOptionList('getProvinceName','')}" initNames="initSelectNames()" getInfo="getInfo()" width="100">

						</tags:regionallinkageselect>

					</div>
					<div class="col-1">
						<tags:label key="地址" />
					</div>
					<div class="col-3">
						<tags:text id="address" name="address"></tags:text>
					</div>
				</div>
			</div>
			<div class="row cl">
				<div class="col-1">
					<tags:label key="联系人" />
				</div>
				<div class="col-3">
					<tags:text id="person" name="person"></tags:text>
				</div>
				<div class="col-8 cl">
					<div class="col-1">
						<tags:label key="联系电话"/>
					</div>
					<div class="col-7">
						<tags:text id="phone" name="phone"></tags:text>
					</div>
					<%--<div class="col-1">--%>
						<%--<tags:label key="导航GPS录入"/>--%>
					<%--</div>--%>
					<%--<div class="col-3">--%>
						<%--<tags:singleselect id="gpsInputFlag" name="gpsInputFlag" localData="[{'text':'导航GPS确定','value':'Y'},{'text':'导航GPS未确定','value':'N'}]"></tags:singleselect>--%>
					<%--</div>--%>
				</div>
			</div>
		</form>
	</div>
</div>
</div>
<div>
	<div class="ui-layout-center">
		<table id="mainTable" class="ui-pg-table"></table>
		<div id="mainPagersssss"></div>
	</div>
</div>
</body>

</html>