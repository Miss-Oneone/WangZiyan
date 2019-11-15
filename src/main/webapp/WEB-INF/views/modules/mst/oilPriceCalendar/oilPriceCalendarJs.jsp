<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<script type="text/javascript">
    $(document).ready(function() {
        $("#searchForm img").remove();
        createGridList("#mainTable", "#mainPager", {
            tblKey:"main"
            ,sortable:true
            ,sortname : 'createTime'
            ,sortorder : 'desc'
            ,colNames:eval("${gridModel.colNames}")
            ,colModel:eval("${gridModel.colModel}")
            ,multiselect : true
            ,rowNum  : 100
            ,rowList : [1000,500,100 ]
            ,gridComplete: function() {
                afterCompleteFunction();
            }
        });

        //查询
        $("#search").click(function() {
            doSearch();
        });

        $("#add").click(function() {
            doAdd();
        });

        $("#edit").click(function() {
            var ids = jQuery("#mainTable").jqGrid('getGridParam', 'selarrrow');
            if(ids.length==1){
                var id = ids[0];
                var obj = jQuery("#mainTable").jqGrid('getRowData', id);
                if(obj.approvalStatus == '2') {
                    errorMsg(MsgConstants.getMsg("M00024", "已审核"));
                    return;
                }

                var effectiveDateArr = obj.effectiveDate.split("-");
                var yearMonth = effectiveDateArr[0]+effectiveDateArr[1];
                var currentFinancialDate = $("#currentFinancialDate").val();

                if(yearMonth < currentFinancialDate.replace("-", "")){
                    errorMsg("勾选数据的生效日的月份已经封账，不能编辑。");

                    return;
                    cancel  }

                doEdit(obj.effectiveDate, obj.oilType, obj.innerFlag, obj.approvalStatus, obj.oilPriceType);
            }else{
                errorMsg(MsgConstants.getMsg("M00001", "一条数据"));
            }
        });

        $("#approval").click(function() {
            var ids = jQuery("#mainTable").jqGrid('getGridParam', 'selarrrow');
            if(ids.length > 0) {
                var data = new Array();
                for(var i=0; i<ids.length; i++) {
                    var obj = jQuery("#mainTable").jqGrid('getRowData', ids[i]);
                    if(obj.approvalStatus == '3'||
                        obj.approvalStatus == '2') {
                        errorMsg(MsgConstants.getMsg("M00002", "已审核或无需审核的数据"));
                        return;
                    }

                    data.push({
                        "effectiveDate": obj.effectiveDate,
                        "innerFlag": obj.innerFlag,
                        "oilType":obj.oilType,
                        "approvalStatus":obj.approvalStatus
                    });
                }
                layer.confirm('确认审批数据吗？', {icon: 3, title:'提示'}, function(index){
                    approval(data);
                });
            }else {
                errorMsg(MsgConstants.getMsg("M00001", "数据"));
            }
        });
        $("#del").click(function() {
            var ids = jQuery("#mainTable").jqGrid('getGridParam', 'selarrrow');
            if(ids.length > 0) {
                var data = new Array();
                for(var i=0; i<ids.length; i++) {
                    var obj = jQuery("#mainTable").jqGrid('getRowData', ids[i]);
                    if(obj.approvalStatus == '2') {
                        errorMsg(MsgConstants.getMsg("M00002", "已审核或无需审核的数据"));
                        return;
                    }
                    data.push({
                        "effectiveDate": obj.effectiveDate,
                        "innerFlag": obj.innerFlag,
                        "oilType":obj.oilType,
                        "approvalStatus":obj.approvalStatus
                    });
                }
                layer.confirm('确认删除数据吗？', {icon: 3, title:'提示'}, function(index){
                    del(data);
                });
            }else {
                errorMsg(MsgConstants.getMsg("M00001", "数据"));
            }
        });

        $(window).resize();
        createSelectCondition();
        //画面加载完成才触发
        document.onreadystatechange = function () {
            doSearch();
        };
    });

    function doSearch() {
        $("#mainTable").jqGrid('setGridParam',{datatype:"json",url:getPostURL("main"),page:1}).trigger("reloadGrid");
    }

    //新增
    function doAdd() {
        layer.open({
            type : 2,
            maxmin : true,
            area : [ "400px", "340px" ],
            title : '新增油价',
            content : ["${ctxZG}/oilPriceCalendar/add",'no'],
            cancel : function() {
                // 点击关闭按钮时触发当前页面的查询按钮。
                if (typeof doSearch === 'function') {
                    doSearch();
                }
            }
        });
    }

    //编辑
    function doEdit(effectiveDate, oilType, innerFlag, approvalStatus, oilPriceType) {
        layer.open({
            type : 2,
            maxmin : true,
            area : [ "400px", "380px" ],
            title : '编辑购价',
            content : ["${ctxZG}/oilPriceCalendar/edit?effectiveDate="+effectiveDate+"&oilType="+oilType+"&innerFlag="+innerFlag+"&approvalStatus="+approvalStatus+"&oilPriceType="+oilPriceType,'no'],
            cancel : function() {
                // 点击关闭按钮时触发当前页面的查询按钮。
                if (typeof doSearch === 'function') {
                    doSearch();
                }
            }
        });
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

    function getPostURL(tblKey) {
        var url = "${ctxZG}/oilPriceCalendar/search";
        return url + "?" + $("#searchForm").serialize();
    }

    //审批
    function approval(data) {
        openLoading();
        postHelper("oilPriceCalendar/approval", {
            "oilPriceList": JSON.stringify(data)
        }, function(response) {
            closeLoading();
            if(response.resultType == BizConstant.SUCCESS) {
                showTip(response.resultMsg);
                doSearch();
            }else {
                showError(response.resultMsg);
            }
        });
    }

    //删除
    function del(data) {
        openLoading();
        postHelper("oilPriceCalendar/del", {
            "oilPriceList": JSON.stringify(data)
        }, function(response) {
            closeLoading();
            if(response.resultType == BizConstant.SUCCESS) {
                showTip(response.resultMsg);
                doSearch();
            }else {
                showError(response.resultMsg);
            }
        });
    }

    $(window).resize(function() {
        screenResize();
    });

    function screenResize() {
        var windowHeight = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
        $("#mainTable").setGridWidth($(window).width() * 0.99);
        $("#mainTable").setGridHeight(windowHeight - $("#selectCondition").height() - $(".ui-jqgrid-labels").height()-$("#mainPager").height() - $("#cxcelForm").height() - 60);
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