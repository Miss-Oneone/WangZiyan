<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<script type="text/javascript">
    var pageType;
    var cusPageType;
    $(document).ready(function () {
        createGridList("#mainTable", "#mainPager", {
            tblKey: "main"
            , colNames: eval("${gridModel.colNames}")
            , colModel: eval("${gridModel.colModel}")
            , rowNum: 100
            , rowList: [100, 500, 1000]
            , onSelectRow: function (rowid, status) {
                var obj = $("#mainTable").jqGrid("getRowData", rowid);
                doCusSearch(obj.priceContractNo)
            }
            , gridComplete: function () {
                var ids = jQuery("#mainTable").jqGrid('getDataIDs');
                for (var i = 0; i < ids.length; i++) {
                    var priceContractNoLink = $("#mainTable").getCell(ids[i], 'priceContractNoLink');
                    operate = "<a href='#' style='color:blue' onclick='openUrl(" + "&quot;" + priceContractNoLink + "&quot;" + ")' >" + priceContractNoLink + "</a>";
                    $("#mainTable").jqGrid('setRowData', ids[i], {priceContractNoLink: operate});
                }
            }
        });

        createGridList("#cusTable", "#cusPager", {
            tblKey: "main"
            , colNames: eval("${cusGridModel.colNames}")
            , colModel: eval("${cusGridModel.colModel}")
            , rowNum: 100
            , rowList: [100, 500, 1000]
        });


        $("#search").click(function () {
            doSearch();
        });

        $("#detail").click(function () {
            var priceContractNo = "";
            var effectiveStatus = "";
            var id = $('#mainTable').jqGrid('getGridParam', 'selrow');

            if (!isBlank(id)) {
                var obj = $("#mainTable").jqGrid('getRowData', id);
                priceContractNo = obj.priceContractNo;
                effectiveStatus = obj.effectiveStatus;
            }
            openUrl(priceContractNo, effectiveStatus);
        });

        $("#add").click(function () {
            pageType = "create";
            addOrUpdate("");
        });

        $("#edit").click(function () {

            var id = $("#mainTable").jqGrid('getGridParam', 'selrow');
            if (isBlank(id)) {
                showError(MsgConstants.getMsg("M00001", "数据"));
            } else {
                pageType = "edit";
                var obj = $("#mainTable").jqGrid('getRowData', id);
                addOrUpdate(obj.priceContractNo);
            }
        });

        $("#copy").click(function () {

            var id = $("#mainTable").jqGrid('getGridParam', 'selrow');
            if (isBlank(id)) {
                showError(MsgConstants.getMsg("M00001", "数据"));
            } else {
                pageType = "copy";
                var obj = $("#mainTable").jqGrid('getRowData', id);
                addOrUpdate(obj.priceContractNo);
            }
        });

        $("#delete").click(function () {
            var id = $("#mainTable").jqGrid('getGridParam', 'selrow');
            if (isBlank(id)) {
                showError(MsgConstants.getMsg("M00001", "一条数据"));
            } else {
                var obj = $("#mainTable").jqGrid('getRowData', id);
                deletePriceContractInfo(obj.priceContractNo);
            }
        });

        $("#download").click(function () {
            window.open("${ctxZG}/mstPriceContractBf/exportTemp");
        });

        $("#export").click(function () {
            doExport();
        });

        $("#cusAdd").click(function () {
            var id = $("#mainTable").jqGrid('getGridParam', 'selrow');
            if (isBlank(id)) {
                showError("请选择价格协议");
                return;
            }
            var obj = $("#mainTable").jqGrid('getRowData', id);
            if (!checkEffectiveStatus(obj)) {
                return;
            }
            cusPageType = "create";
            addOrUpdateCus(obj.priceContractNo, "");
        });

        $("#cusEdit").click(function () {
            var id = $("#cusTable").jqGrid('getGridParam', 'selrow');
            if (isBlank(id)) {
                showError(MsgConstants.getMsg("M00001", "数据"));
            } else {
                var obj = $("#cusTable").jqGrid('getRowData', id);
                if (!checkEffectiveStatus(obj)) {
                    return;
                }
                cusPageType = "edit";
                addOrUpdateCus(obj.priceContractNo, obj.cusCode);
            }
        });

        $("#cusCopy").click(function () {
            var id = $("#cusTable").jqGrid('getGridParam', 'selrow');
            if (isBlank(id)) {
                showError(MsgConstants.getMsg("M00001", "数据"));
            } else {
                var obj = $("#cusTable").jqGrid('getRowData', id);
                if (!checkEffectiveStatus(obj)) {
                    return;
                }
                cusPageType = "copy";
                addOrUpdateCus(obj.priceContractNo, obj.cusCode);
            }
        });

        $("#cusDelete").click(function () {
            var id = $("#cusTable").jqGrid('getGridParam', 'selrow');
            if (isBlank(id)) {
                showError(MsgConstants.getMsg("M00001", "一条数据"));
            } else {
                var obj = $("#cusTable").jqGrid('getRowData', id);
                deletePriceContractCus(obj.priceContractNo, obj.cusCode);
            }
        });

        //页面init
        createSelectCondition();//加减图标-查询栏层的显示和隐藏
        $(window).resize();//显示表格的大小
        document.onreadystatechange = function () {
            if(document.readyState=="complete") {
                doSearch();
            }
        }
    });


    function doExport() {
        var url = "${ctxZG}/priceContract/export?";
        window.location.href = url + $("#searchForm").serialize();
    }

    function deletePriceContractInfo(priceContractNo) {
        openLoading();
        var index = layer.confirm("确认删除该价格协议？", function () {
            $.ajax({
                url: "${ctxZG}/priceContract/delete",
                type: "post",
                data: {"priceContractNo": priceContractNo},
                success: function (result) {
                    closeLoading();
                    var obj = JSON.parse(result);
                    if (obj.resultType == BizConstant.SUCCESS) {
                        showTip(obj.resultMsg);
                    } else {
                        showError(obj.errorMsg);
                    }
                    doSearch();
                    layer.close(index);
                },
                error: function (xhr, status, error) {
                    closeLoading();
                    showError("系统错误");
                    layer.close(index);
                }
            });
        }, function () {
            closeLoading();
        });
    }

    function deletePriceContractCus(priceContractNo, cusCode) {
        openLoading();
        var index = layer.confirm("确认删除该价格协议？", function () {
            $.ajax({
                url: "${ctxZG}/priceContract/deleteCus",
                type: "post",
                data: {"priceContractNo": priceContractNo, "cusCode": cusCode},
                success: function (result) {
                    closeLoading();
                    var obj = JSON.parse(result);
                    if (obj.resultType == BizConstant.SUCCESS) {
                        showTip(obj.resultMsg);
                    } else {
                        showError(obj.errorMsg);
                    }
                    doCusSearch();
                    layer.close(index);
                },
                error: function (xhr, status, error) {
                    closeLoading();
                    showError("系统错误");
                    layer.close(index);
                }
            });
        }, function () {
            closeLoading();
        });
    }
    //窗口
    $(window).resize(function () {
        screenResize();
    });
    //查询
    function doSearch() {
        $("#mainTable").jqGrid('setGridParam', {datatype: "json", url: getPostURL(), page: 1}).trigger("reloadGrid");
    }

    function doCusSearch(priceContractNo) {
        $("#cusTable").jqGrid('setGridParam', {
            datatype: "json",
            url: getCusPostURL(priceContractNo),
            page: 1
        }).trigger("reloadGrid");
    }
    function getPostURL() {
        var url = "${ctxZG}/priceContract/search";
        return url + "?" + $("#searchForm").serialize();
    }
    function getCusPostURL(priceContractNo) {
        var url = "${ctxZG}/priceContract/cusSearch";
        return url + "?priceContractNo=" + priceContractNo;
    }
    //列表展示
    function screenResize() {
        var windowHeight = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
        if ($(window).width() * 0.99 < 1182) {
            $("#mainTable").setGridWidth(1182);
            $("#cusTable").setGridWidth(1182);
        } else {
            $("#mainTable").setGridWidth($(window).width() * 0.99);
            $("#cusTable").setGridWidth($(window).width() * 0.99);
        }
        var height = windowHeight - $("#selectCondition").height() - $(".content-button").height() * 2 - $("#mainPager").height() * 2 - 100;
        $("#mainTable").setGridHeight(height * 0.7);
        $("#cusTable").setGridHeight(height * 0.3);
        $("#footer").width($("#gbox_mainTable").width());
    }

    //非空判断
    function isBlank(obj) {
        return (!obj || $.trim(obj) === "");
    }


    var index;
    //增加或编辑协议页面
    function addOrUpdate(priceContractNo) {
        var url = "${ctxZG}/priceContract/priceContractDetail?";
        url += "&pageType=" + pageType;
        var title = '新增协议';
        if (pageType == 'edit') {
            title = '编辑协议';
        }
        if (!isBlank(priceContractNo)) {
            url += "&priceContractNo=" + priceContractNo;
        }
        index = layer.open({
            id: 'test',
            type: 2,
            maxmin: true,
            area: ["600px", "400px"],
            title: title,
            content: url,
            cancel: function () {

            }
        })
    }

    //增加或编辑协议客户页面
    function addOrUpdateCus(priceContractNo, cusCode) {
        var url = "${ctxZG}/priceContract/priceContractCusDetail?";
        url += "pageType=" + cusPageType;
        var title = '新增协议客户';
        if (pageType == 'edit') {
            title = '编辑协议客户';
        }
        if (!isBlank(priceContractNo)) {
            url += "&priceContractNo=" + priceContractNo;
            url += "&cusCode=" + cusCode;
        }
        index = layer.open({
            id: 'test',
            type: 2,
            maxmin: true,
            area: ["400px", "250px"],
            title: title,
            content: url,
            cancel: function () {

            }
        })
    }

    function doCancel() {
        layer.close(index);
    }

    function openUrl(priceContractNo, effectiveStatus) {
        var url = "${ctxZG}/priceContract/priceContractBfInit?";
        url += "priceContractNo=" + priceContractNo;
        url += "&effectiveStatus=" + effectiveStatus;
        creatIframeFromSub(url, "价格协议明细");
    }

    function checkEffectiveStatus(obj) {
        if (obj.effectiveStatus == 'N') {
            showError("当前价格协议已经失效，不能进行客户关联");
            return false;
        }
        return true;
    }
</script>