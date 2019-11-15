<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<script type="text/javascript">
    $(document).ready(function () {
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
            ,onSelectAll:function(aRowids,status) {
            }
            ,gridComplete:function() {
                var ids=$("#mainTable").jqGrid('getDataIDs');
                for(var j=0; j<ids.length; j++){
                    var status = $("#mainTable").getCell(ids[j],'status');
                    if (status == "已处理") {
                        $("#mainTable").jqGrid('setRowData', ids[j], false, {background: '#eee'});
                    }
                }
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

        $("#detail").click(function(){
            toDetail();
        })

        $("#delete").click(function(){
           doDelete();
        })

        $("#export").click(function(){
            doExport();
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
        var url = "${ctxZG}/yard/searchHd";
        return url+"?" + $("#searchForm").serialize();
    }

    var planLayerIdx;
    function toDetail() {
        var ids = jQuery("#mainTable").jqGrid('getGridParam', 'selarrrow');
        if (!ids || ids.length == 0) {
            showError("请选择一条数据");
            return;
        }
        if (ids.length > 1) {
            showError("只能选择一条数据");
            return;
        }
        var obj = jQuery("#mainTable").jqGrid('getRowData', ids[0]);
        var batchNo = obj.batchNo;
        var status = obj.status;
        if (status == '已处理') {
//            showError("当前导入计划已处理，不能重复操作");
//            return;
        }
        planLayerIdx = layer.open({
            title: '导入计划明细',
            type : 2,
            maxmin : true,
            area : [ "400px", "330px" ],
            content : "${ctxZG}/yard/heapPlanImportDtl?batchNo=" + batchNo,
            maxmin : true,
            cancel : function() {
                //do nothing
            },
            end: function () {
                doSearch();
            }
        })
        layer.full(planLayerIdx);
    }

    function doDelete() {
        var ids = jQuery("#mainTable").jqGrid('getGridParam', 'selarrrow');
        if (!ids || ids.length == 0) {
            showError("请至少选择一条数据");
            return;
        }

        var heapPlanImportHdIds = [];
        for (var idx in ids) {
            var obj = jQuery("#mainTable").jqGrid('getRowData', ids[idx]);
            var status = obj.status;
            if (status == '已处理') {
                showError("存在导入计划已处理，已处理的不能再删除，请确认后再进行操作");
                return;
            }
            heapPlanImportHdIds.push(obj.id);
        }
        var index = layer.confirm("确定删除吗？", {
            btn: ['确定','取消'], //按钮
            icon: 7
        }, function () {
            layer.close(index);
            $.ajax({
                url: "${ctxZG}/yard/deleteHd",
                type: "post",
                data: {heapPlanImportHdIds: JSON.stringify(heapPlanImportHdIds)},
                success: function (result) {
                    var obj = JSON.parse(result);
                    if (obj.resultType == BizConstant.SUCCESS) {
                        showTip("删除成功")
                        doSearch();
                    } else {
                        showError(obj.resultMsg);
                    }
                },
                error: function (xhr, status, error) {
                    showError("系统错误");
                }
            })
        })
    }

    function doExport() {
        var ids = jQuery("#mainTable").jqGrid('getGridParam', 'selarrrow');
        if (!ids || ids.length == 0) {
            showError("请至少选择一条数据");
            return;
        }

        var batchNos = [];
        for (var idx in ids) {
            var obj = jQuery("#mainTable").jqGrid('getRowData', ids[idx]);
            var status = obj.status;
            if (status == '已处理') {
                showError("存在导入计划已处理，已处理的不能再排计划，请确认后再进行操作");
                return;
            }
            batchNos.push(obj.batchNo);
        }

        var url = "${ctxZG}/yard/multBatchExportDtls?batchNos=";
        window.location.href = url + JSON.stringify(batchNos);
    }

    function back() {
        layer.close(planLayerIdx);
    }
</script>