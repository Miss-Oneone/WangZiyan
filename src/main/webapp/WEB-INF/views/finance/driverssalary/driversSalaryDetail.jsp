<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <meta name="decorator" content="default" />
    <%@ include file="/WEB-INF/views/finance/driverssalary/driversSalaryDetailJs.jsp"%>
</head>
<body>
<!-- 挡板效果 -->
<div id="over" class="over"></div>
<div id="layout" class="layout"><img src="${ctx}/static/sunsail/images/loading_072.gif" /></div>
<!-- 挡板效果 -->
<div class="content-button"  id="divSearch">
</div>
<div id="selectCondition">
    <div class="content-head">
        <form id="searchForm" method="post" action="${ctxZG}/driversSalaryDetail">
            <tags:hidden id="driverCode" value="${driverCode}" />
            <tags:hidden id="salaryMonth" value="${salaryMonth}" />
        </form>
    </div>
</div>
<div class="ui-layout-center">
    <table id="mainTable" class="ui-pg-table"></table>
    <div id="mainPager"></div>
</div>
</body>
</html>