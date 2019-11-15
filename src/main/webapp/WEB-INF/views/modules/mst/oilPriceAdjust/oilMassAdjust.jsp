<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <meta name="decorator" content="default"/>
    <%@ include file="/WEB-INF/views/modules/mst/oilPriceAdjust/oilMassAdjustJs.jsp" %>
</head>
<body>
<!-- 挡板效果 -->
<div id="over" class="over"></div>
<div id="layout" class="layout"><img src="${ctx}/static/sunsail/images/loading_072.gif"/></div>
<!-- 挡板效果 -->
<div class="content-button">
    <b id="condition" isOpen="true" style="font-size: 20px; float: right; margin-right: 15px; cursor: pointer">-</b>
    <!-- 新建 -->
    <input id="create" type="button" class="btn btn-primary" value="新建" />
    <!-- 编辑 -->
    <input id="edit" type="button" class="btn btn-primary" value="编辑" />
    <!-- 查询 -->
    <input id="search" type="button" class="btn btn-secondary"
           value="<fmt:message key="btn_query"/>"
           style="float: right; margin-right: 15px;"/>
</div>
<div id="selectCondition">
    <form id="searchForm" method="post" action="${ctxZG}/gpsKmAdjust">
        <div class="content-head">
            <tags:hidden id="id" value="${id}" />
            <!--司机姓名-->
            <div class="col-1">
                <label><tags:label key="司机姓名"/></label>
            </div>
            <div class="col-3">
                <tags:singleselect id="driverCode"
                                   localData="${fns:getOptionList('getDriverList','')}">
                </tags:singleselect>
            </div>
            <div class="row cl">
                <!--日期-->
                <div class="col-1">
                    <label><tags:label key="日期"/></label>
                </div>
                <div class="col-3">
                    <tags:date id="timeFrom" value="${timeFrom}" width="95"/>
                    -
                    <tags:date id="timeTo" value="${timeTo}" width="95"/>
                </div>
            </div>
        </div>
    </form>
</div>
<div class="ui-layout-center">
    <table id="mainTable" class="ui-pg-table"></table>
    <div id="mainPager"></div>
</div>
</body>

</html>