<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<script type="text/javascript">
    window.onload = function () {
        $("#piName").val($("#piCode",parent.document).find("option:selected").text());
        $("#amount").val($("#amount",parent.document).val());
        doSearch();
    }
    $(document).ready(function () {
        $("#searchForm img").remove();
        createGridList("#mainTable", "#mainPager", {
            tblKey: "main"
            , multiselect: true
            , rowNum:1000
            , rowList: [100, 500, 1000]
            , colNames: eval("${gridModel.colNames}")
            , colModel: eval("${gridModel.colModel}")
            , gridComplete:function() {
                var ids = $("#mainTable").jqGrid('getDataIDs');
                for(var i=0; i<ids.length; i++) {
                    var checkResult = $("#mainTable").getCell(ids[i],'checkResult')
                    if(checkResult == "通过")
                        $("#mainTable").jqGrid('setSelection',ids[i]);
                }
            }
        });
        $("#save").click(function () {
            insertInfo();
        });
        $(window).resize();

    });

    function doSearch() {
        $("#mainTable").jqGrid('setGridParam', {
            datatype: "json",
            postData:{
                "prFlag":$("#paymentType",parent.document).val()
                ,"orderNo":$("#orderNoStr",parent.document).val()
                ,"checkPiName" :$("#piCode",parent.document).find("option:selected").text()
                ,"checkPiCode" :$("#piCode",parent.document).val()
            },
            url: getPostURL("main"),
            page: 1
        }).trigger("reloadGrid");
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



    function getPostURL(tblKey) {
        var url = "${ctxZG}/feeBatchManage/check";
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

    function insertInfo(){
        //必须选择一条信息
        var ids = $("#mainTable").jqGrid("getGridParam", "selarrrow");
        if(ids.length == 0) {
            showError("请至少选择一条需要新增的费用！");
            return false;
        }
        var checkResult;
        for(var i=0;i<ids.length;i++) {
            var id = ids[i];
            var obj = jQuery("#mainTable").jqGrid('getRowData', id);
            checkResult = obj.checkResult;
            if (checkResult == '不通过') {
                showError("存在未录入应收实费的订单，请先剔除！");
                return false;
            }
        }

        var index = layer.confirm(MsgConstants.getMsg("C00009","更新数据"), function(index) {
            openLoading();
            $.ajax({
                url: "${ctxZG}/feeBatchManage/feeBatchSave",
                data:{orderNo:$("#orderNo").val()
                    ,selectOrderNo:$("#orderNoStr",parent.document).val()
                    ,piCode:$("#piCode",parent.document).val()
                    ,piName:$("#piName").val()
                    ,amount:$("#amount",parent.document).val()
                    ,expDate:$("#expDate",parent.document).val()
                    ,remark:$("#remarks",parent.document).val()
                    ,relatedCompy:$("#relatedCompy",parent.document).val()
                    ,prFlag:$("#paymentType",parent.document).val()
                    ,feeStatus:"1"
                },
                type:'post',
                dataType:"html",
                success:function(data){
                    closeLoading();
                    showAlert("新增完成");
                    parent.parent.doSearch();
                    parent.parent.layer.closeAll();
                }
            })
            layer.close(index);

        });
    }
</script>