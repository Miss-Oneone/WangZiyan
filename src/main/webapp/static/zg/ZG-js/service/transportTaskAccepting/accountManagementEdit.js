$(document).ready(function(){
    $("#accountManagementEdit").jqGrid({
        //url:contextPath + "search.action",
        datatype:"json", //数据来源，本地数据
        mtype:"POST",//提交方式
        height:'auto',//高度，表格高度。可为数值、百分比或'auto'
        width:1000,//这个宽度不能为百分比
        //autowidth:true,//自动宽
		shrinkToFit:false,  
		autoScroll: true,  
		cellEdit:true, 
		cellsubmit:"clientArray",
        colNames:['费用类型', '费用单价', '数量', '金额', '司机代收', '应收操作人', '应收备注', '实收金额', '实收凭证1', '实收凭证2', '实收凭证3', '实收操作人', '实收备注'],
        colModel:[
            {name:'costType',index:'costType', align:'center',editable:true},
            {name:'unitPrice',index:'unitPrice', align:'center'},	
			{name:'count',index:'count', align:'center'},	
            {name:'amounts',index:'amounts', align:"center"},
			{name:'collectionOfDrivers',index:'collectionOfDrivers', align:"center"},
			{name:'accountsReceivable',index:'accountsReceivable', align:"center"},
			{name:'notesReceivable',index:'notesReceivable', align:"center"},
			{name:'realIncomeAmount',index:'realIncomeAmount', align:"center"},
			{name:'realEvidence1',index:'realEvidence1', align:"center"},
			{name:'realEvidence2',index:'realEvidence2', align:"center"},
			{name:'realEvidence3',index:'realEvidence3', align:"center"},
			{name:'realOperator',index:'realOperator', align:"center"},
			{name:'realCharge',index:'realCharge', align:"center"}
			
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
			var rowdata = $("#accountManagementEdit").jqGrid("getRowData",rowid); 
			var id=rowid+"_"+name; 
			if(name=="amt"){ 
				$("#"+id).keyup(function(e){ 
				var amt = $(this).val(); 
				var fee = rowdata["fee"]; 
				var total = parseFloat(amt) + parseFloat(fee); 
				$("#accountManagementEdit").jqGrid("setRowData",rowid,{"total":total}); 
				}); 
			} 
		 },
        pager:$('#gridPager')
    });
	var mydata = [
			{costType:"运费",unitPrice:"600",count:"1",amounts:"600",collectionOfDrivers:"否",accountsReceivable:"小蒋",notesReceivable:"",realIncomeAmount:"",realEvidence1:"如：榜单号",realEvidence2:"如：榜单号",realEvidence3:"如：榜单号",realOperator:"",realCharge:""},
			{costType:"路线变更差价",unitPrice:"400",count:"1",amounts:"400",collectionOfDrivers:"是",accountsReceivable:"小蒋",notesReceivable:"",realIncomeAmount:"",realEvidence1:"",realEvidence2:"",realEvidence3:"",realOperator:"",realCharge:""}
			];
	for(var i=0;i<=mydata.length;i++)
		jQuery("#accountManagementEdit").jqGrid('addRowData',i+1,mydata[i]);
	
	// $('#container').click(function() {
        // parent.containerFlag = $(this).is(":checked");
        
    // });
    // $('#container').prop("checked", parent.containerFlag);
    
    // $('#unContainer').click(function() {
        // parent.uncontainerFlag = $(this).is(":checked");
        
    // });
    // $('#unContainer').prop("checked", parent.uncontainerFlag);

});