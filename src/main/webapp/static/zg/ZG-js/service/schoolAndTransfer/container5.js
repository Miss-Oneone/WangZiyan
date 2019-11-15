$(document).ready(function(){
    $("#container5").jqGrid({
        //url:contextPath + "search.action",
        datatype:"json", //数据来源，本地数据
        mtype:"POST",//提交方式
        height:70,//高度，表格高度。可为数值、百分比或'auto'
        //width:1000,//这个宽度不能为百分比
        autowidth:true,//自动宽
        colNames:['费用类型','费用单价','数量','金额','备注'],
        colModel:[
            //{name:'id',index:'id', width:'10%', align:'center' },
            {name:'costType',index:'costType', width:'3%',align:'center'},
            {name:'price',index:'price', width:'3%',align:'center'},	
            {name:'number',index:'number', width:'3%', align:"center"},
            {name:'cost',index:'cost', width:'3%', align:"center"},
            {name:'remarks',index:'remarks', width:'3%', align:"center"}
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
            {costType:"高速费1级-10t以下",price:"10",number:"1",cost:"10",remarks:""},
            {costType:"高速费2级-20t以下",price:"20",number:"1",cost:"20",remarks:""},
            {costType:"高速费1级-10t以下-减免",price:"5",number:"1",cost:"5",remarks:"蔬菜减免"}
			];
	for(var i=0;i<=mydata.length;i++)
		jQuery("#container5").jqGrid('addRowData',i+1,mydata[i]);
});