
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <meta name="decorator" content="default"/>
    <%@ include file="/WEB-INF/views/modules/unDrvordList/cusContactHisJs.jsp"%>
    <style type="text/css">
        #mainTableContentOne{
            width:94%;
            margin-left:3%;
        }
        #mainTableContent{
            width:94%;
            margin-left:3%;
        }
        #divOperate{
            top: 0px;
            width: 100%;
            position: fixed;
            z-index: 999;
        }
        .ui-pager-control > .ui-pg-table > tbody > tr > td:first-child{
            width:auto !important;
        }
    </style>
</head>
<body>
<p class="clear-fix"></p>
<!-- 挡板效果 -->
<div class="content-button" id="divOperate" style="${DisplayNoneOperate}">
    <input id="return" class="btn btn-primary size-M" type="button" value="返回" />
    <input id="save" class="btn btn-warning size-M" type="button" value="保存" />
</div>
<div style="padding-left: 20px;padding-top: 44px" id="allDiv">
    <form id="addMassage" class="form-horizontal">
        <tags:text id="id" name="id" value="${id}" cssStyle="display:none;"/>
        <div class="row cl">
            <div class="col-4">
                <div class="row">
                    <div class="col-3">
                        <tags:label key="联系人" cssClass="clear-fix"/>
                    </div>
                    <div class="col-9">
                        <tags:text id="contact" name="contact" value="${model.contact}" readonly="true" width="150"></tags:text>
                    </div>
                </div>
            </div>
            <div class="col-8">
                <div class="row">
                    <div class="col-4">
                        <tags:label key="公司名称" cssClass="clear-fix"/>
                    </div>
                    <div class="col-8">
                        <tags:text id="companyNm" name="companyNm" value="${model.companyNm}" readonly="true" width="300"></tags:text>
                    </div>
                </div>
            </div>
        </div>
        <div class="row cl">
            <div class="col-12">
                <div class="row">
                    <div class="col-1">
                        <tags:label key="联系号码" cssClass="clear-fix"/>
                    </div>
                    <div class="col-3">
                        <tags:text id="contactTel1" name="contactTel1" width="150" onchange="checkTel(this)" cssStyle="text-align: right"></tags:text>
                    </div>
                    <div class="col-3">
                        <tags:text id="contactTel2" name="contactTel2" width="150" onchange="checkTel(this)" cssStyle="text-align: right"></tags:text>
                    </div>
                    <div class="col-3">
                        <tags:text id="contactTel3" name="contactTel3" width="150" onchange="checkTel(this)" cssStyle="text-align: right"></tags:text>
                    </div>
                </div>
            </div>
        </div><br>
        <HR color="#eee" size="2" width="98%"><br>
        <div class="row cl">
            <div class="col-3">
                <div class="row">
                    <div class="col-4">
                        <tags:label key="船名航次" cssClass="clear-fix"/>
                    </div>
                    <div class="col-8">
                        <tags:text id="shipVoyage" name="shipVoyage" readonly="true" width="120"></tags:text>
                    </div>
                </div>
            </div>
            <div class="col-3">
                <div class="row">
                    <div class="col-4">
                        <tags:label key="船期" cssClass="clear-fix"/>
                    </div>
                    <div class="col-8">
                        <tags:text id="shipDate" name="shipDate" readonly="true" width="120"></tags:text>
                    </div>
                </div>
            </div>
            <div class="col-3">
                <div class="row">
                    <div class="col-4">
                        <tags:label key="超期" cssClass="clear-fix"/>
                    </div>
                    <div class="col-8">
                        <tags:text id="overDays" name="overDays" readonly="true" width="120"></tags:text>
                    </div>
                </div>
            </div>
            <div class="col-3">
                <div class="row">
                    <div class="col-4">
                        <tags:label key="门点" cssClass="clear-fix"/>
                    </div>
                    <div class="col-8">
                        <tags:text id="doorPoint" name="doorPoint" readonly="true" width="120"></tags:text>
                    </div>
                </div>
            </div>
        </div>
        <div class="row cl">
            <div class="col-3">
                <div class="row">
                    <div class="col-4">
                        <tags:label key="码头" cssClass="clear-fix"/>
                    </div>
                    <div class="col-8">
                        <tags:text id="wharf" name="wharf" readonly="true" width="120"></tags:text>
                    </div>
                </div>
            </div>
            <div class="col-3">
                <div class="row">
                    <div class="col-4">
                        <tags:label key="品名" cssClass="clear-fix"/>
                    </div>
                    <div class="col-8">
                        <tags:text id="goodsNm" name="goodsNm" readonly="true" width="120"></tags:text>
                    </div>
                </div>
            </div>
            <div class="col-3">
                <div class="row">
                    <div class="col-4">
                        <tags:label key="类型" cssClass="clear-fix"/>
                    </div>
                    <div class="col-8">
                        <tags:text id="businessType" name="businessType" readonly="true" width="120"></tags:text>
                    </div>
                </div>
            </div>
            <div class="col-3">
                <div class="row">
                    <div class="col-4">
                        <tags:label key="箱型" cssClass="clear-fix"/>
                    </div>
                    <div class="col-8">
                        <tags:text id="contnType" name="contnType" readonly="true" width="120"></tags:text>
                    </div>
                </div>
            </div>
        </div>
    </form><br>
    <div id="contractGrid">
        <div class="ui-layout-center" id="mainTableContentOne">
            <table id="mainTable1" class="ui-pg-table"></table>
            <div id="mainPager1"></div>
        </div>
        <br><HR color="#eee" size="2" width="98%"><br>
        <div class="ui-layout-center" id="mainTableContent">
            <table id="mainTable2" class="ui-pg-table"></table>
            <div id="mainPager2"></div>
        </div>
        <br>
    </div>
</div>
</body>
</html>