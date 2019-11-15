
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<meta name="decorator" content="default"/>
	<%@ include file="/WEB-INF/views/modules/relateCompany/relateCompanyAddJs.jsp"%>
	<style type="text/css">
		#mainTableContentOne{
			width:90%;
			margin-left:10%;
		}
		#mainTableContent{
			width:90%;
			margin-left:10%;
		}
		#divOperate{
			top: 0px;
			width: 100%;
			position: fixed;
			z-index: 999;
		}
		.ui-pager-control > .ui-pg-table > tbody > tr > td:first-child{
			width:auto !important;
		}

		#flag{
			position: absolute;
			top: 1px;
			color: red;
			display: inline-block;
			margin-left: -10px;
			width: 76px;
			white-space: normal;
		}
		#helperCodeFlag{
			position: absolute;
			left: 31%;
			top: 140px;
			color: red;
			white-space: normal;
		}
	</style>
</head>
<body>
<!-- 挡板效果 -->
<div class="content-button" id="divOperate" style="${DisplayNoneOperate}">
	<input id="return" class="btn btn-primary size-M" type="button" value="返回" />
	<input id="save" class="btn btn-warning size-M" type="button" value="保存" />
</div>
<div style="padding-left: 20px;padding-top: 44px" id="allDiv">
	<form id="addMassage" class="form-horizontal" style="margin-top: 10px">
		<tags:text id="id" name="id" value="${journal.id}" cssStyle="display:none;"/>
		<tags:text id="saveFlag" name="saveFlag" value="${journal.saveFlag}" cssStyle="display:none;"/>
		<tags:text id="type" name="type" value="${type}" cssStyle="display:none;"/>
		<div class="row cl">
			<div class="col-12 text-right">
				<div class="row cl">
					<div class="col-4">
						<div class="row">
							<div class="col-4">
								<tags:label key="编码" cssClass="clear-fix"/>
							</div>
							<div class="col-8">
								<tags:text id="relatedCompyCode" name="relatedCompyCode" placeholder="系统自动生成" readonly="true" width="170" maxlength="400" value="${relateCompanyModel.relatedCompyCode}"></tags:text>
							</div>
						</div>
					</div>
					<div class="col-4">
						<div class="row">
							<div class="col-6">
								<tags:label key="类型" cssClass="clear-fix" required="true"/>
							</div>
							<div class="col-6">
								<tags:singleselect id="relatedCompyType" name="relatedCompyType" localData="${fns:getOptionList('getCompanyType','')}" width="170" onchange="showAndHide()"></tags:singleselect>
							</div>
						</div>
					</div>
				</div>
				<div class="row cl">
					<div class="col-4">
						<div class="row">
							<div class="col-4">
								<tags:label key="简称" cssClass="clear-fix" required="true"/>
							</div>
							<div class="col-8">
								<tags:text id="compySname" name="compySname" width="170" maxlength="30" onchange="changEnglishScode()" value="${relateCompanyModel.compySname}"></tags:text>
							</div>
						</div>
					</div>
					<div class="col-4">
						<div class="row">
							<div class="col-6">
								<tags:label key="有效标志" cssClass="clear-fix" required="true"/>
							</div>
							<div class="col-6">
								<tags:singleselect id="activeFlag" name="activeFlag" localData="${fns:getOptionList('getvalidFlag','')}" width="170" value="Y" ></tags:singleselect>
							</div>
						</div>
					</div>
				</div>
				<div class="row cl">
					<div class="col-8">
						<div class="row">
							<div class="col-2">
								<tags:label key="全称" cssClass="clear-fix"/>
							</div>
							<div class="col-10">
								<tags:text id="compyFname" name="compyFname" width="551" maxlength="200" value="${relateCompanyModel.compyFname}"></tags:text>
							</div>
						</div>
					</div>
				</div>
				<div id="driver" style="margin-top: 2px">
					<div class="row cl">
						<div class="col-4">
							<div class="row">
								<div class="col-4">
									<tags:label key="司机助手账号" cssClass="clear-fix" required="false"/>
								</div>
								<div class="col-8">
									<tags:text  id="helperCode" name="helperCode" width="170" onchange="repeatJudgeHelperCode()" value="${relateCompanyModel.helperCode}" ></tags:text>
								</div>
							</div>
						</div>
						<div class="col-4">
							<div class="row">
								<div class="col-4">
									<tags:label key="身份证号" cssClass="clear-fix" required="false"/>
								</div>
								<div class="col-8">
									<tags:text  id="sfzNo" name="sfzNo" width="170" maxlength="30" onchange="provingSfzNo()" value="${relateCompanyModel.sfzNo}" ></tags:text>
								</div>
							</div>
						</div>
						<div id="sfzNoFlag">
						</div>
					</div>
					<div class="row cl">
						<div class="col-4">
							<div class="row">
								<div class="col-4">
									<tags:label key="驾驶证号" cssClass="clear-fix" required="false"/>
								</div>
								<div class="col-8">
									<tags:text  id="drvLicenceNo" name="drvLicenceNo" width="170" maxlength="30" value="${relateCompanyModel.drvLicenceNo}" ></tags:text>
								</div>
							</div>
						</div>
						<div class="col-4">
							<div class="row">
								<div class="col-4">
									<tags:label key="驾驶证等级" cssClass="clear-fix"/>
								</div>
								<div class="col-8">
									<tags:text  id="drvLicenceLevel" name="drvLicenceLevel" width="170" maxlength="10" value="${relateCompanyModel.drvLicenceLevel}"></tags:text>
								</div>
							</div>
						</div>
						<div class="col-4">
							<div class="row">
								<div class="col-4">
									<tags:label key="驾驶证获取年份" cssClass="clear-fix"/>
								</div>
								<div class="col-8">
									<tags:text  id="drvLicenceYear" name="drvLicenceYear" width="170"  value="${relateCompanyModel.drvLicenceYear}" maxlength="4"></tags:text>
								</div>
							</div>
						</div>

					</div>
					<div class="row cl">
						<div class="col-4">
							<div class="row">
								<div class="col-4">
									<tags:label key="从业资格证" cssClass="clear-fix"/>
								</div>
								<div class="col-8">
									<tags:singleselect id="certificateFlag" name="certificateFlag"  localData="${fns:getOptionList('getCertificateFlag','{text: \"请选择从业资格证\", value:\"null\" }')}" width="170" value="${relateCompanyModel.certificateFlag}" ></tags:singleselect>
								</div>
							</div>
						</div>
						<div class="col-4">
							<div class="row">
								<div class="col-4">
									<tags:label key="危货证" cssClass="clear-fix"/>
								</div>
								<div class="col-8">
									<tags:singleselect id="dangerousFlag" name="dangerousFlag" localData="${fns:getOptionList('getDangerousFlag','{text: \"请选择危货证\", value:\"null\" }')}" width="170"  value="${relateCompanyModel.dangerousFlag}"></tags:singleselect>
								</div>
							</div>
						</div>
						<div class="col-4">
							<div class="row">
								<div class="col-4">
									<tags:label key="存油量(升)" cssClass="clear-fix"/>
								</div>
								<div class="col-8">
									<tags:text  id="storageOil" name="storageOil" width="170" maxlength="6"  value="${relateCompanyModel.storageOil}"></tags:text>
								</div>
							</div>
						</div>

					</div>
					<div class="row cl">
						<div class="col-4">
							<div class="row">
								<div class="col-4">
									<tags:label key="司机手机号码1" cssClass="clear-fix" required="false"/>
								</div>
								<div class="col-8">
									<tags:text  id="phone1" name="phone1" width="170" value="${relateCompanyModel.phone1}"></tags:text>
								</div>
							</div>
						</div>
						<div class="col-4">
							<div class="row">
								<div class="col-4">
									<tags:label key="司机手机号码2" cssClass="clear-fix"/>
								</div>
								<div class="col-8">
									<tags:text  id="phone2" name="phone2" width="170" value="${relateCompanyModel.phone2}"></tags:text>
								</div>
							</div>
						</div>
						<div class="col-4">
							<div class="row">
								<div class="col-4">
									<tags:label key="邮箱" cssClass="clear-fix"/>
								</div>
								<div class="col-8">
									<tags:text  id="email" name="email" width="170" maxlength="100" value="${relateCompanyModel.email}"></tags:text>
								</div>
							</div>
						</div>

					</div>
					<div class="row cl">
						<div class="col-4">
							<div class="row">
								<div class="col-4">
									<tags:label key="离职标志" cssClass="clear-fix"/>
								</div>
								<div class="col-8">
									<tags:singleselect id="quitFlag" name="quitFlag" localData="${fns:getOptionList('getQuitFlag','')}" width="170" value="${relateCompanyModel.quitFlag}"></tags:singleselect>
								</div>
							</div>
						</div>
						<div class="col-4">
							<div class="row">
								<div class="col-4">
									<tags:label key="入职日期" cssClass="clear-fix"/>
								</div>
								<div class="col-8">
									<tags:date  id="entryTime" name="entryTime" width="170" value="${relateCompanyModel.entryTime}"></tags:date>
								</div>
							</div>
						</div>
						<div class="col-4">
							<div class="row">
								<div class="col-4">
									<tags:label key="离职日期" cssClass="clear-fix"/>
								</div>
								<div class="col-8">
									<tags:date  id="quitTime" name="quitTime" width="170" value="${relateCompanyModel.quitTime}"></tags:date>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</form>
	<div id="helperCodeFlag">
	</div>
	<div id="contractGrid" ${type} style="margin-top: 45px">
		<div id="relatedPsn">
			<div style="margin-left: 10%;margin-top: 20px">联系人信息</div>
			<div class="ui-layout-center" id="mainTableContentOne">
				<table id="psnTable" class="ui-pg-table"></table>
				<div id="psnPager"></div>
			</div>
		</div>
		<div style="margin-left: 10%;margin-top: 20px">银行账号</div>
		<div class="ui-layout-center" id="mainTableContent">
			<table id="bankTable" class="ui-pg-table"></table>
			<div id="bankPager"></div>
		</div>
	</div>
</div>
</body>
</html>