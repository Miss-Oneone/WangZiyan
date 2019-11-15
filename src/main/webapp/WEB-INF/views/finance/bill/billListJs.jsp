<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<script type="text/javascript">
    var invoiceIssueNeedFlag = "";
	if ("${noData}" == "noData") {
		showError(MsgConstants.getMsg("M00006"))
	}

    window.onload = function() {
        doSearch();
    }
	$(document).ready(function() {
		createSelectCondition();
		createGridList("#mainTable", "#mainPager", {
			tblKey : "main",
			colNames : eval("${gridModel.colNames}"),
			colModel : eval("${gridModel.colModel}"),
			rowList : [ 1000,500, 100 ],
			multiselect : true
		   ,gridComplete:function() {
				var ids = jQuery("#mainTable").jqGrid('getDataIDs');
				for(var i = 0; i <　ids.length; i++){
					var billNo = $("#mainTable").getCell(ids[i], 'billNo');
					var id = $("#mainTable").getCell(ids[i], 'id');
					operate = "<a href='#' style='color:#383098' onclick='openDetail("+id+")' >"+billNo+"</a>";
					$("#mainTable").jqGrid('setRowData',ids[i],{billNo:operate});
				}
		   }
		});
		$(window).resize();
        $("#signImg").remove();
        $("#batchSignImg").remove();

		//查询
		$("#billSearch").click(function() {
			doSearch();
		});

        $("#billAmount").keyup(function(){
            clearNoNum(this);
        });

        $("#billAmount").blur(function(){
            var billAmount = $("#billAmount").val();
            if(!isBlank(billAmount))
                $("#billAmount").val(formatCurrency(billAmount));
        });

		//账单导出
		$("#billExport2").click(function() {
			var ids = $("#mainTable").jqGrid('getGridParam', "selarrrow");
			var para = "id";
			var feeType = "1";
			var info = "直接账单";
			var idStr = '';
			if (!checkedSelect(ids, MsgConstants.getMsg("M00001","一条或多条数据")))
				return;
            if(!checkDiff(ids,"relatedCompyCode","请选择相同往来单位！"))
                return;
			idStr = getStr(ids, para);
			var relatedCompyCode=$("#mainTable").getCell(ids[0], 'relatedCompyCode');
			doBillExport(idStr,relatedCompyCode);
		});

		//对账开始
		$("#billStart").click(function() {
			doBillStart();
		});

		//对账完成
		$("#billComplete").click(function() {
			doBillComplete();
		});

		//生成票据
		$("#invoiceCreate").click(function() {
			doInvoiceCreate();
		});

		//账单删除 
		$("#billDelete").click(function() {
			doBillDelete();
		});

		//账单明细
		$("#billDetail").click(function() {
			doBillDetail();
		});

		//账单编辑
		$("#billEdit").click(function() {
			doBillEdit();
		});

        //对账完成
        $("#billCompleteCancel").click(function() {
            doBillCompleteCancel();
        });
	});

    //状态回退
    function doBillCompleteCancel() {
        var ids = $("#mainTable").jqGrid('getGridParam', "selarrrow");
        var checkType = "6";
        var updateType = ""
        if (!checkedSelect(ids, MsgConstants.getMsg("M00001","一条或多条数据")))
            return;
        if (!checkedBillStatus(ids,"", checkType))
            return;
        updateBillHeaderStatusAjax(ids, updateType)
    }

	$(window).resize(function() {
		screenResize();
	});


	function checkFeeType(ids,feeType,info){
		var para="feeType";
		for (var i = 0; i < ids.length; i++) {
			var rowFeeType = $("#mainTable").getCell(ids[i], para);
			if (rowFeeType != feeType) {
				showError(MsgConstants.getMsg("M00001",info));
				return false;
			}
		}
		return checkDiff(ids,para,MsgConstants.getMsg("M00026"));
	}
	//查询
	function doSearch() {
		$("#mainTable").jqGrid('setGridParam', {
			datatype : "json",
			url : getPostURL("main"),page:1
		}).trigger("reloadGrid");
		setInitAmount();
	}

	function getPostURL(tblKey) {
		var url = "${ctxZG}/billManage/search";
		return url + "?" + $("#searchForm").serialize();
	}

	function screenResize() {
		var windowHeight = window.innerHeight
				|| document.documentElement.clientHeight
				|| document.body.clientHeight;
		$("#mainTable").setGridWidth($(window).width() * 0.99);
		$("#mainTable").setGridHeight(
				windowHeight - $("#selectCondition").height()
						- $(".content-button").height()
						- $("#mainPager").height() 
						- $("#content-bottom").height() - 70);
	}

	//对账导出
	function doBillExport(idStr,relatedCompyCode) {
		layer.confirm(MsgConstants.getMsg("C00008","账单"), function() {
			closeLayerFirm();
			$.ajax({
				url : "${ctxZG}/billManage/checkExport",
				type : 'POST',
				data : {
					"idStr" : idStr
				},
				async : false,
				cache : false,
				success : function(data) {
					var jsonStr = JSON.parse(data);
					if (jsonStr.length==0) {
						showError(MsgConstants.getMsg("M00006"));
					} else {
						$("#exportForm").attr("action",
								"${ctxZG}/billJgManage/export?idStr=" + idStr
										+ "&type=1&relatedCompyExecel="+relatedCompyCode);
						$("#exportForm").submit();
					}

				}
			});
		});
	}

	//选中检查
	function checkedSelect(ids, errorInfo) {
		if (ids.length == 0) {
			showError(errorInfo);
			return false;
		} else {
			if (errorInfo == MsgConstants.getMsg("M00001","一条数据") && ids.length != 1) {
				showError(errorInfo);
				return false;
			} else {
				return true;
			}
		}
		return true;

	}

	//账单状态检查 
	function checkedBillStatus(ids, errorInfo, type) {
		var billStatus;
		if (type == "1") {//1处理对账状态不为未对账
			for (var i = 0; i < ids.length; i++) {
				billStatus = $("#mainTable").getCell(ids[i], 'billStatus');
				if (billStatus != 0) {
					showError(errorInfo);
					return false;
				}
			}
			return true;
		}
		if (type == "2") {//2处理对账状态不为对账开始
			for (var i = 0; i < ids.length; i++) {
				billStatus = $("#mainTable").getCell(ids[i], 'billStatus');
				if (billStatus != "1") {
					showError(errorInfo);
					return false;
				}
			}
			return true;
		}
		if (type == "3") {//3处理对账状态不为对账完成
			for (var i = 0; i < ids.length; i++) {
				billStatus = $("#mainTable").getCell(ids[i], 'billStatus');
				if (billStatus != "2") {
					showError(errorInfo);
					return false;
				}
			}
			return true;
		}
        if (type == "4") {//4处理对账状态为生成票据
            for (var i = 0; i < ids.length; i++) {
                billStatus = $("#mainTable").getCell(ids[i], 'billStatus');
                if (billStatus == "3") {
                    showError(errorInfo);
                    return false;
                }
            }
            return true;
        }
		if (type == "5") {//4处理对账状态为对账完成或生成票据
			for (var i = 0; i < ids.length; i++) {
				billStatus = $("#mainTable").getCell(ids[i], 'billStatus');
				if (billStatus == "2"||billStatus == "3") {
				    if(billStatus=="2")
				        errorInfo =  MsgConstants.getMsg("M00002","为对账完成");
                    if(billStatus=="3")
                        errorInfo = MsgConstants.getMsg("M00002","为生成票据");
					showError(errorInfo);
					return false;
				}
			}
			return true;
		}
        if (type == "6") {//6处理对账状态为未对账或生成票据
            for (var i = 0; i < ids.length; i++) {
                billStatus = $("#mainTable").getCell(ids[i], 'billStatus');
                if (billStatus == "0"||billStatus == "3") {
                    if(billStatus == "0")
                        errorInfo = MsgConstants.getMsg("M00002","为未对账");
                    if(billStatus == "3")
                        errorInfo = MsgConstants.getMsg("M00002","为生成票据");
                    showError(errorInfo);
                    return false;
                }
            }
            return true;
        }
		return true;

	}

	//不同往来单位检查
	function checkedRelatedCompy(ids, errorInfo) {
		var para="relatedCompyCode";
		
		return checkDiff(ids,para,errorInfo);
	}
	
	//不同业务
	function checkedFeeType(ids, errorInfo) {
		var para="feeType";
		
		return checkDiff(ids,para,errorInfo);
	}
	
	//费用未审批check
	function checkedBinsApprovalFlag(){
		var ids = $("#mainTable").jqGrid('getGridParam', "selarrrow");
		var para = "id";
		var idStr = getStr(ids, para);
		$.ajax({
			type : "post",
			url : "${ctxZG}/billManage/checkedBinsApprovalFlag",
			data : {
				'ids' : idStr,
			},
			success : function(data) {
				var obj = JSON.parse(data);
				if(obj.resultType=='-1'){
					showError(MsgConstants.getMsg("M00030"));
                    invoiceIssueNeedFlag = ""
				}else{
					var url = "${ctxZG}/billManage/invoiceHeader?ids="+ids+"&invoiceIssueNeedFlag="+invoiceIssueNeedFlag
					layer.open({
						  type: 2,
						  maxmin : true,
						  title: '票据生成',
						  shade: 0.5,
						  area: [ "1100px", "500px" ], //宽高
						  content: url
					});
                    invoiceIssueNeedFlag = "";
				}
			}
		});
	}
	
	//所选字段值不同check
	function checkDiff(ids,para,errorInfo){
		var temp;
		var tempNext;
		for (var i = 0; i < ids.length; i++) {
			temp = $("#mainTable").getCell(ids[i], para);
			for (var j = i+1; j < ids.length; j++) {
				tempNext = $("#mainTable").getCell(ids[j],
						para);
				if (temp != tempNext) {
					showError(errorInfo);
					return false;
				}
			}

		}
		return true;
	}
	
	//更新
	function updateBillHeaderStatusAjax(ids, type) {
		var para = 'id';
		var idStr = getStr(ids, para);
		layer.confirm(MsgConstants.getMsg("C00009","更新数据"), function() {
			openLoading();
			closeLayerFirm();
			$.ajax({
				type : "post",
				url : "${ctxZG}/billManage/updateBillHeaderStatus",
				data : {
					'ids' : idStr,
					'type' : type
				},
				success : function(data) {
					var obj = JSON.parse(data);
					closeLoading();
					showAlert(obj.resultMsg,1000);
					doSearch();
				}
			});
		});

	}
	
	//账单删除
	function deleteBillStatusAjax(ids) {
		var para1 = 'id';
		var idStr = getStr(ids, para1);
		layer.confirm(MsgConstants.getMsg("C00009","删除这些账单"), function() {
			openLoading();
			closeLayerFirm();
			$.ajax({
				type : "post",
				url : "${ctxZG}/billManage/deleteBill",
				data : {
					'ids' : idStr,
				},
				success : function(data) {
					var obj = JSON.parse(data);
					closeLoading();
					showAlert(obj.resultMsg,1000);
					doSearch();
				}
			});
		});

	}

	//对账开始
	function doBillStart() {
		var ids = $("#mainTable").jqGrid('getGridParam', "selarrrow");
		var type = "1";
		var para = "id";
		if (!checkedSelect(ids, MsgConstants.getMsg("M00001","一条或多条数据")))
			return;
		if (!checkedBillStatus(ids, MsgConstants.getMsg("M00002","不为未对账"), type))
			return;
		var idStr = getStr(ids, para);
		updateBillHeaderStatusAjax(ids, type)
	}

	//对账完成
	function doBillComplete() {
		var ids = $("#mainTable").jqGrid('getGridParam', "selarrrow");
		var type = "2";
		if (!checkedSelect(ids, MsgConstants.getMsg("M00001","一条或多条数据")))
			return;
		if (!checkedBillStatus(ids, MsgConstants.getMsg("M00002","不为对账中"), type))
			return;
		updateBillHeaderStatusAjax(ids, type)
	}

	//生成票据
	function doInvoiceCreate() {
		var ids = $("#mainTable").jqGrid('getGridParam', "selarrrow");
		var type = 3;
		if (!checkedSelect(ids, MsgConstants.getMsg("M00001","一条或多条数据")))
			return;
		if (!checkedBillStatus(ids, MsgConstants.getMsg("M00002","不为对账完成"), type))
			return;
		if (!checkedRelatedCompy(ids, MsgConstants.getMsg("M00003")))
			return;
		if (!checkedFeeType(ids, MsgConstants.getMsg("M00005")))
			return;
        if (!checkInvoiceIssueNeedFlag(ids))
            return;
		checkedBinsApprovalFlag();
	}

    //校验开票标志
    function checkInvoiceIssueNeedFlag(ids) {
        var invoiceIssueNeedFlag = ""
        var result = true;
        for (var i = 0; i < ids.length; i++) {
            var id = ids[i];
            var obj = $("#mainTable").jqGrid('getRowData', id);
            if (isBlank(obj.invoiceIssueNeedFlag)) {
                continue;
            } else {
                if (isBlank(invoiceIssueNeedFlag)) {
                    invoiceIssueNeedFlag = obj.invoiceIssueNeedFlag;
                } else {
                    if (invoiceIssueNeedFlag != obj.invoiceIssueNeedFlag) {
                        result = false;
                        break;
                    }
                }
            }
        }
        if (!result) {
            var index = layer.confirm("此次费用无法确定是否开票，请选择", {
                btn: ['开票', '不开票','取消'], //按钮
                icon: 8,
                closeBtn: 0
            }, function () {
                setInvoiceIssueNeedFlag("Y");
                checkedBinsApprovalFlag();
                layer.close(index);
            }, function () {
                setInvoiceIssueNeedFlag("N");
                checkedBinsApprovalFlag();
                layer.close(index);
            });
        } else {
            setInvoiceIssueNeedFlag(invoiceIssueNeedFlag);
        }

        return result;
    }

    function setInvoiceIssueNeedFlag(flag) {
        invoiceIssueNeedFlag = flag;
    }
	//对账删除
	function doBillDelete() {
		var ids = $("#mainTable").jqGrid('getGridParam', "selarrrow");
		var type = 5;
        if (!checkedSelect(ids, MsgConstants.getMsg("M00001","一条或多条数据")))
            return;
		if (!checkedBillStatus(ids, "", type))
			return;

		deleteBillStatusAjax(ids);
	}

	//对账明细
	function doBillDetail() {
		var ids = $("#mainTable").jqGrid('getGridParam', "selarrrow");
		if (!checkedSelect(ids, MsgConstants.getMsg("M00001","一条数据")))
			return;
		var url = "${ctxZG}/billManage/billDetail?type=detail";
		url = setParaUrl(url, ids);
		layer.open({ 
			  type: 2,
			  maxmin : true,
			  title: '账单明细',
			  shade: 0.5,
			  area: [ "1100px", "550px" ], //宽高
			  content: url
		});
	}

	function openDetail(id){
		var rowData = $("#mainTable").jqGrid("getRowData",id);
		var url = "${ctxZG}/billManage/billDetail?type=detail";
		var paymentName = rowData.paymentName;
		var feeName = rowData.feeName;
		var billStatusName = rowData.billStatusName;
		
		url += "&id=" + id;
		url += "&paymentName=" + paymentName;
		url += "&feeName=" + feeName;
		url += "&billStatusName=" + billStatusName;
		
		layer.open({ 
			  type: 2,
			  maxmin : true,
			  title: '账单明细',
			  shade: 0.5,
			  area: [ "1100px", "550px" ], //宽高
			  content: url
		});
	}
	
	//账单编辑
	function doBillEdit() {
		var ids = $("#mainTable").jqGrid('getGridParam', "selarrrow");
		if (!checkedSelect(ids, MsgConstants.getMsg("M00001","一条数据")))
			return;
		var url = "${ctxZG}/billManage/billDetail?type=edit";
		url = setParaUrl(url, ids);
		layer.open({
			  type: 2,
			  maxmin : true,
			  title: '账单编辑',
			  shade: 0.5,
			  area: [ "1100px", "350px" ], //宽高
			  content: url
		});
	}

	//设置id
	function setParaUrl(url, ids) {
		var id = $("#mainTable").getCell(ids[0], 'id');
		var paymentName = $("#mainTable").getCell(ids[0], 'paymentName');
		var feeName = $("#mainTable").getCell(ids[0], 'feeName');
		var billStatusName = $("#mainTable").getCell(ids[0], 'billStatusName');
		url += "&id=" + id;
		url += "&paymentName=" + paymentName;
		url += "&feeName=" + feeName;
		url += "&billStatusName=" + billStatusName;
		return url;

	}

	//关闭弹窗
	function closeLayerFirm() {
		var i = layer.confirm();
		layer.close(i);
	}

	<!--utils - -->
	//非空判断
	function isBlank(obj) {
        return (!obj || $.trim(obj) == "");
    }

	//多选时字段拼接如1,2,3
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
	
	function operateFormatter(value,row,obj){
		var editDelStr="";
		if(!isBlank(value)) {
	        editDelStr='<a class="a-info" href="javascript:void(0);" onclick="getInvoiceInfo(\''+ obj.invoiceId +'\')">'+value+'</a>';
	    }
	    return editDelStr;
	}
	
	function getInvoiceInfo(invoiceId){
		var url = "${ctxZG}/fcinvoice?ids=" + invoiceId;
		//window.location.href = url;
		creatIframeFromSub(url, "票据管理");
	}
	function setInitAmount(){
		$.ajax({
	        url :  "${ctxZG}/billManage/initAmount",
	        data : $("#searchForm").serialize(),
	        type : 'post',
	        success:function(data){
	        	obj = JSON.parse(data);
	        	jsonStr = obj.resultMsg;
	        	json = JSON.parse(jsonStr);
	    		$("#unAmount").attr("value",json.unAmount);
	    		$("#beginAmount").attr("value",json.beginAmount);
	    		$("#finishAmount").attr("value",json.finishAmount);
	    		$("#invoiceAmount").attr("value",json.invoiceAmount);
                $("#fiDoneAmount").attr("value",json.fiDoneAmount);

	        },
	        error:function(){
	        	showError("操作失败!");
	        }
	    });
	}
    function clearNoNum(obj){
        obj.value = obj.value.replace(/[^\d.-]/g,"");  //清除“数字”和“.”以外的字符
        obj.value = obj.value.replace(/^\./g,"");  //验证第一个字符是数字而不是.
        obj.value = obj.value.replace(/\.{2,}/g,"."); //只保留第一个. 清除多余的.
        obj.value = obj.value.replace(".","$#$").replace(/\./g,"").replace("$#$",".");
        obj.value = obj.value.replace(/\.\d{2,}$/,obj.value.substr(obj.value.indexOf('.'),3));//只保留小数点后两位小数
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