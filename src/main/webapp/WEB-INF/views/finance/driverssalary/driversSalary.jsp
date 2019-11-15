<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <meta name="decorator" content="default"/>
    <%@ include file="/WEB-INF/views/finance/driverssalary/driversSalaryJs.jsp" %>
    <style type="text/css">
        .confirmColor{
            background-color:rgb(193, 193, 193) !important;
        }
        #plateNumImg {
            top: 9px!important;
        }
    </style>
</head>
<body>
<!-- 挡板效果 -->
<div id="over" class="over"></div>
<div id="layout" class="layout"><img src="${ctx}/static/sunsail/images/loading_072.gif"/></div>
<!-- 挡板效果 -->
<div class="content-button">
    <!-- 导出 -->
    <input id="export" type="button" class="btn btn-primary" value="导出"/>
    <!-- 修改附加项 -->
    <input id="updateAmount"  type="button" class="btn btn-warning" value="修改附加项"  />
    <b id="condition" isOpen="true" style="font-size: 20px; float: right; margin-right: 15px; cursor: pointer">-</b>
    <!-- 查询 -->
    <input id="search" type="button" class="btn btn-secondary"
           value="<fmt:message key="btn_query"/>"
           style="float: right; margin-right: 15px;"/>
</div>
<div id="selectCondition">
    <form id="searchForm" method="post" action="${ctxZG}/driversSalary">
        <div class="content-head">
            <tags:hidden id="statusFlag" value="${statusCode}" />
            <tags:hidden id="gpsJobUpdateTime" value="${gpsJobUpdateTime}" />
            <tags:hidden id="searchTime" value="" />
            <div class="row cl">
                <!--发车日期-->
                <div class="col-1">
                    <label><tags:label key="工资年月"/></label>
                </div>
                <div class="col-3">
                    <tags:date formmat="yyyy-MM" id="salaryMonth" value="${salaryMonth}" width="95" />
                </div>
                <!--司机姓名-->
                <div class="col-1">
                    <label><tags:label key="司机姓名"/></label>
                </div>
                <div class="col-3">
                    <tags:singleselect id="driverCode"
                                       localData="${fns:getOptionList('getInnerDriverName','')}">
                    </tags:singleselect>
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