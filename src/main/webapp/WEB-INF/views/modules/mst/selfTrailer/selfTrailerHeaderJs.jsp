<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<script type="text/javascript">
    window.onload = function () {

    };

    $(document).ready(function () {
        $("#searchForm img").remove();

        $("#Save").click(function () {
            var pageType = $("#pageType").val();
            doSave(pageType);
        });
    });

    //保存
    function doSave(pageType) {
        if(!confirmCheck()) {
            return;
        }
        var title = "更新数据";
        if ($("#pageType").val() == "create") {
            title = "新增数据";
        }
        var pageType = $("#pageType").val();
        var url = "${ctxZG}/selfTrailer/save";
        layer.confirm(MsgConstants.getMsg("C00009", title), function () {
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
                        if (!isBlank(obj.resultMsg) && obj.resultMsg.indexOf("保存成功") != -1) {
                            parent.layer.closeAll();
                        } else {
                            layer.closeAll();
                        }
                    });

                }
            });
        });
    }

    function numberCheck(e) {
        var patrn = /^[0-9]*$/;
        if (!patrn.test(e.value)) {
            showError('只能输入数字');
            e.value = "";
            e.focus();
        }
    }

    <!--utils - -->
    //非空判断
    function isBlank(obj) {
        return (!obj || $.trim(obj) == "");
    }

    function closeLayerFirm() {
        var i = layer.confirm();
        layer.close(i);
    }

    function confirmCheck() {
        var check = true;
        if(isBlank($("#plateNum").val())) {
            showError("车牌号不能为空");
            check = false;
            return check;
        }
        var trailerBelongType = $("#trailerBelongType").val()
        if(isBlank(trailerBelongType)) {
            showError("运力类型不能为空");
            check = false;
            return check;
        }
//        if ((trailerBelongType == '1' || trailerBelongType == '2') && isBlank($("#relatedDrvCode").val())) {
//            showError("挂靠车或外排车【关系人/车队】不能为空");
//            return false;
//        }
//        if(isBlank($("#gpsPlateNum").val())) {
//            showError("GPS车牌号不能为空");
//            check = false;
//            return check;
//        }
//        if(isBlank($("#tWheelType").val())) {
//            showError("轮轴类型不能为空");
//            check = false;
//            return check;
//        }
//        if(isBlank($("#validFlag").val())) {
//            showError("有效标志不能为空");
//            check = false;
//            return check;
//        }
//        if(isBlank($("#buyTime").val())) {
//            showError("购入日期不能为空");
//            check = false;
//            return check;
//        }
//        if(isBlank($("#productModel").val())) {
//            showError("车辆型号不能为空");
//            check = false;
//            return check;
//        }
//        if(isBlank($("#engineNo").val())) {
//            showError("发动机编号不能为空");
//            check = false;
//            return check;
//        }
//        if(isBlank($("#zhangzhouFlag").val())) {
//            showError("漳州标志不能为空");
//            check = false;
//            return check;
//        }
//        if(isBlank($("#controlGroup").val())) {
//            showError("调度分组不能为空");
//            check = false;
//            return check;
//        }
        return check;
    }

    function changeBelongType() {
//        var trailerBelongType = $("#trailerBelongType").val();
//        if (!trailerBelongType || trailerBelongType == "0") {
//            $("#relatedDrvCode").select2("readonly", true);
//        } else if (trailerBelongType == "1" || trailerBelongType == "2") {
//            $("#relatedDrvCode").select2("readonly", false);
//        }
    }
    
</script>