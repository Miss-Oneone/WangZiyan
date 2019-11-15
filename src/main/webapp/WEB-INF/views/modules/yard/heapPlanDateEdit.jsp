
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <meta name="decorator" content="default"/>
    <%@ include file="/WEB-INF/views/modules/yard/heapPlanDateEditJs.jsp"%>
    <style type="text/css">

    </style>
</head>
<body>
<!-- 挡板效果 -->
<div id="over" class="over"></div>
<div id="layout" class="layout"><img src="${ctx}/static/sunsail/images/loading_072.gif" /></div>
<!-- 挡板效果 -->
<div class="content-button">
    <input id="updatePlanDate" class="btn btn-warning" type="button" value="保存" style="${hide}">
</div>
<div id="selectCondition">
    <div class="content-head">
        <form id="searchForm"  method="post" action="">
            <tags:hidden id="heapPlanIds" value="${heapPlanIds}"></tags:hidden>
            <div class="row cl">
                <div class="col-3">
                    <tags:label key="计划日期" />
                </div>
                <div class="col-9">
                    <tags:date id="planDate" name="planDate" width="120"/>
                </div>
            </div>
        </form>
    </div>
</div>
</body>
</html>
