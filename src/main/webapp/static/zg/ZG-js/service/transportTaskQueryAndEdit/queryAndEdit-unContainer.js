$(document).ready(function(){
    $("#queryAndEdit-unContainer").jqGrid({
        //url:contextPath + "search.action",
        datatype:"json", //������Դ����������
        mtype:"POST",//�ύ��ʽ
        height:'auto',//�߶ȣ����߶ȡ���Ϊ��ֵ���ٷֱȻ�'auto'
        width:1000,//�����Ȳ���Ϊ�ٷֱ�
        //autowidth:true,//�Զ���
		shrinkToFit:false,  
		autoScroll: true,  
        colNames:['ϵͳ����', '����״̬', '��װ���', '�ᵥ��', '·����Ϣ', '����', '�ͻ�', 'ʱ��Ҫ��', '��������', '��������', '���˹�˾', '�ύʱ��'],
        colModel:[
            //{name:'id',index:'id', width:'10%', align:'center' },
            {name:'sysNum',index:'costType',align:'center', formatter:"showlink",
                          formatoptions:{baseLinkUrl:"unContainer-taskQuery.html",target:"_self"},editable:true},
            {name:'missionState',index:'phoneNo',align:'center'},	
            {name:'containerNum',index:'currency',align:"center"},
            {name:'ladbillNum',index:'currency',align:"center"},
            {name:'routeMessage',index:'currency',align:"center"},
            {name:'route',index:'currency',align:"center"},
            {name:'client',index:'currency',align:"center"},
            {name:'timeRequire',index:'currency', align:"center"},
            {name:'goodsType',index:'currency', align:"center"},
            {name:'goodsWeight',index:'currency',align:"center"},
            {name:'shipCompany',index:'currency',align:"center"},
            {name:'subTime',index:'currency',align:"center"}
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
			{sysNum:"XXXXXX",missionState:"",containerNum:"",ladbillNum:"",routeMessage:"",route:"",client:"",timeRequire:"",goodsType:"",goodsWeight:"",shipCompany:"",subTime:""},
			{sysNum:"XXXXXX",missionState:"",containerNum:"",ladbillNum:"",routeMessage:"",route:"",client:"",timeRequire:"",goodsType:"",goodsWeight:"",shipCompany:"",subTime:""},
			{sysNum:"XXXXXX",missionState:"",containerNum:"",ladbillNum:"",routeMessage:"",route:"",client:"",timeRequire:"",goodsType:"",goodsWeight:"",shipCompany:"",subTime:""},
			{sysNum:"XXXXXX",missionState:"",containerNum:"",ladbillNum:"",routeMessage:"",route:"",client:"",timeRequire:"",goodsType:"",goodsWeight:"",shipCompany:"",subTime:""},
			{sysNum:"XXXXXX",missionState:"",containerNum:"",ladbillNum:"",routeMessage:"",route:"",client:"",timeRequire:"",goodsType:"",goodsWeight:"",shipCompany:"",subTime:""},
			{sysNum:"XXXXXX",missionState:"",containerNum:"",ladbillNum:"",routeMessage:"",route:"",client:"",timeRequire:"",goodsType:"",goodsWeight:"",shipCompany:"",subTime:""},
			{sysNum:"XXXXXX",missionState:"",containerNum:"",ladbillNum:"",routeMessage:"",route:"",client:"",timeRequire:"",goodsType:"",goodsWeight:"",shipCompany:"",subTime:""},
			{sysNum:"XXXXXX",missionState:"",containerNum:"",ladbillNum:"",routeMessage:"",route:"",client:"",timeRequire:"",goodsType:"",goodsWeight:"",shipCompany:"",subTime:""}
			];
	for(var i=0;i<=mydata.length;i++)
		jQuery("#queryAndEdit-unContainer").jqGrid('addRowData',i+1,mydata[i]);
});