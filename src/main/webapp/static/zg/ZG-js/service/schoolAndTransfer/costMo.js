$(document).ready(function(){
    $("#costMo").jqGrid({
        //url:contextPath + "search.action",
        datatype:"json", //数据来源，本地数据
        mtype:"POST",//提交方式
        height:'auto',//高度，表格高度。可为数值、百分比或'auto'
        width:600,//这个宽度不能为百分比
        //autowidth:true,//自动宽
        colNames:['费用类型', '费用单价', '数量','金额','备注'],
        colModel:[
            //{name:'id',index:'id', width:'10%', align:'center' },
            {name:'a',index:'a',align:'center'},
            {name:'b',index:'b',align:'center'},	
            {name:'c',index:'c',align:"center"},
			{name:'d',index:'d',align:"center"},
			{name:'e',index:'e',align:"center"}
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
			{a:"高速费1级-10t以下",b:"10",c:"1",d:"10",e:""},
			{a:"高速费2级-20t以下",b:"20",c:"1",d:"20",e:""},
			{a:"高速费1级-10t以下-减免",b:"5",c:"1",d:"5",e:"蔬菜减免"}
			];
	for(var i=0;i<=mydata.length;i++)
		jQuery("#costMo").jqGrid('addRowData',i+1,mydata[i]);
});