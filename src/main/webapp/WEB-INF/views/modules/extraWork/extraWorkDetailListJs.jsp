<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<script type="text/javascript">
    var index;
    $(document).ready(function(){
        createGridList("#mainTable", "#mainPager", {
            tblKey:"main"
            ,colNames:eval("${extraWorkGridModel.colNames}")
            ,colModel:eval("${extraWorkGridModel.colModel}")
            ,sortable:true
            ,rowNum  : 500
            ,rowList : [1000,500,100 ]
            ,multiselect : true
            ,shrinkToFit:true
        });

        //查询
        $("#search").click(function(){
            doSearch();
        })

        //新增
        $("#add").click(function () {
            toAddAndEditid();
        })

        //编辑
        $("#edit").click(function () {
            var ids = jQuery("#mainTable").jqGrid('getGridParam', 'selarrrow');
            if(!ids || ids.length !=1) {
                validate("请选择一条数据")
                return;
            }
            var obj = jQuery("#mainTable").jqGrid('getRowData', ids[0]);
            if(obj.systemAutoFlag == 'Y'){
                validate("系统生成的数据无法编辑！")
                return;
            }
            toAddAndEditid(obj.id)
        })

        //删除
        $("#delete").click(function () {
            var ids = jQuery("#mainTable").jqGrid('getGridParam', 'selarrrow');
            if(!ids || ids.length !=1) {
                validate("请选择一条数据")
                return;
            }
            var obj = jQuery("#mainTable").jqGrid('getRowData', ids[0]);
            if(obj.systemAutoFlag == 'Y'){
                validate("系统生成的数据无法删除！")
                return;
            }
            toDelete(obj.id)
        })

        //查看小活类目
        $("#lookUp").click(function () {
            toExtraWorkPriceItem();
        })

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
        getAmount();
    }

    function getPostURL(tblKey) {
        var url = "${ctxZG}/extraWork/search";
        return url+"?" + $("#searchForm").serialize();
    }

    function getAmount() {
        $.ajax({
            url :  "${ctxZG}/extraWork/getAmount",
            data : $("#searchForm").serialize(),
            type : 'post',
            success:function(data){
                obj = JSON.parse(data);
                var json = obj.dataModel;
                $("#amountSum").attr("value",json.amountSum);
                $("#extraWorkOilPatchSum").attr("value",json.extraWorkOilPatchSum);
                $("#addKmSum").attr("value",json.addKmSum);
                $("#addKmOilPatchSum").attr("value",json.addKmOilPatchSum);
            },
            error:function(){
                showError("操作失败!");
            }
        });
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

    //新增与编辑
    function toAddAndEditid(id) {
        var url = "${ctxZG}/extraWork/addAndEdit"
        if(id) {
            url = url + "?id=" + id
        }
        index =  layer.open({
            type : 2,
            area : [ "900px", "350px" ],
            title : false,
            closeBtn: false,
            content : url,
            cancel : function() {
            }
        })
    }

    //删除小活
    function toDelete(id) {
        var url = "${ctxZG}/extraWork/deleteExtraWork";
        layer.confirm("确定删除小活记录信息？", function () {
            $.ajax({
                url: url,
                type: "post",
                data: {
                    id: id
                },
                success: function (data) {
                    closeLoading();
                    var obj = JSON.parse(data);
                    layer.alert(obj.resultMsg, function (index) {
                        doSearch();
                        layer.closeAll();
                    });
                }
            });
        });
    }

    //查看小活名称
    function toExtraWorkPriceItem() {
        var url = "${ctxZG}/extraWork/extraWorkPriceItem"
        index =  layer.open({
            type : 2,
            area : [ "800px", "350px" ],
            title : false,
            closeBtn: true,
            content : url,
            cancel : function() {
            }
        })
    }

    function back() {
        layer.close(index)
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
</script>
