<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<script type="text/javascript">
	$(document).ready(function(){
		createGridList("#mainTable", "#mainPager", {
	        tblKey:"main"
	       ,colNames:eval("${gridModel.colNames}")
	       ,colModel:eval("${gridModel.colModel}")
           ,sortable:true
	       ,rowNum  : 500
	       ,rowList : [1000,500,100 ]
	       ,multiselect : false
           ,shrinkToFit:true
            ,onSelectRow : function(id,status) {

            }
            ,ondblClickRow: function (rowId) {
                var obj = jQuery("#mainTable").jqGrid('getRowData', rowId);
                parent.setCostRoute(obj);
                parent.setCostRouteTempKey('${plateNum}', '${fromAdrs}', '${toAdrs}');
                parent.back();
            }
            ,gridComplete:function() {

            }
            ,editurl : 'clientArray'
	   	});

        document.onreadystatechange = function () {
            if(document.readyState=="complete") {
                doSearch();
            }
        }

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
        $("#mainTable").jqGrid('setGridParam',{datatype:"json",url:getPostURL("main"),page:1}).trigger("reloadGrid");
    }

	function getPostURL(tblKey) {
	    var url = "${ctxZG}/container/getCostRoutesByIds";
        return url+"?" + $("#searchForm").serialize();
	}
   //列表展示
	function screenResize() {
	    var windowHeight = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
        $("#mainTable").setGridWidth($(window).width() * 0.99);

	    $("#mainTable").setGridHeight(windowHeight - $("#selectCondition").height()-$(".ui-jqgrid-labels").height()-$("#mainPager").height()-$("#content-bottom").height());
	    $("#footer").width($("#gbox_mainTable").width());
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
</script>