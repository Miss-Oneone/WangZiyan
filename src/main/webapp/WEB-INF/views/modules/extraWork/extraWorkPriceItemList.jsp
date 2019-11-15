<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <meta name="decorator" content="default"/>
    <%@ include file="/WEB-INF/views/modules/extraWork/extraWorkPriceItemListJs.jsp"%>
    <style type="text/css">

    </style>
</head>
<body>
<!-- 挡板效果 -->
<div id="over" class="over"></div>
<div id="layout" class="layout"><img src="${ctx}/static/sunsail/images/loading_072.gif" /></div>
<!-- 挡板效果 -->
<div class="content-button">
    <input id="back" class="btn btn-primary" type="button" value="返回">
</div>
<div id="selectCondition">
    <div class="content-head">
        <form id="searchForm"  method="post" action="">

        </form>
    </div>
</div>
<div>
    <div class="ui-layout-center table-col-3">
        <table id="mainTable" class="ui-pg-table"></table>
        <div id="mainPager"></div>
    </div>
</div>
</body>
</html>
