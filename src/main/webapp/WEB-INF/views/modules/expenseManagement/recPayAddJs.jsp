<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<script type="text/javascript">
    $(document).ready(function () {
        if ('${actionType}' == "recUpdate" || '${actionType}' == "payUpdate") {
            document.getElementById("saveAndNext").style.display = "none";
            document.getElementById("temporaryAndNext").style.display = "none";
            $('#amount').val(Number('${recPay.amount}').toFixed(2));
        }

        $("#temporary").click(function () {
            reg = /^\-?([1-9][\d]{0,7}|0)(\.[\d]{1,2})?$/;

            if ($("#feeStatue").val() == '1' && $("#binsApprovalFlag").val() == 'Y') {
                showError("该笔费用已开始对账或已审核，不能恢复为暂存费用！");
                return false;
            }

            var amount = $("#amount").val();
            if (isBlank($("#piCode").val())) {
                showError("请选择【价目】！");
            } else if (isBlank($("#compyCode").val())) {
                showError("请选择【付款单位】！");
            } else if (isBlank(amount)) {
                showError("请填写【应收金额】！");
            } else if (!reg.test(amount)) {
                showError("请输入正确金额！");
            } else if (isBlank($("#expDate").val())) {
                showError("请填写【预计日期】！");
            } else if (parseFloat(amount) == 0 && isBlank($("#remarks").val())) {
                showError("应收金额为0，请填写【备注】！");
            } else {
                var index = layer.confirm("您确定要保存这些数据吗？", {
                    btn: ['确定', '取消'], //按钮
                    icon: 7
                }, function () {
                    layer.close(index);
                    var ajaxUrl = "${ctx}/finance/expense/saveRecPay";
                    $.ajax({
                        url: ajaxUrl,
                        data: {
                              recPayId: $('#recPayId').val()
                            , paymentType:$('#paymentType').val()
                            , feeType:$('#feeType').val()
                            , orderNo: $('#orderNo').val()
                            , piCode: $('#piCode').val()
                            , piName: $("#s2id_piCode"+" "+".select2-chosen").text()
                            , compyCode: $("#compyCode").val()
                            , amount: $("#amount").val()
                            , expDate: $("#expDate").val()
                            , remarks: $("#remarks").val()
                            , feeStatus: '0'
                        },
                        type: "post",
                        dataType: "text",
                        async: false,
                        success: function (data) {
                            if (data == "true") {
                                showTip("保存成功");
                                window.parent.findReceivable();
                                window.parent.findPayable();
                                window.parent.closeLayer();
                            } else {
                                showError("<fmt:message key='expenseManagement.error'/>");
                            }
                        }
                    });
                })
            }
        });

        $("#save").click(function () {
            reg = /^\-?([1-9][\d]{0,7}|0)(\.[\d]{1,2})?$/;

            var amount = $("#amount").val();
            if (isBlank($("#piCode").val())) {
                showError("请选择【价目】！");
            } else if (isBlank($("#compyCode").val())) {
                showError("请选择【付款单位】！");
            } else if (isBlank(amount)) {
                showError("请填写【应收金额】！");
            } else if (!reg.test(amount)) {
                showError("请输入正确金额！");
            } else if (isBlank($("#expDate").val())) {
                showError("请填写【预计日期】！");
            } else if (parseFloat(amount) == 0 && isBlank($("#remarks").val())) {
                showError("应收金额为0，请填写【备注】！");
            } else {
                var index = layer.confirm("您确定要保存这些数据吗？", {
                    btn: ['确定', '取消'], //按钮
                    icon: 7
                }, function () {
                    layer.close(index);
                    var ajaxUrl = "${ctx}/finance/expense/saveRecPay";
                    $.ajax({
                        url: ajaxUrl,
                        data: {
                            recPayId: $('#recPayId').val()
                            , paymentType:$('#paymentType').val()
                            , feeType:$('#feeType').val()
                            , orderNo: $('#orderNo').val()
                            , piCode: $('#piCode').val()
                            , piName: $("#s2id_piCode"+" "+".select2-chosen").text()
                            , compyCode: $("#compyCode").val()
                            , amount: $("#amount").val()
                            , expDate: $("#expDate").val()
                            , remarks: $("#remarks").val()
                            , feeStatus: '1'
                        },
                        type: "post",
                        dataType: "text",
                        async: false,
                        success: function (data) {
                            if (data == "true") {
                                showTip("保存成功");
                                window.parent.findReceivable();
                                window.parent.findPayable();
                                window.parent.closeLayer();
                            } else {
                                showError("<fmt:message key='expenseManagement.error'/>");
                            }
                        }
                    });
                })
            }
        });

        $("#temporaryAndNext").click(function () {
            reg = /^\-?([1-9][\d]{0,7}|0)(\.[\d]{1,2})?$/;

            if ($("#feeStatue").val() == '1' && $("#binsApprovalFlag").val() == 'Y') {
                showError("该笔费用已开始对账或已审核，不能恢复为暂存费用！");
                return false;
            }

            var amount = $("#amount").val();
            if (isBlank($("#piCode").val())) {
                showError("请选择【价目】！");
            } else if (isBlank($("#compyCode").val())) {
                showError("请选择【付款单位】！");
            } else if (isBlank(amount)) {
                showError("请填写【应收金额】！");
            } else if (!reg.test(amount)) {
                showError("请输入正确金额！");
            } else if (isBlank($("#expDate").val())) {
                showError("请填写【预计日期】！");
            } else if (parseFloat(amount) == 0 && isBlank($("#remarks").val())) {
                showError("应收金额为0，请填写【备注】！");
            } else {
                var index = layer.confirm("您确定要保存这些数据吗？", {
                    btn: ['确定', '取消'], //按钮
                    icon: 7
                }, function () {
                    layer.close(index);
                    $.ajax({
                        url: "${ctx}/finance/expense/saveRecPay",
                        data: {
                            recPayId: $('#recPayId').val()
                            , paymentType:$('#paymentType').val()
                            , feeType:$('#feeType').val()
                            , orderNo: $('#orderNo').val()
                            , piCode: $('#piCode').val()
                            , piName: $("#s2id_piCode"+" "+".select2-chosen").text()
                            , compyCode: $("#compyCode").val()
                            , amount: $("#amount").val()
                            , expDate: $("#expDate").val()
                            , remarks: $("#remarks").val()
                            , feeStatus: '0'
                        },
                        type: "post",
                        dataType: "text",
                        async: false,
                        success: function (data) {
                            if (data == "true") {
                                showTip("保存成功");
                                clearView();
                                window.parent.findReceivable();
                                window.parent.findPayable();
                            } else {
                                showError("<fmt:message key='expenseManagement.error'/>");
                            }
                        }
                    });
                })
            }
        });

        $("#saveAndNext").click(function () {
            reg = /^\-?([1-9][\d]{0,7}|0)(\.[\d]{1,2})?$/;

            var amount = $("#amount").val();
            if (isBlank($("#piCode").val())) {
                showError("请选择【价目】！");
            } else if (isBlank($("#compyCode").val())) {
                showError("请选择【付款单位】！");
            } else if (isBlank(amount)) {
                showError("请填写【应收金额】！");
            } else if (!reg.test(amount)) {
                showError("请输入正确金额！");
            } else if (isBlank($("#expDate").val())) {
                showError("请填写【预计日期】！");
            } else if (parseFloat(amount) == 0 && isBlank($("#remarks").val())) {
                showError("应收金额为0，请填写【备注】！");
            } else {
                var index = layer.confirm("您确定要保存这些数据吗？", {
                    btn: ['确定', '取消'], //按钮
                    icon: 7
                }, function () {
                    layer.close(index);
                    $.ajax({
                        url: "${ctx}/finance/expense/saveRecPay",
                        data: {
                            recPayId: $('#recPayId').val()
                            , paymentType:$('#paymentType').val()
                            , feeType:$('#feeType').val()
                            , orderNo: $('#orderNo').val()
                            , piCode: $('#piCode').val()
                            , piName: $("#s2id_piCode"+" "+".select2-chosen").text()
                            , compyCode: $("#compyCode").val()
                            , amount: $("#amount").val()
                            , expDate: $("#expDate").val()
                            , remarks: $("#remarks").val()
                            , feeStatus: '1'
                        },
                        type: "post",
                        dataType: "text",
                        async: false,
                        success: function (data) {
                            if (data == "true") {
                                showTip("保存成功");
                                clearView();
                                window.parent.findReceivable();
                                window.parent.findPayable();
                            } else {
                                showError("<fmt:message key='expenseManagement.error'/>");
                            }
                        }
                    });
                })
            }
        });

        $("#cancel").click(function () {
            window.parent.closeLayer();
        });

    });

    function clearView() {
        $("#piCode").val('');
        $("#piCode").trigger("change");
        $("#compyCode").val('');
        $("#compyCode").trigger("change");
        $("#amount").val('');
        $("#expDate").val('');
        $("#remarks").val('');
    }

    function isBlank(obj) {
        return (!obj || $.trim(obj) == "");
    }

    function clearNoNum(obj) {
        obj.value = obj.value.replace(/[^\d\-.]/g, ""); //清除"数字"和"."以外的字符
        obj.value = obj.value.replace(/^\./g, ""); //验证第一个字符是数字而不是
        obj.value = obj.value.replace(/\.{2,}/g, "."); //只保留第一个. 清除多余的
        obj.value = obj.value.replace(".", "$#$").replace(/\./g, "").replace("$#$", ".");
//        obj.value = obj.value.replace(/^(\-)*(\d+)\.(\d\d).*$/, '$1$2.$3'); //只能输入两个小数
//        obj.value = Number(obj.value).toFixed(2);
        // 负数四舍五入处理
        var flag = false;
        if (obj.value.indexOf("-") > -1) {
            flag = true;
            obj.value = -obj.value;
        }
        obj.value = Math.round(obj.value * 100) /100
        if (flag) {
            obj.value = -obj.value
        }
    }
</script>