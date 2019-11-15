<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<script type="text/javascript">
	$(document).ready(function(){
        $("#cusCode").val('${cusCode}');
        var type = '${type}';
	    if(type) {
            $("#save").show();
        }else {
	        $("#save").hide();
        }

		createGridList("#mainTable", "#mainPagersssss", {
	        tblKey:"main"
	       ,colNames:eval("${gridModel.colNames}")
	       ,colModel:eval("${gridModel.colModel}")
           ,sortable:true
           ,sortname:"R.id"
           ,sortorder:"desc"
	       ,rowNum  : 100
	       ,rowList : [ 100, 500, 1000 ]
	       ,multiselect : true
           ,shrinkToFit:true
	   	});

        $("#search").click(function(){
			doSearch();
		})
        if('${phone}') {
            $('#phone').val('${phone}')
        }
        doSearch();

		$("#addressAdd").click(function () {
            addView();
        })

        $("#addressDelete").click(function() {
            deleteAddress();
        })
        //页面init
		createSelectCondition();//加减图标-查询栏层的显示和隐藏
		$(window).resize();//显示表格的大小
        var a = [];
        JSON.stringify(a)
        
        $("#save").click(function () {
            doSave();
        })
	});
    //列表窗口
	$(window).resize(function(){
		screenResize();
	});
    //列表查询
	function doSearch(){
		$("#mainTable").jqGrid('setGridParam',{datatype:"json",url:getPostURL("main"),page:1}).trigger("reloadGrid");
	}

	function getPostURL(tblKey) {
	    var url = "${ctxZG}/zxAddress/search";
	    return url+"?" + $("#searchForm").serialize();
	}
   //列表展示
	function screenResize() {
	    var windowHeight = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
	    if($(window).width() * 0.99<1182){
            $("#mainTable").setGridWidth(1182);
        }else{
            $("#mainTable").setGridWidth($(window).width() * 0.99);
        }

	    $("#mainTable").setGridHeight(windowHeight - $("#selectCondition").height()-$(".ui-jqgrid-labels").height()-$("#mainPagersssss").height()-$("#content-bottom").height()-80);
	    $("#footer").width($("#gbox_mainTable").width());
	}

    //非空判断
    function isBlank(obj){
        return(!obj || $.trim(obj) === "");
    }

    function getInfo() {
        var arrStr = JSON.stringify([{
            url:"${ctxZG}/helper/getCityList",
            key:"provinceCode"
        },{
            url:"${ctxZG}/helper/getDistrictList",
            key:"cityCode"
        },{
            url:"${ctxZG}/helper/getCountyList",
            key:"districtCode"
        }])
        return arrStr
    }

    function initSelectNames() {
        var arrStr = JSON.stringify(['provinceCode','cityCode','districtCode','countyCode'])
        return arrStr
    }
    var index;
    function addView() {
        var type = '${type}';
        var area = [ "1200px", "550px" ]
        if(type) {
            area = [ "900px", "450px" ]
        }
        index =  layer.open({
            type : 2,
            maxmin : true,
            area : area,
            title : '新增地址',
            content : "${ctxZG}/zxAddress/detail" +
                    "?provinceCode=" + '${provinceCode}' +
                    "&cityCode=" + '${cityCode}' +
                    "&districtCode=" + '${districtCode}' +
                    "&countyCode=" + '${countyCode}' +
                    "&addrsFull=" + '${addrsFull}' +
                    "&contactor=" + "${contactor}" +
                    "&phone=" + '${phone}' +
                    "&type=" + '${type}',
            cancel : function() {
                //do nothing
            }
        })
    }

    //地址详情
    function getAddressDetail(value,index, obj){
        var editDelStr = '';
            if(!isBlank(value) && isBlank(obj.relatedCompyCode)) {
                editDelStr='<a class="a-info" href="javascript:void(0);" onclick="toDetail(\''+ obj.id +'\')">'+value+'</a>';
            }else {
                editDelStr = value;
            }
        return editDelStr
    }

    //地址详情页面
    function toDetail(id) {
        var type = '${type}';
        var area = [ "1100px", "550px" ]
        if(type) {
            area = [ "900px", "450px" ]
        }
      index = layer.open({
            type : 2,
            maxmin : true,
            area : area,
            title : '地址详情',
            content : "${ctxZG}/zxAddress/detail?id=" + id,
            cancel : function() {
                //do nothing
            }
        })

    }

    function  doCancel() {
        layer.close(index);
    }

    function deleteAddress() {
        var ids = jQuery("#mainTable").jqGrid('getGridParam', 'selarrrow');
        if(ids.length > 0) {
            var data = new Array();
            var hasOther = false;
            for(var i=0; i<ids.length; i++) {
                var obj = jQuery("#mainTable").jqGrid('getRowData', ids[i]);
                if (ids.length == 1 && !isBlank(obj.relatedCompyCode)) {
                    showError("该装卸地不允许删除！");
                    return
                }
                if (ids.length > 1 && !isBlank(obj.relatedCompyCode)) {
                    showError("选中的装卸地中包含有不允许删除的装卸地！");
                    return
                }
                data.push( obj.id);
            }
            if(hasOther) {
                var index = layer.confirm(true, {
                    btn: ['仍然提交','取消'], //按钮
                    icon: 7
                }, function () {

                })
            }else {
                var index = layer.confirm(MsgConstants.getMsg("C00009", "删除"), function () {
                    del(data,index);
                })
            }


        }else {
            showError(MsgConstants.getMsg("M00001", "一条或多条数据"));
        }

    }
    
    function del(data) {
        $.ajax({
            url:"${ctxZG}/zxAddress/deleteAddressList",
            type:"post",
            data:{
                "idList": JSON.stringify(data)
            },
            success:function(result){
                var obj = JSON.parse(result);
                if(obj.resultType == BizConstant.SUCCESS){
                    showTip(obj.resultMsg);
                }else{
                    showError(obj.resultMsg);
                }
               doSearch();
            },
            error:function(xhr,status,error){
                showError("系统错误");
            }
        })
    }

    function doSave() {
        var ids = jQuery("#mainTable").jqGrid('getGridParam', 'selarrrow');
        if(ids.length == 0) {
            showError(MsgConstants.getMsg("M00001", "一条数据"));
            return;
        }
        if(ids.length > 1) {
            showError("只能选取一条数据");
            return;
        }
        var obj = jQuery("#mainTable").jqGrid('getRowData', ids[0]);
        var dataModel = {
            provinceCode: obj.provinceCode,
            cityCode: obj.cityCode,
            districtCode: obj.districtCode,
            countyCode: obj.countyCode,
            id: obj.id
        }

        if(typeof parent.setNewZxdAddrs == 'function') {
            parent.setNewZxdAddrs('${type}', dataModel);
            parent.doCancel();
        }
    }

    function gpsFlagView(value,index, obj) {
        var editDelStr = '';
        if(!isBlank(value)) {
            if(value == 'Y') {
                editDelStr='<a class="gps-ok" href="javascript:void(0);" onclick="toGpsReview(\''+ obj.id +'\')">OK</a>';
            }
            if(value == 'N') {
                editDelStr='<a class="gps-ng" href="javascript:void(0);" onclick="toGpsManage(\''+ obj.id +'\')">NG</a>';
            }
        }
        return editDelStr
    }

    function toGpsReview(id) {
        creatIframeFromSub('${ctxZG}/zxAddress/GpsReview?zxAddrsId=' + id, '导航数据已录入')
    }

    function toGpsManage(id) {
        creatIframeFromSub('${ctxZG}/zxAddress/zxGpsManage?zxAddrsId=' + id, '导航数据维护')
    }
</script>