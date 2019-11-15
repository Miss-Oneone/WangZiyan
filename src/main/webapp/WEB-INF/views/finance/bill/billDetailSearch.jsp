<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <meta name="decorator" content="default"/>
    <%@ include file="/WEB-INF/views/finance/bill/billDetailSearchJs.jsp" %>
    <style type="text/css">
        .a-info {
            color: blue !important;
        }
    </style>
</head>
<body>
<!-- 挡板效果 -->
<div id="over" class="over"></div>
<div id="layout" class="layout"><img src="${ctx}/static/sunsail/images/loading_072.gif"/></div>
<!-- 挡板效果 -->

<div class="content-button">
    <!-- 导出 -->
    <input id="export" type="button" class="btn btn-primary" value="导出"/>

    <b id="condition" isOpen="true" style="font-size:20px;float: right;margin-right: 15px;cursor:pointer">-</b>
    <!-- 查询 -->
    <input id="search" type="button" class="btn btn-secondary" value="查询" style="float: right;margin-right: 15px;"/>
</div>
<form id="exportForm" method="post"></form>
<div id="selectCondition">
    <div class="content-head">
        <form id="searchForm" method="post" action="${ctxZG}/bill">
            <div class="row cl">
                <div class="col-1">
                    <tags:label key="应收应付"/>
                </div>
                <div class="col-3">
                    <tags:checkboxs id="paymentType" width="200" multiValue="${BillDetailSearchResultModel.paymentType}"
                                    localData="${fns:getOptionList('getDownList','PAYMENT_TYPE')}"/>
                </div>
                <div class="col-1">
                    <tags:label key="直接间接"/>
                </div>
                <div class="col-3">
                    <tags:checkboxs id="feeType" width="200" multiValue="${BillDetailSearchResultModel.feeType}"
                                    localData="${fns:getOptionList('getDownList','FEE_TYPE')}"/>
                </div>
                <div class="col-1">
                    <tags:label key="账单状态"/>
                </div>
                <div class="col-3">
                    <tags:checkboxs id="billStatus" width="200"
                                    multiValue="${BillDetailSearchResultModel.billStatus}"
                                    localData="${fns:getOptionList('getDownList','BILL_STATUS')}"/>
                </div>
            </div>
            <div class="row cl">
                <div class="col-1">
                    <tags:label key="账单号"/>
                </div>
                <div class="col-3">
                    <tags:text id="billNo" value="${BillDetailSearchResultModel.billNo}" width="200"/>
                </div>
                <div class="col-1">
                    <tags:label key="往来单位"/>
                </div>
                <div class="col-3">
                    <tags:singleselect id="relatedCompy" value="${BillDetailSearchResultModel.relatedCompy}"
                                       localData="${fns:getOptionList('getComList','')}"></tags:singleselect>
                </div>
                <div class="col-1">
                    <tags:label key="账单日期"/>
                </div>
                <div class="col-3">
                    <tags:date id="billDateFrom" value="${expression:today()}" width="110"/>
                    -
                    <tags:date id="billDateTo" value="${expression:today()}" width="110"/>
                </div>
            </div>
            <div class="row cl">
                <div class="col-1">
                    <tags:label key="票据号"/>
                </div>
                <div class="col-3">
                    <tags:text id="invoiceNo" value="${BillDetailSearchResultModel.invoiceNo}" width="200"/>
                </div>
                <div class="col-1">
                    <tags:label key="finance.businessNo1"/>
                </div>
                <div class="col-3">
                    <tags:text id="businessNo1" value="${BillDetailSearchResultModel.businessNo1}" width="234"/>
                </div>
                <div class="col-1">
                    <tags:label key="finance.businessNo2"/>
                </div>
                <div class="col-3">
                    <tags:text id="businessNo2" value="${BillDetailSearchResultModel.businessNo2}" width="234"/>
                </div>
            </div>
            <div class="row cl">
                <div class="col-1">
                    <tags:label key="票据日期"/>
                </div>
                <div class="col-3">
                    <tags:date id="invoiceDateFrom" value="${BillDetailSearchResultModel.invoiceDateFrom}"
                               width="110"/>
                    -
                    <tags:date id="invoiceDateTo" value="${BillDetailSearchResultModel.invoiceDateTo}" width="110"/>
                </div>
                <div class="col-1">
                    <tags:label key="finance.businessDate"/>
                </div>
                <div class="col-3">
                    <tags:date id="businessDateFrom" value="${BillDetailSearchResultModel.businessDateFrom}"
                               width="110"/>
                    -
                    <tags:date id="businessDateTo" value="${BillDetailSearchResultModel.businessDateTo}" width="110"/>
                </div>
                <div class="col-1">
                    <tags:label key="费用备注"/>
                </div>
                <div class="col-3">
                    <tags:text id="srpRemarks" value="${BillDetailSearchResultModel.srpRemarks}" width="200"/>
                </div>
            </div>
        </form>
    </div>
</div>
<div class="ui-layout-center">
    <table id="mainTable" class="ui-pg-table"></table>
    <div id="mainPager"></div>
</div>
<div id="content-bottom" style="padding-top: 5px;">
    <div class="row cl">
        <div class="col-1">
            <tags:label key="(应收)金额"/>
        </div>
        <div class="col-3">
            <tags:text id="rAmount" value="0.00" width="100" readonly="true" cssStyle="text-align:right"></tags:text>
        </div>
        <div class="col-1">
            <tags:label key="已核销"/>
        </div>
        <div class="col-3">
            <tags:text id="rFiDoneAmount" value="0.00" width="100" readonly="true" cssStyle="text-align:right"></tags:text>
        </div>
        <div class="col-1">
            <tags:label key="未核销"/>
        </div>
        <div class="col-3">
            <tags:text id="rUnFiDoneAmount" value="0.00" width="100" readonly="true" cssStyle="text-align:right"></tags:text>
        </div>
    </div>
    <div class="row cl">
        <div class="col-1">
            <tags:label key="(应付)金额"/>
        </div>
        <div class="col-3">
            <tags:text id="pAmount" value="0.00" width="100" readonly="true" cssStyle="text-align:right"></tags:text>
        </div>
        <div class="col-1">
            <tags:label key="已核销"/>
        </div>
        <div class="col-3">
            <tags:text id="pFiDoneAmount" value="0.00" width="100" readonly="true" cssStyle="text-align:right"></tags:text>
        </div>
        <div class="col-1">
            <tags:label key="未核销"/>
        </div>
        <div class="col-3">
            <tags:text id="pUnFiDoneAmount" value="0.00" width="100" readonly="true" cssStyle="text-align:right"></tags:text>
        </div>
    </div>
</div>
</body>

</html>