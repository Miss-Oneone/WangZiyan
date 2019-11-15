<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <meta name="decorator" content="default"/>
    <%@ include file="/WEB-INF/views/modules/mst/pricecontract/priceContractListJs.jsp" %>
    <style type="text/css">
        .a-info {
            color: blue !important;
        }

        #gbox_mainTable table th:nth-of-type(2),
        #gbox_mainTable table td:nth-of-type(2) {
            /*display: none;*/
        }

        #gbox_mainTable2 table th:nth-of-type(2),
        #gbox_mainTable2 table td:nth-of-type(2) {
            /*display: none;*/
        }
    </style>
</head>
<body>
<!-- 挡板效果 -->
<div id="over" class="over"></div>
<div id="layout" class="layout"><img src="${ctx}/static/sunsail/images/loading_072.gif"/></div>
<!-- 挡板效果 -->
<div class="content-button">
    <input id="export" class="btn btn-primary" type="button" value="导出" style="${hide}">
    <input id="add" class="btn btn-primary" type="button" value="新增" style="${displayNone}">
    <input id="edit" class="btn btn-primary" type="button" value="编辑" style="${displayNone}">
    <input id="copy" class="btn btn-primary" type="button" value="复制一条" style="${displayNone}">
    <input id="detail" class="btn btn-primary" type="button" value="运费明细" style="${displayNone}">
    <%--<input id="download" class="btn btn-primary" type="button" value="下载合同模板" style="${displayNone}">--%>
    <input id="delete" class="btn btn-danger" type="button" value="删除" style="${displayNone}">
    <b id="condition" isOpen="true" style="font-size:20px;float: right;margin-right: 15px;cursor:pointer">-</b>
    <input id="search" class="btn btn-secondary" type="button" value="查询" style="float: right;margin-right: 15px;">
</div>
<div id="selectCondition">
    <div class="content-head">
        <form id="searchForm" method="post" action="">
            <div class="row cl">
                <div class="col-1">
                    <tags:label key="协议名称"/>
                </div>
                <div class="col-3">
                    <tags:text id="contractName" value="${contractName}"/>
                </div>
                <div class="col-1">
                    <tags:label key="有效状态"/>
                </div>
                <div class="col-3">
                    <tags:singleselect id="effectiveStatus" value="Y"
                                       localData="${fns:getOptionList('getDownList','EFFECTIVE_STATUS')}"
                                       width="100"/>
                </div>
            </div>
        </form>
    </div>
</div>
<div class="ui-layout-center">
    <table id="mainTable" class="ui-pg-table"></table>
    <div id="mainPager"></div>
</div>

<div class="ui-layout-center">
    <table id="cusTable" class="ui-pg-table"></table>
    <div id="cusPager"></div>
</div>

<div class="content-button" style="${displayNone}">
    <input id="cusAdd" class="btn btn-primary" type="button" value="新增" >
    <input id="cusEdit" class="btn btn-primary" type="button" value="编辑" >
    <input id="cusCopy" class="btn btn-primary" type="button" value="复制一条" >
    <input id="cusDelete" class="btn btn-danger" type="button" value="删除">
</div>
</body>

</html>