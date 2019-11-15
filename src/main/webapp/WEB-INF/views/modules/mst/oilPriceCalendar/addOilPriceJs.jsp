<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<script type="text/javascript">
    $(document).ready(function(){
        //保存
        $("#save").click(function(){
            if(validate()) {
                layer.confirm('确认提交数据吗？', {icon: 3, title:'提示'}, function(index){
                    doConfirm();
                });
            }
        });

        //取消
        $("#cancel").click(function(){
            doClose();
        })

    });

    function doConfirm() {
        openLoading();
        postHelper("oilPriceCalendar/addConfirm?"+$('#saveForm').serialize(), {
        }, function(response) {
            closeLoading();
            if(response.resultType == BizConstant.SUCCESS) {
                showTip(response.resultMsg);
                setTimeout(function () {
                    window.parent.frames.doSearch();
                    doClose();
                },1000)

            }else {
                showError(response.resultMsg);
            }
        });
        layer.close(parent.layer.index);
    }

    function doClose(){
        var index = parent.layer.getFrameIndex(window.name);
        parent.layer.close(index);
    }

    //提交验证
    function validate(){
        var effectiveDate = $("#effectiveDate").val();
        if(isBlank(effectiveDate)) {
            tipMsg(MsgConstants.getMsg("M00011", "生效时间"));
            return false;
        }

        var oilPriceType = $("#oilPriceType").val();
        if(isBlank(oilPriceType)) {
            tipMsg(MsgConstants.getMsg("M00011", "油价分类"));
            return false;
        }

        var oilType = $("#oilType").val();
        if(isBlank(oilType)) {
            tipMsg(MsgConstants.getMsg("M00011", "燃油类型"));
            return false;
        }

        var lastPrice = $("#lastPrice").val();
        if(isBlank(lastPrice)) {
            tipMsg(MsgConstants.getMsg("M00011", "最终油价"));
            return false;
        }

//        var currDate = getNowFormatDate();
//        if(effectiveDate < currDate) {
//            tipMsg("生效日期不能小于当前日期");
//            return false;
//        }

        var lastPrice = $("#lastPrice").val().replace(/,/g,'');
        if(isBlank(lastPrice) || Number(lastPrice) == 0) {
            tipMsg(MsgConstants.getMsg("M00011", "最终油价"));
            return false;
        }

        return true;
    }

    function isBlank(obj){
        return(!obj || $.trim(obj) === "");
    }

    function getNowFormatDate() {
        var date = new Date();
        var seperator = "-";
        var year = date.getFullYear();
        var month = date.getMonth() + 1;
        var strDate = date.getDate();
        if (month >= 1 && month <= 9) {
            month = "0" + month;
        }
        if (strDate >= 0 && strDate <= 9) {
            strDate = "0" + strDate;
        }
        var currentdate = year + seperator + month + seperator + strDate;
        return currentdate;
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

    function tipMsg(msg, time) {
        var displayTime = 2000;
        if (typeof (time) != "undefined") {
            displayTime = time;
        }
        layer.msg(msg, {
            icon : 7,
            time : displayTime
        });
    }

    function formatNum(obj) {
        var value = obj.value.replace(/,/g,'');
        obj.value = toThousands((isNaN(Number(value))?0:Number(value)).toFixed(2));
    }

    function calAmount() {
        var tons = $('#tons').val().replace(/,/g,'');
        var price = $('#price').val().replace(/,/g,'');
        var amt = toThousands(((isNaN(Number(tons))?0:Number(tons)) * (isNaN(Number(price))?0:Number(price))).toFixed(2));
        $('#amount').val(amt);
    }

    function toThousands(num) {
        return num.toString().replace(/\d+/, function (n) {
            // 先提取整数部分
            return n.replace(/(\d)(?=(\d{3})+$)/g, function ($1) {
                // 对整数部分添加分隔符
                return $1 + ","; });
        });
    }
</script>