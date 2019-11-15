<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <meta name="decorator" content="default"/>
    <%@ include file="/WEB-INF/views/modules/mst/pricecontract/priceContractCusDetailJs.jsp" %>
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
        <div style="margin-left: 45px">
            <div class="row cl">
                <div class="col-3">
                    <tags:label key="价格协议" required="true"/>
                </div>
                <div class="col-6">
                    <tags:singleselect id="priceContractNo" localData="${fns:getOptionList('getAllBFPriceContractNo','')}"
                                       value="${mstPriceContractCusModel.priceContractNo}" width="180" readonly="true"/>

                </div>
            </div>
            <div class="row cl">
                <div class="col-3">
                    <tags:label key="客户" required="true"/>
                </div>
                <div class="col-6">
                    <tags:singleselect id="cusCode" localData="${fns:getOptionList('getCusNameList','')}"
                                       value="${mstPriceContractCusModel.cusCode}" width="180"/>
                </div>
            </div>
        </div>
    </form>
</div>
</body>
</html>