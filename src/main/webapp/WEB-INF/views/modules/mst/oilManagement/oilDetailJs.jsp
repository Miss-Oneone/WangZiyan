<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<script type="text/javascript">
    var flag = false;//用户当前车头车牌号，如果之前保存的车牌号已经作废，下拉选是不应该有的
    var initFlag = true;
	$(document).ready(function(){
        //保存
        $("#save").click(function () {
            doSave(1);
        })

        $("#saveAndNext").click(function () {
            doSave(2)
        })

        //返回
        $("#back").click(function () {
            if(typeof parent.back == 'function'){
                parent.back();
            }
        })

        $("#\\@span_checkbox_innerFlagY").on("change", function (e) {
            if ($("#\\@checkbox_innerFlagY_0").is(':checked')) {
                innerOil();
                $("#\\@checkbox_innerFlagN_0").prop('checked', false);
                $("#innerFlagN").val("");
                $("#innerFlag").val("Y");
            }
        })
        $("#\\@span_checkbox_innerFlagN").on("change", function (e) {
            if ($("#\\@checkbox_innerFlagN_0").is(':checked')) {
                outerOil();
                $("#\\@checkbox_innerFlagY_0").prop('checked', false);
                $("#innerFlagY").val("");
                $("#innerFlag").val("N");
            }
        })
    });

	function doSave(type) {
        var innerFlag="";
        if($("input[name='@checkbox_innerFlagY']").is(':checked')){
            innerFlag="Y";
        }else if($("input[name='@checkbox_innerFlagN']").is(':checked')){
            innerFlag="N";
        }

        if (!innerFlag) {
            showError("请选择油库类型");
            return;
        }

        var operationTime=$('#operationTime').val();
        var plateNum=$('#plateNum').val();
        var cardNo=$('#cardNo').val();
        var driver=$('#driver').val();
        var station=$('#station').val();
        var fuelType=$('#fuelType').val();
        var thePrice=$('#thePrice').val();
        var addLiters=$('#addLiters').val();
        var tankStorage=$('#tankStorage').val();
        var remarks=$('#remarks').val();
        var unitPrice=$('#unitPrice').val();

        if(isBlank(plateNum)){
            showError("请选择车牌号");
            return;
        }

        if(isBlank(driver)){
            showError("请选择司机");
            return;
        }

        if (isBlank(unitPrice)) {
            showError("请填写单价");
            return;
        }

        if(innerFlag=='Y'){
            if(operationTime==''||plateNum==''||fuelType==''||thePrice==''||addLiters==''||tankStorage==''){
                showError("请将信息填写完整");
            }else{
                judge(addLiters,tankStorage,type);
            }
        }
        if(innerFlag=='N'){
            if(operationTime==''||plateNum==''||fuelType==''||thePrice==''||addLiters==''||tankStorage==''||cardNo==''||station==''){
                showError("请将信息填写完整");
            }else{
                judge(addLiters,tankStorage,type);
            }
        }
    }

    function judge(addLiters,tankStorage,flag){
        if (!addLiters.match(/^[0-9]+(.[0-9]{2})?$/)) {
            showError("加油量请填写数值");
            $('#addLiters').focus();
        } else if (!tankStorage.match(/^[0-9]+(.[0-9]{2})?$/)) {
            showError("加油后油箱油量请填写数值");
            $('#tankStorage').focus();
        } else {
            var layerIdx = layer.confirm("确认保存这些数据？", function () {
                postHelper("oilManage/turnToShare", $("#saveForm").serialize(), function (res) {
                    if (res.resultType == "1") {
                        showTip("保存成功")
                        if (flag == 1) {
                            setTimeout(function () {
                                parent.back()
                            }, 1000)
                        } else {
                            setTimeout(function () {
                                window.location.reload()
                            }, 1000)
                        }
                    } else {
                        showError(res.resultMsg)
                    }
                })
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

    function ValidateNumber(e, pnumber) {
        if (!/^\d+[.]?[0-9]?[0-9]?$/.test(pnumber))
        {
            e.value = /\d+[.]?[0-9]?[0-9]?/.exec(e.value);
        }
        return false;
    }

    function changeNum(x, type){
        var f = parseFloat(x.value);
        if (isNaN(f)) {
            if (type == 0) {
                $("#addLiters").val("0.00");
                $("#amount").html("0.00")
            } else {
                $("#unitPrice").val("0.00");
                $("#amount").html("0.00")
            }
            return false;
        }
        var f = Math.round(x.value*100)/100;
        var s = f.toString();
        var rs = s.indexOf('.');
        if (rs < 0) {
            rs = s.length;
            s += '.';
        }
        while (s.length <= rs + 2) {
            s += '0';
        }
        if (type == 0) {
            $("#addLiters").val(s);
            var unitPrice = $("#unitPrice").val();
            if (unitPrice&& Number(unitPrice) > 0) {
                $("#amount").html(Number(unitPrice) * Number(s))
            }
        } else {
            $("#unitPrice").val(s);
            var addLiters = $("#addLiters").val();
            if (addLiters&& Number(addLiters) > 0) {
                $("#amount").html(Number(addLiters) * Number(s))
            }
        }
    }

    function innerOil(){
        $('#cardNo').val("").css("background-color","#eeeeee").attr("readonly","true");
        $('#station').val("").css("background-color","#eeeeee").attr("readonly","true");
    }

    function outerOil(){
        $('#cardNo').css("background-color","#FFFFFF").removeAttr("readonly");
        $('#station').css("background-color","#FFFFFF").removeAttr("readonly");
    }

    function driverChange(){
        var driverCode=$('#driver').val();
        if(driverCode!=''){
            $.ajax({
                url:"${ctxZG}/oilManage/findTrailer",
                type:"post",
                data:{"driverCode":driverCode},
                success:function(data){
                    var json=eval("("+data+")");
                    //$('#plateNum').val(json.plateNum);
                    //$("#plateNum").trigger("chosen:updated");
                    $('#fuelType').val(json.fuelType);
                    $("#fuelType").trigger("chosen:updated");
                    $('#tankLiters').val(json.tankLiters);
                    fuelTypeChange();
                }
            });
        }else{
            $('#plateNum').val('');
            $("#plateNum").trigger("chosen:updated");
            $('#fuelType').val('');
            $("#fuelType").trigger("chosen:updated");
            $('#tankLiters').val('');
            $('#thePrice').val("0.0");
        }
    }

    function fuelTypeChange(){
        var innerFlag="";
        if($("input[name='@checkbox_innerFlagY']").is(':checked')){
            innerFlag="Y";
        }else if($("input[name='@checkbox_innerFlagN']").is(':checked')){
            innerFlag="N";
        }
        var fuelType=$('#fuelType').val();
        if(innerFlag!=""&&fuelType!=""){
            $.ajax({
                url:"${ctxZG}/oilManage/findOilPrice",
                type:"post",
                data:{"fuelType":fuelType,"innerFlag":innerFlag},
                success:function(data){
                    $('#thePrice').val(data);
                    $("#thePrice").trigger("chosen:updated");
                }
            });
        }else{
            $('#thePrice').val("0.0");
        }
    }

    function trailerChange(){
        var plateNum=$('#plateNum').val();
        if(plateNum!=''){
            $.ajax({
                url:"${ctxZG}/oilManage/findDriver",
                type:"post",
                data:{"plateNum":plateNum},
                success:function(data){
                    var json = eval("(" + data + ")");
                    if (json) {
                        $('#driver').val(json.driverCode).trigger("change");
                        $('#fuelType').val(json.fuelType).trigger("change");
                        $('#tankLiters').val(json.tankLiters);
                        fuelTypeChange();
                    }
                }
            });
        }else{
            $('#driver').val('');
            $("#driver").trigger("chosen:updated");
            $('#fuelType').val('');
            $("#fuelType").trigger("chosen:updated");
            $('#tankLiters').val('');
        }

    }
</script>