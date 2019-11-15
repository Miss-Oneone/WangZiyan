<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<script type="text/javascript">
    var tripUpInitFlag = true;
    var tripDownInitFlag = true;
    var tempPlateNum = '${containerModel.plateNum}', tempFromAdrs = '${containerModel.fromZxAdrs}', tempToAdrs = '${containerModel.toZxAdrs}'; // 用于判断司机工资是否需要变化，重新获取
    $(document).ready(function(){
        //计费模式为按吨或者按立方时数量可编辑
        if ('${containerModel.chargingType}' == '2' || '${containerModel.chargingType}' == '3' ) {
            $("#count").prop("readonly",false);
            $("#count").css("background-color", "#fff");
        }
        //业务类型为自有运输时禁用还箱、截箱时间
        if ('${containerModel.ioType}' == '1') {
            $("#changeBoxTime").prop("disabled",true);
            $("#changeBoxTime").css("background-color", "#eee");
            $("#crossBoxTime").prop("disabled",true);
            $("#crossBoxTime").css("background-color", "#eee");
        }
        $("#departureDate").val('${containerModel.departureDate}').trigger('change');
        $("#save").click(function () {
            if(!checkMustItem()){
                return false;
            }
            var index = layer.confirm("确定保存吗？", {
                btn: ['确定', '取消'], //按钮
                icon: 7
            }, function () {
                layer.close(index);
                saveInfo();
            })
        })

        $("#saveAndNext").click(function () {
            if(!checkMustItem()){
                return false;
            }
            var index = layer.confirm("确定保存并新建下一条吗？", {
                btn: ['确定', '取消'], //按钮
                icon: 7
            }, function () {
                layer.close(index);
                saveInfoAndNext();
            })
        })
        $("#return").click(function () {
            parent.closeLayer();
        })
        $("#price").keyup(function(){
            clearNoNum(this);
        });
        $("#count").keyup(function(){
            //按吨保留3位小数、按立方保留2位小数、按柜就不用填了
            if ($("#chargingType").val() == '2') {
                clearNoNumber(this);
            }
            if ($("#chargingType").val() == '3') {
                clearNoNum(this);
            }
        });

        $("#\\@span_checkbox_collectionOrderYes").on("change", function (e) {
            if ($("#\\@checkbox_collectionOrderYes_0").is(':checked')) {
                $("#\\@checkbox_collectionOrderNo_0").prop('checked', false);
                $("#collectionOrderNo").val("");
            }
        })
        $("#\\@span_checkbox_collectionOrderNo").on("change", function (e) {
            if ($("#\\@checkbox_collectionOrderNo_0").is(':checked')) {
                $("#\\@checkbox_collectionOrderYes_0").prop('checked', false);
                $("#collectionOrderYes").val("");
            }
        })

        var orderNo = $("#orderNo").val();
        $("#\\@span_checkbox_tripFlagUp").on("change", function (e) {
            if ($("#\\@checkbox_tripFlagUp_0").is(':checked')) {
                $("#\\@checkbox_tripFlagDown_0").prop('checked', false);
                $("#tripFlagDown").val("");
            }
            // 监听行程标志触发价格协议查询，编辑时初始化时不触发
            if ($("#transportType").val() == 1 && (isBlank(orderNo) || (!isBlank(orderNo) && !tripUpInitFlag))) {
                getPriceContractBfs();
            } else {
                tripUpInitFlag = false;
            }
        })
        $("#\\@span_checkbox_tripFlagDown").on("change", function (e) {
            if ($("#\\@checkbox_tripFlagDown_0").is(':checked')) {
                $("#\\@checkbox_tripFlagUp_0").prop('checked', false);
                $("#tripFlagUp").val("");
            }
            if ($("#transportType").val() == 1 && (isBlank(orderNo) || (!isBlank(orderNo) && !tripDownInitFlag))) {
                getPriceContractBfs();
            } else {
                tripDownInitFlag = false;
            }
        })

        $("#plateNum").click(function () {
            getDriverCode(this.value);
            getCostRoute();
        })
        $("#contnNo").keyup(function () {
            this.value=this.value.toUpperCase()
        })

        $("#transportType").change(function () {
            if (this.value == '2') {
                $("#\\@checkbox_tripFlagUp_0").prop('checked', false);
                $("#tripFlagUp").val("");
                $("#\\@checkbox_tripFlagDown_0").prop('checked', false);
                $("#tripFlagDown").val("");
                $("#\\@checkbox_tripFlagUp_0").prop('disabled', true);
                $("#\\@checkbox_tripFlagDown_0").prop('disabled', true);
            } else {
                $("#\\@checkbox_tripFlagUp_0").prop('disabled', false);
                $("#\\@checkbox_tripFlagDown_0").prop('disabled', false);
            }
        })

        // 编辑时价格协议提示信息显示隐藏控制
        if (!isBlank(orderNo)) {
            if ('${containerModel.limitWeightTip}' && '${containerModel.limitWeightTip}' !=  '0.0') {
                showOverweightTip();
            } else if ('${containerModel.unitPriceTip}' && '${containerModel.unitPriceTip}' != '0.0') {
                showUnitPriceTip();
            } else if (!'${containerModel.contaBfId}' || '${containerModel.contaBfId}' == '0') {
                hideOverweightTip();
                hideUnitPriceTip();
                $("#priceTip").show();
                $("#rCusBfPrice").prop('readonly', false).trigger('change')
            }
        }

        $("#modifyPrice").click(function () {
            var msg = getPriceContractBfs(true);
            if (msg) {
                showError(msg);
            }
        })

        $("#modifySalary").click(function () {
            var msg = getCostRoute(true);
            if (msg) {
                showError(msg);
            }
        })
    });

    function checkMustItem() {
        if (isBlank($("#cusCode").val())) {
            showError("客户不能为空！");
            return false;
        }

//        if (isBlank($("#ioType").val())) {
//            showError("业务类型不能为空！");
//            return false;
//        }

        if (isBlank($("#goodsCodeIn").val())) {
            showError("对内货物不能为空！");
            return false;
        }

        if (isBlank($("#departureDate").val()) && !isBlank($("#plateNum").val())) {
            showError("发车日期不能为空！");
            return false;
        }

        if (!isBlank($("#departureDate").val()) && isBlank($("#plateNum").val())) {
            showError("车牌号不能为空！");
            return false;
        }

        if (isBlank($("#fromZxAdrs").val())) {
            showError("起运地不能为空！");
            return false;
        }

        if (isBlank($("#toZxAdrs").val())) {
            showError("到达地不能为空！");
            return false;
        }

        if (isBlank($("#transportType").val())) {
            showError("运输方式不能为空！");
            return false;
        }

        if ($("#transportType").val() == '1') {
            if (isBlank($("#tripFlagUp").val()) && isBlank($("#tripFlagDown").val())) {
                showError("行程标志不能为空！");
                return false;
            }
        }

        if (isBlank($("#chargingType").val())) {
            showError("计费模式不能为空！");
            return false;
        }

        <!--价格协议校验-->
//        if (isBlank($("#rCusBfPrice").val())) {
//            showError("协议运费不能为空！");
//            return false;
//        }
//        if (isBlank($("#contaBfId").val())) {
//            showError("协议运费ID不能为空！");
//            return false;
//        }

        return true;
    }
    function saveInfo() {
        openLoading();
        $.ajax({
            url: "${ctxZG}/container/saveOrder?"+$("#addFrom").serialize(),
            type: "post",
            success: function (result) {
                closeLoading();
                var obj = JSON.parse(result);
                if (obj.resultType == BizConstant.SUCCESS) {
                    showTip(obj.resultMsg);
                    if (!isBlank($("#orderNo").val())) {
                        parent.doSearch();
                        parent.closeLayer();
                    } else {
                        location.href = "${ctxZG}/container/orderSearch";
                    }
                } else {
                    showError(obj.resultMsg);
                }
            },
            error: function (xhr, status, error) {
                closeLoading();
                showError("系统错误");
            }
        })
    }

    function saveInfoAndNext() {
        openLoading()
        $.ajax({
            url: "${ctxZG}/container/saveOrder?"+$("#addFrom").serialize(),
            type: "post",
            success: function (result) {
                closeLoading();
                var obj = JSON.parse(result);
                if (obj.resultType == BizConstant.SUCCESS) {
                    showTip(obj.resultMsg);
                    showTip("保存成功");

                    // 清除不相同的数据的信息（司机信息等）
                    $("#plateNum").val('');
                    $("#plateNum").trigger('change');
                    $("#frameNo").val('');
                    $("#frameNo").trigger('change');
                    $("#frameNum").val('');
                    $("#driverCode").val('');
                    $("#driverCode").trigger('change');
                    $("#contnNo").val('');
                    $("#sealNo").val('');
                    $("#count").val('');
                    $("#changeBoxTime").val('');
                    $("#changeBoxTime").val('');
                    $("#volume").val('');
                    $("#weight").val('');
                    $("#costRouteId").val('');
                    tempPlateNum = '';

//                    $("input[name='@checkbox_tripFlagUp']").prop('checked', false);
//                    $("input[name='@checkbox_tripFlagDown']").prop('checked', false);
//                    $("#tripFlagUp").val('');
//                    $("#tripFlagDown").val('');
                } else {
                    showError(obj.resultMsg);
                }
            },
            error: function (xhr, status, error) {
                closeLoading();
                showError("系统错误");
            }
        })
    }

    function clearNoNum(obj){
        obj.value = obj.value.replace(/[^\d.]/g,"");  //清除“数字”和“.”以外的字符
        obj.value = obj.value.replace(/^\./g,"");  //验证第一个字符是数字而不是.
        obj.value = obj.value.replace(/\.{2,}/g,"."); //只保留第一个. 清除多余的.
        obj.value = obj.value.replace(".","$#$").replace(/\./g,"").replace("$#$",".");
        obj.value = obj.value.replace(/\.\d{2,}$/,obj.value.substr(obj.value.indexOf('.'),3));//只保留小数点后两位小数
    }

    function clearNoNumber(obj){
        obj.value = obj.value.replace(/[^\d.]/g,"");  //清除“数字”和“.”以外的字符
        obj.value = obj.value.replace(/^\./g,"");  //验证第一个字符是数字而不是.
        obj.value = obj.value.replace(/\.{2,}/g,"."); //只保留第一个. 清除多余的.
        obj.value = obj.value.replace(".","$#$").replace(/\./g,"").replace("$#$",".");
        obj.value = obj.value.replace(/\.\d{2,}$/,obj.value.substr(obj.value.indexOf('.'),4));//只保留小数点后两位小数
    }

    function isBlank(obj) {
        return (!obj || $.trim(obj) === "");
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
     * 查找司机
     */
    function getDriverCode(value) {
        $.ajax({
            url: "${ctxZG}/container/getDriverCode?plateNum="+value,
            type: "post",
            success: function (result) {
                var obj = JSON.parse(result);
                if (obj.resultType == BizConstant.SUCCESS) {
                    if (obj.dataModel) {
                        $("#driverCode").val(obj.dataModel.driverCode).trigger("change");
                        $("#relatedDrvName").val(obj.dataModel.relatedDrvName);
                    }
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
     * 查找箱型
     */
    function getContnNos(value) {
        $.ajax({
            url: "${ctxZG}/container/getContnNos?contnNo="+value,
            type: "post",
            success: function (result) {
                var obj = JSON.parse(result);debugger
                if (obj.resultType == BizConstant.SUCCESS) {
                    if (!isBlank(obj.dataModel.contnNo)) {
                        $("#bfLevelCode").val("40HQ").trigger("change");
                        $("#contnOwnerId").val(obj.dataModel.contnOwnerId).trigger("change");
                        $("#ioType").val(obj.dataModel.contnType).trigger("change");
                    }
                } else {
                    showError(obj.resultMsg);
                }
            },
            error: function (xhr, status, error) {
                showError("系统错误");
            }
        })
    }

    function input(e) {
        var contnNo = e.target.value;
        if (contnNo) {
            $("#contnNoOptions").show();
            $.ajax({
                url: "${ctxZG}/container/getLikeContnNos?contnNo="+contnNo,
                type: "post",
                success: function (result) {
                    var obj = JSON.parse(result);
                    if (obj.resultType == BizConstant.SUCCESS) {
                        $("#contnNoOptions").html('')
                        var likeContnNos = obj.dataModel;
                        var html = '';
                        for (var i in likeContnNos) {
                            html += '<p onclick="choseContnNo(\''+ likeContnNos[i] + '\')">' + likeContnNos[i] + '</p>'
                        }
                        $("#contnNoOptions").html(html);

                    } else {
                        showError(obj.resultMsg);
                    }
                },
                error: function (xhr, status, error) {
                    showError("系统错误");
                }
            })
        } else {
            $("#contnNoOptions").hide();
        }
    }

    var choseContnNoFlag = false;
    function choseContnNo(contnNo) {
        choseContnNoFlag = true;
        $("#contnNo").val(contnNo);
        choseContnNoFlag = false;
        $("#contnNoOptions").html('');
        $("#contnNoOptions").hide();
        getContnNos(contnNo);
    }

    function closeContnNoOptions(e) {
        setTimeout(function () {
            if (choseContnNoFlag) {
                return;
            }
            $("#contnNoOptions").html('');
            $("#contnNoOptions").hide();
            choseContnNoFlag = false;
            // 自动查找并填写截箱时间
           getCrossBoxTime();
        }, 400)
    }

    // 查找同一箱号，还未还箱的截箱时间
    function getCrossBoxTime() {
        var contnNo = $("#contnNo").val();
        var ioType = $("#ioType").val();
        if (contnNo && ioType && (ioType == '2' || ioType == '3' || ioType == '4')) {
            $.ajax({
                url: "${ctxZG}/container/getCrossBoxTime?contnNo="+contnNo,
                type: "post",
                success: function (result) {
                    var obj = JSON.parse(result);
                    if (obj.resultType == BizConstant.SUCCESS) {
                        var crossBoxTime = obj.dataModel;
                        if (crossBoxTime) {
                            $("#crossBoxTime").val(crossBoxTime);
                        }
                    } else {
                        showError(obj.resultMsg);
                    }
                },
                error: function (xhr, status, error) {
                    showError("系统错误");
                }
            })
        }
    }

    //计费模式改变事件
    function setCount(value) {
//        $("#count").val("");
//        if (!isBlank(value) && value != '1') {
//            $("#count").prop("readonly",false);
//            $("#count").css("background-color", "#fff");
//        } else {
//            $("#count").prop("readonly","readonly");
//            $("#count").css("background-color", "#eee");
//        }

        $("#volume").prop("readonly",false);
        $("#weight").prop("readonly",false);
        $("#volume").css("background-color", "#fff");
        $("#weight").css("background-color", "#fff");
        if (value == '1') {
            $("#volume").prop("readonly",true);
            $("#volume").css("background-color", "#eee");
            $("#volume").val('')
            $("#weight").val('')
            $("#count").val('')
        } else if (value == '2') {
            $("#volume").prop("readonly",true);
            $("#volume").css("background-color", "#eee");
            $("#volume").val('')
            $("#weight").val('')
            $("#count").val('')
        } else if (value == '3') {
            $("#weight").prop("readonly",true);
            $("#weight").css("background-color", "#eee");
            $("#weight").val('')
            $("#count").val('')
        }
        getPriceContractBfs();
    }

    //设置提箱时间还箱时间只读
    function setTimeReadOnly(value) {
        if (!isBlank(value) && value == '1') {
            $("#changeBoxTime").val("");
            $("#crossBoxTime").val("");
            $("#changeBoxTime").prop("disabled",true);
            $("#changeBoxTime").css("background-color", "#eee");
            $("#crossBoxTime").prop("disabled",true);
            $("#crossBoxTime").css("background-color", "#eee");

        } else {
            $("#changeBoxTime").prop("disabled",false);
            $("#changeBoxTime").css("background-color", "#fff");
            $("#crossBoxTime").prop("disabled",false);
            $("#crossBoxTime").css("background-color", "#fff");
            // 自动查找并填写截箱时间
            getCrossBoxTime();
        }
    }

    function initFromSelectNames() {
        var arrStr = JSON.stringify(['fromProvinceCode','fromCityCode','fromDistrictCode','fromCountyCode'])
        return arrStr
    }

    function initToSelectNames() {
        var arrStr = JSON.stringify(['toProvinceCode','toCityCode','toDistrictCode','toCountyCode'])
        return arrStr
    }

    function getFromInfo() {
        var arrStr = JSON.stringify([{
            url:"${ctxZG}/container/getCityList",
            key:"provinceCode"
        },{
            url:"${ctxZG}/container/getDistrictList",
            key:"cityCode"
        },{
            url:"${ctxZG}/container/getCountyList",
            key:"districtCode"
        }]);
        return arrStr;
    }

    function getToInfo() {
        var arrStr = JSON.stringify([{
            url:"${ctxZG}/container/getCityList",
            key:"provinceCode"
        },{
            url:"${ctxZG}/container/getDistrictList",
            key:"cityCode"
        },{
            url:"${ctxZG}/container/getCountyList",
            key:"districtCode"
        }]);
        return arrStr;
    }

    function setFromDefaultCheck(){
        var arrStr = [];
        if (!isBlank('${containerModel.fromCountyCode}')){
            arrStr = JSON.stringify([${containerModel.fromProvinceCode},${containerModel.fromCityCode},${containerModel.fromDistrictCode},'${containerModel.fromCountyCode}'])
        }else if(isBlank('${containerModel.fromCountyCode}')&&(!isBlank(${containerModel.fromDistrictCode}))){
            arrStr = JSON.stringify([${containerModel.fromProvinceCode},${containerModel.fromCityCode},${containerModel.fromDistrictCode}])
        }else if(isBlank('${containerModel.fromCountyCode}')&&(isBlank(${containerModel.fromDistrictCode}))&&(!isBlank(${containerModel.fromCityCode}))){
            arrStr = JSON.stringify([${containerModel.fromProvinceCode},${containerModel.fromCityCode}])
        }else {

        }

        return arrStr
    }

    function setToDefaultCheck(){
        var arrStr = [];
        if (!isBlank('${containerModel.toCountyCode}')){
            arrStr = JSON.stringify([${containerModel.toProvinceCode},${containerModel.toCityCode},${containerModel.toDistrictCode},'${containerModel.toCountyCode}'])
        }else if(isBlank('${containerModel.toCountyCode}')&&(!isBlank(${containerModel.toDistrictCode}))){
            arrStr = JSON.stringify([${containerModel.toProvinceCode},${containerModel.toCityCode},${containerModel.toDistrictCode}])
        }else if(isBlank('${containerModel.toCountyCode}')&&(isBlank(${containerModel.toDistrictCode}))&&(!isBlank(${containerModel.toCityCode}))){
            arrStr = JSON.stringify([${containerModel.toProvinceCode},${containerModel.toCityCode}])
        }else {

        }

        return arrStr
    }
    
    function choseAdrs(type) {
        var address
        if (type == 1) {
            address = $("#fromZxAdrs").val();
        } else if (type == 2) {
            address = $("#toZxAdrs").val();
        }
        if (!address) {
            getPriceContractBfs();
            if (type == 1) {
                $("#fromStdAdrs").select2('val', '');
                $("#fromStdAdrs").trigger('change')
                $("#fromContactPerson").val('')
                $("#fromContactPhone").val('')
                $("#fromAddressFull").val('');
            }  else if (type == 2) {
                $("#toStdAdrs").select2('val', '');
                $("#toStdAdrs").trigger('change')
                $("#toContactPerson").val('')
                $("#toContactPhone").val('')
                $("#toAddressFull").val('');
            }
            clearStdAdress(type);
            return
        }

        openLoading()
        $.ajax({
            url: "${ctxZG}/container/getStdAdrsCodesByZxd",
            type: "post",
            data: {zxdId: address},
            success: function (result) {
                closeLoading();
                var obj = JSON.parse(result);
                if (obj.resultType == BizConstant.SUCCESS) {
                    var stdAddress = obj.dataModel;
                    var datas = [stdAddress.provinceCode, stdAddress.cityCode, stdAddress.districtCode, stdAddress.countyCode];
                    if (type == 1) {
//                        var ids = ['fromStdAdrs', 'fromStdAdrsCity', 'fromStdAdrsDistrict', 'fromStdAdrsCounty'];
//                       loopSetDefaultValue(ids, datas, 0);
                        $("#fromProvinceName").val(stdAddress.provinceName)
                        $("#fromCityName").val(stdAddress.cityName)
                        $("#fromDistrictName").val(stdAddress.districtName)
                        $("#fromCountyName").val(stdAddress.countyName)

                        $("#fromProvinceCode").val(stdAddress.provinceCode)
                        $("#fromCityCode").val(stdAddress.cityCode)
                        $("#fromDistrictCode").val(stdAddress.districtCode)
                        $("#fromCountyCode").val(stdAddress.countyCode)
                        getPriceContractBfs();

                        $("#fromContactPerson").val(stdAddress.contactPerson);
                       $("#fromContactPhone").val(stdAddress.contactPhone);
                       $("#fromAddressFull").val(stdAddress.addressFull);
                    } else if (type == 2) {
//                        var ids = ['toStdAdrs', 'toStdAdrsCity', 'toStdAdrsDistrict', 'toStdAdrsCounty'];
//                        loopSetDefaultValue(ids, datas, 0);
                        $("#toProvinceName").val(stdAddress.provinceName)
                        $("#toCityName").val(stdAddress.cityName)
                        $("#toDistrictName").val(stdAddress.districtName)
                        $("#toCountyName").val(stdAddress.countyName)

                        $("#toProvinceCode").val(stdAddress.provinceCode)
                        $("#toCityCode").val(stdAddress.cityCode)
                        $("#toDistrictCode").val(stdAddress.districtCode)
                        $("#toCountyCode").val(stdAddress.countyCode)
                        getPriceContractBfs();

                        $("#toContactPerson").val(stdAddress.contactPerson);
                        $("#toContactPhone").val(stdAddress.contactPhone);
                        $("#toAddressFull").val(stdAddress.addressFull);
                    }
                } else {
                    showError(obj.resultMsg);
                }
            },
            error: function (xhr, status, error) {
                closeLoading();
                showError("系统错误");
            }
        })
    }

    function changeContnType() {
        if ($("#chargingType").val() != 1) {
            return;
        }
        getPriceContractBfs();
    }

    function loopSetDefaultValue(ids, datas, idx) {
        setTimeout(function () {
            var cnt = 0;
            var interval = setInterval(function () {
                $("#" + ids[idx]).val(datas[idx]).trigger('change');
                var val = $("#" + ids[idx]).val();
                cnt++;
                if (cnt > 100) {
                    console.log('failure')
                    clearInterval(interval);
                }
                if (val) {
                    clearInterval(interval);
                    if (idx < ids.length - 1) {
                        loopSetDefaultValue(ids, datas, ++idx);
                    } else {
                        // 赋值完获取价格协议
                        getPriceContractBfs();
                    }
                }
            },10)
        }, 100)
    }

    // 获取价格协议明细
    var layerIndex;
    function getPriceContractBfs(forcePopup) {
        // 验证价格协议主键(客户、计费类型、柜型、起运地四级、到达地四级、价格协议)是否都有值
        clearPriceInfo();
        var cusCode = $("#cusCode").val();
        if (!cusCode) {
            getCostRoute(false, forcePopup);
            return '客户不能为空';
        }
        var chargingType = $("#chargingType").val();
        if (!chargingType) {
            getCostRoute(false, forcePopup);
            return '计费模式不能为空';
        }
        var fromZxAdrs = $("#fromZxAdrs").val();
        if (!fromZxAdrs) {
            getCostRoute(false, forcePopup);
            return '起运地不能为空';
        }
        var toZxAdrs = $("#toZxAdrs").val();
        if (!toZxAdrs) {
            getCostRoute(false, forcePopup);
            return '到达地不能为空';
        }
        var priceContract = $("#priceContract").val();
        if (!priceContract) {
            getCostRoute(false, forcePopup);
            return '价格协议不能为空';
        }
        // 如果计费类型为按柜，柜型必须
        var bfLevelCode = '';
        if (chargingType == 1) {
            bfLevelCode = $("#bfLevelCode").val();
            if (!bfLevelCode) {
                $("#priceTip").hide();
                getCostRoute(false, forcePopup);
                return '柜型不能为空';
            }
        }
        // 如果运输方式为长途，行程标志必须
        var tripUpFlag = false;
        var transportType = $("#transportType").val();
        if (transportType == 1 && !$("#\\@checkbox_tripFlagUp_0").is(':checked') && !$("#\\@checkbox_tripFlagDown_0").is(':checked')) {
            getCostRoute(false, forcePopup);
            return '运输方式为长途，行程标志不能为空';;
        }
        if ($("#\\@checkbox_tripFlagUp_0").is(':checked')) {
            tripUpFlag = true;
        }

//        var fromProvinceCode = $("#fromStdAdrs").val();
//        var fromCityCode = $("#fromStdAdrsCity").val();
//        var fromDistrictCode = $("#fromStdAdrsDistrict").val();
//        var fromCountyCode = $("#fromStdAdrsCounty").val();
//        var toProvinceCode = $("#toStdAdrs").val();
//        var toCityCode = $("#toStdAdrsCity").val();
//        var toDistrictCode = $("#toStdAdrsDistrict").val();
//        var toCountyCode = $("#toStdAdrsCounty").val();
        var fromProvinceCode = $("#fromProvinceCode").val();
        var fromCityCode = $("#fromCityCode").val();
        var fromDistrictCode = $("#fromDistrictCode").val();
        var fromCountyCode = $("#fromCountyCode").val();
        var toProvinceCode = $("#toProvinceCode").val();
        var toCityCode = $("#toCityCode").val();
        var toDistrictCode = $("#toDistrictCode").val();
        var toCountyCode = $("#toCountyCode").val();

        // 获取价格协议明细
        openLoading()
        $.ajax({
            url: "${ctxZG}/container/getPriceContractBfs",
            type: "post",
            data: {priceContractNo: priceContract
                ,chargingType: chargingType
                ,fromProvinceCode: fromProvinceCode
                ,fromCityCode: fromCityCode
                ,fromDistrictCode: fromDistrictCode
                ,fromCountyCode: fromCountyCode
                ,toProvinceCode: toProvinceCode
                ,toCityCode: toCityCode
                ,toDistrictCode: toDistrictCode
                ,toCountyCode: toCountyCode
                ,containerType: bfLevelCode
                ,roundTripFlag: tripUpFlag ? "N" : ""
            },
            success: function (result) {
                closeLoading();
                var obj = JSON.parse(result);
                if (obj.resultType == BizConstant.SUCCESS) {
                    var priceContractBfs = obj.dataModel;
                    if (priceContractBfs && priceContractBfs.length > 0) {
                        // 如果是下行，且选择的是双边价格，需将之前的上行订单的费用修改为双程价格
                        // 判断是否有双程标志的价格
//                        var roundTripFlag = "N";
//                        var roundTripPriceContractBf
//                        for (var i in priceContractBfs) {
//                            if (priceContractBfs[i].roundTripFlag == 'Y') {
//                                roundTripFlag = "Y";
//                                roundTripPriceContractBf = priceContractBfs[i];
//                                break;
//                            }
//                        }
//                        $("#roundTripFlag").val(roundTripFlag);
//                        if (roundTripFlag == 'Y') {
//                            setPriceInfo(roundTripPriceContractBf);
//                            return;
//                        }

                        // 一条直接赋值
                        if (priceContractBfs.length == 1 && !forcePopup) {
                            setPriceInfo(priceContractBfs[0]);
                            getCostRoute();
                        }
                        // 多条弹窗供选择
                        if (priceContractBfs.length > 1 || forcePopup) {
                            var ids=[];
                            for (var idx in priceContractBfs) {
                                ids.push(priceContractBfs[idx].priceContractId)
                            }
                            layerIndex = layer.open({
                                type : 2,
                                maxmin : true,
                                area : [ "1100px", "400px" ],
                                title : '协议运费列表',
                                content : "${ctxZG}/container/chosePriceBfList?ids=" +  ids.join(),
                                cancel : function() {
                                },
                                end: function () {
                                    getCostRoute();
                                }
                            })
                        }
                    } else {
                        // 提示没有找到协议运费
                        $("#priceTip").show();
                        $("#rCusBfPrice").prop('readonly', false).trigger('change')
                        getCostRoute(false, forcePopup);
                    }
                } else {
                    showError(obj.resultMsg);
                }
            },
            error: function (xhr, status, error) {
                closeLoading();
                showError("系统错误");
            }
        })
    }

    // 获取价格协议
    function getPriceContracts() {
        var cusCode = $("#cusCode").val();
        if (cusCode) {
            openLoading()
            $.ajax({
                url: "${ctxZG}/container/getPriceContracts",
                type: "post",
                data: {cusCode: cusCode},
                success: function (result) {
                    closeLoading();
                    var obj = JSON.parse(result);
                    if (obj.resultType == BizConstant.SUCCESS) {
                        var priceContracts = obj.dataModel;
                        if (priceContracts && priceContracts.length > 0) {
                            initSelect("priceContract", priceContracts, true, false, false, true, 200, priceContracts[0].value);
                            $("#priceContract").trigger("change");
                            getPriceContractBfs();
                        }
                    } else {
                        showError(obj.resultMsg);
                    }
                },
                error: function (xhr, status, error) {
                    closeLoading();
                    showError("系统错误");
                }
            })
        } else {
            initSelect("priceContract", [], true, false, false, true, 200, '');
            getPriceContractBfs();
        }
    }

    // 根据价格协议，设置价格信息
    function setPriceInfo(priceContractBf) {
        // 设置价格协议ID
        $("#contaBfId").val(priceContractBf.priceContractId);
        // 如果是按柜则直接赋值协议运费，如果是按吨或立方则要根据重量和体积计算后赋值到协议运费上(1：按柜；2：按吨；3：按立方)
        var chargingType = $("#chargingType").val();
        var weight = $("#weight").val();
        var volume = $("#volume").val();
        var rCusBfPrice = '0.00'
        if (chargingType == 1) {
            rCusBfPrice = priceContractBf.rCusBfPrice;
            // 如果有限重，需要计算超重费
            var limitWeight = priceContractBf.limitWeight;
            if (limitWeight) {
                // 显示超重提示信息
                showOverweightTip(limitWeight, priceContractBf.overweightPrice);
                // 如果重量有值，直接判断是否超重，超重则计算超重费
                if (weight) {
                    var overweight = Number(weight) - Number(limitWeight);
                    if (overweight > 0) {
                        var overweightPrice = Number(overweight) * Number(priceContractBf.overweightPrice);
                        $("#overweightPrice").val(overweightPrice.toFixed(2));
                    }
                }
            }
        } else if (chargingType == 2) {
            $("#unitPrice").val(priceContractBf.rCusBfPrice);
            $("#price").val(priceContractBf.rCusBfPrice);
            showUnitPriceTip(priceContractBf.rCusBfPrice);
            if (weight) {
                rCusBfPrice = Number(weight) * Number(priceContractBf.rCusBfPrice)
            }
        } else if (chargingType == 3) {
            $("#unitPrice").val(priceContractBf.rCusBfPrice);
            $("#price").val(priceContractBf.rCusBfPrice);
            showUnitPriceTip(priceContractBf.rCusBfPrice);
            if (volume) {
                rCusBfPrice = Number(volume) * Number(priceContractBf.rCusBfPrice)
            }
        }
        $("#rCusBfPrice").val(Number(rCusBfPrice).toFixed(2));
        // 双程标志
        $("#roundTripFlag").val(priceContractBf.roundTripFlag);
    }

    // 显示超重提示信息
    function showOverweightTip(limitWeight, overweightPrice) {
        if (limitWeight) {
            $("#limitWeightTip").html(limitWeight);
            $("#overweightPriceTip").html(overweightPrice);
        }
        $("#overweightTip").show();
        $('#priceTip').hide();
        $('#unitPriceTip').hide();
    }
    // 隐藏超重提示信息
    function hideOverweightTip() {
        $("#limitWeightTip").html('');
        $("#overweightPriceTip").html('');
        $("#overweightTip").hide();
    }

    // 显示价格协议单价信息
    function showUnitPriceTip(unitPrice) {
        if (unitPrice) {
            $("#rCusBfPriceTip").html(unitPrice);
        }
        $("#unitPriceTip").show();
        $('#priceTip').hide();
        $('#overweightTip').hide();
    }
    // 隐藏价格协议单价信息
    function hideUnitPriceTip() {
        $("#rCusBfPriceTip").html('');
        $("#unitPriceTip").hide();
    }

    // 清空价格协议相关信息
    function clearPriceInfo() {
        $("#rCusBfPrice").val('');
        $("#overweightPrice").val('');
        $("#contaBfId").val('');
        $("#priceTip").hide();
        $("#price").val('');
        $("#weight").val('');
        $("#volume").val('');
        $("#count").val('');
        hideOverweightTip();
        hideUnitPriceTip();
        $("#rCusBfPrice").attr('readonly', true).trigger('change');
        $("#roundTripFlag").val("N");
    }

    // 如果按柜，计算超重费；如果不是则计算协议运费（单价*吨数（或立方数））
    function computePrice() {
        var chargingType = $("#chargingType").val();
        if (chargingType == 1) {
            $("#overweightPrice").val('');
            var weight = $("#weight").val();
            if (!weight) {
                return
            }
            var limitWeight = $("#limitWeightTip").html();
            if (!limitWeight) {
                return
            }
            var overweightPrice = $("#overweightPriceTip").html();
            if (!overweightPrice) {
                return
            }
            var overweight = Number(weight) - Number(limitWeight);
            if (overweight > 0) {
                overweightPrice = Number(overweight) * Number(overweightPrice);
                $("#overweightPrice").val(overweightPrice.toFixed(2));
            }
        } else if (chargingType == 2) {
            $("#rCusBfPrice").val('');
            var weight = $("#weight").val();
            if (!weight) {
                return
            }
            var unitPriceTip = $("#rCusBfPriceTip").html();
            if (!unitPriceTip) {
                return
            }
            var rCusBfPriceTip = Number(weight) * Number(unitPriceTip)
            $("#rCusBfPrice").val(rCusBfPriceTip.toFixed(2));
        } else if (chargingType == 3) {
            $("#rCusBfPrice").val('');
            var volume = $("#volume").val();
            if (!volume) {
                return
            }
            var unitPriceTip = $("#rCusBfPriceTip").html();
            if (!unitPriceTip) {
                return
            }
            var rCusBfPriceTip = Number(volume) * Number(unitPriceTip)
            $("#rCusBfPrice").val(rCusBfPriceTip.toFixed(2));
        }
    }

    function validateNumber(e, pnumber) {
        if (!/^\d+[.]?[0-9]?[0-9]?[0-9]?[0-9]?$/.test(pnumber))
        {
            e.value = /\d+[.]?[0-9]?[0-9]?[0-9]?[0-9]?/.exec(e.value);
        }
        return false;
    }

    function changeNum(x, type){
        var f = parseFloat(x.value);
        if (isNaN(f)) {
            var chargingType = $("#chargingType").val();
            if (type == 0) {
                $("#weight").val("0.00");
                if (chargingType == 2) {
                    $("#rCusBfPrice").val('');
                }
            } else {
                $("#volume").val("0.00");
                if (chargingType == 3) {
                    $("#rCusBfPrice").val('');
                }
            }
            $("#count").val("0.00");

            return false;
        }
        var f = Math.round(x.value*10000)/10000;
        var s = f.toString();
        var rs = s.indexOf('.');
        if (rs < 0) {
            rs = s.length;
            s += '.';
        }
        while (s.length <= rs + 4) {
            s += '0';
        }
        if (type == 0) {
            $("#weight").val(s);
        } else {
            $("#volume").val(s);
        }
        $("#count").val(s);

        computePrice();
    }

    function back() {
        if (layerIndex) {
            layer.close(layerIndex);
        }
    }

    // 运输类型变更为短途，触发价格协议查询,且清空行程标志并封死
    function transportTypeChange() {
        var transportType = $("#transportType").val()
        if (transportType == 2) {
            getPriceContractBfs();
        }
    }

    function clearStdAdress(type) {
        if (type == 1) {
            $("#fromProvinceName").val('')
            $("#fromCityName").val('')
            $("#fromDistrictName").val('')
            $("#fromCountyName").val('')
            $("#fromProvinceCode").val('')
            $("#fromCityCode").val('')
            $("#fromDistrictCode").val('')
            $("#fromCountyCode").val('')
        } else if (type == 2) {
            $("#toProvinceName").val('')
            $("#toCityName").val('')
            $("#toDistrictName").val('')
            $("#toCountyName").val('')
            $("#toProvinceCode").val('')
            $("#toCityCode").val('')
            $("#toDistrictCode").val('')
            $("#toCountyCode").val('')
        }
    }

    function priceFocus() {
        var readonly =  $("#rCusBfPrice").attr('readonly');
        if (!readonly) {
            $("#rCusBfPrice").attr('type', 'text')
        }
    }

    function priceBlur() {
        var readonly =  $("#rCusBfPrice").attr('readonly');
        if (!readonly) {
            $("#rCusBfPrice").attr('type', 'password')
        }
    }

    function getCostRoute(forcePopup, isSkipCostRoute) {
        if (isSkipCostRoute) {
            return;
        }
        // 清空旧工资
        $("#stdDrvSalPrice").val('');
        // 校验
        var fromZxAdrs = $("#fromZxAdrs").val();
        if (!fromZxAdrs) {
            return '起运地不能为空';
        }
        var toZxAdrs = $("#toZxAdrs").val();
        if (!toZxAdrs) {
            return '到达地不能为空';
        }
        var plateNum = $("#plateNum").val();
        if (!plateNum) {
            return '车牌号不能为空';
        }

        var fromProvinceCode = $("#fromProvinceCode").val();
        var fromCityCode = $("#fromCityCode").val();
        var fromDistrictCode = $("#fromDistrictCode").val();
        var fromCountyCode = $("#fromCountyCode").val();
        var toProvinceCode = $("#toProvinceCode").val();
        var toCityCode = $("#toCityCode").val();
        var toDistrictCode = $("#toDistrictCode").val();
        var toCountyCode = $("#toCountyCode").val();

        // 主键相同并且已有工资，不用重复去获取
        if ((plateNum == tempPlateNum && fromZxAdrs == tempFromAdrs && toZxAdrs == tempToAdrs && $("#costRouteId").val()) && !forcePopup) {
            return;
        }

        // 获取工资
        openLoading()
        $.ajax({
            url: "${ctxZG}/container/getCostRoutes",
            type: "post",
            data: {
                fromProvinceCode: fromProvinceCode
                ,fromCityCode: fromCityCode
                ,fromDistrictCode: fromDistrictCode
                ,fromCountyCode: fromCountyCode
                ,toProvinceCode: toProvinceCode
                ,toCityCode: toCityCode
                ,toDistrictCode: toDistrictCode
                ,toCountyCode: toCountyCode
                ,plateNum: plateNum
            },
            success: function (result) {
                closeLoading();
                var obj = JSON.parse(result);
                if (obj.resultType == BizConstant.SUCCESS) {
                    var costRoutes = obj.dataModel;
                    if (costRoutes && costRoutes.length > 0) {
                        // 一条直接赋值
                        if (costRoutes.length == 1 && !forcePopup) {
                            $("#stdDrvSalPrice").val(costRoutes[0].stdDrvSalPrice);
                            setCostRouteTempKey(plateNum, fromZxAdrs, toZxAdrs);
                        }
                        // 多条弹窗供选择
                        if (costRoutes.length > 1 || forcePopup) {
                            var ids=[];
                            for (var idx in costRoutes) {
                                ids.push(costRoutes[idx].id)
                            }
                            layerIndex = layer.open({
                                type : 2,
                                maxmin : true,
                                area : [ "1100px", "400px" ],
                                title : '司机工资列表',
                                content : "${ctxZG}/container/choseCostRouteList?ids=" +  ids.join() + "&plateNum=" + plateNum + "&fromAdrs=" + fromZxAdrs + "&toAdrs=" + toZxAdrs,
                                cancel : function() {
                                }
                            })
                        }
                    } else if (forcePopup) {
                        showError("未找到对应工资");
                    }
                } else {
                    showError(obj.resultMsg);
                }
            },
            error: function (xhr, status, error) {
                closeLoading();
                showError("系统错误");
            }
        })
    }

    function setCostRoute(costRoute) {
        $("#costRouteId").val(costRoute.id);
    }

    function setCostRouteTempKey(plateNum, fromAdrs, toAdrs) {
        tempPlateNum = plateNum;
        tempFromAdrs = fromAdrs;
        tempToAdrs = toAdrs;
    }
</script>