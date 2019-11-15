<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<html>
<head>
	<meta name="decorator" content="default"/>
	<%@ include file="/WEB-INF/views/modules/mst/oilPriceCalendar/addOilPriceJs.jsp"%>
	<style type="text/css">

	</style>
</head>
<body>
<!-- 挡板效果 -->
<div id="over" class="over"></div>
<div id="layout" class="layout"><img src="${ctx}/static/sunsail/images/loading_072.gif" /></div>
<div class="content-button">
	<input id="save" class="btn btn-warning" type="button" value="保存">
	<input id="cancel" class="btn btn-primary" type="button" value="返回">
</div>
<div id="selectCondition" style="margin-top: 20px">
	<form id="saveForm" class="form-horizontal">
		<%--<tags:hidden id="fuelPurchaseId" value="${addModel.fuelPurchaseId}"></tags:hidden>--%>
		<%--<tags:hidden id="pSeq" value="${addModel.pSeq}"></tags:hidden>--%>
		<tags:hidden id="pageType" value="${addModel.pageType}"></tags:hidden>

		<div class="row cl" style="margin-bottom: 5px">
			<div class="col-3"><tags:label key="生效时间" required="true" labelfor="effectiveDate"></tags:label></div>
			<div class="col-9">
				<tags:date id="effectiveDate"  value="${addModel.effectiveDate}" width="160" readonly="${addModel.pageType == 'edit' ? true:false}"/>
			</div>
		</div>

		<div class="row cl" style="margin-bottom: 5px">
			<div class="col-3"><tags:label key="油价(元/升)" required="true" labelfor="lastPrice"></tags:label></div>
			<div class="col-9">
				<tags:text id="lastPrice" width="160" value="${addModel.lastPrice}" cssStyle="text-align:right;" onKeyup="value=value.replace(/[^\d.]/g,'')" onblur="formatNum(this)" onchange="calAmount()"></tags:text>
			</div>
		</div>

		<div class="row cl" style="margin-bottom: 5px;display: none">
			<div class="col-3"><tags:label key="油价分类" required="true" labelfor="oilPriceType"></tags:label></div>
			<div class="col-9">
				<tags:singleselect id="oilPriceType" value="${addModel.oilPriceType}"
								   localData="${fns:getOptionList('getDownList','OIL_PRICE_TYPE')}" width="160"  readonly="${addModel.pageType == 'edit' ? true:false}">
				</tags:singleselect>
			</div>
		</div>

		<div class="row cl" style="margin-bottom: 5px">
			<div class="col-3"><tags:label key="燃油类型" required="true" labelfor="oilType"></tags:label></div>
			<div class="col-9">
				<tags:singleselect id="oilType" value="${addModel.oilType}"
								   localData="${fns:getOptionList('getFuelType','')}" width="160" readonly="${addModel.pageType == 'edit' ? true:false}">
				</tags:singleselect>
			</div>
		</div>
		<%--<div class="row cl" style="margin-bottom: 5px">--%>
			<%--<div class="col-3"><tags:label key="系统平均油价" required="true" labelfor="avgPrice"></tags:label></div>--%>
			<%--<div class="col-9">--%>
				<%--<tags:text id="avgPrice" width="160" value="${addModel.avgPrice}" cssStyle="text-align:right;" readonly="readonly"></tags:text>--%>
			<%--</div>--%>
		<%--</div>--%>
		<div class="row cl" style="margin-bottom: 5px">
			<div class="col-3"><tags:label key="备注"></tags:label></div>
			<div class="col-9">
				<tags:textarea id="remarks" value="${addModel.remarks}"></tags:textarea>
			</div>
		</div>
	</form>
</div>
<br>
<%--<div class="text-center col-12" style="margin-bottom: 15px">--%>
	<%--<div class="col-2">&nbsp</div>--%>
	<%--<div class="col-2" style="text-align: center;">--%>
		<%--<input id="save" class="btn btn-warning size-S" type="submit" value="保存" />--%>
	<%--</div>--%>
	<%--<div class="col-4">&nbsp</div>--%>
	<%--<div class="col-2" style="text-align: center;">--%>
		<%--<input id="cancel" class="btn btn-danger size-S" type="button" value="取消" />--%>
	<%--</div>--%>
<%--</div>--%>
</body>
</html>