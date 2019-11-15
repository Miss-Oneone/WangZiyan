<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <meta name="decorator" content="default"/>
    <%@ include file="/WEB-INF/views/modules/mst/pricecontract/priceContractDetailJs.jsp" %>
    <style type="text/css">
    </style>
</head>
<body>
<!-- 挡板效果 -->
<div id="over" class="over"></div>
<div id="layout" class="layout"><img src="${ctx}/static/sunsail/images/loading_072.gif" /></div>
<!-- 挡板效果 -->
<div class="content-button" id="divOperate" style="${DisplayNoneOperate}">
    <input id="return" class="btn btn-primary size-M" type="button" value="返回"/>
    <input id="save" class="btn btn-warning size-M" type="button" value="保存"/>
</div>
<div style="padding-left: 20px;padding-top: 2px">
    <form id="addFrom" class="form-horizontal">
        <tags:hidden id="pageType" value="${pageType}"/>
        <tags:hidden id="priceContractNo" value="${mstPriceContractModel.priceContractNo}"/>
        <div style="margin-left: 45px">
            <div class="row cl">
                <div class="col-3">
                    <tags:label key="价格协议名称" required="true"/>
                </div>
                <div class="col-6">
                    <tags:text id="contractName" name="contractName" value="${mstPriceContractModel.contractName}"/>
                </div>
            </div>
            <div class="row cl">
                <div class="col-3">
                    <tags:label key="有效标志" required="true"/>
                </div>
                <div class="col-6">
                    <tags:singleselect id="validFlag" localData="${fns:getOptionList('getDownList','EFFECTIVE_STATUS')}"
                                       value="${mstPriceContractModel.validFlag}" width="100"/>
                </div>
            </div>
            <div class="row cl">
                <div class="col-3">
                    <tags:label key="协议有效开始日" required="true"/>
                </div>
                <div class="col-6">
                    <tags:date id="effectStartTime" width="120" name="effectStartTime" value="${mstPriceContractModel.effectStartTime}"/>
                </div>
            </div>
            <div class="row cl">
                <div class="col-3">
                    <tags:label key="协议有效结束日" required="true"/>
                </div>
                <div class="col-6">
                    <tags:date id="effectEndTime" width="120" name="effectEndTime" value="${mstPriceContractModel.effectEndTime}"/>
                </div>
            </div>
            <div class="row cl">
                <div class="col-3">
                    <tags:label key="结算类型" required="true"/>
                </div>
                <div class="col-6">
                    <tags:singleselect id="settlementType" localData="[{'text':'月结','value':'1'},{'text':'票结','value':'2'}]"
                                       value="${mstPriceContractModel.settlementType}" width="100"/>
                </div>
            </div>
            <div class="row cl">
                <div class="col-3">
                    <tags:label key="应到款天数"/>
                </div>
                <div class="col-6">
                    <tags:text id="settlementDays" name="settlementDays" value="${mstPriceContractModel.settlementDays}"/>
                </div>
            </div>
            <div class="row cl">
                <div class="col-3">
                    <tags:label key="备注" />
                </div>
                <div class="col-6">
                    <tags:text id="remarks" name="remarks" value="${mstPriceContractModel.remarks}"/>
                </div>
            </div>
        </div>
    </form>
</div>
</body>
</html>