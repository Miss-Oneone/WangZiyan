$(document).ready(function(){
    $("#container1").jqGrid({
        //url:contextPath + "search.action",
        datatype:"json", //������Դ����������
        mtype:"POST",//�ύ��ʽ
        height:18,//�߶ȣ����߶ȡ���Ϊ��ֵ���ٷֱȻ�'auto'
        //width:1000,//�����Ȳ���Ϊ�ٷֱ�
        autowidth:true,//�Զ���
        colNames:['��������', '��������', '���ɳ�����','���������','��/��','װ���ص�','ж���ص�','װ������ʱ��','ж������ʱ��','����ʱ���','��ת�ص�','��ת����ʱ��','��ת�뿪ʱ��'],
        colModel:[
            //{name:'id',index:'id', width:'10%', align:'center' },
            {name:'goodsType',index:'goodsType', width:'3%',align:'center'},
            {name:'goodsWeight',index:'goodsWeight', width:'3%',align:'center'},	
            {name:'carWeight',index:'carWeight', width:'3%', align:"center"},
			{name:'successWeight',index:'currency', width:'3%', align:"center"},
			{name:'singleMany',index:'singleMany', width:'3%', align:"center"},
			{name:'loadPlace',index:'loadPlace', width:'3%', align:"center"},
			{name:'cargoPlace',index:'cargoPlace', width:'3%', align:"center"},
			{name:'loadTime',index:'loadTime', width:'3%', align:"center"},
			{name:'cargoTime',index:'cargoTime', width:'3%', align:"center"},
			{name:'tranTime',index:'tranTime', width:'3%', align:"center"},
			{name:'tranMidTime',index:'tranMidTime', width:'3%', align:"center"},
			{name:'arrTime',index:'arrTime', width:'3%', align:"center"},
			{name:'leftTime',index:'leftTime', width:'3%', align:"center"}
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
			{goodsType:"",goodsWeight:"",carWeight:"",successWeight:"",singleMany:"",loadPlace:"",cargoPlace:"",loadTime:"",cargoTime:"",tranTime:"",tranMidTime:"",arrTime:"",leftTime:""}
			];
	for(var i=0;i<=mydata.length;i++)
		jQuery("#container1").jqGrid('addRowData',i+1,mydata[i]);
});