<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<script type="text/javascript">
    var cnt = 0;
	$(document).ready(function(){
		createGridList("#mainTable", "#mainPager", {
	        tblKey:"main"
	       ,colNames:eval("${gridModel.colNames}")
	       ,colModel:eval("${gridModel.colModel}")
           ,sortable:true
	       ,rowNum  : 500
	       ,rowList : [1000,500,100 ]
	       ,multiselect : true
           ,shrinkToFit:true
            ,onSelectRow : function(id,status) {

            }
            ,onSelectAll:function(aRowids,status){

            }
            ,gridComplete:function() {

            }
            ,editurl : 'clientArray'
	   	});

        $("#search").click(function(){
			doSearch();
		})
        document.onreadystatechange = function () {
            if(document.readyState=="complete") {
                doSearch();
            }
        }

        //新增
        $("#add").click(function () {
            toDetail();
        })

        //编辑
        $("#edit").click(function () {
            var ids = jQuery("#mainTable").jqGrid('getGridParam', 'selarrrow');
            if(!ids || ids.length !=1) {
                validate("请选择一条数据")
                return;
            }
            var obj = jQuery("#mainTable").jqGrid('getRowData', ids[0]);
            toDetail(obj.id)
        })

        $("#export").click(function(){
            doExport();
        });

        //页面init
		createSelectCondition();//加减图标-查询栏层的显示和隐藏
		$(window).resize();//显示表格的大小

        setGroupHeaders();
        setColHeader();
	});
    //列表窗口
	$(window).resize(function(){
		screenResize();
	});
    //列表查询
	function doSearch(){
        $("#mainTable").jqGrid('setGridParam',{datatype:"json",url:getPostURL("main"),page:1}).trigger("reloadGrid");
    }

	function getPostURL(tblKey) {
	    var url = "${ctxZG}/costRoute/search";
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

	    $("#mainTable").setGridHeight(windowHeight - $("#selectCondition").height()-$(".ui-jqgrid-labels").height()-$("#mainPager").height()-$("#content-bottom").height()-85);
	    $("#footer").width($("#gbox_mainTable").width());
	}

    var index
    function toDetail(id) {
        var url = "${ctxZG}/costRoute/detail"
        if(id) {
            url = url + "?id=" + id
        }
        index =  layer.open({
            type : 2,
            area : [ "800px", "350px" ],
            title : false,
            closeBtn: false,
            content : url,
            cancel : function() {
            }
        })
    }

    //非空判断
    function isBlank(obj){
        return(!obj || $.trim(obj) === "");
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

    function back() {
        layer.close(index)
        doSearch();
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

    function doExport() {
        var url = "${ctxZG}/costRoute/export?";
        window.location.href = url + $("#searchForm").serialize();
    }
</script>