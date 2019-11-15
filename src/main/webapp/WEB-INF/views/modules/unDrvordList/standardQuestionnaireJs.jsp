<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<script type="text/javascript">
    if ("${noData}" == "noData") {
        showError(MsgConstants.getMsg("M00006"))
    }
    window.onload = function () {

    }

    $(document).ready(function () {
        $("#return").click(function () {
            var index = parent.layer.getFrameIndex(window.name);
            parent.layer.close(index);
        });
    });

    $(window).resize(function () {

    });

    //非空判断
    function isBlank(obj) {
        return (!obj || $.trim(obj) == "");
    }

</script>