$(document).ready(function(){
    $("#container2").jqGrid({
        //url:contextPath + "search.action",
        datatype:"json", //������Դ����������
        mtype:"POST",//�ύ��ʽ
        height:150,//�߶ȣ����߶ȡ���Ϊ��ֵ���ٷֱȻ�'auto'
        //width:1000,//�����Ȳ���Ϊ�ٷֱ�
        autowidth:true,//�Զ���
        colNames:['�ɳ�����', '�ɳ�ʱ��', '��������','������','���ƺ�','��������','���ܺ�','˾��','������','�ɳ���״̬','ʵ�ʷ���ʱ��','ʵ�ʻس�ʱ��'],
        colModel:[
            //{name:'id',index:'id', width:'10%', align:'center' },
            {name:'carsNum',index:'carsNum', width:'3%',align:'center'},
            {name:'carsTime',index:'carsTime', width:'3%',align:'center'},	
            {name:'carsDate',index:'carsDate', width:'3%', align:"center"},
            {name:'person',index:'person', width:'3%', align:"center"},
            {name:'carsNum',index:'carsNum', width:'3%', align:"center"},
            {name:'carsType',index:'carsType', width:'3%', align:"center"},
            {name:'frameCarNum',index:'frameCarNum', width:'3%', align:"center"},
            {name:'drivers',index:'drivers', width:'3%', align:"center"},
            {name:'load',index:'load', width:'3%', align:"center"},
            {name:'carsState',index:'carsState', width:'3%', align:"center"},
            {name:'trueGoTime',index:'trueGoTime', width:'3%', align:"center"},
            {name:'trueReturnTime',index:'trueReturnTime', width:'3%', align:"center"}
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
            {carsNum:"",carsTime:"",carsDate:"",person:"",carsNum:"",carsType:"",frameCarNum:"",drivers:"",load:"",carsState:"",trueGoTime:"",trueReturnTime:""},
            {carsNum:"",carsTime:"",carsDate:"",person:"",carsNum:"",carsType:"",frameCarNum:"",drivers:"",load:"",carsState:"",trueGoTime:"",trueReturnTime:""},
            {carsNum:"",carsTime:"",carsDate:"",person:"",carsNum:"",carsType:"",frameCarNum:"",drivers:"",load:"",carsState:"",trueGoTime:"",trueReturnTime:""},
            {carsNum:"",carsTime:"",carsDate:"",person:"",carsNum:"",carsType:"",frameCarNum:"",drivers:"",load:"",carsState:"",trueGoTime:"",trueReturnTime:""},
			];
	for(var i=0;i<=mydata.length;i++)
		jQuery("#container2").jqGrid('addRowData',i+1,mydata[i]);
});