$(document).ready(function(){
    $("#sum").jqGrid({
        //url:contextPath + "search.action",
        datatype:"json", //数据来源，本地数据
        mtype:"POST",//提交方式
        height:'auto',//高度，表格高度。可为数值、百分比或'auto'
        width:300,//这个宽度不能为百分比
        //autowidth:true,//自动宽
        colNames:['载重类别', '公里数', '百公里油耗','油耗合计'],
        colModel:[
            //{name:'id',index:'id', width:'10%', align:'center' },
            {name:'a',index:'a', width:'3%',align:'center'},
            {name:'b',index:'b', width:'3%',align:'center'},	
            {name:'c',index:'c', width:'3%', align:"center"},
			{name:'d',index:'d', width:'3%', align:"center"}
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
			{a:"重车",b:"200",c:"32",d:"64"},
			{a:"轻车",b:"170",c:"30",d:"51"},
			];
	for(var i=0;i<=mydata.length;i++)
		jQuery("#sum").jqGrid('addRowData',i+1,mydata[i]);
});