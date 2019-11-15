$(document).ready(function(){
    $("#moreDetail-queryAndEdit").jqGrid({
        //url:contextPath + "search.action",
        datatype:"json", //数据来源，本地数据
        mtype:"POST",//提交方式
        height:80,//高度，表格高度。可为数值、百分比或'auto'
        //width:1000,//这个宽度不能为百分比
        autowidth:true,//自动宽 
		cellEdit:true, 
		cellsubmit:"clientArray",
        colNames:['明细单号', '集装箱尺寸', '超重箱','数量','货物类型','箱主','租箱费','出发地点/装货地点','上柜时间段-开始/结束','联系人','电话','传真','目的地/卸货地点','卸货时间段-开始/结束'],
        colModel:[
            //{name:'id',index:'id', width:'10%', align:'center' },
            {name:'detailCode',index:'detailCode', width:'10%',align:'center', formatter:"showlink",
                          formatoptions:{baseLinkUrl:"moreDetail-queryAndEdit.html",target:"_self"},editable:true},
            {name:'containerSize',index:'containerSize', width:'10%',align:'center',editable:true},	
            {name:'overweightBox',index:'overweightBox', width:'10%', align:"center",editable:true},
            {name:'count',index:'count', width:'8%', align:"left", sortable:false},
            {name:'cargoType',index:'cargoType', width:'10%',align:"center", sortable:false,editable:true},
			{name:'mainBox',index:'mainBox', width:'10%',align:"center", sortable:false,editable:true},
			{name:'boxCost',index:'boxCost', width:'10%',align:"center"},
			{name:'startPlace',index:'startPlace', width:'15%',align:"center", sortable:false,editable:true},
			{name:'timeOfLoding',index:'timeOfStartAndEnd', width:'18%',align:"center", sortable:false},
			{name:'contactMan',index:'contactMan', width:'8%',align:"center", sortable:false},
			{name:'telPhone',index:'telPhone', width:'8%',align:"center", sortable:false},
			{name:'fax',index:'fax', width:'8%',align:"center", sortable:false},
			{name:'timeOfDischarge',index:'mainBox', width:'18%',align:"center",editable:true},
			{name:'timeOfEnd',index:'mainBox', width:'18%',align:"center", sortable:false},
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
			var rowdata = $("#moreDetail-queryAndEdit").jqGrid("getRowData",rowid); 
			var id=rowid+"_"+name; 
			if(name=="amt"){ 
				$("#"+id).keyup(function(e){ 
				var amt = $(this).val(); 
				var fee = rowdata["fee"]; 
				var total = parseFloat(amt) + parseFloat(fee); 
				$("#moreDetail-queryAndEdit").jqGrid("setRowData",rowid,{"total":total}); 
				}); 
			} 
		 },
        pager:$('#gridPager')
    });
	var mydata = [
			{detailCode:"xxxxxxxx",containerSize:"20GP",overweightBox:"是",count:"1",cargoType:"服装",mainBox:"自有",boxCost:"无",startPlace:"",timeOfLoding:"MM-DD HH24:MI",contactMan:"",telPhone:"",fax:"",timeOfDischarge:"",timeOfEnd:"MM-DD HH24:MI"},
			{detailCode:"xxxxxxxx",containerSize:"40GP",overweightBox:"是",count:"2",cargoType:"服装",mainBox:"自有",boxCost:"无",startPlace:"",timeOfLoding:"",contactMan:"",telPhone:"",fax:"",timeOfDischarge:"",timeOfEnd:""},
			{detailCode:"xxxxxxxx",containerSize:"40HQ",overweightBox:"是",count:"8",cargoType:"玩具",mainBox:"第三方",boxCost:"无",startPlace:"",timeOfLoding:"",contactMan:"",telPhone:"",fax:"",timeOfDischarge:"",timeOfEnd:""},
			{detailCode:"xxxxxxxx",containerSize:"",overweightBox:"",count:"test",cargoType:"",mainBox:"some",boxCost:"有",dstartPlace:"",timeOfLoding:"",contactMan:"",telPhone:"",fax:"",timeOfDischarge:"",timeOfEnd:""}
			];
	for(var i=0;i<=mydata.length;i++)
		jQuery("#moreDetail-queryAndEdit").jqGrid('addRowData',i+1,mydata[i]);
});