$(document).ready(function(){
    $("#container1").jqGrid({
        //url:contextPath + "search.action",
        datatype:"json", //数据来源，本地数据
        mtype:"POST",//提交方式
        height:18,//高度，表格高度。可为数值、百分比或'auto'
        //width:1000,//这个宽度不能为百分比
        autowidth:true,//自动宽
        colNames:['货物类型', '货物重量', '已派车重量','已完成重量','单/多','装货地点','卸货地点','装货到场时间','卸货到场时间','运输时间段','中转地点','中转到达时间','中转离开时间'],
        colModel:[
            //{name:'id',index:'id', width:'10%', align:'center' },
            {name:'goodsType',index:'goodsType', width:'3%',align:'center'},
            {name:'goodsWeight',index:'goodsWeight', width:'3%',align:'center'},	
            {name:'carWeight',index:'carWeight', width:'3%', align:"center"},
			{name:'successWeight',index:'currency', width:'3%', align:"center"},
			{name:'singleMany',index:'singleMany', width:'3%', align:"center"},
			{name:'loadPlace',index:'loadPlace', width:'3%', align:"center"},
			{name:'cargoPlace',index:'cargoPlace', width:'3%', align:"center"},
			{name:'loadTime',index:'loadTime', width:'3%', align:"center"},
			{name:'cargoTime',index:'cargoTime', width:'3%', align:"center"},
			{name:'tranTime',index:'tranTime', width:'3%', align:"center"},
			{name:'tranMidTime',index:'tranMidTime', width:'3%', align:"center"},
			{name:'arrTime',index:'arrTime', width:'3%', align:"center"},
			{name:'leftTime',index:'leftTime', width:'3%', align:"center"}
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
			{goodsType:"",goodsWeight:"",carWeight:"",successWeight:"",singleMany:"",loadPlace:"",cargoPlace:"",loadTime:"",cargoTime:"",tranTime:"",tranMidTime:"",arrTime:"",leftTime:""}
			];
	for(var i=0;i<=mydata.length;i++)
		jQuery("#container1").jqGrid('addRowData',i+1,mydata[i]);
});