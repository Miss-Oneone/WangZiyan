<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title></title>
    <meta name="decorator" content="default"/>
    <%@ include file="/WEB-INF/views/modules/container/orderSeachJs.jsp" %>
    <style type="text/css">
        .differentFlag {
            color:#FF0000 ;
        }
    </style>
</head>
<body>
<!-- 挡板效果 -->
<div id="over" class="over"></div>
<div id="layout" class="layout"><img src="${ctx}/static/sunsail/images/loading_072.gif"/></div>
<!-- 挡板效果 -->
<div class="content-button" id="divOperate" style="${DisplayNoneOperate}">
    <input id="batchInsertExpenses" class="btn btn-primary" type="button" value="费用" style="${hide}">
    <input id="export" class="btn btn-primary" type="button" value="导出" style="${hide}">
    <b id="condition" isOpen="true" style="font-size:20px;float: right;margin-right: 15px;cursor:pointer">-</b>
    <input id="search" class="btn btn-secondary" type="button" value="查询" style="float: right;margin-right: 15px;">
</div>
    <div id="selectCondition">
        <div class="content-head">
            <form id="searchForm" class="form-horizontal">
                <input id="orderNoAll" type="hidden" />
                <tags:hidden id="selectOrderNo"></tags:hidden>
                <tags:hidden id="currentDate" value="${containerModel.beginTime}"></tags:hidden>
                <div class="row cl">
                    <div class="col-9">
                        <div class="col-6">
                            <div class="col-2">
                                <tags:label key="提单号"/>
                            </div>
                            <div class="col-4">
                                <tags:text id="blNo" name="blNo" width="150"/>
                            </div>
                            <div class="col-2">
                                <tags:label key="柜号"/>
                            </div>
                            <div class="col-4">
                                <tags:text id="contnNo" name="contnNo" width="150"/>
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="col-2">
                                <tags:label key="封签"/>
                            </div>
                            <div class="col-4">
                                <tags:text id="sealNo" name="sealNo" width="150"></tags:text>
                            </div>
                            <div class="col-2">
                                <tags:label key="客户"/>
                            </div>
                            <div class="col-4">
                                <tags:singleselect id="cusCode" name="cusCode"
                                                   localData="${fns:getOptionList('getCompanySname','')}" width="150"></tags:singleselect>
                            </div>
                        </div>
                    </div>
                    <div class="col-3">
                        <div class="col-3">
                            <tags:label key="发车日期"/>
                        </div>
                        <div class="col-9">
                            <tags:date id="beginTime" name="beginTime" width="93" value="${containerModel.beginTime}"/>-
                            <tags:date id="endTime" name="endTime" width="93" value="${containerModel.endTime}"/>
                            <tags:checkboxs id="unScheduling" localData="[{'text':'未排期','value':'Y'}]" multiValue="${containerModel.unScheduling}"></tags:checkboxs>
                            <tags:checkboxs id="scheduling" localData="[{'text':'已排期','value':'Y'}]" multiValue="${containerModel.scheduling}"></tags:checkboxs>
                        </div>
                    </div>

                </div>
                <div class="row cl">
                    <div class="col-9">
                        <div class="col-6">
                            <div class="col-2">
                                <tags:label key="对内货物"/>
                            </div>
                            <div class="col-4">
                                <tags:singleselect id="goodsCodeIn" name="goodsCodeIn" localData="${fns:getOptionList('getGoodsType','1')}" width="150"></tags:singleselect>
                            </div>
                            <div class="col-2">
                                <tags:label key="运力类型"/>
                            </div>
                            <div class="col-4">
                                <tags:singleselect id="trailerBelongType" localData="${fns:getOptionList('getDownList','TRAILER_BELONG_TYPE')}" width="150"/>
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="col-2">
                                <tags:label key="起始地"/>
                            </div>
                            <div class="col-4">
                                <tags:singleselect id="startArr" name="startArr" localData="${fns:getOptionList('getZxAddresList','')}" width="150"></tags:singleselect>
                            </div>
                            <div class="col-2">
                                <tags:label key="到达地"/>
                            </div>
                            <div class="col-4">
                                <tags:singleselect id="distination" name="distination" localData="${fns:getOptionList('getZxAddresList','')}" width="150"></tags:singleselect>
                            </div>
                        </div>
                    </div>
                    <div class="col-3">
                        <div class="col-3">
                            <tags:label key="接单时间"/>
                        </div>
                        <div class="col-9">
                            <tags:date id="orderDateBegin" name="orderDateBegin" width="93"></tags:date>-
                            <tags:date id="orderDateEnd" name="orderDateEnd" width="93"></tags:date>
                        </div>
                    </div>
                </div>
                <div class="row cl">
                    <div class="col-9">
                        <div class="col-6">
                            <div class="col-2">
                                <tags:label key="司机"/>
                            </div>
                            <div class="col-4">
                                <tags:singleselect id="driverCode" name="driverCode" localData="${fns:getOptionList('getDriverList','')}" width="150"></tags:singleselect>
                            </div>
                            <div class="col-2">
                                <tags:label key="车架号"/>
                            </div>
                            <div class="col-4">
                                <tags:singleselect id="frameNo" name="frameNo" localData="${fns:getOptionList('getFrames','')}" width="150"></tags:singleselect>
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="col-2">
                                <tags:label key="柜型"/>
                            </div>
                            <div class="col-4">
                                <tags:singleselect id="bfLevelCode" name="bfLevelCode" localData="${fns:getOptionList('getContainerType','')}" width="150"></tags:singleselect>
                            </div>
                            <div class="col-2">
                                <tags:label key="运输方式"/>
                            </div>
                            <div class="col-4">
                                <tags:singleselect id="transportType" name="transportType" localData="${fns:getOptionList('getTransportType','')}" width="150"></tags:singleselect>
                            </div>
                        </div>
                    </div>
                    <div class="col-3">
                        <div class="col-3">
                            <tags:label key="车牌号"/>
                        </div>
                        <div class="col-9">
                            <tags:singleselect id="plateNum" name="plateNum" localData="${fns:getOptionList('getTruckPlateNo','')}"></tags:singleselect>
                            <tags:checkboxs id="freightFlag" name="freightFlag" localData="[{'text':'运费未录','value':'Y'}]"></tags:checkboxs>
                            <tags:checkboxs id="wagesFlag" name="wagesFlag" localData="[{'text':'工资未录','value':'Y'}]"></tags:checkboxs>
                        </div>
                    </div>
                </div>
                <div class="row cl">
                    <div class="col-9">
                        <div class="col-6" style="display: none">
                            <div class="col-2">
                                <tags:label key="单据号"/>
                            </div>
                            <div class="col-4">
                                <tags:text id="documentNo" name="documentNo" width="150"/>
                            </div>
                            <div class="col-2">
                                <tags:label key="批号"/>
                            </div>
                            <div class="col-4">
                                <tags:text id="batchNo" name="batchNo" width="150"/>
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="col-2">
                                <tags:label key="计费模式"/>
                            </div>
                            <div class="col-4">
                                <tags:singleselect id="chargingType" name="chargingType" localData="${fns:getOptionList('getChargingType','')}" width="150"></tags:singleselect>
                            </div>
                            <div class="col-2" style="display: none">
                                <tags:label key="是否收单"/>
                            </div>
                            <div class="col-4" style="display: none">
                                <tags:checkboxs id="collectionOrderYes" localData="[{'text':'是','value':'Y'}]" multiValue="${containerModel.collectionOrderYes}"></tags:checkboxs>
                                <tags:checkboxs id="collectionOrderNo" localData="[{'text':'否','value':'N'}]" multiValue="${containerModel.collectionOrderNo}"></tags:checkboxs>
                            </div>
                            <div class="col-2">
                                <tags:label key="行程标志"/>
                            </div>
                            <div class="col-4">
                                <tags:checkboxs id="tripFlagUp" localData="[{'text':'上行','value':'1'}]" multiValue="${containerModel.tripFlagUp}"></tags:checkboxs>
                                <tags:checkboxs id="tripFlagDown" localData="[{'text':'下行','value':'2'}]" multiValue="${containerModel.tripFlagDown}"></tags:checkboxs>
                                <tags:checkboxs id="tripFlagNone" localData="[{'text':'无','value':'0'}]" multiValue="${containerModel.tripFlagNone}"></tags:checkboxs>
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="col-2">
                                <tags:label key="业务类型"/>
                            </div>
                            <div class="col-4">
                                <tags:singleselect id="ioType" name="ioType" localData="${fns:getOptionList('getIoType','')}" width="150"></tags:singleselect>
                            </div>
                            <div class="col-2">
                                <tags:label key="特殊箱类型"/>
                            </div>
                            <div class="col-4">
                                <tags:singleselect id="specialContnType" name="specialContnType" localData="${fns:getOptionList('getSpecialContnType','')}" width="150"></tags:singleselect>
                            </div>
                        </div>
                    </div>
                    <div class="col-3">
                        <div class="col-3">
                            <tags:label key="截箱时间"/>
                        </div>
                        <div class="col-9">
                            <tags:date id="crossBoxBeginTime" name="crossBoxBeginTime" width="93"></tags:date>-
                            <tags:date id="crossBoxEndTime" name="crossBoxEndTime" width="93"></tags:date>
                            <tags:checkboxs id="overdue" localData="[{'text':'临近超期','value':'Y'}]"></tags:checkboxs>
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
</body>
</html>