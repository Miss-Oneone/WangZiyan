$(document).ready(function(){
    $("#send-cars-container").jqGrid({
        //url:contextPath + "search.action",
        datatype:"json", //数据来源，本地数据
        mtype:"POST",//提交方式
        height:200,//高度，表格高度。可为数值、百分比或'auto'
        width:1000,//这个宽度不能为百分比
        //autowidth:true,//自动宽
		cellEdit:true, 
		cellsubmit:"clientArray",
        colNames:['系统单号', '任务状态', '集装箱号', '提单号', '路线信息', '航线', '客户', '时间要求', '货物类型', '货物重量', '承运公司', '提交时间'],
        colModel:[
            {name:'systemCode',index:'systemCode', width:'10%',align:'center',formatter:"showlink",
                          formatoptions:{baseLinkUrl:"send-cars-container.html",target:"_self"},editable:true},
            {name:'taskStatus',index:'taskStatus', width:'9%',align:'center'},	
			{name:'containerNum',index:'containerNum', width:'9%',align:'center'},	
            {name:'billOfLading',index:'billOfLading', width:'9%', align:"center"},
			{name:'pathInfo',index:'pathInfo', width:'9%', align:"center"},
			{name:'airPath',index:'airPath', width:'9%', align:"center"},
			{name:'customer',index:'customer', width:'9%', align:"center"},
			{name:'timeRequest',index:'timeRequest', width:'9%', align:"center"},
			{name:'cargoType',index:'cargoType', width:'9%', align:"center"},
			{name:'cargoWeight',index:'cargoWeight', width:'9%', align:"center"},
			{name:'carrier',index:'carrier', width:'9%', align:"center"},
			{name:'subTime',index:'subTime', width:'9%', align:"center"}
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
		afterEditCell:function(rowid,name,val,iRow,iCol){ 
			var rowdata = $("#costManagement").jqGrid("getRowData",rowid); 
			var id=rowid+"_"+name; 
			if(name=="amt"){ 
				$("#"+id).keyup(function(e){ 
				var amt = $(this).val(); 
				var fee = rowdata["fee"]; 
				var total = parseFloat(amt) + parseFloat(fee); 
				$("#send-cars-container").jqGrid("setRowData",rowid,{"total":total}); 
				}); 
			} 
		 },
        pager:$('#gridPager')
    });
	var mydata = [
			{systemCode:"xxxxxxxx",taskStatus:"",containerNum:"",billOfLading:"",pathInfo:"",airPath:"",customer:"",timeRequest:"",cargoType:"",cargoWeight:"",carrier:"",subTime:""},
			{systemCode:"xxxxxxxx",taskStatus:"",containerNum:"",billOfLading:"",pathInfo:"",airPath:"",customer:"",timeRequest:"",cargoType:"",cargoWeight:"",carrier:"",subTime:""},
			{systemCode:"xxxxxxxx",taskStatus:"",containerNum:"",billOfLading:"",pathInfo:"",airPath:"",customer:"",timeRequest:"",cargoType:"",cargoWeight:"",carrier:"",subTime:""},
			{systemCode:"xxxxxxxx",taskStatus:"",containerNum:"",billOfLading:"",pathInfo:"",airPath:"",customer:"",timeRequest:"",cargoType:"",cargoWeight:"",carrier:"",subTime:""},
			{systemCode:"xxxxxxxx",taskStatus:"",containerNum:"",billOfLading:"",pathInfo:"",airPath:"",customer:"",timeRequest:"",cargoType:"",cargoWeight:"",carrier:"",subTime:""},
			{systemCode:"xxxxxxxx",taskStatus:"",containerNum:"",billOfLading:"",pathInfo:"",airPath:"",customer:"",timeRequest:"",cargoType:"",cargoWeight:"",carrier:"",subTime:""},
			{systemCode:"xxxxxxxx",taskStatus:"",containerNum:"",billOfLading:"",pathInfo:"",airPath:"",customer:"",timeRequest:"",cargoType:"",cargoWeight:"",carrier:"",subTime:""},
			{systemCode:"xxxxxxxx",taskStatus:"",containerNum:"",billOfLading:"",pathInfo:"",airPath:"",customer:"",timeRequest:"",cargoType:"",cargoWeight:"",carrier:"",subTime:""},
			{systemCode:"xxxxxxxx",taskStatus:"",containerNum:"",billOfLading:"",pathInfo:"",airPath:"",customer:"",timeRequest:"",cargoType:"",cargoWeight:"",carrier:"",subTime:""},
			{systemCode:"xxxxxxxx",taskStatus:"",containerNum:"",billOfLading:"",pathInfo:"",airPath:"",customer:"",timeRequest:"",cargoType:"",cargoWeight:"",carrier:"",subTime:""},
			{systemCode:"xxxxxxxx",taskStatus:"",containerNum:"",billOfLading:"",pathInfo:"",airPath:"",customer:"",timeRequest:"",cargoType:"",cargoWeight:"",carrier:"",subTime:""},
			{systemCode:"xxxxxxxx",taskStatus:"",containerNum:"",billOfLading:"",pathInfo:"",airPath:"",customer:"",timeRequest:"",cargoType:"",cargoWeight:"",carrier:"",subTime:""},
			{systemCode:"xxxxxxxx",taskStatus:"",containerNum:"",billOfLading:"",pathInfo:"",airPath:"",customer:"",timeRequest:"",cargoType:"",cargoWeight:"",carrier:"",subTime:""},
			{systemCode:"xxxxxxxx",taskStatus:"",containerNum:"",billOfLading:"",pathInfo:"",airPath:"",customer:"",timeRequest:"",cargoType:"",cargoWeight:"",carrier:"",subTime:""},
			{systemCode:"xxxxxxxx",taskStatus:"",containerNum:"",billOfLading:"",pathInfo:"",airPath:"",customer:"",timeRequest:"",cargoType:"",cargoWeight:"",carrier:"",subTime:""},
			{systemCode:"xxxxxxxx",taskStatus:"",containerNum:"",billOfLading:"",pathInfo:"",airPath:"",customer:"",timeRequest:"",cargoType:"",cargoWeight:"",carrier:"",subTime:""},
			{systemCode:"xxxxxxxx",taskStatus:"",containerNum:"",billOfLading:"",pathInfo:"",airPath:"",customer:"",timeRequest:"",cargoType:"",cargoWeight:"",carrier:"",subTime:""}
			];
	for(var i=0;i<=mydata.length;i++)
		jQuery("#send-cars-container").jqGrid('addRowData',i+1,mydata[i]);
});