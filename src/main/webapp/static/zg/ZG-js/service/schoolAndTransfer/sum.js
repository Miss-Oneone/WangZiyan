$(document).ready(function(){
    $("#sum").jqGrid({
        //url:contextPath + "search.action",
        datatype:"json", //������Դ����������
        mtype:"POST",//�ύ��ʽ
        height:'auto',//�߶ȣ����߶ȡ���Ϊ��ֵ���ٷֱȻ�'auto'
        width:300,//�����Ȳ���Ϊ�ٷֱ�
        //autowidth:true,//�Զ���
        colNames:['�������', '������', '�ٹ����ͺ�','�ͺĺϼ�'],
        colModel:[
            //{name:'id',index:'id', width:'10%', align:'center' },
            {name:'a',index:'a', width:'3%',align:'center'},
            {name:'b',index:'b', width:'3%',align:'center'},	
            {name:'c',index:'c', width:'3%', align:"center"},
			{name:'d',index:'d', width:'3%', align:"center"}
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
			{a:"�س�",b:"200",c:"32",d:"64"},
			{a:"�ᳵ",b:"170",c:"30",d:"51"},
			];
	for(var i=0;i<=mydata.length;i++)
		jQuery("#sum").jqGrid('addRowData',i+1,mydata[i]);
});