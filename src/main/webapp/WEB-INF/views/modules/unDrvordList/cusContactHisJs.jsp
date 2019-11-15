<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<script type="text/javascript">
    if ("${noData}" == "noData") {
        showError(MsgConstants.getMsg("M00006"))
    }
    window.onload = function () {
    }

    $(document).ready(function () {
        createSelectCondition();
        createGridList("#mainTable1", "#mainPager1", {
            tblKey: "main"
            , colNames: eval("${gridModel1.colNames}")
            , colModel: eval("${gridModel1.colModel}")
            , rowList: [100, 300, 500]
            , multiselect: true
            , shrinkToFit: true,
            gridComplete:function(){

            },
            onSelectRow: function(rowId){

            }
        });
        $("#mainPager1").height(29);
        createGridList("#mainTable2", "#mainPager2", {
            tblKey: "main"
            , colNames: eval("${gridModel2.colNames}")
            , colModel: eval("${gridModel2.colModel}")
            , rowList: [100, 300, 500]
            , multiselect: true
            , shrinkToFit: true,
            gridComplete:function(){

            },
            onSelectRow: function(rowId){

            }
        });
        $("#mainPager2").height(29);
        $("#mainPager2_left").append("&nbsp;<input type='button' id='hisAdd' name='' class='oms-button' style='border: none;background-color: #5a98de;width: 50px;height: 30px;color: #fff' value='增加'>");
        $("#mainPager2_left").append("&nbsp;<input type='button' id='hisEdit' name='' class='oms-button' style='border: none;background-color: #5a98de;width: 50px;height: 30px;color: #fff' value='修改'>");
        $("#mainPager2_left").append("&nbsp;<input type='button' id='hisDelete' name='revCreate' class='oms-button' style='border: none;background-color: #5a98de;width: 50px;height: 30px;color: #fff' value='删除'>");
        $(window).resize();
        //doSearch1();
        //doSearch2();

        $("#hisAdd").click(function () {
            var url = "${ctxZG}/unDrvordList/standardQuestionnaire";
            parent.layer.open({
                type: 2,
                title: "标准问卷",
                shade: 0.5,
                area: [ "900px", "450px" ], //宽高
                content: [url,'no']
            });
        });

        $("#return").click(function () {
            var index = parent.layer.getFrameIndex(window.name);
            parent.layer.close(index);
        });
    });
    $(window).resize(function () {
        screenResize("#mainTable1");
        screenResize("#mainTable2");
    });

    <!--grid-->
    function doSearch1() {
        $("#mainTable1").jqGrid('setGridParam', {
            datatype: "json",
            url: getPostURL("grid1"),
            page: 1,
            postData: {fOrderNos:$('#fOrderNos').val()}
        }).trigger("reloadGrid");
    }

    function doSearch2() {
        $("#mainTable2").jqGrid('setGridParam', {
            datatype: "json",
            url: getPostURL("grid2"),
            page: 1,
            postData: {sOrderNos:$('#sOrderNos').val()}
        }).trigger("reloadGrid");
    }

    function getPostURL(acType) {
        var url = "${ctxZG}/cabinetsMatching/cabinetsDetails";
        return url + "?" + $("#searchForm").serialize()+"&acType="+acType;
    }

    function screenResize(str) {
        var windowHeight = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
        $(str).setGridWidth($("#mainTableContent").width() * 1);
        $(str).setGridHeight(windowHeight * 0.20);
        $("#footer").width($("#gbox_mainTable").width());
    }

    <!--utils-->
    //非空判断
    function isBlank(obj) {
        return (!obj || $.trim(obj) == "");
    }

    function checkTel(e) {
        var regPho = /^1[3|4|5|8][0-9]\d{4,8}$/;
        var regTel = /^(\(\d{3,4}\)|\d{3,4}-|\s)?\d{7,14}$/;
        if(!(regPho.test(e.value)) && !(regTel.test(e.value))){
            showError("联系号码格式不正确");
            e.focus();
            return false;
        }
    }
</script>