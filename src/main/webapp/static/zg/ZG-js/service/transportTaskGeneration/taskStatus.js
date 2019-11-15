$(document).ready(function(){
    $("#taskStatus").jqGrid({
        //url:contextPath + "search.action",
        datatype:"json", //������Դ����������
        mtype:"POST",//�ύ��ʽ
        height:'auto',//�߶ȣ����߶ȡ���Ϊ��ֵ���ٷֱȻ�'auto'
        width:1150,//�����Ȳ���Ϊ�ٷֱ�
        //autowidth:'auto',//�Զ��� 
		shrinkToFit:false,  
		autoScroll: true,  
		cellEdit:true, 
		cellsubmit:"clientArray",
        colNames:['����״̬', 'ϵͳ����', 'ҵ������','��װ���','�ᵥ��','·����Ϣ','��������','�ͻ�','ʱ��Ҫ��','��������','��������','���˹�˾'],
        colModel:[
            //{name:'id',index:'id', width:'10%', align:'center' },
            {name:'taskStatus',index:'taskStatus',width:'85%',align:'center'},
            {name:'sysCode',index:'sysCode',align:'center',width:'100%',editable:true},	
            {name:'serviceType',index:'serviceType',align:"center",width:'50%'},
            {name:'containerNum',index:'containerNum',align:"center",width:'105%'},
            {name:'getCode',index:'getCode',align:"center", width:'120%'},
			{name:'pathInfo',index:'pathInfo',align:"center", width:'120%'},
			{name:'boatNum',index:'boatNum',align:"center", width:'120%'},
			{name:'customer',index:'customer',align:"center", width:'80%'},
			{name:'timeOfRequire',index:'timeOfRequire',align:"center",width:'100%'},
			{name:'cargoType',index:'cargoType',align:"center", width:'50%'},
			{name:'cargoWeight',index:'cargoWeight',align:"center", width:'60%'},
			{name:'carrier',index:'carrier',align:"center", width:'70%'}
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
			var rowdata = $("#taskStatus").jqGrid("getRowData",rowid); 
			var id=rowid+"_"+name; 
			if(name=="amt"){ 
				$("#"+id).keyup(function(e){ 
				var amt = $(this).val(); 
				var fee = rowdata["fee"]; 
				var total = parseFloat(amt) + parseFloat(fee); 
				$("#taskStatus").jqGrid("setRowData",rowid,{"total":total}); 
				}); 
			} 
		 },
        pager:$('#gridPager')
		,gridComplete:function(){
			
		}
    });
	var mydata = [
			{taskStatus:"<input type='text' class='btn btn-success radius' readOnly value='�½�' style='width:85px;'/>",sysCode:"0000001_����",serviceType:"��ó",containerNum:"CBHU8500452",getCode:"COSU611084040",pathInfo:"Ȫ��-������ͷ",boatNum:"��ʢ��7/007N",customer:"��Զ",timeOfRequire:"2015-09-10",cargoType:"��ͨ",cargoWeight:"1000",carrier:"�׹�����"},
			{taskStatus:"<input type='text' class='btn btn-success radius' readOnly value='�½�' style='width:85px;'/>",sysCode:"0000002_����",serviceType:"��ó",containerNum:"CBHU8501452",getCode:"ZOSU611084040",pathInfo:"���׹���-�º���",boatNum:"��������/021S",customer:"��Զ",timeOfRequire:"2015-09-02",cargoType:"��ͨ",cargoWeight:"860",carrier:"�׹�����"},
			{taskStatus:"<input type='text' class='btn btn-warning radius' readOnly value='�Ѳ����ɳ�' style='width:85px;'/>",sysCode:"0000003",serviceType:"��ó",containerNum:"CBHU8500552",getCode:"HOSU611084040",pathInfo:"����-������ͷ",boatNum:"��������/6#201",customer:"�к�����",timeOfRequire:"2015-09-03",cargoType:"��ͨ",cargoWeight:"200",carrier:"�׹�����"},
			];
	for(var i=0;i<=mydata.length;i++)
		jQuery("#taskStatus").jqGrid('addRowData',i+1,mydata[i]);
});