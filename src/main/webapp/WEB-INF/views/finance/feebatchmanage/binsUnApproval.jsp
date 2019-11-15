<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>

<html>
<head>
    <meta name="decorator" content="default"/>
    <%@ include file="/WEB-INF/views/finance/feebatchmanage/binsUnApprovalJs.jsp" %>
    <style type="text/css">
        .select2-results {
            max-height: 100px !important;
        }
    </style>
</head>
<body>
<div>&nbsp</div>
<form id="saveForm" class="form-horizontal">
    <tags:hidden id="isPsdFlag"/>
    <!-- 挡板效果 -->
    <div id="over" class="over"></div>
    <div id="layout" class="layout"><img src="${ctx}/static/sunsail/images/loading_072.gif"/></div>
    <div class="row cl" style="margin-bottom: 5px">
        <div class="col-2"><tags:label key="备注" required="true"/></div>
        <div class="col-4">
            <tags:text id="remark"/>
        </div>
    </div>
</form>
<br/>
<div class="text-center col-12">
    <div class="col-2">&nbsp</div>
    <div class="col-2" style="text-align: center;">
        <input id="save" class="btn btn-warning size-S" type="submit" value="保存"/>
    </div>
    <div class="col-2">&nbsp</div>
    <div class="col-2" style="text-align: center;">
        <input id="cancel" class="btn btn-danger size-S" type="button"
               value="取消"/>
    </div>
</div>
</body>
</html>