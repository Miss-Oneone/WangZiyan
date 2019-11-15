<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<script type="text/javascript">
    window.onload = function () {
        doSearch();
    }
$(document).ready(function() {
	$("#searchForm img").remove();
    createGridList("#mainTable", "#mainPager", {
        tblKey:"main"
        ,multiselect : true
        ,rowList : [ 100, 300, 500 ]
        ,colNames:eval("${gridModel.colNames}")
        ,colModel:eval("${gridModel.colModel}")
    });

    //查询
    $("#search").click(function() {
        doSearch();
    })


     $("#save").click(function() {
        var ids = jQuery("#mainTable").jqGrid('getGridParam', 'selarrrow');
        if(ids.length > 0) {
            var data = new Array();
            var hasOther = false;
            for(var i=0; i<ids.length; i++) {
                var obj = jQuery("#mainTable").jqGrid('getRowData', ids[i]);
                if(obj.feeStatus != BizConstant.FEE_STATUS.FEE_STATUS_0) {
                	showError(MsgConstants.getMsg("M00002", "非暂存数据"));
                    return;
                }
                if(obj.createBy != ${userId}) {
                    hasOther = true;
                }
                data.push({
                    "id": obj.id,
                    "paymentType": obj.paymentType
                })
            }
            if(hasOther) {
                var index = layer.confirm(MsgConstants.getMsg("M00025"), {
                    btn: ['仍然提交','取消'], //按钮
                    icon: 7
                }, function () {
                    doSave(data, index)
                })
            }else {
                var index = layer.confirm(MsgConstants.getMsg("C00009", "提交"), function () {
                    doSave(data, index)
                })
            }

        }else {
        	showError(MsgConstants.getMsg("M00001", "一条或多条数据"));
        }

    })

    $("#generateBill").click(function() {
        var ids = jQuery("#mainTable").jqGrid('getGridParam', 'selarrrow');
        if(ids.length > 0) {
            var data = new Array();
            for(var i=0; i<ids.length; i++) {
                var obj = jQuery("#mainTable").jqGrid('getRowData', ids[i]);
                if(obj.feeStatus == BizConstant.FEE_STATUS.FEE_STATUS_3) {
                    errorMsg(MsgConstants.getMsg("M00002", "为对账完成的数据"));
                    return;
                }
                if(obj.feeStatus == BizConstant.FEE_STATUS.FEE_STATUS_0) {
                    errorMsg(MsgConstants.getMsg("M00002", "为暂存的数据"));
                    return;
                }

                data.push({
                    "id": obj.id,
                    "paymentType": obj.paymentType,
                    "feeType": "1",
                    "piCode": obj.piCode,
                    "piName": obj.piName,
                    "compyCode": obj.relatedCompyCode,
                    "compyName": obj.compySname,
                    "compyFName": obj.compyFname,
                    "reconAmount": (obj.amount-obj.billAmount),
                    "orderNo":obj.orderNo.split(">")[1].split("<")[0],
                    "contnTime":obj.contnTime,
                    "billAmount":obj.billAmount,
                    "amount":obj.amount,
                    "invoiceIssueNeedFlag":obj.invoiceIssueNeedFlag
                })
            }
            generateBill(data);
        }else {
            errorMsg(MsgConstants.getMsg("M00001", "一条数据"));
        }

    });



    //生成快速账单
    function generateBill(data) {
        var index = layer.confirm(MsgConstants.getMsg("C00009", "快速账单生成"), function() {
            openLoading();
            postHelper("directCostManage/settlement", {
                "settlementModels": JSON.stringify(data)
            }, function(response) {
                closeLoading();
                if(response.resultType == BizConstant.SUCCESS) {
                    showTip(response.resultMsg);
                    //跳转票据管理页
                    setTimeout(function () {
                        doSearch();
                        if(!isBlank(response.dataModel)) {
                            creatIframeFromSub("${ctxZG}/fcinvoice?ids=" + response.dataModel, "票据管理");
                        }
                    }, 1000)
                }else {
                    showError(response.resultMsg);
                }
                doSearch();
            });
            layer.close(index);
        })
    }

    $("#export").click(function() {
        doExport();
    })

    $(window).resize();
    createSelectCondition();
});

function isContains(str, substr) {
    return str.indexOf(substr) >= 0;
}

function doSearch() {
    $("#mainTable").jqGrid('setGridParam',{datatype:"json",url:getPostURL("main"),page:1}).trigger("reloadGrid");
    getAmount();
}

function getAmount() {
    $.ajax({
        url :  "${ctxZG}/directCostManageJg/getAmount",
        data : $("#searchForm").serialize(),
        type : 'post',
        success:function(data){
            obj = JSON.parse(data);
            var json = obj.dataModel;
            $("#rAmount").attr("value",json.rAmount);
            $("#pAmount").attr("value",json.pAmount);
            $("#rBillAmount").attr("value",json.rBillAmount);
            $("#pBillAmount").attr("value",json.pBillAmount);
            $("#rUnBillAmount").attr("value",json.rUnBillAmount);
            $("#pUnBillAmount").attr("value",json.pUnBillAmount);
        },
        error:function(){
            showError("操作失败!");
        }
    });
}
//导出
function doExport() {
    var url = "${ctxZG}/directCostManageJg/export?";
    window.location.href = url + $("#searchForm").serialize();
}


//提交
function doSave(data, index) {
    openLoading();
    postHelper("directCostManage/submit", {
        "directCostList": JSON.stringify(data)
    },function(response) {
        closeLoading();
        if(response.resultType == BizConstant.SUCCESS) {
            showTip(response.resultMsg);
            doSearch();
        }else {
            showError(response.resultMsg);
        }
    });
    layer.close(index)
}

function postHelper(url, data, callback) {
    url = "${ctxZG}/" + url;
    $.ajax({
        url : url,
        type : 'post',
        data: data,
        success:function(data){
            var obj = JSON.parse(data)
            callback(obj);
        },
        error:function(xhr,status,error){
            showError("系统错误");
        }
    });
}

function getPostURL(tblKey) {
    var url = "${ctxZG}/directCostManageJg/search";
    return url + "?" + $("#searchForm").serialize();
}

$(window).resize(function() {
    screenResize();
});

function screenResize() {
    var windowHeight = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
    $("#mainTable").setGridWidth($(window).width() * 0.99);
    $("#mainTable").setGridHeight(windowHeight - $("#selectCondition").height() - $(".ui-jqgrid-labels").height()
        -$("#mainPager").height() - $("#content-bottom").height() - 70);
    $("#footer").width($("#gbox_mainTable").width());
}

//非空判断
function isBlank(obj){
    return(!obj || $.trim(obj) === "");
}
function errorMsg(msg, time) {
    var displayTime = 2000;
    if (typeof (time) != "undefined") {
        displayTime = time;
    }
    layer.msg(msg, {
        icon : 2,
        time : displayTime
    });
}
function operateFormatter(value,row,index){
    var editDelStr = "<a href='javascript:void(0)' onclick='openUrl(&quot;"+value+"&quot;)' style='color: blue;' >" + value + "</a>";
    return editDelStr
}

function openUrl(orderNo){
    var ids=$("#mainTable").jqGrid('getDataIDs');
    var orderNoAll='';
    for(var j=0;j < ids.length;j++){
        var orderNostr = $("#mainTable").getCell(ids[j],'orderNo');
        orderNostr = orderNostr.split(">")[1].split("<")[0];
        if(orderNoAll.indexOf(orderNostr)> -1)
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