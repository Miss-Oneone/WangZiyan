<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<script type="text/javascript">
    var flag = false;//用户当前车头车牌号，如果之前保存的车牌号已经作废，下拉选是不应该有的
    var initFlag = true;
	$(document).ready(function(){
        //保存
        $("#save").click(function () {
            doSave();
        })

        //返回
        $("#back").click(function () {
            if(typeof parent.back == 'function'){
                parent.back();
            }
        })
	});

	function doSave() {
        //箱号
        var contnNo = $("#contnNo").val()
        if(!contnNo) {
            validate("箱号不能为空");
            return;
        }
        if(!verifyContainerCode(contnNo)){
            validate("箱号不符合规范!");
            return;
        }

        //箱类型
        var contnType = $("#contnType").val()
        if(!contnType) {
            validate("箱类型不能为空");
            return;
        }

        //有效标志
        var activeFlag = $("#activeFlag").val()
        if(!activeFlag) {
            validate("有效标志不能为空");
            return;
        }

        var id = $("#id").val();
        var url
        var closeFlag = false;
        if(id && id > 0) {
            //编辑
            url = "contn/eidtContn"
            closeFlag = true;
        }else {
            //新增
            url = "contn/addContn"
        }
        openLoading();
        postHelper(url, $("#saveForm").serialize(), function (res) {
            closeLoading();
            if(res.resultType == 1) {
                showTip("保存成功")
                setTimeout(function () {
                    if(closeFlag) {
                        parent.back();
                    }else {
                        window.location.reload();
                    }
                }, 1000);
            }else {
                showError(res.resultMsg);
            }
        })
    }

    function postHelper(url, data, callback) {
        url = "${ctxZG}/" + url;
        $.ajax({
            url : url,
            type : 'post',
            data: data,
            success:function(res){
                var obj = JSON.parse(res)
                callback(obj);
            },
            error:function(xhr,status,error){
                showError("系统错误");
            }
        });
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

    function trim(obj) {
        obj.value = obj.value.replace(/(^\s*)|(\s*$)/g, "");
        obj.value = obj.value.replace(/[^\u4E00-\u9FFF\x21-\x7E\’]/g, "");
    }

    //非空判断
    function isBlank(obj){
        return(!obj || $.trim(obj) === "");
    }

    function verifyContainerCode(strContnNo) {
        var Charcode = "0123456789A?BCDEFGHIJK?LMNOPQRSTU?VWXYZ";
        var contnNo = strContnNo.split("");
        if($("#txdAddrsAbbr").val() == 'OG002731'){
            return true;
        }else{
            if (contnNo.length != 11) {
                return false;
            } else {
                var result = true;
                var num = 0;
                for (var i = 0; i < 10; i++) {
                    var idx = Charcode.indexOf(contnNo[i]);
                    if (idx == -1 || Charcode[idx] == "?") {
                        return false;
                        break;
                    }
                    idx = idx * Math.pow(2, i);
                    num += idx;
                }
                num = (num % 11) % 10;
                return parseInt(contnNo[10]) == num;
            }
        }
    }
</script>