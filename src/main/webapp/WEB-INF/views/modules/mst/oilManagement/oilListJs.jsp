<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<script type="text/javascript">
	$(document).ready(function(){
        var retFlag = ${returnFlag};
		createGridList("#mainTable", "#mainPager", {
	        tblKey:"main"
            ,colNames:eval("${gridModel.colNames}")
            ,colModel:eval("${gridModel.colModel}")
            ,sortable:true
            ,rowNum  : 500
            ,rowList : [1000,500,100 ]
            ,footerrow: true
            ,shrinkToFit:true
            ,gridComplete:function() {
                $("[aria-describedby='mainTable_addLiters']").css("text-align", "right");
                $("[aria-describedby='mainTable_tankStorage']").css("text-align", "right");
                allCount();
            }
	   	});

        $("#mainPager").height(29);

        $("#search").click(function(){
            if(!($("input[name='@checkbox_innerFlagY']").is(':checked') || $("input[name='@checkbox_innerFlagN']").is(':checked'))) {
                showError("车场加油/油卡加油至少选择一项！");
                return;
            }
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
        $("#edit").click(function () {
            var id = $("#mainTable").jqGrid('getGridParam','selrow');
            if(!id) {
                validate("请选择一条数据")
                return;
            }
            var seqNo = $("#mainTable").getCell(id,'seqNo');
            toDetail(seqNo)
        })

        $("#export").click(function(){
            var layerIdx = layer.confirm("确认导出数据？", function () {
                $("#searchForm").attr("action","${ctxZG}/oilManage/export");
                $("#searchForm").submit();
                layer.close(layerIdx)
            })
        })

        //页面init
		createSelectCondition();//加减图标-查询栏层的显示和隐藏
		$(window).resize();//显示表格的大小
	});
    //列表窗口
	$(window).resize(function(){
		screenResize();
	});
    //列表查询
	function doSearch(){
        if ($("input[name='@checkbox_innerFlagY']").is(':checked') && $("input[name='@checkbox_innerFlagN']").is(':checked')){
            $('#innerFlag').val("2");
        } else if ($("input[name='@checkbox_innerFlagY']").is(':checked') && !$("input[name='@checkbox_innerFlagN']").is(':checked')) {
            $('#innerFlag').val("0");
        } else {
            $('#innerFlag').val("1");
        }
        $("#mainTable").jqGrid('setGridParam',{datatype:"json",url:getPostURL("main"),page:1}).trigger("reloadGrid");
    }

	function getPostURL(tblKey) {
        var url = "${ctxZG}/oilManage/oilRecordList";
        return url + "?" + $("#searchForm").serialize();
	}
   //列表展示
	function screenResize() {
	    var windowHeight = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
	    if($(window).width() * 0.99<1182){
            $("#mainTable").setGridWidth(1182);
        }else{
            $("#mainTable").setGridWidth($(window).width() * 0.98);
        }

	    $("#mainTable").setGridHeight(windowHeight - $("#selectCondition").height()-$(".ui-jqgrid-labels").height()-$("#mainPager").height()-$("#content-bottom").height()-90);
	    $("#footer").width($("#gbox_mainTable").width());
	}
    var index
    function toDetail(seqNo) {
        var url = "${ctxZG}/oilManage/oilDetail"
        if(seqNo) {
            url = url + "?seqNo=" + seqNo
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
        layer.full(index)
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

    function operateFormatter(value,row,index){
        var plateNum = $('#plateNum').val();
        var driverCode = $('#driverCode').val();
        var operationTimeFrom = $('#operationTimeFrom').val();
        var operationTimeTo = $('#operationTimeTo').val();
        var cardNo = $('#cardNo').val();
        var station = $('#station').val();
        var remarks = $('#remarks').val();
        var own = $('#own').is(':checked');
        var out = $('#out').is(':checked');

        var selectValue = "plateNum:"+plateNum
            +";driverCode:" + driverCode
            +";operationTimeFrom:" + operationTimeFrom
            +";operationTimeTo:" + operationTimeTo
            +";cardNo:" + cardNo
            +";station:" + station
            +";remarks:" + remarks
            +";own:" + own
            +";out:" + out
        ;
        //var editDelStr="<a onclick=\"show('"+index.seqNo+"')\" href='javascript:void(0)'>修改</a>";
        var editDelStr="<a href='${ctxZG}/oilManage/oilAdd?flag=revise&seqNo="+index.seqNo+"&selectValue="+selectValue+"'>"+"修改"+"</a>";
        return editDelStr;
    }

    function allCount(){
        var oilCount = 0;
        oilCount += jQuery("#mainTable").getCol("addLiters",false,"sum");
        $("#mainTable").jqGrid('footerData', 'set',
            {cardNo: '加油量总计：',addLiters: oilCount.toFixed(2)}, false);

        var amount = 0;
        amount += jQuery("#mainTable").getCol("amount",false,"sum");
        $("#mainTable").jqGrid('footerData', 'set',
            {unitPrice: '金额总计：',amount: amount.toFixed(2)}, false);
    }
</script>