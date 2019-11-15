
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <meta name="decorator" content="default"/>
    <%@ include file="/WEB-INF/views/modules/yard/heapPlanImportHdListJs.jsp"%>
    <style type="text/css">

    </style>
</head>
<body>
<!-- 挡板效果 -->
<div id="over" class="over"></div>
<div id="layout" class="layout"><img src="${ctx}/static/sunsail/images/loading_072.gif" /></div>
<!-- 挡板效果 -->
<div class="content-button">
    <input id="detail" class="btn btn-primary" type="button" value="计划明细" style="${hide}">
    <input id="export" class="btn btn-primary" type="button" value="导出" style="${hide}">
    <input id="delete" class="btn btn-danger" type="button" value="删除" style="${hide}">
    <b id="condition" isOpen="true" style="font-size:20px;float: right;margin-right: 15px;cursor:pointer">-</b>
    <input id="search" class="btn btn-secondary" type="button" value="查询" style="float: right;margin-right: 15px;">
</div>
<div id="selectCondition">
    <div class="content-head">
        <form id="searchForm"  method="post" action="">
            <div class="row cl">
                <div class="col-1">
                    <tags:label key="批次号"/>
                </div>
                <div class="col-2">
                    <tags:text id="batchNo" name="batchNo" maxlength="30"></tags:text>
                </div>
                <div class="col-1">
                    <tags:label key="导入日期" />
                </div>
                <div class="col-3">
                    <tags:date id="dateFrom" name="dateFrom" value="${dateFrom}" width="100"/>
                    -
                    <tags:date id="dateTo" name="dateTo" value="${dateTo}" width="100"/>
                </div>
                <div class="col-1">
                    <tags:label key="状态"/>
                </div>
                <div class="col-2">
                    <tags:singleselect id="status" name="status" localData="${fns:getOptionList('getDownList','HEAP_PLAN_IMPORT_HD_STATUS')}"
                                       value="010"></tags:singleselect>
                </div>
            </div>
        </form>
    </div>
</div>
<div class="ui-layout-center">
    <table id="mainTable" class="ui-pg-table"></table>
    <div id="mainPager"></div>
</div>
</body>
</html>
