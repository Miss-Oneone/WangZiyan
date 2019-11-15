<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<meta name="decorator" content="default"/>
	<%@include file="/WEB-INF/views/modules/expenseManagement/recPayAddJs.jsp" %>
	<style type="text/css">
		button{
			color:#FFFFFF;
			margin-left:10px;
			height:20px;
			width:120px;
		}
		.select2-results {
			max-height: 150px;
		}
	</style>
</head>
<body>
<tags:hidden id="recPayId" value="${recPay.recPayId}"/>
<tags:hidden id="paymentType" value="${recPay.paymentType}"/>
<tags:hidden id="feeType" value="${recPay.feeType}"/>
<tags:hidden id="orderNo" value="${recPay.orderNo}"/>
<tags:hidden id="feeStatus" value="${recPay.feeStatus}"/>
<tags:hidden id="binsApprovalFlag" value="${recPay.binsApprovalFlag}"/>
<div style="padding-top: 10px;">
	<div class="row cl">
		<div class="col-3">
			<tags:label key="价目" required="true"></tags:label>
		</div>
		<div class="col-9">
			<tags:singleselect id="piCode" value="${recPay.piCode}"
							   localData="${fns:getOptionList('getPriceItems','')}">
			</tags:singleselect>
		</div>
	</div>
	<div class="row cl">
		<div class="col-3">
			<tags:label key="${recPay.paymentType == '1'? '付款单位':'收款单位' }" required="true"></tags:label>
		</div>
		<div class="col-9">
			<tags:singleselect id="compyCode" value="${recPay.compyCode}"
							   localData="${fns:getOptionList('getRelatedCompy','')}">
			</tags:singleselect>
		</div>
	</div>
	<div class="row cl">
		<div class="col-3">
			<tags:label key="${recPay.paymentType == '1'? '应收金额':'应付金额' }" required="true"></tags:label>
		</div>
		<div class="col-9">
			<tags:text id="amount" name="amount" value="${recPay.amount}" onKeypress="if (event.keyCode!=46 && event.keyCode!=45 && (event.keyCode<48 || event.keyCode>57)) event.returnValue=false" onblur="clearNoNum(this)" cssStyle="text-align:right"></tags:text>
		</div>
	</div>
	<div class="row cl">
		<div class="col-3">
			<tags:label key="预计日期" required="true"></tags:label>
		</div>
		<div class="col-9">
			<tags:date id="expDate" name="expDate" value="${recPay.expDate}"></tags:date>
		</div>
	</div>
	<div class="row cl">
		<div class="col-3">
			<tags:label key="${recPay.paymentType == '1'? '应收备注':'应付备注' }"></tags:label>
		</div>
		<div class="col-9">
			<tags:textarea id="remarks" value="${recPay.remarks}" rows="5"></tags:textarea>
		</div>
	</div>
</div>
	<div style="text-align: center; left: 0; right: 0; padding-top: 22px;">
		<tags:button id="temporary" key="暂存" cssClass="btn btn-warning" cssStyle="height: 31px;padding-left: 11px;width: 46px;margin-left: 0px;"/>
		<tags:button id="temporaryAndNext" key="暂存并下一笔" cssClass="btn btn-warning" cssStyle="height: 31px;padding-left: 11px;width: 95px;margin-left: 0px;"/>
		<tags:button id="save" key="提交" cssClass="btn btn-warning" cssStyle="height: 31px;padding-left: 11px;width: 46px;margin-left: 0px;"/>
		<tags:button id="saveAndNext" key="提交并下一笔" cssClass="btn btn-warning" cssStyle="height: 31px;padding-left: 11px;width: 95px;margin-left: 0px;"/>
		<tags:button id="cancel" key="取消" cssClass="btn btn-primary" cssStyle="height: 31px;padding-left: 9px;width: 46px;margin-left: 0px;"/>
	</div>
</body>
</html>