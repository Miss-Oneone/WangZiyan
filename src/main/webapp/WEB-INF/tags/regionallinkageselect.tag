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
<%@ attribute name="defaultCheck" type="java.lang.String" required="false" description="默认选中的省市区县，长度小于四的数组" %>
<%@ attribute name="readonly" type="java.lang.String" required="false" description="只读" %>
<style>
    .regional-linkage-select{
        display: inline-block;
        white-space: nowrap;
    }
    .regional-linkage-sel{
        margin-left:20px;
    }
</style>
<div id="${id}Main" class="regional-linkage-select">
    <select id="${id}" title="${id}" name="${id}" onchange="${id}getCityName(0)">
        ${empty required or required eq 'false' ? '<option value=""></option>' : ''}
    </select>
</div>
<div class="regional-linkage-select" id="${id}CityMain">
    <select id="${id}City" name="${id}City" title="${id}City" onchange="${id}getCityName(1)">
        ${empty required or required eq 'false' ? '<option value=""></option>' : ''}
    </select>
</div>
<div class="regional-linkage-select" id="${id}DistrictMain">
    <select id="${id}District" name="${id}District" title="${id}District" onchange="${id}getCityName(2)">
        ${empty required or required eq 'false' ? '<option value=""></option>' : ''}
    </select>
</div>
<div class="regional-linkage-select" id="${id}CountyMain">
    <select id="${id}County" title="${id}County" name="${id}County" onchange="${id}getCityName(3)">
        ${empty required or required eq 'false' ? '<option value=""></option>' : ''}
    </select>
</div>

<c:if test="${(empty readonly or readonly eq 'false') and (empty disabled or disabled eq 'false')}">
    <%--<img id="${id}Img" src="${ctxStatic}/sunsail/images/refresh.png" width="24" height="24" onclick="${id}Refresh()"--%>
         <%--style="cursor:pointer;"/>--%>
</c:if>
<br/>
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
                    if(n>3){
                        setTimeout(function(){
                            <%=onchange%>
                        },20)
                        return false;
                    }
                    var getKey = {};
                    getKey[${id}getInfo[n-1].key] =${id}defaultCheck[n-1];
                    var index = i;
                    $.ajax({
                        url: ${id}getInfo[n-1].url,
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
                                    var arr = ['', 'City', 'District', 'County'];
                                    data[index].children = obj.dataList;

                                    ${id}setDefaultChecked(data[index].children,n);
//                                    data[index].children = obj.dataList;
                                    ${id}initMineSelect("${id}"+ arr[n], data[index].children, false, ${empty required or required eq 'false' ? 'false' : 'true'}, ${(empty readonly or readonly eq 'false' ? 'false' : 'true')}, true, ${empty width ? 200 : width}, "${value}");
                                    $("#" + "${id}" + arr[n]+"Main").show();
                                    $("#" + "${id}" + arr[n]).attr('selectData', JSON.stringify(data[index].children));
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
        for(var i=0;i<select.length;i++){
            if(select[i].name.indexOf('${id}') != -1) {
                <%--多个4级地址--%>
                select[i].name = ${id}initNames[i%4];
            }
        }
    }
    ${id}initMineSelectName();

    function ${id}LoadData() {
        $("#" + "${id}CityMain").hide();
        $("#" + "${id}CityMain select").val('');
         $("#" + "${id}DistrictMain").hide();
        $("#" + "${id}DistrictMain select").val('');
         $("#" + "${id}CountyMain").hide();
        $("#" + "${id}CountyMain select").val('');
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
                ${id}initMineSelect("${id}", localDataObj, initFlag, ${empty required or required eq 'false' ? 'false' : 'true'}, ${(empty readonly or readonly eq 'false' ? 'false' : 'true')}, true, ${empty width ? 200 : width}, defaultValue);
                $("#" + "${id}").attr('selectData', JSON.stringify(localDataObj));
            }
        } catch (e) {
            $.ajaxSetup({async: true});  //设置成异步
        }
        $.ajaxSetup({async: true});  //设置成异步
        <%--${id}GetCountyName();--%>
    }
    ;

//    获取下一级数据
    function ${id}getCityName(indexNum) {
        var arr = ['', 'City', 'District', 'County','aaaa'], pStr, str, selectNum = 999, selectCode, selectData;
        for (var i = 0; i < arr.length; i++) {
            if ((indexNum+1) == i) {
                selectNum = i;
                pStr = arr[i - 1];
                str = arr[i];
                selectCode = $("#" + "${id}" + pStr).val();
            }

            if (i >= selectNum) {
                $("#" + "${id}" + arr[i]+"Main").hide();
                $("#" + "${id}" + arr[i]+"Main select").val('');
            }
        }
        if(!selectCode){
            <%=changeNoEnd%>
            return false;
        }
        if(indexNum==3){
            setTimeout(function(){
                <%=onchange%>
            },20)
            return false;
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
            ${id}initMineSelect("${id}"+str, selectData[index].children, false, ${empty required or required eq 'false' ? 'false' : 'true'}, false, true, ${empty width ? 200 : width}, "${value}");
            $("#" + "${id}" + str).attr('selectData', JSON.stringify(selectData[index].children));
            <%=changeNoEnd%>
        } else {
            var getKey={};
            getKey[${id}getInfo[indexNum].key] = selectCode
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
                            <%=onchange%>
                        },20)
                    }else {
                        <%=changeNoEnd%>
                        $("#" + "${id}"+str+"Main").show();
                        selectData[index].children = obj.dataList;
                        ${id}initMineSelect("${id}"+ str, selectData[index].children, false, ${empty required or required eq 'false' ? 'false' : 'true'}, false, true, ${empty width ? 200 : width}, "${value}");
                        $("#" + "${id}" + str).attr('selectData', JSON.stringify(selectData[index].children));
                    }

                },
                error: function (xhr, status, error) {
                    showError("系统错误");
                }
            });
        }

    }

//    刷新
    function ${id}Refresh() {
        ${id}defaultCheck = [];
        localData = '${fns:replaceQuote(localData, "\\'")}';
        localDataObj = eval('(' + localData + ')');
        ${id}LoadData();
        <%=changeNoEnd%>
        <%--$("#${id}").trigger("change");--%>
        showTip("刷新完成！", 800);
    }

//    初始化select
    function ${id}initMineSelect(id, data, initFlag, requiredFlag, readonlyFlag, enableFlag, width, defaultValue) {
        $("#" + id + " > option[value!='']").remove();
        for (var i = 0; i < data.length; i++) {
            if (data[i].isCheck) {
                $("#" + id).append('<option value="' + data[i].value + '" selected>' + data[i].text + '</option>');
                $("#" + id).attr('title', data[i].text);
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
