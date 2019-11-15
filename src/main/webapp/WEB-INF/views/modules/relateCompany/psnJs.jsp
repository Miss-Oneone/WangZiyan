<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<script type="text/javascript">
	var amountInit=0.00;
    var last;//上个选取数
	$(document).ready(function(){
        onlyNumber("#relatedPsnTel1");
        onlyNumber("#relatedPsnTel2");
        onlyNumber("#relatedPsnTel3");

        $("#save").click(function () {

            if(isBlank($("#relatedPsnName").val())){
                showError("联系人姓名不能为空！");
                return;
            }
            var data = {
                id:"${id}",
                relatedCompyCode:"${relatedCompyCode}",
                relatedPsnName:$("#relatedPsnName").val(),
                relatedPsnPosition:$("#relatedPsnPosition").val(),
                relatedPsnTel1:$("#relatedPsnTel1").val(),
                relatedPsnTel2:$("#relatedPsnTel2").val(),
                relatedPsnTel3:$("#relatedPsnTel3").val()
            };
            var index = layer.confirm("是否确定要保存", {
                btn: ['确定','取消'], //按钮
                icon: 7
            }, function () {
                if("${psnFlag}" == "edit"){
                    $.ajax({
                        url:"${ctxZG}/relateCompany/addOrUpdatePsn",
                        type:"post",
                        data:{
                            flag:"${flag}",
                            relatedCompyCode:"${relatedCompyCode}",
                            relatedPsnName:$("#relatedPsnName").val(),
                            relatedPsnPosition:$("#relatedPsnPosition").val(),
                            relatedPsnTel1:$("#relatedPsnTel1").val(),
                            relatedPsnTel2:$("#relatedPsnTel2").val(),
                            relatedPsnTel3:$("#relatedPsnTel3").val(),
                            beforeRelatedPsnName:"${relatedPsnName}"
                        },
                        success:function(result){
                            var obj = JSON.parse(result);
                            if(obj.resultType == BizConstant.SUCCESS){
                                showTip(obj.resultMsg);
                                data.relatedCompyCode = obj.dataModel;
                                parent.psnCancel(data,"${flag}");
                            }else{
                                showError(obj.resultMsg);
                            }
                        },
                        error:function(xhr,status,error){
                            showError("系统错误");
                        }
                    })
                }else {
                    $.ajax({
                        url:"${ctxZG}/relateCompany/checkPsnPhone",
                        type:"post",
                        data:{
                            flag:"${flag}",
                            relatedPsnTel1:$("#relatedPsnTel1").val(),
                            relatedPsnTel2:$("#relatedPsnTel2").val(),
                            relatedPsnTel3:$("#relatedPsnTel3").val(),
                        },
                        success:function(result){
                            var obj = JSON.parse(result);
                            if(obj.resultType == BizConstant.SUCCESS){
                                parent.psnCancel(data,"${flag}");
                            }else{
                                showError(obj.resultMsg);
                            }
                        },
                        error:function(xhr,status,error){
                            showError("系统错误");
                        }
                    })
                }
                layer.close(index);
            })
        })

        $("#return").click(function () {
            parent.psnCancel(null,"${flag}");
        })
	});

    //非空判断
    function isBlank(obj){
        return(!obj || $.trim(obj) === "");
    }

    function clearNoNumber(obj) {
        obj.value = obj.value.replace(/[^\d-]/g,"");  //清除“数字”以外的字符
    }
    function onlyNumber(main){
        $(main).keyup(function () {
            clearNoNumber(this);
        })
    }
</script>