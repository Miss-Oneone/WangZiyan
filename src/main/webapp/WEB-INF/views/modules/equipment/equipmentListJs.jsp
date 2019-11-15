<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<script type="text/javascript">
    var key;
	$(document).ready(function(){
		createGridList("#trailerMainTable", "#trailerMainPager", {
            tblKey:"main"
            ,colNames:eval("${selfTrailerGridModel.colNames}")
            ,colModel:eval("${selfTrailerGridModel.colModel}")
            ,sortable:true
            ,rowNum  : 500
            ,rowList : [1000,500,100 ]
//            ,multiselect : true
            ,shrinkToFit:true
            ,cellEdit:true
            ,cellsubmit:'remote'
            ,cellurl: '${ctxZG}/eqpManage/updateAddress'
            ,onSelectRow : function(id,status) {
//                $('#trailerMainTable').jqGrid('editRow', id,{"keys":true});
            }
            ,onSelectAll:function(aRowids,status){

            }
            ,gridComplete:function() {

            }
            ,beforeSubmitCell: function(rowid, cellname, value, iRow, iCol) {
                openLoading();
                var obj = jQuery("#trailerMainTable").jqGrid('getRowData', iRow);
                key = obj.plateNum;
            }
            ,afterSaveCell : function(serverresponse, rowid, cellname, value, iRow, iCol) {
                key = '';
                closeLoading()
                showTip('位置修改成功');
            }
            ,serializeCellData: function (postdata) {
                postdata.mstType = "010";
                postdata.key = key;
                return postdata
            }
            ,errorCell:function (serverresponse, status) {
                key = '';
                closeLoading()
                showError('位置修改失败');
            }
            ,editurl : 'clientArray'
        });

        createGridList("#truckFrameMainTable", "#truckFrameMainPager", {
            tblKey:"main"
            ,colNames:eval("${truckFrameGridModel.colNames}")
            ,colModel:eval("${truckFrameGridModel.colModel}")
            ,sortable:true
            ,rowNum  : 500
            ,rowList : [1000,500,100 ]
//            ,multiselect : true
            ,shrinkToFit:true
            ,cellEdit:true
            ,footerrow: true
            ,cellsubmit:'remote'
            ,cellurl: '${ctxZG}/eqpManage/updateAddress'
            ,beforeSubmitCell: function(rowid, cellname, value, iRow, iCol) {
                openLoading();
                var obj = jQuery("#truckFrameMainTable").jqGrid('getRowData', rowid);
                key = obj.id;
            }
            ,afterSaveCell : function(serverresponse, rowid, cellname, value, iRow, iCol) {debugger
                var msg = '位置修改成功';
                if(rowid == 'currBindContnNo'){
                    msg = '箱号修改成功'
                }
                key = '';
                closeLoading()
                showTip(msg);
            }
            ,serializeCellData: function (postdata) {
                postdata.mstType = "020";
                postdata.key = key;
                return postdata
            }
            ,errorCell:function (serverresponse, status) {
                key = '';
                closeLoading()
                showError('位置修改失败');
            }
            ,editurl : 'clientArray'
            ,gridComplete:function() {
                truckFrameCount();
            }
        });

        createGridList("#contnMainTable", "#contnMainPager", {
            tblKey:"main"
            ,colNames:eval("${contnGridModel.colNames}")
            ,colModel:eval("${contnGridModel.colModel}")
            ,sortable:true
            ,rowNum  : 500
            ,rowList : [1000,500,100 ]
//            ,multiselect : true
            ,shrinkToFit:true
            ,footerrow: true
            ,cellEdit:true
            ,cellsubmit:'remote'
            ,cellurl: '${ctxZG}/eqpManage/updateAddress'
            ,beforeSubmitCell: function(rowid, cellname, value, iRow, iCol) {
                openLoading();
                var obj = jQuery("#contnMainTable").jqGrid('getRowData', rowid);
                key = obj.id;
            }
            ,afterSaveCell : function(serverresponse, rowid, cellname, value, iRow, iCol) {
                key = '';
                closeLoading()
                showTip('位置修改成功');
            }
            ,serializeCellData: function (postdata) {
                postdata.mstType = "030";
                postdata.key = key;
                return postdata
            }
            ,errorCell:function (serverresponse, status) {
                key = '';
                closeLoading()
                showError('位置修改失败');
            }
            ,editurl : 'clientArray'
            ,gridComplete:function() {
                contnCount();
            }
        });

        $("#search").click(function(){
			doSearch();
		})
        document.onreadystatechange = function () {
            if(document.readyState=="complete") {
                doSearch();
            }
        }

        //新增
        $("#add").click(function () {
            toDetail();
        })

        //编辑
//        $("#edit").click(function () {
//            var ids = jQuery("#mainTable").jqGrid('getGridParam', 'selarrrow');
//            if(!ids || ids.length !=1) {
//                validate("请选择一条数据")
//                return;
//            }
//            var obj = jQuery("#mainTable").jqGrid('getRowData', ids[0]);
//            toDetail(obj.id)
//        })

//        $("#export").click(function(){
//
//            var ids = jQuery("#mainTable").jqGrid('getGridParam', 'selarrrow');
//            if (ids.length == 0){
//                cnt++;
//                showError(MsgConstants.getMsg("M00001", "一条或多条数据"));
//            }else {
//                var data = new Array();
//                for(var i=0; i<ids.length; i++) {
//                    var obj = jQuery("#mainTable").jqGrid('getRowData', ids[i]);
//                    obj.relatedCompyCode = obj.relatedCompyCode.split(">")[1].split("</")[0];
//                    data.push(obj.relatedCompyCode);
//                }
//                exportForRelateCompy(data);
//            }
//        })

        //导出
        $("#export").click(function () {
            doExport();
        });
        //页面init
		createSelectCondition();//加减图标-查询栏层的显示和隐藏
		$(window).resize();//显示表格的大小
	});
    //列表窗口
	$(window).resize(function(){
		screenResize();
	});
    //列表查询
	function doSearch(initFlag){
        doTrailerSearch();
        doTruckFrameSearch();
        doContnSearch();
    }

    function doTrailerSearch() {
        $("#trailerMainTable").jqGrid('setGridParam',{datatype:"json",url:getPostURL("010"),page:1}).trigger("reloadGrid");
    }

    function doTruckFrameSearch() {
        $("#truckFrameMainTable").jqGrid('setGridParam',{datatype:"json",url:getPostURL("020"),page:1}).trigger("reloadGrid");
    }

    function doContnSearch() {
        $("#contnMainTable").jqGrid('setGridParam',{datatype:"json",url:getPostURL("030"),page:1}).trigger("reloadGrid");
    }

	function getPostURL(tblKey) {
	    if (tblKey == '010') {
            var url = "${ctxZG}/eqpManage/searchTrailers";
        } else if (tblKey == '020') {
            var url = "${ctxZG}/eqpManage/searchTurckFrames";
        } else if (tblKey == '030') {
            var url = "${ctxZG}/eqpManage/searchContns";
        }
        return url+"?" + $("#searchForm").serialize();
	}
   //列表展示
	function screenResize() {
	    var windowHeight = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
//	    if($(window).width() * 0.99<1182){
//            $("#mainTable").setGridWidth(1182);
//        }else{
//            $("#trailerMainTable").setGridWidth($(window).width() * 0.99);
//        }
        $("#trailerMainTable").setGridWidth($(window).width() * 0.25);
        $("#truckFrameMainTable").setGridWidth($(window).width() * 0.40);
        $("#contnMainTable").setGridWidth($(window).width() * 0.32);

        var height = windowHeight - $("#selectCondition").height()-$(".ui-jqgrid-labels").height()-$("#content-bottom").height()-100;
	    $("#trailerMainTable").setGridHeight(height);
	    $("#truckFrameMainTable").setGridHeight(height - 23);
	    $("#contnMainTable").setGridHeight(height - 23);
//	    $("#footer").width($("#gbox_mainTable").width());
	}
    var index
    function toDetail(id) {
        var url = "${ctxZG}/contn/contnDetail"
        if(id) {
            url = url + "?id=" + id
        }
        index =  layer.open({
            type : 2,
            area : [ "800px", "350px" ],
            title : false,
            closeBtn: false,
            content : url,
            cancel : function() {
            }
        })
//        layer.full(index)
    }

    //非空判断
    function isBlank(obj){
        return(!obj || $.trim(obj) === "");
    }

    function validate(msg, time) {
        var displayTime = 1500;
        if (typeof (time) != "undefined") {
            displayTime = time;
        }
        layer.msg(msg, {
            icon : 7,
            time : displayTime
        });
    }

    function back() {
        layer.close(index)
        doSearch();
    }

    function exportForRelateCompy(objs){
        var url = "${ctxZG}/relateCompany/exportRelateCompy";
        $("#objs").val(JSON.stringify(objs));
        $("#searchForm").attr("action", url);
        $("#searchForm").submit();
    }

    /**
     * 查找车架号
     */
    function searchframeNum(value) {
        $.ajax({
            url: "${ctxZG}/container/searchFrameNum?id="+value,
            type: "post",
            success: function (result) {
                var obj = JSON.parse(result);
                if (obj.resultType == BizConstant.SUCCESS) {
                    $("#frameNum").val(obj.dataModel);
                } else {
                    showError(obj.resultMsg);
                }
            },
            error: function (xhr, status, error) {
                showError("系统错误");
            }
        })
    }

    var choseContnNoFlag = false;
    function choseContnNo(contnNo) {
        choseContnNoFlag = true;
        $("#contnNo").val(contnNo);
        choseContnNoFlag = false;
        $("#contnNoOptions").html('');
        $("#contnNoOptions").hide();
    }

    function closeContnNoOptions(e) {
        setTimeout(function () {
            if (choseContnNoFlag) {
                return;
            }
            $("#contnNoOptions").html('');
            $("#contnNoOptions").hide();
            choseContnNoFlag = false;
        }, 400)
    }

    function input(e) {
        var contnNo = e.target.value;
        if (contnNo) {
            $("#contnNoOptions").show();
            $.ajax({
                url: "${ctxZG}/container/getLikeContnNos?contnNo="+contnNo,
                type: "post",
                success: function (result) {
                    var obj = JSON.parse(result);
                    if (obj.resultType == BizConstant.SUCCESS) {
                        $("#contnNoOptions").html('')
                        var likeContnNos = obj.dataModel;
                        var html = '';
                        for (var i in likeContnNos) {
                            html += '<p onclick="choseContnNo(\''+ likeContnNos[i] + '\')">' + likeContnNos[i] + '</p>'
                        }
                        $("#contnNoOptions").html(html);

                    } else {
                        showError(obj.resultMsg);
                    }
                },
                error: function (xhr, status, error) {
                    showError("系统错误");
                }
            })
        } else {
            $("#contnNoOptions").hide();
        }
    }

    function truckFrameCount() {
        var cnt = 0;
        cnt += jQuery("#truckFrameMainTable").getCol("count",false,"sum");
        $("#truckFrameMainTable").jqGrid('footerData', 'set',
            {frameNum: '次数合计：',count: cnt.toFixed(0)}, false);
    }

    function contnCount() {
        var cnt = 0;
        cnt += jQuery("#contnMainTable").getCol("count",false,"sum");
        $("#contnMainTable").jqGrid('footerData', 'set',
            {contnType: '次数合计：',count: cnt.toFixed(0)}, false);
    }

    //导出
    function doExport() {
        layer.confirm(MsgConstants.getMsg("C00008", "设备统计信息？"), function () {
            closeLayerFirm();
            $("#searchForm").attr("action",
                "${ctxZG}/eqpManage/export?" + $("#searchForm").serialize());
            $("#searchForm").submit();
        });
    }
    function closeLayerFirm() {
        var i = layer.confirm();
        layer.close(i);
    }
</script>