<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<script type="text/javascript">

    $(document).ready(function () {
        $("#return").click(function () {
            parent.doCancel();
        })

        $("#save").click(function () {
            var cusCode = $("#cusCode").val();
            var salesManId = $("#salesManId").val();

            if (isBlank(cusCode)) {
                showError("请选择客户！");
                return false;
            }
            save();
        });
    });


    //非空判断
    function isBlank(obj) {
        return (!obj || $.trim(obj) === "");
    }

    function save() {
        var pageType = $("#pageType").val();
        var index = layer.confirm("确认保存该协议客户？", function (index) {
            openLoading();
            $.ajax({
                url: "${ctxZG}/priceContract/saveCus",
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
                    parent.doCusSearch($("#priceContractNo").val());
                },
                error: function (xhr, status, error) {
                    closeLoading();
                    showError("系统错误");
                }
            });
            layer.close(index);
        });

    }
</script>