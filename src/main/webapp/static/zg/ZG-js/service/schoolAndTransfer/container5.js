$(document).ready(function(){
    $("#container5").jqGrid({
        //url:contextPath + "search.action",
        datatype:"json", //������Դ����������
        mtype:"POST",//�ύ��ʽ
        height:70,//�߶ȣ����߶ȡ���Ϊ��ֵ���ٷֱȻ�'auto'
        //width:1000,//�����Ȳ���Ϊ�ٷֱ�
        autowidth:true,//�Զ���
        colNames:['��������','���õ���','����','���','��ע'],
        colModel:[
            //{name:'id',index:'id', width:'10%', align:'center' },
            {name:'costType',index:'costType', width:'3%',align:'center'},
            {name:'price',index:'price', width:'3%',align:'center'},	
            {name:'number',index:'number', width:'3%', align:"center"},
            {name:'cost',index:'cost', width:'3%', align:"center"},
            {name:'remarks',index:'remarks', width:'3%', align:"center"}
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
            {costType:"���ٷ�1��-10t����",price:"10",number:"1",cost:"10",remarks:""},
            {costType:"���ٷ�2��-20t����",price:"20",number:"1",cost:"20",remarks:""},
            {costType:"���ٷ�1��-10t����-����",price:"5",number:"1",cost:"5",remarks:"�߲˼���"}
			];
	for(var i=0;i<=mydata.length;i++)
		jQuery("#container5").jqGrid('addRowData',i+1,mydata[i]);
});