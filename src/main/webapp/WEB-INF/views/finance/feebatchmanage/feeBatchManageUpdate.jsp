<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>

<html>
<head>
    <meta name="decorator" content="default"/>
    <%@ include file="/WEB-INF/views/finance/feebatchmanage/feeBatchManageUpdateJs.jsp" %>
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
    <tags:hidden id="amountFlag" value="1"/>
        <tags:hidden id="isPsdFlag" value="N"/>
    <div class="row cl" style="margin-bottom: 5px">
        <div class="col-4"><tags:label key="所选费用条数"/></div>
        <div class="col-4">
            <tags:text id="feeCnt" readonly="true"/>
        </div>
    </div>
    <div class="row cl" style="margin-bottom: 5px">
        <div class="col-4"><tags:label key="收付类型"/></div>
        <div class="col-4">
            <tags:text id="paymentTypeName" readonly="true"/>
        </div>
    </div>
    <div class="row cl" style="margin-bottom: 5px">
        <div class="col-4"><tags:label key="费用名称" /></div>
        <div class="col-4">
            <tags:textarea id="piName" name="piName" readonly="true"
                           cssStyleSecond="display:none" cssStyle="background-color:#eee"/>
        </div>
    </div>
    <div class="row cl" style="margin-bottom: 5px">
        <div class="col-4"><tags:label key="往来单位" /></div>
        <div class="col-4">
            <tags:textarea id="relatedCompy" name="relatedCompy" readonly="true"
                           cssStyleSecond="display:none" cssStyle="background-color:#eee"/>
        </div>
    </div>
    <div class="row cl" style="margin-bottom: 5px">
        <div class="col-4">
            <input id='addAmountCb' type='checkBox' name='addAmountCb' checked='true' style='margin-left:10px'>
            <tags:label key="每条修改(元)" />
        </div>
        <div class="col-4">
            <tags:text id="addAmount" name="addAmount"/>
        </div>
    </div>
    <div class="row cl" style="margin-bottom: 5px">
        <div class="col-4">
            <input id='amountCb' type='checkBox' name='amountCb' style='margin-left:10px'>
            <tags:label key="全部修改为(元)" />
        </div>
        <div class="col-4">
            <tags:text id="amount" name="amount" readonly="true"/>
        </div>
    </div>
    <div class="row cl" style="margin-bottom: 5px" id="psdDiv">
        <div class="col-4">
            <tags:label key="密码" />
        </div>
        <div class="col-4">
            <tags:text id="confirmPsd" name="confirmPsd" />
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