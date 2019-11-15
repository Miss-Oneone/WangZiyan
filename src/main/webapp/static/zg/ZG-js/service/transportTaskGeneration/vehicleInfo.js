$(document).ready(function(){
    $("#vehicleInfo").jqGrid({
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
        colNames:['��������״̬', '���ƺ�', '������Ϣ','������','ͣ���ص�','ϵͳ����','��װ���','·����Ϣ','����ʱ����Ϣ','˾��','����'],
        colModel:[
            //{name:'id',index:'id', width:'10%', align:'center' },
            {name:'taskStatus',index:'taskStatus',width:'115%',align:'center'},
            {name:'carsNum',index:'carsNum',align:'center',width:'90%'},	
            {name:'carsInfo',index:'carsInfo', align:"center",width:'60%'},
            {name:'load',index:'load', align:"center", width:'60%'},
            {name:'placeOfPark',index:'placeOfPark',align:"center",width:'90%',},
			{name:'sysCode',index:'sysCode',align:"center", width:'120%'},
			{name:'containerNum',index:'containerNum',align:"center",width:'120%'},
			{name:'pathInfo',index:'pathInfo',align:"center",width:'120%'},
			{name:'timeOfTask',index:'timeOfTask',align:"center", width:'130%'},
			{name:'driver',index:'driver',align:"center",width:'70%'},
			{name:'frame',index:'frame',align:"center", width:'90%'}
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
			var rowdata = $("#vehicleInfo").jqGrid("getRowData",rowid); 
			var id=rowid+"_"+name; 
			if(name=="amt"){ 
				$("#"+id).keyup(function(e){ 
				var amt = $(this).val(); 
				var fee = rowdata["fee"]; 
				var total = parseFloat(amt) + parseFloat(fee); 
				$("#vehicleInfo").jqGrid("setRowData",rowid,{"total":total}); 
				}); 
			} 
		 },
        pager:$('#gridPager')
		,gridComplete:function(){
			
		}
    });
	var mydata = [
			{taskStatus:"<input type='text' class='btn btn-success radius' readOnly value='����' style='width:115px;'/>",carsNum:"��D 66703",carsInfo:"С��",load:"20��",placeOfPark:"���ڳ���",sysCode:"",containerNum:"",pathInfo:"",timeOfTask:"",driver:"����",frame:"��DM797��"},
			{taskStatus:"<input type='text' class='btn btn-success radius' readOnly value='����' style='width:115px;'/>",carsNum:"��D 66706",carsInfo:"��ж",load:"20��",placeOfPark:"���ڳ���",sysCode:"",containerNum:"",pathInfo:"",timeOfTask:"",driver:"«����",frame:"��DQ605��"},
			{taskStatus:"<input type='text' class='btn btn-success radius' readOnly value='����' style='width:115px;'/>",carsNum:"��D 57525",carsInfo:"����",load:"40��",placeOfPark:"���׳���",sysCode:"",containerNum:"",pathInfo:"",timeOfTask:"",driver:"������",frame:"��DL076��"},
			{taskStatus:"<input type='text' class='btn btn-danger radius' readOnly value='ʹ����-����ж��' style='width:115px;'/>",carsNum:"��D B0025",carsInfo:"����",load:"40��",placeOfPark:"",sysCode:"0000005_����",containerNum:"CBHU8501415",pathInfo:"���׹���-�º���",timeOfTask:"2015-09-01 11:00",driver:"�ߺ���",frame:"��DC901��"},
			{taskStatus:"<input type='text' class='btn btn-danger radius' readOnly value='ʹ����-�ѵ���' style='width:115px;'/>",carsNum:"��D 66702",carsInfo:"С��",load:"20��",placeOfPark:"",sysCode:"0000014_����",containerNum:"CBHU8500412",pathInfo:"Ȫ��-������ͷ",timeOfTask:"2015-09-01 10:00",driver:"��ǰ��",frame:"��DN097��"},
			{taskStatus:"<input type='text' class='btn btn-danger radius' readOnly value='ʹ����-�ѷ���' style='width:115px;'/>",carsNum:"��D 55092",carsInfo:"С��",load:"20��",placeOfPark:"",sysCode:"0000003",containerNum:"CBHU8500552",pathInfo:"����-������ͷ",timeOfTask:"2015-09-01 09:30",driver:"����",frame:"��DQ572��"}
			];
	for(var i=0;i<=mydata.length;i++)
		jQuery("#vehicleInfo").jqGrid('addRowData',i+1,mydata[i]);
});