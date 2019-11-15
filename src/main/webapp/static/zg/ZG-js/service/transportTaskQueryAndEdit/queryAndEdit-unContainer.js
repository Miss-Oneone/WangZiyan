$(document).ready(function(){
    $("#queryAndEdit-unContainer").jqGrid({
        //url:contextPath + "search.action",
        datatype:"json", //数据来源，本地数据
        mtype:"POST",//提交方式
        height:'auto',//高度，表格高度。可为数值、百分比或'auto'
        width:1000,//这个宽度不能为百分比
        //autowidth:true,//自动宽
		shrinkToFit:false,  
		autoScroll: true,  
        colNames:['系统单号', '任务状态', '集装箱号', '提单号', '路线信息', '航线', '客户', '时间要求', '货物类型', '货物重量', '承运公司', '提交时间'],
        colModel:[
            //{name:'id',index:'id', width:'10%', align:'center' },
            {name:'sysNum',index:'costType',align:'center', formatter:"showlink",
                          formatoptions:{baseLinkUrl:"unContainer-taskQuery.html",target:"_self"},editable:true},
            {name:'missionState',index:'phoneNo',align:'center'},	
            {name:'containerNum',index:'currency',align:"center"},
            {name:'ladbillNum',index:'currency',align:"center"},
            {name:'routeMessage',index:'currency',align:"center"},
            {name:'route',index:'currency',align:"center"},
            {name:'client',index:'currency',align:"center"},
            {name:'timeRequire',index:'currency', align:"center"},
            {name:'goodsType',index:'currency', align:"center"},
            {name:'goodsWeight',index:'currency',align:"center"},
            {name:'shipCompany',index:'currency',align:"center"},
            {name:'subTime',index:'currency',align:"center"}
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
			{sysNum:"XXXXXX",missionState:"",containerNum:"",ladbillNum:"",routeMessage:"",route:"",client:"",timeRequire:"",goodsType:"",goodsWeight:"",shipCompany:"",subTime:""},
			{sysNum:"XXXXXX",missionState:"",containerNum:"",ladbillNum:"",routeMessage:"",route:"",client:"",timeRequire:"",goodsType:"",goodsWeight:"",shipCompany:"",subTime:""},
			{sysNum:"XXXXXX",missionState:"",containerNum:"",ladbillNum:"",routeMessage:"",route:"",client:"",timeRequire:"",goodsType:"",goodsWeight:"",shipCompany:"",subTime:""},
			{sysNum:"XXXXXX",missionState:"",containerNum:"",ladbillNum:"",routeMessage:"",route:"",client:"",timeRequire:"",goodsType:"",goodsWeight:"",shipCompany:"",subTime:""},
			{sysNum:"XXXXXX",missionState:"",containerNum:"",ladbillNum:"",routeMessage:"",route:"",client:"",timeRequire:"",goodsType:"",goodsWeight:"",shipCompany:"",subTime:""},
			{sysNum:"XXXXXX",missionState:"",containerNum:"",ladbillNum:"",routeMessage:"",route:"",client:"",timeRequire:"",goodsType:"",goodsWeight:"",shipCompany:"",subTime:""},
			{sysNum:"XXXXXX",missionState:"",containerNum:"",ladbillNum:"",routeMessage:"",route:"",client:"",timeRequire:"",goodsType:"",goodsWeight:"",shipCompany:"",subTime:""},
			{sysNum:"XXXXXX",missionState:"",containerNum:"",ladbillNum:"",routeMessage:"",route:"",client:"",timeRequire:"",goodsType:"",goodsWeight:"",shipCompany:"",subTime:""}
			];
	for(var i=0;i<=mydata.length;i++)
		jQuery("#queryAndEdit-unContainer").jqGrid('addRowData',i+1,mydata[i]);
});