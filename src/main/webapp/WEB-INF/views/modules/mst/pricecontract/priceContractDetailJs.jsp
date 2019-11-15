<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<script type="text/javascript">

    $(document).ready(function () {
        $("#return").click(function () {
            parent.doCancel();
        })

        $("#save").click(function () {
            var contractName = $("#contractName").val();
            var validFlag = $("#validFlag").val();
            var effectStartTime = $("#effectStartTime").val();
            var effectEndTime = $("#effectEndTime").val();
            var settlementType = $("#settlementType").val();
            var settlementDays = $("#settlementDays").val();
            if (isBlank(contractName)) {
                showError("价格名称不能为空！");
                return false;
            }
            if (isBlank(validFlag)) {
                showError("有效标志不能为空！");
                return false;
            }
            if (isBlank(effectStartTime)) {
                showError("协议有效开始日不能为空！");
                return false;
            }
            if (isBlank(effectEndTime)) {
                showError("协议有效结束日不能为空！");
                return false;
            }
            if (isBlank(settlementType)) {
                showError("结算类型不能为空！");
                return false;
            }
            if (!isBlank(settlementDays)) {
                if (!Number.isInteger(Number(settlementDays)) || Number(settlementDays) < 0) {
                    showError("【应到款天数】格式不正确，请重新输入！")
                    return false;
                }
            }

            save();
        });

        $("#outHctxFee").keyup(function () {
            clearNoNum(this);
        });

        $("#outHctxFee").blur(function () {
            var outHctxFee = $("#outHctxFee").val();
            if (!isBlank(outHctxFee))
                $("#outHctxFee").val(formatCurrency(outHctxFee));
        });
    });


    //非空判断
    function isBlank(obj) {
        return (!obj || $.trim(obj) === "");
    }

    function save() {
        var pageType = $("#pageType").val();
        var index = layer.confirm("确认保存该协议？", function (index) {
            openLoading();
            $.ajax({
                url: "${ctxZG}/priceContract/save",
                type: "post",
                data: $("#addFrom").serialize(),
                success: function (result) {
                    closeLoading();
                    var obj = JSON.parse(result);
                    if (obj.resultType == BizConstant.SUCCESS) {
                        showTip(obj.resultMsg);
                        setTimeout(function () {
                            parent.doCancel();
                        }, 1000)
                    } else {
                        showError(obj.resultMsg);
                    }
                    parent.doSearch();
                },
                error: function (xhr, status, error) {
                    closeLoading();
                    showError("系统错误");
                }
            });
            layer.close(index);
        });

    }

    function clearNoNum(obj) {
        obj.value = obj.value.replace(/[^\d.-]/g, "");  //清除“数字”和“.”以外的字符
        obj.value = obj.value.replace(/^\./g, "");  //验证第一个字符是数字而不是.
        obj.value = obj.value.replace(/\.{2,}/g, "."); //只保留第一个. 清除多余的.
        obj.value = obj.value.replace(".", "$#$").replace(/\./g, "").replace("$#$", ".");
        obj.value = obj.value.replace(/\.\d{2,}$/, obj.value.substr(obj.value.indexOf('.'), 3));//只保留小数点后两位小数
    }
    function formatCurrency(num) {
        num = num.toString().replace(/\$|\,/g, '');
        if (isNaN(num))
            num = "0";
        sign = (num == (num = Math.abs(num)));
        num = Math.floor(num * 100 + 0.50000000001);
        cents = num % 100;
        num = Math.floor(num / 100).toString();
        if (cents < 10)
            cents = "0" + cents;
        for (var i = 0; i < Math.floor((num.length - (1 + i)) / 3); i++)
            num = num.substring(0, num.length - (4 * i + 3)) + ',' +
                num.substring(num.length - (4 * i + 3));
        return (((sign) ? '' : '-') + num + '.' + cents);
    }

    function clearNoNumber(obj) {
        obj.value = obj.value.replace(/[^\d]/g, "");  //清除“数字”以外的字符
    }

    function formatCurrencys(num) {
        num = num.toString().replace(/\$|\,/g, '');
        if (isNaN(num))
            num = "0";
        sign = (num == (num = Math.abs(num)));
        num = Math.floor(num * 100 + 0.50000000001);
        num = Math.floor(num / 100).toString();

        for (var i = 0; i < Math.floor((num.length - (1 + i)) / 3); i++)
            num = num.substring(0, num.length - (4 * i + 3)) + ',' +
                num.substring(num.length - (4 * i + 3));
        return (((sign) ? '' : '-') + num);
    }
</script>