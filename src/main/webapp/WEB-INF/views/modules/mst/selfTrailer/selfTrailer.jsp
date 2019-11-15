<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <meta name="decorator" content="default"/>
    <%@ include file="/WEB-INF/views/modules/mst/selfTrailer/selfTrailerJs.jsp" %>
</head>
<body>
<!-- 挡板效果 -->
<div id="over" class="over"></div>
<div id="layout" class="layout"><img src="${ctx}/static/sunsail/images/loading_072.gif"/></div>
<!-- 挡板效果 -->
<div class="content-button">
    <!-- 新建 -->
    <input id="build" type="button" class="btn btn-primary" value="新建" />
    <!-- 编辑 -->
    <input id="edit" type="button" class="btn btn-primary" value="编辑" />
    <!-- 删除 -->
    <input id="delete" type="button" class="btn btn-danger" value="删除" />
    <!-- 导出 -->
    <input id="export" type="button" class="btn btn-primary" value="导出Excel"/>
    <b id="condition" isOpen="true" style="font-size: 20px; float: right; margin-right: 15px; cursor: pointer">-</b>
    <!-- 查询 -->
    <input id="search" type="button" class="btn btn-secondary"
           value="<fmt:message key="btn_query"/>"
           style="float: right; margin-right: 15px;"/>
</div>
<div id="selectCondition">
    <form id="searchForm" method="post" action="${ctxZG}/selfTrailer">
        <div class="content-head">
            <div class="row cl">
                <div class="col-1">
                    <tags:label key="车牌号"/>
                </div>
                <div class="col-2">
                    <tags:singleselect id="plateNum" value="${plateNum}"
                                       localData="${fns:getOptionList('getTruckPlateNo','')}" width="180"/>
                    <img id="refreshImg" src="${ctxStatic}/sunsail/images/refresh.png" width="24" height="24" onclick="plateNumRefresh()" style="cursor:pointer;"/>
                </div>
                <div class="col-1">
                    <tags:label key="运力类型"/>
                </div>
                <div class="col-2">
                    <tags:singleselect id="trailerBelongType" value="${trailerBelongType}"
                                       localData="${fns:getOptionList('getDownList','TRAILER_BELONG_TYPE')}"/>
                </div>
                <div class="col-1">
                    <tags:label key="车辆识别码" />
                </div>
                <div class="col-2">
                    <tags:text id="identityNo"></tags:text>
                </div>
                <div class="col-1">
                    <tags:label key="车架号" />
                </div>
                <div class="col-2">
                    <tags:text id="currentCfNum"></tags:text>
                </div>
            </div>
            <div class="row cl">
                <div class="col-1">
                    <tags:label key="轮轴类型"/>
                </div>
                <div class="col-2">
                    <tags:singleselect id="tWheelType" value="${tWheelType}"
                                       localData="${fns:getOptionList('getTWheelType','')}"/>
                </div>
                <div class="col-1">
                    <tags:label key="有效标志"/>
                </div>
                <div class="col-2">
                    <tags:singleselect id="validFlag" value="Y" localData="[{'text':'是','value':'Y'},{'text':'否','value':'N'}]" />
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