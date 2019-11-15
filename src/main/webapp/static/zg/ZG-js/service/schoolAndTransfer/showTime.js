$(document).ready(function(){
    $("#showTime").jqGrid({
        //url:contextPath + "search.action",
        datatype:"json", //数据来源，本地数据
        mtype:"POST",//提交方式
        height:'auto',//高度，表格高度。可为数值、百分比或'auto'
        width:1200,//这个宽度不能为百分比
        //autowidth:true,//自动宽
		cellEdit:false, 
		shrinkToFit:false,  
		autoScroll: true,
		cellsubmit:"clientArray",
        colNames:['系统单号', '早', '6', '7', '8', '9', '10','11','12','13','14','15','16','17','18','19','晚','早','6', '7', '8', '9', '10','11','12','13','14','15','16','17','18','19','晚'],
        colModel:[
            {name:'sysCode',index:'sysCode',align:'center',width:'77%'},
            {name:'morning',index:'morning',align:'center',width:'29%'},	
			{name:'hour6',index:'hour6',align:'center',width:'29%'},	
            {name:'hour7',index:'hour7',align:'center',width:'29%'},
			{name:'hour8',index:'hour8',align:'center',width:'29%'},
			{name:'hour9',index:'hour9',align:'center',width:'29%'},
			{name:'hour10',index:'hour10',align:'center',width:'29%'},
			{name:'hour11',index:'hour11',align:'center',width:'29%'},
			{name:'hour12',index:'hour12',align:'center',width:'29%'},
			{name:'hour13',index:'hour13',align:'center',width:'29%'},
			{name:'hour14',index:'hour14',align:'center',width:'29%'},
			{name:'hour15',index:'hour15',align:'center',width:'29%'},
			{name:'hour16',index:'hour16',align:'center',width:'29%'},
			{name:'hour17',index:'hour17',align:'center',width:'29%'},
			{name:'hour18',index:'hour18',align:'center',width:'29%'},
			{name:'hour19',index:'hour19',align:'center',width:'29%'},
			{name:'hour20',index:'hour20',align:'center',width:'29%'},
			{name:'hour21',index:'hour21',align:'center',width:'29%'},	
			{name:'hour22',index:'hour22',align:'center',width:'29%'},	
            {name:'hour23',index:'hour23',align:'center',width:'29%'},
			{name:'hour24',index:'hour24',align:'center',width:'29%'},
			{name:'hour25',index:'hour25',align:'center',width:'29%'},
			{name:'hour26',index:'hour26',align:'center',width:'29%'},
			{name:'hour27',index:'hour27',align:'center',width:'29%'},
			{name:'hour28',index:'hour28',align:'center',width:'29%'},
			{name:'hour29',index:'hour29',align:'center',width:'29%'},
			{name:'hour30',index:'hour30',align:'center',width:'29%'},
			{name:'hour31',index:'hour31',align:'center',width:'29%'},
			{name:'hour32',index:'hour32',align:'center',width:'29%'},
			{name:'hour33',index:'hour33',align:'center',width:'29%'},
			{name:'hour34',index:'hour34',align:'center',width:'29%'},
			{name:'hour35',index:'hour35',align:'center',width:'29%'},
			{name:'hour36',index:'hour36',align:'center',width:'29%'}
        ],
        rownumbers:true,//添加左侧行号
        //altRows:true,//设置为交替行表格,默认为false
        //sortname:'createDate',
        //sortorder:'asc',
        viewrecords: true,//是否在浏览导航栏显示记录总数
        rowNum:15,//每页显示记录数
        rowList:[15,20,25],//用于改变显示行数的下拉列表框的元素数组。
        jsonReader:{
            id: "blackId",//设置返回showTimeshowTime参数中，表格ID的名字为blackId
            repeatitems : false
        },
		afterEditCell:function(rowid,name,val,iRow,iCol){ 
			var rowdata = $("#showTime").jqGrid("getRowData",rowid); 
			var id=rowid+"_"+name; 
			if(name=="amt"){ 
				$("#"+id).keyup(function(e){ 
				var amt = $(this).val(); 
				var fee = rowdata["fee"]; 
				var total = parseFloat(amt) + parseFloat(fee); 
				$("#showTime").jqGrid("setRowData",rowid,{"total":total}); 
				}); 
			} 
		 },
        pager:$('#gridPager')
    });
	var mydata = [
			{sysCode:"",morning:"5",hour6:"口",hour7:"口",hour8:"口",hour9:"口",hour10:"口",hour11:"口",hour12:"口",hour13:"口",hour14:"口",hour15:"口",hour16:"口",hour17:"口",hour18:"口",hour19:"口",hour20:"20"
					   ,hour21:"5",hour22:"口",hour23:"口",hour24:"口",hour25:"口",hour26:"口",hour27:"口",hour28:"口",hour29:"口",hour30:"口",hour31:"口",hour32:"口",hour33:"口",hour34:"口",hour35:"口",hour36:"20"
			},
			{sysCode:"",morning:"5",hour6:"口",hour7:"口",hour8:"口",hour9:"口",hour10:"口",hour11:"口",hour12:"口",hour13:"口",hour14:"口",hour15:"口",hour16:"口",hour17:"口",hour18:"口",hour19:"口",hour20:"20"
					   ,hour21:"5",hour22:"口",hour23:"口",hour24:"口",hour25:"口",hour26:"口",hour27:"口",hour28:"口",hour29:"口",hour30:"口",hour31:"口",hour32:"口",hour33:"口",hour34:"口",hour35:"口",hour36:"20"
			}
			];
	for(var i=0;i<=mydata.length;i++)
		jQuery("#showTime").jqGrid('addRowData',i+1,mydata[i]);
});