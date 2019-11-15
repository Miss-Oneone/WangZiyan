<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title></title>
    <meta name="decorator" content="default"/>
    <%@ include file="/WEB-INF/views/modules/container/containerJs.jsp" %>
    <style type="text/css">
        #contnNoOptions{
            width: 198px;
            max-height: 250px;
            border: 1px solid #CCC6C6;
            background: white;
            position: absolute;
            top: 24px;
            z-index: 99999;
            box-shadow: 0 4px 5px rgba(0, 0, 0, .15);
            overflow-y: auto;
            display: none;
        }
        #contnNoOptions p {
            padding-left: 10px;
            margin-bottom: 0px;
            padding-bottom: 3px;
            padding-top: 3px;
        }
        #contnNoOptions p:hover {
            background: #0B61A4;
            color: white;
        }
    </style>
</head>
<body>
<!-- 挡板效果 -->
<div id="over" class="over"></div>
<div id="layout" class="layout"><img src="${ctx}/static/sunsail/images/loading_072.gif"/></div>
<!-- 挡板效果 -->
<div class="content-button" id="divOperate" style="${DisplayNoneOperate}">
    <c:if test="${containerModel.orderNo != '' && containerModel.orderNo != null}">
        <input id="return" class="btn btn-primary size-M" type="button" value="返回"/>
    </c:if>
    <input id="save" class="btn btn-warning size-M" type="button" value="保存"/>
    <c:if test="${containerModel.orderNo == '' || containerModel.orderNo == null}">
        <input id="saveAndNext" class="btn btn-warning size-M" type="button" value="保存并下一条"/>
    </c:if>
    <input id="modifyPrice" class="btn btn-warning size-M" type="button" value="改运费"/>
    <input id="modifySalary" class="btn btn-warning size-M" type="button" value="改工资"/>
</div>
<div style="padding-left: 20px;padding-top: 2px">
    <form id="addFrom" class="form-horizontal">
        <!--价格协议id-->
        <tags:hidden id="contaBfId" value="${containerModel.contaBfId}"></tags:hidden>
        <!--单价（每吨或立方米）-->
        <tags:hidden id="unitPrice" value="${containerModel.unitPriceTip}"></tags:hidden>
        <!--双程标志-->
        <tags:hidden id="roundTripFlag" value="${containerModel.roundTripFlag}"></tags:hidden>
        <!--单价-->
        <tags:hidden id="price" value="${containerModel.price}"></tags:hidden>
        <!--数量-->
        <tags:hidden id="count" value="${containerModel.count}"></tags:hidden>
        <!--工资id-->
        <tags:hidden id="costRouteId" value="${containerModel.costRouteId}"></tags:hidden>
        <div class="row cl">
            <div class="col-1">
                <tags:label key="系统单号"/>
            </div>
            <div class="col-3">
                <tags:text id="orderNo" name="orderNo" readonly="true" value="${containerModel.orderNo}"/>
            </div>
            <div class="col-1">
                <tags:label key="客户" required="true"/>
            </div>
            <div class="col-3">
                <tags:singleselect id="cusCode" name="cusCode" localData="${fns:getOptionList('getCompanySname','')}"
                                   value="${containerModel.cusCode}" onchange="getPriceContracts()"></tags:singleselect>
            </div>
            <div class="col-1">
                <tags:label key="接单日期"/>
            </div>
            <div class="col-3">
                <tags:date id="orderDate" name="orderDate" value="${containerModel.orderDate}"/>
            </div>
        </div>
        <div class="row cl">
            <div class="col-1">
                <tags:label key="柜号"/>
            </div>
            <div class="col-3" style="position: relative;">
                <tags:text id="contnNo" name="contnNo" value="${containerModel.contnNo}" onKeyup="input(event)" onblur="closeContnNoOptions(event)" autocomplete="off" maxlength="30"/>
                <div id="contnNoOptions">
                </div>
            </div>
            <div class="col-1">
                <tags:label key="封签" />
            </div>
            <div class="col-3">
                <tags:text id="sealNo" name="sealNo" value="${containerModel.sealNo}"></tags:text>
            </div>
            <div class="col-1">
                <tags:label key="柜型"/>
            </div>
            <div class="col-3">
                <tags:singleselect id="bfLevelCode" name="bfLevelCode" localData="${fns:getOptionList('getContainerType','')}"
                                   value="${containerModel.bfLevelCode}" onchange="changeContnType()"></tags:singleselect>
            </div>
        </div>
        <div class="row cl">
            <div class="col-1">
                <tags:label key="业务类型"/>
            </div>
            <div class="col-3">
                <tags:singleselect id="ioType" name="ioType" localData="${fns:getOptionList('getIoType','')}" value="${containerModel.ioType}" onchange="setTimeReadOnly(this.value)"></tags:singleselect>
            </div>
            <div class="col-1">
                <tags:label key="提单号"/>
            </div>
            <div class="col-3">
                <tags:text id="blNo" name="blNo" value="${containerModel.blNo}"/>
            </div>
            <div class="col-1">
                <tags:label key="箱主"/>
            </div>
            <div class="col-3">
                <tags:singleselect id="contnOwnerId" name="contnOwnerId" localData="${fns:getOptionList('getContnOwnerList','')}" value="${containerModel.contnOwnerId}" ></tags:singleselect>
            </div>
        </div>
        <div class="row cl">
            <div class="col-1">
                <tags:label key="特殊箱类型"/>
            </div>
            <div class="col-3">
                <tags:singleselect id="specialContnType" name="specialContnType" localData="${fns:getOptionList('getSpecialContnType','')}" value="${containerModel.specialContnType}" ></tags:singleselect>
            </div>
            <div class="col-1">
                <tags:label key="还箱时间"/>
            </div>
            <div class="col-3">
                <tags:date id="changeBoxTime" name="changeBoxTime" value="${containerModel.changeBoxTime}"></tags:date>
            </div>
            <div class="col-1">
                <tags:label key="截箱时间"/>
            </div>
            <div class="col-3">
                <tags:date id="crossBoxTime" name="crossBoxTime" value="${containerModel.crossBoxTime}"></tags:date>
            </div>
        </div>
        <br/>

        <div class="row cl">
            <div class="col-1">
                <tags:label key="发车日期"/>
            </div>
            <div class="col-3">
                <tags:datetime id="departureDate" name="departureDate" formmat="yyyy-MM-dd HH:mm:ss" startDate="%y-%M-%d 08:00:00"/>
            </div>
            <div class="col-1">
                <tags:label key="车牌号"/>
            </div>
            <div class="col-3">
                <tags:singleselect id="plateNum" name="plateNum" localData="${fns:getOptionList('getTruckPlateNo','')}"
                                   value="${containerModel.plateNum}"></tags:singleselect>
            </div>
            <div class="col-1">
                <tags:label key="车架"/>
            </div>
            <div class="col-3">
                <tags:singleselect id="frameNo" name="frameNo" localData="${fns:getOptionList('getFrames','')}" value="${containerModel.frameNo}" onchange="searchframeNum(this.value)" width="115"></tags:singleselect>
                <tags:text id="frameNum" name="frameNum" readonly="true" value="${containerModel.frameNum}" width="80"/>
            </div>
        </div>
        <div class="row cl">
            <div class="col-1">
                <tags:label key="司机" />
            </div>
            <div class="col-3">
                <tags:singleselect id="driverCode" name="driverCode"
                                   localData="${fns:getOptionList('getDriverList','')}"
                                   value="${containerModel.driverCode}"></tags:singleselect>
                <tags:text cssStyle="display:none" id="relatedDrvName" value="${containerModel.relatedDrvName}" readonly="true" width="96"></tags:text>
            </div>
            <%--<div class="col-1">--%>
                <%--<tags:label key="起运地" required="true"/>--%>
            <%--</div>--%>
            <%--<div class="col-3">--%>
                <%--<tags:singleselect id="startArr" name="startArr" localData="${fns:getOptionList('getRouterType','')}" value="${containerModel.startArr}"></tags:singleselect>--%>
            <%--</div>--%>
            <%--<div class="col-1">--%>
                <%--<tags:label key="到达地" required="true"/>--%>
            <%--</div>--%>
            <%--<div class="col-3">--%>
                <%--<tags:singleselect id="distination" name="distination" localData="${fns:getOptionList('getRouterType','')}" value="${containerModel.distination}"></tags:singleselect>--%>
            <%--</div>--%>
        </div>
        <div class="row cl">
            <div class="col-1">
                <tags:label key="对内货物" required="true"/>
            </div>
            <div class="col-3">
                <tags:singleselect id="goodsCodeIn" name="goodsCodeIn" localData="${fns:getOptionList('getGoodsType','1')}"
                                   value="${containerModel.goodsCodeIn}"></tags:singleselect>
            </div>
            <div class="col-1">
                <tags:label key="对外货物"/>
            </div>
            <div class="col-3">
                <%--<tags:singleselect id="goodsCodeOut" name="goodsCodeOut" localData="${fns:getOptionList('getGoodsType','2')}"--%>
                                   <%--value="${containerModel.goodsCodeOut}"></tags:singleselect>--%>
                <tags:multiselect id="goodsCodeOut"  localData="${fns:getOptionList('getGoodsType','2')}" multiValue="${containerModel.goodsCodeOut}"/>
            </div>
            <div class="col-1">
                <tags:label key="运输方式" required="true"/>
            </div>
            <div class="col-3">
                <tags:singleselect id="transportType" name="transportType" localData="${fns:getOptionList('getTransportType','')}"
                                   value="${containerModel.transportType}" onchange="transportTypeChange()"></tags:singleselect>
            </div>
        </div>
        <br/>
        <div class="row cl">
            <div class="col-1">
                <tags:label key="起运地" required="true"/>
            </div>
            <div class="col-7">
                <tags:singleselect id="fromZxAdrs" name="fromZxAdrs" localData="${fns:getOptionList('getZxAddresList','')}"
                                   value="${containerModel.fromZxAdrs}" onchange="choseAdrs(1)"></tags:singleselect>
                <%--<tags:regionallinkageselect id="fromStdAdrs" localData="${fns:getOptionList('getProvinceName','')}"--%>
                                            <%--initNames="initFromSelectNames()" getInfo="getFromInfo()"  defaultCheck="setFromDefaultCheck()" width="100"></tags:regionallinkageselect>--%>
                <tags:text id="fromProvinceName" value="${containerModel.fromProvinceName}" width="80" readonly="true"></tags:text>
                <tags:text id="fromCityName" value="${containerModel.fromCityName}" width="80" readonly="true"></tags:text>
                <tags:text id="fromDistrictName" value="${containerModel.fromDistrictName}" width="80" readonly="true"></tags:text>
                <tags:text id="fromCountyName" value="${containerModel.fromCountyName}" width="80" readonly="true"></tags:text>
                <tags:hidden id="fromProvinceCode" value="${containerModel.fromProvinceCode}"></tags:hidden>
                <tags:hidden id="fromCityCode" value="${containerModel.fromCityCode}"></tags:hidden>
                <tags:hidden id="fromDistrictCode" value="${containerModel.fromDistrictCode}"></tags:hidden>
                <tags:hidden id="fromCountyCode" value="${containerModel.fromCountyCode}"></tags:hidden>
                <tags:hidden id="fromAddressFull" value="${containerModel.fromAddressFull}"></tags:hidden>
            </div>
            <div class="col-1">
                <tags:label key="起运地联系人"/>
            </div>
            <div class="col-3">
                <tags:text id="fromContactPerson" value="${containerModel.fromContactPerson}" width="100"></tags:text>
                <tags:text id="fromContactPhone" value="${containerModel.fromContactPhone}" width="120"></tags:text>
            </div>
        </div>
        <div class="row cl">
            <div class="col-1">
                <tags:label key="到达地" required="true"/>
            </div>
            <div class="col-7">
                <tags:singleselect id="toZxAdrs" name="toZxAdrs" localData="${fns:getOptionList('getZxAddresList','')}"
                                   value="${containerModel.toZxAdrs}" onchange="choseAdrs(2)"></tags:singleselect>
                <%--<tags:regionallinkageselect id="toStdAdrs" localData="${fns:getOptionList('getProvinceName','')}"--%>
                                            <%--initNames="initToSelectNames()" getInfo="getToInfo()"  defaultCheck="setToDefaultCheck()" width="100"></tags:regionallinkageselect>--%>
                <tags:text id="toProvinceName" value="${containerModel.toProvinceName}" width="80" readonly="true"></tags:text>
                <tags:text id="toCityName" value="${containerModel.toCityName}" width="80" readonly="true"></tags:text>
                <tags:text id="toDistrictName" value="${containerModel.toDistrictName}" width="80" readonly="true"></tags:text>
                <tags:text id="toCountyName" value="${containerModel.toCountyName}" width="80" readonly="true"></tags:text>
                <tags:hidden id="toProvinceCode" value="${containerModel.toProvinceCode}"></tags:hidden>
                <tags:hidden id="toCityCode" value="${containerModel.toCityCode}"></tags:hidden>
                <tags:hidden id="toDistrictCode" value="${containerModel.toDistrictCode}"></tags:hidden>
                <tags:hidden id="toCountyCode" value="${containerModel.toCountyCode}"></tags:hidden>
                <tags:hidden id="toAddressFull" value="${containerModel.toAddressFull}"></tags:hidden>
            </div>
            <div class="col-1">
                <tags:label key="到达地联系人"/>
            </div>
            <div class="col-3">
                <tags:text id="toContactPerson"  value="${containerModel.toContactPerson}" width="100"></tags:text>
                <tags:text id="toContactPhone"  value="${containerModel.toContactPhone}" width="120"></tags:text>
            </div>
        </div>
        <div class="row cl">
            <div class="col-1">
                <tags:label key="价格协议" required="true"/>
            </div>
            <div class="col-3">
                <tags:singleselect id="priceContract" name="priceContract" localData="${fns:getOptionList('getPriceContracts','')}"
                                   value="${containerModel.priceContract}" onchange="getPriceContractBfs()"></tags:singleselect>
            </div>
            <div class="col-1">
                <tags:label key="协议运费（元）"/>
            </div>
            <div class="col-7">
                <tags:text id="rCusBfPrice" value="${containerModel.rCusBfPrice}"  readonly="true"></tags:text>
                <span id="priceTip" style="color: red; display: none">该路线暂无定价，请再知晓价格后重新进入该订单进行价格保存</span>
                <span id="overweightTip" style="color: #0000ee; display: none">限重<span id="limitWeightTip">${containerModel.limitWeightTip}</span>吨；超重部分每吨加收<span id="overweightPriceTip">${containerModel.overweightPriceTip}</span>元</span>
                <span id="unitPriceTip" style="color: #0000ee; display:none;">单价<span id="rCusBfPriceTip">${containerModel.unitPriceTip}</span>元/吨（或元/立方米）</span>
            </div>
        </div>
        <div class="row cl">
            <div class="col-1">
                <tags:label key="重量（吨）"/>
            </div>
            <div class="col-3">
                <tags:text id="weight" value="${containerModel.weight}" readonly="${containerModel.chargingType == '3' ? true : false}"  onKeyup="return validateNumber(this,value)" onblur="changeNum(this, 0)"></tags:text>
            </div>
            <div class="col-1">
                <tags:label key="体积（立方米）"/>
            </div>
            <div class="col-3">
                <tags:text id="volume" value="${containerModel.volume}" readonly="${containerModel.chargingType != '3' ? true : false}"  onKeyup="return validateNumber(this,value)" onblur="changeNum(this, 1)"></tags:text>
            </div>
            <div class="col-1">
                <tags:label key="超重费（元）"/>
            </div>
            <div class="col-3">
                <tags:text id="overweightPrice" value="${containerModel.overweightPrice}"  readonly="true"></tags:text>
                <span id="limitWeight"></span>
            </div>
        </div>
        <br>
        <div class="row cl">
            <div class="col-1">
                <tags:label key="计费模式" required="true"/>
            </div>
            <div class="col-3">
                <tags:singleselect id="chargingType" name="chargingType" localData="${fns:getOptionList('getChargingType','')}" value="${containerModel.chargingType}" onchange="setCount(this.value)"></tags:singleselect>
            </div>
            <div class="col-1">
                <tags:label key="单据号"/>
            </div>
            <div class="col-3">
                <tags:text id="documentNo" name="documentNo" value="${containerModel.documentNo}"/>
            </div>
            <div class="col-1">
                <tags:label key="批号"/>
            </div>
            <div class="col-3">
                <tags:text id="batchNo" name="batchNo" value="${containerModel.batchNo}"/>
            </div>
        </div>
        <%--<div class="row cl">--%>
            <%--<div class="col-1">--%>
                <%--<tags:label key="单价" />--%>
            <%--</div>--%>
            <%--<div class="col-3">--%>
                <%--<tags:text id="price" name="price" value="${containerModel.price}" readonly="true"></tags:text>--%>
            <%--</div>--%>
            <%--<div class="col-1" >--%>
                <%--<tags:label key="数量"/>--%>
            <%--</div>--%>
            <%--<div class="col-3">--%>
                <%--<tags:text id="count" name="count" value="${containerModel.count}" readonly="true"></tags:text>--%>
            <%--</div>--%>
        <%--</div>--%>
        <div class="row cl">
            <div class="col-1">
                <tags:label key="行程标志"/>
            </div>
            <div class="col-3">
                <tags:checkboxs id="tripFlagUp" localData="[{'text':'上行','value':'1'}]" multiValue="${containerModel.tripFlagUp}"></tags:checkboxs>
                <tags:checkboxs id="tripFlagDown" localData="[{'text':'下行','value':'2'}]" multiValue="${containerModel.tripFlagDown}"></tags:checkboxs>
            </div>
            <div class="col-1">
                <tags:label key="是否收单"/>
            </div>
            <div class="col-3">
                <tags:checkboxs id="collectionOrderYes" localData="[{'text':'是','value':'Y'}]"
                                multiValue="${containerModel.collectionOrderYes}"></tags:checkboxs>
                <tags:checkboxs id="collectionOrderNo" localData="[{'text':'否','value':'N'}]"
                                multiValue="${containerModel.collectionOrderNo}"></tags:checkboxs>
            </div>
            <div class="col-1">
                <tags:label key="备注"/>
            </div>
            <div class="col-3">
                <tags:textarea id="remark" name="remark" value="${containerModel.remark}" maxlength="200"></tags:textarea>
            </div>
        </div>
    </form>
</div>

</body>
</html>