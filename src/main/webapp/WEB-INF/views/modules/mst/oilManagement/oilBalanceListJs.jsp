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
            ,shrinkToFit:true
            ,gridComplete:function() {

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

        <%--$("#export").click(function(){--%>
            <%--var layerIdx = layer.confirm("确认导出数据？", function () {--%>
                <%--$("#searchForm").attr("action","${ctxZG}/oilManage/export");--%>
                <%--$("#searchForm").submit();--%>
                <%--layer.close(layerIdx)--%>
            <%--})--%>
        <%--})--%>

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
        var url = "${ctxZG}/oilManage/balanceSearch";
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