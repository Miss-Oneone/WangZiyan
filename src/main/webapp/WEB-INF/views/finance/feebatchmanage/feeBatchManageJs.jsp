<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<script type="text/javascript">
    window.onload = function () {
        doSearch();
    }
    $(document).ready(function () {
        $("#searchForm img").remove();
        createGridList("#mainTable", "#mainPager", {
            tblKey: "main"
            , multiselect: true
            , rowList: [100, 500, 1000]
            , colNames: eval("${gridModel.colNames}")
            , colModel: eval("${gridModel.colModel}")
        });

        //查询
        $("#search").click(function () {
            doSearch();
        })

        $("#feeAdd").click(function () {
            if (!checkSelected())
                return;
            setValueAdd();
            var url = "${ctxZG}/feeBatchManage/feeBatchManageAdd";
            layer.open({
                type: 2,
                maxmin: true,
                title: '批量新增',
                shade: 0.5,
                area: ["700px", "550px"], //宽高
                content: url
            });
        });

        $("#feeUpdate").click(function () {
            if (!checkSelected() || !checkInfo())
                return;
            if (!checkStatus())
                return;
            setValueUpdate();
            var url = "${ctxZG}/feeBatchManage/feeBatchManageUpdate";
            layer.open({
                type: 2,
                maxmin: true,
                title: '费用批量编辑',
                shade: 0.5,
                area: ["500px", "450px"], //宽高
                content: url
            });
        });

        $("#binsApproval").click(function () {
            if (!checkSelectedOne()) {
                return false;
            } else {
                if (!checkBinsApprovalFlag())
                    return;
            }
            doApproval()
        });

        $("#binsUnApproval").click(function () {
            if (!checkUnAplFlag())
                return;
            var url = "${ctxZG}/feeBatchManage/binsUnApproval";
            layer.open({
                type: 2,
                maxmin: true,
                title: '反审核',
                shade: 0.5,
                area: ["500px", "200px"], //宽高
                content: url
            });
        });

        $(window).resize();
        createSelectCondition();
    });

    function checkUnAplFlag() {
        if (!checkSelectedOne()) {
            return false;
        } else {
            if (!checkUnBinsApprovalFlag())
                return false
        }
        return true;
    }

    function isContains(str, substr) {
        return str.indexOf(substr) >= 0;
    }

    function doSearch() {
        $("#mainTable").jqGrid('setGridParam', {
            datatype: "json",
            url: getPostURL("main"),
            page: 1
        }).trigger("reloadGrid");
    }

    function doApproval() {
        var ids = $('#mainTable').jqGrid('getGridParam', 'selarrrow');
        var data = new Array();
        for (var i = 0; i < ids.length; i++) {
            var obj = $("#mainTable").jqGrid('getRowData', ids[i]);
            data.push({
                "id": obj.feeId,
                "feeType": "1",
                "paymentType": obj.paymentType,
                "feeStutas": obj.feeStatus
            })
        }
        saveApproval(data)
    }

    //费用审核
    function saveApproval(data) {

        var index = layer.confirm("确定审核选中费用吗？", function () {
            openLoading();
            postHelper("binsApprovalOrd/updateBinsApprovalFee", {
                "datas": JSON.stringify(data)
            }, function (response) {
                closeLoading();
                if (response.resultType == BizConstant.SUCCESS) {
                    showTip(response.resultMsg);
                } else {
                    showError(response.resultMsg);
                }
                doSearch();
            });
            layer.close(index);
        })
    }

    function postHelper(url, data, callback) {
        url = "${ctxZG}/" + url;
        $.ajax({
            url: url,
            type: 'post',
            data: data,
            success: function (data) {
                var obj = JSON.parse(data)
                callback(obj);
            },
            error: function (xhr, status, error) {
                showError("系统错误");
            }
        });
    }

    function checkInfo() {
        var feeStatus;
        var binsApprovalFlag;
        var ids = $('#mainTable').jqGrid('getGridParam', 'selarrrow');
        if (!checkSelectedOne()) {
            return false;
        } else {
            for (var i = 0; i < ids.length; i++) {
                feeStatus = $("#mainTable").getCell(ids[i], 'feeStatus');
                binsApprovalFlag = $("#mainTable").getCell(ids[i], 'binsApprovalFlag');
                if (feeStatus == '2' || feeStatus == '3') {
                    showError("所选数据中含有已经生成账单的数据，已经生成账单的数据不能修改！");
                    return false;
                }
                if(binsApprovalFlag != 'N') {
                    showError("只有未审核的数据，才能进行修改");
                    return false;
                }

            }
        }
        return true;
    }

    function setValueAdd() {
        var orderNoStr = '';
        var compyCodeStr = '';
        var orderNo = '';
        var compyCode = '';
        var cnt = 0;
        var ids = $('#mainTable').jqGrid('getGridParam', 'selarrrow');
        if (ids == 0) {
            return;
        } else {
            for (var i = 0; i < ids.length; i++) {
                orderNo = $("#mainTable").getCell(ids[i], 'orderNo');
                if (orderNoStr.indexOf(orderNo) == -1) {
                    orderNoStr += ("," + orderNo);
                    cnt += 1;
                }
                compyCode = $("#mainTable").getCell(ids[i], 'relatedCompyCode');
                if (compyCodeStr.indexOf(compyCode) == -1) {
                    compyCodeStr += ("," + compyCode );
                }

            }
        }
        orderNoStr = orderNoStr.substring(1);
        compyCodeStr = compyCodeStr.substring(1);
        $("#orderNoStr").val(orderNoStr);
        $("#orderNoCnt").val(cnt);
        if (compyCodeStr.split(",").length == 1) {
            $("#compyCodeStr").val(compyCodeStr);
        } else {
            $("#compyCodeStr").val("");
        }
    }
    function setValueUpdate() {
        var compyNameStr = '';
        var compyName = '';
        var piNameStr = '';
        var piName = '';
        var feeIdStr = '';
        var feeCnt = 0;
        var ids = $('#mainTable').jqGrid('getGridParam', 'selarrrow');
        feeCnt = ids.length;
        if (ids.length == 0) {
            return;
        } else {
            for (var i = 0; i < ids.length; i++) {
                compyName = $("#mainTable").getCell(ids[i], 'relatedCompyName');
                if (compyNameStr.indexOf(compyName) == -1) {
                    compyNameStr += ("," + compyName );
                }
                piName = $("#mainTable").getCell(ids[i], 'piName');
                if (piNameStr.indexOf(piName) == -1) {
                    piNameStr += ("," + piName );
                }
                feeIdStr += ("," + $("#mainTable").getCell(ids[i], 'feeId'));
            }
        }
        compyNameStr = compyNameStr.substring(1);
        piNameStr = piNameStr.substring(1);
        feeIdStr = feeIdStr.substring(1);
        $("#compyNameStr").val(compyNameStr);
        $("#piNameStr").val(piNameStr);
        $("#feeCnt").val(feeCnt);
        $("#feeIdStr").val(feeIdStr);
        $("#paymentTypeNameStr").val($("#mainTable").getCell(ids[0], 'paymentTypeName'));
        $("#paymentTypeStr").val($("#mainTable").getCell(ids[0], 'paymentType'));
    }
    function setValueUpdateApl() {
        var feeIdStr = '';
        var rpTypeCodeStr = '';
        var ids = $('#mainTable').jqGrid('getGridParam', 'selarrrow');
        for (var i = 0; i < ids.length; i++) {
            feeIdStr += ("," + $("#mainTable").getCell(ids[i], 'FEE_ID'));
            rpTypeCodeStr += ("," + $("#mainTable").getCell(ids[i], 'rpType'));
        }
        feeIdStr = feeIdStr.substring(1);
        rpTypeCodeStr = rpTypeCodeStr.substring(1);
        $("#feeIdStr").val(feeIdStr);
        $("#rpTypeCodeStr").val(rpTypeCodeStr);
    }

    function checkSelectedOne() {
        var ids = $('#mainTable').jqGrid('getGridParam', 'selarrrow');
        if (ids.length == 0) {
            showError("请勾选数据！");
            return false;
        }
        return true;
    }

    function checkSelected() {
        var ids = $('#mainTable').jqGrid('getGridParam', 'selarrrow');
        if (ids.length == 0) {
            showError("请勾选数据！");
            return false;
        }
        return true;
    }

    function checkStatus() {
        var paymentType = '';
        var ids = $('#mainTable').jqGrid('getGridParam', 'selarrrow');
        var systemAutoFlag, editableFlag;
        var revFlag = 'N';
        var payFlag = 'N';
        for (var i = 0; i < ids.length; i++) {
            systemAutoFlag = $("#mainTable").getCell(ids[i], 'systemAutoFlag');
            editableFlag = $("#mainTable").getCell(ids[i], 'editableFlag');
            if (systemAutoFlag == 'Y') {
                showError("系统自动生成的数据不能修改！");
                return false;
            }
            if (editableFlag == 'N') {
                showError("存在数据为不可修改状态，请重新选择！");
                return false;
            }
            if (paymentType == '2')
                payFlag = 'Y';
            if (paymentType == '1')
                revFlag = 'Y';
        }
        if (revFlag == 'Y' && payFlag == 'Y') {
            showError("不能同时编辑应收和应付！");
            return false;
        }
        return true;
    }

    function checkBinsApprovalFlag() {
        var ids = $('#mainTable').jqGrid('getGridParam', 'selarrrow');
        var binsApprovalFlag, feeStatus;
        for (var i = 0; i < ids.length; i++) {
            binsApprovalFlag = $("#mainTable").getCell(ids[i], 'binsApprovalFlag');
            if (binsApprovalFlag == BizConstant.YES) {
                showError("所选数据中含有已审核的数据，已审核的数据不能进行该操作！");
                return false;
            }
            if (binsApprovalFlag == BizConstant.CLOSE) {
                showError("所选数据中含有已封账的数据，已封账的数据不能进行该操作！");
                return false;
            }
            feeStatus = $("#mainTable").getCell(ids[i], 'feeStatus');
            if (feeStatus == BizConstant.FEE_STATUS.FEE_STATUS_0) {
                showError("所选数据中含有暂存的数据，暂存的数据不能进行审核！");
                return false;
            }
        }
        return true;
    }
    function checkUnBinsApprovalFlag() {
        var ids = $('#mainTable').jqGrid('getGridParam', 'selarrrow');
        var binsApprovalFlag;
        for (var i = 0; i < ids.length; i++) {
            binsApprovalFlag = $("#mainTable").getCell(ids[i], 'binsApprovalFlag');
            if (binsApprovalFlag != 'Y') {
                showError("只有已审核的数据才能进行反审核！");
                return false;
            }
        }
        return true;
    }

    function getPostURL(tblKey) {
        var url = "${ctxZG}/feeBatchManage/search";
        return url + "?" + $("#searchForm").serialize();
    }

    $(window).resize(function () {
        screenResize();
    });

    function screenResize() {
        var windowHeight = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
        $("#mainTable").setGridWidth($(window).width() * 0.99);
        $("#mainTable").setGridHeight(windowHeight - $("#selectCondition").height() - $(".ui-jqgrid-labels").height()
            - $("#mainPager").height() - 70);
        $("#footer").width($("#gbox_mainTable").width());
    }

    //非空判断
    function isBlank(obj) {
        return (!obj || $.trim(obj) === "");
    }
    function errorMsg(msg, time) {
        var displayTime = 2000;
        if (typeof (time) != "undefined") {
            displayTime = time;
        }
        layer.msg(msg, {
            icon: 2,
            time: displayTime
        });
    }
    function operateFormatter(value, row, index) {
        var editDelStr = "<a href='javascript:void(0)' onclick='openUrl(&quot;" + value + "&quot;)' style='color: blue;' >" + value + "</a>";
        return editDelStr
    }

    function openUrl(orderNo) {
        var ids=$("#mainTable").jqGrid('getDataIDs');
        var orderNoAll='';
        for(var j=0;j < ids.length;j++){
            var orderNostr = $("#mainTable").getCell(ids[j],'orderNo');
            if(orderNoAll.indexOf(orderNostr) > -1)
                continue;
            orderNoAll = orderNoAll + ',' + orderNostr ;
            if (orderNoAll.substr(0,1)==',')
                orderNoAll=orderNoAll.substr(1);
        }
        var orderNosKey = 'ordRecPayManage' + Date.parse(new Date());
        setSessionStorageItem(orderNosKey,orderNoAll);
        creatIframeFromSub("${ctx}/finance/expense/ordRecPayManage?orderNo=" + orderNo + "&orderNosKey=" + orderNosKey,'费用管理');
    }
</script>