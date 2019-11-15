<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
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
            ,onSelectAll:function(aRowids,status){

            }
            ,gridComplete:function() {
                var ids = $("#mainTable").jqGrid('getDataIDs');
                for(var i=0; i<ids.length; i++) {
                    var checkResult = $("#mainTable").getCell(ids[i],'checkResult')
                    if(checkResult == "通过")
                        $("#mainTable").jqGrid('setSelection',ids[i]);
                }
            }
            ,editurl : 'clientArray'
        });

        $("#save").click(function(){
            doSave()
        });
        $("#cancel").click(function(){
            parent.closeBatchCheck();
        });
        $("#orderNo").val($("#selectOrderNo", parent.document).val());
        doSearch();

        //页面init
        createSelectCondition();//加减图标-查询栏层的显示和隐藏
        $(window).resize();//显示表格的大小
    });

    //列表查询
    function doSearch(){
        $("#mainTable").jqGrid('setGridParam',{postData:$("#searchForm").serialize(), datatype:"json",url:getPostURL("main"),page:1}).trigger("reloadGrid");
    }

    function getPostURL(tblKey) {
        return "${ctx}/finance/expense/batchRecPayCheckList";
    }

    //列表窗口
    $(window).resize(function(){
        screenResize();
    });

    //列表展示
    function screenResize() {
        var windowHeight = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
        $("#mainTable").setGridWidth($(window).width() * 0.99);

        $("#mainTable").setGridHeight(windowHeight - $("#selectCondition").height()-$(".ui-jqgrid-labels").height()-$("#mainPager").height()-$("#content-bottom").height()-70);
        $("#footer").width($("#gbox_mainTable").width());
    }

    function doSave() {
        var ids = $("#mainTable").jqGrid("getGridParam", "selarrrow");
        if (!ids || ids.length == 0) {
            showError("请至少选择一条需要新增的费用！");
            return;
        }

        var orderNoStr = '';
        for (var i = 0; i < ids.length; i++) {
            var orderNo = $("#mainTable").getCell(ids[i],'orderNo');
            orderNoStr = orderNoStr + ',' + orderNo;
        }
        if (orderNoStr.substr(0,1)==',') {
            orderNoStr = orderNoStr.substr(1);
        }
        $("#selectOrderNos").val(orderNoStr);

        var index = layer.confirm("您确定要保存这些数据吗？", {
            btn: ['确定', '取消'], //按钮
            icon: 7
        }, function () {
            layer.close(index);
            openLoading();
            var ajaxUrl = "${ctx}/finance/expense/batchSaveRecPay";
            $.ajax({
                url: ajaxUrl,
                data: $("#searchForm").serialize(),
                type: "post",
                dataType: "json",
                async: false,
                success: function (data) {
                    closeLoading();
                    if (data.resultType == "1") {
                        showTip("保存成功");
                        setTimeout(function () {
                            parent.closeLayer();
                            parent.closeBatchCheck();
                        }, 1000)
                    } else {
                        showError("<fmt:message key='expenseManagement.error'/>");
                    }
                },
                error: function () {
                    closeLoading();
                    showError("系统未知错误")
                }
            });
        })
    }

    function isBlank(obj) {
        return (!obj || $.trim(obj) == "");
    }
</script>