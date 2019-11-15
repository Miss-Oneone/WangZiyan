$(document).ready(function(){
    $("#sendUnManagement").jqGrid({
        //url:contextPath + "search.action",
        datatype:"json", //数据来源，本地数据
        mtype:"POST",//提交方式
        height:180,//高度，表格高度。可为数值、百分比或'auto'
        width:1000,//这个宽度不能为百分比
        //autowidth:true,//自动宽
		cellEdit:true, 
		cellsubmit:"clientArray",
        colNames:['系统单号', '状态', '承运车队', '车牌号', '司机', '车辆类型', '车架类型', '业务类型', '箱号', '提单号', '集装箱尺寸', '超重箱','货物类型','货物重量','提箱地点','提箱时间','装货地点','装货到场时间','卸货地点','卸货到场时间','空箱堆场'],
        colModel:[
            {name:'A',index:'A', width:'20%',align:'center',formatter:"showlink",
                          formatoptions:{baseLinkUrl:"send-unContainer.html",target:"_self"},editable:true},
            {name:'B',index:'B', width:'15%',align:'center'},	
			{name:'C',index:'C', width:'15%',align:'center'},	
            {name:'D',index:'D', width:'15%', align:"center"},
			{name:'E',index:'E', width:'15%', align:"center"},
			{name:'F',index:'F', width:'15%', align:"center"},
			{name:'G',index:'G', width:'15%', align:"center"},
			{name:'H',index:'H', width:'15%', align:"center"},
			{name:'I',index:'I', width:'15%', align:"center"},
			{name:'J',index:'J', width:'15%', align:"center"},
			{name:'K',index:'K', width:'15%', align:"center"},
			{name:'L',index:'L', width:'15%', align:"center"},
			{name:'M',index:'M', width:'15%', align:"center"},
			{name:'N',index:'N', width:'15%', align:"center"},
			{name:'O',index:'O', width:'15%', align:"center"},
			{name:'P',index:'P', width:'15%', align:"center"},
			{name:'Q',index:'Q', width:'15%', align:"center"},
			{name:'R',index:'R', width:'15%', align:"center"},
			{name:'S',index:'S', width:'15%', align:"center"},
			{name:'T',index:'T', width:'15%', align:"center"},
			{name:'U',index:'U', width:'15%', align:"center"}
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
			var rowdata = $("#sendUnManagement").jqGrid("getRowData",rowid); 
			var id=rowid+"_"+name; 
			if(name=="amt"){ 
				$("#"+id).keyup(function(e){ 
				var amt = $(this).val(); 
				var fee = rowdata["fee"]; 
				var total = parseFloat(amt) + parseFloat(fee); 
				$("#sendUnManagement").jqGrid("setRowData",rowid,{"total":total}); 
				}); 
			} 
		 },
        pager:$('#gridPager')
    });
	var mydata = [
			{A:"xxxxxxxx",B:"",C:"",D:"",E:"",F:"",G:"",H:"",I:"",J:"",K:"",L:"",M:"",N:"",O:"",P:"",Q:"",R:"",S:"",T:"",U:""},
			{A:"xxxxxxxx",B:"",C:"",D:"",E:"",F:"",G:"",H:"",I:"",J:"",K:"",L:"",M:"",N:"",O:"",P:"",Q:"",R:"",S:"",T:"",U:""},
			{A:"xxxxxxxx",B:"",C:"",D:"",E:"",F:"",G:"",H:"",I:"",J:"",K:"",L:"",M:"",N:"",O:"",P:"",Q:"",R:"",S:"",T:"",U:""},
			{A:"xxxxxxxx",B:"",C:"",D:"",E:"",F:"",G:"",H:"",I:"",J:"",K:"",L:"",M:"",N:"",O:"",P:"",Q:"",R:"",S:"",T:"",U:""},
			{A:"xxxxxxxx",B:"",C:"",D:"",E:"",F:"",G:"",H:"",I:"",J:"",K:"",L:"",M:"",N:"",O:"",P:"",Q:"",R:"",S:"",T:"",U:""},
			{A:"xxxxxxxx",B:"",C:"",D:"",E:"",F:"",G:"",H:"",I:"",J:"",K:"",L:"",M:"",N:"",O:"",P:"",Q:"",R:"",S:"",T:"",U:""},
			{A:"xxxxxxxx",B:"",C:"",D:"",E:"",F:"",G:"",H:"",I:"",J:"",K:"",L:"",M:"",N:"",O:"",P:"",Q:"",R:"",S:"",T:"",U:""},
			{A:"xxxxxxxx",B:"",C:"",D:"",E:"",F:"",G:"",H:"",I:"",J:"",K:"",L:"",M:"",N:"",O:"",P:"",Q:"",R:"",S:"",T:"",U:""}
			];
	for(var i=0;i<=mydata.length;i++)
		jQuery("#sendUnManagement").jqGrid('addRowData',i+1,mydata[i]);
});