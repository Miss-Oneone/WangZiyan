<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<script type="text/javascript">
    var amountInit=0.00;
    var last;//上个选取数
    $(document).ready(function(){
        var type = "${type}";
        if(!type){
            $("#contractGrid").show();
        }else{
            $("#contractGrid").hide();
        }

        $("#return").click(function(){
            parent.doCancel();
        })

        $("#add").click(function () {
            if (isBlank($("#name").val())){
                showError("名称不能为空！");
                return false;
            }else
            if (isBlank($("#address").val())){
                showError("地址不能为空！");
                return false;
            }
//            else if (isBlank($("#contactPerson").val())){
//                showError("联系人1不能为空！");
//                return false;
//            }else if (isBlank($("#contactPhone").val())){
//                showError("电话1不能为空！");
//                return false;
//            }
            var index;
            for (var i=0;i<($("div[id^='provinceCodeCopy']").length);i++){
                if(i>0){
                    if ($($("div[id^='provinceCodeCopy']")[i]).is(":hidden")){
                        index = i;
                        i = $("div[id^='provinceCodeCopy']").length;
                    }
                }
            }
            if(!index){
                index = $("div[id^='provinceCodeCopy']").length;
            }
            if(!$($("select[id^='provinceCodeCopy']")[index-1]).val()){
                showError("地区不能为空且必须选到最后一级！");
                return false;
            }

            doSave();
        })
    });

    //列表查询
    function doSearch(main,address){
        //js方法  
        $(main).jqGrid('setGridParam',{datatype:"json",url:getPostURL(address),page:1,beforeSelectRow: beforeSelectRow}).trigger("reloadGrid");
        jQuery(main).jqGrid('filterToolbar',{searchOperators : true});
    }

    function doSave() {
        $.ajax({
            url:"${ctxZG}/zxAddress/save",
            data: $("#saveForm").serialize(),
            type:"post",
            success:function(result){
                var obj = JSON.parse(result);
                if(obj.resultType == BizConstant.SUCCESS){
                    showTip(obj.resultMsg);
                    setTimeout(function(){
                        parent.doCancel();
                    },1000)
                }else{
                    showError(obj.resultMsg);
                }
                if(typeof parent.doSearch == 'function'){
                    parent.doSearch();
                }

                if(typeof parent.setNewZxdAddrs == 'function') {
                    parent.setNewZxdAddrs($("#type").val(), obj.dataModel);
                    parent.doCancel();
                }
            },
            error:function(xhr,status,error){
                showError("系统错误");
            }
        })
    }

    function beforeSelectRow(data,obj){
        var c = $(obj.target).parent()[0].classList[1];
        var isCheck;
        isCheck = $(obj.target).prop('checked');//这个得到的是true或是false表示是否有选中
                $(obj.target).parent().parent().parent().find('.'+c).find('input[type="checkbox"]').prop('checked',false);
                $(obj.target).parent().parent().parent().find('.'+c).find('input[type="checkbox"]').attr('mineTitle','');
                $(obj.target).prop('checked',isCheck);
                if(!isCheck){
                    $(obj.target).attr('mineTitle','');
                }else{
                    $(obj.target).attr('mineTitle',data);
                }

    }

    function getPostURL(addresss) {
        var url = "${ctxZG}/zxAddress/"+addresss;
        return url+"?"+$("#addAddress").serialize();
    }

    //列表展示
    function screenResize(str) {
        var windowHeight = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
        $(str).setGridWidth($("#mainTableContent").width() * 0.99);
        $(str).setGridHeight(windowHeight*0.25);
        $("#footer").width($("#gbox_mainTable").width());
    }

    //非空判断
    function isBlank(obj){
        return(!obj || $.trim(obj) === "");
    }

    function getSpecialContract() {

        doSearch("#mainTable","getSpecialContract");
        doSearch("#mainTableTwo","getSpecialContractLclBf");
        doSearch("#mainTableThree","getSpecialCostOutContractBf");
        doSearch("#mainTableFour","getSpecialRoute");
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
        var arrStr = JSON.stringify(['provinceCode','cityCode','districtCode','countyCode'])
        return arrStr
    }

    function afterCompleteFunction(str){
        var ids = $(str).getDataIDs();
        var contract = '';
        var flag = 0;
        var cssClass = ["deSelectBG", "SelectBG"];
        var cssAddNum = [0,0];
        var number = 0;
        var arrtName;

        if (str == "#mainTable"){
            arrtName = 'containerType';
        }else
            if(str == "#mainTableTwo"){
                arrtName = 'goodsType';
        }else
            if(str == "#mainTableThree"){
                arrtName = 'bfLevelCode';
            }
        for(var i=0;i<ids.length;i++){
            var rowData = $(str).getRowData(ids[i]);
            if(i>0){
                if (rowData[arrtName]!= $(str).getRowData(ids[i-1])[arrtName]){
                    number++;
                }
            }
            if(rowData.contract != contract){
                if(flag == 0) {
                    flag = 1;
                    cssAddNum[flag]++;
                }else {
                    flag = 0;
                    cssAddNum[flag]++;
                }
                contract = rowData.contract;
            }

            $('#'+ids[i]).find("td").addClass(cssClass[flag]+" "+cssClass[flag]+'-'+cssAddNum[flag].toString()+'-'+number);
        }
    }

    function afterCompleteFunctionFour(str){
        var ids = $(str).getDataIDs();
        var reContract = '';
        var flag = 0;
        var cssClass = ["deSelectBG", "SelectBG"];
        var cssAddNum = [0,0];
        for(var i=0;i<ids.length;i++){
            var rowData = $(str).getRowData(ids[i]);
            if(rowData.contract.replace(rowData.costRouteCode+" ","")!= reContract){
                if(flag == 0) {
                    flag = 1;
                    cssAddNum[flag]++;
                }else {
                    flag = 0;
                    cssAddNum[flag]++;
                }
                reContract = rowData.contract.replace(rowData.costRouteCode+" ","");
            }

            $('#'+ids[i]).find("td").addClass(cssClass[flag]+" "+cssClass[flag]+'-'+cssAddNum[flag].toString());
        }
    }

    function setDefaultCheck(){
        var arrStr = [];
        if (!isBlank(${zxAddressModel.countyCode})){
            arrStr = JSON.stringify([${zxAddressModel.provinceCode},${zxAddressModel.cityCode},${zxAddressModel.districtCode},${zxAddressModel.countyCode}])
        }else if(isBlank(${zxAddressModel.countyCode})&&(!isBlank(${zxAddressModel.districtCode}))){
            arrStr = JSON.stringify([${zxAddressModel.provinceCode},${zxAddressModel.cityCode},${zxAddressModel.districtCode}])
        }else if(isBlank(${zxAddressModel.countyCode})&&(isBlank(${zxAddressModel.districtCode}))&&(!isBlank(${zxAddressModel.cityCode}))){
            arrStr = JSON.stringify([${zxAddressModel.provinceCode},${zxAddressModel.cityCode}])
        }else {

        }

        return arrStr
    }

    //清空列表数据
    function dataInfo(){
        jQuery("#mainTable").jqGrid("clearGridData");
        jQuery("#mainTableTwo").jqGrid("clearGridData");
        jQuery("#mainTableThree").jqGrid("clearGridData");
        jQuery("#mainTableFour").jqGrid("clearGridData");
    }

</script>