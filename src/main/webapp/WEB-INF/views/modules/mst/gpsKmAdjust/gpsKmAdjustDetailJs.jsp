<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<script type="text/javascript">
    $(document).ready(function () {
        $("#searchForm img").remove();

        $("#Save").click(function () {
            doSave();
        });

    });

    //保存
    function doSave() {
        var driverCode = $("#driverCode").val();
        var adjustTime = $("#adjustTime").val();
        var adjustKm = $("#adjustKm").val();
        if (isBlank(driverCode)) {
            showError("司机姓名不能为空！");
            return;
        }
        if (isBlank(adjustTime)) {
            showError("GPS校正日期不能为空！");
            return;
        }
        if (isBlank(adjustKm)) {
            showError("公里数调整不能为空！");
            return;
        }
        var url = "${ctxZG}/gpsKmAdjust/save"

        layer.confirm(MsgConstants.getMsg("C00009", "更新数据"), function () {
            openLoading();
            closeLayerFirm();
            $.ajax({
                url: url,
                type: "post",
                data: $("#searchForm").serialize(),
                success: function (data) {
                    closeLoading();
                    var obj = JSON.parse(data);
                    layer.alert(obj.resultMsg, function (index) {
                        parent.doSearch();
                        parent.layer.closeAll();
                    });

                }
            });
        });
    }
    <!--utils - -->
    //非空判断
    function isBlank(obj) {
        return (!obj || $.trim(obj) == "");
    }

    function clearNoNum(obj) {
        obj.value = obj.value.replace(/[^\d.]/g, ""); //清除“数字”和“.”以外的字符
        obj.value = obj.value.replace(/^\./g, ""); //验证第一个字符是数字而不是.
        obj.value = obj.value.replace(/\.{2,}/g, "."); //只保留第一个. 清除多余的.
        obj.value = obj.value.replace(".", "$#$").replace(/\./g, "").replace(
            "$#$", ".");
        obj.value = obj.value.replace(/\.\d{2,}$/, obj.value.substr(obj.value
            .indexOf('.'), 3));//只保留小数点后两位小数
    }

    function closeLayerFirm() {
        var i = layer.confirm();
        layer.close(i);
    }
</script>