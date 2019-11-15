$(document).ready(function(){
    $("#queryAndEdit-container").jqGrid({
        //url:contextPath + "search.action",
        datatype:"json", //������Դ����������
        mtype:"POST",//�ύ��ʽ
        height:'auto',//�߶ȣ����߶ȡ���Ϊ��ֵ���ٷֱȻ�'auto'
        width:1150,//�����Ȳ���Ϊ�ٷֱ�
        //autowidth:true,//�Զ���
		shrinkToFit:false,  
		autoScroll: true,  
        colNames:['ϵͳ����', '����״̬', 'ҵ������', '�ͻ�/������', '��������', 'Ҫ��ʱ��', '��ͷ', '�Ƿ�װ��', '��װ������', '���ɳ�����', '����������', '���ɳ�����','���������','������Ϣ'],
        colModel:[
            //{name:'id',index:'id', width:'10%', align:'center' },
            {name:'sysNum',index:'costType',width:'120%',align:'center'},
            {name:'missionState',index:'phoneNo',width:'90%',align:'center'},	
            {name:'serviceType',index:'currency',width:'50%',align:"center"},
            {name:'customer',index:'currency', width:'80%',align:"center"},
            {name:'boatNum',index:'currency', width:'120%',align:"center"},
            {name:'timeOfRequire',index:'currency',width:'100%',align:"center"},
            {name:'placeOfBoat',index:'currency', width:'100%',align:"center"},
            {name:'ifContainer',index:'currency',width:'30%',align:"center"},
            {name:'countOfContainer',index:'currency',width:'30%',align:"center"},
            {name:'countOfSend',index:'currency',width:'30%',align:"center"},
            {name:'totalWeight',index:'currency',width:'50%',align:"center"},
            {name:'weightOfSend',index:'currency',width:'30%',align:"center"},
			{name:'weightOfComplete',index:'currency',width:'30%',align:"center"},
			{name:'info',index:'currency',width:'190%',align:"center"}
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
			{sysNum:"<a href='container.html'>0000001_����</a>",missionState:"<input type='text' class='btn btn-success radius' readOnly value='�½�' style='width:85px;'/>",serviceType:"��ó",customer:"������ó",boatNum:"��ʢ��7/007N",timeOfRequire:"2015-09-10",placeOfBoat:"������ͷ",ifContainer:"��",countOfContainer:"1",countOfSend:"0",totalWeight:"20",weightOfSend:"20",weightOfComplete:"0",info:""},
			{sysNum:"<a href='container.html'>0000002_����</a>",missionState:"<input type='text' class='btn btn-danger radius' readOnly value='�ѷ���' style='width:85px;'/>",serviceType:"��ó",customer:"��Զ��ó",boatNum:"��������/021S",timeOfRequire:"2015-09-02",placeOfBoat:"�����º���",ifContainer:"��",countOfContainer:"1",countOfSend:"1",totalWeight:"20",weightOfSend:"20",weightOfComplete:"0",info:""},
			{sysNum:"<a href='unContainer-taskQuery.html'>0000003</a>",missionState:"<input type='text' class='btn btn-warning radius' readOnly value='�Ѳ����ɳ�' style='width:85px;'/>",serviceType:"��ó",customer:"�к�����",boatNum:"",timeOfRequire:"2015-09-03",placeOfBoat:"������ͷ",ifContainer:"��",countOfContainer:"",countOfSend:"2",totalWeight:"1000",weightOfSend:"80",weightOfComplete:"0",info:""},
			{sysNum:"<a href='unContainer-taskQuery.html'>0000004</a>",missionState:"<input type='text' class='btn btn-warning radius' readOnly value='�Ѳ����ɳ�' style='width:85px;'/>",serviceType:"��ó",customer:"�Ͻ��ҵ",boatNum:"",timeOfRequire:"",placeOfBoat:"�����º���",ifContainer:"��",countOfContainer:"��",countOfSend:"2",totalWeight:"1000",weightOfSend:"40",weightOfComplete:"40",info:"���ڣ�Ԥ�Ƶ��µ���"}
			];
	for(var i=0;i<=mydata.length;i++)
		jQuery("#queryAndEdit-container").jqGrid('addRowData',i+1,mydata[i]);
});