<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<script type="text/javascript">
    if ("${noData}" == "noData") {
        showError(MsgConstants.getMsg("M00006"))
    }
    $(document).ready(function () {
        createSelectCondition();
        createGridList("#mainTable", "#mainPager", {
            tblKey: "main"
            , colNames: eval("${gridModel.colNames}")
            , colModel: eval("${gridModel.colModel}")
            , rowList: [100, 300, 500]
            , multiselect: true
            , shrinkToFit: false
        });
        $("#mainTable").jqGrid('setGroupHeaders', {
            useColSpanStyle: true
            ,groupHeaders : [ {
                startColumnName :  'binsType' ,  // 对应colModel中的name
                numberOfColumns : 2,  // 跨越的列数
                titleText :  '<div align="center"><span id="type">类型</span></div>'
            }]
        });
        doSearch();
        screenResize();
        $(window).resize(function () {
            screenResize();
        });

        $("#search").click(function () {
            doSearch();
        });

        $("#createContact").click(function () {
            var url = "${ctxZG}/unDrvordList/cusContactHis";
            layer.open({
                type: 2,
                maxmin : true,
                title: "客户联系履历",
                shade: 0.5,
                area: [ "900px", "450px" ], //宽高
                content: url
            });
        });

    });
    $(window).resize(function () {
        screenResize();
    });

    <!--grid-->
    function doSearch() {
        $("#mainTable").jqGrid('setGridParam', {
            datatype: "json",
            url: getPostURL("main"),
            page: 1
        }).trigger("reloadGrid");
    }

    function getPostURL(tblKey) {
        var url = "${ctxZG}/unDrvordList/search";
        return url + "?" + $("#searchForm").serialize();
    }

    function screenResize() {
        var windowHeight = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
        if ($(window).width() * 0.99 < 1182) {
            $("#mainTable").setGridWidth(1182);
        } else {
            $("#mainTable").setGridWidth($(window).width() * 0.99);
        }
        $("#mainTable").setGridHeight(windowHeight - $("#selectCondition").height() - $(".content-button").height() - $("#mainPager").height() - 65 - $("#content-bottom").height());
        $("#footer").width($("#gbox_mainTable").width());
    }

    //grid选中检查
    function checkedSelect(ids, errorInfo) {
        if (ids.length == 0) {
            showError(errorInfo);
            return false;
        } else {
            if (errorInfo == MsgConstants.getMsg("M00001", "一条数据") && ids.length != 1) {
                showError(errorInfo);
                return false;
            } else {
                return true;
            }
        }
        return true;

    }

    function checkTel(e) {
        var re = /^([0-9-]+)$/ ;
        if (e.value != "") {
            if (!re.test(e.value)) {
                showError("电话格式不正确");
                e.value = "";
                e.focus();
            }
        }
    }

    function closeLayerFirm() {
        var i = layer.confirm();
        layer.close(i);
    }

    <!--utils-->
    //非空判断
    function isBlank(obj) {
        return (!obj || $.trim(obj) == "");
    }

    function closeLayer(index) {
        layer.close(index);
    }
</script>