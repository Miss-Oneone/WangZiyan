$(document).ready(function(){ 
	var hour;
    $("#timeOfPlan").jqGrid({
        //url:contextPath + "search.action",
        datatype:"json", //数据来源，本地数据
        mtype:"POST",//提交方式
        height:'auto',//高度，表格高度。可为数值、百分比或'auto'
        width:1200,//这个宽度不能为百分比
        //autowidth:true,//自动宽
		cellEdit:true, 
		cellsubmit:"clientArray",
        colNames:['时间预告', '发车时间', '发车日期', '系统单号', '运输任务详情', '时间要求', '业务备注'],
        colModel:[
            {name:'timeForecast',index:'timeForecast', align:'center',editable:true},
            {name:'timeOfSending',index:'timeOfSending',align:'center'},	
			{name:'dateOfSending',index:'dateOfSending',align:'center'},	
            {name:'sysCode',index:'sysCode',align:"center"},
			{name:'transportInfo',index:'transportInfo',align:"center",width:'200%'},
			{name:'timeOfRequire',index:'timeOfRequire', align:"center"},
			{name:'remarks',index:'remarks', align:"center"}
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
			var rowdata = $("#timeOfPlan").jqGrid("getRowData",rowid); 
			var id=rowid+"_"+name; 
			if(name=="amt"){ 
				$("#"+id).keyup(function(e){ 
				var amt = $(this).val(); 
				var fee = rowdata["fee"]; 
				var total = parseFloat(amt) + parseFloat(fee); 
				$("#timeOfPlan").jqGrid("setRowData",rowid,{"total":total}); 
				}); 
			} 
		 },
        pager:$('#gridPager'),
		beforeSubmitCell : function(rowid,celname,value,iRow,iCol) {
			var h = value.replace(/[^0-9]/ig,""); 
			testReloadGrid(rowid,h);
		}
    });
	var mydata = [
			{timeForecast:"5小时",timeOfSending:"HH24 +/-",dateOfSending:"MM-DD +/-",sysCode:"082105",transportInfo:"提箱地：厦门新海达  装货地：长泰到灌口金龙的散货  卸货地：灌口",timeOfRequire:"",remarks:""},
			{timeForecast:"8小时",timeOfSending:"HH24 +/-",dateOfSending:"MM-DD +/-",sysCode:"082107",transportInfo:"提箱地：中集海投（海沧）  装货地：吉特利环保科技（厦门）有限公司 厦门市同安区上坂西洪塘集安路523号  卸货地：海沧码头",timeOfRequire:"",remarks:""}
			];
	for(var i=0;i<=mydata.length;i++)
		jQuery("#timeOfPlan").jqGrid('addRowData',i+1,mydata[i]);
});
function testReloadGrid(rowid,hour){
	var mydata = [
			{sysCode:"",morning:"5",hour6:"口",hour7:"口",hour8:"口",hour9:"口",hour10:"口",hour11:"口",hour12:"口",hour13:"口",hour14:"口",hour15:"口",hour16:"口",hour17:"口",hour18:"口",hour19:"口",hour20:"20"
					   ,hour21:"5",hour22:"口",hour23:"口",hour24:"口",hour25:"口",hour26:"口",hour27:"口",hour28:"口",hour29:"口",hour30:"口",hour31:"口",hour32:"口",hour33:"口",hour34:"口",hour35:"口",hour36:"20"
			},
			{sysCode:"",morning:"5",hour6:"口",hour7:"口",hour8:"口",hour9:"口",hour10:"口",hour11:"口",hour12:"口",hour13:"口",hour14:"口",hour15:"口",hour16:"口",hour17:"口",hour18:"口",hour19:"口",hour20:"20"
					   ,hour21:"5",hour22:"口",hour23:"口",hour24:"口",hour25:"口",hour26:"口",hour27:"口",hour28:"口",hour29:"口",hour30:"口",hour31:"口",hour32:"口",hour33:"口",hour34:"口",hour35:"口",hour36:"20"
			}
			];
	var choose = "<input type='button' value='口' class='btn btn-danger radius'>";
	if(rowid==1){
		var len = Number(hour)+6;
		for(var num=6;num<len;num++){
			mydata[rowid-1]['hour'+num]=choose;
		}
		var count = $("#showTime").getGridParam("reccount");
		for(var i=1;i<=Number(count);i++){
			jQuery("#showTime").jqGrid('delRowData',i);
		}
		jQuery("#showTime").jqGrid('addRowData',0,mydata[0]);
		jQuery("#showTime").jqGrid('addRowData',0,mydata[1]);
	}else{
		var len = Number(hour)+6;
		for(var num=6;num<len;num++){
			mydata[rowid-1]['hour'+num]=choose;
		}
		var count = $("#showTime").getGridParam("reccount");
		for(var i=1;i<=Number(count);i++){
			jQuery("#showTime").jqGrid('delRowData',i);
		}
		jQuery("#showTime").jqGrid('addRowData',0,mydata[0]);
		jQuery("#showTime").jqGrid('addRowData',1,mydata[1]);
	}
}
