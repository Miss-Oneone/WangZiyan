$(document).ready(function(){
    $("#container4").jqGrid({
        //url:contextPath + "search.action",
        datatype:"json", //������Դ����������
        mtype:"POST",//�ύ��ʽ
        height:70,//�߶ȣ����߶ȡ���Ϊ��ֵ���ٷֱȻ�'auto'
        //width:1000,//�����Ȳ���Ϊ�ٷֱ�
        autowidth:true,//�Զ���
        colNames:['˾������','�绰����1','�绰����2','���ó�','����·��','��������״̬','��ʻ֤����','����','��˾��������'],
        colModel:[
            //{name:'id',index:'id', width:'10%', align:'center' },
            {name:'dirverName',index:'dirverName', width:'15%',align:'center'},
            {name:'phoneNumF',index:'phoneNumF', width:'10%',align:'center'},	
            {name:'phoneNumS',index:'phoneNumS', width:'12%', align:"center"},
            {name:'usualCars',index:'usualCars', width:'12%', align:"center"},
            {name:'usualRoute',index:'usualRoute', width:'12%', align:"center"},
            {name:'tranState',index:'tranState', width:'12%', align:"center"},
            {name:'drivCardType',index:'drivCardType', width:'12%', align:"center"},
            {name:'driverAge',index:'driverAge', width:'12%', align:"center"},
            {name:'comSevYears',index:'comSevYears', width:'12%', align:"center"}
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
            {dirverName:"",phoneNumF:"",phoneNumS:"",usualCars:"",usualRoute:"",tranState:"",drivCardType:"",driverAge:"",comSevYears:""},
            {dirverName:"",phoneNumF:"",phoneNumS:"",usualCars:"",usualRoute:"",tranState:"",drivCardType:"",driverAge:"",comSevYears:""},
            {dirverName:"",phoneNumF:"",phoneNumS:"",usualCars:"",usualRoute:"",tranState:"",drivCardType:"",driverAge:"",comSevYears:""},
            {dirverName:"",phoneNumF:"",phoneNumS:"",usualCars:"",usualRoute:"",tranState:"",drivCardType:"",driverAge:"",comSevYears:""},
            {dirverName:"",phoneNumF:"",phoneNumS:"",usualCars:"",usualRoute:"",tranState:"",drivCardType:"",driverAge:"",comSevYears:""}
			];
	for(var i=0;i<=mydata.length;i++)
		jQuery("#container4").jqGrid('addRowData',i+1,mydata[i]);
});