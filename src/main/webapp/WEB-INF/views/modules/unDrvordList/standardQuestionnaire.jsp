
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <meta name="decorator" content="default"/>
    <%@ include file="/WEB-INF/views/modules/unDrvordList/standardQuestionnaireJs.jsp"%>
    <style type="text/css">
        #divOperate{
            top: 0px;
            width: 100%;
            position: fixed;
            z-index: 999;
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
                    <div class="col-4">
                        <tags:label key="联系类型" cssClass="clear-fix" required="true"/>
                    </div>
                    <div class="col-8">
                        <tags:singleselect id="contactObj" name="contactObj" localData="[{'text':'我方联系','value':'0'},{'text':'对方联系','value':'1'}]" value="${contactObj}" width="100"></tags:singleselect>
                    </div>
                </div>
            </div>
            <div class="col-4">
                <div class="row">
                    <div class="col-4">
                        <tags:label key="联系时间" cssClass="clear-fix" required="true"/>
                    </div>
                    <div class="col-8">
                        <tags:date id="contactTime" name="contactTime" width="100" value="${contactTime}" ></tags:date>
                    </div>
                </div>
            </div>
            <div class="col-4">
                <div class="row">
                    <div class="col-4">
                        <tags:label key="联系结论" cssClass="clear-fix"/>
                    </div>
                    <div class="col-8">
                        <tags:singleselect id="contactResult" name="contactResult" localData="[{'text':'可执行','value':'0'},{'text':'等通知','value':'1'},{'text':'未接通','value':'2'}]" value="${contactResult}" width="100"></tags:singleselect>
                    </div>
                </div>
            </div>
        </div><br>
        <div class="row cl">
            <div class="col-4">
                <div class="row">
                    <div class="col-4">
                        <tags:label key="需求时间类型" cssClass="clear-fix"/>
                    </div>
                    <div class="col-8">
                        <tags:singleselect id="demandType" name="demandType" localData="[{'text':'具体时间','value':'0'},{'text':'无具体时间','value':'1'}]" value="${demandType}" width="100"></tags:singleselect>
                    </div>
                </div>
            </div>
            <div class="col-8">
                <div class="row">
                    <div class="col-2">
                        <label><tags:label key="备注"/></label>
                    </div>
                    <div class="col-10">
                        <tags:textarea id="remarks" value="${remarks}" maxlength="200" cssStyle="width:350px"/>
                    </div>
                </div>
            </div>
        </div><br>
        <HR color="#eee" size="2" width="98%"><br>
        <div class="row cl">
            <div class="col-4">
                <div class="row">
                    <div class="col-4">
                        <tags:label key="需求日期" cssClass="clear-fix"/>
                    </div>
                    <div class="col-8">
                        <tags:date id="demandTime" name="demandTime" width="100" value="${demandTime}" ></tags:date>
                    </div>
                </div>
            </div>
            <div class="col-4">
                <div class="row">
                    <div class="col-4">
                        <tags:label key="时间段" cssClass="clear-fix"/>
                    </div>
                    <div class="col-8">
                        <tags:singleselect id="demandTimeSlot" name="demandTimeSlot" localData="[{'text':'全天','value':'0'},{'text':'上午','value':'1'},{'text':'下午','value':'1'},{'text':'晚上','value':'1'}]" value="${demandTimeSlot}" width="100"></tags:singleselect>
                    </div>
                </div>
            </div>
            <div class="col-4">
                <div class="row">
                    <div class="col-4">
                        <tags:label key="指定到场" cssClass="clear-fix"/>
                    </div>
                    <div class="col-8">
                        <tags:date id="arrivalTime" name="arrivalTime" width="100" value="${arrivalTime}" ></tags:date>
                    </div>
                </div>
            </div>
        </div>
        <div class="row cl">
            <div class="col-4">
                <div class="row">
                    <div class="col-4">
                        <tags:label key="货是否准备好" cssClass="clear-fix"/>
                    </div>
                    <div class="col-8">
                        <tags:checkboxs id="goodsReady" name="goodsReady" localData="[{'text':'','value':'1'}]"></tags:checkboxs>
                    </div>
                </div>
            </div>
            <div class="col-4">
                <div class="row">
                    <div class="col-4">
                        <tags:label key="装卸方式" cssClass="clear-fix"/>
                    </div>
                    <div class="col-8">
                        <tags:singleselect id="zxType" name="zxType" localData="[{'text':'人工','value':'0'},{'text':'机械','value':'1'}]" value="${zxType}" width="100"></tags:singleselect>
                    </div>
                </div>
            </div>
            <div class="col-4">
                <div class="row">
                    <div class="col-4">
                        <tags:label key="装卸预计" cssClass="clear-fix"/>
                    </div>
                    <div class="col-8">
                        <tags:text id="zxUserTime" value="${zxUserTime}" maxlength="9" width="100" cssStyle="text-align: right"/><span>小时</span>
                    </div>
                </div>
            </div>
        </div><br>
        <HR color="#eee" size="2" width="98%"><br>
        <div class="row cl">
            <div class="col-4">
                <div class="row">
                    <div class="col-4">
                        <tags:label key="确认预排" cssClass="clear-fix"/>
                    </div>
                    <div class="col-8">
                        <tags:checkboxs id="expSendConfirmSign" name="expSendConfirmSign" localData="[{'text':'','value':'1'}]"></tags:checkboxs>
                    </div>
                </div>
            </div>
            <div class="col-4">
                <div class="row">
                    <div class="col-4">
                        <tags:label key="预排日期" cssClass="clear-fix"/>
                    </div>
                    <div class="col-8">
                        <tags:date id="expSendTime" name="expSendTime" width="100" value="${expSendTime}" ></tags:date>
                    </div>
                </div>
            </div>
        </div>
        <div class="row cl">
            <div class="col-8">
                <div class="row">
                    <div class="col-2">
                        <tags:label key="超期费承担方" cssClass="clear-fix"/>
                    </div>
                    <div class="col-10">
                        <tags:singleselect id="overdueFeePart" name="overdueFeePart" localData="[{'text':'我方','value':'0'},{'text':'对方','value':'1'}]" value="${overdueFeePart}" width="100"></tags:singleselect>
                        <span style="margin-left: 40px;color: red">注：超期天数>0的需要输入</span>
                    </div>
                </div>
            </div>
        </div>
    </form>
</div>
</body>
</html>