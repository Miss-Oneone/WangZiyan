<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<script type="text/javascript">
    var driverCodeAll = "";
    var driverCodeAllArr;
    window.onload = function () {
        $("#salaryMonth").val($("#salaryMonth", parent.document).val());
        var ids = parent.$("#mainTable").jqGrid('getDataIDs');
        for (var i = 0; i < ids.length; i++) {
            var obj = parent.$("#mainTable").jqGrid('getRowData', ids[i]);
            driverCodeAll += "," + obj.driverCode;
        }
        if(!isBlank(driverCodeAll)) {
            driverCodeAll = driverCodeAll.substr(1);
            driverCodeAllArr = driverCodeAll.split(",");
        }
    }
    $(document).ready(function () {
        //保存
        $("#save").click(function () {
            if(!checkAmount()){
                return;
            }
            doSave();
        });

        $("#leaveDays").keyup(function () {
            clearNoNum(this);
            var leaveDays = $("#leaveDays").val();
            var addDutyRewardAmount = "${model.orgBaseSalaryAmount}";
            var salaryMonth = $("#salaryMonth").val();
            var days = new Date(salaryMonth.split("-")[0],salaryMonth.split("-")[1],0)
            var dayCount = days.getDate();
            if (isBlank(leaveDays) || leaveDays == 0) {
                $("#addDutyRewardAmount").val(300)
                $("#baseSalaryAmount").val(addDutyRewardAmount)
            }
            if (leaveDays == 1) {
                $("#addDutyRewardAmount").val(0)
                $("#baseSalaryAmount").val(addDutyRewardAmount)
            }
            if (leaveDays > 1) {
                var reduceAddDutyRewardAmount = addDutyRewardAmount * (dayCount - (leaveDays - 2)) / dayCount
                $("#addDutyRewardAmount").val(0)
                $("#baseSalaryAmount").val(reduceAddDutyRewardAmount.toFixed(2));
            }
        });
        $("#addOtherAmount").keyup(function () {
            clearNoNum(this);
        });
        $("#deductSsAmount").keyup(function () {
            clearNoNum(this);
        });
        $("#deductRiskAmount").keyup(function () {
            clearNoNum(this);
        });
        $("#deductLoanAmount").keyup(function () {
            clearNoNum(this);
        });
        $("#deductTaxAmount").keyup(function () {
            clearNoNum(this);
        });
        $("#deductOtherAmount").keyup(function () {
            clearNoNum(this);
        });
        $("#baseSubsidy").keyup(function () {
            clearNoNum(this);
        });

        //取消
        $("#cancel").click(function () {
            parent.layer.closeAll();
        });

        //上一条
        $("#preOne").click(function () {
            var driverCode = $("#driverCode").val();
            var nextDriverCode = driverCodeAllArr.indexOf(driverCode);
            if (nextDriverCode == 0) {
                showError("当前是第一条！");
                return;
            }
            driverCode = driverCodeAllArr[nextDriverCode - 1];

            findDriverAddtionInfo(driverCode);
        });

        //下一条
        $("#nextOne").click(function () {
            var driverCode = $("#driverCode").val();
            var nextDriverCode = driverCodeAllArr.indexOf(driverCode);
            if (driverCodeAllArr.length < nextDriverCode + 2) {
                showError("没有下一条了！");
                return;
            }
            driverCode = driverCodeAllArr[nextDriverCode + 1];

            findDriverAddtionInfo(driverCode);
        });
    });
    function checkAmount() {
        var leaveDays = $("#leaveDays").val();
        var baseSalaryAmount = $("#baseSalaryAmount").val();
        var addDutyRewardAmount = $("#addDutyRewardAmount").val();
        var addOtherAmount = $("#addOtherAmount").val();
        var deductSsAmount = $("#deductSsAmount").val();
        var deductRiskAmount = $("#deductRiskAmount").val();
        var deductLoanAmount = $("#deductLoanAmount").val();
        var deductTaxAmount = $("#deductTaxAmount").val();
        var deductOtherAmount = $("#deductOtherAmount").val();
        var baseSubsidy = $("#baseSubsidy").val();
        var exp = /^(\-|\+)?(([1-9]\d*)|\d)(\.\d{1,2})?$/;
        <%--if(Number("${model.orgBaseSalaryAmount}") == 0) {--%>
            <%--showError("该司机底薪为0，请先确认底薪，再修改附加项！")--%>
            <%--return false;--%>
        <%--}--%>
        if (isBlank(leaveDays)) {
            $("#leaveDays").val(0.00);
        } else {
            if (!Number.isInteger(Number(leaveDays)) || Number(leaveDays)<0) {
                showError("【请假天数】格式不正确，请重新输入！")
                return false;
            }
        }
        if (isBlank(baseSalaryAmount)) {
            $("#baseSalaryAmount").val(0.00);
        } else {
            if (!exp.test(baseSalaryAmount)) {
                showError("【底薪】格式不正确，请重新输入！")
                return false;
            }
        }
        if (isBlank(addDutyRewardAmount)) {
            $("#addDutyRewardAmount").val(0.00);
        } else {
            if (!exp.test(addDutyRewardAmount)) {
                showError("【满勤奖】格式不正确，请重新输入！")
                return false;
            }
        }
        if (isBlank(addOtherAmount)) {
            $("#addOtherAmount").val(0.00);
        } else {
            if (!exp.test(addOtherAmount)) {
                showError("【其它】格式不正确，请重新输入！")
                return false;
            }
        }
        if (isBlank(deductSsAmount)) {
            $("#deductSsAmount").val(0.00);
        } else {
            if (!exp.test(deductSsAmount)) {
                showError("【扣-社保】格式不正确，请重新输入！")
                return false;
            }
        }
        if (isBlank(deductRiskAmount)) {
            $("#deductRiskAmount").val(0.00);
        } else {
            if (!exp.test(deductRiskAmount)) {
                showError("【扣-风险金】格式不正确，请重新输入！")
                return false;
            }
        }
        if (isBlank(deductLoanAmount)) {
            $("#deductLoanAmount").val(0.00);
        } else {
            if (!exp.test(deductLoanAmount)) {
                showError("【扣-借款】格式不正确，请重新输入！")
                return false;
            }
        }
        if (isBlank(deductTaxAmount)) {
            $("#deductTaxAmount").val(0.00);
        } else {
            if (!exp.test(deductTaxAmount)) {
                showError("【扣-个税】格式不正确，请重新输入！")
                return false;
            }
        }
        if (isBlank(deductOtherAmount)) {
            $("#deductOtherAmount").val(0.00);
        } else {
            if (!exp.test(deductOtherAmount)) {
                showError("【扣-其他】格式不正确，请重新输入！")
                return false;
            }
        }

        if (isBlank(baseSubsidy)) {
            $("#baseSubsidy").val(0.00);
        } else {
            if (!exp.test(baseSubsidy)) {
                showError("【基础补贴】格式不正确，请重新输入！")
                return false;
            }
        }
        return true;
    }

    function findDriverAddtionInfo(driverCode) {
        openLoading();
        $.ajax({
            type: "post",
            url: "${ctxZG}/driversSalary/findDriverAddtionInfo",
            data: {"driverCode":driverCode,"salaryMonth":$("#salaryMonth").val()},
            success: function (data) {
                closeLoading();
                obj = JSON.parse(data);
                var result = obj.dataModel;
                if (obj.resultType == '1') {
                   $("#leaveDays").val(result.leaveDays);
                   $("#orgBaseSalaryAmount").val(result.orgBaseSalaryAmount);
                   $("#baseSalaryAmount").val(result.baseSalaryAmount);
                   $("#addDutyRewardAmount").val(result.addDutyRewardAmount);
                   $("#addOtherAmount").val(result.addOtherAmount);
                   $("#deductSsAmount").val(result.deductSsAmount);
                   $("#deductRiskAmount").val(result.deductRiskAmount);
                   $("#deductLoanAmount").val(result.deductLoanAmount);
                   $("#deductTaxAmount").val(result.deductTaxAmount);
                   $("#deductOtherAmount").val(result.deductOtherAmount);
                   $("#driverCode").val(result.driverCode);
                   $("#driverName").val(result.driverName);
                   $("#baseSubsidy").val(result.baseSubsidy);
                } else {
                    showError(obj.resultMsg);
                }
            },
            error: function () {
                showError("操作失败!");
            }
        });

    }

    function doSave() {
        openLoading();
        $.ajax({
            type: "post",
            url: "${ctxZG}/driversSalary/saveOrUpdateDriverSalaryAmount",
            data: $("#searchForm").serialize(),
            success: function (data) {
                closeLoading();
                obj = JSON.parse(data);
                if (obj.resultType == '1') {
                    showTip("操作成功");
                    parent.doSearch();
                } else {
                    showError(obj.resultMsg);
                }
            },
            error: function () {
                showError("操作失败!");
            }
        });

    }

    function getStr(ids, para) {
        var temp = '';
        var tempStr = '';
        for (var i = 0; i < ids.length; i++) {
            temp = $("#mainTable").getCell(ids[i], para);
            tempStr += "," + temp
        }
        tempStr = tempStr.substring(1);
        return tempStr;
    }

    function closeLayerFirm() {
        var i = layer.confirm();
        layer.close(i);
    }

    <!--utils-->
    //非空判断
    function isBlank(obj) {
        return (!obj || $.trim(obj) == "");
    }

    function formatMoney(number, places, symbol, thousand, decimal) {
        number = number || 0;
        places = !isNaN(places = Math.abs(places)) ? places : 2;
        symbol = symbol !== undefined ? symbol : "$";
        thousand = thousand || ",";
        decimal = decimal || ".";
        var negative = number < 0 ? "-" : "",
            i = parseInt(number = Math.abs(+number || 0).toFixed(places), 10) + "",
            j = (j = i.length) > 3 ? j % 3 : 0;
        return symbol + negative + (j ? i.substr(0, j) + thousand : "") + i.substr(j).replace(/(\d{3})(?=\d)/g, "$1" + thousand) + (places ? decimal + Math.abs(number - i).toFixed(places).slice(2) : "");
    }
</script>