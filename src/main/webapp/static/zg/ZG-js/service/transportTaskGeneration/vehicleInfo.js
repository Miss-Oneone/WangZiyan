$(document).ready(function(){
    $("#vehicleInfo").jqGrid({
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
        colNames:['车辆运输状态', '车牌号', '车架信息','载重量','停车地点','系统单号','集装箱号','路线信息','任务时间信息','司机','车架'],
        colModel:[
            //{name:'id',index:'id', width:'10%', align:'center' },
            {name:'taskStatus',index:'taskStatus',width:'115%',align:'center'},
            {name:'carsNum',index:'carsNum',align:'center',width:'90%'},	
            {name:'carsInfo',index:'carsInfo', align:"center",width:'60%'},
            {name:'load',index:'load', align:"center", width:'60%'},
            {name:'placeOfPark',index:'placeOfPark',align:"center",width:'90%',},
			{name:'sysCode',index:'sysCode',align:"center", width:'120%'},
			{name:'containerNum',index:'containerNum',align:"center",width:'120%'},
			{name:'pathInfo',index:'pathInfo',align:"center",width:'120%'},
			{name:'timeOfTask',index:'timeOfTask',align:"center", width:'130%'},
			{name:'driver',index:'driver',align:"center",width:'70%'},
			{name:'frame',index:'frame',align:"center", width:'90%'}
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
			var rowdata = $("#vehicleInfo").jqGrid("getRowData",rowid); 
			var id=rowid+"_"+name; 
			if(name=="amt"){ 
				$("#"+id).keyup(function(e){ 
				var amt = $(this).val(); 
				var fee = rowdata["fee"]; 
				var total = parseFloat(amt) + parseFloat(fee); 
				$("#vehicleInfo").jqGrid("setRowData",rowid,{"total":total}); 
				}); 
			} 
		 },
        pager:$('#gridPager')
		,gridComplete:function(){
			
		}
    });
	var mydata = [
			{taskStatus:"<input type='text' class='btn btn-success radius' readOnly value='空闲' style='width:115px;'/>",carsNum:"闽D 66703",carsInfo:"小架",load:"20尺",placeOfPark:"岛内车场",sysCode:"",containerNum:"",pathInfo:"",timeOfTask:"",driver:"沈阳",frame:"闽DM797挂"},
			{taskStatus:"<input type='text' class='btn btn-success radius' readOnly value='空闲' style='width:115px;'/>",carsNum:"闽D 66706",carsInfo:"自卸",load:"20尺",placeOfPark:"岛内车场",sysCode:"",containerNum:"",pathInfo:"",timeOfTask:"",driver:"芦金友",frame:"闽DQ605挂"},
			{taskStatus:"<input type='text' class='btn btn-success radius' readOnly value='空闲' style='width:115px;'/>",carsNum:"闽D 57525",carsInfo:"二轴",load:"40尺",placeOfPark:"海沧车场",sysCode:"",containerNum:"",pathInfo:"",timeOfTask:"",driver:"王金义",frame:"闽DL076挂"},
			{taskStatus:"<input type='text' class='btn btn-danger radius' readOnly value='使用中-到场卸货' style='width:115px;'/>",carsNum:"闽D B0025",carsInfo:"三轴",load:"40尺",placeOfPark:"",sysCode:"0000005_出口",containerNum:"CBHU8501415",pathInfo:"海沧工厂-新海达",timeOfTask:"2015-09-01 11:00",driver:"催海江",frame:"闽DC901挂"},
			{taskStatus:"<input type='text' class='btn btn-danger radius' readOnly value='使用中-已到场' style='width:115px;'/>",carsNum:"闽D 66702",carsInfo:"小架",load:"20尺",placeOfPark:"",sysCode:"0000014_进口",containerNum:"CBHU8500412",pathInfo:"泉州-厦门码头",timeOfTask:"2015-09-01 10:00",driver:"范前进",frame:"闽DN097挂"},
			{taskStatus:"<input type='text' class='btn btn-danger radius' readOnly value='使用中-已发车' style='width:115px;'/>",carsNum:"闽D 55092",carsInfo:"小架",load:"20尺",placeOfPark:"",sysCode:"0000003",containerNum:"CBHU8500552",pathInfo:"集美-厦门码头",timeOfTask:"2015-09-01 09:30",driver:"余因海",frame:"闽DQ572挂"}
			];
	for(var i=0;i<=mydata.length;i++)
		jQuery("#vehicleInfo").jqGrid('addRowData',i+1,mydata[i]);
});