$(document).ready(function(){
    $("#costMo").jqGrid({
        //url:contextPath + "search.action",
        datatype:"json", //������Դ����������
        mtype:"POST",//�ύ��ʽ
        height:'auto',//�߶ȣ����߶ȡ���Ϊ��ֵ���ٷֱȻ�'auto'
        width:600,//�����Ȳ���Ϊ�ٷֱ�
        //autowidth:true,//�Զ���
        colNames:['��������', '���õ���', '����','���','��ע'],
        colModel:[
            //{name:'id',index:'id', width:'10%', align:'center' },
            {name:'a',index:'a',align:'center'},
            {name:'b',index:'b',align:'center'},	
            {name:'c',index:'c',align:"center"},
			{name:'d',index:'d',align:"center"},
			{name:'e',index:'e',align:"center"}
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
			{a:"���ٷ�1��-10t����",b:"10",c:"1",d:"10",e:""},
			{a:"���ٷ�2��-20t����",b:"20",c:"1",d:"20",e:""},
			{a:"���ٷ�1��-10t����-����",b:"5",c:"1",d:"5",e:"�߲˼���"}
			];
	for(var i=0;i<=mydata.length;i++)
		jQuery("#costMo").jqGrid('addRowData',i+1,mydata[i]);
});