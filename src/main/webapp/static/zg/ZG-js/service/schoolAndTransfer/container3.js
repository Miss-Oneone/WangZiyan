$(document).ready(function(){
    $("#container3").jqGrid({
        //url:contextPath + "search.action",
        datatype:"json", //������Դ����������
        mtype:"POST",//�ύ��ʽ
        height:70,//�߶ȣ����߶ȡ���Ϊ��ֵ���ٷֱȻ�'auto'
        //width:1000,//�����Ȳ���Ϊ�ٷֱ�
        autowidth:true,//�Զ���
        colNames:['���ƺ�','������Ϣ','������','��������״̬','ͣ���ص�','ϵͳ����','��װ���','·����Ϣ','����ʱ����Ϣ','�̶�˾��','��ǰ˾��'],
        colModel:[
            //{name:'id',index:'id', width:'10%', align:'center' },
            {name:'carsNum',index:'carsNum', width:'3%',align:'center'},
            {name:'carsImfor',index:'carsImfor', width:'3%',align:'center'},	
            {name:'load',index:'load', width:'3%', align:"center"},
            {name:'carsTransInfor',index:'carsTransInfor', width:'3%', align:"center"},
            {name:'stopPlace',index:'stopPlace', width:'3%', align:"center"},
            {name:'sysNum',index:'sysNum', width:'3%', align:"center"},
            {name:'containNum',index:'containNum', width:'3%', align:"center"},
            {name:'routeInfor',index:'routeInfor', width:'3%', align:"center"},
            {name:'taskTime',index:'taskTime', width:'3%', align:"center"},
            {name:'fixedDriver',index:'fixedDriver', width:'3%', align:"center"},
            {name:'currentDriver',index:'currentDriver', width:'3%', align:"center"}
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
        pager:$('#gridPager')
    });
	var mydata = [
            {carsNum:"",carsImfor:"",load:"",carsTransInfor:"",stopPlace:"",sysNum:"",containNum:"",routeInfor:"",taskTime:"",fixedDriver:"",currentDriver:""},
            {carsNum:"",carsImfor:"",load:"",carsTransInfor:"",stopPlace:"",sysNum:"",containNum:"",routeInfor:"",taskTime:"",fixedDriver:"",currentDriver:""},
            {carsNum:"",carsImfor:"",load:"",carsTransInfor:"",stopPlace:"",sysNum:"",containNum:"",routeInfor:"",taskTime:"",fixedDriver:"",currentDriver:""},
            {carsNum:"",carsImfor:"",load:"",carsTransInfor:"",stopPlace:"",sysNum:"",containNum:"",routeInfor:"",taskTime:"",fixedDriver:"",currentDriver:""},
            {carsNum:"",carsImfor:"",load:"",carsTransInfor:"",stopPlace:"",sysNum:"",containNum:"",routeInfor:"",taskTime:"",fixedDriver:"",currentDriver:""}
			];
	for(var i=0;i<=mydata.length;i++)
		jQuery("#container3").jqGrid('addRowData',i+1,mydata[i]);
});