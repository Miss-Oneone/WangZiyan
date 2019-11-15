<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<script type="text/javascript">
	var amountInit=0.00;
    var last;//上个选取数
	$(document).ready(function(){

        $("#save").click(function () {
            if(isBlank($("#relatedAccountName").val())){
                showError("账户名称不能为空！");
                return;
            }
            if(isBlank($("#relatedAccountNo").val())){
                showError("账户号码不能为空！");
                return;
            }

            var data = {
                id:"${id}",
                relatedCompyCode:$("#relatedCompyCode").val(),
                relatedAccountName:$("#relatedAccountName").val(),
                relatedAccountNo:$("#relatedAccountNo").val(),
                relatedAccountBank:$("#relatedAccountBank").val()
            };
            var index = layer.confirm("是否确定要保存", {
                btn: ['确定','取消'], //按钮
                icon: 7
            }, function () {
                if("${bankFlag}" == "edit"){
                    $.ajax({
                        url:"${ctxZG}/relateCompany/addOrUpdateBank",
                        type:"post",
                        data:{
                            id:"${id}",
                            flag:"${flag}",
                            relatedCompyCode:$("#relatedCompyCode").val(),
                            relatedAccountName:$("#relatedAccountName").val(),
                            relatedAccountNo:$("#relatedAccountNo").val(),
                            relatedAccountBank:$("#relatedAccountBank").val(),
                            beforeRelatedAccountNo:"${relatedAccountNo}",
                            realId:"${realId}"
                        },
                        success:function(result){
                            var obj = JSON.parse(result);
                            if(obj.resultType == BizConstant.SUCCESS){
                                showTip(obj.resultMsg);
                                data.realId = obj.dataModel;
                                parent.doCancel(data,"${flag}");
                            }else{
                                showError(obj.resultMsg);
                            }
                        },
                        error:function(xhr,status,error){
                            showError("系统错误");
                        }
                    })
                }else {
                    parent.doCancel(data,"${flag}");
                }

                layer.close(index);
            })
        })

        $("#return").click(function () {
            parent.doCancel(null,"${flag}");
        })
	});

    //非空判断
    function isBlank(obj){
        return(!obj || $.trim(obj) === "");
    }

    function onlyNumber() {
        var no = $("#relatedAccountNo").val().replace(/[^\d]/g,"");
        var str=no.replace(/(\d{4})/g,'$1 ').replace(/\s*$/,'');
        $("#relatedAccountNo").val(str);
        var pattern=new RegExp(/^([0-9]{1})(\d{11}|\d{12}|\d{13}|\d{14}|\d{15}|\d{16}|\d{17}|\d{18})$/);
        var  str = $("#relatedAccountNo").val().replace(/\s+/g, "");
        if(isBlank(str)){
            $("#flag").text("");
        }else {
            if(!pattern.test(str)){
                $("#flag").text("账户号码格式不正确！");
            }else {
                $("#flag").text("");
            }
        }
    }
    
    function onlyNumbers(parameter) {
        var pattern=new RegExp(/(^\d*$)/);
        if(!pattern.exec(parameter)){
            showError("账户号码不正确！只能是数字格式")
        }
    }

    function formatBankCarNumber (BankNo){
        if (BankNo.value == ""){
            return;
        } else {
            BankNo.value = BankNo.value.replace(/[^\d\s]/g,"");  //清除“数字”和空格以外的字符
            var account = new String (BankNo.value);
            account = account.substring(0,23); /*这里限制账号的位数 */
            if (account.match (".[0-9]{4}-[0-9]{4}-[0-9]{4}-[0-9]{7}") == null){
                /* 对照格式 */
                if (account.match (".[0-9]{4}-[0-9]{4}-[0-9]{4}-[0-9]{7}|" + ".[0-9]{4}-[0-9]{4}-[0-9]{4}-[0-9]{7}|" +
                        ".[0-9]{4}-[0-9]{4}-[0-9]{4}-[0-9]{7}|" + ".[0-9]{4}-[0-9]{4}-[0-9]{4}-[0-9]{7}") == null){
                    var accountNumeric = "";
                    var accountChar = "";
                    var i = undefined;
                    for (i=0;i<account.length;i++){
                        accountChar = account.substr (i,1);
                        if (!isNaN (accountChar.length) && (accountChar != " ")) accountNumeric = accountNumeric + accountChar;
                    }
                    account = "";
                    for (i=0;i<accountNumeric.length;i++){    /* 可将以下空格改为-,效果也不错 */
                        if (i == 4) account = account + " "; /* 帐号第四位数后加空格 */
                        if (i == 8) account = account + " "; /* 帐号第八位数后加空格 */
                        if (i == 12) account = account + " ";/* 帐号第十二位后数后加空格 */
                        if (i == 16) account = account + " ";/* 帐号第十六位后数后加空格 */
                        account = account + accountNumeric.substr (i,1)
                    }
                }
            } else {
                account = " " + account.substring (1,5) + " " + account.substring (6,10) + " " + account.substring (14,18) + "-" + account.substring(18,25);
            }
            if (account != BankNo.value) {
                BankNo.value = account;
            }
        }

    }
    function clearNoNumber(obj) {
        obj.value = obj.value.replace(/[^\d\s]/g,"");  //清除“数字”和空格以外的字符
    }
</script>