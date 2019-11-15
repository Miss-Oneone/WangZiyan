<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <meta name="decorator" content="default" />
    <%@ include file="/WEB-INF/views/finance/driverssalary/updateAmountFormJs.jsp"%>
</head>
<body>
<!-- 挡板效果 -->
<div id="over" class="over"></div>
<div id="layout" class="layout"><img src="${ctx}/static/sunsail/images/loading_072.gif" /></div>
<!-- 挡板效果 -->
<div id="selectCondition">
    <div class="content-head">
        <form id="searchForm"  method="post">
            <tags:hidden  id="driverCode" value="${model.driverCode}"/>
            <tags:hidden  id="orgBaseSalaryAmount" value="${model.orgBaseSalaryAmount}"/>
            <div class="content-button" id="divSearch">
                <!-- 上一条 -->
                <input id="preOne"  type="button" class="btn btn-primary" value="上一条"  />
                <!-- 下一条 -->
                <input id="nextOne"  type="button" class="btn btn-primary" value="下一条" />
                <!-- 保存 -->
                <input id="save"  type="button" class="btn btn-warning" value="保存" />
                <!-- 取消-->
                <input id="cancel"  type="button" class="btn btn-primary" value="取消" />
            </div>
            <div class="row cl">
                <!--司机姓名-->
                <div class="col-2">
                    <label><tags:label key="司机姓名" /></label>
                </div>
                <div class="col-2">
                    <tags:text id="driverName" value="${model.driverName}" width="200" readonly="true" />
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
                    <tags:text id="leaveDays" value="${model.leaveDays}" width="200" />
                </div>
                <!--底薪(元)-->
                <div class="col-2">
                    <label><tags:label key="底薪(元)" /></label>
                </div>
                <div class="col-2">
                    <tags:text id="baseSalaryAmount" value="${model.baseSalaryAmount}" width="200" readonly="true"/>
                </div>
            </div>
            <div class="row cl" style="display: none">
                <!--满勤奖(元)-->
                <div class="col-2">
                    <label><tags:label key="满勤奖(元)" /></label>
                </div>
                <div class="col-2">
                    <tags:text id="addDutyRewardAmount" value="${model.addDutyRewardAmount}" width="200" readonly="true"/>
                </div>
                <!--其他(元)-->
                <div class="col-2">
                    <label><tags:label key="其他(元)" /></label>
                </div>
                <div class="col-2">
                    <tags:text id="addOtherAmount" value="${model.addOtherAmount}" width="200" />
                </div>
            </div>
            <div class="row cl">
                <!--扣-社保(元)-->
                <div class="col-2">
                    <label><tags:label key="扣-社保(元)" /></label>
                </div>
                <div class="col-2">
                    <tags:text id="deductSsAmount" value="${model.deductSsAmount}" width="200" />
                </div>
                <%--<!--扣-风险金(元)-->--%>
                <div class="col-2"  style="display: none">
                    <label><tags:label key="扣-风险金(元)" /></label>
                </div>
                <div class="col-2"  style="display: none">
                    <tags:text id="deductRiskAmount" value="${model.deductRiskAmount}" width="200" />
                </div>
                <!--扣-个税(元)-->
                <div class="col-2">
                    <label><tags:label key="扣-个税(元)" /></label>
                </div>
                <div class="col-2">
                    <tags:text id="deductTaxAmount" value="${model.deductTaxAmount}" width="200" />
                </div>
            </div>
            <div class="row cl">
                <!--扣-借款(元)-->
                <div class="col-2">
                    <label><tags:label key="扣-借款(元)" /></label>
                </div>
                <div class="col-2">
                    <tags:text id="deductLoanAmount" value="${model.deductLoanAmount}" width="200" />
                </div>
                <!--扣-其他(元)-->
                <div class="col-2">
                    <label><tags:label key="扣-其他(元)" /></label>
                </div>
                <div class="col-2">
                    <tags:text id="deductOtherAmount" value="${model.deductOtherAmount}" width="200" />
                </div>
            </div>
            <div class="row cl">
                <!--基础补贴(元)-->
                <div class="col-2">
                    <label><tags:label key="基础补贴(元)" /></label>
                </div>
                <div class="col-2">
                    <tags:text id="baseSubsidy" value="${model.baseSubsidy}" width="200" />
                </div>
            </div>
            <%--<div class="row cl">--%>
                <%--<!--扣-其他(元)-->--%>
                <%--<div class="col-2">--%>
                    <%--<label><tags:label key="扣-其他(元)" /></label>--%>
                <%--</div>--%>
                <%--<div class="col-2">--%>
                    <%--<tags:text id="deductOtherAmount" value="${model.deductOtherAmount}" width="200" />--%>
                <%--</div>--%>
            <%--</div>--%>
        </form>
    </div>
</div>
</body>
</html>