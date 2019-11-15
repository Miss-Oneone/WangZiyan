<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<script type="text/javascript">
    var layerIndex;
    var windowHeight;
    var windowWidth;
    $(window).resize(function() {
        windowHeight = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
        windowWidth = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth;

    });
    $(document).ready(function(){
        windowHeight = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
        windowWidth = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth;
        createGridList("#mainTable", "#mainPager", {
            tblKey:"main"
            ,colNames:eval("${gridModel.colNames}")
            ,colModel:eval("${gridModel.colModel}")
            ,sortable:true
            ,rowNum  : 100
            ,rowList : [1000,500,100]
            ,multiselect : true
//            ,sortname:"departureDate,plateNum,tripFlag"
//            ,sortorder:"ASC"
            ,editurl : 'clientArray'
            ,gridComplete: function () {
                var ids=$("#mainTable").jqGrid('getDataIDs');
                var plateNum,crossBoxTime,changeBoxTime,bgcolor;
                var currentDate = $("#currentDate").val();
                var orderNoAll='';
                for(var i=0;i < ids.length;i++){
                    var rowData = $("#mainTable").jqGrid("getRowData",ids[i]);
                    crossBoxTime = $("#mainTable").getCell(ids[i],'crossBoxTime');
                    $("#mainTable").jqGrid('setRowData',ids[i],{crossBoxTimeF:crossBoxTime});
                    plateNum = $("#mainTable").getCell(ids[i],'plateNum');
                    changeBoxTime = $("#mainTable").getCell(ids[i],'changeBoxTime');
                    if (isBlank(changeBoxTime) && !isBlank(crossBoxTime)) {
                        var date = DateDiff(currentDate,crossBoxTime);
                        if (date >= -1) {
                            $('#mainTable '+'#'+ids[i]).find("td").addClass("differentFlag");
                        } else {
                            if (!isBlank(plateNum)) {
                                $("#mainTable").jqGrid('setRowData',ids[i],{bgcolor:"#C8FAFA"});
                            } else {
                                $("#mainTable").jqGrid('setRowData',ids[i],{bgcolor:'#FFFFFF'});
                            }
                        }
                    } else if (!isBlank(plateNum)) {
                        $("#mainTable").jqGrid('setRowData',ids[i],{bgcolor:"#C8FAFA"});
                    } else {
                        $("#mainTable").jqGrid('setRowData',ids[i],{bgcolor:'#FFFFFF'});
                        //$("#"+ids[i]).css("background-color",'#FFFFFF');
                    }
                    var orderNo = $("#mainTable").getCell(ids[i],'orderNo');
                    orderNoAll = orderNoAll + ',' + orderNo;
                }
                if (orderNoAll.substr(0,1)==',') {
                    orderNoAll=orderNoAll.substr(1);
                    $("#orderNoAll").val(orderNoAll);
                }

                for(var i=0;i < ids.length;i++){
                    bgcolor = $("#mainTable").getCell(ids[i],'bgcolor');
                    $("#"+ids[i]).css("background-color",bgcolor);
                }

                if ($("#ioType").val() == '2') {
                    $("#mainTable").setGridParam().hideCol("crossBoxTime");
                    $("#mainTable").setGridParam().showCol("crossBoxTimeF");
                } else {
                    $("#mainTable").setGridParam().hideCol("crossBoxTimeF");
                    $("#mainTable").setGridParam().showCol("crossBoxTime");
                }
            }
            ,onSelectRow:function(id){
                if($("#"+id).attr("style")) {
                    $("#mainTable").jqGrid('setRowData', id, false, {background:'#ffff00'});

                    var ids = $("#mainTable").jqGrid('getDataIDs');
                    for(var i=0; i<ids.length; i++) {
                        if(i+1 != id) {
                          var bgcolor = $("#mainTable").jqGrid("getCell",ids[i],"bgcolor");
                            $("#"+ids[i]).css("background-color",bgcolor);
                        }
                    }
                }else {
                    $("#mainTable").jqGrid('setRowData', id, false, {background:$("#mainTable").jqGrid("getCell",id,"bgcolor")});
                }
            }
        });

        $("#search").click(function(){
            doSearch();
        })
        doSearch();

        // 费用批量录入
        $("#batchInsertExpenses").click(function () {
            var ids = $("#mainTable").jqGrid('getGridParam',"selarrrow");
            if (!ids || ids.length == 0){
                showError("请选择订单！")
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
            $("#selectOrderNo").val(orderNoStr);

            layerIndex = layer.open({
                type : 2,
                maxmin : true,
                area : [ "410px", "400px" ],
                title : '批量新增费用',
                content : "${ctx}/finance/expense/batchRecPayAdd?selectedOrderNum=" + ids.length,
                cancel : function() {

                }
            })
        })

        // 导出excel
        $("#export").click(function () {
            var url = "${ctxZG}/container/export?";
            window.location.href = url + $("#searchForm").serialize();
        })

        //页面init
        createSelectCondition();//加减图标-查询栏层的显示和隐藏
        $(window).resize();//显示表格的大小
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
        var url = "${ctxZG}/container/search";
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

        $("#mainTable").setGridHeight(windowHeight - $("#selectCondition").height()-$(".ui-jqgrid-labels").height()-$("#mainPager").height()-$("#content-bottom").height()-70);
        $("#footer").width($("#gbox_mainTable").width());
    }

    function operateFormatter(value, row, obj) {
        var editDelStr = '';
        if(!isBlank(value)) {
            editDelStr='<a class="a-info" style="color: blue" href="javascript:void(0);" onclick="url(\''+ value +'\')">'+value+'</a>';
        }
        return editDelStr;
    }

    function feeOperateFormatter(value, row, obj) {
        var editDelStr='<a class="a-info" style="color: blue" href="javascript:void(0);" onclick="openFee(\''+ obj.orderNo +'\')">'+"费用管理"+'</a>';
        return editDelStr;
    }

    function url(orderNo) {
        layerIndex =  layer.open({
            type : 2,
            maxmin : true,
            area : [ windowWidth+"px", windowHeight+"px" ],
            title : '订单编辑',
            content : "${ctxZG}/container/init?orderNo=" + orderNo,
            cancel : function() {

            }
        })
    }

    function openFee(orderNo) {
        // 角色判断，如果只有调度一个角色不让查看
        if ('${roleWithoutDispatcherCnt}' == 0) {
            showError("您没有权限访问费用管理页面！")
            return
        }
        var orderNosKey = 'ordRecPayManage' + Date.parse(new Date());
        setSessionStorageItem(orderNosKey,$("#orderNoAll").val());
        creatIframeFromSub("${ctx}/finance/expense/ordRecPayManage?orderNo=" + orderNo + "&orderNosKey=" + orderNosKey,'费用管理');
    }

    function DateDiff(sDate1, sDate2) {  //计算两个日期天数差（sDate1和sDate2是yyyy-MM-dd格式）

        var aDate, oDate1, oDate2, iDays;
        aDate = sDate1.split("-");
        oDate1 = new Date(aDate[1] + '-' + aDate[2] + '-' + aDate[0]);  //转换为yyyy-MM-dd格式
        aDate = sDate2.split("-");
        oDate2 = new Date(aDate[1] + '-' + aDate[2] + '-' + aDate[0]);
        iDays = parseInt((oDate1 - oDate2) / 1000 / 60 / 60 / 24); //把相差的毫秒数转换为天数

        return iDays;  //返回相差天数
    }

    var batchCheck;
    function bathCheck(url) {
        batchCheck =  layer.open({
            type : 2,
            maxmin : true,
            area : [ "710px", "420px" ],
            title : '<fmt:message key='batchAddPi.checkPi'/>',
            content : url,
            cancel : function() {

            }
        });
    }

    //非空判断
    function isBlank(obj){
        return(!obj || $.trim(obj) === "");
    }

    function closeLayer() {
        layer.close(layerIndex);
    }

    function closeBatchCheck() {
        layer.close(batchCheck);
    }
</script>