<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <meta name="decorator" content="default"/>
    <%@ include file="/WEB-INF/views/modules/mst/selfTrailer/selfTrailerHeaderJs.jsp" %>
</head>
<body>
<!-- 挡板效果 -->
<div id="over" class="over"></div>
<div id="layout" class="layout"><img src="${ctx}/static/sunsail/images/loading_072.gif"/></div>
<!-- 挡板效果 -->
<div class="content-button" id="divSearch">
    <!-- 头部保存 -->
    <input id="Save" type="button" class="btn btn-warning" value="保存"/>
</div>
<div id="selectCondition">
    <div class="content-head">
        <form id="searchForm" method="post">
            <tags:hidden id="pageType" value="${pageType}"/>
            <div class="row cl">
                <div class="col-1">
                    <tags:label key="车牌号" required="true"/>
                </div>
                <div class="col-2">
                    <tags:text id="plateNum" value="${selfTrailer.plateNum}" readonly="${pageType == 'edit'}"  width="150"></tags:text>
                </div>
                <%--<div class="col-1">--%>
                    <%--<tags:label key="GPS车牌号" required="true"/>--%>
                <%--</div>--%>
                <%--<div class="col-2">--%>
                    <%--<tags:text id="gpsPlateNum" value="${selfTrailer.gpsPlateNum}"  width="150"></tags:text>--%>
                <%--</div>--%>
                <div class="col-1">
                    <tags:label key="运力类型" required="true"/>
                </div>
                <div class="col-2">
                    <tags:singleselect id="trailerBelongType" onchange="changeBelongType()" value="${selfTrailer.trailerBelongType}" localData="${fns:getOptionList('getDownList','TRAILER_BELONG_TYPE')}" width="150"/>
                </div>
                <div class="col-1">
                    <label><tags:label key="当前司机"/></label>
                </div>
                <div class="col-2">
                    <tags:singleselect id="currentDrvCode" value="${selfTrailer.currentDrvCode}"
                                       localData="${fns:getOptionList('getInnerDriverName','')}" width="150">
                    </tags:singleselect>
                </div>
                <div class="col-1">
                    <label><tags:label key="关系人/车队"/></label>
                </div>
                <div class="col-2">
                    <tags:singleselect id="relatedDrvCode" value="${selfTrailer.relatedDrvCode}"
                                       localData="${fns:getOptionList('getRelatedCompysByType','PDL,ADL')}" width="150" readonly="true">
                    </tags:singleselect>
                </div>
            </div>
            <br>
            <div class="row cl">
                <div class="col-1">
                    <tags:label key="GPS车牌号"/>
                </div>
                <div class="col-2">
                    <tags:text id="gpsPlateNum" value="${selfTrailer.gpsPlateNum}"  width="150"></tags:text>
                </div>
                <div class="col-1">
                    <label><tags:label key="生产年份"/></label>
                </div>
                <div class="col-2">
                    <tags:date formmat="yyyy" id="productionYear" value="${selfTrailer.productionYear}" width="150" />
                </div>
                <div class="col-1">
                    <tags:label key="车龄"/>
                </div>
                <div class="col-2">
                    <tags:text id="age" value="${selfTrailer.age}" width="150" cssStyle="text-align:right" onblur="numberCheck(this)"></tags:text>
                </div>
                <div class="col-1">
                    <tags:label key="车辆识别码"/>
                </div>
                <div class="col-2">
                    <tags:text id="identityNo" value="${selfTrailer.identityNo}" width="150"></tags:text>
                </div>
            </div>
            <br>
            <%--<div class="row cl">--%>
                <%--<div class="col-1">--%>
                    <%--<tags:label key="车辆位置描述"/>--%>
                <%--</div>--%>
                <%--<div class="col-2">--%>
                    <%--<tags:text id="curStopCode" value="${selfTrailer.curStopCode}" width="150"></tags:text>--%>
                <%--</div>--%>
                <%--<div class="col-1">--%>
                    <%--<tags:label key="车辆详细位置"/>--%>
                <%--</div>--%>
                <%--<div class="col-2">--%>
                    <%--<tags:text id="curStopFaddrs" value="${selfTrailer.curStopFaddrs}" width="150"></tags:text>--%>
                <%--</div>--%>
                <%--<div class="col-1">--%>
                    <%--<tags:label key="油箱容量"/>--%>
                <%--</div>--%>
                <%--<div class="col-2">--%>
                    <%--<tags:text id="tankLiters" value="${selfTrailer.tankLiters}" width="150" cssStyle="text-align:right" onblur="numberCheck(this)"></tags:text>升--%>
                <%--</div>--%>
                <%--<div class="col-1">--%>
                    <%--<tags:label key="设备分组"/>--%>
                <%--</div>--%>
                <%--<div class="col-2">--%>
                    <%--<tags:text id="eqmGroupCode" value="${selfTrailer.eqmGroupCode}" width="150"></tags:text>--%>
                <%--</div>--%>
            <%--</div>--%>
            <%--<br>--%>
            <div class="row cl">
                <div class="col-1">
                    <tags:label key="车辆类型"/>
                </div>
                <div class="col-2">
                    <tags:singleselect id="trailerType" value="${selfTrailer.trailerType}" localData="${fns:getOptionList('getTrailerType','')}" width="150"/>
                </div>
                <div class="col-1">
                    <tags:label key="最大载重量"/>
                </div>
                <div class="col-2">
                    <tags:text id="maxLoad" value="${selfTrailer.maxLoad}" width="150" cssStyle="text-align:right" onblur="numberCheck(this)"></tags:text>吨
                </div>
                <div class="col-1">
                    <tags:label key="燃油类型"/>
                </div>
                <div class="col-2">
                    <tags:singleselect id="fuelType" value="${selfTrailer.fuelType}" localData="${fns:getOptionList('getFuelType','')}" width="150"/>
                </div>
                <div class="col-1">
                    <tags:label key="所属公司"/>
                </div>
                <div class="col-2">
                    <tags:text id="compy" value="${selfTrailer.compy}" width="150"></tags:text>
                </div>
            </div>
            <br>
            <div class="row cl">
                <div class="col-1">
                    <tags:label key="有效标志"/>
                </div>
                <div class="col-2">
                    <tags:singleselect id="validFlag" value="${selfTrailer.validFlag}" localData="[{'text':'是','value':'Y'},{'text':'否','value':'N'}]" width="150"/>
                </div>
                <div class="col-1">
                    <tags:label key="报废日期"/>
                </div>
                <div class="col-2">
                    <tags:datetime formmat="yyyy-MM-dd" id="scrapTime" value="${selfTrailer.scrapTime}" width="150" />
                </div>
                <div class="col-1">
                    <tags:label key="购入日期"/>
                </div>
                <div class="col-2">
                    <tags:datetime formmat="yyyy-MM-dd" id="buyTime" value="${selfTrailer.buyTime}" width="150" />
                </div>
                <div class="col-1">
                    <tags:label key="车辆型号"/>
                </div>
                <div class="col-2">
                    <tags:text id="productModel" value="${selfTrailer.productModel}" width="150"></tags:text>
                </div>
            </div>
            <br>
            <%--<div class="row cl">--%>
                <%--<div class="col-1">--%>
                    <%--<tags:label key="发动机编号"/>--%>
                <%--</div>--%>
                <%--<div class="col-2">--%>
                    <%--<tags:text id="engineNo" value="${selfTrailer.engineNo}" width="150"></tags:text>--%>
                <%--</div>--%>
                <%--<div class="col-1">--%>
                    <%--<tags:label key="年检日期"/>--%>
                <%--</div>--%>
                <%--<div class="col-2">--%>
                    <%--<tags:datetime formmat="yyyy-MM-dd" id="yearInspectDate" value="${selfTrailer.yearInspectDate}" width="150" />--%>
                <%--</div>--%>
                <%--<div class="col-1">--%>
                    <%--<tags:label key="季度检日期"/>--%>
                <%--</div>--%>
                <%--<div class="col-2">--%>
                    <%--<tags:datetime formmat="yyyy-MM-dd" id="quarterlyInspectDate" value="${selfTrailer.quarterlyInspectDate}" width="150" />--%>
                <%--</div>--%>
                <%--<div class="col-1">--%>
                    <%--<tags:label key="营运检日期"/>--%>
                <%--</div>--%>
                <%--<div class="col-2">--%>
                    <%--<tags:datetime formmat="yyyy-MM-dd" id="businessInspectDate" value="${selfTrailer.businessInspectDate}" width="150" />--%>
                <%--</div>--%>
            <%--</div>--%>
            <%--<br>--%>
            <%--<div class="row cl">--%>
                <%--<div class="col-1">--%>
                    <%--<tags:label key="保险到期日"/>--%>
                <%--</div>--%>
                <%--<div class="col-2">--%>
                    <%--<tags:datetime formmat="yyyy-MM-dd" id="insuranceEndDate" value="${selfTrailer.insuranceEndDate}" width="150" />--%>
                <%--</div>--%>
                <%--<div class="col-1">--%>
                    <%--<tags:label key="路桥费到期日"/>--%>
                <%--</div>--%>
                <%--<div class="col-2">--%>
                    <%--<tags:datetime formmat="yyyy-MM-dd" id="luqiaoFeeEndDate" value="${selfTrailer.luqiaoFeeEndDate}" width="150" />--%>
                <%--</div>--%>
                <%--<div class="col-1">--%>
                    <%--<tags:label key="漳州标志" required="true"/>--%>
                <%--</div>--%>
                <%--<div class="col-2">--%>
                    <%--<tags:singleselect id="zhangzhouFlag" value="${selfTrailer.zhangzhouFlag}" localData="[{'text':'是','value':'Y'},{'text':'否','value':'N'}]" width="150"/>--%>
                <%--</div>--%>
                <%--<div class="col-1">--%>
                    <%--<tags:label key="调度分组" required="true"/>--%>
                <%--</div>--%>
                <%--<div class="col-2">--%>
                    <%--<tags:singleselect id="controlGroup" value="${selfTrailer.controlGroup}" localData="${fns:getOptionList('getDownList','CONTROL_GROUP')}" width="150"/>--%>
                <%--</div>--%>
            <%--</div>--%>
            <%--<br>--%>
            <div class="row cl">
                <div class="col-1">
                    <tags:label key="油箱容量"/>
                </div>
                <div class="col-2">
                    <tags:text id="tankLiters" value="${selfTrailer.tankLiters}" width="150" cssStyle="text-align:right" onblur="numberCheck(this)"></tags:text>升
                </div>
                <div class="col-1">
                    <tags:label key="轮轴类型"/>
                </div>
                <div class="col-2">
                    <tags:singleselect id="tWheelType" value="${selfTrailer.tWheelType}" localData="${fns:getOptionList('getTWheelType','')}" width="150"/>
                </div>
                <div class="col-1">
                    <tags:label key="发动机编号"/>
                </div>
                <div class="col-2">
                    <tags:text id="engineNo" value="${selfTrailer.engineNo}" width="150"></tags:text>
                </div>
                <div class="col-1">
                    <tags:label key="车架号"/>
                </div>
                <div class="col-2">
                    <tags:text id="currentCfNum" value="${selfTrailer.currentCfNum}" width="150" readonly="true"></tags:text>
                </div>
            </div>
            <br>
            <div class="row cl">
                <div class="col-1">
                    <tags:label key="百公里油耗"/>
                </div>
                <div class="col-2">
                    <tags:text id="liters" value="${selfTrailer.liters}" width="150" ></tags:text>
                </div>
            </div>
            <br>
            <div class="row cl">
                <div class="col-1">
                    <tags:label key="备注"/>
                </div>
                <div class="col-11">
                    <tags:textarea id="remarks" value="${selfTrailer.remarks}" maxlength="200" cssStyle="width:42%"></tags:textarea>
                </div>
            </div>
        </form>
    </div>
</div>
</body>
</html>