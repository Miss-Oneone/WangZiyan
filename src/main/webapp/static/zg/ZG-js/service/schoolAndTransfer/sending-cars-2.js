$(document).ready(function(){
    $("#sending-cars-2").jqGrid({
        //url:contextPath + "search.action",
        datatype:"json", //������Դ����������
        mtype:"POST",//�ύ��ʽ
        height:500,//�߶ȣ����߶ȡ���Ϊ��ֵ���ٷֱȻ�'auto'
        width:800,//�����Ȳ���Ϊ�ٷֱ�
        //autowidth:true,//�Զ���
		shrinkToFit:false,  
		autoScroll: true,
		multiselect: true,
        colNames:['ϵͳ����', '���䶩������','����ʱ��','��ϵ��/�绰','����','ҵ��ע'],
        colModel:[
            //{name:'id',index:'id', width:'10%', align:'center' },
            //{name:'choose',index:'choose',width:'40%',align:'center',formatter:function(v,x,r){ return "<input type='checkbox'/>";}},//formatter: cLink,
            {name:'sysCode',index:'sysCode',width:'65%',align:'center'},	
            {name:'transactionInfo',index:'transactionInfo',align:"center"},
			{name:'startTime',index:'startTime',width:'75%',align:"center"},
			{name:'tel',index:'tel',align:"center"},
			{name:'amounts',index:'amounts',width:'60%',align:"center"},
			{name:'remarks',index:'remarks',width:'160%',align:"center"}
        ],
        //rownumbers:true,//�������к�
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
			{sysCode:"<a href='../sendQueryAndEdit/send-container.html'>082101</a>",transactionInfo:"����أ�������ͷ  װ���أ�������ʯ����ͷ����ҵ��(������˿����ɡ)ж���أ�������ͷ",startTime:"2015-9-1",tel:"С��/13400801999",amounts:"<a href='../transportTaskAccepting/costManagement.html'>Ӧ��<br/>Ӧ��</a>",remarks:""},
			{sysCode:"<a href='../sendQueryAndEdit/send-container.html'>082102</a>",transactionInfo:"����أ������º���  װ���أ�������ʯ����ͷ����ҵ��(������˿����ɡ)ж���أ������º���",startTime:"2015-9-1",tel:"С��/13400801239",amounts:"<a href='../transportTaskAccepting/costManagement.html'>Ӧ��<br/>Ӧ��</a>",remarks:""},
			{sysCode:"<a href='../sendQueryAndEdit/send-container.html'>082103</a>",transactionInfo:"����أ������º���  װ���أ���̩����ڽ�����ɢ��  ж���أ����",startTime:"2015-9-1",tel:"С��/15392235639",amounts:"<a href='../transportTaskAccepting/costManagement.html'>Ӧ��<br/>Ӧ��</a>",remarks:""},
			{sysCode:"<a href='../sendQueryAndEdit/send-container.html'>082104</a>",transactionInfo:"����أ������º���  װ���أ���̩����ڽ�����ɢ��  ж���أ����",startTime:"2015-9-1",tel:"С��/15392235639",amounts:"<a href='../transportTaskAccepting/costManagement.html'>Ӧ��<br/>Ӧ��</a>",remarks:""},
			{sysCode:"<a href='../sendQueryAndEdit/send-container.html'>082105</a>",transactionInfo:"����أ������º���  װ���أ���̩����ڽ�����ɢ��  ж���أ����",startTime:"2015-9-1",tel:"С��/15392235639",amounts:"<a href='../transportTaskAccepting/costManagement.html'>Ӧ��<br/>Ӧ��</a>",remarks:""},
			{sysCode:"<a href='../sendQueryAndEdit/send-container.html'>082106</a>",transactionInfo:"����أ�������ͷ  װ���أ�Ȫ������Ƽ���ҵ����̩·1��  ж���أ�������ͷ",startTime:"2015-9-1",tel:"�����/0595-22496682,<br/>13959839039",amounts:"<a href='../transportTaskAccepting/costManagement.html'>Ӧ��<br/>Ӧ��</a>",remarks:""},
			{sysCode:"<a href='../sendQueryAndEdit/send-container.html'>082107</a>",transactionInfo:"����أ��м���Ͷ�����ף�  װ���أ������������Ƽ������ţ����޹�˾ ������ͬ������������������·523��  ж���أ�������ͷ",startTime:"2015-9-1",tel:"����÷/15959269594",amounts:"<a href='../transportTaskAccepting/costManagement.html'>Ӧ��<br/>Ӧ��</a>",remarks:""},
			{sysCode:"<a href='../sendQueryAndEdit/send-container.html'>082108</a>",transactionInfo:"����أ��м���Ͷ�����ף�    װ���أ�ʯʨ������·�ʹڲִ���װ����ϵ��: ��Ͽ  ж���أ�������ͷ",startTime:"2015-9-1",tel:"С��/ 18050996131",amounts:"<a href='../transportTaskAccepting/costManagement.html'>Ӧ��<br/>Ӧ��</a>",remarks:""}
			];
	for(var i=0;i<=mydata.length;i++)
		jQuery("#sending-cars-2").jqGrid('addRowData',i+1,mydata[i]);
});
function choose(){
	layer.open({
        type: 2,
        title: '�����������',
        maxmin: true,
        shadeClose: true, //������ֹرղ�
        area : ['820px' , '400px'],
        content: 'addOrderTask.html'
    });
}
function cLink(cellvalue, options, rowObject){
	return '<a href="javascript:void(0)" onclick="choose();">ѡ</a>';
} 
