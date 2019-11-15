<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <meta name="decorator" content="default"/>
    <%@ include file="/WEB-INF/views/modules/extraWork/extraWorkDetailListJs.jsp"%>
    <style type="text/css">

    </style>
</head>
<body>
<!-- 挡板效果 -->
<div id="over" class="over"></div>
<div id="layout" class="layout"><img src="${ctx}/static/sunsail/images/loading_072.gif" /></div>
<!-- 挡板效果 -->
<div class="content-button">
    <input id="add" type="button" class="btn btn-primary" value="新增"/>
    <input id="edit" type="button" class="btn btn-primary" value="编辑"/>
    <input id="delete" type="button" class="btn btn-danger" value="删除"/>
    <input id="lookUp" type="button" class="btn btn-primary" value="查看小活类目"/>
    <b id="condition" isOpen="true" style="font-size:20px;float: right;margin-right: 15px;cursor:pointer">-</b>
    <input id="search" class="btn btn-secondary" type="button" value="查询" style="float: right;margin-right: 15px;">
</div>
<div id="selectCondition">
    <div class="content-head">
        <form id="searchForm"  method="post" action="">
            <div class="row cl">
                <div class="col-1">
                    <tags:label key="发生时间"/>
                </div>
                <div class="col-2">
                    <tags:date id="occurDateFrom" name="occurDateFrom" width="93" value="${occurDateFrom}"></tags:date>-
                    <tags:date id="occurDateTo" name="occurDateTo" width="93" value="${occurDateTo}"></tags:date>
                </div>
                <div class="col-1">
                    <tags:label key="司机"/>
                </div>
                <div class="col-2">
                    <tags:singleselect id="driverCode" name="driverCode" localData="${fns:getOptionList('getDriverList','')}" width="150"></tags:singleselect>
                </div>
                <div class="col-1">
                    <tags:label key="小活名称"/>
                </div>
                <div class="col-2">
                    <tags:singleselect id="extraWorkId" name="extraWorkId" localData="${fns:getOptionList('getExtraWorkList','')}" width="150"></tags:singleselect>
                </div>
                <div class="col-1">
                    <tags:label key="车牌号"/>
                </div>
                <div class="col-2">
                    <tags:singleselect id="plateNum" name="plateNum" localData="${fns:getOptionList('getTruckPlateNo','')}" width="150"></tags:singleselect>
                </div>
            </div>
            <div class="row cl">
                <div class="col-1">
                    <tags:label key="车架号"/>
                </div>
                <div class="col-2">
                    <tags:singleselect id="frameId" name="frameId" localData="${fns:getOptionList('getFrames','')}" onchange="searchframeNum(this.value)" width="115"></tags:singleselect>
                    <tags:text id="frameNum" name="frameNum" readonly="true"  width="80"/>
                </div>
                <div class="col-1">
                    <tags:label key="箱号"/>
                </div>
                <div class="col-2">
                    <tags:text id="contnNo" name="contnNo" width="150" />
                </div>
            </div>
        </form>
    </div>
</div>
<div>
    <div class="ui-layout-center table-col-3">
        <table id="mainTable" class="ui-pg-table"></table>
        <div id="mainPager"></div>
    </div>
    <div id="content-bottom"  style="padding-top: 5px;">
        <div class="row cl">
            <div class="col-1">
                <tags:label key="金额合计" />
            </div>
            <div class="col-1">
                <tags:text id="amountSum" width="100" readonly="true"  value="0.00" cssStyle="text-align:right"></tags:text>
            </div>
            <div class="col-1">
                <tags:label key="小活油补合计" />
            </div>
            <div class="col-1">
                <tags:text id="extraWorkOilPatchSum" width="80" readonly="true" value="0.00" cssStyle="text-align:right"></tags:text>
            </div>
            <div class="col-1">
                <tags:label key="补公里数合计" />
            </div>
            <div class="col-1">
                <tags:text id="addKmSum" width="80" readonly="true" value="0.00" cssStyle="text-align:right"></tags:text>
            </div>
            <div class="col-1">
                <tags:label key="公里数油补合计" />
            </div>
            <div class="col-1">
                <tags:text id="addKmOilPatchSum" width="80" readonly="true" value="0.00" cssStyle="text-align:right"></tags:text>
            </div>
        </div>
    </div>
</div>
</body>
</html>
