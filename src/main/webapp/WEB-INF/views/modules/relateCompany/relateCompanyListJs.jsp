<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<script type="text/javascript">
	var amountInit=0.00;
    var last;//上个选取数
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
        $("#Add").click(function() {
            addView("");
        })

        $("#edit").click(function () {
            var ids = jQuery("#mainTable").jqGrid('getGridParam', 'selarrrow');
            if (ids.length != 1){
                cnt++;
                showError(MsgConstants.getMsg("M00001", "一条数据"));
            }else {
                var obj = jQuery("#mainTable").jqGrid('getRowData', ids[0]);
                var arr = obj.relatedCompyCode.split(">")[1].split("</")[0];
                addView(arr);
            }
        })
        $("#export").click(function(){

            var ids = jQuery("#mainTable").jqGrid('getGridParam', 'selarrrow');
            if (ids.length == 0){
                cnt++;
                showError(MsgConstants.getMsg("M00001", "一条或多条数据"));
            }else {
                var data = new Array();
                for(var i=0; i<ids.length; i++) {
                    var obj = jQuery("#mainTable").jqGrid('getRowData', ids[i]);
                    obj.relatedCompyCode = obj.relatedCompyCode.split(">")[1].split("</")[0];
                    data.push(obj.relatedCompyCode);
                }
                exportForRelateCompy(data);
            }
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
        $("#mainTable").jqGrid('setGridParam',{datatype:"json",url:getPostURL("main"),page:1}).trigger("reloadGrid");
    }

	function getPostURL(tblKey) {
	    var url = "${ctxZG}/relateCompany/search";
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

    var updateFlag = 0;
	function setUpdateFlag(flag){
        updateFlag = flag;
    }
    //
    function addView(relatedCompyCode) {
        cnt++;
        index =  layer.open({
            type : 2,
            maxmin : true,
            area : [ "1000px", "700px" ],
            title : '新增或修改',
            content : "${ctxZG}/relateCompany/add?relatedCompyCode=" + relatedCompyCode,
            cancel : function(index, layer) {
                var frameId=document.getElementById('layui-layer'+cnt).getElementsByTagName("iframe")[0].id;
                $('#'+frameId)[0].contentWindow.test();
                return false;
            }
        })
    }

    //非空判断
    function isBlank(obj){
        return(!obj || $.trim(obj) === "");
    }

    var editDate;
    function operateFormatter(value, row, obj) {


        var editDelStr = '';
        if(!isBlank(value)) {
            editDelStr='<a class="a-info" href="javascript:void(0);" onclick="addView(\''+ obj.relatedCompyCode +'\')">'+value+'</a>';
        }
        return editDelStr;
    }

    function  doCancel() {
        layer.close(index);
    }
    //重新加载页面
    function doLoadWindow(dataModel,flag) {
       doSearch();
    }
    function exportForRelateCompy(objs){
        var url = "${ctxZG}/relateCompany/exportRelateCompy";
        $("#objs").val(JSON.stringify(objs));
        $("#searchForm").attr("action", url);
        $("#searchForm").submit();
    }

</script>