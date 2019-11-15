<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<script type="text/javascript">
    $(document).ready(function () {
        layui.config({
            base: "/static/sunsail/lib/layui/lay/mymodules/"
        }).use(['form',"jquery","cascader","form"], function(){
            var $ = layui.jquery;
            var cascader = layui.cascader;
            var cas=cascader({
                elem: "#heapContnNo",
                data: JSON.parse('${heapTreeForm}'),
                // url: "/aa",
                // type: "post",
                 triggerType: "change",
                // showLastLevels: true,
                // where: {
                //     a: "aaa"
                // },
                value: [],
                // changeOnSelect: true,
                success: function (valData,labelData) {
                    console.log(valData,labelData);
                }
            });

        });
    })

    function move() {
        var heapContnNo = $("#heapContnNo").val();
        var contnNo = $("#contnNo").val();
        if (!heapContnNo) {
            showError("请选择位置")
            return;
        }

        var index = layer.confirm("确定将柜子移到指定位置？", {
            btn: ['确定', '取消'], //按钮
            icon: 7
        }, function () {
            layer.close(index);
            $.ajax({
                url: "${ctxZG}/yard/updateHeapContn?contnNo=" + contnNo + "&heapContnNo=" + heapContnNo,
                type: "post",
                success: function (result) {
                    var obj = JSON.parse(result);
                    if (obj.resultType == BizConstant.SUCCESS) {
                        showTip("操作成功");
                        setTimeout(function () {
                            parent.close(true);
                        }, 1000)
                    } else {
                        showError(obj.resultMsg);
                    }
                },
                error: function (xhr, status, error) {
                    showError("系统错误");
                }
            })
        })
    }

    function back() {
        parent.close(false);
    }
</script>