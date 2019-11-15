
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <meta name="decorator" content="default"/>
    <%@ include file="/WEB-INF/views/modules/yard/heapPlanImportDtlListJs.jsp"%>
    <style type="text/css">
        p {
            padding-left: 20px;
            font-size: 20px;
            color: #aaaaaa;
        }
        p > span[tip] {
            margin-right: 30px;
            color: #2a2a2a!important;
        }
        p > span[chose] {
            margin-right: 30px;
            color: #358aed !important;
        }
        #createPlan[disabled] {
            background-color: #aaaaaa;
            border: #aaaaaa;
        }
        #sameHeapContnBox {
            height:auto;
            display: none;
            z-index: 9999;
            position: absolute;
            background-color: white;
            border: 1px solid;
        }
        .sameHeapTip {
            font-size: 12px;
            padding: 0px;
            margin: 3px;
            color: #1a1a1a;
        }
        #sameHeapContnBox:before {
            content: '';
            display: block;
            position: absolute;
            top: 2px;
            left: -11px;
            width: 0;
            height: 0;
            overflow: hidden;
            font-size: 0;
            line-height: 0;
            border: 5px;
            border-style: dashed dashed solid dashed;
            border-color: transparent transparent #000 transparent;
            transform: rotate(-90deg);
        }
        #sameHeapContnBox:after {
            content: '';
            display: block;
            width: 0;
            height: 0;
            overflow: hidden;
            font-size: 0;
            line-height: 0;
            border: 5px;
            border-style: dashed dashed solid dashed;
            border-color: transparent transparent #fff transparent;
            position: absolute;
            left: -10px;
            top: 2px;
            transform: rotate(-90deg);
        }
        .a-info:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
<!-- 挡板效果 -->
<div id="over" class="over"></div>
<div id="layout" class="layout"><img src="${ctx}/static/sunsail/images/loading_072.gif" /></div>
<!-- 挡板效果 -->
<div class="content-button">
    <input id="createPlan" class="btn btn-warning" type="button" value="生成计划" style="${hide}">
    <input id="export" class="btn btn-warning" type="button" value="导出明细" style="${hide}">
    计划日期：<tags:date id="planDate" name="planDate" value="${planDate}" width="120"/>
    <input type="checkbox" name="referFlag" value="Y" id="referFlag">
    <label for="referFlag">作为其他计划参考</label>
    <b id="condition" isOpen="true" style="font-size:20px;float: right;margin-right: 15px;cursor:pointer">-</b>
    <input id="search" class="btn btn-secondary" type="button" value="查询" style="float: right;margin-right: 15px;">
</div>
<div id="selectCondition">
    <div class="content-head">
        <form id="searchForm"  method="post" action="">
            <tags:hidden id="batchNo" value="${batchNo}"></tags:hidden>
        </form>
    </div>
    <p>批次号：<span id="batchNo_tip" tip></span>
        货号：<span id="goodsNo" tip></span>
        结关日：<span id="customsClearanceDate" tip></span>
        欠货数量：<span id="goodsOweQuantity" tip></span>
        <span style="color: #0f9ae0">已选箱数：</span></span><span id="choseQty" chose></span>
    </p>
</div>
<div class="ui-layout-center">
    <table id="mainTable" class="ui-pg-table"></table>
    <div id="mainPager"></div>
</div>
<div id="sameHeapContnBox">

</div>
</body>
</html>
