<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <meta name="decorator" content="default"/>
    <%@ include file="/WEB-INF/views/finance/feebatchmanage/feeBatchManageJs.jsp" %>
</head>
<body>
<!-- 挡板效果 -->
<div id="over" class="over"></div>
<div id="layout" class="layout"><img src="${ctx}/static/sunsail/images/loading_072.gif"/></div>
<div class="content-button">
    <input id="feeAdd" class="btn btn-primary" type="button" value="批量新增">
    <input id="feeUpdate" class="btn btn-primary" type="button" value="批量编辑">
    <input id="binsApproval" class="btn btn-warning" type="button" value="商务审核">
    <input id="binsUnApproval" class="btn btn-warning" type="button" value="商务反审核">
    <b id="condition" isOpen="true" style="font-size:20px;float: right;margin-right: 15px;cursor:pointer">-</b>
    <input id="search" class="btn btn-secondary" type="button" value="查询" style="float: right;margin-right: 15px;">
</div>
<div id="selectCondition">
    <div class="content-head">
        <tags:hidden id="orderNoStr"/>
        <tags:hidden id="orderNoCnt"/>
        <tags:hidden id="compyCodeStr"/>
        <tags:hidden id="feeCnt"/>
        <tags:hidden id="compyNameStr"/>
        <tags:hidden id="piNameStr"/>
        <tags:hidden id="paymentTypeNameStr"/>
        <tags:hidden id="paymentTypeStr"/>
        <tags:hidden id="feeIdStr"/>
        <form id="searchForm" onsubmit="return false;" method="post" class="form-horizontal">
            <div class="row cl">
                <!--拖箱时间-->
                <div class="col-1"><tags:label key="发车日期"></tags:label></div>
                <div class="col-3">
                    <tags:date id="drvordTimeFrom" value="${drvordTimeFrom}" width="95"/>
                    -
                    <tags:date id="drvordTimeTo" value="${drvordTimeTo}" width="95"/>
                </div>
                <!--往来单位-->
                <div class="col-1"><tags:label key="往来单位"></tags:label></div>
                <div class="col-3">
                    <tags:singleselect id="relatedCompyCode" value="${relatedCompyCode}"
                                       localData="${fns:getOptionList('getComList','')}">
                    </tags:singleselect>
                </div>
                <!--托运人-->
                <div class="col-1">
                    <label><tags:label key="客户"/></label>
                </div>
                <div class="col-3">
                    <tags:singleselect id="cusCode"
                                       localData="${fns:getOptionList('getComList','')}">
                    </tags:singleselect>
                </div>
            </div>

            <div class="row cl">
                <!--提单号-->
                <div class="col-1"><tags:label key="提单号"></tags:label></div>
                <div class="col-3">
                    <tags:text id="blNo"></tags:text>
                </div>
                <!--箱号-->
                <div class="col-1"><tags:label key="箱号"></tags:label></div>
                <div class="col-3">
                    <tags:text id="contnNo"></tags:text>
                </div>
                <!--箱型-->
                <div class="col-1"><tags:label key="箱型"></tags:label></div>
                <div class="col-3">
                    <tags:singleselect id="containerType"
                                       localData="${fns:getOptionList('getDownList','CONTAINER_TYPE')}"/>
                </div>
            </div>
            <div class="row cl">
                <!--审核状态-->
                <div class="col-1"><tags:label key="审核状态"></tags:label></div>
                <div class="col-3">
                    <tags:checkboxs id="binsApprovalFlag" multiValue="N"
                                    cssStyle="word-wrap: break-word;word-break: break-all;white-space: pre-wrap !important;"
                                    localData="${fns:getOptionList('getDownList','BINS_APPROVAL_STATUS')}">
                    </tags:checkboxs>
                </div>
                <!--创建人-->
                <div class="col-1"><tags:label key="创建人"></tags:label></div>
                <div class="col-3">
                    <tags:singleselect id="createBy" value="${createBy}"
                                       localData="${fns:getOptionList('getCreatePsnList','')}">
                    </tags:singleselect>
                </div>
                <!--创建时间-->
                <div class="col-1"><tags:label key="创建时间"></tags:label></div>
                <div class="col-3">
                    <tags:date id="createTimeFrom" value="${createTimeFrom}" width="95"/>
                    -
                    <tags:date id="createTimeTo" value="${createTimeTo}" width="95"/>
                </div>
            </div>
            <div class="row cl">
                <!--费用状态-->
                <div class="col-1"><tags:label key="费用状态"></tags:label></div>
                <div class="col-3">
                    <tags:checkboxs id="feeStatus" multiValue="0,1"
                                    localData="${fns:getOptionList('getDownList','FEE_STATUS')}">
                    </tags:checkboxs>
                </div>
                <!--收付类型-->
                <div class="col-1"><tags:label key="收付类型"></tags:label></div>
                <div class="col-3">
                    <tags:singleselect id="paymentType"
                                       localData="${fns:getOptionList('getDownList','PAYMENT_TYPE')}">
                    </tags:singleselect>
                </div>
                <!--费用名称-->
                <div class="col-1"><tags:label key="费用名称"></tags:label></div>
                <div class="col-3">
                    <tags:singleselect id="piCode" name="piCode"
                                       localData="${fns:getOptionList('getPiNameList','')}">
                    </tags:singleselect>
                </div>
            </div>
            <div class="row cl">
                <!-- 金额-->
                <div class="col-1">
                    <label><tags:label key="金额"/></label>
                </div>
                <!-- 符号-->
                <div class="col-3">
                    <tags:singleselect id="sign" localData="${fns:getOptionList('getDownList','SIGN')}" required="true"
                                       width="85"/>
                    <tags:text id="amount" cssStyle="width:110px"/>
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