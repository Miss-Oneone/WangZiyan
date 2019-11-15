<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<script type="text/javascript">
    var pageType;
	$(document).ready(function(){

        var day1 = new Date();
        var day2 = new Date();
        day1.setTime(day1.getTime()-24*60*60*1000*30);
        var s1 = day1.getFullYear()+"-" + (day1.getMonth()+1) + "-" + day1.getDate();
        var s2 = day2.getFullYear()+"-" + (day2.getMonth()+1) + "-" + day2.getDate();
        $("#beginTime").val(s1).trigger('change');
        $("#endTime").val(s2).trigger('change');
        $("#beginTime").blur(function () {
            var time = (new Date(Date.parse($("#endTime").val().replace(/-/g,   "/")))).getTime()- (new Date(Date.parse($("#beginTime").val().replace(/-/g,   "/")))).getTime();
            if(time<0){
                $("#endTime").val('');
            }
        })
		createGridList("#mainTable", "#mainPager", {
	        tblKey:"main"
	       ,colNames:eval("${gridModel.colNames}")
	       ,colModel:eval("${gridModel.colModel}")
	       ,rowNum  : 100
	       ,rowList : [ 100, 500, 1000 ]
           ,sortable: true
           ,sortorder:"desc"
	       ,multiselect : true
           ,shrinkToFit:true
           ,loadonce:true
	   	});

        $("#search").click(function(){
            if(isBlank($("#beginTime").val()) || isBlank($("#endTime").val())){
                showError("创建时间不能为空！");
                return false;
            }
            var time = (new Date(Date.parse($("#endTime").val().replace(/-/g,   "/")))).getTime()- (new Date(Date.parse($("#beginTime").val().replace(/-/g,   "/")))).getTime();
            var flag = 24*60*60*1000*30*2;
            var a = time - flag;
            if(a >0){
                showError("创建时间间隔不能超过两个月！");
                return false;
            }
            var changeType = $("#changeType").val();
            if(isBlank(changeType)){
                showError("变动类型不能为空！");
                return false;
            }
			doSearch();
		});
         //doSearch();
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


        $("#export").click(function() {
            doExport();
        })

        //页面init
		createSelectCondition();//加减图标-查询栏层的显示和隐藏
        $(window).resize();//显示表格的大小
        var a = [];
        JSON.stringify(a)

	});

	function doExport() {
        var url = "${ctxZG}/mstPriceContractBfChange/export?";
        window.location.href = url + $("#searchForm").serialize();
    }

    //窗口
	$(window).resize(function(){
		screenResize();
	});
    //查询
	function doSearch(){

	    var chargingType = $("#chargingType").val();
        if(chargingType == '2'){
            $("#mainTable").setGridParam().showCol("goodsName");
            $("#mainTable").setGridParam().showCol("goodsWeight");
            $("#mainTable").setGridParam().hideCol("containerName");
        }else{
            $("#mainTable").setGridParam().showCol("containerName");
            $("#mainTable").setGridParam().hideCol("goodsName");
            $("#mainTable").setGridParam().hideCol("goodsWeight");
        }
		$("#mainTable").jqGrid('setGridParam',{datatype:"json",url:getPostURL(),page:1}).trigger("reloadGrid");
        $(window).resize();
	}

	function getPostURL() {
        var url = "${ctxZG}/mstPriceContractBfChange/search";
	    return url+"?" + $("#searchForm").serialize();
	}
   //列表展示
	function screenResize() {
	    var windowHeight = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
	    if($(window).width() * 0.99<1182){
            $("#mainTable").setGridWidth(1182);
        }else{
	        console.log($(window).width() * 0.99)
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
            url:"${ctxZG}/mstPriceContractBf/getCityList",
            key:"provinceCode"
        },{
            url:"${ctxZG}/mstPriceContractBf/getDistrictList",
            key:"cityCode"
        },{
            url:"${ctxZG}/mstPriceContractBf/getCountyList",
            key:"districtCode"
        }])
        return arrStr
    }

    function initSelectNames() {
        var arrStr = JSON.stringify(['provinceCode','cityCode','districtCode','countyCode'])
        return arrStr
    }
    var index;

    function  doCancel() {
        layer.close(index);
    }

</script>