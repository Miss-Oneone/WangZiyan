
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <meta name="decorator" content="default"/>
    <%@ include file="/WEB-INF/views/modules/yard/heapPlanListJs.jsp"%>
    <style type="text/css">

    </style>
</head>
<body>
<!-- 挡板效果 -->
<div id="over" class="over"></div>
<div id="layout" class="layout"><img src="${ctx}/static/sunsail/images/loading_072.gif" /></div>
<!-- 挡板效果 -->
<div class="content-button">
    <input id="updatePlanDate" class="btn btn-warning" type="button" value="批量修改计划日期" style="${hide}">
    <b id="condition" isOpen="true" style="font-size:20px;float: right;margin-right: 15px;cursor:pointer">-</b>
    <input id="search" class="btn btn-secondary" type="button" value="查询" style="float: right;margin-right: 15px;">
</div>
<div id="selectCondition">
    <div class="content-head">
        <form id="searchForm"  method="post" action="">
            <div class="row cl">
                <div class="col-1">
                    <tags:label key="状态"/>
                </div>
                <div class="col-2">
                    <tags:singleselect id="status" name="status" localData="${fns:getOptionList('getDownList','HEAP_PLAN_STATUS')}"
                                       value="010"></tags:singleselect>
                </div>
                <div class="col-1">
                    <tags:label key="计划日期" />
                </div>
                <div class="col-3">
                    <tags:date id="dateFrom" name="dateFrom" value="${dateFrom}" width="100"/>
                    -
                    <tags:date id="dateTo" name="dateTo" value="${dateTo}" width="100"/>
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
