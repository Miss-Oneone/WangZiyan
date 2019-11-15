$(document).ready(function(){
    $("#container4").jqGrid({
        //url:contextPath + "search.action",
        datatype:"json", //数据来源，本地数据
        mtype:"POST",//提交方式
        height:70,//高度，表格高度。可为数值、百分比或'auto'
        //width:1000,//这个宽度不能为百分比
        autowidth:true,//自动宽
        colNames:['司机姓名','电话号码1','电话号码2','常用车','常运路线','工作运输状态','驾驶证类型','驾龄','公司服务年限'],
        colModel:[
            //{name:'id',index:'id', width:'10%', align:'center' },
            {name:'dirverName',index:'dirverName', width:'15%',align:'center'},
            {name:'phoneNumF',index:'phoneNumF', width:'10%',align:'center'},	
            {name:'phoneNumS',index:'phoneNumS', width:'12%', align:"center"},
            {name:'usualCars',index:'usualCars', width:'12%', align:"center"},
            {name:'usualRoute',index:'usualRoute', width:'12%', align:"center"},
            {name:'tranState',index:'tranState', width:'12%', align:"center"},
            {name:'drivCardType',index:'drivCardType', width:'12%', align:"center"},
            {name:'driverAge',index:'driverAge', width:'12%', align:"center"},
            {name:'comSevYears',index:'comSevYears', width:'12%', align:"center"}
        ],
        rownumbers:true,//添加左侧行号
        //altRows:true,//设置为交替行表格,默认为false
        //sortname:'createDate',
        //sortorder:'asc',
        viewrecords: true,//是否在浏览导航栏显示记录总数
        rowNum:15,//每页显示记录数
        rowList:[15,20,25],//用于改变显示行数的下拉列表框的元素数组。
        jsonReader:{
            id: "blackId",//设置返回参数中，表格ID的名字为blackId
            repeatitems : false
        },
        pager:$('#gridPager')
    });
	var mydata = [
            {dirverName:"",phoneNumF:"",phoneNumS:"",usualCars:"",usualRoute:"",tranState:"",drivCardType:"",driverAge:"",comSevYears:""},
            {dirverName:"",phoneNumF:"",phoneNumS:"",usualCars:"",usualRoute:"",tranState:"",drivCardType:"",driverAge:"",comSevYears:""},
            {dirverName:"",phoneNumF:"",phoneNumS:"",usualCars:"",usualRoute:"",tranState:"",drivCardType:"",driverAge:"",comSevYears:""},
            {dirverName:"",phoneNumF:"",phoneNumS:"",usualCars:"",usualRoute:"",tranState:"",drivCardType:"",driverAge:"",comSevYears:""},
            {dirverName:"",phoneNumF:"",phoneNumS:"",usualCars:"",usualRoute:"",tranState:"",drivCardType:"",driverAge:"",comSevYears:""}
			];
	for(var i=0;i<=mydata.length;i++)
		jQuery("#container4").jqGrid('addRowData',i+1,mydata[i]);
});