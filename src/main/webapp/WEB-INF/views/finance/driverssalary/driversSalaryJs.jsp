<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<script type="text/javascript">
    if ("${noData}" == "noData") {
        showError(MsgConstants.getMsg("M00006"))
    }
    window.onload = function () {
    }
    $(document).ready(function(){
        if ('${value}' == 'N') {
            $("#GpsJob").prop({"disabled":"disabled"});
            $("#GpsJob").css("background-color", "#ddd");
            $("#GpsJob").css("border-color", "#ddd");
        }
        createSelectCondition();
        createGridList("#mainTable", "#mainPager", {
            tblKey: "main"
            , colNames: eval("${gridModel.colNames}")
            , colModel: eval("${gridModel.colModel}")
            , rowList: [100, 300, 500]
            , rowNum: 100
            , multiselect: true
            , loadonce: true
            , gridComplete: function () {
                var ids = jQuery("#mainTable").jqGrid('getDataIDs');
//                var binsApprovalFlag = $("#mainTable").getCell(ids[0], 'binsApprovalFlag');
//                if(binsApprovalFlag == 'C') {
//                    $('#jqgh_mainTable_totalAmount').text("已封账趟次及补贴");
//                    $('#jqgh_mainTable_unAuditedTotalAmount').text("未封账趟次及补贴");
//                } else {
//                    $('#jqgh_mainTable_totalAmount').text("已审核趟次及补贴");
//                    $('#jqgh_mainTable_unAuditedTotalAmount').text("未审核趟次及补贴");
//                }
                for (var i = 0; i < ids.length; i++) {
                    var detail = $("#mainTable").getCell(ids[i], 'detail');
                    /*var download = $("#mainTable").getCell(ids[i], 'download');*/
                    var driverCode1 = $("#mainTable").getCell(ids[i], 'driverCode');
                    operate = '<a href="#" style="color:#383098" onclick="openDetail(\'' + driverCode1 + '\')" >' + '明细' + '</a>';
                    $("#mainTable").jqGrid('setRowData', ids[i], {detail: operate});
                    operate = '<a href="#" style="color:#383098" onclick="doDownload(\'' + driverCode1 + '\')" >' + '下载' + '</a>';
                    $("#mainTable").jqGrid('setRowData', ids[i], {download: operate});
                    /*if(binsApprovalFlag == 'C') {
                        $('#'+ids[i]).find("td").addClass("confirmColor");
                    }*/
                }
            }
        });
        $(window).resize();

        $("#search").click(function () {
            if (checkSelectTime()) {
                showError("必须选择发车日期！");
                return;
            };

            doSearch();
        });

        //导出
        $("#export").click(function () {
            if (checkSelectTime()) {
                showError("必须选择发车日期！");
                return;
            }
            ;
            doExport();
        });

//        //GPS未归属导出
//        $("#GPSExport").click(function () {
//            if (checkSelectTime()) {
//                showError("必须选择发车日期！");
//                return;
//            }
//            ;
//            doGPSExport();
//        });
//
//        //GPS未归属导出
//        $("#mileExport").click(function () {
//            if (checkSelectTime()) {
//                showError("必须选择发车日期！");
//                return;
//            }
//            ;
//            doMileExport();
//        });

        //修改附加项
        $("#updateAmount").click(function () {
            var ids = jQuery("#mainTable").jqGrid('getGridParam', 'selarrrow');
            if (!ids || ids.length == 0) {
                showError("请选择一行数据！");
                return;
            }

            if (ids.length == 1) {
                var obj = $("#mainTable").jqGrid('getRowData', ids[0]);
                if (obj.binsApprovalFlag == 'C') {
                    showError("已封账数据不能修改！");
                    return;
                }
                openUpdateAmount(obj);
            } else {
                var trueIds = new Array();
                for (var i = 0; i < ids.length; i++) {
                    if($("#mainTable").getCell(ids[i], 'binsApprovalFlag') != 'C') {
                        trueIds.push(ids[i]);
                    }
                }
                if(trueIds.length == 0) {
                    showError("选择的数据都已封账，不能修改！");
                    return;
                }
                openUpdateAmountBatch();
            }
        });

        //GPS抓取
        $("#GpsJob").click(function () {
            var plateNum = $("#plateNum").val();
            var massage;
            if (isBlank(plateNum)) {
                massage = "抓取预计需要40分钟，建议下班之前点击，晚上执行。执行中的不能再次启动。是否继续？";
            } else {
                massage = "抓取预计需要10分钟,执行中的不能再次启动。是否继续？";
            }
            var index = layer.confirm(massage, {
                btn: ['是','否'], //按钮
                icon: 7
            }, function () {
                layer.close(index);
                $("#GpsJob").css("background-color", "#ddd");
                $("#GpsJob").css("border-color", "#ddd");
                gpsJob();
            })
        });

        //司机工资确认
        $("#driversSalaryConfirm").click(function () {

            var ids = $("#mainTable").jqGrid('getDataIDs');

            var rowData = jQuery("#mainTable").jqGrid('getRowData', ids[0]);
            if(rowData.binsApprovalFlag == 'C') {
                showError("你当前选择的财务月数据都已封账，无需再次确认！");
                return;
            }

            var unAuditedTotalAmount = 0;

            for(var i=0;i<ids.length;i++) {
                unAuditedTotalAmount += $("#mainTable").jqGrid('getRowData', ids[i]).unAuditedTotalAmount * 1;
            }
            if(unAuditedTotalAmount > 0){

                var msg = "合计"+ unAuditedTotalAmount +"元的工资及补贴还没有审核，封账后将自动移到下个月，确定封账吗？";
                var index = layer.confirm(msg, {
                    btn: ['是','否'], //按钮
                    icon: 7
                }, function () {
                    layer.close(index);

                    var msg = "司机工资都审核完了？工资确认后，不能修改，变更只能在下个月体现！";
                    var index = layer.confirm(msg, {
                        btn: ['是', '否'], //按钮
                        icon: 7
                    }, function () {
                        layer.close(index);
                        doConfirm();
                    })
                })
            } else {

                var msg = "司机工资都审核完了？工资确认后，不能修改，变更只能在下个月体现！";
                var index = layer.confirm(msg, {
                    btn: ['是', '否'], //按钮
                    icon: 7
                }, function () {
                    layer.close(index);
                    doConfirm();
                })
            }
        });

    });

    $(window).resize(function () {
        screenResize();
    });

    //每10分钟读取抓取标志
    <%--setInterval(function(){--%>
        <%--$.ajax({--%>
            <%--url : "${ctxZG}/driversSalary/getGbsJobFlag",--%>
            <%--type : 'post',--%>
            <%--success:function(data){--%>
                <%--var obj = JSON.parse(data);--%>
                <%--if (obj.resultType == '99') {--%>
                    <%--var model= obj.dataModel;--%>
                    <%--if (model.flag == "Y") {--%>
                        <%--$("#GpsJob").css("background-color", "#f37b1d");--%>
                        <%--$("#GpsJob").css("border-color", "#f37b1d");--%>
                        <%--$("#gpsJobUpdateTime").val(model.createTime);--%>
                    <%--} else {--%>
                        <%--$("#GpsJob").css("background-color", "#ddd");--%>
                        <%--$("#GpsJob").css("border-color", "#ddd");--%>
                        <%--$("#gpsJobUpdateTime").val(model.createTime);--%>
                    <%--}--%>
                <%--}--%>
            <%--}--%>
        <%--});--%>
    <%--},600000);--%>

    function openUpdateAmountBatch() {
        var url = "${ctxZG}/driversSalary/updateAmountFormBatch";
        layer.open({
            type: 2,
            maxmin: true,
            title: "批量修改金额",
            shade: 0.5,
            area: ["900px", "300px"], //宽高
            content: url
        });
    }

    function openUpdateAmount(rowData) {
        var url = "${ctxZG}/driversSalary/updateAmountForm";
        url += "?driverCode=" + rowData.driverCode;
        url += "&driverName=" + rowData.driverName;
        url += "&leaveDays=" + (rowData.leaveDays ? rowData.leaveDays : '0');
        url += "&addDutyRewardAmount=" + (rowData.addDutyRewardAmount ? rowData.addDutyRewardAmount : '0');
        url += "&addOtherAmount=" + (rowData.addOtherAmount ? rowData.addOtherAmount : '0');
        url += "&deductSsAmount=" + (rowData.deductSsAmount ? rowData.deductSsAmount : '0');
        url += "&deductRiskAmount=" + (rowData.deductRiskAmount ? rowData.deductRiskAmount : '0');
        url += "&deductLoanAmount=" + (rowData.deductLoanAmount ? rowData.deductLoanAmount : '0');
        url += "&deductOtherAmount=" + (rowData.deductOtherAmount ? rowData.deductOtherAmount : '0');
        url += "&deductTaxAmount=" + (rowData.deductTaxAmount ? rowData.deductTaxAmount : '0');
        url += "&baseSalaryAmount=" + (rowData.baseSalaryAmount ? rowData.baseSalaryAmount : '0');
        url += "&orgBaseSalaryAmount=" + (rowData.orgBaseSalaryAmount ? rowData.orgBaseSalaryAmount : '0');
        url += "&baseSubsidy=" + (rowData.baseSubsidy ? rowData.baseSubsidy : '0');
        layer.open({
            type: 2,
            maxmin: true,
            title: "修改金额",
            shade: 0.5,
            area: ["900px", "300px"], //宽高
            content: url
        });
    }
    function checkSelectTime() {
        var salaryMonth = $("#salaryMonth").val();
        var driverCode = $("#driverCode").val();
        if (isBlank(salaryMonth)) {
            return true;
        }
    }

    function openDetail(driverCode1) {
        var driverCode = driverCode1;
        var salaryMonth = $("#salaryMonth").val();
        var url = "${ctxZG}/driversSalary/driversSalaryDetail?" + "driverCode=" + driverCode + "&salaryMonth=" + salaryMonth;
        layer.open({
            type: 2,
            maxmin: true,
            title: "工资明细",
            shade: 0.5,
            area: ["75%", "75%"], //宽高
            content: url
        });
    }

    <!--grid-->
    function doSearch() {
        $("#mainTable").jqGrid('setGridParam', {
            datatype: "json",
            url: getPostURL("main"),
            page: 1
        }).trigger("reloadGrid");
        $('#searchTime').val($('#fromTime').val());
    }

    function getPostURL(tblKey) {
        var url = "${ctxZG}/driversSalary/search";
        return url + "?" + $("#searchForm").serialize();
    }

    function screenResize() {
        var windowHeight = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
        $("#mainTable").setGridWidth($(window).width() * 0.99);
        $("#mainTable").setGridHeight(windowHeight - $("#selectCondition").height() - $(".content-button").height() - $("#mainPager").height() - 50 - $("#content-bottom").height());
    }

    //导出
    function doExport() {
        layer.confirm(MsgConstants.getMsg("C00009", "司机工资导出"), function () {
            closeLayerFirm();
            $("#searchForm").attr("action",
                "${ctxZG}/driversSalary/export?" + $("#searchForm").serialize());
            $("#searchForm").submit();
            //window.location.href = "${ctxZG}/driversSalary/export?" + $("#searchForm").serialize();
        });
    }

    //GPS未归属导出
    function doGPSExport() {
        layer.confirm(MsgConstants.getMsg("C00009", "GPS未归属导出"), function () {
            closeLayerFirm();
            window.location.href = "${ctxZG}/driversSalary/doGPSExport?" + $("#searchForm").serialize();
        });
    }

    //轨迹里程导出
    function doMileExport() {
        layer.confirm(MsgConstants.getMsg("C00009", "轨迹里程导出"), function () {
            closeLayerFirm();
            window.location.href = "${ctxZG}/driversSalary/doMileExport?" + $("#searchForm").serialize();
        });
    }

    //下载
    function doDownload(driverCode1) {
        var driverCode = driverCode1;
        var salaryMonth = $("#salaryMonth").val();
        layer.confirm(MsgConstants.getMsg("C00009", "司机工资明细下载"), function () {
            closeLayerFirm();
            window.location.href = "${ctxZG}/driversSalary/download?" + "driverCode=" + driverCode + "&salaryMonth=" + salaryMonth;
        });
    }

    //grid选中检查
    function checkedSelect(ids, errorInfo) {
        if (ids.length == 0) {
            showError(errorInfo);
            return false;
        } else {
            if (errorInfo == MsgConstants.getMsg("M00001", "一条数据") && ids.length != 1) {
                showError(errorInfo);
                return false;
            } else {
                return true;
            }
        }
        return true;

    }

    function getStr(ids, para) {
        var temp = '';
        var tempStr = '';
        for (var i = 0; i < ids.length; i++) {
            temp = $("#mainTable").getCell(ids[i], para);
            tempStr += "," + temp
        }
        tempStr = tempStr.substring(1);
        return tempStr;
    }

    function closeLayerFirm() {
        var i = layer.confirm();
        layer.close(i);
    }

    <!--utils-->
    //非空判断
    function isBlank(obj) {
        return (!obj || $.trim(obj) == "");
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

    function gpsJob() {
        var gpsJobUpdateTime = $("#gpsJobUpdateTime").val();
        var time = $("#fromTime").val();
        var plateNum = $("#plateNum").val();
        $.ajax({
            url: "${ctxZG}/driversSalary/getCarGpsInfoByPerson",
            data: {
                gpsJobUpdateTime: gpsJobUpdateTime,
                time: time,
                plateNum: plateNum
            },
            type: 'post',
            success: function (data) {
                var obj = JSON.parse(data);
                if (obj.resultType == '99') {
                    var model= obj.dataModel;
                    if (model.flag == "Y") {
                        $("#GpsJob").css("background-color", "#f37b1d");
                        $("#GpsJob").css("border-color", "#f37b1d");
                        $("#gpsJobUpdateTime").val(model.createTime);
                    } else {
                        $("#GpsJob").css("background-color", "#ddd");
                        $("#GpsJob").css("border-color", "#ddd");
                        $("#gpsJobUpdateTime").val(model.createTime);
                    }
                    showTip(obj.resultMsg);
                } else {
                    showTip(obj.resultMsg,2000);
                }
            },
            error:function(){
                showError("操作失败!");
            }
        });
    }

    function doConfirm(gridData) {
        openLoading();
        postHelper(
            "driversSalary/driversSalaryConfirm?salaryYm="+$('#searchTime').val(),
            {}, function(response) {
            closeLoading();
            if(response.resultType == BizConstant.SUCCESS) {
                showTip(response.resultMsg);
                doSearch();
            }else {
                showError(response.resultMsg);
            }
        });
        layer.close(parent.layer.index);
    }

    function postHelper(url, data, callback) {
        url = "${ctxZG}/" + url;
        $.ajax({
            url : url,
            type : 'post',
            data: data,
            success:function(res){
                var obj = JSON.parse(res)
                callback(obj);
            },
            error:function(xhr,status,error){
                showError("系统错误");
            }
        });
    }

</script>