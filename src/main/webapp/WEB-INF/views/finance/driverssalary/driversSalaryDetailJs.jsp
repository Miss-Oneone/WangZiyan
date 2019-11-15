<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<script type="text/javascript">
    $(document).ready(function(){
        createSelectCondition();
        createGridList("#mainTable", "#mainPager", {
            tblKey:"main"
            ,colNames:eval("${gridModel.colNames}")
            ,colModel:eval("${gridModel.colModel}")
            ,rowList : [ 100, 300, 500 ]
            ,rowNum  :300
            ,loadonce:true
            ,gridComplete:function() {
                var ids = jQuery("#mainTable").jqGrid('getDataIDs');
                for (var i = 0; i < ids.length; i++) {
                    if (ids.length - i <= 8) {
                        setZeroToBlank(ids[i]);
                    }
                }
            }
        });
        $(window).resize();
        doSearch();

    });
    $(window).resize(function(){
        screenResize();
    });

    function setZeroToBlank(rowid) {
        $("#mainTable").jqGrid("setCell", rowid, "stdKmQty", "a");
        $("#mainTable").jqGrid("setCell", rowid, "adjustKm", "a");
        $("#mainTable").jqGrid("setCell", rowid, "stdOilQty", "a");
        $("#mainTable").jqGrid("setCell", rowid, "actualOil", "a");
        $("#mainTable").jqGrid("setCell", rowid, "baseSalary", "a");
        $("#mainTable").jqGrid("setCell", rowid, "otherSubsidy", "a");
        $("#mainTable").jqGrid("setCell", rowid, "totalAmount", "a");
    }

    <!--grid-->
    function doSearch(){
        $("#mainTable").jqGrid('setGridParam',{datatype:"json",url:getPostURL("main"),page:1}).trigger("reloadGrid");
    }

    function getPostURL(tblKey) {
        var url = "${ctxZG}/driversSalary/searchDetail";
        var driverCode = $("#driverCode").val();
        var salaryMonth = $("#salaryMonth").val();
        return url + "?" + "driverCode="+driverCode+ "&salaryMonth="+salaryMonth;
    }

    function screenResize() {
        var windowHeight = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
        $("#mainTable").setGridWidth($(window).width() * 0.99);
        $("#mainTable").setGridHeight(windowHeight - $("#selectCondition").height()-$(".content-button").height()-$("#mainPager").height()-65 - $("#content-bottom").height());
    }

    //导出
    function  doExport(){
        layer.confirm(MsgConstants.getMsg("C00008","票据"), function(){
            closeLayerFirm();
            $.ajax({
                url: "${ctxZG}/invoiceTicket/checkExport" ,
                type: 'POST',
                data: $("#searchForm").serialize(),
                async: false,
                cache: false,
                success: function (data) {
                    var jsonStr = JSON.parse(data);
                    if (jsonStr.length==0) {
                        showError(MsgConstants.getMsg("M00006"));
                    } else {
                        $("#searchForm").attr("action",
                            "${ctxZG}/invoiceTicket/export");
                        $("#searchForm").submit();
                    }

                }
            });
        });
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