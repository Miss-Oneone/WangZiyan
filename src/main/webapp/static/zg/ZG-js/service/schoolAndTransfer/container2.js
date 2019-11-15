$(document).ready(function(){
    $("#container2").jqGrid({
        //url:contextPath + "search.action",
        datatype:"json", //数据来源，本地数据
        mtype:"POST",//提交方式
        height:150,//高度，表格高度。可为数值、百分比或'auto'
        //width:1000,//这个宽度不能为百分比
        autowidth:true,//自动宽
        colNames:['派车单号', '派车时间', '发车日期','调度人','车牌号','车辆类型','车架号','司机','载重量','派车单状态','实际发车时间','实际回场时间'],
        colModel:[
            //{name:'id',index:'id', width:'10%', align:'center' },
            {name:'carsNum',index:'carsNum', width:'3%',align:'center'},
            {name:'carsTime',index:'carsTime', width:'3%',align:'center'},	
            {name:'carsDate',index:'carsDate', width:'3%', align:"center"},
            {name:'person',index:'person', width:'3%', align:"center"},
            {name:'carsNum',index:'carsNum', width:'3%', align:"center"},
            {name:'carsType',index:'carsType', width:'3%', align:"center"},
            {name:'frameCarNum',index:'frameCarNum', width:'3%', align:"center"},
            {name:'drivers',index:'drivers', width:'3%', align:"center"},
            {name:'load',index:'load', width:'3%', align:"center"},
            {name:'carsState',index:'carsState', width:'3%', align:"center"},
            {name:'trueGoTime',index:'trueGoTime', width:'3%', align:"center"},
            {name:'trueReturnTime',index:'trueReturnTime', width:'3%', align:"center"}
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
            {carsNum:"",carsTime:"",carsDate:"",person:"",carsNum:"",carsType:"",frameCarNum:"",drivers:"",load:"",carsState:"",trueGoTime:"",trueReturnTime:""},
            {carsNum:"",carsTime:"",carsDate:"",person:"",carsNum:"",carsType:"",frameCarNum:"",drivers:"",load:"",carsState:"",trueGoTime:"",trueReturnTime:""},
            {carsNum:"",carsTime:"",carsDate:"",person:"",carsNum:"",carsType:"",frameCarNum:"",drivers:"",load:"",carsState:"",trueGoTime:"",trueReturnTime:""},
            {carsNum:"",carsTime:"",carsDate:"",person:"",carsNum:"",carsType:"",frameCarNum:"",drivers:"",load:"",carsState:"",trueGoTime:"",trueReturnTime:""},
			];
	for(var i=0;i<=mydata.length;i++)
		jQuery("#container2").jqGrid('addRowData',i+1,mydata[i]);
});