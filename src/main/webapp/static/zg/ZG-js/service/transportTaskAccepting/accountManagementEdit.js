$(document).ready(function(){
    $("#accountManagementEdit").jqGrid({
        //url:contextPath + "search.action",
        datatype:"json", //������Դ����������
        mtype:"POST",//�ύ��ʽ
        height:'auto',//�߶ȣ����߶ȡ���Ϊ��ֵ���ٷֱȻ�'auto'
        width:1000,//�����Ȳ���Ϊ�ٷֱ�
        //autowidth:true,//�Զ���
		shrinkToFit:false,  
		autoScroll: true,  
		cellEdit:true, 
		cellsubmit:"clientArray",
        colNames:['��������', '���õ���', '����', '���', '˾������', 'Ӧ�ղ�����', 'Ӧ�ձ�ע', 'ʵ�ս��', 'ʵ��ƾ֤1', 'ʵ��ƾ֤2', 'ʵ��ƾ֤3', 'ʵ�ղ�����', 'ʵ�ձ�ע'],
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
        rownumbers:true,//�������к�
        //altRows:true,//����Ϊ�����б��,Ĭ��Ϊfalse
        //sortname:'createDate',
        //sortorder:'asc',
        viewrecords: true,//�Ƿ��������������ʾ��¼����
        rowNum:15,//ÿҳ��ʾ��¼��
        rowList:[15,20,25],//���ڸı���ʾ�����������б���Ԫ�����顣
        jsonReader:{
            id: "blackId",//���÷��ز����У����ID������ΪblackId
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
			{costType:"�˷�",unitPrice:"600",count:"1",amounts:"600",collectionOfDrivers:"��",accountsReceivable:"С��",notesReceivable:"",realIncomeAmount:"",realEvidence1:"�磺�񵥺�",realEvidence2:"�磺�񵥺�",realEvidence3:"�磺�񵥺�",realOperator:"",realCharge:""},
			{costType:"·�߱�����",unitPrice:"400",count:"1",amounts:"400",collectionOfDrivers:"��",accountsReceivable:"С��",notesReceivable:"",realIncomeAmount:"",realEvidence1:"",realEvidence2:"",realEvidence3:"",realOperator:"",realCharge:""}
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