<%@ page import="com.xzg56.finance.common.constants.BizFcConstants" %>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<script type="text/javascript">
$(document).ready(function() {
    createGridList("#mainTable", "#mainPager", {
        tblKey:"main"
        ,sortable:true
        ,multiselect : true
        ,colNames:eval("${gridModel.colNames}")
        ,colModel:eval("${gridModel.colModel}")
    });

    //查询
    $("#search").click(function() {
        doSearch();
    })

    //审核通过
    $("#approval").click(function() {
        var ids = jQuery("#mainTable").jqGrid('getGridParam', 'selarrrow');
        if(ids.length > 0) {
            var data = new Array();
            for(var i=0; i<ids.length; i++) {
                var obj = jQuery("#mainTable").jqGrid('getRowData', ids[i]);
                if(obj.binsApprovalFlag != BizConstant.APPROVAL_FLAG.YES) { //过滤已审核的数据
                    data.push({
                        "orderNo": obj.orderNo,
                    })
                }
            }
            binsApproval(data, BizConstant.YES);
        }else {
            errorMsg(MsgConstants.getMsg("M00001", "一条数据"));
        }

    })

    //反审核
    $("#reverseApproval").click(function() {
        var ids = jQuery("#mainTable").jqGrid('getGridParam', 'selarrrow');
        if(ids.length > 0) {
            var data = new Array();
            for(var i=0; i<ids.length; i++) {
                var obj = jQuery("#mainTable").jqGrid('getRowData', ids[i]);
                if(obj.binsApprovalFlag == BizConstant.APPROVAL_FLAG.YES) { //过滤未审核的数据
                    data.push({
                    	"orderNo": obj.orderNo,
                    })
                }
            }
            binsApproval(data, BizConstant.NO);
        }else {
            errorMsg(MsgConstants.getMsg("M00001", "一条数据"));
        }

    })

    //审核不通过
    $("#approvalLess").click(function() {
        var ids = jQuery("#mainTable").jqGrid('getGridParam', 'selarrrow');
        if(ids.length > 0) {
            var data = new Array();
            for(var i=0; i<ids.length; i++) {
                var obj = jQuery("#mainTable").jqGrid('getRowData', ids[i]);
                if(obj.binsApprovalFlag != BizConstant.APPROVAL_FLAG.YES) { //过滤已审核的数据
                    data.push({
                        "orderNo": obj.orderNo,
                    })
                }
            }
            binsApproval(data, "X");
        }else {
            errorMsg(MsgConstants.getMsg("M00001", "一条数据"));
        }

    });

    //提交公司审核
    $("#compyAppNeed").click(function() {
        var ids = jQuery("#mainTable").jqGrid('getGridParam', 'selarrrow');
        if(ids.length > 0) {
            var data = new Array();
            for(var i=0; i<ids.length; i++) {
                var obj = jQuery("#mainTable").jqGrid('getRowData', ids[i]);
                if(obj.compyAppNeedFlag == BizConstant.COMPY_APP_NEED_FLAG.NO) { //过滤需要公司审批标志的数据
                    data.push({
                        "orderNo": obj.orderNo,
                    })
                }
            }
            submitCompyAppNeedFlag(data, BizConstant.YES);
        }else {
            errorMsg(MsgConstants.getMsg("M00001", "一条数据"));
        }

    })

    //不提交公司
    $("#compyAppNeedless").click(function() {
        var ids = jQuery("#mainTable").jqGrid('getGridParam', 'selarrrow');
        if(ids.length > 0) {
            var data = new Array();
            for(var i=0; i<ids.length; i++) {
                var obj = jQuery("#mainTable").jqGrid('getRowData', ids[i]);
                if(obj.compyAppNeedFlag == BizConstant.COMPY_APP_NEED_FLAG.YES) { //过滤未审核的数据
                    data.push({
                    	 "orderNo": obj.orderNo,
                    })
                }
            }
            submitCompyAppNeedFlag(data, BizConstant.NO);
        }else {
            errorMsg(MsgConstants.getMsg("M00001", "一条数据"));
        }

    })

    $("#profitFrom").keyup(function(){
    	clearNoNum(this);
	});
    
    $("#profitFrom").blur(function(){
    	var amount = $("#profitFrom").val();
    	if(!isBlank(amount))
    		$("#profitFrom").val(formatCurrency(amount));
    });
    
    $("#profitTo").keyup(function(){
    	clearNoNum(this);
    });
    
    $("#profitTo").blur(function(){
    	var amount = $("#profitTo").val();
    	if(!isBlank(amount))
    		$("#profitTo").val(formatCurrency(amount));
    });

    $("#export").click(function(){
        doExport();
    });
    $(window).resize();
    createSelectCondition();
});


function doSearch() {
    $("#mainTable").jqGrid('setGridParam',{datatype:"json",url:getPostURL("main"),page:1}).trigger("reloadGrid");
}

function doExport(){
    var url = "${ctxZG}/binsApprovalOrdJg/export?";
    window.location.href = url + $("#searchForm").serialize();
}
function binsApproval(data, binsAprovalFlag) {
	openLoading();
	postHelper("binsApprovalOrd/binsApproval", {
	    "orderNos": JSON.stringify(data),
	    "binsAprovalFlag": binsAprovalFlag
	}, function(response) {
	    closeLoading();
	    if(response.resultType == BizConstant.SUCCESS) {
	        showTip(response.resultMsg);
	        doSearch();
	    }else {
	        showError(response.resultMsg);
	    }
	});
	layer.close(index);
}

//提交（不提交）公司审核
function submitCompyAppNeedFlag(data, needFlag) {
    var index = layer.confirm(MsgConstants.getMsg("C00009", "更新数据"), function() {
        openLoading();
        postHelper("binsApprovalOrd/modifyCompyAppNeedFlag", {
            "orderNos": JSON.stringify(data),
            "needFlag": needFlag
        }, function(response) {
            closeLoading();
            if(response.resultType == BizConstant.SUCCESS) {
                showTip(response.resultMsg);
                doSearch();
            }else {
                showError(response.resultMsg);
            }
        });
        layer.close(index);
    })
}

function afterCompleteFunction() {
    var ids = $("#mainTable").getDataIDs();
    for(var i=0;i<ids.length;i++) {
        var rowData = $("#mainTable").getRowData(ids[i]);
        if(rowData.feeStatus==BizConstant.FEE_STATUS.FEE_STATUS_0) {
            $('#'+ids[i]).find("td").addClass("noSave");
        }else if(rowData.feeStatus==BizConstant.FEE_STATUS.FEE_STATUS_3) {
            $('#'+ids[i]).find("td").addClass("completed");
        }
    }
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

function getPostURL(tblKey) {
    var url = "${ctxZG}/binsApprovalOrdJg/list";
    return url + "?" + $("#searchForm").serialize();
}

$(window).resize(function() {
    screenResize();
});

function screenResize() {
    var windowHeight = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
    $("#mainTable").setGridWidth($(window).width() * 0.99);
    $("#mainTable").setGridHeight(windowHeight - $("#selectCondition").height() - $(".ui-jqgrid-labels").height()-$("#mainPager").height() - $("#cxcelForm").height() - 70);
    $("#footer").width($("#gbox_mainTable").width());
}

function formatAmount(str){
	 var arr = str.replace(/,/g,"");
	 arr = arr.replace(/，/g,"");
	 arr = arr.replace(/ /g,"");
     return arr;
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
        if(orderNoAll.indexOf(orderNostr) > -1)
            continue;
        orderNoAll = orderNoAll + ',' + orderNostr;
        if (orderNoAll.substr(0,1)==',')
            orderNoAll=orderNoAll.substr(1);
    }
    var orderNosKey = 'ordRecPayManage' + Date.parse(new Date());
    setSessionStorageItem(orderNosKey,orderNoAll);
    creatIframeFromSub("${ctx}/finance/expense/ordRecPayManage?orderNo=" + orderNo + "&orderNosKey=" + orderNosKey,'费用管理');
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

</script>