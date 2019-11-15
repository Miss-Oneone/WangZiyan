<%@ tag language="java" pageEncoding="UTF-8" %>
<%@ tag trimDirectiveWhitespaces="true" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<%@ attribute name="id" type="java.lang.String" required="true" description="ID" %>
<%@ attribute name="name" type="java.lang.String" required="false" description="名称" %>
<%@ attribute name="width" type="java.lang.String" required="false" description="宽度" %>
<%@ attribute name="localData" type="java.lang.String" required="false" description="下拉选项数据(JSON格式)" %>
<%@ attribute name="getInfo" type="java.lang.String" required="false" description="获取数据接口名称和参数" %>
<%@ attribute name="initNames" type="java.lang.String" required="false" description="form提交的话对应字段名" %>
<%@ attribute name="required" type="java.lang.String" required="false" description="是否必输" %>
<%@ attribute name="onchange" type="java.lang.String" required="false" description="选到最后一级值变更事件" %>
<%@ attribute name="changeNoEnd" type="java.lang.String" required="false" description="没选到最后一级值变更事件" %>
<%@ attribute name="defaultCheck" type="java.lang.String" required="false" description="默认选中的省市区县，长度小于五的数组" %>
<%@ attribute name="readonly" type="java.lang.String" required="false" description="只读" %>
<%@ attribute name="isShowZxdAddress" type="java.lang.String" required="false" description="是否显示五级地址" %>
<%@ attribute name="onchangeFour" type="java.lang.String" required="false" description="选中四级最后一级变更事件" %>
<%@ attribute name="changeNoEndFour" type="java.lang.String" required="false" description="四级没选到最后一级变更事件" %>
<%@ attribute name="cssClass" type="java.lang.String" required="false" description="样式" %>
<%@ attribute name="isShowRefresh" type="java.lang.String" required="false" description="是否显示刷新标志" %>

<style>
	.regional-linkage-select{
		display: inline-block;
		white-space: nowrap;
	}
	.regional-linkage-sel{
		margin-left:20px;
	}
</style>
<div id="${id}ProvinceMain" class="regional-linkage-select ${cssClass}">
	<select id="${id}Province" title="省" name="${id}Province" onchange="${id}getCityName(0)" placeholder="省">
		${empty required or required eq 'false' ? '<option value=""></option>' : ''}
	</select>
</div>
<div class="regional-linkage-select ${cssClass}" id="${id}CityMain">
	<select id="${id}City" name="${id}City" title="市" onchange="${id}getCityName(1)" placeholder="市">
		${empty required or required eq 'false' ? '<option value=""></option>' : ''}
	</select>
</div>
<div class="regional-linkage-select ${cssClass}" id="${id}DistrictMain">
	<select id="${id}District" name="${id}District" title="区/县" onchange="${id}getCityName(2)" placeholder="区/县">
		${empty required or required eq 'false' ? '<option value=""></option>' : ''}
	</select>
</div>
<div class="regional-linkage-select ${cssClass}" id="${id}CountyMain">
	<select id="${id}County" title="乡/镇" name="${id}County" onchange="${id}getCityName(3)" placeholder="乡/镇">
		${empty required or required eq 'false' ? '<option value=""></option>' : ''}
	</select>
</div>
<c:if test="${isShowZxdAddress eq 'true'}">
	<div class="regional-linkage-select ${cssClass}" id="${id}ZxdAddrsMain">
		<select id="${id}ZxdAddrs" title="地点" name="${id}ZxdAddrs" onchange="${id}getCityName(4)" placeholder="地点">
				${empty required or required eq 'false' ? '<option value=""></option>' : ''}
		</select>
	</div>
</c:if>
<c:if test="${(empty readonly or readonly eq 'false') and (empty disabled or disabled eq 'false')} and (empty isShowRefresh or isShowRefresh eq 'true')}">
	<img id="${id}Img" class="${cssClass}" src="${ctxStatic}/sunsail/images/refresh.png" width="24" height="24" onclick="${id}Refresh()"
		 style="cursor:pointer;"/>
</c:if>

<div id="${id}AddressMain" style="display: none">
	<input id="${id}Address" name="${id}Address">
	<input id="${id}TelList" name="${id}TelList">
	<input id="${id}Persons" name="${id}Persons">
</div>

<script>
    var ${id}getInfo = JSON.parse(<%=getInfo%>);
    var ${id}initNames = JSON.parse(<%=initNames%>);
    var ${id}defaultCheck = [];
    if(<%=defaultCheck%>&&<%=defaultCheck%>.length>0){
        ${id}defaultCheck = JSON.parse(<%=defaultCheck%>);
    }


    var localData = '${fns:replaceQuote(localData, "\\'")}';
    var localDataObj = eval('(' + localData + ')');


    <%--设置数据的isCheck递归--%>
    function ${id}setDefaultChecked(data,n){
        for(var i=0;i<data.length;i++){
            if(data[i].value==${id}defaultCheck[n]){
                data[i].isCheck = true;
                n++;
                if(data[i].children){
                    ${id}setDefaultChecked(data[i].children,n)
                }else{
                    if(${isShowZxdAddress eq 'true'}) {
                        if(n>4){
                            setTimeout(function(){
                                <%=onchange%>
                            },20)
                            return false;
                        }
                    } else {
                        if(n>3){
                            setTimeout(function(){
                                <%=onchange%>
                            },20)
                            return false;
                        }
                    }
                    var getKey = {};
                    if(n <= 3){
                        getKey[${id}getInfo[n-1].key] =${id}defaultCheck[n-1];
                    } else {
                        getKey[${id}getInfo[n-4].key] =${id}defaultCheck[n-4];
                        getKey[${id}getInfo[n-3].key] =${id}defaultCheck[n-3];
                        getKey[${id}getInfo[n-2].key] =${id}defaultCheck[n-2];
                        getKey[${id}getInfo[n-1].key] =${id}defaultCheck[n-1];
                    }
                    var index = i;
                    var url = ${id}getInfo[n-1].url;
                    <%--if(!isBlank(${id}defaultCheck[n-1])){--%>
                        <%--if (n == 2 && isBlank(${id}defaultCheck[n])) {--%>
                            <%--url = ${id}getInfo[3].url;--%>
                            <%--n = 4;--%>
                        <%--}--%>
                        <%--if(n == 3 && isBlank(${id}defaultCheck[n])) {--%>
                            <%--url = ${id}getInfo[3].url;--%>
                            <%--n = 4;--%>
                        <%--}--%>
                    <%--}--%>
                    $.ajax({
                        url: url,
                        type: "post",
                        data: getKey,
                        success: function (d) {

                            if (!isBlank(d)) {
                                var obj = JSON.parse(d);
                                if(!obj.dataList||obj.dataList.length==0){
                                    setTimeout(function(){
                                        <%=onchange%>
                                    },20)
                                }else {
                                    var arr;
                                    if(${isShowZxdAddress eq 'true'}) {
                                        arr = ['Province', 'City', 'District', 'County', 'ZxdAddrs'];
                                    } else {
                                        arr = ['Province', 'City', 'District', 'County'];
                                    }
                                    data[index].children = obj.dataList;

                                    ${id}setDefaultChecked(data[index].children,n);
//                                    data[index].children = obj.dataList;
									if(arr[n] != 'ZxdAddrs') {
                                        ${id}initMineSelect("${id}"+ arr[n], data[index].children, false, ${empty required or required eq 'false' ? 'false' : 'true'}, ${(empty readonly or readonly eq 'false' ? 'false' : 'true')}, true, ${empty width ? 200 : width}, "${value}");
                                    } else {
                                        ${id}initMineSelect("${id}"+ arr[n], data[index].children, false, ${empty required or required eq 'false' ? 'false' : 'true'}, ${(empty readonly or readonly eq 'false' ? 'false' : 'true')}, true, 200, "${value}");
                                    }
                                    $("#" + "${id}" + arr[n]+"Main").show();
                                    $("#" + "${id}" + arr[n]).attr('selectData', JSON.stringify(data[index].children));
                                    if (n == 4) {
                                        if (${id}defaultCheck[4]) {
                                            for (var k=0; k<obj.dataList.length; k++) {
												if(obj.dataList[k].value == ${id}defaultCheck[4]) {
                                                    //多个联系人和电话，拼接成一个
                                                    var contactor = "";
                                                    var phone = "";
                                                    var address = "";
                                                    $("#${id}Address").val('');
                                                    if(obj.dataList[k].contactPerson) {
                                                        contactor = contactor + obj.dataList[k].contactPerson;
                                                    }
                                                    if(obj.dataList[k].contactPerson2) {
                                                        contactor = contactor + "," + obj.dataList[k].contactPerson2;
                                                    }
                                                    if(obj.dataList[k].contactPerson3) {
                                                        contactor = contactor + "," + obj.dataList[k].contactPerson3;
                                                    }
                                                    if(obj.dataList[k].contactPhone) {
                                                        phone = phone +obj.dataList[k].contactPhone;
                                                    }
                                                    if(obj.dataList[k].contactPhone2) {
                                                        phone = phone + "," + obj.dataList[k].contactPhone2;
                                                    }
                                                    if(obj.dataList[k].contactPhone3) {
                                                        phone = phone + "," + obj.dataList[k].contactPhone3;
                                                    }
                                                    if ($("#" + "${id}" + arr[arr.length - 5]).val()) {
                                                        address = address + $("#" + "${id}" + arr[arr.length - 5] + "Main" + " "+".select2-chosen").text();
                                                    }
                                                    if ($("#" + "${id}" + arr[arr.length - 4]).val()) {
                                                        address = address + $("#" + "${id}" + arr[arr.length - 4] + "Main" + " "+".select2-chosen").text();
                                                    }
                                                    if ($("#" + "${id}" + arr[arr.length - 3]).val()) {
                                                        address = address + $("#" + "${id}" + arr[arr.length - 3] + "Main" + " "+".select2-chosen").text();
                                                    }
                                                    if ($("#" + "${id}" + arr[arr.length - 2]).val()) {
                                                        address = address + $("#" + "${id}" + arr[arr.length - 2] + "Main" + " "+".select2-chosen").text();
                                                    }
                                                    address = address + obj.dataList[k].address + obj.dataList[k].text;
                                                    $("#${id}Persons").val(contactor);
                                                    $("#${id}TelList").val(phone);
                                                    $("#${id}Address").val(address);
												}
                                            }
                                        }
									}
                                }
                            }
                        },
                        error: function (xhr, status, error) {
                            showError("系统错误");
                        }
                    });
                }

            }
        }
    }

    $("#" + "${id}Img").parent().css({position: "relative"});
    $("#" + "${id}Img").css({position: "relative", top: "2px"});

    $(document).ready(function () {
        ${id}LoadData();
        //设置
        if(${id}defaultCheck){
            ${id}setDefaultChecked(localDataObj,0);
        }
    });
    <%--初始化selectNmae--%>
    function ${id}initMineSelectName(){
        var select = $('.regional-linkage-select select');
        var nameIdx = 0;
        for(var i=0;i<select.length;i++){
            if(select[i].name.indexOf('${id}') != -1) {
                <%--多个4级地址--%>
                if (${id}initNames[nameIdx]) {
                    select[i].name = ${id}initNames[nameIdx];
                }
                nameIdx++;
            }
        }
    }
    ${id}initMineSelectName();

    function ${id}LoadData() {
        $("#" + "${id}CityMain select").val('');
        $("#" + "${id}DistrictMain select").val('');
        $("#" + "${id}CountyMain select").val('');
        if(${isShowZxdAddress eq 'true'}) {
            $("#" + "${id}ZxdAddrsMain select").val('');
        }
        var initFlag = false;
        var defaultValue = "${value}" || (${id}defaultCheck.length>0&&${id}defaultCheck[0]);
        if (defaultValue) {
            initFlag = true;
        }
        $.ajaxSetup({async: false});  //设置成同步
        try {
            if (localData != '') {//使用单引号
                for(var i=0;i<localDataObj.length;i++){
                    if(defaultValue == localDataObj[i].value){
                        localDataObj[i].isCheck = true;
                    } else {
                        delete localDataObj[i].isCheck;
                    }
                }
                ${id}initMineSelect("${id}" + 'Province', localDataObj, initFlag, ${empty required or required eq 'false' ? 'false' : 'true'}, ${(empty readonly or readonly eq 'false' ? 'false' : 'true')}, true, ${empty width ? 200 : width}, defaultValue);
                $("#" + "${id}" + 'Province').attr('selectData', JSON.stringify(localDataObj));
            }
            var arr;
            if(${isShowZxdAddress eq 'true'}) {
                arr = ['City', 'District', 'County', 'ZxdAddrs'];
            } else {
                arr = ['City', 'District', 'County'];
            }
            for (var i = 0; i < arr.length; i++) {
                if(arr[i] != 'ZxdAddrs') {
                    ${id}initMineSelect("${id}"+ arr[i], '', false, ${empty required or required eq 'false' ? 'false' : 'true'}, false, true, ${empty width ? 200 : width}, '');
                } else {
                    ${id}initMineSelect("${id}"+ arr[i], '', false, ${empty required or required eq 'false' ? 'false' : 'true'}, false, true, 200, '');
                }
            }
        } catch (e) {
            $.ajaxSetup({async: true});  //设置成异步
        }
        $.ajaxSetup({async: true});  //设置成异步
    }
    ;

    //    获取下一级数据
    function ${id}getCityName(indexNum) {
        var arr, pStr, str, selectNum = 999, selectCode, selectData;
        if(${isShowZxdAddress eq 'true'}) {
            arr = ['Province', 'City', 'District', 'County', 'ZxdAddrs'];
        } else {
            arr = ['Province', 'City', 'District', 'County'];
        }
        for (var i = 0; i < arr.length; i++) {
            if ((indexNum+1) == i) {
                selectNum = i;
                pStr = arr[i - 1];
                str = arr[i];
                selectCode = $("#" + "${id}" + pStr).val();
            }

            if (i >= selectNum) {
                $("#" + "${id}" + arr[i]+"Main select").val('');
                $("#" + "${id}" + arr[i]+"Main select").trigger("change");
                $("#" + "${id}"+ arr[i] + " > option[value!='']").remove();
            }
        }
        if(!selectCode){
            var flag = false;
            var index = 0;
            if (indexNum == 2 && isBlank($("#" + "${id}" + arr[4]).val()) && !isBlank($("#" + "${id}" + arr[1]).val()) && isBlank($("#" + "${id}" + arr[2]).val())) {
                flag = true;
                selectData = JSON.parse($("#" + "${id}" + arr[indexNum - 1]).attr('selectData'));
                for (var i = 0; i < selectData.length; i++) {
                    if (selectData[i].value == $("#" + "${id}" + arr[indexNum - 1]).val()) {
                        index = i;
                    }
                }

            }
            if (indexNum == 3 && isBlank($("#" + "${id}" + arr[4]).val()) && !isBlank($("#" + "${id}" + arr[2]).val()) && isBlank($("#" + "${id}" + arr[3]).val())) {
                flag = true;
                selectData = JSON.parse($("#" + "${id}" + arr[indexNum - 1]).attr('selectData'));
                for (var i = 0; i < selectData.length; i++) {
                    if (selectData[i].value == $("#" + "${id}" + arr[indexNum - 1]).val()) {
                        index = i;
                    }
                }
            }
            if (flag) {
                var address = "";
                if ($("#" + "${id}" + arr[arr.length - 5]).val()) {
					address = address + $("#" + "${id}" + arr[arr.length - 5] + "Main" + " "+".select2-chosen").text();
                }
                if ($("#" + "${id}" + arr[arr.length - 4]).val()) {
                    address = address + $("#" + "${id}" + arr[arr.length - 4] + "Main" + " "+".select2-chosen").text();
                }
                if ($("#" + "${id}" + arr[arr.length - 3]).val()) {
                    address = address + $("#" + "${id}" + arr[arr.length - 3] + "Main" + " "+".select2-chosen").text();
                }
                if ($("#" + "${id}" + arr[arr.length - 2]).val()) {
                    address = address + $("#" + "${id}" + arr[arr.length - 2] + "Main" + " "+".select2-chosen").text();
                }
                $("#${id}Address").val(address);
                getKey = {};
                getKey[${id}getInfo[0].key] = $("#" + "${id}" + arr[arr.length - 5]).val();
                getKey[${id}getInfo[1].key] = $("#" + "${id}" + arr[arr.length - 4]).val();
                getKey[${id}getInfo[2].key] = $("#" + "${id}" + arr[arr.length - 3]).val();
                getKey[${id}getInfo[3].key] = $("#" + "${id}" + arr[arr.length - 2]).val();

                $.ajax({
                    url: ${id}getInfo[3].url,
                    type: "post",
                    data: getKey,
                    success: function (data) {
                        if (!isBlank(data)) {
                            var obj = JSON.parse(data)
                        }
                        if (!obj.dataList || obj.dataList == 0) {
                            setTimeout(function () {
                                <%=onchange%>
                            }, 20)
                        } else {
                            $("#" + "${id}" + "ZxdAddrs" + "Main").show();
                            selectData[index].children = obj.dataList;
                            ${id}initMineSelect("${id}" + "ZxdAddrs", selectData[index].children, false, ${empty required or required eq 'false' ? 'false' : 'true'}, false, true, 200, "${value}");
                            $("#" + "${id}" + "ZxdAddrs").attr('selectData', JSON.stringify(selectData[index].children));
                        }

                    },
                    error: function (xhr, status, error) {
                        showError("系统错误");
                    }
                });
            }
            if (!isBlank($("#" + "${id}" + arr[4]).val()) && ${id}getInfo.length > 4) {
                getKey = {};
                getKey[${id}getInfo[4].key] = $("#" + "${id}" + arr[arr.length - 1]).val();
                var url = ${id}getInfo[4].url;
                $.ajax({
                    url: url,
                    type: "post",
                    data: getKey,
                    success: function (data) {
                        if (!isBlank(data)) {
                            var obj = JSON.parse(data);
                            ${id}defaultCheck = [obj.provinceCode, obj.cityCode, obj.districtCode, obj.countyCode, obj.id];
                            $("#" + "${id}DistrictMain select").val('');
                            $("#" + "${id}CountyMain select").val('');
                            if(${isShowZxdAddress eq 'true'}) {
                                $("#" + "${id}ZxdAddrsMain select").val('');
                            }
                            localData = '${fns:replaceQuote(localData, "\\'")}';
                            localDataObj = eval('(' + localData + ')');
                            ${id}setDefaultChecked(localDataObj, 0);
                        }
                    },
                    error: function (xhr, status, error) {
                        showError("系统错误");
                    }
                });
            }
            $("#${id}Persons").val('');
            $("#${id}TelList").val('');
            if ($("#" + "${id}" + arr[arr.length - 5]).val()) {
                var address = "";
                if ($("#" + "${id}" + arr[arr.length - 5]).val()) {
                    address = address + $("#" + "${id}" + arr[arr.length - 5] + "Main" + " "+".select2-chosen").text();
                }
                if ($("#" + "${id}" + arr[arr.length - 4]).val()) {
                    address = address + $("#" + "${id}" + arr[arr.length - 4] + "Main" + " "+".select2-chosen").text();
                }
                if ($("#" + "${id}" + arr[arr.length - 3]).val()) {
                    address = address + $("#" + "${id}" + arr[arr.length - 3] + "Main" + " "+".select2-chosen").text();
                }
                if ($("#" + "${id}" + arr[arr.length - 2]).val()) {
                    address = address + $("#" + "${id}" + arr[arr.length - 2] + "Main" + " "+".select2-chosen").text();
                }
                $("#${id}Address").val(address);
            } else {
                $("#${id}Address").val('');
            }
            <%=changeNoEnd%>
			if(indexNum != 4) {
                <%=changeNoEndFour%>
			}
			return false;
        }
        if(${isShowZxdAddress eq 'true'}) {
            if(indexNum==4){
                setTimeout(function(){
                    <%=onchange%>
                },20)
                return false;
            }
        } else {
            if(indexNum==3){
                setTimeout(function(){
                    <%=onchange%>
                },20)
                return false;
            }
        }
        selectData = JSON.parse($("#" + "${id}" + pStr).attr('selectData'));
        var index = 0;
        for (var i = 0; i < selectData.length; i++) {
            if (selectData[i].value == selectCode) {
                index = i;
            }
        }
        if (selectData[index].children && selectData[index].children.length > 0) {
            $("#" + "${id}"+str+"Main").show();
            if(str != 'ZxdAddrs') {
                ${id}initMineSelect("${id}"+str, selectData[index].children, false, ${empty required or required eq 'false' ? 'false' : 'true'}, false, true, ${empty width ? 200 : width}, "${value}");
            } else {
                ${id}initMineSelect("${id}"+str, selectData[index].children, false, ${empty required or required eq 'false' ? 'false' : 'true'}, false, true, 200, "${value}");
            }
            $("#" + "${id}" + str).attr('selectData', JSON.stringify(selectData[index].children));
            <%=changeNoEnd%>
        } else {
            var getKey={};
            if(${isShowZxdAddress eq 'true'}) {

            }
            if(indexNum < 3){
                getKey[${id}getInfo[indexNum].key] = selectCode;
            } else {
                getKey[${id}getInfo[0].key] = $("#" + "${id}" + arr[arr.length - 5]).val();
                getKey[${id}getInfo[1].key] = $("#" + "${id}" + arr[arr.length - 4]).val();
                getKey[${id}getInfo[2].key] = $("#" + "${id}" + arr[arr.length - 3]).val();
                getKey[${id}getInfo[3].key] = $("#" + "${id}" + arr[arr.length - 2]).val();
            }
            $.ajax({
                url: ${id}getInfo[indexNum].url,
                type: "post",
                data: getKey,
                success: function (data) {
                    if (!isBlank(data)) {
                        var obj = JSON.parse(data)
                    }
                    if(!obj.dataList||obj.dataList==0){
                        setTimeout(function(){
                            <%=onchangeFour%>
                        },20)
                    }else {
                        <%=changeNoEnd%>
                        if (indexNum == 3) {
                            setTimeout(function(){
                                <%=onchangeFour%>
                            },20)
                        }
						$("#" + "${id}"+str+"Main").show();
                        selectData[index].children = obj.dataList;
                        if(str != 'ZxdAddrs') {
                            ${id}initMineSelect("${id}"+ str, selectData[index].children, false, ${empty required or required eq 'false' ? 'false' : 'true'}, false, true, ${empty width ? 200 : width}, "${value}");
                        } else {
                            ${id}initMineSelect("${id}"+ str, selectData[index].children, false, ${empty required or required eq 'false' ? 'false' : 'true'}, false, true, 200, "${value}");
                        }
                        $("#" + "${id}" + str).attr('selectData', JSON.stringify(selectData[index].children));
                    }

                },
                error: function (xhr, status, error) {
                    showError("系统错误");
                }
            });
        }

        var address = "";
        if ($("#" + "${id}" + arr[arr.length - 5]).val()) {
            address = address +$("#" + "${id}" + arr[arr.length - 5] + "Main" + " "+".select2-chosen").text();
        }
        if ($("#" + "${id}" + arr[arr.length - 4]).val()) {
            address = address + $("#" + "${id}" + arr[arr.length - 4] + "Main" + " "+".select2-chosen").text();
        }
        if ($("#" + "${id}" + arr[arr.length - 3]).val()) {
            address = address + $("#" + "${id}" + arr[arr.length - 3] + "Main" + " "+".select2-chosen").text();
        }
        if ($("#" + "${id}" + arr[arr.length - 2]).val()) {
            address = address + $("#" + "${id}" + arr[arr.length - 2] + "Main" + " "+".select2-chosen").text();
        }
        $("#${id}Address").val(address);

    }

    //    刷新
    function ${id}Refresh() {
        ${id}defaultCheck = [];
        localData = '${fns:replaceQuote(localData, "\\'")}';
        localDataObj = eval('(' + localData + ')');
        ${id}LoadData();
        <%=changeNoEnd%>
        showTip("刷新完成！", 800);
    }

    //设置默认值返回地址
    function ${id}SetDefaultValue(obj) {
		${id}defaultCheck = [];
        if (obj != ''){
            ${id}defaultCheck = [obj.provinceCode, obj.cityCode, obj.districtCode, obj.countyCode, obj.id];
        }
        $("#" + "${id}DistrictMain select").val('');
        $("#" + "${id}CountyMain select").val('');
        if(${isShowZxdAddress eq 'true'}) {
            $("#" + "${id}ZxdAddrsMain select").val('');
        }
        localData = '${fns:replaceQuote(localData, "\\'")}';
        localDataObj = eval('(' + localData + ')');
       	${id}LoadData();
        ${id}setDefaultChecked(localDataObj, 0);
    }

	//返回地址
	function ${id}GetAddressValue() {
	    return  $("#${id}Address").val();
    }
    //返回联系人
    function ${id}GetPersonsValue() {
       return  $("#${id}Persons").val();
    }

    //返回联系电话
    function ${id}GetTelListValue() {
       return $("#${id}TelList").val();
    }

    //    初始化select
    function ${id}initMineSelect(id, data, initFlag, requiredFlag, readonlyFlag, enableFlag, width, defaultValue) {
        $("#" + id + " > option[value!='']").remove();
        for (var i = 0; i < data.length; i++) {
            if (data[i].isCheck) {
                $("#" + id).append('<option value="' + data[i].value + '" selected>' + data[i].text + '</option>');
            } else {
                $("#" + id).append('<option value="' + data[i].value + '">' + data[i].text + '</option>');
            }
        }

        $("#" + id).select2({
            width : width,
            allowClear : !requiredFlag,
            matcher : function(term, text) {
                return pinyinMatcher(term, text);
            }
        });
        $("#" + id).select2("readonly", readonlyFlag);
        $("#" + id).select2("enable", enableFlag);
        if (requiredFlag) {
            $("#" + id).trigger("change");
        }
    }
</script>
