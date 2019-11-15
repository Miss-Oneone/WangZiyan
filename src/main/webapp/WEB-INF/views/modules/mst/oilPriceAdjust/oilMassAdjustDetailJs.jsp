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
        var adjustTime = $("#time").val();
        var adjustOil = $("#oilMass").val();
        if (isBlank(driverCode)) {
            showError("司机姓名不能为空！");
            return;
        }
        if (isBlank(adjustTime)) {
            showError("补油日期不能为空！");
            return;
        }
        if (isBlank(adjustOil)) {
            showError("补油量不能为空！");
            return;
        }
        var url = "${ctxZG}/oilMassAdjust/save"

        var i = layer.confirm(MsgConstants.getMsg("C00009", "保存数据"), function () {
            openLoading();
            layer.close(i);
            $.ajax({
                url: url,
                type: "post",
                data: $("#searchForm").serialize(),
                success: function (data) {
                    closeLoading();
                    var obj = JSON.parse(data);
                    var j = layer.alert(obj.resultMsg, function (index) {
                        parent.doSearch();
                        parent.closeLayer();
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


</script>