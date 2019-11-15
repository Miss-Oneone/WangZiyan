<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<script type="text/javascript">
    $(document).ready(function(){
        createGridList("#mainTable", "#mainPager", {
            tblKey:"main"
            ,colNames:eval("${extraWorkPriceItemGridModel.colNames}")
            ,colModel:eval("${extraWorkPriceItemGridModel.colModel}")
            ,sortable:true
            ,rowNum  : 500
            ,rowList : [1000,500,100 ]
            ,shrinkToFit:true
        });

        document.onreadystatechange = function () {
            if(document.readyState=="complete") {
                doSearch();
            }
        }

        //返回
        $("#back").click(function () {
            if(typeof parent.back == 'function'){
                parent.back();
            }
        })

        //页面init
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
        var url = "${ctxZG}/extraWork/searchExtraWorkPriceItem";
        return url;
    }

    //列表展示
    function screenResize() {
        var windowHeight = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
        $("#mainTable").setGridWidth($(window).width() * 0.99);

        $("#mainTable").setGridHeight(windowHeight - $("#selectCondition").height()-$(".ui-jqgrid-labels").height()-$("#mainPager").height()-$("#content-bottom").height()-70);
        $("#footer").width($("#gbox_mainTable").width());
    }

</script>