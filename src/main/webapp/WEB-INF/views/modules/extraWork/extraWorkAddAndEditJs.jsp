<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<script type="text/javascript">
    $(document).ready(function(){
        //保存
        $("#save").click(function () {
            doSave();
        })

        //返回
        $("#back").click(function () {
            if(typeof parent.back == 'function'){
                parent.back();
            }
        })
    });

    function doSave() {

        var occurDate = $("#occurDate").val()
        if(!occurDate) {
            validate("发生日期不能为空！");
            return;
        }

        var driverCode = $("#driverCode").val()
        if(!driverCode) {
            validate("司机不能为空！");
            return;
        }

        var extraWorkId = $("#extraWorkId").val()
        if(!extraWorkId) {
            validate("小活名称不能为空！");
            return;
        }

        var quantity = $("#quantity").val()
        if(!quantity || quantity == 0) {
            validate("小活数量不能为空！");
            return;
        }

        var id = $("#id").val();
        var url
        if(id && id > 0) {
            //编辑
            url = "extraWork/eidtExtraWork"
        }else {
            //新增
            url = "extraWork/addExtraWork"
        }
        openLoading();
        postHelper(url, $("#saveForm").serialize(), function (res) {
            closeLoading();
            if(res.resultType == 1) {
                showTip("保存成功")
                setTimeout(function () {
                    parent.doSearch();
                    parent.back();
                }, 1000);
            }else {
                showError(res.resultMsg);
            }
        })
    }

    function postHelper(url, data, callback) {
        url = "${ctxZG}/" + url;
        $.ajax({
            url : url,
            type : 'post',
            data: data,
            success:function(res){
                var obj = JSON.parse(res)
                callback(obj);
            },
            error:function(xhr,status,error){
                showError("系统错误");
            }
        });
    }

    /**
     * 查找车架号
     */
    function searchframeNum(value) {
        $.ajax({
            url: "${ctxZG}/container/searchFrameNum?id="+value,
            type: "post",
            success: function (result) {
                var obj = JSON.parse(result);
                if (obj.resultType == BizConstant.SUCCESS) {
                    $("#frameNum").val(obj.dataModel);
                } else {
                    showError(obj.resultMsg);
                }
            },
            error: function (xhr, status, error) {
                showError("系统错误");
            }
        })
    }

    /**
     * 查找车辆油耗
     */
    function searchPlateNumLiters(value) {
        $.ajax({
            url: "${ctxZG}/extraWork/searchPlateNumLiters?plateNum="+value,
            type: "post",
            success: function (result) {
                var obj = JSON.parse(result);
                if (obj.resultType == BizConstant.SUCCESS) {
                    $("#liters").val(obj.dataModel);
                    countExtraWork();
                    countGPSOilPatch();
                } else {
                    showError(obj.resultMsg);
                }
            },
            error: function (xhr, status, error) {
                showError("系统错误");
            }
        })
    }

    /**
     * 查找小活价格
     */
    function searchExtraWorkPrice(value) {
        $.ajax({
            url: "${ctxZG}/extraWork/searchExtraWorkPrice?id="+value,
            type: "post",
            success: function (result) {
                var obj = JSON.parse(result);
                if (obj.resultType == BizConstant.SUCCESS) {
                    $("#extraWorkAddKm").val(obj.dataModel.extraWorkAddKm);
                    $("#extraWorkOilPatchEach").val(obj.dataModel.extraWorkOilPatchEach);
                    $("#extraWorkAmount").val(obj.dataModel.extraWorkAmount);
                    countExtraWork();
                } else {
                    showError(obj.resultMsg);
                }
            },
            error: function (xhr, status, error) {
                showError("系统错误");
            }
        })
    }

    /**
     * 计算小活金额和油补
     */
    function countExtraWork(){
        var extraWorkAddKm = $("#extraWorkAddKm").val();
        var extraWorkOilPatchEach = $("#extraWorkOilPatchEach").val();
        var extraWorkAmount = $("#extraWorkAmount").val();
        var quantity = $("#quantity").val();
        var liters = $("#liters").val();
        $("#amount").val(quantity*extraWorkAmount);
        $("#extraWorkOilPatch").val(quantity*extraWorkOilPatchEach+quantity*extraWorkAddKm*liters/100);
    }

    /**
     * 计算GPS油补
     */
    function countGPSOilPatch(){
        var liters = $("#liters").val();
        var addKm = $("#addKm").val();
        $("#addKmOilPatch").val(liters*addKm/100);
    }

    function validate(msg, time) {
        var displayTime = 1500;
        if (typeof (time) != "undefined") {
            displayTime = time;
        }
        layer.msg(msg, {
            icon : 7,
            time : displayTime
        });
    }

    function validateNumber(e, pnumber) {
        if (!/^\d+[.]?[0-9]?[0-9]?[0-9]?[0-9]?$/.test(pnumber))
        {
            e.value = /\d+[.]?[0-9]?[0-9]?[0-9]?[0-9]?/.exec(e.value);
        }
        return false;
    }

    function validatePositiveInteger(e, pnumber) {
        if (!/^\+?[1-9]\d*$/.test(pnumber))
        {
            e.value = /\+?[1-9]\d*/.exec(e.value);
        }
        return false;
    }

</script>