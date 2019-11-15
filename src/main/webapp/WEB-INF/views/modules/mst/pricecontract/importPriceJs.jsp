<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<script type="text/javascript">
$(document).ready(function(){
    //导入
    $("#import").click(function(){
        validate();
    })

    //取消
    $("#cancel").click(function(){
        doColse();
    })
});

//提交验证
function validate(){
    var files = $('input[name="file"]').prop('files');
    if(files.length == 0) {
        showError("请选择文件");
        return;
    }
    var file = files[0];
    var name = file.name;
    var start = name.lastIndexOf(".") + 1;
    var suffix = name.substring(start, name.length).toUpperCase();
    if(suffix != 'XLS') {
        return
    }
    doImport();
}

function isBlank(obj){
    return(!obj || $.trim(obj) === "");	
}

function doColse(){
    var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
    parent.layer.close(index);
}

function doImport(){
    var form = new FormData(document.getElementById("importForm"));
    openLoading();
	$.ajax({
        url :  "${ctxZG}/priceContract/upload",
        data : form,
        type : 'post',
        processData:false,
        contentType:false,
        success:function(data){
            closeLoading();
        	obj = JSON.parse(data);
        	if(obj.resultType == BizConstant.SUCCESS){
        	    showTip(obj.resultMsg);
        	    setTimeout(function(){
                    parent.doSearch();
                    parent.doCancel();
                }, 1000)
        	}else{
                showError(obj.resultMsg);
        		result = false;
        	}
        }
    });

}

function errorMsg(msg, time) {
    var displayTime = 1500;
    if (typeof (time) != "undefined") {
        displayTime = time;
    }
    layer.msg(msg, {
        icon : 2,
        time : displayTime
    });
}
</script>