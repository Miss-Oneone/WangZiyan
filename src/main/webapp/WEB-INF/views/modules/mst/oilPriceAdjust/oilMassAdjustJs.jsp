<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<script type="text/javascript">
    var layerIndex;
    $(document).ready(function(){
        createSelectCondition();
        createGridList("#mainTable", "#mainPager", {
            tblKey:"main"
            ,colNames:eval("${gridModel.colNames}")
            ,colModel:eval("${gridModel.colModel}")
            ,rowList : [ 100, 300, 500 ]
            ,multiselect : true
        });
        $(window).resize();

        doSearch();

        $("#search").click(function(){
            doSearch();
        });

        //新建
        $("#create").click(function(){
            var pageType="Y";
            oilMassAdjustDetail(pageType);
        });

        //编辑
        $("#edit").click(function(){
            var pageType="N";
            var ids = $("#mainTable").jqGrid('getGridParam',"selarrrow");
            if(!checkedSelect(ids,MsgConstants.getMsg("M00001","一条数据")))
                return;
            oilMassAdjustDetail(pageType);
        });

    });
    $(window).resize(function(){
        screenResize();
    });

    //编辑&编辑
    function oilMassAdjustDetail(pageType){
        var url = "${ctxZG}/oilMassAdjust/oilMassAdjustDetail?";
        var title = "新建";
        if(pageType=="N"){
            var ids = $("#mainTable").jqGrid('getGridParam',"selarrrow");
            var id = $("#mainTable").getCell(ids[0], 'id');
            url += "&id="+id;
            title = "编辑";
        }
      layerIndex = layer.open({
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
        var url = "${ctxZG}/oilMassAdjust/search";
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

    /**
     * 关闭弹窗
     */
    function closeLayer(){
        layer.close(layerIndex);
    }

    <!--utils-->
    //非空判断
    function isBlank(obj){
        return(!obj || $.trim(obj) == "");
    }

</script>