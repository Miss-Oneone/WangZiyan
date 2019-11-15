<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<script type="text/javascript">
    var layerIndex;
    $(document).ready(function () {
        top.$("#min_title_list .active").html('<span data-href="${ctx}/finance/expense">费用管理</span><i></i><em></em>');
        tabNavallwidthFromSub();
        createSelectCondition();
        createGridList("#payTable", "payPager", {
            tblKey: "pay",
            shrinkToFit: "false",
            rowNum: -1,
            pgbuttons: false,
            pginput: false,
            userDataOnFooter: true,
            footerrow: true,
            loadonce: true,
            colNames: eval("${payGrid.colNames}"),
            colModel: eval("${payGrid.colModel}"),
            gridComplete: function () {
                paySum();
                $("input[class='editable']").blur(function () {
                    paySum();
                });
            },
            onSelectRow:function(id){

            }
        });
        $("#payPager").height(30);
        $("#payPager_left").append("&nbsp;<input type='button' id='payAdd' name='' class='oms-button' style='border: none;background-color: #f37b1d;width: 90px;height: 25px;color: #fff' value='增加一条应付'>");
        $("#payPager_left").append("&nbsp;<input type='button' id='payEdit' name='' class='oms-button' style='border: none;background-color: #f37b1d;width: 90px;height: 25px;color: #fff' value='修改'>");
        createGridList("#receivableTable", "receivablePager", {
            tblKey: "main",
            shrinkToFit: "false",
            rowNum: -1,
            pgbuttons: false,
            pginput: false,
            userDataOnFooter: true,
            footerrow: true,
            loadonce: true,
            colNames: eval("${receiveGrid.colNames}"),
            colModel: eval("${receiveGrid.colModel}"),
            gridComplete: function () {
                recSum();
                $("input[class='editable']").blur(function () {
                    recSum();
                });
            },
            onSelectRow:function(id){

            }
        });
        $("#receivablePager").height(30);
        $("#receivablePager_left").append("&nbsp;<input type='button' id='incomeAdd' name='' class='oms-button' style='border: none;background-color: #f37b1d;width: 90px;height: 25px;color: #fff' value='增加一条应收'>");
        $("#receivablePager_left").append("&nbsp;<input type='button' id='incomeEdit' name='' class='oms-button' style='border: none;background-color: #f37b1d;width: 90px;height: 25px;color: #fff' value='修改'>");
        findReceivable();
        findPayable();

        //添加一条应收
        $("#incomeAdd").click(function () {
            var orderNo = $("#orderNo").val();
            layerIndex =  layer.open({
                type : 2,
                maxmin : true,
                area : [ "400px", "330px" ],
                title : '添加一条应收',
                content : "${ctx}/finance/expense/recPayUpdate?actionType=recAdd&orderNo=" + orderNo + "&cusCode=" + $('#cusCode').val(),
                cancel : function() {
                    //do nothing
                }
            })
        });

        //编辑一条应收
        $("#incomeEdit").click(function () {
            var ids = $("#receivableTable").jqGrid('getGridParam', "selrow");
            if (ids == null) {
                showError("请选择一行数据");
                return;
            }
            var feeStatus = $("#receivableTable").jqGrid('getRowData', ids).feeStatus;
            var createById = $("#receivableTable").jqGrid('getRowData', ids).createById;
            var editableFlag = $("#receivableTable").jqGrid('getRowData', ids).editableFlag;
            var binsApprovalFlag = $("#receivableTable").jqGrid('getRowData', ids).binsApprovalFlag;
            if (editableFlag == "N" || (createById != "${loginId}" && feeStatus == '1')
                || feeStatus == '2' || feeStatus == '3' || binsApprovalFlag == 'Y') {
                showError("系统自动生成、已开始对账或已审核的费用不能修改。已提交的费用也只能自己修改自己的！");
                return;
            }

            var orderNo = $("#orderNo").val();
            var recPayId = $("#receivableTable").jqGrid('getRowData', ids).recPayId;
            layerIndex =  layer.open({
                type : 2,
                maxmin : true,
                area : [ "400px", "330px" ],
                title : "编辑应收",
                content : "${ctx}/finance/expense/recPayUpdate?actionType=recUpdate&orderNo=" + orderNo + "&recPayId=" + recPayId,
                cancel : function() {
                    //do nothing
                }
            })
        });

        //添加一条应付
        $("#payAdd").click(function () {
            var orderNo = $("#orderNo").val();
            layerIndex =  layer.open({
                type : 2,
                maxmin : true,
                area : [ "400px", "330px" ],
                title : "添加一条应付",
                content : "${ctx}/finance/expense/recPayUpdate?actionType=payAdd&orderNo=" + orderNo + "&driverCode=" + $('#driverCode').val(),
                cancel : function() {
                    //do nothing
                }
            })
        });

        //编辑应付
        $("#payEdit").click(function () {
            var ids = $("#payTable").jqGrid('getGridParam', "selrow");
            if (ids == null) {
                showError("请选择一行数据");
                return;
            }
            var feeStatus = $("#payTable").jqGrid('getRowData', ids).feeStatus;
            var createById = $("#payTable").jqGrid('getRowData', ids).createById;
            var editableFlag = $("#payTable").jqGrid('getRowData', ids).editableFlag;
            var binsApprovalFlag = $("#payTable").jqGrid('getRowData', ids).binsApprovalFlag;
            if (editableFlag == "N" || (createById != "${loginId}" && feeStatus == '1')
                || feeStatus == '2' || feeStatus == '3' || binsApprovalFlag == 'Y') {
                showError("系统自动生成、已开始对账或已审核的费用不能修改。已提交的费用也只能自己修改自己的！");
                return;
            }

            var orderNo = $("#orderNo").val();
            var recPayId = $("#payTable").jqGrid('getRowData', ids).recPayId;
            layerIndex =  layer.open({
                type : 2,
                maxmin : true,
                area : [ "400px", "330px" ],
                title : "编辑应付",
                content : "${ctx}/finance/expense/recPayUpdate?actionType=payUpdate&orderNo=" + orderNo + "&recPayId=" + recPayId,
                cancel : function() {
                    //do nothing
                }
            });

        });

        $(window).resize();

        //下一条
        $("#nextOne").click(function () {
            var orderNoAll = getSessionStorageItem($("#orderNosKey").val());
            var orderNo = $("#orderNo").val();
            var orderNoAllArr = orderNoAll.split(",");
            var nextOrderNo = orderNoAllArr.indexOf(orderNo);

            if (orderNoAllArr.length < nextOrderNo + 2) {
                showError("没有下一条了！");
                return;
            }

            orderNo = orderNoAllArr[nextOrderNo + 1];
            location.href = "${ctx}/finance/expense/ordRecPayManage?orderNo=" + orderNo + "&orderNosKey=" + $("#orderNosKey").val();
        });

        //上一条
        $("#preOne").click(function () {
            var orderNoAll = getSessionStorageItem($("#orderNosKey").val());
            var orderNo = $("#orderNo").val();
            var orderNoAllArr = orderNoAll.split(",");
            var nextOrderNo = orderNoAllArr.indexOf(orderNo);

            if (nextOrderNo == 0) {
                showError("当前是第一条！");
                return;
            }

            orderNo = orderNoAllArr[nextOrderNo - 1];
            location.href = "${ctx}/finance/expense/ordRecPayManage?orderNo=" + orderNo + "&orderNosKey=" + $("#orderNosKey").val();
        });

    });

    Array.prototype.unique = function () {
        this.sort(); //先排序
        var res = [this[0]];
        for (var i = 1; i < this.length; i++) {
            if (this[i] !== res[res.length - 1]) {
                res.push(this[i]);
            }
        }
        return res;
    };

    function recSum() {
        var ids = jQuery("#receivableTable").jqGrid('getDataIDs');
        var amountSum = 0.00;
        for (var i = 0; i < ids.length; i++) {
            amountSum = floatAdd(amountSum, $("#receivableTable").jqGrid('getRowData', ids[i]).amount);
        }
        $("#receivableTable").jqGrid('footerData', 'set', {piName: '应收合计：', amount: amountSum}, false);
    }

    function paySum() {
        var amountSum = 0.00;
        var ids = jQuery("#payTable").jqGrid('getDataIDs');
        for (var i = 0; i < ids.length; i++) {
            amountSum = floatAdd(amountSum, $("#payTable").jqGrid('getRowData', ids[i]).amount);
        }
        $("#payTable").jqGrid('footerData', 'set', {piName: '应付合计：', amount: amountSum}, false);
    }

    //表格获取数据
    function getPostURL(tblKey) {
        var orderNo = $("#orderNo").val();
        if (tblKey == "main") {
            var url = "${ctx}/finance/expense/recList?orderNo=" + orderNo + "&paymentType=1&feeType=1";
            return url;
        } else if (tblKey == "pay") {
            var url = "${ctx}/finance/expense/payList?orderNo=" + orderNo + "&paymentType=2&feeType=1";
            return url;
        }
    }

    function findReceivable() {
        $("#receivableTable").jqGrid('setGridParam', {datatype: "json", url: getPostURL("main")}).trigger("reloadGrid");
    }

    function findPayable() {
        $("#payTable").jqGrid('setGridParam', {datatype: "json", url: getPostURL("pay")}).trigger("reloadGrid");
    }

    $(window).resize(function () {
        screenResize();
    });

    function screenResize() {
        var windowHeight = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
        if ($(window).width() * 0.99 < 1182) {
            $("#receivableTable").setGridWidth(1182 / 2 - 5);
            $("#payTable").setGridWidth(1182 / 2 - 5);
        } else {
            $("#receivableTable").setGridWidth($(window).width() * 0.99 / 2 - 5);
            $("#payTable").setGridWidth($(window).width() * 0.99 / 2 - 5);
        }

        $("#receivableTable").setGridHeight(windowHeight - parseInt($('#selectCondition').get(0).offsetHeight)-parseInt($('#btnRow').get(0).offsetHeight)-95);
        $("#footer").width($("#gbox_receivableTable").width());
        $("#payTable").setGridHeight(windowHeight - parseInt($('#selectCondition').get(0).offsetHeight)-parseInt($('#btnRow').get(0).offsetHeight)-95);
        $("#footer").width($("#gbox_payTable").width());
    }

    function clearNoNum(obj) {
        obj = obj.target;
        var value = obj.value;
        value = value.replace(/[^\d.-]/g, "");  //清除“数字”和“.”以外的字符
        value = value.replace(/^\./g, "");  //验证第一个字符是数字而不是.
        value = value.replace(/\.{2,}/g, "."); //只保留第一个. 清除多余的.
        value = value.replace(".", "$#$").replace(/\./g, "").replace("$#$", ".");
        obj.value = value;
    }

    function editPayableList() {
        //应付
        var ids = jQuery('#payTable').jqGrid('getDataIDs');
        var obj = $("#payTable").jqGrid("getRowData");
        var payableList = "";
        var json = "";
        for (var i = 0; i < obj.length; i++) {
            json = "";
            for (var p in obj[i]) {
                json += "," + p + ":'" + obj[i][p] + "'";
            }
            payableList += ",{" + json.substr(1) + "}";
        }
        payableList = "[" + payableList.substr(1) + "]";
        return payableList;

    }

    function editReceivbleList() {
        //应收
        var ids = jQuery('#receivableTable').jqGrid('getDataIDs');
        var obj = $("#receivableTable").jqGrid("getRowData");
        var receivbleList = "";
        var json = "";
        for (var i = 0; i < obj.length; i++) {
            json = "";
            for (var p in obj[i]) {
                json += "," + p + ":'" + obj[i][p] + "'";
            }
            receivbleList += ",{" + json.substr(1) + "}";
        }
        receivbleList = "[" + receivbleList.substr(1) + "]";
        return receivbleList;

    }

    function billNoUrl(value, row, obj) {
        var editDelStr = "";
        if (!isBlank(value)) {
            var billNoArray = value.split(",");

            for (var i = 0; i < billNoArray.length; i++) {
                editDelStr += ',<a class="a-info" href="javascript:void(0);" onclick="billDetailByBillNo(\'' + billNoArray[i] + '\')">' + billNoArray[i] + '</a>';
            }

        }
        return editDelStr.substring(1);
    }

    function invoiceNoUrl(value, row, obj) {
        var editDelStr = "";
        if (!isBlank(value)) {
            var invoiceNoArray = value.split(",");
            for (var i = 0; i < invoiceNoArray.length; i++) {
                editDelStr += ',<a class="a-info" href="javascript:void(0);" onclick="billDetailByInvoiceNo(\'' + invoiceNoArray[i] + '\')">' + invoiceNoArray[i] + '</a>';
            }
        }
        return editDelStr.substring(1);
    }

    function billDetailByBillNo(billNo) {
        var url = "${ctxZG}/billManage/billDetail?type=detail";
        url += "&billNo=" + billNo;
        url += "&blNo=" + $("#blNo").val();
        url += "&contnNo=" + $("#contnNo").val();
        url += "&urlType=Y";

        layerIndex =  layer.open({
            type : 2,
            maxmin : true,
            area : [ "1100px", "550px" ],
            title : "账单明细",
            content : url,
            cancel : function() {

            }
        })
    }
    function billDetailByInvoiceNo(invoiceNo) {
        var url = "${ctxZG}/fcinvoice/invoiceDetail?";
        url += "invoiceNo=" + invoiceNo;
        url += "&blNo=" + $("#blNo").val();
        url += "&contnNo=" + $("#contnNo").val();

        layerIndex =  layer.open({
            type : 2,
            maxmin : true,
            area : [ "1100px", "550px" ],
            title : "票据明细",
            content : url,
            cancel : function() {

            }
        })

    }

    function isBlank(obj) {
        return (!obj || $.trim(obj) == "");
    }

    function closeLayer() {
        layer.close(layerIndex);
    }
</script>