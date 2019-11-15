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
        doSearch();
        $("#search").click(function(){
            doSearch();
        });

        //新建
        $("#create").click(function(){
            var pageType="Y";
            gpsKmAdjustDetail(pageType);
        });

        //编辑
        $("#edit").click(function(){
            var pageType="N";
            var ids = $("#mainTable").jqGrid('getGridParam',"selarrrow");
            if(!checkedSelect(ids,MsgConstants.getMsg("M00001","一条数据")))
                return;
            gpsKmAdjustDetail(pageType);
        });

    });
    $(window).resize(function(){
        screenResize();
    });

    //编辑&编辑
    function gpsKmAdjustDetail(pageType){
        var url = "${ctxZG}/gpsKmAdjust/gpsKmAdjustDetail?";
        var title = "新建";
        if(pageType=="N"){
            var ids = $("#mainTable").jqGrid('getGridParam',"selarrrow");
            var id = $("#mainTable").getCell(ids[0], 'id');
            url += "&id="+id;
            title = "编辑";
        }
        layer.open({
            type: 2,
            maxmin : true,
            title: title,
            shade: 0.5,
            area: ["1100px", "500px"], //宽高
            content: url
        });
    }

    <!--grid-->
    function doSearch(){
        $("#mainTable").jqGrid('setGridParam',{datatype:"json",url:getPostURL("main"),page:1}).trigger("reloadGrid");
    }

    function getPostURL(tblKey) {
        var url = "${ctxZG}/gpsKmAdjust/search";
        return url + "?" + $("#searchForm").serialize();
    }

    function screenResize() {
        var windowHeight = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
        $("#mainTable").setGridWidth($(window).width() * 0.99);
        $("#mainTable").setGridHeight(windowHeight - $("#selectCondition").height()-$(".content-button").height()-$("#mainPager").height()-65 - $("#content-bottom").height());
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

    function getStr(ids,para){
        var temp='';
        var tempStr='';
        for(var i=0; i<ids.length; i++) {
            temp=$("#mainTable").getCell(ids[i],para);
            tempStr +=","+temp
        }
        tempStr = tempStr.substring(1);
        return tempStr;
    }

    function closeLayerFirm(){
        var i = layer.confirm();
        layer.close(i);
    }

    <!--utils-->
    //非空判断
    function isBlank(obj){
        return(!obj || $.trim(obj) == "");
    }

    function formatMoney(number, places, symbol, thousand, decimal) {
        number = number || 0;
        places = !isNaN(places = Math.abs(places)) ? places : 2;
        symbol = symbol !== undefined ? symbol : "$";
        thousand = thousand || ",";
        decimal = decimal || ".";
        var negative = number < 0 ? "-" : "",
            i = parseInt(number = Math.abs(+number || 0).toFixed(places), 10) + "",
            j = (j = i.length) > 3 ? j % 3 : 0;
        return symbol + negative + (j ? i.substr(0, j) + thousand : "") + i.substr(j).replace(/(\d{3})(?=\d)/g, "$1" + thousand) + (places ? decimal + Math.abs(number - i).toFixed(places).slice(2) : "");
    }
</script>