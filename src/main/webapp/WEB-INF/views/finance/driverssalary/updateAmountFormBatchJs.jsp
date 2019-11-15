<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<script type="text/javascript">
    var data = new Array();
    window.onload = function () {
        $("#salaryMonth").val($("#salaryMonth", parent.document).val());
        var ids = parent.$("#mainTable").jqGrid('getGridParam', 'selarrrow');
        var driverName = ""
        for (var i = 0; i < ids.length; i++) {
            var id = ids[i];
            var obj = parent.$("#mainTable").jqGrid('getRowData', id);
            if(obj.binsApprovalFlag == 'C') {
                continue;
            }
            driverName += "," + obj.driverName;
        }
        $("#driverName").val(driverName.substring(1));
    };
    $(document).ready(function () {
        //保存
        $("#save").click(function () {
            if (!checkAmount()) {
                return;
            }
            var ids = parent.$("#mainTable").jqGrid('getGridParam', 'selarrrow');
            var data = new Array();
            for (var i = 0; i < ids.length; i++) {
                var id = ids[i];
                var obj = parent.$("#mainTable").jqGrid('getRowData', id);
                if(obj.binsApprovalFlag == 'C') {
                    continue;
                }
                data.push({
                    "driverCode": obj.driverCode
                    , "salaryMonth": $("#salaryMonth").val()
                });
            }
            doSave();
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
    });
    function checkAmount() {
        var deductSsAmount = $("#deductSsAmount").val();
        var exp = /^(\-|\+)?(([1-9]\d*)|\d)(\.\d{1,2})?$/;

        if (isBlank(deductSsAmount)) {
            showError("请输入社保金额！")
            return false;
        } else if (Number(deductSsAmount) == 0) {
            showError("扣-社保的金额不能为0！")
            return false;
        } else {
            if (!exp.test(deductSsAmount)) {
                showError("【扣-社保】格式不正确，请重新输入！")
                return false;
            }
        }
        return true;
    }
    function doSave() {
        var ids = parent.$("#mainTable").jqGrid('getGridParam', 'selarrrow');
        for (var i = 0; i < ids.length; i++) {
            var obj = parent.$("#mainTable").jqGrid('getRowData', ids[i]);
            if(obj.binsApprovalFlag == 'C') {
                continue;
            }
            data.push({
                "driverCode": obj.driverCode
                , "driverName": obj.driverName
                , "salaryMonth": $("#salaryMonth", parent.document).val()
                , "deductSsAmount": $("#deductSsAmount").val()
                , "baseSalaryAmount": (obj.baseSalaryAmount ? obj.baseSalaryAmount : '0.00')
                , "orgBaseSalaryAmount": (obj.orgBaseSalaryAmount ? obj.orgBaseSalaryAmount : '0.00')
                , "leaveDays": ($("#leaveDays").val() ? $("#leaveDays").val() : '0.00')
                , "addDutyRewardAmount": (obj.addDutyRewardAmount ? obj.addDutyRewardAmount : '0.00')
                , "addOtherAmount": (obj.addOtherAmount ? obj.addOtherAmount : '0.00')
                , "deductRiskAmount": (obj.deductRiskAmount ? obj.deductRiskAmount : '0.00')
                , "deductLoanAmount": (obj.deductLoanAmount ? obj.deductLoanAmount : '0.00')
                , "deductTaxAmount": (obj.deductTaxAmount ? obj.deductTaxAmount : '0.00')
                , "deductOtherAmount": (obj.deductOtherAmount ? obj.deductOtherAmount : '0.00')
                , "baseSubsidy": (obj.baseSubsidy ? obj.baseSubsidy : '0.00')
                , "id": ids[i]
            })
        }
        openLoading();
        $.ajax({
            type: "post",
            url: "${ctxZG}/driversSalary/saveOrUpdateDriverSalaryAmountBatch",
            data: {
                "data": JSON.stringify(data)
            },
            success: function (data) {
                closeLoading();
                obj = JSON.parse(data);
                if (obj.resultType == '1') {
                    parent.doSearch();
                    showTip("操作成功");
                    setTimeout(function () {
                        parent.layer.closeAll();
                    }, 1000)
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

</script>