$(document).ready(function(){
    $("#moreDetail-queryAndEdit").jqGrid({
        //url:contextPath + "search.action",
        datatype:"json", //������Դ����������
        mtype:"POST",//�ύ��ʽ
        height:80,//�߶ȣ����߶ȡ���Ϊ��ֵ���ٷֱȻ�'auto'
        //width:1000,//�����Ȳ���Ϊ�ٷֱ�
        autowidth:true,//�Զ��� 
		cellEdit:true, 
		cellsubmit:"clientArray",
        colNames:['��ϸ����', '��װ��ߴ�', '������','����','��������','����','�����','�����ص�/װ���ص�','�Ϲ�ʱ���-��ʼ/����','��ϵ��','�绰','����','Ŀ�ĵ�/ж���ص�','ж��ʱ���-��ʼ/����'],
        colModel:[
            //{name:'id',index:'id', width:'10%', align:'center' },
            {name:'detailCode',index:'detailCode', width:'10%',align:'center', formatter:"showlink",
                          formatoptions:{baseLinkUrl:"moreDetail-queryAndEdit.html",target:"_self"},editable:true},
            {name:'containerSize',index:'containerSize', width:'10%',align:'center',editable:true},	
            {name:'overweightBox',index:'overweightBox', width:'10%', align:"center",editable:true},
            {name:'count',index:'count', width:'8%', align:"left", sortable:false},
            {name:'cargoType',index:'cargoType', width:'10%',align:"center", sortable:false,editable:true},
			{name:'mainBox',index:'mainBox', width:'10%',align:"center", sortable:false,editable:true},
			{name:'boxCost',index:'boxCost', width:'10%',align:"center"},
			{name:'startPlace',index:'startPlace', width:'15%',align:"center", sortable:false,editable:true},
			{name:'timeOfLoding',index:'timeOfStartAndEnd', width:'18%',align:"center", sortable:false},
			{name:'contactMan',index:'contactMan', width:'8%',align:"center", sortable:false},
			{name:'telPhone',index:'telPhone', width:'8%',align:"center", sortable:false},
			{name:'fax',index:'fax', width:'8%',align:"center", sortable:false},
			{name:'timeOfDischarge',index:'mainBox', width:'18%',align:"center",editable:true},
			{name:'timeOfEnd',index:'mainBox', width:'18%',align:"center", sortable:false},
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
			var rowdata = $("#moreDetail-queryAndEdit").jqGrid("getRowData",rowid); 
			var id=rowid+"_"+name; 
			if(name=="amt"){ 
				$("#"+id).keyup(function(e){ 
				var amt = $(this).val(); 
				var fee = rowdata["fee"]; 
				var total = parseFloat(amt) + parseFloat(fee); 
				$("#moreDetail-queryAndEdit").jqGrid("setRowData",rowid,{"total":total}); 
				}); 
			} 
		 },
        pager:$('#gridPager')
    });
	var mydata = [
			{detailCode:"xxxxxxxx",containerSize:"20GP",overweightBox:"��",count:"1",cargoType:"��װ",mainBox:"����",boxCost:"��",startPlace:"",timeOfLoding:"MM-DD HH24:MI",contactMan:"",telPhone:"",fax:"",timeOfDischarge:"",timeOfEnd:"MM-DD HH24:MI"},
			{detailCode:"xxxxxxxx",containerSize:"40GP",overweightBox:"��",count:"2",cargoType:"��װ",mainBox:"����",boxCost:"��",startPlace:"",timeOfLoding:"",contactMan:"",telPhone:"",fax:"",timeOfDischarge:"",timeOfEnd:""},
			{detailCode:"xxxxxxxx",containerSize:"40HQ",overweightBox:"��",count:"8",cargoType:"���",mainBox:"������",boxCost:"��",startPlace:"",timeOfLoding:"",contactMan:"",telPhone:"",fax:"",timeOfDischarge:"",timeOfEnd:""},
			{detailCode:"xxxxxxxx",containerSize:"",overweightBox:"",count:"test",cargoType:"",mainBox:"some",boxCost:"��",dstartPlace:"",timeOfLoding:"",contactMan:"",telPhone:"",fax:"",timeOfDischarge:"",timeOfEnd:""}
			];
	for(var i=0;i<=mydata.length;i++)
		jQuery("#moreDetail-queryAndEdit").jqGrid('addRowData',i+1,mydata[i]);
});