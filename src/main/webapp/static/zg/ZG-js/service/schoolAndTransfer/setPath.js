$(document).ready(function(){
    $("#setPath").jqGrid({
        //url:contextPath + "search.action",
        datatype:"json", //数据来源，本地数据
        mtype:"POST",//提交方式
        height:'auto',//高度，表格高度。可为数值、百分比或'auto'
        //width:1000,//这个宽度不能为百分比
        autowidth:true,//自动宽
		shrinkToFit:false,  
		autoScroll: true,
        colNames:['代码', '出发地代码', '目的地','路线简称','车牌号','公里数','百公里油耗','载重类别','公里数-调度指定','百公里油耗-调度指定','备注-调度指定'],
        colModel:[
            //{name:'id',index:'id', width:'10%', align:'center' },
            {name:'code',index:'code',align:'center'},
            {name:'start',index:'start',align:'center'},	
            {name:'arrive',index:'arrive', align:"center"},
			{name:'path',index:'path', align:"center"},
			{name:'carCode',index:'carCode', align:"center"},
			{name:'kilometers',index:'kilometers', align:"center"},
			{name:'fuelConsumption',index:'fuelConsumption', align:"center"},
			{name:'loadCategory',index:'loadCategory', align:"center"},
			{name:'kilometers1',index:'kilometers1', align:"center"},
			{name:'fuelConsumption1',index:'fuelConsumption1', align:"center"},
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
        pager:$('#gridPager')
    });
	var mydata = [
			{code:"01",start:"厦门",arrive:"泉州",path:"厦门-泉州线",carCode:"闽D678A",kilometers:"200",fuelConsumption:"32",loadCategory:"重车",kilometers1:"200",fuelConsumption1:"32",remarks:""},
			{code:"02",start:"厦门",arrive:"泉州",path:"厦门-泉州线",carCode:"闽D678A",kilometers:"200",fuelConsumption:"30",loadCategory:"轻车",kilometers1:"200",fuelConsumption1:"30",remarks:""},
			{code:"",start:"",arrive:"",path:"",carCode:"",kilometers:"",fuelConsumption:"",loadCategory:"起车",kilometers1:"-30",fuelConsumption1:"30",remarks:"新手"},
			];
	for(var i=0;i<=mydata.length;i++)
		jQuery("#setPath").jqGrid('addRowData',i+1,mydata[i]);
});