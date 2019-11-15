<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<script type="text/javascript">
    var pageType;
    var priceContractNoIsSelct = "";
    var initFlag = true;
	$(document).ready(function(){
	    window.onload = function () {
            var priceContractNo = $("#priceContractNo").val();
            changePriceContractNoEffectiveStatus(priceContractNo);
            setTimeout(doSearch, 1000)
        };
		createGridList("#mainTable", "#mainPager", {
	        tblKey:"main"
	       ,colNames:eval("${gridModel.colNames}")
	       ,colModel:eval("${gridModel.colModel}")
	       ,rowNum  : 100
	       ,rowList : [ 100, 500, 1000 ]
	       ,multiselect : true
	   	});

        $("#search").click(function(){
			doSearch();
		});

        $("#chargingType").change(function () {
            var chargingType = $("#chargingType").val();

            if(chargingType=='2'){
                $("#containerType").val("");
                $("#containerType").trigger('change');
                $("#containerType").prop("disabled", true);
            }else{
                $("#containerType").prop("disabled", false);
            }
        });

		$("#Add").click(function () {
            var ids = jQuery("#mainTable").jqGrid('getGridParam', 'selarrrow');
            var id="";
            if (ids.length == 1){
                id = ids[0];
            }
           priceContractNoIsSelct = $("#priceContractNo").val();
            pageType = "create";

            addOrUpdate(id);
        });

        $("#Edit").click(function() {

            var ids = jQuery("#mainTable").jqGrid('getGridParam', 'selarrrow');
            if (ids.length != 1){
                showError(MsgConstants.getMsg("M00001", "一条数据"));
            }else {
                var id = ids[0];
                pageType = "edit";
                addOrUpdate(id);
            }
        });

        $("#Copy").click(function() {

            var ids = jQuery("#mainTable").jqGrid('getGridParam', 'selarrrow');
            var id;
            if (ids.length != 1){
                showError(MsgConstants.getMsg("M00001", "一条数据"));
            }else {
                id = ids[0];
                pageType = "copy";
                addOrUpdate(id);
            }
        });

        $("#delete").click(function () {
            var ids = jQuery("#mainTable").jqGrid('getGridParam', 'selarrrow');
            if (ids.length == 0){
                showError(MsgConstants.getMsg("M00001", "一条或多条数据"));
            }else {
                var data = new Array();
                for (var i = 0; i < ids.length; i++) {
                    var obj = jQuery("#mainTable").jqGrid('getRowData', ids[i]);
                    data.push({
                        "id":obj.id,
                        "chargingType":obj.chargingType
                    });
                }
                deletePriceContractBf(data);
            }
        });

        $("#export").click(function() {
            doExport();
        });

        /**
         * 批量导入
         * */
        $("#import").click(function () {
            importPrice();
        })

        //页面init
		createSelectCondition();//加减图标-查询栏层的显示和隐藏
		$(window).resize();//显示表格的大小
        var a = [];
        JSON.stringify(a)

        /*$("#effectiveStatus").change(function () {
            changePriceContractList();
        });*/

        $("#priceContractNo").change(function () {
            var priceContractNo = $("#priceContractNo").val();
            changePriceContractNoEffectiveStatus(priceContractNo);
        });

        setGroupHeaders();
        setColHeader();
	});
	
	function changePriceContractNoEffectiveStatus(priceContractNo) {
        $.ajax({
            type : "post",
            url : "${ctxZG}/mstPriceContractBf/changePriceContractNoEffectiveStatus",
            data : {
                "priceContractNo" : priceContractNo
            },
            success : function(data) {
                $("#priceContractNoEffectiveStatus").val(data);
                $("#priceContractNoEffectiveStatus").trigger('change');
                doCancel();
            }
        });
    }

    function changePriceContractList() {
        var effectiveStatus = $("#effectiveStatus").val();
        //对方帐户下拉框清空
        $("#priceContractNo option").remove();
        $("#priceContractNo").select2("val", "");

        $.ajax({
            type : "post",
            url : "${ctxZG}/mstPriceContractBf/changePriceContractList",
            data : {
                "effectiveStatus" : effectiveStatus
            },
            success : function(data) {
                if (data != "") {
                    var json = JSON.parse(data);
                    if (json.length > 0) {
                        $("#priceContractNo").append("<option value=''></option>");
                        for (var i = 0; i < json.length; i++) {
                            $("#priceContractNo").append(
                                "<option value='"+json[i].value+"'>"
                                + json[i].text + "</option>");
                        }
                    } else {
                        $("#priceContractNo option").remove();
                    }
                    $("#priceContractNo").trigger('change');
                    if(initFlag){
                        $("#priceContractNo").val('${priceContractNo}');
                        $("#priceContractNo").trigger('change');
                        setTimeout(doSearch, 1000)
                    }
                    initFlag = false;
                }
            }
        });
    }
	function doExport() {
        var url = "${ctxZG}/priceContract/exportBf?";
        window.location.href = url + $("#searchForm").serialize();
    }

	function deletePriceContractBf(data) {
        openLoading();
        var index = layer.confirm("确认删除运费？", function() {
            $.ajax({
                url:"${ctxZG}/priceContract/deleteBf",
                type:"post",
                data:{"data":JSON.stringify(data)},
                success:function (result) {
                    closeLoading();
                    var obj = JSON.parse(result);
                    if(obj.resultType == BizConstant.SUCCESS){
                        showTip(obj.resultMsg);
                    }else{
                        showError(obj.errorMsg);
                    }
                    doSearch();
                    layer.close(index);
                },
                error:function(xhr,status,error){
                    closeLoading();
                    showError("系统错误");
                    layer.close(index);
                }
            });
        },function() {
            closeLoading();
        });
    }
    //窗口
	$(window).resize(function(){
		screenResize();
	});
    //查询
	function doSearch(){
	    var chargingType = $("#chargingType").val();
		$("#mainTable").jqGrid('setGridParam',{datatype:"json",url:getPostURL(),page:1}).trigger("reloadGrid");
	}

	function getPostURL() {
        var url = "${ctxZG}/priceContract/searchBf";
	    return url+"?" + $("#searchForm").serialize();
	}
   //列表展示
	function screenResize() {
	    var windowHeight = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
	    if($(window).width() * 0.99<1182){
            $("#mainTable").setGridWidth(1182);
        }else{
            $("#mainTable").setGridWidth($(window).width() * 0.99);
        }

	    $("#mainTable").setGridHeight(windowHeight - $("#searchForm").height()-$(".ui-jqgrid-labels").height()-$("#mainPager").height()-$("#content-bottom").height()-80);
	    $("#footer").width($("#gbox_mainTable").width());
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

    var index;
    //增加协议运费明细页面
    function addOrUpdate(id) {
        var obj;
        var url = "${ctxZG}/priceContract/priceContractBfDetail?";
        url += "&pageType="+pageType;

        if(!isBlank(id)){
            obj = jQuery("#mainTable").jqGrid('getRowData', id);
            url += "&id="+obj.id;
            url += "&chargingType=" + obj.chargingType;
        }
        if (!isBlank(priceContractNoIsSelct)){
            url += "&priceContractNoIsSelct=" + priceContractNoIsSelct;
        }
        index =  layer.open({
            id :'test',
            type : 2,
            maxmin : true,
            area : [ "1100px", "550px" ],
            title : '新增协议运费',
            content : url,
            cancel : function() {

            }
        })
    }

    function  doCancel() {
        layer.close(index);
    }

    function setDefaultCheck(){
        var arrStr = [];
        if (!isBlank(${fromCountyCode})){
            arrStr = JSON.stringify([${fromProvinceCode},${fromCityCode},${fromDistrictCode},${fromCountyCode}])
        }else if(isBlank(${fromCountyCode})&&(!isBlank(${fromDistrictCode}))){
            arrStr = JSON.stringify([${fromProvinceCode},${fromCityCode},${fromDistrictCode}])
        }else if(isBlank(${fromCountyCode})&&(isBlank(${fromDistrictCode}))&&(!isBlank(${fromCityCode}))){
            arrStr = JSON.stringify([${fromProvinceCode},${fromCityCode}])
        }else {

        }

        return arrStr
    }

    function setToAdrsDefaultCheck(){
        var arrStr = [];
        if (!isBlank(${toCountyCode})){
            arrStr = JSON.stringify([${toProvinceCode},${toCityCode},${toDistrictCode},${toCountyCode}])
        }else if(isBlank(${toCountyCode})&&(!isBlank(${toDistrictCode}))){
            arrStr = JSON.stringify([${toProvinceCode},${toCityCode},${toDistrictCode}])
        }else if(isBlank(${toCountyCode})&&(isBlank(${toDistrictCode}))&&(!isBlank(${toCityCode}))){
            arrStr = JSON.stringify([${toProvinceCode},${toCityCode}])
        }else {

        }

        return arrStr
    }

    //批量导入
    function importPrice() {
        index = layer.open({
            type : 2,
            maxmin : true,
            area : [ "400px", "200px" ],
            title : '导入价格协议',
            content : "${ctxZG}/priceContract/importPrice",
            cancel : function() {
                // 点击关闭按钮时触发当前页面的查询按钮。
                if (typeof doSearch === 'function') {
                    doSearch();
                }
            }
        });
    }

    //公共调用方法
    function merger(gridName, cellName, colNames) {
        //得到显示到界面的id集合
        var mya = $("#" + gridName + "").getDataIDs();
        //当前显示多少条
        var length = mya.length;
        for (var i = 0; i < length; i++) {
            //从上到下获取一条信息
            var before = $("#" + gridName + "").jqGrid('getRowData', mya[i]);
            //定义合并行数
            var rowSpanTaxCount = 1;
            for (j = i + 1; j <= length; j++) {
                //和上边的信息对比 如果值一样就合并行数+1 然后设置rowspan 让当前单元格隐藏
                var end = $("#" + gridName + "").jqGrid('getRowData', mya[j]);
                if (before[cellName] == end[cellName]) {
                    rowSpanTaxCount++;
                    $("#" + gridName + "").setCell(mya[j], cellName, '', { display: 'none' });
                    if (colNames && colNames.length>0) {

                        for (var idx in colNames) {
                            $("#" + gridName + "").setCell(mya[j], colNames[idx], '', { display: 'none' });
                        }
                    }
                } else {
                    rowSpanTaxCount = 1;
                    break;
                }
                $("#" + cellName + "" + mya[i] + "").attr("rowspan", rowSpanTaxCount);
                if (colNames && colNames.length>0) {
                    for (var idx in colNames) {
                        $("#" + colNames[idx] + "" + mya[i] + "").attr("rowspan", rowSpanTaxCount);
                    }
                }
            }
        }
    }

    function setGroupHeaders() {
        $("#mainTable").jqGrid('setGroupHeaders', {
            useColSpanStyle: true
            , groupHeaders: [{
                startColumnName: 'fromProvinceName',  // 对应colModel中的name
                numberOfColumns: 4,  // 跨越的列数
                titleText: '<div align="center"><span id="headerDate1"></span></div>'
            }, {
                startColumnName: 'toProvinceName',  // 对应colModel中的name
                numberOfColumns: 4,  // 跨越的列数
                titleText: '<div align="center"><span id="headerDate2"></span></div>'
            }]
        });
    }

    function setColHeader() {
        $('#headerDate1').text('起运地');
        $('#headerDate2').text('到达地');
    }
</script>