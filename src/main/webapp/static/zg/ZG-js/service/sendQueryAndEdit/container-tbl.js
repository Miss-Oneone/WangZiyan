$(document).ready(function(){
    $("#sendCarInfo").jqGrid({
        //url:contextPath + "search.action",
        datatype:"json", //������Դ����������
        mtype:"POST",//�ύ��ʽ
        height:68,//�߶ȣ����߶ȡ���Ϊ��ֵ���ٷֱȻ�'auto'
        width:1000,//�����Ȳ���Ϊ�ٷֱ�
        //autowidth:true,//�Զ���
        colNames:['��������', '���õ���', '����', '���', '��ע'],
        colModel:[
            {name:'costType',index:'costType', width:'20%',align:'center'},
            {name:'unitPrice',index:'unitPrice', width:'15%',align:'center'},	
			{name:'count',index:'count', width:'15%',align:'center'},	
            {name:'amounts',index:'amounts', width:'15%', align:"center"},
			{name:'remarks',index:'remarks', width:'15%', align:"center"}
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
			{costType:"���ٷ�1��-10t����",unitPrice:"10",count:"1",amounts:"10",remarks:""},
			{costType:"���ٷ�2��-20t����",unitPrice:"20",count:"1",amounts:"20",remarks:""},
			{costType:"���ٷ�1��-10t����-����",unitPrice:"5",count:"1",amounts:"5",remarks:"�߲˼���"}
			];
	for(var i=0;i<=mydata.length;i++)
		jQuery("#sendCarInfo").jqGrid('addRowData',i+1,mydata[i]);
});