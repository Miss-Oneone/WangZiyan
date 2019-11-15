$(document).ready(function(){
    $("#sending-cars-1").jqGrid({
        //url:contextPath + "search.action",
        datatype:"json", //数据来源，本地数据
        mtype:"POST",//提交方式
        height:500,//高度，表格高度。可为数值、百分比或'auto'
        width:680,//这个宽度不能为百分比
        //autowidth:true,//自动宽
		shrinkToFit:false,  
		autoScroll: true,
		multiselect: true,
        colNames:['车牌号','位置','早','6','7','8','9','10','11','12','13','14','15','16','17','18','19','晚'],
        colModel:[
            //{name:'id',index:'id', width:'10%', align:'center' },
            //{name:'choose',index:'choose',width:'40%',align:'center',formatter: "checkbox",formatoptions:{disabled:false}},
            {name:'carCode',index:'carCode',width:'97%',align:'center',
				cellattr: function(rowId, value, rowObject, colModel, arrData) {
					if(Number(rowId)==1){
						 return "";
					}else if(Number(rowId)==2){
						 return "rowspan='2'";
					}else if(Number(rowId)==3){
						 return " style=display:none; ";
					}else if(Number(rowId)==4){
						 return "";
					}
				}
			},	
            {name:'location',index:'location',align:"center",width:'50%',
				cellattr: function(rowId, value, rowObject, colModel, arrData) {
					if(Number(rowId)==1){
						 return "";
					}else if(Number(rowId)==2){
						 return "rowspan='2'";
					}else if(Number(rowId)==3){
						 return " style=display:none; ";
					}else if(Number(rowId)==4){
						 return "";
					}
				}
			},
			{name:'morning',index:'morning',align:"center",width:'25%',
				cellattr: function(rowId, value, rowObject, colModel, arrData) {
					if(Number(rowId)==1){
						 return "";
					}else if(Number(rowId)==2){
						 return "";
					}else if(Number(rowId)==3){
						 return "";
					}else if(Number(rowId)==4){
						 return "";
					}
				}
			},
			{name:'hour6',index:'hour6',align:"center",width:'25%',
				cellattr: function(rowId, value, rowObject, colModel, arrData) {
					if(Number(rowId)==1){
						return ' colspan=7';
					}else if(Number(rowId)==2){
						 return "";
					}else if(Number(rowId)==3){
						 return "";
					}else if(Number(rowId)==4){
						 return "";
					}
				}
			},
			{name:'hour7',index:'hour7',align:"center",width:'25%',
				cellattr: function(rowId, value, rowObject, colModel, arrData) {
					if(Number(rowId)==1){
						 return " style=display:none; ";
					}else if(Number(rowId)==2){
						 return "";
					}else if(Number(rowId)==3){
						 return "";
					}else if(Number(rowId)==4){
						 return ' colspan=4';
					}
				}
			},
			{name:'hour8',index:'hour8',align:"center",width:'25%',
				cellattr: function(rowId, value, rowObject, colModel, arrData) {
					if(Number(rowId)==1){
						 return " style=display:none; ";
					}else if(Number(rowId)==2){
						 return ' colspan=11';
					}else if(Number(rowId)==3){
						 return ' colspan=12';
					}else if(Number(rowId)==4){
						 return " style=display:none; ";
					}
				}
			},
			{name:'hour9',index:'hour9',align:"center",width:'25%',
				cellattr: function(rowId, value, rowObject, colModel, arrData) {
					if(Number(rowId)==1){
						 return " style=display:none; ";
					}else if(Number(rowId)==2){
						return " style=display:none; ";
					}else if(Number(rowId)==3){
						return " style=display:none; ";
					}else if(Number(rowId)==4){
						 return " style=display:none; ";
					}
				}
			},
			{name:'hour10',index:'hour10',align:"center",width:'25%',
				cellattr: function(rowId, value, rowObject, colModel, arrData) {
					if(Number(rowId)==1){
						 return " style=display:none; ";
					}else if(Number(rowId)==2){
						return " style=display:none; ";
					}else if(Number(rowId)==3){
						return " style=display:none; ";
					}else if(Number(rowId)==4){
						return " style=display:none; ";
					}
				}
			},
			{name:'hour11',index:'hour11',align:"center",width:'25%',
				cellattr: function(rowId, value, rowObject, colModel, arrData) {
					if(Number(rowId)==1){
						 return " style=display:none; ";
					}else if(Number(rowId)==2){
						return " style=display:none; ";
					}else if(Number(rowId)==3){
						return " style=display:none; ";
					}else if(Number(rowId)==4){
						 return ' colspan=5';
					}
				}
			},
			{name:'hour12',index:'hour12',align:"center",width:'25%',
				cellattr: function(rowId, value, rowObject, colModel, arrData) {
					if(Number(rowId)==1){
						 return " style=display:none; ";
					}else if(Number(rowId)==2){
						return " style=display:none; ";
					}else if(Number(rowId)==3){
						return " style=display:none; ";
					}else if(Number(rowId)==4){
						return " style=display:none; ";
					}
				}
			},
			{name:'hour13',index:'hour13',align:"center",width:'25%',
				cellattr: function(rowId, value, rowObject, colModel, arrData) {
					if(Number(rowId)==1){
						 return "";
					}else if(Number(rowId)==2){
						return " style=display:none; ";
					}else if(Number(rowId)==3){
						return " style=display:none; ";
					}else if(Number(rowId)==4){
						return " style=display:none; ";
					}
				}
			},
			{name:'hour14',index:'hour14',align:"center",width:'25%',
				cellattr: function(rowId, value, rowObject, colModel, arrData) {
					if(Number(rowId)==1){
						 return "";
					}else if(Number(rowId)==2){
						return " style=display:none; ";
					}else if(Number(rowId)==3){
						return " style=display:none; ";
					}else if(Number(rowId)==4){
						return " style=display:none; ";
					}
				}
			},
			{name:'hour15',index:'hour15',align:"center",width:'25%',
				cellattr: function(rowId, value, rowObject, colModel, arrData) {
					if(Number(rowId)==1){
						 return "";
					}else if(Number(rowId)==2){
						return " style=display:none; ";
					}else if(Number(rowId)==3){
						return " style=display:none; ";
					}else if(Number(rowId)==4){
						return " style=display:none; ";
					}
				}
			},
			{name:'hour16',index:'hour16',align:"center",width:'25%',
				cellattr: function(rowId, value, rowObject, colModel, arrData) {
					if(Number(rowId)==1){
						 return " colspan='5' ";
					}else if(Number(rowId)==2){
						return " style=display:none; ";
					}else if(Number(rowId)==3){
						return " style=display:none; ";
					}else if(Number(rowId)==4){
						return ' colspan=4';
					}
				}
			},
			{name:'hour17',index:'hour17',align:"center",width:'25%',
				cellattr: function(rowId, value, rowObject, colModel, arrData) {
					if(Number(rowId)==1){
						 return " style=display:none; ";
					}else if(Number(rowId)==2){
						return " style=display:none; ";
					}else if(Number(rowId)==3){
						return " style=display:none; ";
					}else if(Number(rowId)==4){
						return " style=display:none; ";
					}
				}
			},
			{name:'hour18',index:'hour18',align:"center",width:'25%',
				cellattr: function(rowId, value, rowObject, colModel, arrData) {
					if(Number(rowId)==1){
						 return " style=display:none; ";
					}else if(Number(rowId)==2){
						return " style=display:none; ";
					}else if(Number(rowId)==3){
						return " style=display:none; ";
					}else if(Number(rowId)==4){
						return " style=display:none; ";
					}
				}
			},
			{name:'hour19',index:'hour19',align:"center",width:'25%',
				cellattr: function(rowId, value, rowObject, colModel, arrData) {
					if(Number(rowId)==1){
						 return " style=display:none; ";
					}else if(Number(rowId)==2){
						return "";
					}else if(Number(rowId)==3){
						return " style=display:none; ";
					}else if(Number(rowId)==4){
						return " style=display:none; ";
					}
				}
			},
			{name:'night',index:'night',align:"center",width:'25%',
				cellattr: function(rowId, value, rowObject, colModel, arrData) {
					if(Number(rowId)==1){
						 return " style=display:none; ";
					}else if(Number(rowId)==2){
						return "";
					}else if(Number(rowId)==3){
						return "";
					}else if(Number(rowId)==4){
						return "";
					}
				}
			}
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
			{carCode:"闽D39561<br/>已到场装货",location:"位置",morning:"",hour6:"外贸出口；#箱号#；40GP；提-海投老场->装-晋江东石镇塔头刘工业区(福建雨丝梦洋伞)->卸-新海达码头",hour7:"",hour8:"",hour9:"",hour10:"",hour11:"",hour12:"",hour13:"",hour14:"",hour15:"",hour16:"外贸进口；#箱号#；40GP；提-海天码头->卸-思明区软件园二期观日路56号101",hour17:"",hour18:"",hour19:"",night:""},
			{carCode:"闽D55092<br/>已领箱",location:"位置",morning:"",hour6:"",hour7:"",hour8:"内贸；#箱号#；20GP；提-欣海天货柜->装-翔鹭海沧->卸-漳州AAAA",hour9:"",hour10:"",hour11:"",hour12:"",hour13:"",hour14:"",hour15:"",hour16:"",hour17:"",hour18:"",hour19:"",night:""},
			{carCode:"",location:"",morning:"",hour6:"",hour7:"",hour8:"内贸；#箱号#；20GP；提-欣海天货柜->装-翔鹭海沧->卸-漳州BBBB",hour9:"",hour10:"",hour11:"",hour12:"",hour13:"",hour14:"",hour15:"",hour16:"",hour17:"",hour18:"",hour19:"",night:""},
			{carCode:"闽DB0017<br/>到场卸货",location:"位置",morning:"",hour6:"",hour7:"外贸出口；#箱号#；40GP；提-海投老场->装-XXX->卸-新海达码头",hour8:"",hour9:"",hour10:"",hour11:"外贸出口；#箱号#；40GP；提-海投老场->装-XXX->卸-新海达码头",hour12:"",hour13:"",hour14:"",hour15:"",hour16:"外贸出口；#箱号#；40GP；提-海投老场->装-XXX->卸-新海达码头",hour17:"",hour18:"",hour19:"",night:""},
			{carCode:"闽DB0025<br/>空闲",location:"",morning:"",hour6:"",hour7:"",hour8:"",hour9:"",hour10:"",hour11:"",hour12:"",hour13:"",hour14:"",hour15:"",hour16:"",hour17:"",hour18:"",hour19:"",night:""},
			{carCode:"闽D55627<br/>空闲",location:"",morning:"",hour6:"",hour7:"",hour8:"",hour9:"",hour10:"",hour11:"",hour12:"",hour13:"",hour14:"",hour15:"",hour16:"",hour17:"",hour18:"",hour19:"",night:""},
			{carCode:"闽D57525<br/>空闲",location:"",morning:"",hour6:"",hour7:"",hour8:"",hour9:"",hour10:"",hour11:"",hour12:"",hour13:"",hour14:"",hour15:"",hour16:"",hour17:"",hour18:"",hour19:"",night:""},
			{carCode:"闽D57526<br/>空闲",location:"",morning:"",hour6:"",hour7:"",hour8:"",hour9:"",hour10:"",hour11:"",hour12:"",hour13:"",hour14:"",hour15:"",hour16:"",hour17:"",hour18:"",hour19:"",night:""},
			{carCode:"闽D57500<br/>空闲",location:"",morning:"",hour6:"",hour7:"",hour8:"",hour9:"",hour10:"",hour11:"",hour12:"",hour13:"",hour14:"",hour15:"",hour16:"",hour17:"",hour18:"",hour19:"",night:""},
			{carCode:"闽D57586<br/>空闲",location:"",morning:"",hour6:"",hour7:"",hour8:"",hour9:"",hour10:"",hour11:"",hour12:"",hour13:"",hour14:"",hour15:"",hour16:"",hour17:"",hour18:"",hour19:"",night:""},
			{carCode:"闽D57506<br/>空闲",location:"",morning:"",hour6:"",hour7:"",hour8:"",hour9:"",hour10:"",hour11:"",hour12:"",hour13:"",hour14:"",hour15:"",hour16:"",hour17:"",hour18:"",hour19:"",night:""},
			{carCode:"闽D57536<br/>空闲",location:"",morning:"",hour6:"",hour7:"",hour8:"",hour9:"",hour10:"",hour11:"",hour12:"",hour13:"",hour14:"",hour15:"",hour16:"",hour17:"",hour18:"",hour19:"",night:""},
			{carCode:"闽D57576<br/>空闲",location:"",morning:"",hour6:"",hour7:"",hour8:"",hour9:"",hour10:"",hour11:"",hour12:"",hour13:"",hour14:"",hour15:"",hour16:"",hour17:"",hour18:"",hour19:"",night:""},
			{carCode:"闽D57550<br/>空闲",location:"",morning:"",hour6:"",hour7:"",hour8:"",hour9:"",hour10:"",hour11:"",hour12:"",hour13:"",hour14:"",hour15:"",hour16:"",hour17:"",hour18:"",hour19:"",night:""},
			{carCode:"闽D57596<br/>空闲",location:"",morning:"",hour6:"",hour7:"",hour8:"",hour9:"",hour10:"",hour11:"",hour12:"",hour13:"",hour14:"",hour15:"",hour16:"",hour17:"",hour18:"",hour19:"",night:""},
			{carCode:"闽D58556<br/>空闲",location:"",morning:"",hour6:"",hour7:"",hour8:"",hour9:"",hour10:"",hour11:"",hour12:"",hour13:"",hour14:"",hour15:"",hour16:"",hour17:"",hour18:"",hour19:"",night:""},
			{carCode:"",location:"",morning:"",hour6:"",hour7:"",hour8:"",hour9:"",hour10:"",hour11:"",hour12:"",hour13:"",hour14:"",hour15:"",hour16:"",hour17:"",hour18:"",hour19:"",night:""},
			{carCode:"",location:"",morning:"",hour6:"",hour7:"",hour8:"",hour9:"",hour10:"",hour11:"",hour12:"",hour13:"",hour14:"",hour15:"",hour16:"",hour17:"",hour18:"",hour19:"",night:""},
			{carCode:"",location:"",morning:"",hour6:"",hour7:"",hour8:"",hour9:"",hour10:"",hour11:"",hour12:"",hour13:"",hour14:"",hour15:"",hour16:"",hour17:"",hour18:"",hour19:"",night:""},
			{carCode:"",location:"",morning:"",hour6:"",hour7:"",hour8:"",hour9:"",hour10:"",hour11:"",hour12:"",hour13:"",hour14:"",hour15:"",hour16:"",hour17:"",hour18:"",hour19:"",night:""}
			];
	for(var i=0;i<=mydata.length;i++)
		jQuery("#sending-cars-1").jqGrid('addRowData',i+1,mydata[i]);
});
