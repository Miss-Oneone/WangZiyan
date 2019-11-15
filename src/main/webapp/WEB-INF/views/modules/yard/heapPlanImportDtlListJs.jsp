<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<script type="text/javascript">
    $(document).ready(function () {
        if (${isCompleted == true}) {
            $("#createPlan").prop('disabled', true).trigger('changed');
        }

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
                countChoseQty();
            }
            ,onSelectAll:function(aRowids,status) {
                countChoseQty();
            }
            ,gridComplete:function() {
                var ids = jQuery("#mainTable").jqGrid('getDataIDs');
                if (ids && ids.length > 0) {
                    var obj = jQuery("#mainTable").jqGrid('getRowData', ids[0]);
                    $("#batchNo_tip").html(obj.batchNo);
                    $("#goodsNo").html(obj.goodsNo);
                    $("#goodsOweQuantity").html(obj.goodsOweQuantity);
                    $("#customsClearanceDate").html(obj.customsClearanceDate);
                    $("#choseQty").html('0');
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

        $("#createPlan").on('click', function () {
            createPlan();
        })

        $("#export").on('click', function () {
            doExport();
        })

        $("body").on('click', closeTip);
        window.onmousewheel = closeTip;

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
        var url = "${ctxZG}/yard/searchDtl";
        return url+"?" + $("#searchForm").serialize();
    }

    function countChoseQty(notTipFlag) {
        var ids = jQuery("#mainTable").jqGrid('getGridParam', 'selarrrow');
        var choseQty = 0;
        if (ids && ids.length > 0) {
            for (var idx in ids) {
                var obj = jQuery("#mainTable").jqGrid('getRowData', ids[idx]);
                choseQty += Number(obj.quantity);
            }
        }
        $("#choseQty").html(choseQty);
        return choseQty;
    }

    var layerIndex3
    function createPlan() {
        var choseQty = countChoseQty(true);
        var goodsOweQuantity = Number($("#goodsOweQuantity").html());
        var msg = "确认生成计划？";
        if (choseQty == 0) {
            showError("请先选择数据");
            return;
        }
        var planDate = $("#planDate").val();
        if (!planDate) {
            showError("请填写计划日期")
            return;
        }
        var referFlag = $("#referFlag").is(":checked") ? "Y" : "N";
        debugger
        if (choseQty < goodsOweQuantity) {
            msg = "当前已选箱数小于欠货数量，是否继续生成计划？";
        }
        layerIndex3 = layer.confirm(msg, {
            btn: ['确定','取消'], //按钮
            icon: 7
        }, function () {
            var batchNo = $("#batchNo").val();
            var heapImportDtlIds = [];
            var ids = jQuery("#mainTable").jqGrid('getGridParam', 'selarrrow');
            for (var idx in ids) {
                var obj = jQuery("#mainTable").jqGrid('getRowData', ids[idx]);
                heapImportDtlIds.push(obj.id);
            }
            $.ajax({
                url: "${ctxZG}/yard/createHeapPlan?batchNo=" + batchNo + "&planDate=" + planDate + "&heapImportDtlIds=" + JSON.stringify(heapImportDtlIds) + "&referFlag=" + referFlag,
                type: "post",
                success: function (result) {
                    var obj = JSON.parse(result);
                    if (obj.resultType == BizConstant.SUCCESS) {
                        showTip("操作成功");
                        setTimeout(function () {
                            window.location.href = '${ctxZG}/yard/heapPlan?planDate='+ planDate;
                        }, 1000)
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

    function back() {
        parent.close(false);
    }

    function doExport() {
        var url = "${ctxZG}/yard/exportDtl?";
        window.location.href = url + $("#searchForm").serialize();
    }

    function sameHeapAction(value, row, obj) {
        var editDelStr = value;
        var mainSameHeapContnNos = obj.mainSameHeapContnNos
        if(!isBlank(value) && Number(value) > 0) {
            editDelStr='<a id="sameHeapContnBox-'+ obj.id +'" class="a-info" style="color: blue" href="javascript:void(0);" onclick="showSameHeapContns(\''+ mainSameHeapContnNos +'\','+ obj.id +');event.stopPropagation()">'+value+'</a>';
        }
        return editDelStr;
    }

    //非空判断
    function isBlank(obj){
        return(!obj || $.trim(obj) === "");
    }

    function showSameHeapContns(sameHeapContnNos, e) {
//        debugger
        var sameHeapContnNoArr = sameHeapContnNos.split(",");
        var html = '';
        for (var idx in sameHeapContnNoArr) {
            html += '<p class="sameHeapTip">'+sameHeapContnNoArr[idx]+'</p>'
        }
        layer.tips(html, '#sameHeapContnBox-' + e, {
            tips: [2, '#fff'],
            time: 100000
        });
    }

    function closeTip() {
        layer.closeAll('tips');
    }
</script>