<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <meta name="decorator" content="default"/>
    <%@ include file="/WEB-INF/views/finance/feebatchmanage/feeBatchManageCheckSaveJs.jsp" %>
</head>
<body>
<!-- 挡板效果 -->
<div id="over" class="over"></div>
<div id="layout" class="layout"><img src="${ctx}/static/sunsail/images/loading_072.gif"/></div>
<div class="content-button">
    <input id="save" class="btn btn-warning" type="button" value="保存">
    <input id="cancel" class="btn btn-primary" type="button" value="取消">
</div>
<div id="selectCondition">
    <div class="content-head">
        <form id="searchForm" onsubmit="return false;" method="post" class="form-horizontal">
            <div class="row cl" style="margin-bottom: 5px">
                <div class="col-2"><tags:label key="新增费用"/></div>
                <div class="col-4">
                    <tags:text id="piName" readonly="true" width="120"/>
                </div>
                <div class="col-2"><tags:label key="金额"/></div>
                <div class="col-4">
                    <tags:text id="amount" readonly="true" width="120"/>
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