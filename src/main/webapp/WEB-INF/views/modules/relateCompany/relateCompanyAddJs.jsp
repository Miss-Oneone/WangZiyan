<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<script type="text/javascript">
    var amountInit = 0.00;
    var bankTableData = [];
    var psnTableData = [];
    var SnameFlag = 0;
    var updateFlag = 0;
    var last;//上个选取数
    window.onload = function () {
        variable = 'T';
    }
    $(document).ready(function () {
        $("#driver").hide();

        $("#compyFname").blur(function () {
            $("#compyFname").val(trims($("#compyFname").val()))
        })

        $("#relatedCompyType").on("select2-opening", function (e) {
            defultCheck();
        });
        showAndHide();
        createGridList("#psnTable", "#psnPager", {
            tblKey: "main"
            , colNames: eval("${psnGridModel.colNames}")
            , colModel: eval("${psnGridModel.colModel}")
            , rowNum: 100
            , rowList: [100, 500, 1000]
            , multiselect: true
            , shrinkToFit: true
            , editurl: 'clientArray'

        });
        $("#psnPager").height(29);
        $("#psnPager_left").append("&nbsp;<input type='button' id='psnAdd' name='' class='oms-button' style='border: none;background-color: #5a98de;width: 50px;height: 30px;color: #fff' value='增加'>");
        $("#psnPager_left").append("&nbsp;<input type='button' id='psnEdit' name='' class='oms-button' style='border: none;background-color: #5a98de;width: 50px;height: 30px;color: #fff' value='修改'>");
        $("#psnPager_left").append("&nbsp;<input type='button' id='psnDelete' name='revCreate' class='oms-button' style='border: none;background-color: #5a98de;width: 50px;height: 30px;color: #fff' value='删除'>");
        $("#psnAdd").click(function () {
            var data = {relateCompyCode: $("#relatedCompyCode").val()}
            addPsnView(data, "addFlag", "${flag}");
        })

        $("#psnEdit").click(function () {

            var ids = jQuery("#psnTable").jqGrid('getGridParam', 'selarrrow');
            if (ids.length != 1) {
                showError(MsgConstants.getMsg("M00001", "一条数据"));
            } else {
                var obj = jQuery("#psnTable").jqGrid('getRowData', ids[0]);
                obj.id = ids[0];
                if ("${flag}" == "edit") {
                    if (isBlank(obj.relateCompyCode)) {
                        obj.relateCompyCode = $("#relatedCompyCode").val();
                    }
                }
                addPsnView(obj, "editFlag", "${flag}");
            }
        })
        $("#psnDelete").click(function () {
            var ids = jQuery("#psnTable").jqGrid('getGridParam', 'selarrrow');
            if (ids.length == 0) {
                showError(MsgConstants.getMsg("M00001", "一条或多条数据"));
            } else {
                var index1 = layer.confirm(MsgConstants.getMsg("C00009", "删除"), function () {
                    if ("${flag}" == "edit") {
                        var data = new Array();
                        for (var i = 0; i < ids.length; i++) {
                            var obj = jQuery("#psnTable").jqGrid('getRowData', ids[i]);
                            data.push(obj);
                        }
                        deletePsn(data, ids);
                    } else {
                        var len = ids.length;
                        for (var i = 0; i < len; i++) {
                            $("#psnTable").jqGrid("delRowData", ids[0]);
                        }
                    }
                    layer.close(index1);
                })
            }
        })
        createGridList("#bankTable", "#bankPager", {
            tblKey: "main"
            , colNames: eval("${bankGridModel.colNames}")
            , colModel: eval("${bankGridModel.colModel}")
            , rowNum: 100
            , rowList: [100, 500, 1000]
            , multiselect: true
            , shrinkToFit: true
            , editurl: 'clientArray'
        });

        $("#bankPager").height(29);
        $("#bankPager_left").append("&nbsp;<input type='button' id='bankAdd' name='' class='oms-button' style='border: none;background-color: #5a98de;width: 50px;height: 30px;color: #fff' value='增加'>");
        $("#bankPager_left").append("&nbsp;<input type='button' id='bankEdit' name='' class='oms-button' style='border: none;background-color: #5a98de;width: 50px;height: 30px;color: #fff' value='修改'>");
        $("#bankPager_left").append("&nbsp;<input type='button' id='bankDelete' name='revCreate' class='oms-button' style='border: none;background-color: #5a98de;width: 50px;height: 30px;color: #fff' value='删除'>");

        $("#bankAdd").click(function () {
            var data = {relateCompyCode: $("#relatedCompyCode").val()}
            addBankView(data, "addFlag", "${flag}");
        })

        $("#bankEdit").click(function () {

            var ids = jQuery("#bankTable").jqGrid('getGridParam', 'selarrrow');
            if (ids.length != 1) {
                showError(MsgConstants.getMsg("M00001", "一条数据"));
            } else {
                var obj = jQuery("#bankTable").jqGrid('getRowData', ids[0]);
                obj.id = ids[0];
                if ("${flag}" == "edit") {
                    if (isBlank(obj.relateCompyCode)) {
                        obj.relateCompyCode = $("#relatedCompyCode").val();
                    }
                }
                addBankView(obj, "editFlag", "${flag}");
            }
        })

        $("#bankDelete").click(function () {
            var ids = jQuery("#bankTable").jqGrid('getGridParam', 'selarrrow');
            if (ids.length == 0) {
                showError(MsgConstants.getMsg("M00001", "一条或多条数据"));
            } else {
                var index1 = layer.confirm(MsgConstants.getMsg("C00009", "删除"), function () {
                    if ("${flag}" == "edit") {
                        var data = new Array();
                        for (var i = 0; i < ids.length; i++) {
                            var obj = jQuery("#bankTable").jqGrid('getRowData', ids[i]);
                            if (obj.realId != "") {
                                data.push(obj.realId);
                            } else {
                                data.push(obj.id);
                            }
                        }
                        deleteBank(data, ids);
                    } else {
                        var len = ids.length;
                        for (var i = 0; i < len; i++) {
                            $("#bankTable").jqGrid("delRowData", ids[0]);
                        }
                    }
                    layer.close(index1);
                })
            }
        })

        $("#return").click(function () {
            if ("${flag}" == "edit") {
                defultCheckEdit();
            } else {
                defultCheck();
            }
            if (updateFlag == 1) {
                var index = layer.confirm("信息有更改，是否保存？", {
                    btn: ['是', '否'], //按钮
                    icon: 7
                }, function () {
                    if (!checkSave()) {
                        return;
                    }
                    submit();
                }, function () {
                    parent.doCancel();
                })
            } else {
                parent.doCancel();
            }
        })

        //页面init
        createSelectCondition();//加减图标-查询栏层的显示和隐藏
        $(window).resize();//显示表格的大小

        $("#save").click(function () {
            if (!checkSave()) {
                return;
            }
            var index = layer.confirm("是否要保存", {
                btn: ['是', '否'], //按钮
                icon: 7
            }, function () {
                layer.close(index);
                submit();
            })
        })

        //编辑时获取相应jqGrid信息
        if ("${flag}" == "edit") {
            $("#relatedCompyTypeImg").css("display", "none");
            setTimeout(function () {
                $("#relatedCompyType").val("${relateCompanyModel.relatedCompyType}").trigger("change");
                $("#relatedCompyType").select2("readonly", true);
                $("#compySname").attr("readonly", true);
                $("#activeFlag").val("${relateCompanyModel.activeFlag}").trigger("change");

            }, 100)

            doSearch("#psnTable", "getPsn");
            doSearch("#bankTable", "getBank");
        }
    });
    var variable;
    //列表窗口
    $(window).resize(function () {
        screenResizes("#bankTable");
        screenResizes("#psnTable");

    });

    function test() {
        if ("${flag}" == "edit") {
            defultCheckEdit();
        } else {
            defultCheck();
        }
        if (updateFlag == 1) {
            var index = layer.confirm("信息有更改，是否保存？", {
                btn: ['是', '否'], //按钮
                icon: 7
            }, function () {
                if (!checkSave()) {
                    return;
                }
                submit();
            }, function () {
                parent.doCancel();
            })
        } else {
            parent.doCancel();
        }
    }

    //列表查询
    function doSearch(main, address) {
        //js方法  
        $(main).jqGrid('setGridParam', {datatype: "json", url: getPostURL(address), page: 1}).trigger("reloadGrid");
    }


    function getPostURL(addresss) {
        var url = "${ctxZG}/relateCompany/" + addresss;
        return url + "?" + $("#addMassage").serialize();
    }

    //列表展示
    function screenResizes(str) {
        var windowHeight = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
        $(str).setGridWidth($("#mainTableContent").width() * 0.75);
        $(str).setGridHeight(windowHeight * 0.20);
        $("#footer").width($("#gbox_mainTable").width());
    }

    //非空判断
    function isBlank(obj) {
        return (!obj || $.trim(obj) === "");
    }

    function getSpecialContract() {

        doSearch("#mainTable", "getSpecialContract");
        doSearch("#mainTableTwo", "getSpecialContractLclBf");
        doSearch("#mainTableThree", "getSpecialCostOutContractBf");
        doSearch("#mainTableFour", "getSpecialRoute");
    }

    //清空列表数据
    function dataInfo() {
        jQuery("#mainTable").jqGrid("clearGridData");
        jQuery("#mainTableTwo").jqGrid("clearGridData");
        jQuery("#mainTableThree").jqGrid("clearGridData");
        jQuery("#mainTableFour").jqGrid("clearGridData");
    }
    var se = "";

    function showAndHide() {

        if (updateFlag == 1) {
            var index = layer.confirm("信息被改变，是否放弃本次修改？", {
                btn: ['是', '否'], //按钮
                icon: 7
            }, function () {
                $("#flag").text("");
                variable = $("#relatedCompyType").val();
                layer.close(index);
                setinput();
                updateFlag = 0;
            }, function () {
                updateFlag = 0;
                $("#relatedCompyType").val(variable).trigger("change");
                layer.close(index);
            })
        } else {
            variable = $("#relatedCompyType").val();
        }
        if ($("#relatedCompyType").val() == 'DR' || $("#relatedCompyType").val() == 'ADR' || $("#relatedCompyType").val() == 'PDR') {
            $("#driver").show();
            $("#relatedPsn").hide();
        } else {
            $("#driver").hide();
            $("#relatedPsn").show();
        }
    }

    function setinput() {
        $("#addMassage input[type='text']").each(function (i) {
            this.value = "";
        });
        $("#storageOil").val("");
        setTimeout(function () {
            $("#activeFlag").val("Y").trigger("change");
        }, 100)
        jQuery("#bankTable").jqGrid("clearGridData");
    }


    function initSetParam(data) {
        var getParam = "";
        if ((data instanceof Object) && !(data instanceof Array)) {
            for (var item in data) {
                getParam += item + "=" + data[item] + "&"
            }
        }
        console.log(getParam)
        return getParam
    }
    function addPsnView(data, flag, psnFlag) {

        var type = '${type}';
        var area = ["500px", "250px"]
        if (type) {
            area = ["900px", "450px"]
        }
        index = layer.open({
            type: 2,
            maxmin: true,
            area: area,
            title: '联系人',
            content: "${ctxZG}/relateCompany/addPsnView?" + initSetParam(data) + "flag=" + flag + "&psnFlag=" + psnFlag,
            cancel: function () {

            }
        })
    }
    function addBankView(data, flag, bankFlag, realId) {

        var type = '${type}';
        var area = ["500px", "250px"]
        if (type) {
            area = ["900px", "450px"]
        }
        index = layer.open({
            type: 2,
            maxmin: true,
            area: area,
            title: '银行账号',
            content: "${ctxZG}/relateCompany/addBankView?" + initSetParam(data) + "flag=" + flag + "&bankFlag=" + bankFlag + "&realId=" + realId,
            cancel: function () {

            }
        })
    }

    function psnCancel(data, flag) {
        if (data == null) {
            layer.close(index);
        } else {
            var obj = jQuery("#psnTable").jqGrid('getRowData');
            var ids = $("#psnTable").jqGrid('getDataIDs');//所有数据行id
            var number = 0;
            for (var i = 0; i < obj.length; i++) {
                if (flag == "addFlag") {
                    if (obj[i].relatedPsnName == data.relatedPsnName) {
                        number = number + 1;
                    }
                } else {
                    if (ids[i] != data.id) {
                        if (obj[i].relatedPsnName == data.relatedPsnName) {
                            number = number + 1;
                        }
                    }
                }
            }
            if (flag == "addFlag") {
                if (number == 0) {
                    $("#psnTable").jqGrid('addRowData', psnTableData.length, data);
                    psnTableData.push(data);
                    layer.close(index);
                } else {
                    showError("联系人已存在！")
                }

            } else {
                if (number == 0) {
                    $("#psnTable").jqGrid('setRowData', data.id, data);
                    layer.close(index);
                } else {
                    showError("联系人已存在！")
                }

            }
        }
    }
    function doCancel(data, flag) {
        if (data == null) {
            layer.close(index);
        } else {
            var obj = jQuery("#bankTable").jqGrid('getRowData');
            var ids = $("#bankTable").jqGrid('getDataIDs');//所有数据行id
            var number = 0;
            if (flag == "addFlag") {
                for (var i = 0; i < obj.length; i++) {
                    if (obj[i].relatedAccountNo == data.relatedAccountNo) {
                        number = number + 1;
                    }
                }
                if (number == 0) {
                    $("#bankTable").jqGrid('addRowData', bankTableData.length, data);
                    bankTableData.push(data);
                    layer.close(index);
                } else {
                    showError("银行账号已存在！");
                }
            } else {
                for (var i = 0; i < obj.length; i++) {
                    if (ids[i] != data.id) {
                        if (obj[i].relatedAccountNo == data.relatedAccountNo) {
                            number = number + 1;
                        }
                    }
                }
                if (number == 0) {
                    $("#bankTable").jqGrid('setRowData', data.id, data);
                    layer.close(index);
                } else {
                    showError("银行账号已存在！");
                }
            }
        }
    }

    //js自动设置英文简码
    function changEnglishScode() {
        $("#compySname").val(trims($("#compySname").val()));
        repeatJudgeSname();
        if ("${flag}" == "add") {
            var compySname = $("#compySname").val();
            if ($("#compySname").val().length > 20) {
                compySname = $("#compySname").val().substring(0, 20);
            }
            if ($("#relatedCompyType").val() == "ST") {
                $("#sysLoginAccount").val(compySname.toPinYin());
                $("#sysLoginAccount").trigger("change");
            }
            if ($("#relatedCompyType").val() == "DR" || $("#relatedCompyType").val() == "ADR") {
                $("#helperCode").val(compySname.toPinYin());
                $("#helperCode").trigger("change");
            }
        }
        fromUpdate();
    }

    //判断简称是否重复
    function repeatJudgeSname() {
        $.ajax({
            url: "${ctxZG}/relateCompany/repeatJudgeSname",
            type: "post",
            data: {
                "compySname": $("#compySname").val(),
                "relatedCompyCode": $("#relatedCompyCode").val()
            },
            success: function (result) {
                var obj = JSON.parse(result);
                if (obj.resultType == BizConstant.SUCCESS) {
                    SnameFlag = 0;
                } else {
                    SnameFlag = 1;
                    showError(obj.resultMsg);
                }
            },
            error: function (xhr, status, error) {
                showError("系统错误");
            }
        })
    }

    function submit() {
        var data = {}
        data.bankObj = JSON.stringify(jQuery("#bankTable").jqGrid('getRowData'));
        data.psnObj = JSON.stringify(jQuery("#psnTable").jqGrid('getRowData'));

        $.ajax({
            url: "${ctxZG}/relateCompany/save?" + $("#addMassage").serialize(),
            type: "post",
            data: data,
            success: function (result) {
                var obj = JSON.parse(result);
                if (obj.resultType == BizConstant.SUCCESS) {
                    showTip(obj.resultMsg);
                    setTimeout(function () {
                        parent.doCancel();
                    }, 1000)
                } else {
                    showError(obj.resultMsg);
                }

                if (typeof parent.doLoadWindow == 'function') {
                    parent.doLoadWindow(obj.dataModel, "${flag}");
                    //parent.doSearch();
                }
            },
            error: function (xhr, status, error) {
                showError("系统错误");
            }
        })
    }

    function deletePsn(data, ids) {
        $.ajax({
            url: "${ctxZG}/relateCompany/deletePsn",
            type: "post",
            data: {
                objs: JSON.stringify(data)
            },
            success: function (result) {
                var obj = JSON.parse(result);
                if (obj.resultType == BizConstant.SUCCESS) {
                    var len = ids.length;
                    for (var i = 0; i < len; i++) {
                        $("#psnTable").jqGrid("delRowData", ids[0]);
                    }
                    showTip(obj.resultMsg);
                } else {
                    showError(obj.resultMsg);
                }
            },
            error: function (xhr, status, error) {
                showError("系统错误");
            }
        })
    }
    function deleteBank(data, ids) {
        $.ajax({
            url: "${ctxZG}/relateCompany/deleteBank",
            type: "post",
            data: {
                ids: JSON.stringify(data)
            },
            success: function (result) {
                var obj = JSON.parse(result);
                if (obj.resultType == BizConstant.SUCCESS) {
                    var len = ids.length;
                    for (var i = 0; i < len; i++) {
                        $("#bankTable").jqGrid("delRowData", ids[0]);
                    }
                    showTip(obj.resultMsg);
                } else {
                    showError(obj.resultMsg);
                }
            },
            error: function (xhr, status, error) {
                showError("系统错误");
            }
        })
    }

    function fromUpdate() {
        updateFlag = 1;
    }

    function listenInput() {

        var div = $("form");
        var result = false;
        //初始化返回值
        var colInput = div.find("input"); //获取输入框控件
        for (var i = 0; i < colInput.length; i++) { //逐个判断页面中的input控件
            var THIS = colInput[i];

            if (THIS.value != THIS.defaultValue) { //判断输入的值是否等于初始值
                updateFlag = 1; //如果不相等，返回true，表示已经修改
            }
        }
    }

    function onlyNumber(main) {
        $(main).keyup(function () {
            clearNoNumber(this);
        })

        $(main).blur(function () {
            var distanceKmQty = $("#distanceKmQty").val();
            if (!isBlank(distanceKmQty))
                $("#distanceKmQty").val(formatCurrencys(distanceKmQty));
        })
    }
    function clearNoNumber(obj) {
        obj.value = obj.value.replace(/[^\d]/g, "");  //清除“数字”以外的字符
    }
    function formatCurrencys(num) {
        num = num.toString().replace(/\$|\,/g, '');
        if (isNaN(num))
            num = "0";
        sign = (num == (num = Math.abs(num)));
        num = Math.floor(num * 100 + 0.50000000001);
        num = Math.floor(num / 100).toString();

        for (var i = 0; i < Math.floor((num.length - (1 + i)) / 3); i++)
            num = num.substring(0, num.length - (4 * i + 3)) + ',' +
                num.substring(num.length - (4 * i + 3));
        return (((sign) ? '' : '-') + num);
    }

    function clearNoEnglish(obj) {
        obj.value = obj.value.replace(/[^a-zA-Z]/g, "");  //清除英文以外的字符
    }

    function defultCheckEdit() {
        listenInput();
        if ( $("#activeFlag").val() != "${relateCompanyModel.activeFlag}") {
            updateFlag = 1;
            return;
        }
    }
    function defultCheck() {

        listenInput();
        if ($("#activeFlag").val() != "Y") {
            updateFlag = 1;
            return;
        }

        var obj = jQuery("#bankTable").jqGrid('getGridParam');
        if (obj.data.length != 0) {
            updateFlag = 1;
            return;
        }
    }
    function checkSave() {
        if (isBlank($("#relatedCompyType").val())) {
            showError("往来单位类型不能为空！");
            return false;
        }
        if (isBlank($("#compySname").val())) {
            showError("简称不能为空！");
            return false;
        } else {
            if (SnameFlag == 1) {
                showError("简称不能重复！");
                return false;
            }
        }

        if (isBlank($("#activeFlag").val())) {
            showError("有效标志不能为空！");
            return false;
        }

        if ($("#relatedCompyType").val() == 'DR' || $("#relatedCompyType").val() == "ADR") {
            if ("${flag}" == "add") {
                if ($("#helperCode").val() == "") {
                    /*showError("司机助手账号不能为空！");
                    return false;*/
                } else {
                    if (!isBlank($("#helperCodeFlag").text())) {
                        showError("司机助手账号重复，请重新输入！");
                        return false;
                    }
                }
            }
            if ($("#sfzNo").val() == "") {
                /*showError("身份证号不能为空！");
                return false;*/
            } else {
                if (!isBlank($("#sfzNoFlag").text())) {
                    showError("证件号码格式非法!");
                    return false;
                }
            }
            if ($("#drvLicenceNo").val() == "") {
                /*showError("驾驶证号不能为空！");
                return false;*/
            }
            if ($("#phone1").val() == "") {
                /*showError("司机手机号码1不能为空！");
                return false;*/
            }
            if($("#quitFlag").val() == "Y"){
                if(isBlank($("#quitTime").val())){
                    showError("请输入离职日期！")
                    return false;
                }
            }
        }

        return true;
    }
    function trims(str) {
        return str.replace(/(^\s*)|(\s*$)/g, "");
    }

    //判断司机助手账号是否重复
    function repeatJudgeHelperCode() {
        $("#helperCode").val(trims($("#helperCode").val()))
        $.ajax({
            url: "${ctxZG}/relateCompany/repeatJudgeHelperCode",
            type: "post",
            data: {
                "helperCode": $("#helperCode").val(),
            },
            success: function (result) {
                var obj = JSON.parse(result);
                if (obj.resultType == BizConstant.SUCCESS) {
                    if ("${flag}" == "add") {
                        if ($("#relatedCompyType").val() == "DR" || $("#relatedCompyType").val() == "ADR") {
                            $("#helperCodeFlag").text("");
                        }
                    }
                } else {
                    if ("${flag}" == "add") {
                        if ($("#relatedCompyType").val() == "DR" || $("#relatedCompyType").val() == "ADR") {
                            $("#helperCodeFlag").text("账号已存在！");
                        }
                    }
                }
            },
            error: function (xhr, status, error) {
                showError("系统错误");
            }
        })
    }

    //身份证号码验证
    function provingSfzNo() {
        fromUpdate();

        if ($("#sfzNo").val() != "") {
            //身份证的地区代码对照
            var aCity = {
                11: "北京",
                12: "天津",
                13: "河北",
                14: "山西",
                15: "内蒙古",
                21: "辽宁",
                22: "吉林",
                23: "黑龙江",
                31: "上海",
                32: "江苏",
                33: "浙江",
                34: "安徽",
                35: "福建",
                36: "江西",
                37: "山东",
                41: "河南",
                42: "湖北",
                43: "湖南",
                44: "广东",
                45: "广西",
                46: "海南",
                50: "重庆",
                51: "四川",
                52: "贵州",
                53: "云南",
                54: "西藏",
                61: "陕西",
                62: "甘肃",
                63: "青海",
                64: "宁夏",
                65: "新疆",
                71: "台湾",
                81: "香港",
                82: "澳门",
                91: "国外"
            };
            //获取证件号码
            var person_id = $("#sfzNo").val();
            //合法性验证
            var sum = 0;
            //出生日期
            var birthday;
            //验证长度与格式规范性的正则
            var pattern = new RegExp(/(^\d{15}$)|(^\d{17}(\d|x|X)$)/i);
            if (pattern.exec(person_id)) {
                //验证身份证的合法性的正则
                pattern = new RegExp(/^[1-9]\d{7}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}$/);
                if (pattern.exec(person_id)) {
                    //获取15位证件号中的出生日期并转位正常日期
                    birthday = "19" + person_id.substring(6, 8) + "-" + person_id.substring(8, 10) + "-" + person_id.substring(10, 12);
                }
                else {
                    person_id = person_id.replace(/x|X$/i, "a");
                    //获取18位证件号中的出生日期
                    birthday = person_id.substring(6, 10) + "-" + person_id.substring(10, 12) + "-" + person_id.substring(12, 14);

                    //校验18位身份证号码的合法性
                    for (var i = 17; i >= 0; i--) {
                        sum += (Math.pow(2, i) % 11) * parseInt(person_id.charAt(17 - i), 11);
                    }
                    if (sum % 11 != 1) {
                        $(this).addClass("txtRequired");
                        $("#sfzNoFlag").text("证件号码格式非法！");
                        //showError("身份证号码不符合国定标准，请核对！");
                        return;
                    } else {
                        $("#sfzNoFlag").text("");
                    }
                }
                //检测证件地区的合法性
                if (aCity[parseInt(person_id.substring(0, 2))] == null) {
                    $(this).addClass("txtRequired");
                    $("#sfzNoFlag").text("证件号码格式非法！");
                    //showError("证件地区未知，请核对！");
                    return;
                } else {
                    $("#sfzNoFlag").text("");
                }
                var dateStr = new Date(birthday.replace(/-/g, "/"));

                if (birthday != (dateStr.getFullYear() + "-" + Append_zore(dateStr.getMonth() + 1) + "-" + Append_zore(dateStr.getDate()))) {
                    $(this).addClass("txtRequired");
                    $("#sfzNoFlag").text("证件号码格式非法！");
                    //showError("证件出生日期非法！");
                    return;
                } else {
                    $("#sfzNoFlag").text("");
                }
                $(this).removeClass("txtRequired");
            }
            else {
                $(this).addClass("txtRequired");
                // alert("证件号码格式非法！");
                $("#sfzNoFlag").text("证件号码格式非法！");
                // showError("证件号码格式非法！");
                return;
            }
        } else {
            $("#sfzNoFlag").text("");
        }
    }
</script>