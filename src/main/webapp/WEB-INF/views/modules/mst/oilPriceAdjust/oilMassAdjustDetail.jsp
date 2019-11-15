<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <meta name="decorator" content="default"/>
    <%@ include file="/WEB-INF/views/modules/mst/oilPriceAdjust/oilMassAdjustDetailJs.jsp" %>
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
        <form id="searchForm" method="post" action="${ctxZG}/gpsKmAdjust">
            <tags:hidden id="id" value="${oilMassModel.id}"/>
            <div class="row cl">
                <!-- 司机姓名 -->
                <div class="col-1">
                    <label><tags:label key="司机姓名" required="true"/></label>
                </div>
                <div class="col-3">
                    <tags:singleselect id="driverCode" value="${oilMassModel.driverCode}"
                                       localData="${fns:getOptionList('getDriverList','')}">
                    </tags:singleselect>
                </div>
                <!--车牌号-->
                <div class="col-1">
                    <label><tags:label key="车牌号"/></label>
                </div>
                <div class="col-3">
                    <tags:singleselect id="plateNum" value="${oilMassModel.plateNum}"
                                       localData="${fns:getOptionList('getTruckPlateNo','')}">
                    </tags:singleselect>
                </div>
                <!--日期-->
                <div class="col-1">
                    <label><tags:label key="补油日期" required="true"/></label>
                </div>
                <div class="col-3">
                    <tags:date id="time" value="${oilMassModel.time}" width="150"/>
                </div>
            </div>
            <br>
            <div class="row cl">
                <!-- 补油量(升) -->
                <div class="col-1">
                    <label><tags:label key="补油量(升)" required="true"/></label>
                </div>
                <div class="col-3">
                    <tags:text id="oilMass" value="${oilMassModel.oilMass}" maxlength="10" cssStyle="text-align: right;" onblur="clearNoNum(this)"/>
                </div>
                <!-- 校正备注 -->
                <div class="col-1">
                    <label><tags:label key="备注"/></label>
                </div>
                <div class="col-3">
                    <tags:textarea id="remark" value="${oilMassModel.remark}" maxlength="200"/>
                </div>
            </div>
        </form>
    </div>
</div>
</body>
</html>