<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<script type="text/javascript">

	//处理明细和编辑界面下的文本框状态
	window.onload = function () { 
		if("${type}"=="detail"){
			$("#expectInvoiceDate").removeClass();
			$("#expectInvoiceDate").addClass("input-text form-text");
		}
		if("${type}"=="edit"){	
		}
	}
    
	$(document).ready(function(){
		createSelectCondition();
		
		createGridList("#mainTable", "#mainPager", {
	        tblKey:"main"
	       ,colNames:eval("${gridModel.colNames}")
	       ,colModel:eval("${gridModel.colModel}")
	       ,rowNum  : 100
            ,rowList : [ 100, 500, 1000 ,3000 ]
	       ,multiselect : true
            ,gridComplete: function() {
                var ids = jQuery("#mainTable").jqGrid('getDataIDs');
                var billAmountSum=0.00;
                for(var i = 0; i <　ids.length; i++){
                    var obj = jQuery("#mainTable").jqGrid('getRowData', ids[i]);
                    billAmountSum=floatAdd(obj.billAmount,billAmountSum);
                }
                $("#billAmountSum").val(formatCurrency(billAmountSum));
                $("#totalCount").text(ids.length);
                $("#billAmountSelected").val("0.00");
            }
            ,onSelectRow : function(id,status) {
                totalAmountSelected();

            }
            ,onSelectAll:function(aRowids,status){
                totalAmountSelected();
            }
	   	});
		
		$(window).resize();
		
		doSearch();
		
		//查询
		$("#billDetailSearch").click(function(){
			doSearch();	
		});

		//导出
		$("#billExport").click(function(){
			var idStr=$("#id").val();
			doBillExport(idStr);
		});
		
		//修改金额
		$("#billDetailUpdateAmount").click(function(){
			doBillDetailUpdateAmount();
		});
		
		//账单明细删除
		$("#billDetailDelete").click(function(){
			doBillDetailDelete();
		});
		
		//增加账单明细
		$("#billDetailAdd").click(function(){
			doBillDetailAdd();
		});
		
		//账单头部更新
		$("#billHeaderUpdate").click(function(){
			doBillHeaderUpdate();
		});
		
		//返回
		$("#back1").click(function(){
			parent.layer.closeAll();
		});
		
		//返回
		$("#back2").click(function(){
			parent.layer.closeAll();
		});

        $("#billDetailSeparate").click(function(){
            billDetailSeparate();
        });

        $("#doRemark").click(function(){
            tempRemark("Y","标记");
        });

        $("#revoke").click(function(){
            tempRemark("N","撤销");
        });

        $("#ordInputGroup").change(function() {
            belongCompyChange();
        });
	});

    function tempRemark(tempRemark,info) {
        var ids = $("#mainTable").jqGrid('getGridParam',"selarrrow");
        if(!checkedSelect(ids,MsgConstants.getMsg("M00001","一条或多条数据")))
            return;
        doTempRemark(ids,tempRemark,info);
    }

    function doTempRemark(ids,tempRemark,info){
        var data = new Array();
        for(var i=0; i<ids.length; i++) {
            var obj = jQuery("#mainTable").jqGrid('getRowData', ids[i]);
            data.push({"id":obj.id
                      ,"tempRemark":tempRemark});
        }
        layer.confirm("确定"+info+"选中数据？", function(){
            openLoading();
            closeLayerFirm();
            $.ajax( {
                type : "post",
                url : "${ctxZG}/billManage/doTempRemark",
                data : {
                    'data' :JSON.stringify(data)
                },
                success : function(data) {
                    obj = JSON.parse(data);
                    closeLoading();
                    showAlert(obj.resultMsg);
                    doSearch();
                }
            });
        });

    }

	function billDetailSeparate() {
        var ids = $("#mainTable").jqGrid('getGridParam',"selarrrow");
        if(!checkedSelect(ids,MsgConstants.getMsg("M00001","一条或多条数据")))
            return;
        if(!checkedBillStatus("该账单状态为："+$("#billStatusName").val()+"，不能再进行拆分，请删除票据后，再操作！"))
            return;
        var feeCount = $("#feeCount").val();
        if(feeCount<=1){
            showError("该账单不需要进行账单拆分");
            return;
        }
        doSeparate(ids);
    }


    function doSeparate(ids){
        var data = new Array();
        for(var i=0; i<ids.length; i++) {
            var obj = jQuery("#mainTable").jqGrid('getRowData', ids[i]);
            data.push({"id":obj.id,
                       "billAmount":obj.billAmount
            });
        }
        var billId = $("#id").val();
        layer.confirm("确定进行账单拆分？", function(){
            openLoading();
            closeLayerFirm();
            $.ajax( {
                type : "post",
                url : "${ctxZG}/billManage/doSeparate",
                data : {
                    'data' :JSON.stringify(data),
                    'billId':billId,
                },
                success : function(data) {
                    obj = JSON.parse(data);
                    var amount= parseFloat(obj.dataModel.billAmount).toFixed(2);
                    $("#billAmount").val(amount);
                    $("#feeCount").val(obj.dataModel.feeCount);
                    closeLoading();
                    showAlert(obj.resultMsg);
                    doSearch();
                    parent.doSearch();
                }
            });
        });

    }

	$(window).resize(function(){
		screenResize();
	});

    //结算单位改变
    function belongCompyChange() {
        //对方结算单位全称和识别号清空
        $("#belongCompyName").val("");
        $("#itin").val("");
        $("#belongCompyFullName").val("");

        var bcText = $("#ordInputGroup").find("option:selected").text();
        if (isBlank(bcText)) {
            $("#ordInputGroup").val("");
        } else {
            $.ajax({
                type : "post",
                url : "${ctxZG}/fcinvoice/changeBelongCompy",
                data : {
                    "belongCompyCode" : $("#ordInputGroup").val()
                },
                success : function(data) {
                    var json = JSON.parse(data);
                    if (json != null) {
                        $("#belongCompyFullName").val(json.belongCompyName);
                        $("#itin").val(json.itin);
                        $("#belongCompyName").val(bcText);
                    } else {
                        $("#belongCompyName").val("");
                        $("#itin").val("");
                        $("#belongCompyFullName").val("");
                    }
                }
            });
        }
    }

	function doSearch(){
	    $("#mainTable").jqGrid('setGridParam',{datatype:"json",url:getPostURL("main")}).trigger("reloadGrid");
	}

    function totalAmountSelected(){
        var billAmountSelected=0.00;
        var ids = jQuery("#mainTable").jqGrid('getGridParam', 'selarrrow');
        for(var i=0;i<ids.length;i++){
            var id = ids[i];
            var obj = $("#mainTable").jqGrid('getRowData', id);
            billAmountSelected=floatAdd(obj.billAmount,billAmountSelected);
        }
        $("#billAmountSelected").val(formatCurrency(billAmountSelected));
    }
	function getPostURL(tblKey) {
	    var url = "${ctxZG}/billManage/detailSearch?";
	    var id = $("#id").val();
	    var paymentType=$("#paymentType").val();
	    var feeType=$("#feeType").val();
	    var businessNo1=$("#businessNo1").val();
	    var businessNo2=$("#businessNo2").val();
	    var piCode=$("#piCode").val();
        var businessDateFrom=$("#businessDateFrom").val();
        var businessDateTo=$("#businessDateTo").val();
        var tempRemark=$("#tempRemark").val();
	    url += "billId="+id;
	    url += "&paymentType="+paymentType;
	    url += "&feeType="+feeType;
	    url += "&businessNo1="+businessNo1;
	    url += "&businessNo2="+businessNo2;
	    url += "&piCode="+piCode;
        url += "&businessDateFrom="+businessDateFrom;
        url += "&businessDateTo="+businessDateTo;
        url += "&tempRemark="+tempRemark;
	    return url;
	}
	
	function screenResize() {
	    var windowHeight = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
	    $("#mainTable").setGridWidth($(window).width() * 0.99);
	    $("#mainTable").setGridHeight(windowHeight - $("#selectCondition").height()-$(".content-button").height()-$("#mainPager").height()-$("#content-bottom").height() - 65);
	}
	
	function doBillDetailAdd(){
		if(!checkedBillStatus(MsgConstants.getMsg("M00007",$("#billStatusName").val())))
			return;
		var id = $("#id").val();
		var url = "${ctxZG}/billManage/initBillDetailAdd?";
		url += "id="+$("#id").val()
		layer.open({
			  type: 2,
			  maxmin : true,
			  title: '账单明细增加',
			  shade: 0.5,
			  area: ['1050px', '500px'], //宽高
			  content: url
		});
	}
	
	
	//导出
	function doBillExport(idStr){
		var relatedCompyCode = $("#relatedCompyCode").val();
		layer.confirm(MsgConstants.getMsg("C00008","账单"), function(){ 
			closeLayerFirm();
			$.ajax({
				url: "${ctxZG}/billManage/checkExport" ,
				type: 'POST',
				data: {"idStr":idStr},
				async: false,
				cache: false,
				success: function (data) {
					if (data == "noData") {
						showError(MsgConstants.getMsg("M00006"));
					}else{
						$("#exportForm").attr("action","${ctxZG}/billManage/export?idStr="+idStr+"&type=1&relatedCompyExecel="+relatedCompyCode);
						$("#exportForm").submit();
					}
				}
			});
		});
	}
	
	//账单头部更新
	function doBillHeaderUpdate(){
	    openLoading();
		layer.confirm(MsgConstants.getMsg("C00009","更新数据"), function(){
            closeLoading();
			$.ajax( {  
	            type : "post",  
	            url : "${ctxZG}/billManage/billHeaderUpdate",
	            data : {'id' : $("#id").val(),
	            	    'relatedPerson' : $("#relatedPerson").val(),
	            	    'expectInvoiceDate' : $("#expectInvoiceDate").val(),
	            	    'invoiceIssueNeedFlag' : $("#invoiceIssueNeedFlag").val(),
                        'billAmount' : $("#billAmount").val(),
	            	    'remarks' : $("#remarks").val(),
                        'ordInputGroup' : $("#ordInputGroup").val()
	            	   },
	            success : function(data) { 
		        	obj = JSON.parse(data);
		        	layer.alert(obj.resultMsg, function(index){
	        			parent.doSearch();
	        			parent.layer.closeAll();
	        		});  
	            },
	            error:function(){
		        	showAlert("操作失败!");
		        }
			});
		},function () {
            closeLoading();
        });
	}
	
	//选中检查
	function checkedSelect(ids,errorInfo){
    	if(ids.length==0){
    		showError(errorInfo);
       		return false;
    	}else{
    		if(errorInfo==MsgConstants.getMsg("M00001","一条数据")&&ids.length!=1){
    			showError(errorInfo); 
    	        return false;
    		}else{
    	    	return true;
    		}
    	}
    	return true;

	}
	
	//账单状态检查
	function checkedBillStatus(messageInfo){
		var billStatus = $("#billStatus").val();
		//0为未对账中，1为对账中
		if(billStatus=='2'||billStatus=='3'){
			showError(messageInfo);
	        return false;
		}
		return true;
	}
	
	//更新金额操作
	function updateBillAmount(ids){
		var id = $("#mainTable").getCell(ids[0],'id');
		var billLineNo = $("#mainTable").getCell(ids[0],'billLineNo');
		var billAmount = $("#mainTable").getCell(ids[0],'billAmount');
		var relatedId = $("#mainTable").getCell(ids[0],'relatedId');
		var paymentType = $("#paymentType").val();
		var feeType = $("#feeType").val();
		var url = "${ctxZG}/billManage/billDetailUpdateForm?";
		url += "id="+id;
		url += "&relatedId="+relatedId;
		url += "&billLineNo="+billLineNo;
		url += "&billAmountNow="+billAmount;
		url += "&feeType="+feeType;
		url += "&paymentType="+paymentType;
		layer.open({
			  type: 2,
			  maxmin : true,
			  title: '账单金额修改',
			  shade: 0.5,
			  area: ['700px', '300px'], //宽高
			  content: url
		});
	}
	
	//删除账单明细
	function deleteillDetailAjax(ids){
		var para1='id';
		var idsStr=getStr(ids,para1);
		var billId=$("#id").val();
		layer.confirm(MsgConstants.getMsg("C00009","更新数据"), function(){ 
			openLoading();
			closeLayerFirm();
			$.ajax( {  
	            type : "post",  
	            url : "${ctxZG}/billManage/deleteBillDetail",
	            data : {
	            	'idsStr' :idsStr,
	            	'billId':billId,
	            },
	            success : function(data) { 
	            	obj = JSON.parse(data);
	            	var result= parseFloat(obj.dataModel.billAmount).toFixed(2);
	            	$("#billAmount").val(result);
	            	$("#feeCount").val(obj.dataModel.feeCount);
	            	closeLoading();
	            	if(obj.dataModel.feeCount==0){
	            		layer.alert(MsgConstants.getMsg("M00013"), function(index){
	            			parent.doSearch();
	            			parent.layer.closeAll();
	            		});  
	            		
	            	}else{
	            		showAlert(obj.resultMsg,1000);
	            		parent.doSearch();
	            		doSearch();
	            	}
	            }
			});
		});

	}
	
	//修改金额
	function doBillDetailUpdateAmount(){
		var ids = $("#mainTable").jqGrid('getGridParam',"selarrrow");
		var index=1;
		if(!checkedSelect(ids,MsgConstants.getMsg("M00001","一条数据")))
			return;
		if(!checkedBillStatus(MsgConstants.getMsg("M00007",$("#billStatusName").val())))
			return;
		updateBillAmount(ids)
	}
	
	//删除账单明细
	function doBillDetailDelete(){
		var ids = $("#mainTable").jqGrid('getGridParam',"selarrrow");
		if(!checkedSelect(ids,MsgConstants.getMsg("M00001","一条或多条数据")))
			return;
		if(!checkedBillStatus(MsgConstants.getMsg("M00007",$("#billStatusName").val())))
			return;
		deleteillDetailAjax(ids)
	}
	
	function closeLayerFirm(){
		var i = layer.confirm();
		layer.close(i);
	}


	//非空判断
	function isBlank(obj){
	    return(!obj || $.trim(obj) === "");	
	} 
	
	//多选时字段拼接如1,2,3
	function getStr(ids,para){
		var temp='';
		var tempStr='';
    	for(var i=0; i<ids.length; i++) {
    		temp=$("#mainTable").getCell(ids[i],para);
    		tempStr +=","+temp
    	}
    	tempStr = tempStr.substring(1);
    	return tempStr;
	}

    function formatCurrency(num) {
        num = num.toString().replace(/\$|\,/g,'');
        if(isNaN(num))
            num = "0";
        sign = (num == (num = Math.abs(num)));
        num = Math.floor(num*100+0.50000000001);
        cents = num%100;
        num = Math.floor(num/100).toString();
        if(cents<10)
            cents = "0" + cents;
        for (var i = 0; i < Math.floor((num.length-(1+i))/3); i++)
            num = num.substring(0,num.length-(4*i+3))+','+
                num.substring(num.length-(4*i+3));
        return (((sign)?'':'-') + num + '.' + cents);
    }
</script>