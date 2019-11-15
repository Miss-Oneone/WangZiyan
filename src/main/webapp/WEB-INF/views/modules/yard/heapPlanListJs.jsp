<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<script type="text/javascript">
    var levelColor = ['#ff9d9d', '#ffd693', '#ffff84', '#c8ffa0'];
    var editLayerIndex;
    $(document).ready(function () {
        createGridList("#mainTable", "#mainPager", {
            tblKey:"main"
            ,colNames:eval("${gridModel.colNames}")
            ,colModel:eval("${gridModel.colModel}")
            ,sortable:true
            ,footerrow: true
            ,rowNum  : 500
            ,rowList : [1000,500,100 ]
            ,multiselect : true
            ,shrinkToFit:true
            ,onSelectRow : function(id,status) {
            }
            ,onSelectAll:function(aRowids,status) {
            }
            ,gridComplete:function() {
                var ids=$("#mainTable").jqGrid('getDataIDs');
                var now = getDate();
                for(var j=0; j<ids.length; j++){
                    var planDate = $("#mainTable").getCell(ids[j],'planDate');
                    var status = $("#mainTable").getCell(ids[j],'status');
                    var difDays = datedifference(planDate, now);
                    if (difDays < 0) {
                        difDays = 0;
                    }
                    var color = levelColor[difDays];

                    if (status == '已处理') {
                        color = '#eee'
                    }
                    if (color) {
                        $("#mainTable").jqGrid('setRowData', ids[j], false, {background: color});
                    }
                }

                $("[aria-describedby='mainTable_planDate']").css("text-align", "right");
                $("[aria-describedby='mainTable_position']").css("text-align", "right");
                $("[aria-describedby='mainTable_status']").css("text-align", "center");
                $("[aria-describedby='mainTable_sealNo']").css("text-align", "center");
                allCount();
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

        $("#updatePlanDate").click(function(){
            doUpdatePlanDate();
        })

        //页面init
        createSelectCondition();//加减图标-查询栏层的显示和隐藏
        $(window).resize();//显示表格的大小
    })

    //列表窗口
    $(window).resize(function(){
        screenResize();
    });

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

    //列表查询
    function doSearch(){
        $("#mainTable").jqGrid('setGridParam',{datatype:"json",url:getPostURL("main"),page:1}).trigger("reloadGrid");
    }

    function getPostURL(tblKey) {
        var url = "${ctxZG}/yard/searchPlan";
        return url+"?" + $("#searchForm").serialize();
    }

    function doUpdatePlanDate() {
        var ids = jQuery("#mainTable").jqGrid('getGridParam', 'selarrrow');
        if (!ids || ids.length == 0) {
            showError("请至少选择一条数据");
            return;
        }

        var heapPlanIds = [];
        for (var idx in ids) {
            var obj = jQuery("#mainTable").jqGrid('getRowData', ids[idx]);
            var status = obj.status;
            if (status == '已处理') {
                showError("存在计划已处理，已处理的不能再修改，请确认后再进行操作");
                return;
            }
            heapPlanIds.push(obj.id);
        }

        editLayerIndex = layer.open({
            title: '修改计划日期',
            type : 2,
            area : [ "400px", "180px" ],
            content : "${ctxZG}/yard/heapPlanDateEdit?heapPlanIds=" + heapPlanIds.join("-"),
            maxmin : true,
            cancel : function() {
                //do nothing
            }
        })
    }

    function datedifference(sDate1, sDate2) {    //sDate1和sDate2是2006-12-18格式
        var dateSpan, tempDate, iDays;
        sDate1 = Date.parse(sDate1);
        sDate2 = Date.parse(sDate2);
        dateSpan = sDate1 - sDate2;
//        dateSpan = Math.abs(dateSpan);
        iDays = Math.floor(dateSpan / (24 * 3600 * 1000));
        return iDays
    }

    function getDate() {
        var date = new Date();
        var month = date.getMonth() + 1;
        var strDate = date.getDate();
        if (month >= 1 && month <= 9) {
            month = "0" + month;
        }
        if (strDate >= 0 && strDate <= 9) {
            strDate = "0" + strDate;
        }
        var currentDate = date.getFullYear() + '-' + month + '-' + strDate;
        return currentDate;
    }

    function back() {
        parent.close(false);
    }

    function close() {
        layer.close(editLayerIndex);
    }

    function allCount(){
        $.ajax({
            url: "${ctxZG}/yard/totalPlans?" + $("#searchForm").serialize(),
            type: "post",
            success: function (result) {
                var obj = JSON.parse(result);
                if (obj.resultType == BizConstant.SUCCESS) {
                    $("#mainTable").jqGrid('footerData', 'set',
                        {status: '已处理：',planDate: obj.dataModel.cntProcessed}, false);
                    $("#mainTable").jqGrid('footerData', 'set',
                        {sealNo: '未处理：',position: obj.dataModel.cntUntreated}, false);
                } else {
                    showError(obj.resultMsg);
                }
            },
            error: function (xhr, status, error) {
                showError("系统错误");
            }
        })
    }
</script>