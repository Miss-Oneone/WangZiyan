<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<script type="text/javascript">
    $(document).ready(function () {
        $("#updatePlanDate").click(function () {
            var planDate = $("#planDate").val();
            if (!planDate) {
                showError("计划日期不能为空");
                return
            }
            var heapPlanIds = $("#heapPlanIds").val();
            heapPlanIds = heapPlanIds.split("-");
            $.ajax({
                url: "${ctxZG}/yard/updatePlanDate",
                type: "post",
                data: {
                    planDate: planDate,
                    heapPlanIds: JSON.stringify(heapPlanIds)
                },
                success: function (result) {
                    var obj = JSON.parse(result);
                    if (obj.resultType == BizConstant.SUCCESS) {
                        showTip("修改成功");
                        setTimeout(function () {
                            parent.doSearch();
                            parent.close();
                        },1000)
                    } else {
                        showError(obj.resultMsg);
                    }
                },
                error: function (xhr, status, error) {
                    showError("系统错误");
                }
            })
        })
    })

</script>