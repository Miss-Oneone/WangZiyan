$(document).ready(function(){
    $("#sending-cars-2").jqGrid({
        //url:contextPath + "search.action",
        datatype:"json", //数据来源，本地数据
        mtype:"POST",//提交方式
        height:500,//高度，表格高度。可为数值、百分比或'auto'
        width:800,//这个宽度不能为百分比
        //autowidth:true,//自动宽
		shrinkToFit:false,  
		autoScroll: true,
		multiselect: true,
        colNames:['系统单号', '运输订单详情','出发时间','联系人/电话','费用','业务备注'],
        colModel:[
            //{name:'id',index:'id', width:'10%', align:'center' },
            //{name:'choose',index:'choose',width:'40%',align:'center',formatter:function(v,x,r){ return "<input type='checkbox'/>";}},//formatter: cLink,
            {name:'sysCode',index:'sysCode',width:'65%',align:'center'},	
            {name:'transactionInfo',index:'transactionInfo',align:"center"},
			{name:'startTime',index:'startTime',width:'75%',align:"center"},
			{name:'tel',index:'tel',align:"center"},
			{name:'amounts',index:'amounts',width:'60%',align:"center"},
			{name:'remarks',index:'remarks',width:'160%',align:"center"}
        ],
        //rownumbers:true,//添加左侧行号
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
			{sysCode:"<a href='../sendQueryAndEdit/send-container.html'>082101</a>",transactionInfo:"提箱地：厦门码头  装货地：晋江东石镇塔头刘工业区(福建雨丝梦洋伞)卸货地：厦门码头",startTime:"2015-9-1",tel:"小王/13400801999",amounts:"<a href='../transportTaskAccepting/costManagement.html'>应收<br/>应付</a>",remarks:""},
			{sysCode:"<a href='../sendQueryAndEdit/send-container.html'>082102</a>",transactionInfo:"提箱地：海沧新海达  装货地：晋江东石镇塔头刘工业区(福建雨丝梦洋伞)卸货地：海沧新海达",startTime:"2015-9-1",tel:"小吴/13400801239",amounts:"<a href='../transportTaskAccepting/costManagement.html'>应收<br/>应付</a>",remarks:""},
			{sysCode:"<a href='../sendQueryAndEdit/send-container.html'>082103</a>",transactionInfo:"提箱地：厦门新海达  装货地：长泰到灌口金龙的散货  卸货地：灌口",startTime:"2015-9-1",tel:"小汪/15392235639",amounts:"<a href='../transportTaskAccepting/costManagement.html'>应收<br/>应付</a>",remarks:""},
			{sysCode:"<a href='../sendQueryAndEdit/send-container.html'>082104</a>",transactionInfo:"提箱地：厦门新海达  装货地：长泰到灌口金龙的散货  卸货地：灌口",startTime:"2015-9-1",tel:"小汪/15392235639",amounts:"<a href='../transportTaskAccepting/costManagement.html'>应收<br/>应付</a>",remarks:""},
			{sysCode:"<a href='../sendQueryAndEdit/send-container.html'>082105</a>",transactionInfo:"提箱地：厦门新海达  装货地：长泰到灌口金龙的散货  卸货地：灌口",startTime:"2015-9-1",tel:"小汪/15392235639",amounts:"<a href='../transportTaskAccepting/costManagement.html'>应收<br/>应付</a>",remarks:""},
			{sysCode:"<a href='../sendQueryAndEdit/send-container.html'>082106</a>",transactionInfo:"提箱地：海润码头  装货地：泉州清濛科技工业区吉泰路1号  卸货地：海润码头",startTime:"2015-9-1",tel:"李翠运/0595-22496682,<br/>13959839039",amounts:"<a href='../transportTaskAccepting/costManagement.html'>应收<br/>应付</a>",remarks:""},
			{sysCode:"<a href='../sendQueryAndEdit/send-container.html'>082107</a>",transactionInfo:"提箱地：中集海投（海沧）  装货地：吉特利环保科技（厦门）有限公司 厦门市同安区上坂西洪塘集安路523号  卸货地：海沧码头",startTime:"2015-9-1",tel:"洪丽梅/15959269594",amounts:"<a href='../transportTaskAccepting/costManagement.html'>应收<br/>应付</a>",remarks:""},
			{sysCode:"<a href='../sendQueryAndEdit/send-container.html'>082108</a>",transactionInfo:"提箱地：中集海投（海沧）    装货地：石狮市西环路皇冠仓储区装柜联系人: 海峡  卸货地：海沧码头",startTime:"2015-9-1",tel:"小钟/ 18050996131",amounts:"<a href='../transportTaskAccepting/costManagement.html'>应收<br/>应付</a>",remarks:""}
			];
	for(var i=0;i<=mydata.length;i++)
		jQuery("#sending-cars-2").jqGrid('addRowData',i+1,mydata[i]);
});
function choose(){
	layer.open({
        type: 2,
        title: '添加运输任务',
        maxmin: true,
        shadeClose: true, //点击遮罩关闭层
        area : ['820px' , '400px'],
        content: 'addOrderTask.html'
    });
}
function cLink(cellvalue, options, rowObject){
	return '<a href="javascript:void(0)" onclick="choose();">选</a>';
} 
