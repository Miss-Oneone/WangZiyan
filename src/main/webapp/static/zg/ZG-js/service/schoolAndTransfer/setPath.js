$(document).ready(function(){
    $("#setPath").jqGrid({
        //url:contextPath + "search.action",
        datatype:"json", //������Դ����������
        mtype:"POST",//�ύ��ʽ
        height:'auto',//�߶ȣ����߶ȡ���Ϊ��ֵ���ٷֱȻ�'auto'
        //width:1000,//�����Ȳ���Ϊ�ٷֱ�
        autowidth:true,//�Զ���
		shrinkToFit:false,  
		autoScroll: true,
        colNames:['����', '�����ش���', 'Ŀ�ĵ�','·�߼��','���ƺ�','������','�ٹ����ͺ�','�������','������-����ָ��','�ٹ����ͺ�-����ָ��','��ע-����ָ��'],
        colModel:[
            //{name:'id',index:'id', width:'10%', align:'center' },
            {name:'code',index:'code',align:'center'},
            {name:'start',index:'start',align:'center'},	
            {name:'arrive',index:'arrive', align:"center"},
			{name:'path',index:'path', align:"center"},
			{name:'carCode',index:'carCode', align:"center"},
			{name:'kilometers',index:'kilometers', align:"center"},
			{name:'fuelConsumption',index:'fuelConsumption', align:"center"},
			{name:'loadCategory',index:'loadCategory', align:"center"},
			{name:'kilometers1',index:'kilometers1', align:"center"},
			{name:'fuelConsumption1',index:'fuelConsumption1', align:"center"},
			{name:'remarks',index:'remarks', align:"center"}
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
			{code:"01",start:"����",arrive:"Ȫ��",path:"����-Ȫ����",carCode:"��D678A",kilometers:"200",fuelConsumption:"32",loadCategory:"�س�",kilometers1:"200",fuelConsumption1:"32",remarks:""},
			{code:"02",start:"����",arrive:"Ȫ��",path:"����-Ȫ����",carCode:"��D678A",kilometers:"200",fuelConsumption:"30",loadCategory:"�ᳵ",kilometers1:"200",fuelConsumption1:"30",remarks:""},
			{code:"",start:"",arrive:"",path:"",carCode:"",kilometers:"",fuelConsumption:"",loadCategory:"��",kilometers1:"-30",fuelConsumption1:"30",remarks:"����"},
			];
	for(var i=0;i<=mydata.length;i++)
		jQuery("#setPath").jqGrid('addRowData',i+1,mydata[i]);
});