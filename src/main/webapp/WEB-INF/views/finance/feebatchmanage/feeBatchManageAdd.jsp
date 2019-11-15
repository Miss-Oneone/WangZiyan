<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>

<html>
<head>
    <meta name="decorator" content="default"/>
    <%@ include file="/WEB-INF/views/finance/feebatchmanage/feeBatchManageAddJs.jsp" %>
    <style type="text/css">
        .select2-results {
            max-height: 100px !important;
        }
    </style>
</head>
<body>
<!-- 挡板效果 -->
<div id="over" class="over"></div>
<div id="layout" class="layout"><img src="${ctx}/static/sunsail/images/loading_072.gif"/></div>
<form id="saveForm" class="form-horizontal">
    <tags:hidden id="orderNoStr"/>
    <div class="row cl" style="margin-bottom: 5px">
        <div class="col-4"><tags:label key="所选订单条数"/></div>
        <div class="col-4">
            <tags:text id="orderNoCnt" readonly="true"/>
        </div>
    </div>
    <div class="row cl" style="margin-bottom: 5px">
        <div class="col-4"><tags:label key="收付类型" required="true"/></div>
        <div class="col-4">
            <tags:singleselect id="paymentType"
                               localData="${fns:getOptionList('getDownList','PAYMENT_TYPE')}">
            </tags:singleselect>
        </div>
    </div>
    <div class="row cl" style="margin-bottom: 5px">
        <div class="col-4"><tags:label key="费用名称" required="true"/></div>
        <div class="col-4">
            <tags:singleselect id="piCode" name="piCode"
                               localData="${fns:getOptionList('getPiNameList','')}">
            </tags:singleselect>
        </div>
    </div>
    <div class="row cl" style="margin-bottom: 5px">
        <div class="col-4"><tags:label key="往来单位" required="true"/></div>
        <div class="col-4">
            <tags:singleselect id="relatedCompy" name="relatedCompy"
                               localData="${fns:getOptionList('getComListToOperateFee','')}">
            </tags:singleselect>
        </div>
    </div>
    <div class="row cl" style="margin-bottom: 5px">
        <div class="col-4"><tags:label key="金额(元)" required="true"/></div>
        <div class="col-4">
            <tags:text id="amount" name="amount"/>
        </div>
    </div>
    <div class="row cl" style="margin-bottom: 5px">
        <div class="col-4"><tags:label key="预计日期" required="true"/></div>
        <div class="col-4">
            <tags:date id="expDate" name="expDate" value="${nowDate}"/>
        </div>
    </div>
    <div class="row cl" style="margin-bottom: 5px">
        <div class="col-4"><tags:label key="备注"/></div>
        <div class="col-4">
            <tags:text id="remarks" name="remarks"/>
        </div>
    </div>
</form>
<br/>
<div class="text-center col-12">
    <div class="col-3">&nbsp</div>
    <div class="col-2" style="text-align: center;">
        <input id="save" class="btn btn-warning size-S" type="submit" value="确定"/>
    </div>
    <div class="col-1">&nbsp</div>
    <div class="col-2" style="text-align: center;">
        <input id="cancel" class="btn btn-primary size-S" type="button"
               value="取消"/>
    </div>
</div>
</body>
</html>