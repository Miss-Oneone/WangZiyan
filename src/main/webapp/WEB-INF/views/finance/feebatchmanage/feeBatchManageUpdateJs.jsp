<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<script type="text/javascript">
    window.onload = function () {
        $("#feeCnt").val($("#feeCnt", parent.document).val());
        $("#paymentTypeName").val($("#paymentTypeNameStr", parent.document).val());
        $("#piName").val($("#piNameStr", parent.document).val());
        $("#relatedCompy").val($("#compyNameStr", parent.document).val());
    }
    $(document).ready(function () {
        //保存
        $("#save").click(function () {
            if (!checkAmount())
                return;
            if (!checkPsd())
                return;
            openLoading();
            $.ajax({
                url: "${ctxZG}/feeBatchManage/feeBatchManageSaveUpdate",
                data: {
                    "feeIdStr": $("#feeIdStr", parent.document).val()
                    , "paymentType": $("#paymentTypeStr", parent.document).val()
                    , "addAmount": $("#addAmount").val()
                    , "amount": $("#amount").val()
                    , "amountFlag": $("#amountFlag").val()
                },
                type: 'post',
                success: function (data) {
                    closeLoading();
                    showAlert("修改完成");
                    parent.doSearch();
                    parent.layer.closeAll();
                }
            });

        });

        $("#addAmountCb").click(function () {
            if ($("#addAmountCb").is(':checked')) {
                selectAddAmountCb();
            } else {
                selectAmountCb();
            }
        });
        $("label[title='每条修改(元)']").click(function () {
            if ($("#addAmountCb").is(':checked')) {
                selectAmountCb();
            } else {
                selectAddAmountCb();
            }
        });
        $("#amountCb").click(function () {
            if ($("#amountCb").is(':checked')) {
                selectAmountCb();
            } else {
                selectAddAmountCb();
            }
        });

        $("label[title='全部修改为(元)']").click(function () {
            if ($("#amountCb").is(':checked')) {
                selectAddAmountCb();
            } else {
                selectAmountCb();
            }
        });

        $("#confirmPsd").blur(function () {
            if ($("#confirmPsd").val() != '') {
                $.ajax({
                    type: "post",
                    url: "${ctxZG}/feeBatchManage/checkPassword",
                    data: {
                        'password': $("#confirmPsd").val(),
                    },
                    success: function (data) {
                        if (data == 'success') {
                            $("#isPsdFlag").val("Y");
                        } else {
                            $("#isPsdFlag").val("N");
                        }
                    }
                });
            }
            return;
        });

        //取消
        $("#cancel").click(function () {
            parent.layer.closeAll();
        });
        $("#psdDiv").hide();
    })
    ;

    function selectAddAmountCb() {

        $("#addAmountCb").prop("checked", true);
        $("#amountCb").prop("checked", false);
        $("#amount").attr("readonly", "readonly");
        $("#addAmount").removeAttr("readonly");
        $("#amount").val("");
        $("#confirmPsd").val("");
        $("#psdDiv").hide();
        $("#amountFlag").val("1");
    }
    function selectAmountCb() {

        $("#amountCb").prop("checked", true);
        $("#addAmountCb").prop("checked", false);
        $("#addAmount").attr("readonly", "readonly");
        $("#amount").removeAttr("readonly");
        $("#addAmount").val("");
        $("#confirmPsd").val("");
        $("#psdDiv").show();
        $("#amountFlag").val("2");
    }

    function checkAmount() {
        var AmountRe = new RegExp(/^[+-]?(([1-9][0-9]*)|(([0]\.\d{1,4}|[1-9][0-9]*\.\d{1,4})))$/);  //金额正则
        var amount = $("#amount").val();
        var addAmount = $("#addAmount").val();

        if ($("#amountCb").is(':checked') && isBlank(amount)) {
            showError("请输入全部修改为(元)的金额！");
            return false;
        }
        if ($("#amountCb").is(':checked') && !isBlank(amount)) {
            if (!AmountRe.test(amount)) {
                showError("全部修改为(元)的金额不符合规范！");
                return false;
            }
        }
        if ($("#addAmountCb").is(':checked') && isBlank(addAmount)) {
            showError("请输入每条修改(元)的金额！");
            return false;
        }
        if ($("#addAmountCb").is(':checked') && !isBlank(addAmount)) {
            if (!AmountRe.test(addAmount)) {
                showError("每条修改(元)的金额不符合规范！");
                return false;
            }
        }
        return true;
    }

    function checkPsd() {
        var psdFlag = $("#isPsdFlag").val();
        var amountFlag = $("#amountFlag").val();
        var confirmPsd = $("#confirmPsd").val();
        if (amountFlag == "2") {
            if (confirmPsd == '') {
                showError("请输入密码校验！");
                return false;
            }
            if (psdFlag == 'N') {
                showError("密码不正确！");
                return false;
            }
        }
        return true;
    }
    //非空判断
    function isBlank(obj) {
        return (!obj || $.trim(obj) === "");
    }

</script>