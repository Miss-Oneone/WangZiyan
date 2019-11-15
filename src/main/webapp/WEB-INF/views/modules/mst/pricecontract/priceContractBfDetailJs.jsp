<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<script type="text/javascript">

    $(document).ready(function(){

        window.onload = function () {
            if (!isBlank("${priceContractNo}")){
                $("#priceContractNo").removeAttr("disabled");
                $("#priceContractNo").val("${priceContractNo}");
                $("#priceContractNo").trigger("change");
            }
        }
        $("#return").click(function(){
            parent.doCancel();
        })

        $("#save").click(function () {
            var chargingType = $("#chargingType").val();
            if(isBlank($("#priceContractNo").val())){
                showError("价格协议号不能为空！");
                return false;
            }

            if(isBlank($("#rCusBfPrice").val())){
                showError("价格(元)不能为空！");
                return false;
            }

            if(isBlank(chargingType)){
                showError("请选择计费方式！");
                return false;
            }

            if(isBlank($("#containerType").val())){
                showError("集装箱价格等级编码不能为空！");
                return false;
            }
            // 起始地
            var index;
            for (var i=0;i<($("div[id^='fromAdrs']").length);i++){
                if(i>0){
                    if ($($("div[id^='fromAdrs']")[i]).is(":hidden")){
                        index = i;
                        i = $("div[id^='fromAdrs']").length;
                    }
                }
            }
            if(!index){
                index = $("div[id^='fromAdrs']").length;
            }
            var provinceCodeCopy = $("#fromAdrs").val()

            if(provinceCodeCopy=='350000000'){
//                if(!$($("select[id^='fromAdrs']")[index-1]).val()){
//                    showError("地址不能为空且必须选到最后一级！");
//                    return false;
//                }
            }else{
                if(!$($("select[id^='fromAdrs']")[2]).val()){
                    showError("(外省)地址不能为空且必须选到第三级！");
                    return false;
                }
            }

            // 到达地
            var toIndex;
            for (var i=0;i<($("div[id^='toAdrs']").length);i++){
                if(i>0){
                    if ($($("div[id^='toAdrs']")[i]).is(":hidden")){
                        toIndex = i;
                        i = $("div[id^='toAdrs']").length;
                    }
                }
            }
            if(!toIndex){
                toIndex = $("div[id^='toAdrs']").length;
            }
            var provinceCodeCopy = $("#toAdrs").val()

            if(provinceCodeCopy=='350000000'){
//                if(!$($("select[id^='toAdrs']")[index-1]).val()){
//                    showError("地址不能为空且必须选到最后一级！");
//                    return false;
//                }
            }else{
                if(!$($("select[id^='toAdrs']")[2]).val()){
                    showError("(外省)地址不能为空且必须选到第三级！");
                    return false;
                }
            }

            save();
        });

        $("#rCusBfPrice").keyup(function () {
            clearNoNum(this);
        });

        $("#rCusBfPrice").blur(function () {
            var rCusBfPrice = $("#rCusBfPrice").val();
            if(!isBlank(rCusBfPrice))
                $("#rCusBfPrice").val(formatCurrency(rCusBfPrice));
        })


        $("#distanceKmQty").keyup(function () {
            clearNoNumber(this);
        })

        $("#distanceKmQty").blur(function () {
            var distanceKmQty = $("#distanceKmQty").val();
            if (!isBlank(distanceKmQty))
                $("#distanceKmQty").val(formatCurrencys(distanceKmQty));
        })


        $("#chargingType").change(function () {
//            var chargingType = $("#chargingType").val();
//            if (chargingType == '2'){
//                $("#containerType").val("");
//                $("#div_weight").show();
//                $("#div_container").hide();
//            }else{
//                $("#goodsWeight").val("");
//                $("#goodsType").val("");
//                $("#div_weight").hide();
//                $("#div_container").show();
//            }
        });


        /*$("#provinceCodeCopyCity").change(function () {
           var cityName = $("#provinceCodeCopyCity").find("option:selected").text();
           var destRegionName = $("#destRegionName").val();
           $("#destRegionName").val(cityName);
        });
        $("#provinceCodeCopyDistrict").change(function () {
            var districtName = $("#provinceCodeCopyDistrict").find("option:selected").text();
            var destAddrsName = $("#destAddrsName").val();
            $("#destAddrsName").val(districtName);
        });
        $("#provinceCodeCopyCounty").change(function () {
            var countyName = $("#provinceCodeCopyCounty").find("option:selected").text();
            var destAddrsName = $("#destAddrsName").val();
            $("#destAddrsName").val(destAddrsName+countyName);
        });*/
        init();
    });



    function init() {
        if("${chargingType}"=='2'){
            $("#div_weight").show();
            $("#div_container").hide();
        }else{
            $("#div_weight").hide();
            $("#div_container").show();
        }
        //隐藏运柜宝
        if("${mstPriceContractBfModel.priceContractNo}" == 'HT000057' && "${chargingType}" == '1') {
            //显示运柜宝
            $("#ygbCustomerDiv").show();
        } else {
            //隐藏运柜宝
            $("#ygbCustomerDiv").hide();
        }
    }
    //非空判断
    function isBlank(obj){
        return(!obj || $.trim(obj) === "");
    }

    function getInfo() {
        var arrStr = JSON.stringify([{
            url:"${ctxZG}/priceContract/getCityList",
            key:"provinceCode"
        },{
            url:"${ctxZG}/priceContract/getDistrictList",
            key:"cityCode"
        },{
            url:"${ctxZG}/priceContract/getCountyList",
            key:"districtCode"
        }]);
        return arrStr
    }

    function initSelectNames() {
        var arrStr = JSON.stringify(['fromProvinceCode','fromCityCode','fromDistrictCode','fromCountyCode'])
        return arrStr
    }

    function toInitSelectNames() {
        var arrStr = JSON.stringify(['toProvinceCode','toCityCode','toDistrictCode','toCountyCode'])
        return arrStr
    }

    function setDefaultCheck(){
        var arrStr = [];
        if (!isBlank('${priceContractBfModel.fromCountyCode}')){
            arrStr = JSON.stringify([${priceContractBfModel.fromProvinceCode},${priceContractBfModel.fromCityCode},${priceContractBfModel.fromDistrictCode},'${priceContractBfModel.fromCountyCode}'])
        }else if(isBlank('${priceContractBfModel.fromCountyCode}')&&(!isBlank(${priceContractBfModel.fromDistrictCode}))){
            arrStr = JSON.stringify([${priceContractBfModel.fromProvinceCode},${priceContractBfModel.fromCityCode},${priceContractBfModel.fromDistrictCode}])
        }else if(isBlank('${priceContractBfModel.fromCountyCode}')&&(isBlank(${priceContractBfModel.fromDistrictCode}))&&(!isBlank(${priceContractBfModel.fromCityCode}))){
            arrStr = JSON.stringify([${priceContractBfModel.fromProvinceCode},${priceContractBfModel.fromCityCode}])
        }else {

        }

        return arrStr
    }

    function setToAdrsDefaultCheck(){
        var arrStr = [];
        if (!isBlank('${priceContractBfModel.toCountyCode}')){
            arrStr = JSON.stringify([${priceContractBfModel.toProvinceCode},${priceContractBfModel.toCityCode},${priceContractBfModel.toDistrictCode},'${priceContractBfModel.toCountyCode}'])
        }else if(isBlank('${priceContractBfModel.toCountyCode}')&&(!isBlank(${priceContractBfModel.toDistrictCode}))){
            arrStr = JSON.stringify([${priceContractBfModel.toProvinceCode},${priceContractBfModel.toCityCode},${priceContractBfModel.toDistrictCode}])
        }else if(isBlank('${priceContractBfModel.toCountyCode}')&&(isBlank(${priceContractBfModel.toDistrictCode}))&&(!isBlank(${priceContractBfModel.toCityCode}))){
            arrStr = JSON.stringify([${priceContractBfModel.toProvinceCode},${priceContractBfModel.toCityCode}])
        }else {

        }

        return arrStr
    }

    function save() {
        var pageType = $("#pageType").val();
        layer.confirm("确认保存该运费？", function() {
            $("#chargingType").prop("disabled", false);
            $("#priceContractNo").prop("disabled", false);
            $.ajax({
                url:"${ctxZG}/priceContract/saveBf",
                type:"post",
                data:$("#detailForm").serialize(),
                success:function (result) {
                    var obj = JSON.parse(result);
                    if(obj.resultType == BizConstant.SUCCESS){
                        showTip(obj.resultMsg);
                        setTimeout(function(){
                            parent.doCancel();
                        },1000)
                    }else{
                        if(pageType == 'edit'){
                            $("#chargingType").prop("disabled", true);
                            $("#priceContractNo").prop("disabled", true);
                        }
                        showError(obj.resultMsg);
                    }
                    parent.doSearch();
                },
                error:function(xhr,status,error){
                    showError("系统错误");
                }
            });
        });

    }

    function clearNoNum(obj){
        obj.value = obj.value.replace(/[^\d.-]/g,"");  //清除“数字”和“.”以外的字符
        obj.value = obj.value.replace(/^\./g,"");  //验证第一个字符是数字而不是.
        obj.value = obj.value.replace(/\.{2,}/g,"."); //只保留第一个. 清除多余的.
        obj.value = obj.value.replace(".","$#$").replace(/\./g,"").replace("$#$",".");
        obj.value = obj.value.replace(/\.\d{2,}$/,obj.value.substr(obj.value.indexOf('.'),3));//只保留小数点后两位小数
    }
    function formatCurrency(num) {
        num = num.toString().replace(/\$|\,/g,'');
        if(isNaN(num))
            num = "0";
        sign = (num == (num = Math.abs(num)));
        num = Math.floor(num*100+0.50000000001);
        cents = num%100;
        num = Math.floor(num/100).toString();
        if(cents<10)
            cents = "0" + cents;
        for (var i = 0; i < Math.floor((num.length-(1+i))/3); i++)
            num = num.substring(0,num.length-(4*i+3))+','+
                num.substring(num.length-(4*i+3));
        return (((sign)?'':'-') + num + '.' + cents);
    }

    function clearNoNumber(obj) {
        obj.value = obj.value.replace(/[^\d]/g,"");  //清除“数字”以外的字符
    }

    function formatCurrencys(num) {
        num = num.toString().replace(/\$|\,/g,'');
        if(isNaN(num))
            num = "0";
        sign = (num == (num = Math.abs(num)));
        num = Math.floor(num*100+0.50000000001);
        num = Math.floor(num/100).toString();

        for (var i = 0; i < Math.floor((num.length-(1+i))/3); i++)
            num = num.substring(0,num.length-(4*i+3))+','+
                num.substring(num.length-(4*i+3));
        return (((sign)?'':'-') + num);
    }
</script>