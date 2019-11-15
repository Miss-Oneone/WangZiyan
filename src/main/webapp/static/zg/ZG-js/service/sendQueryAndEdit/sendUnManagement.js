$(document).ready(function(){
    $("#sendUnManagement").jqGrid({
        //url:contextPath + "search.action",
        datatype:"json", //������Դ����������
        mtype:"POST",//�ύ��ʽ
        height:180,//�߶ȣ����߶ȡ���Ϊ��ֵ���ٷֱȻ�'auto'
        width:1000,//�����Ȳ���Ϊ�ٷֱ�
        //autowidth:true,//�Զ���
		cellEdit:true, 
		cellsubmit:"clientArray",
        colNames:['ϵͳ����', '״̬', '���˳���', '���ƺ�', '˾��', '��������', '��������', 'ҵ������', '���', '�ᵥ��', '��װ��ߴ�', '������','��������','��������','����ص�','����ʱ��','װ���ص�','װ������ʱ��','ж���ص�','ж������ʱ��','����ѳ�'],
        colModel:[
            {name:'A',index:'A', width:'20%',align:'center',formatter:"showlink",
                          formatoptions:{baseLinkUrl:"send-unContainer.html",target:"_self"},editable:true},
            {name:'B',index:'B', width:'15%',align:'center'},	
			{name:'C',index:'C', width:'15%',align:'center'},	
            {name:'D',index:'D', width:'15%', align:"center"},
			{name:'E',index:'E', width:'15%', align:"center"},
			{name:'F',index:'F', width:'15%', align:"center"},
			{name:'G',index:'G', width:'15%', align:"center"},
			{name:'H',index:'H', width:'15%', align:"center"},
			{name:'I',index:'I', width:'15%', align:"center"},
			{name:'J',index:'J', width:'15%', align:"center"},
			{name:'K',index:'K', width:'15%', align:"center"},
			{name:'L',index:'L', width:'15%', align:"center"},
			{name:'M',index:'M', width:'15%', align:"center"},
			{name:'N',index:'N', width:'15%', align:"center"},
			{name:'O',index:'O', width:'15%', align:"center"},
			{name:'P',index:'P', width:'15%', align:"center"},
			{name:'Q',index:'Q', width:'15%', align:"center"},
			{name:'R',index:'R', width:'15%', align:"center"},
			{name:'S',index:'S', width:'15%', align:"center"},
			{name:'T',index:'T', width:'15%', align:"center"},
			{name:'U',index:'U', width:'15%', align:"center"}
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
			var rowdata = $("#sendUnManagement").jqGrid("getRowData",rowid); 
			var id=rowid+"_"+name; 
			if(name=="amt"){ 
				$("#"+id).keyup(function(e){ 
				var amt = $(this).val(); 
				var fee = rowdata["fee"]; 
				var total = parseFloat(amt) + parseFloat(fee); 
				$("#sendUnManagement").jqGrid("setRowData",rowid,{"total":total}); 
				}); 
			} 
		 },
        pager:$('#gridPager')
    });
	var mydata = [
			{A:"xxxxxxxx",B:"",C:"",D:"",E:"",F:"",G:"",H:"",I:"",J:"",K:"",L:"",M:"",N:"",O:"",P:"",Q:"",R:"",S:"",T:"",U:""},
			{A:"xxxxxxxx",B:"",C:"",D:"",E:"",F:"",G:"",H:"",I:"",J:"",K:"",L:"",M:"",N:"",O:"",P:"",Q:"",R:"",S:"",T:"",U:""},
			{A:"xxxxxxxx",B:"",C:"",D:"",E:"",F:"",G:"",H:"",I:"",J:"",K:"",L:"",M:"",N:"",O:"",P:"",Q:"",R:"",S:"",T:"",U:""},
			{A:"xxxxxxxx",B:"",C:"",D:"",E:"",F:"",G:"",H:"",I:"",J:"",K:"",L:"",M:"",N:"",O:"",P:"",Q:"",R:"",S:"",T:"",U:""},
			{A:"xxxxxxxx",B:"",C:"",D:"",E:"",F:"",G:"",H:"",I:"",J:"",K:"",L:"",M:"",N:"",O:"",P:"",Q:"",R:"",S:"",T:"",U:""},
			{A:"xxxxxxxx",B:"",C:"",D:"",E:"",F:"",G:"",H:"",I:"",J:"",K:"",L:"",M:"",N:"",O:"",P:"",Q:"",R:"",S:"",T:"",U:""},
			{A:"xxxxxxxx",B:"",C:"",D:"",E:"",F:"",G:"",H:"",I:"",J:"",K:"",L:"",M:"",N:"",O:"",P:"",Q:"",R:"",S:"",T:"",U:""},
			{A:"xxxxxxxx",B:"",C:"",D:"",E:"",F:"",G:"",H:"",I:"",J:"",K:"",L:"",M:"",N:"",O:"",P:"",Q:"",R:"",S:"",T:"",U:""}
			];
	for(var i=0;i<=mydata.length;i++)
		jQuery("#sendUnManagement").jqGrid('addRowData',i+1,mydata[i]);
});