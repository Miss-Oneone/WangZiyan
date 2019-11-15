<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<script type="text/javascript">
    if ("${noData}" == "noData") {
        showError(MsgConstants.getMsg("M00006"))
    }
    $(document).ready(function(){
        createSelectCondition();
        createGridList("#mainTable", "#mainPager", {
            tblKey:"main"
            ,colNames:eval("${gridModel.colNames}")
            ,colModel:eval("${gridModel.colModel}")
            ,rowList : [ 100, 300, 500 ]
            ,multiselect : true
            ,
        });
        $(window).resize();
        document.onreadystatechange = function () {
            if(document.readyState=="complete") {
                doSearch();
            }
        }
        $("#search").click(function(){
            doSearch();
        });

        //编辑
        $("#edit").click(function(){
            var pageType="edit";
            var ids = $("#mainTable").jqGrid('getGridParam',"selarrrow");
            if(!checkedSelect(ids,MsgConstants.getMsg("M00001","一条数据")))
                return;
            mstContnOwnerInfoHeader(pageType);
        });

        //新建
        $("#build").click(function(){
            var pageType="create";
            mstContnOwnerInfoHeader(pageType);
        });

        $("#delete").click(function () {
            var ids = $("#mainTable").jqGrid('getGridParam',"selarrrow");
            if(ids.length==0) {
                showError(MsgConstants.getMsg("M00001","一条数据"));
                return;
            }
            var plateNums = '';
            for (var i=0;i<ids.length;i++) {
                plateNums = plateNums + "'" + $("#mainTable").getCell(ids[i], 'plateNum') + "'" + ",";
            }
            plateNums = plateNums.substring(0,plateNums.length - 1);
            deleteSelfTrailer(plateNums);
        });

        //导出
        $("#export").click(function () {
            doExport();
        });

    });
    $(window).resize(function(){
        screenResize();
    });

    //删除
    function deleteSelfTrailer(plateNums) {
        var url = "${ctxZG}/selfTrailer/deleteSelfTrailer";
        layer.confirm("确定删除自有车辆信息？", function () {
            $.ajax({
                url: url,
                type: "post",
                data: {
                    plateNums: plateNums
                },
                success: function (data) {
                    closeLoading();
                    var obj = JSON.parse(data);
                    layer.alert(obj.resultMsg, function (index) {
                        doSearch();
                        layer.closeAll();
                    });
                }
            });
        });
    }

    //编辑
    function mstContnOwnerInfoHeader(pageType){
        var url = "${ctxZG}/selfTrailer/selfTrailerDetail?";
        var title = "新建自有车辆";
        url += "&pageType="+pageType;
        if(pageType=="edit"){
            var ids = $("#mainTable").jqGrid('getGridParam',"selarrrow");
            var plateNum = $("#mainTable").getCell(ids[0], 'plateNum');
            url += "&plateNum="+plateNum;
            title = "编辑自有车辆";
        }
        layer.open({
            type: 2,
            maxmin : true,
            title: title,
            shade: 0.5,
            area: ["1150px", "500px"], //宽高
            content: url
        });
    }

    //导出
    function doExport() {
        layer.confirm(MsgConstants.getMsg("C00009", "自有车辆导出"), function () {
            closeLayerFirm();
            $("#searchForm").attr("action","${ctxZG}/selfTrailer/export?" + $("#searchForm").serialize());
            $("#searchForm").submit();
        });
    }

    <!--grid-->
    function doSearch(){
        $("#mainTable").jqGrid('setGridParam',{datatype:"json",url:getPostURL("main"),page:1}).trigger("reloadGrid");
    }

    function getPostURL(tblKey) {
        var url = "${ctxZG}/selfTrailer/search";
        return url + "?" + $("#searchForm").serialize();
    }

    function screenResize() {
        var windowHeight = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
        $("#mainTable").setGridWidth($(window).width() * 0.99);
        $("#mainTable").setGridHeight(windowHeight - $("#selectCondition").height()-$(".content-button").height()-$("#mainPager").height()-50 - $("#content-bottom").height());
    }

    //grid选中检查
    function checkedSelect(ids,errorInfo){
        if(ids.length==0){
            showError(errorInfo);
            return false;
        }else{
            if(errorInfo==MsgConstants.getMsg("M00001","一条数据")&&ids.length!=1){
                showError(errorInfo);
                return false;
            }else{
                return true;
            }
        }
        return true;

    }

    function closeLayerFirm() {
        var i = layer.confirm();
        layer.close(i);
    }

    <!--utils-->
    //非空判断
    function isBlank(obj){
        return(!obj || $.trim(obj) == "");
    }
    
    function plateNumRefresh() {
        var url = "${ctxZG}/selfTrailer/getTruckPlateNo";
        $.ajax({
            url: url,
            type: "post",
            data: {},
            success: function (data) {
                var obj = eval('(' + data + ')');
                initSelect("plateNum", obj, false, false, false, true, 200, "");
                showTip("刷新完成！", 800);
            }
        });
    }
</script>