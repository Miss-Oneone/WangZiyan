<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<script type="text/javascript">
    $(document).ready(function () {
        //保存
        $("#save").click(function () {
            if (!checkPsd())
                return;
            doUnApproval()
        });

        //取消
        $("#cancel").click(function () {
            doClose();
        });

    });


    function doUnApproval() {
        var ids = parent.$('#mainTable').jqGrid('getGridParam', 'selarrrow');
        var data = new Array();
        var obj;
        var paymentType;
        for (var i = 0; i < ids.length; i++) {
            obj = parent.$("#mainTable").jqGrid('getRowData', ids[i]);
            paymentType = obj.paymentType;
            data.push({
                "id": obj.feeId,
                "feeType": "1",
                "paymentType": paymentType,
                "feeStutas": obj.feeStatus
            })
        }

        saveUnApproval(data)
    }

    //费用审核
    function saveUnApproval(data) {
        var index = layer.confirm("确定反审核该信息吗?", function () {
            openLoading();
            postHelper("binsApprovalOrd/updateUnBinsApprovalFee?remarks=" + $("#remarks").val(), {
                "datas": JSON.stringify(data)
            }, function (response) {
                closeLoading();
                if (response.resultType == BizConstant.SUCCESS) {
                    parent.doSearch();
                    showAlert(response.resultMsg)
                    parent.layer.closeAll();
                } else {
                    showError(response.resultMsg);
                }
            });
            layer.close(index)
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

    function checkPsd() {
        var psdFlag = $("#isPsdFlag").val();
        var remark = $("#remark").val();
        if (remark == '') {
            showError("请输入备注！");
            return false;
        }
        if (psdFlag == 'N') {
            showError("密码不正确！");
            return false;
        }
        return true;
    }

    function isBlank(obj) {
        return (!obj || $.trim(obj) === "");
    }

    function doClose() {
//    layer.confirm(MsgConstants.getMsg("C00022"), {
//        btn: ['确认','取消'], //按钮
//        shade: false //不显示遮罩
//    }, function(){
        var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
        parent.layer.close(index);
//    }, function(){
//
//    });
    }

    function saveIndirectCost(flag) {
        $.ajax({
            url: "${ctxZG}/indirectCostManage/saveOrUpdate",
            data: $("#saveForm").serialize(),
            type: 'post',
            success: function (data) {
                obj = JSON.parse(data);
                if (obj.resultType == BizConstant.SUCCESS) {
                    if (flag) {
                        showTip(obj.resultMsg);
                        setTimeout(function () {
                            window.parent.frames.doSearch()
                            var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
                            parent.layer.close(index);
                            parent.window.location.reload();
                        }, 1000)

                    } else {
                        showTip(obj.resultMsg);
                        window.location.reload();
                    }
                } else {
                    showError(obj.resultMsg);
                    result = false;
                }
            }
        });

    }


    function tipMsg(msg, time) {
        var displayTime = 2000;
        if (typeof (time) != "undefined") {
            displayTime = time;
        }
        layer.msg(msg, {
            icon: 7,
            time: displayTime
        });
    }

</script>