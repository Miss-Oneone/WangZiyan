
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<meta name="decorator" content="default"/>
	<%@ include file="/WEB-INF/views/modules/mst/zxaddress/zxAddressDetailJs.jsp"%>
	<style type="text/css">
		#mainTableContent{
			width:95%;
			margin-left:3%;
		}
		#mainTableContentFour{
			width:95%;
			margin-left:3%;
		}
		#mainTableContentTwo{
			width:95%;
			margin-left:3%;
		}
		#mainTableContentThree{
			width:95%;
			margin-left:3%;
		}
		.SelectBG{
			background-color:#d2e9ee !important;
		}
		.deSelectBG{
			background-color:#FFFFFF !important;
		}
		#divOperate{
			top: 0px;
			width: 100%;
			position: fixed;
			z-index: 999;
		}
		.ui-jqgrid-hdiv tr th:nth-of-type(2) input{
			display: none;
		}
	</style>
</head>
<body>
<!-- 挡板效果 -->
<div class="content-button" id="divOperate" style="${DisplayNoneOperate}">
	<input id="return" class="btn btn-primary size-M" type="button" value="返回" />
	<input id="add" class="btn btn-warning size-M" type="button" value="保存" />
</div>
<div style="padding-left: 20px;padding-top: 44px">
	<div style="margin-left: -100px">
		<form id="saveForm" method="post" action="">
			<tags:hidden id="id" value="${zxAddressModel.id}"/>
			<div class="row cl">
				<div class="col-2">
					<tags:label key="公司名称" required="true"/>
				</div>
				<div class="col-3">
					<tags:text id="name" name="name" value="${zxAddressModel.name}"></tags:text>
				</div>
				<div class="col-1">
					<tags:label key="地区" required="true"/>
				</div>
				<div class="col-6">
					<tags:regionallinkageselect  id="provinceCodeCopy" readonly="${zxAddressModel.id}"
												 localData="${fns:getOptionList('getProvinceName','')}" initNames="initSelectNames()" changeNoEnd="dataInfo()" defaultCheck="setDefaultCheck()" getInfo="getInfo()" onchange="getSpecialContract()" width="100">

					</tags:regionallinkageselect>
				</div>
			</div>
			<div class="row cl">
				<div class="col-2">
					<tags:label key="地址" required="true"/>
				</div>
				<div class="col-2">
					<tags:text id="address" name="address" value="${zxAddressModel.address}" maxlength="200"></tags:text>
				</div>
			</div>
			<div class="row cl">
				<div class="col-2">
					<tags:label key="联系人1"/>
				</div>
				<div class="col-3">
					<tags:text id="contactPerson" name="contactPerson" value="${zxAddressModel.contactPerson}"></tags:text>
				</div>
				<div class="col-1">
					<tags:label key="电话1"/>
				</div>
				<div class="col-3">
					<tags:text placeholder="手机号或固定电话(区号-电话号码)" id="contactPhone" name="contactPhone" value="${zxAddressModel.contactPhone}"></tags:text>
				</div>
			</div>
			<div class="row cl">
				<div class="col-2">
					<tags:label key="联系人2"/>
				</div>
				<div class="col-3">
					<tags:text  id="contactPerson2" name="contactPerson2" value="${zxAddressModel.contactPerson2}"></tags:text>
				</div>
				<div class="col-1">
					<tags:label key="电话2"/>
				</div>
				<div class="col-3">
					<tags:text placeholder="手机号或固定电话(区号-电话号码)" id="contactPhone2" name="contactPhone2" value="${zxAddressModel.contactPhone2}"></tags:text>
				</div>
			</div>
			<div class="row cl">
				<div class="col-2">
					<tags:label key="联系人3"/>
				</div>
				<div class="col-3">
					<tags:text id="contactPerson3" name="contactPerson3" value="${zxAddressModel.contactPerson3}"></tags:text>
				</div>
				<div class="col-1">
					<tags:label key="电话3"/>
				</div>
				<div class="col-3">
					<tags:text placeholder="手机号或固定电话(区号-电话号码)" id="contactPhone3" name="contactPhone3" value="${zxAddressModel.contactPhone3}"></tags:text>
				</div>
			</div>
		</form>
	</div>
	<div style="position: absolute; width: 25%; padding: 10px; right: 40px; top: 65px;height: auto">
		<p style="color: red">
			公司名称填写规则：<br>
			1.优先填写货主的实际所属公司/工厂名称，如：绿色照明、厦杏摩托；<br>
			2.若不知道公司/工厂名称，则以装卸货联系人（货名）作为公司名称，如：张先生（普货）<br>
			详细地址填写规则：<br>
			1.需要具体到路名、村名和足以百度地图定位的位置描述。如：龙池开发区横四路、新阳工业区新景路99号6号仓库、恒仓村（联盛纸业附近）
		</p>
	</div>
</div>
</body>


</html>