<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<script type="text/javascript">
    var cnt = 0;
	$(document).ready(function(){
		createGridList("#mainTable", "#mainPager", {
	        tblKey:"main"
	       ,colNames:eval("${gridModel.colNames}")
	       ,colModel:eval("${gridModel.colModel}")
           ,sortable:true
	       ,rowNum  : 500
	       ,rowList : [1000,500,100 ]
	       ,multiselect : true
           ,shrinkToFit:true
            ,onSelectRow : function(id,status) {

            }
            ,onSelectAll:function(aRowids,status){

            }
            ,gridComplete:function() {

            }
            ,editurl : 'clientArray'
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
        $("#edit").click(function () {
            var ids = jQuery("#mainTable").jqGrid('getGridParam', 'selarrrow');
            if(!ids || ids.length !=1) {
                validate("请选择一条数据")
                return;
            }
            var obj = jQuery("#mainTable").jqGrid('getRowData', ids[0]);
            toDetail(obj.id)
        })

        $("#export").click(function(){
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
	function doSearch(){
        $("#mainTable").jqGrid('setGridParam',{datatype:"json",url:getPostURL("main"),page:1}).trigger("reloadGrid");
    }

	function getPostURL(tblKey) {
	    var url = "${ctxZG}/contn/search";
        return url+"?" + $("#searchForm").serialize();
	}
   //列表展示
	function screenResize() {
	    var windowHeight = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
	    if($(window).width() * 0.99<1182){
            $("#mainTable").setGridWidth(1182);
        }else{
            $("#mainTable").setGridWidth($(window).width() * 0.99);
        }

	    $("#mainTable").setGridHeight(windowHeight - $("#selectCondition").height()-$(".ui-jqgrid-labels").height()-$("#mainPager").height()-$("#content-bottom").height()-70);
	    $("#footer").width($("#gbox_mainTable").width());
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

    //导出
    function doExport() {
        layer.confirm(MsgConstants.getMsg("C00009", "自备箱导出"), function () {
            closeLayerFirm();
            $("#searchForm").attr("action","${ctxZG}/contn/export?" + $("#searchForm").serialize());
            $("#searchForm").submit();
        });
    }

    function closeLayerFirm() {
        var i = layer.confirm();
        layer.close(i);
    }
</script>