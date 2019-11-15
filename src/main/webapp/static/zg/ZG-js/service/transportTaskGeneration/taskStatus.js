$(document).ready(function(){
    $("#taskStatus").jqGrid({
        //url:contextPath + "search.action",
        datatype:"json", //数据来源，本地数据
        mtype:"POST",//提交方式
        height:'auto',//高度，表格高度。可为数值、百分比或'auto'
        width:1150,//这个宽度不能为百分比
        //autowidth:'auto',//自动宽 
		shrinkToFit:false,  
		autoScroll: true,  
		cellEdit:true, 
		cellsubmit:"clientArray",
        colNames:['任务状态', '系统单号', '业务类型','集装箱号','提单号','路线信息','船名航次','客户','时间要求','货物类型','货物重量','承运公司'],
        colModel:[
            //{name:'id',index:'id', width:'10%', align:'center' },
            {name:'taskStatus',index:'taskStatus',width:'85%',align:'center'},
            {name:'sysCode',index:'sysCode',align:'center',width:'100%',editable:true},	
            {name:'serviceType',index:'serviceType',align:"center",width:'50%'},
            {name:'containerNum',index:'containerNum',align:"center",width:'105%'},
            {name:'getCode',index:'getCode',align:"center", width:'120%'},
			{name:'pathInfo',index:'pathInfo',align:"center", width:'120%'},
			{name:'boatNum',index:'boatNum',align:"center", width:'120%'},
			{name:'customer',index:'customer',align:"center", width:'80%'},
			{name:'timeOfRequire',index:'timeOfRequire',align:"center",width:'100%'},
			{name:'cargoType',index:'cargoType',align:"center", width:'50%'},
			{name:'cargoWeight',index:'cargoWeight',align:"center", width:'60%'},
			{name:'carrier',index:'carrier',align:"center", width:'70%'}
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
			var rowdata = $("#taskStatus").jqGrid("getRowData",rowid); 
			var id=rowid+"_"+name; 
			if(name=="amt"){ 
				$("#"+id).keyup(function(e){ 
				var amt = $(this).val(); 
				var fee = rowdata["fee"]; 
				var total = parseFloat(amt) + parseFloat(fee); 
				$("#taskStatus").jqGrid("setRowData",rowid,{"total":total}); 
				}); 
			} 
		 },
        pager:$('#gridPager')
		,gridComplete:function(){
			
		}
    });
	var mydata = [
			{taskStatus:"<input type='text' class='btn btn-success radius' readOnly value='新建' style='width:85px;'/>",sysCode:"0000001_进口",serviceType:"外贸",containerNum:"CBHU8500452",getCode:"COSU611084040",pathInfo:"泉州-厦门码头",boatNum:"昌盛集7/007N",customer:"中远",timeOfRequire:"2015-09-10",cargoType:"普通",cargoWeight:"1000",carrier:"兆冠物流"},
			{taskStatus:"<input type='text' class='btn btn-success radius' readOnly value='新建' style='width:85px;'/>",sysCode:"0000002_进口",serviceType:"外贸",containerNum:"CBHU8501452",getCode:"ZOSU611084040",pathInfo:"海沧工厂-新海达",boatNum:"东成蓝天/021S",customer:"中远",timeOfRequire:"2015-09-02",cargoType:"普通",cargoWeight:"860",carrier:"兆冠物流"},
			{taskStatus:"<input type='text' class='btn btn-warning radius' readOnly value='已部分派车' style='width:85px;'/>",sysCode:"0000003",serviceType:"内贸",containerNum:"CBHU8500552",getCode:"HOSU611084040",pathInfo:"集美-厦门码头",boatNum:"金玉蓝湾/6#201",customer:"中海物流",timeOfRequire:"2015-09-03",cargoType:"普通",cargoWeight:"200",carrier:"兆冠物流"},
			];
	for(var i=0;i<=mydata.length;i++)
		jQuery("#taskStatus").jqGrid('addRowData',i+1,mydata[i]);
});