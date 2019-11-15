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
	});

	function doSave() {
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
//            if(!$($("select[id^='fromAdrs']")[index-1]).val()){
//                showError("地址不能为空且必须选到最后一级！");
//                return false;
//            }
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
//            if(!$($("select[id^='toAdrs']")[index-1]).val()){
//                showError("地址不能为空且必须选到最后一级！");
//                return false;
//            }
        }else{
            if(!$($("select[id^='toAdrs']")[2]).val()){
                showError("(外省)地址不能为空且必须选到第三级！");
                return false;
            }
        }

        var distanceAdjKm = $("#distanceAdjKm").val()
        if(!distanceAdjKm) {
            validate("核定公里数不能为空");
            return;
        }

        var validFlag = $("#validFlag").val()
        if(!validFlag) {
            validate("有效标志不能为空");
            return;
        }

        var trailerBelongType = $("#trailerBelongType").val()
        if(!trailerBelongType) {
            validate("运力类型不能为空");
            return;
        }

        openLoading();
        postHelper("costRoute/save", $("#saveForm").serialize(), function (res) {
            closeLoading();
            if(res.resultType == 1) {
                parent.doSearch();
                showTip("保存成功")
                setTimeout(function () {
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

    function getInfo() {
        var arrStr = JSON.stringify([{
            url:"${ctxZG}/helper/getCityList",
            key:"provinceCode"
        },{
            url:"${ctxZG}/helper/getDistrictList",
            key:"cityCode"
        },{
            url:"${ctxZG}/helper/getCountyList",
            key:"districtCode"
        }])
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
        if (!isBlank(${costRouteModel.fromCountyCode})){
            arrStr = JSON.stringify([${costRouteModel.fromProvinceCode},${costRouteModel.fromCityCode},${costRouteModel.fromDistrictCode},${costRouteModel.fromCountyCode}])
        }else if(isBlank(${costRouteModel.fromCountyCode})&&(!isBlank(${costRouteModel.fromDistrictCode}))){
            arrStr = JSON.stringify([${costRouteModel.fromProvinceCode},${costRouteModel.fromCityCode},${costRouteModel.fromDistrictCode}])
        }else if(isBlank(${costRouteModel.fromCountyCode})&&(isBlank(${costRouteModel.fromDistrictCode}))&&(!isBlank(${costRouteModel.fromCityCode}))){
            arrStr = JSON.stringify([${costRouteModel.fromProvinceCode},${costRouteModel.fromCityCode}])
        }else {

        }

        return arrStr
    }

    function setToAdrsDefaultCheck(){
        var arrStr = [];
        if (!isBlank(${costRouteModel.toCountyCode})){
            arrStr = JSON.stringify([${costRouteModel.toProvinceCode},${costRouteModel.toCityCode},${costRouteModel.toDistrictCode},${costRouteModel.toCountyCode}])
        }else if(isBlank(${costRouteModel.toCountyCode})&&(!isBlank(${costRouteModel.toDistrictCode}))){
            arrStr = JSON.stringify([${costRouteModel.toProvinceCode},${costRouteModel.toCityCode},${costRouteModel.toDistrictCode}])
        }else if(isBlank(${costRouteModel.toCountyCode})&&(isBlank(${costRouteModel.toDistrictCode}))&&(!isBlank(${costRouteModel.toCityCode}))){
            arrStr = JSON.stringify([${costRouteModel.toProvinceCode},${costRouteModel.toCityCode}])
        }else {

        }

        return arrStr
    }

    function clearNoNum(obj){
        obj.value = obj.value.replace(/[^\d.-]/g,"");  //清除“数字”和“.”以外的字符
        obj.value = obj.value.replace(/^\./g,"");  //验证第一个字符是数字而不是.
        obj.value = obj.value.replace(/\.{2,}/g,"."); //只保留第一个. 清除多余的.
        obj.value = obj.value.replace(".","$#$").replace(/\./g,"").replace("$#$",".");
        obj.value = obj.value.replace(/\.\d{2,}$/,obj.value.substr(obj.value.indexOf('.'),3));//只保留小数点后两位小数
    }
</script>