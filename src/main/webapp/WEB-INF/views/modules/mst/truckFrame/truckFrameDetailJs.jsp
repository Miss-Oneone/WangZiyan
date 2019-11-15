<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<script type="text/javascript">
    var flag = false;//用户当前车头车牌号，如果之前保存的车牌号已经作废，下拉选是不应该有的
    var initFlag = true;
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
        //编辑时设置当前车头车牌号
        if('${truckFrameModel.id}' && ${truckFrameModel.id} > 0 && '${truckFrameModel.plateNum}') {
            setTimeout(function () {
                if($("#truckPlateNo").find("option:selected").val() != '${truckFrameModel.plateNum}') {
                    flag = true;
                    var plateNo = "${truckFrameModel.plateNum}";
                    $("#truckPlateNo").append('<option value="' + plateNo + '" selected>' + plateNo + '</option>');
                    $("#truckPlateNo").trigger("change");
                }
            }, 100)
        }
	});

	function clearScrapData() {
        if(!initFlag) {
            if(flag) {
                truckPlateNoLoadData();
            }
        }else {
            initFlag = false;
        }
    }

	function doSave() {
        //内部编码
        var frameCardId = $("#frameCardId").val()
        if(!frameCardId) {
            validate("内部编码不能为空");
            return;
        }
        //车牌号
        var frameNum = $("#frameNum").val()
        if(!frameNum) {
            validate("车架车牌号不能为空");
            return;
        }
        var truckFrameId = $("#id").val();
        var url
        var closeFlag = false;
        if(truckFrameId && truckFrameId > 0) {
            //编辑
            url = "truckFrame/eidtTruckFrame"
            closeFlag = true;
        }else {
            //新增
            url = "truckFrame/addTruckFrame"
        }
        openLoading();
        postHelper(url, $("#saveForm").serialize(), function (res) {
            closeLoading();
            if(res.resultType == 1) {
                showTip("保存成功")
                setTimeout(function () {
                    if(closeFlag) {
                        parent.back();
                    }else {
                        window.location.reload();
                    }
                }, 1000);
            }else {
                showError(res.resultMsg);
            }
        })
    }

	function getInternalCodes() {
        var frameTypeId = $("#frameType").val();
        var taopaiFlag = $("#taopaiFlag").val();
        if(frameType && taopaiFlag) {
            postHelper("truckFrameManage/findInCodeList", {
                frameTypeId: frameTypeId,
                taopaiFlag: taopaiFlag
            },function (res) {
                if(res.resultType == 1) {
                    initSelect("internalCode", res.dataModel, false, false, false, true, 200);
                }else {
                    showError(res.resultMsg);
                }
            })
        }
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

    function trim(obj) {
        obj.value = obj.value.replace(/(^\s*)|(\s*$)/g, "");
        obj.value = obj.value.replace(/[^\u4E00-\u9FFF\x21-\x7E\’]/g, "");
    }

    //非空判断
    function isBlank(obj){
        return(!obj || $.trim(obj) === "");
    }
</script>