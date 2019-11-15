<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <meta name="decorator" content="default" />
    <%@ include file="/WEB-INF/views/finance/driverssalary/updateAmountFormBatchJs.jsp"%>
</head>
<body>
<!-- 挡板效果 -->
<div id="over" class="over"></div>
<div id="layout" class="layout"><img src="${ctx}/static/sunsail/images/loading_072.gif" /></div>
<!-- 挡板效果 -->
<div id="selectCondition">
    <div class="content-head">
        <form id="searchForm"  method="post" action="${ctxZG}/billManager">
            <tags:hidden  id="driverCode" value="${model.driverCode}"/>
            <div class="content-button" id="divSearch">
                <!-- 保存 -->
                <input id="save"  type="button" class="btn btn-warning" value="保存"  />
                <!-- 取消-->
                <input id="cancel"  type="button" class="btn btn-primary" value="取消"  />
            </div>
            <div class="row cl">
                <!--司机姓名-->
                <div class="col-2">
                    <label><tags:label key="司机姓名" /></label>
                </div>
                <div class="col-2">
                    <tags:textarea id="driverName"  cssStyleSecond="display:none" readonly="true" cssStyle="background-color:#eee"/>
                </div>
                <!--司机姓名-->
                <div class="col-2">
                    <label><tags:label key="月份" /></label>
                </div>
                <div class="col-2">
                    <tags:text id="salaryMonth" width="200" readonly="true" />
                </div>
            </div>
            <div class="row cl" style="display: none">
                <!--请假天数-->
                <div class="col-2">
                    <label><tags:label key="请假天数" /></label>
                </div>
                <div class="col-2">
                    <tags:text id="leaveDays" value="0" width="200" />
                </div>
                <!--底薪(元)-->
                <div class="col-2">
                    <label><tags:label key="底薪(元)" /></label>
                </div>
                <div class="col-2">
                    <tags:text id="baseSalaryAmount" value="0.00" width="200" readonly="true"/>
                </div>
            </div>
            <div class="row cl" style="display: none">
                <!--请假天数-->
                <div class="col-2">
                    <label><tags:label key="请假天数" /></label>
                </div>
                <div class="col-2">
                    <tags:text id="leaveDays" value="0" width="200" />
                </div>
                <!--底薪(元)-->
                <div class="col-2">
                    <label><tags:label key="底薪(元)" /></label>
                </div>
                <div class="col-2">
                    <tags:text id="baseSalaryAmount" value="0.00" width="200" readonly="true"/>
                </div>
            </div>
            <div class="row cl" style="display: none">
                <!--满勤奖(元)-->
                <div class="col-2">
                    <label><tags:label key="满勤奖(元)" /></label>
                </div>
                <div class="col-2">
                    <tags:text id="addDutyRewardAmount" value="0.00" width="200" readonly="true"/>
                </div>
                <!--其他(元)-->
                <div class="col-2">
                    <label><tags:label key="其他(元)" /></label>
                </div>
                <div class="col-2">
                    <tags:text id="addOtherAmount" value="0.00" width="200" />
                </div>
            </div>
            <div class="row cl">
                <!--扣-社保(元)-->
                <div class="col-2">
                    <label><tags:label key="扣-社保(元)" /></label>
                </div>
                <div class="col-2">
                    <tags:text id="deductSsAmount" value="0.00" width="200" />
                </div>
                <!--扣-风险金(元)-->
                <div class="col-2" style="display: none">
                    <label><tags:label key="扣-风险金(元)" /></label>
                </div>
                <div class="col-2" style="display: none">
                    <tags:text id="deductRiskAmount" value="0.00" width="200" />
                </div>
            </div>
            <div class="row cl" style="display: none">
                <!--扣-借款(元)-->
                <div class="col-2">
                    <label><tags:label key="扣-借款(元)" /></label>
                </div>
                <div class="col-2">
                    <tags:text id="deductLoanAmount" value="0.00" width="200" />
                </div>
                <!--扣-个税(元)-->
                <div class="col-2">
                    <label><tags:label key="扣-个税(元)" /></label>
                </div>
                <div class="col-2">
                    <tags:text id="deductTaxAmount" value="0.00" width="200" />
                </div>
            </div>
            <div class="row cl" style="display: none">
                <!--扣-其他(元)-->
                <div class="col-2">
                    <label><tags:label key="扣-其他(元)" /></label>
                </div>
                <div class="col-2">
                    <tags:text id="deductOtherAmount" value="0.00" width="200" />
                </div>
                <!--基础补贴(元)-->
                <div class="col-2">
                    <label><tags:label key="基础补贴(元)" /></label>
                </div>
                <div class="col-2">
                    <tags:text id="baseSubsidy" value="${model.baseSubsidy}" width="200" />
                </div>
            </div>
        </form>
    </div>
</div>
</body>
</html>