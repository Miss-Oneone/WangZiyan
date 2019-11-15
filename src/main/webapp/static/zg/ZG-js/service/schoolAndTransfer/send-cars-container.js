$(document).ready(function(){
    $("#send-cars-container").jqGrid({
        //url:contextPath + "search.action",
        datatype:"json", //������Դ����������
        mtype:"POST",//�ύ��ʽ
        height:200,//�߶ȣ����߶ȡ���Ϊ��ֵ���ٷֱȻ�'auto'
        width:1000,//�����Ȳ���Ϊ�ٷֱ�
        //autowidth:true,//�Զ���
		cellEdit:true, 
		cellsubmit:"clientArray",
        colNames:['ϵͳ����', '����״̬', '��װ���', '�ᵥ��', '·����Ϣ', '����', '�ͻ�', 'ʱ��Ҫ��', '��������', '��������', '���˹�˾', '�ύʱ��'],
        colModel:[
            {name:'systemCode',index:'systemCode', width:'10%',align:'center',formatter:"showlink",
                          formatoptions:{baseLinkUrl:"send-cars-container.html",target:"_self"},editable:true},
            {name:'taskStatus',index:'taskStatus', width:'9%',align:'center'},	
			{name:'containerNum',index:'containerNum', width:'9%',align:'center'},	
            {name:'billOfLading',index:'billOfLading', width:'9%', align:"center"},
			{name:'pathInfo',index:'pathInfo', width:'9%', align:"center"},
			{name:'airPath',index:'airPath', width:'9%', align:"center"},
			{name:'customer',index:'customer', width:'9%', align:"center"},
			{name:'timeRequest',index:'timeRequest', width:'9%', align:"center"},
			{name:'cargoType',index:'cargoType', width:'9%', align:"center"},
			{name:'cargoWeight',index:'cargoWeight', width:'9%', align:"center"},
			{name:'carrier',index:'carrier', width:'9%', align:"center"},
			{name:'subTime',index:'subTime', width:'9%', align:"center"}
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
			var rowdata = $("#costManagement").jqGrid("getRowData",rowid); 
			var id=rowid+"_"+name; 
			if(name=="amt"){ 
				$("#"+id).keyup(function(e){ 
				var amt = $(this).val(); 
				var fee = rowdata["fee"]; 
				var total = parseFloat(amt) + parseFloat(fee); 
				$("#send-cars-container").jqGrid("setRowData",rowid,{"total":total}); 
				}); 
			} 
		 },
        pager:$('#gridPager')
    });
	var mydata = [
			{systemCode:"xxxxxxxx",taskStatus:"",containerNum:"",billOfLading:"",pathInfo:"",airPath:"",customer:"",timeRequest:"",cargoType:"",cargoWeight:"",carrier:"",subTime:""},
			{systemCode:"xxxxxxxx",taskStatus:"",containerNum:"",billOfLading:"",pathInfo:"",airPath:"",customer:"",timeRequest:"",cargoType:"",cargoWeight:"",carrier:"",subTime:""},
			{systemCode:"xxxxxxxx",taskStatus:"",containerNum:"",billOfLading:"",pathInfo:"",airPath:"",customer:"",timeRequest:"",cargoType:"",cargoWeight:"",carrier:"",subTime:""},
			{systemCode:"xxxxxxxx",taskStatus:"",containerNum:"",billOfLading:"",pathInfo:"",airPath:"",customer:"",timeRequest:"",cargoType:"",cargoWeight:"",carrier:"",subTime:""},
			{systemCode:"xxxxxxxx",taskStatus:"",containerNum:"",billOfLading:"",pathInfo:"",airPath:"",customer:"",timeRequest:"",cargoType:"",cargoWeight:"",carrier:"",subTime:""},
			{systemCode:"xxxxxxxx",taskStatus:"",containerNum:"",billOfLading:"",pathInfo:"",airPath:"",customer:"",timeRequest:"",cargoType:"",cargoWeight:"",carrier:"",subTime:""},
			{systemCode:"xxxxxxxx",taskStatus:"",containerNum:"",billOfLading:"",pathInfo:"",airPath:"",customer:"",timeRequest:"",cargoType:"",cargoWeight:"",carrier:"",subTime:""},
			{systemCode:"xxxxxxxx",taskStatus:"",containerNum:"",billOfLading:"",pathInfo:"",airPath:"",customer:"",timeRequest:"",cargoType:"",cargoWeight:"",carrier:"",subTime:""},
			{systemCode:"xxxxxxxx",taskStatus:"",containerNum:"",billOfLading:"",pathInfo:"",airPath:"",customer:"",timeRequest:"",cargoType:"",cargoWeight:"",carrier:"",subTime:""},
			{systemCode:"xxxxxxxx",taskStatus:"",containerNum:"",billOfLading:"",pathInfo:"",airPath:"",customer:"",timeRequest:"",cargoType:"",cargoWeight:"",carrier:"",subTime:""},
			{systemCode:"xxxxxxxx",taskStatus:"",containerNum:"",billOfLading:"",pathInfo:"",airPath:"",customer:"",timeRequest:"",cargoType:"",cargoWeight:"",carrier:"",subTime:""},
			{systemCode:"xxxxxxxx",taskStatus:"",containerNum:"",billOfLading:"",pathInfo:"",airPath:"",customer:"",timeRequest:"",cargoType:"",cargoWeight:"",carrier:"",subTime:""},
			{systemCode:"xxxxxxxx",taskStatus:"",containerNum:"",billOfLading:"",pathInfo:"",airPath:"",customer:"",timeRequest:"",cargoType:"",cargoWeight:"",carrier:"",subTime:""},
			{systemCode:"xxxxxxxx",taskStatus:"",containerNum:"",billOfLading:"",pathInfo:"",airPath:"",customer:"",timeRequest:"",cargoType:"",cargoWeight:"",carrier:"",subTime:""},
			{systemCode:"xxxxxxxx",taskStatus:"",containerNum:"",billOfLading:"",pathInfo:"",airPath:"",customer:"",timeRequest:"",cargoType:"",cargoWeight:"",carrier:"",subTime:""},
			{systemCode:"xxxxxxxx",taskStatus:"",containerNum:"",billOfLading:"",pathInfo:"",airPath:"",customer:"",timeRequest:"",cargoType:"",cargoWeight:"",carrier:"",subTime:""},
			{systemCode:"xxxxxxxx",taskStatus:"",containerNum:"",billOfLading:"",pathInfo:"",airPath:"",customer:"",timeRequest:"",cargoType:"",cargoWeight:"",carrier:"",subTime:""}
			];
	for(var i=0;i<=mydata.length;i++)
		jQuery("#send-cars-container").jqGrid('addRowData',i+1,mydata[i]);
});