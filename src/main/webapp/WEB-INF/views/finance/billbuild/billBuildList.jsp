<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <meta name="decorator" content="default"/>
    <%@ include file="/WEB-INF/views/finance/billbuild/billBuildListJs.jsp" %>
    <style type="text/css">

    </style>
</head>
<body>
<!-- 挡板效果 -->
<div id="over" class="over"></div>
<div id="layout" class="layout"><img src="${ctx}/static/sunsail/images/loading_072.gif"/></div>
<!-- 挡板效果 -->
<div class="content-button">
    <input id="exportForFee" class="btn btn-primary" type="button" value="费用导出(竖)">
    <%--<input id="billView" class="btn btn-primary" type="button" value="对账单查询">--%>
    <input id="setBillAmount" class="btn btn-warning" type="button" value="对账保存">
    <input id="createBill" class="btn btn-warning" type="button" value="生成账单">
    <input id="settlement" class="btn btn-warning" type="button" value="快速结算">
    <b id="condition" isOpen="true" style="font-size:20px;float: right;margin-right: 15px;cursor:pointer">-</b>
    <input id="search" class="btn btn-secondary" type="button" value="查询" style="float: right;margin-right: 15px;">
</div>
<div id="selectCondition">
    <div class="content-head">
        <form id="mainForm" onsubmit="return false;" method="get" class="form-horizontal">
            <div class="responsive">
                <div class="row cl">
                    <div class="col-1">
                        <tags:label key="finance.businessDate"/>
                    </div>
                    <div class="col-3">
                        <tags:date id="businessDateFrom" value="${businessDateFrom}" width="100"/>
                        -
                        <tags:date id="businessDateTo" value="${businessDateTo}" width="100"/>
                    </div>
                    <div class="col-1">
                        <tags:label key="客户"/>
                    </div>
                    <div class="col-3">
                        <tags:singleselect id="cusCode" value="${cusCode}"
                                           localData="${fns:getOptionList('getComList','')}"></tags:singleselect>
                    </div>
                    <div class="col-1">
                        <tags:label key="往来单位"/>
                    </div>
                    <div class="col-3">
                        <tags:singleselect id="compyCode" value="${compyCode}"
                                           localData="${fns:getOptionList('getComList','')}"></tags:singleselect>
                    </div>
                </div>
                <div class="row cl">
                    <div class="col-1">
                        <tags:label key="费用名称"/>
                    </div>
                    <div class="col-3">
                        <tags:singleselect id="piCode"
                                           localData="${fns:getOptionList('getPiNameList','')}"></tags:singleselect>
                    </div>
                    <div class="col-1">
                        <tags:label key="订单号"/>
                    </div>
                    <div class="col-3">
                        <tags:text id="orderNo" value="${orderNo}"/>
                    </div>
                    <div class="col-1">
                        <tags:label key="finance.businessNo2"/>
                    </div>
                    <div class="col-3">
                        <tags:text id="businessNo2" value="${businessNo2}"/>
                    </div>
                </div>
                <div class="row cl">
                    <div class="col-1">
                        <tags:label key="类型"/>
                    </div>
                    <div class="col-3" id="allPayType">
                        <tags:checkboxs id="paymentType" multiValue="${paymentType}"
                                        localData="${fns:getOptionList('getDownList','PAYMENT_TYPE')}"/>
                        <tags:checkboxs id="feeType" multiValue="1"
                                        localData="${fns:getOptionList('getDownList','FEE_TYPE')}"/>
                    </div>
                    <!--创建人-->
                    <div class="col-1">
                        <label><tags:label key="创建人"/></label>
                    </div>
                    <div class="col-3">
                        <tags:singleselect id="createBy" localData="${fns:getOptionList('getCreatePsnList','')}">
                        </tags:singleselect>
                    </div>
                    <div class="col-1">
                        <tags:label key="创建时间"/>
                    </div>
                    <div class="col-3">
                        <tags:date id="createTimeFrom" value="${createTimeFrom}" width="100"/>
                        -
                        <tags:date id="createTimeTo" value="${createTimeTo}" width="100"/>
                    </div>
                </div>
                <div class="row cl">

                    <div class="col-1">
                        <tags:label key="对账状态"/>
                    </div>
                    <div class="col-3">
                        <tags:checkboxs id="feeStatus" multiValue="${feeStatus}"
                                        localData="[{'text':'已提交','value':'1'},{'text':'部分账单','value':'2'},{'text':'完整账单','value':'3'}]"/>
                    </div>
                    <div class="col-1">
                        <tags:label key="核销状态"/>
                    </div>
                    <div class="col-3">
                        <tags:checkboxs id="fiDoneSts" multiValue="${fiDoneSts}"
                                        localData="[{'text':'未核销','value':'未核销'},{'text':'部分核销','value':'部分核销'},{'text':'完成核销','value':'完成核销'}]"/>
                    </div>
                    <div class="col-1">
                        <tags:label key="备注"/>
                    </div>
                    <div class="col-3">
                        <tags:text id="remarks" value="${remarks}"/>
                    </div>
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
        <tags:hidden id="rreconAmounte"></tags:hidden>
        <div class="col-1">
            <tags:label key="(应收)总计"/>
        </div>
        <div class="col-1">
            <tags:text id="rAmountSum" width="120" readonly="true" cssStyle="text-align:right"></tags:text>
        </div>
        <div class="col-1">
            <tags:label key="账单"/>
        </div>
        <div class="col-1">
            <tags:text id="rBillAmountSum" width="120" readonly="true" cssStyle="text-align:right"></tags:text>
        </div>
        <div class="col-1">
            <tags:label key="账单(未)"/>
        </div>
        <div class="col-1">
            <tags:text id="runBillAmountSum" width="120" readonly="true" cssStyle="text-align:right"></tags:text>
        </div>
        <div class="col-1">
            <tags:label key="核销"/>
        </div>
        <div class="col-1">
            <tags:text id="rFiDoneAmountSum" width="120" readonly="true" cssStyle="text-align:right"></tags:text>
        </div>
        <div class="col-1">
            <tags:label key="核销(未)"/>
        </div>
        <div class="col-1">
            <tags:text id="runFiDoneAmountSum" width="120" readonly="true" cssStyle="text-align:right"></tags:text>
        </div>
    </div>
    <div class="row cl">
        <tags:hidden id="preconAmounte"></tags:hidden>
        <div class="col-1">
            <tags:label key="(应付)总计"/>
        </div>
        <div class="col-1">
            <tags:text id="pAmountSum" width="120" readonly="true" cssStyle="text-align:right"></tags:text>
        </div>
        <div class="col-1">
            <tags:label key="账单"/>
        </div>
        <div class="col-1">
            <tags:text id="pBillAmountSum" width="120" readonly="true" cssStyle="text-align:right"></tags:text>
        </div>
        <div class="col-1">
            <tags:label key="账单(未)"/>
        </div>
        <div class="col-1">
            <tags:text id="punBillAmountSum" width="120" readonly="true" cssStyle="text-align:right"></tags:text>
        </div>
        <div class="col-1">
            <tags:label key="核销"/>
        </div>
        <div class="col-1">
            <tags:text id="pFiDoneAmountSum" width="120" readonly="true" cssStyle="text-align:right"></tags:text>
        </div>
        <div class="col-1">
            <tags:label key="核销(未)"/>
        </div>
        <div class="col-1">
            <tags:text id="punFiDoneAmountSum" width="120" readonly="true" cssStyle="text-align:right"></tags:text>
        </div>
    </div>
</div>
<script>
    $(document).ready(function () {
        doSearch();
    })
</script>
</body>

</html>