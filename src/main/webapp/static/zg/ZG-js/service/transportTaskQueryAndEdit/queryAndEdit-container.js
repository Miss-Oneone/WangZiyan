$(document).ready(function(){
    $("#queryAndEdit-container").jqGrid({
        //url:contextPath + "search.action",
        datatype:"json", //数据来源，本地数据
        mtype:"POST",//提交方式
        height:'auto',//高度，表格高度。可为数值、百分比或'auto'
        width:1150,//这个宽度不能为百分比
        //autowidth:true,//自动宽
		shrinkToFit:false,  
		autoScroll: true,  
        colNames:['系统单号', '任务状态', '业务类型', '客户/托运人', '船名航次', '要求时间', '码头', '是否集装箱', '集装箱数量', '已派车次数', '货物总重量', '已派车重量','已完成重量','超期信息'],
        colModel:[
            //{name:'id',index:'id', width:'10%', align:'center' },
            {name:'sysNum',index:'costType',width:'120%',align:'center'},
            {name:'missionState',index:'phoneNo',width:'90%',align:'center'},	
            {name:'serviceType',index:'currency',width:'50%',align:"center"},
            {name:'customer',index:'currency', width:'80%',align:"center"},
            {name:'boatNum',index:'currency', width:'120%',align:"center"},
            {name:'timeOfRequire',index:'currency',width:'100%',align:"center"},
            {name:'placeOfBoat',index:'currency', width:'100%',align:"center"},
            {name:'ifContainer',index:'currency',width:'30%',align:"center"},
            {name:'countOfContainer',index:'currency',width:'30%',align:"center"},
            {name:'countOfSend',index:'currency',width:'30%',align:"center"},
            {name:'totalWeight',index:'currency',width:'50%',align:"center"},
            {name:'weightOfSend',index:'currency',width:'30%',align:"center"},
			{name:'weightOfComplete',index:'currency',width:'30%',align:"center"},
			{name:'info',index:'currency',width:'190%',align:"center"}
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
			{sysNum:"<a href='container.html'>0000001_进口</a>",missionState:"<input type='text' class='btn btn-success radius' readOnly value='新建' style='width:85px;'/>",serviceType:"外贸",customer:"冠世外贸",boatNum:"昌盛集7/007N",timeOfRequire:"2015-09-10",placeOfBoat:"海天码头",ifContainer:"是",countOfContainer:"1",countOfSend:"0",totalWeight:"20",weightOfSend:"20",weightOfComplete:"0",info:""},
			{sysNum:"<a href='container.html'>0000002_出口</a>",missionState:"<input type='text' class='btn btn-danger radius' readOnly value='已发车' style='width:85px;'/>",serviceType:"外贸",customer:"中远外贸",boatNum:"东成蓝天/021S",timeOfRequire:"2015-09-02",placeOfBoat:"海沧新海达",ifContainer:"是",countOfContainer:"1",countOfSend:"1",totalWeight:"20",weightOfSend:"20",weightOfComplete:"0",info:""},
			{sysNum:"<a href='unContainer-taskQuery.html'>0000003</a>",missionState:"<input type='text' class='btn btn-warning radius' readOnly value='已部分派车' style='width:85px;'/>",serviceType:"内贸",customer:"中海物流",boatNum:"",timeOfRequire:"2015-09-03",placeOfBoat:"厦门码头",ifContainer:"否",countOfContainer:"",countOfSend:"2",totalWeight:"1000",weightOfSend:"80",weightOfComplete:"0",info:""},
			{sysNum:"<a href='unContainer-taskQuery.html'>0000004</a>",missionState:"<input type='text' class='btn btn-warning radius' readOnly value='已部分派车' style='width:85px;'/>",serviceType:"内贸",customer:"紫金矿业",boatNum:"",timeOfRequire:"",placeOfBoat:"海沧新海达",ifContainer:"否",countOfContainer:"无",countOfSend:"2",totalWeight:"1000",weightOfSend:"40",weightOfComplete:"40",info:"超期，预计到月底完"}
			];
	for(var i=0;i<=mydata.length;i++)
		jQuery("#queryAndEdit-container").jqGrid('addRowData',i+1,mydata[i]);
});