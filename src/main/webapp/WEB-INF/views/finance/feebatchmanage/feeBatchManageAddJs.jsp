<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<script type="text/javascript">
    window.onload = function () {
        $("#orderNoStr").val($("#orderNoStr", parent.document).val());
        $("#orderNoCnt").val($("#orderNoCnt", parent.document).val());
        $("#relatedCompy").val($("#compyCodeStr", parent.document).val());
        $("#relatedCompy").trigger("change");
    }
    $(document).ready(function () {
        //保存
        $("#save").click(function () {
            if (!checkAmount())
                return;
            var url = "${ctxZG}/feeBatchManage/feeBatchManageCheckSave";
            layer.open({
                type: 2,
                maxmin: true,
                title: '批量新增校验',
                shade: 0.5,
                area: ["600px", "400px"], //宽高
                content: url
            });
        });

        //收付类型
        $("#paymentType").change(function () {
            paymentTypeChange();
        });

        //取消
        $("#cancel").click(function () {
            parent.layer.closeAll();
        });

    });

    function checkAmount() {
        var paymentType = $("#paymentType").val();
        if (isBlank(paymentType)) {
            showError("请选择收付类型！");
            return false;
        }
        var piCode = $("#piCode").val();
        if (isBlank(piCode)) {
            showError("请选择费用名称！");
            return false;
        }
        var relatedCompy = $("#relatedCompy").val();
        if (isBlank(relatedCompy)) {
            showError("请选择往来单位！");
            return false;
        }
        var amount = $("#amount").val();
        if (isBlank(amount)) {
            showError("请输入金额！");
            return false;
        }
        var expDate = $("#expDate").val();
        if (isBlank(expDate)) {
            showError("请选择预计日期！");
            return false;
        }
        var AmountRe= new RegExp(/^[+-]?(([1-9][0-9]*)|(([0]\.\d{1,4}|[1-9][0-9]*\.\d{1,4})))$/);  //金额正则
        var amount = $("#amount").val();
        if(!AmountRe.test(amount)) {
            showError(MsgConstants.getMsg("M00011", "正确的金额"))
            return false;
        }
        return true;
    }
    //非空判断
    function isBlank(obj) {
        return (!obj || $.trim(obj) === "");
    }

</script>