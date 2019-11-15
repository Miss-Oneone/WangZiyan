$(document).ready(function(){
    $("#container3").jqGrid({
        //url:contextPath + "search.action",
        datatype:"json", //数据来源，本地数据
        mtype:"POST",//提交方式
        height:70,//高度，表格高度。可为数值、百分比或'auto'
        //width:1000,//这个宽度不能为百分比
        autowidth:true,//自动宽
        colNames:['车牌号','车型信息','载重量','车辆运输状态','停车地点','系统单号','集装箱号','路线信息','任务时间信息','固定司机','当前司机'],
        colModel:[
            //{name:'id',index:'id', width:'10%', align:'center' },
            {name:'carsNum',index:'carsNum', width:'3%',align:'center'},
            {name:'carsImfor',index:'carsImfor', width:'3%',align:'center'},	
            {name:'load',index:'load', width:'3%', align:"center"},
            {name:'carsTransInfor',index:'carsTransInfor', width:'3%', align:"center"},
            {name:'stopPlace',index:'stopPlace', width:'3%', align:"center"},
            {name:'sysNum',index:'sysNum', width:'3%', align:"center"},
            {name:'containNum',index:'containNum', width:'3%', align:"center"},
            {name:'routeInfor',index:'routeInfor', width:'3%', align:"center"},
            {name:'taskTime',index:'taskTime', width:'3%', align:"center"},
            {name:'fixedDriver',index:'fixedDriver', width:'3%', align:"center"},
            {name:'currentDriver',index:'currentDriver', width:'3%', align:"center"}
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
            {carsNum:"",carsImfor:"",load:"",carsTransInfor:"",stopPlace:"",sysNum:"",containNum:"",routeInfor:"",taskTime:"",fixedDriver:"",currentDriver:""},
            {carsNum:"",carsImfor:"",load:"",carsTransInfor:"",stopPlace:"",sysNum:"",containNum:"",routeInfor:"",taskTime:"",fixedDriver:"",currentDriver:""},
            {carsNum:"",carsImfor:"",load:"",carsTransInfor:"",stopPlace:"",sysNum:"",containNum:"",routeInfor:"",taskTime:"",fixedDriver:"",currentDriver:""},
            {carsNum:"",carsImfor:"",load:"",carsTransInfor:"",stopPlace:"",sysNum:"",containNum:"",routeInfor:"",taskTime:"",fixedDriver:"",currentDriver:""},
            {carsNum:"",carsImfor:"",load:"",carsTransInfor:"",stopPlace:"",sysNum:"",containNum:"",routeInfor:"",taskTime:"",fixedDriver:"",currentDriver:""}
			];
	for(var i=0;i<=mydata.length;i++)
		jQuery("#container3").jqGrid('addRowData',i+1,mydata[i]);
});