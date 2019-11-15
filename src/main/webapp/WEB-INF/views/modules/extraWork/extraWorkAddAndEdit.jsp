<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <meta name="decorator" content="default"/>
    <%@ include file="/WEB-INF/views/modules/extraWork/extraWorkAddAndEditJs.jsp"%>
    <style type="text/css">
        .select2-results{
            max-height:100px;
        }
    </style>
</head>
<body>
<!-- 挡板效果 -->
<div id="over" class="over"></div>
<div id="layout" class="layout"><img src="${ctx}/static/sunsail/images/loading_072.gif" /></div>
<!-- 挡板效果 -->
<div class="content-button">
    <input id="save" class="btn btn-primary" type="button" value="保存">
    <input id="back" class="btn btn-warning" type="button" value="返回">
</div>
<div id="selectCondition">
    <form id="saveForm"  method="post" action="">
        <tags:hidden id="id" value="${extraWorkModel.id}"></tags:hidden>
        <div class="row cl space">
            <div class="col-1">
                <tags:label key="发生时间"/>
            </div>
            <div class="col-3">
                <tags:date id="occurDate" name="occurDate" width="150" value="${extraWorkModel.occurDate}"></tags:date>
            </div>
            <div class="col-1">
                <tags:label key="司机"/>
            </div>
            <div class="col-3">
                <tags:singleselect id="driverCode" name="driverCode" value="${extraWorkModel.driverCode}" localData="${fns:getOptionList('getDriverList','')}" width="150"></tags:singleselect>
            </div>
            <div class="col-1">
                <tags:label key="车牌号"/>
            </div>
            <div class="col-3">
                <tags:singleselect id="plateNum" name="plateNum" value="${extraWorkModel.plateNum}" localData="${fns:getOptionList('getTruckPlateNo','')}" onchange="searchPlateNumLiters(this.value)" width="150"></tags:singleselect>
                <tags:hidden id="liters" value="${extraWorkModel.liters}"/>
            </div>
        </div>
        <div class="row cl space">
            <div class="col-1">
                <tags:label key="小活名称"/>
            </div>
            <div class="col-3">
                <tags:singleselect id="extraWorkId" name="extraWorkId" value="${extraWorkModel.extraWorkId}" localData="${fns:getOptionList('getExtraWorkList','')}" onchange="searchExtraWorkPrice(this.value)" width="150"></tags:singleselect>
                <tags:hidden id="extraWorkAmount"  value="${extraWorkModel.extraWorkAmount}"/>
                <tags:hidden id="extraWorkAddKm"  value="${extraWorkModel.extraWorkAddKm}"/>
                <tags:hidden id="extraWorkOilPatchEach"  value="${extraWorkModel.extraWorkOilPatchEach}"/>
            </div>
            <div class="col-1">
                <tags:label key="小活数量"/>
            </div>
            <div class="col-3">
                <tags:text id="quantity" name="quantity" value="${extraWorkModel.quantity}" onKeyup="return validatePositiveInteger(this,value)" onblur="countExtraWork()" width="150"></tags:text>
            </div>
            <div class="col-1">
                <tags:label key="补GPS公里"/>
            </div>
            <div class="col-3">
                <tags:text id="addKm" name="addKm" value="${extraWorkModel.addKm}" onKeyup="return validateNumber(this,value)" onblur="countGPSOilPatch()" width="150"></tags:text>
            </div>
        </div>
        <div class="row cl space">
            <div class="col-1">
                <tags:label key="小活金额"/>
            </div>
            <div class="col-3">
                <tags:text id="amount" name="amount" value="${extraWorkModel.amount}" readonly="true"  width="150"></tags:text>
            </div>
            <div class="col-1">
                <tags:label key="小活油补"/>
            </div>
            <div class="col-3">
                <tags:text id="extraWorkOilPatch" name="extraWorkOilPatch" value="${extraWorkModel.extraWorkOilPatch}" readonly="true"  width="150"></tags:text>
            </div>
            <div class="col-1">
                <tags:label key="GPS油补"/>
            </div>
            <div class="col-3">
                <tags:text id="addKmOilPatch" name="addKmOilPatch" value="${extraWorkModel.addKmOilPatch}" readonly="true"  width="150"></tags:text>
            </div>
        </div>
        <div class="row cl space">
            <div class="col-1">
                <tags:label key="车架号"/>
            </div>
            <div class="col-7">
                <tags:singleselect id="frameId" name="frameId" value="${extraWorkModel.frameId}" localData="${fns:getOptionList('getFrames','')}" onchange="searchframeNum(this.value)" width="150"></tags:singleselect>
                <tags:text id="frameNum" name="frameNum" value="${extraWorkModel.frameNum}" readonly="true"  width="100"/>
            </div>
            <div class="col-1">
                <tags:label key="箱号"/>
            </div>
            <div class="col-3">
                <tags:text id="contnNo" name="contnNo" value="${extraWorkModel.contnNo}" width="150" />
            </div>
        </div>
        <div class="row cl space">
            <div class="col-1">
                <tags:label key="备注"/>
            </div>
            <div class="col-4">
                <tags:textarea id="remarks" value="${extraWorkModel.remarks}" ></tags:textarea>
            </div>
        </div>
    </form>
</div>
</body>
</html>
