$(document).ready(function(){
    $("#sending-cars-1").jqGrid({
        //url:contextPath + "search.action",
        datatype:"json", //������Դ����������
        mtype:"POST",//�ύ��ʽ
        height:500,//�߶ȣ����߶ȡ���Ϊ��ֵ���ٷֱȻ�'auto'
        width:680,//�����Ȳ���Ϊ�ٷֱ�
        //autowidth:true,//�Զ���
		shrinkToFit:false,  
		autoScroll: true,
		multiselect: true,
        colNames:['���ƺ�','λ��','��','6','7','8','9','10','11','12','13','14','15','16','17','18','19','��'],
        colModel:[
            //{name:'id',index:'id', width:'10%', align:'center' },
            //{name:'choose',index:'choose',width:'40%',align:'center',formatter: "checkbox",formatoptions:{disabled:false}},
            {name:'carCode',index:'carCode',width:'97%',align:'center',
				cellattr: function(rowId, value, rowObject, colModel, arrData) {
					if(Number(rowId)==1){
						 return "";
					}else if(Number(rowId)==2){
						 return "rowspan='2'";
					}else if(Number(rowId)==3){
						 return " style=display:none; ";
					}else if(Number(rowId)==4){
						 return "";
					}
				}
			},	
            {name:'location',index:'location',align:"center",width:'50%',
				cellattr: function(rowId, value, rowObject, colModel, arrData) {
					if(Number(rowId)==1){
						 return "";
					}else if(Number(rowId)==2){
						 return "rowspan='2'";
					}else if(Number(rowId)==3){
						 return " style=display:none; ";
					}else if(Number(rowId)==4){
						 return "";
					}
				}
			},
			{name:'morning',index:'morning',align:"center",width:'25%',
				cellattr: function(rowId, value, rowObject, colModel, arrData) {
					if(Number(rowId)==1){
						 return "";
					}else if(Number(rowId)==2){
						 return "";
					}else if(Number(rowId)==3){
						 return "";
					}else if(Number(rowId)==4){
						 return "";
					}
				}
			},
			{name:'hour6',index:'hour6',align:"center",width:'25%',
				cellattr: function(rowId, value, rowObject, colModel, arrData) {
					if(Number(rowId)==1){
						return ' colspan=7';
					}else if(Number(rowId)==2){
						 return "";
					}else if(Number(rowId)==3){
						 return "";
					}else if(Number(rowId)==4){
						 return "";
					}
				}
			},
			{name:'hour7',index:'hour7',align:"center",width:'25%',
				cellattr: function(rowId, value, rowObject, colModel, arrData) {
					if(Number(rowId)==1){
						 return " style=display:none; ";
					}else if(Number(rowId)==2){
						 return "";
					}else if(Number(rowId)==3){
						 return "";
					}else if(Number(rowId)==4){
						 return ' colspan=4';
					}
				}
			},
			{name:'hour8',index:'hour8',align:"center",width:'25%',
				cellattr: function(rowId, value, rowObject, colModel, arrData) {
					if(Number(rowId)==1){
						 return " style=display:none; ";
					}else if(Number(rowId)==2){
						 return ' colspan=11';
					}else if(Number(rowId)==3){
						 return ' colspan=12';
					}else if(Number(rowId)==4){
						 return " style=display:none; ";
					}
				}
			},
			{name:'hour9',index:'hour9',align:"center",width:'25%',
				cellattr: function(rowId, value, rowObject, colModel, arrData) {
					if(Number(rowId)==1){
						 return " style=display:none; ";
					}else if(Number(rowId)==2){
						return " style=display:none; ";
					}else if(Number(rowId)==3){
						return " style=display:none; ";
					}else if(Number(rowId)==4){
						 return " style=display:none; ";
					}
				}
			},
			{name:'hour10',index:'hour10',align:"center",width:'25%',
				cellattr: function(rowId, value, rowObject, colModel, arrData) {
					if(Number(rowId)==1){
						 return " style=display:none; ";
					}else if(Number(rowId)==2){
						return " style=display:none; ";
					}else if(Number(rowId)==3){
						return " style=display:none; ";
					}else if(Number(rowId)==4){
						return " style=display:none; ";
					}
				}
			},
			{name:'hour11',index:'hour11',align:"center",width:'25%',
				cellattr: function(rowId, value, rowObject, colModel, arrData) {
					if(Number(rowId)==1){
						 return " style=display:none; ";
					}else if(Number(rowId)==2){
						return " style=display:none; ";
					}else if(Number(rowId)==3){
						return " style=display:none; ";
					}else if(Number(rowId)==4){
						 return ' colspan=5';
					}
				}
			},
			{name:'hour12',index:'hour12',align:"center",width:'25%',
				cellattr: function(rowId, value, rowObject, colModel, arrData) {
					if(Number(rowId)==1){
						 return " style=display:none; ";
					}else if(Number(rowId)==2){
						return " style=display:none; ";
					}else if(Number(rowId)==3){
						return " style=display:none; ";
					}else if(Number(rowId)==4){
						return " style=display:none; ";
					}
				}
			},
			{name:'hour13',index:'hour13',align:"center",width:'25%',
				cellattr: function(rowId, value, rowObject, colModel, arrData) {
					if(Number(rowId)==1){
						 return "";
					}else if(Number(rowId)==2){
						return " style=display:none; ";
					}else if(Number(rowId)==3){
						return " style=display:none; ";
					}else if(Number(rowId)==4){
						return " style=display:none; ";
					}
				}
			},
			{name:'hour14',index:'hour14',align:"center",width:'25%',
				cellattr: function(rowId, value, rowObject, colModel, arrData) {
					if(Number(rowId)==1){
						 return "";
					}else if(Number(rowId)==2){
						return " style=display:none; ";
					}else if(Number(rowId)==3){
						return " style=display:none; ";
					}else if(Number(rowId)==4){
						return " style=display:none; ";
					}
				}
			},
			{name:'hour15',index:'hour15',align:"center",width:'25%',
				cellattr: function(rowId, value, rowObject, colModel, arrData) {
					if(Number(rowId)==1){
						 return "";
					}else if(Number(rowId)==2){
						return " style=display:none; ";
					}else if(Number(rowId)==3){
						return " style=display:none; ";
					}else if(Number(rowId)==4){
						return " style=display:none; ";
					}
				}
			},
			{name:'hour16',index:'hour16',align:"center",width:'25%',
				cellattr: function(rowId, value, rowObject, colModel, arrData) {
					if(Number(rowId)==1){
						 return " colspan='5' ";
					}else if(Number(rowId)==2){
						return " style=display:none; ";
					}else if(Number(rowId)==3){
						return " style=display:none; ";
					}else if(Number(rowId)==4){
						return ' colspan=4';
					}
				}
			},
			{name:'hour17',index:'hour17',align:"center",width:'25%',
				cellattr: function(rowId, value, rowObject, colModel, arrData) {
					if(Number(rowId)==1){
						 return " style=display:none; ";
					}else if(Number(rowId)==2){
						return " style=display:none; ";
					}else if(Number(rowId)==3){
						return " style=display:none; ";
					}else if(Number(rowId)==4){
						return " style=display:none; ";
					}
				}
			},
			{name:'hour18',index:'hour18',align:"center",width:'25%',
				cellattr: function(rowId, value, rowObject, colModel, arrData) {
					if(Number(rowId)==1){
						 return " style=display:none; ";
					}else if(Number(rowId)==2){
						return " style=display:none; ";
					}else if(Number(rowId)==3){
						return " style=display:none; ";
					}else if(Number(rowId)==4){
						return " style=display:none; ";
					}
				}
			},
			{name:'hour19',index:'hour19',align:"center",width:'25%',
				cellattr: function(rowId, value, rowObject, colModel, arrData) {
					if(Number(rowId)==1){
						 return " style=display:none; ";
					}else if(Number(rowId)==2){
						return "";
					}else if(Number(rowId)==3){
						return " style=display:none; ";
					}else if(Number(rowId)==4){
						return " style=display:none; ";
					}
				}
			},
			{name:'night',index:'night',align:"center",width:'25%',
				cellattr: function(rowId, value, rowObject, colModel, arrData) {
					if(Number(rowId)==1){
						 return " style=display:none; ";
					}else if(Number(rowId)==2){
						return "";
					}else if(Number(rowId)==3){
						return "";
					}else if(Number(rowId)==4){
						return "";
					}
				}
			}
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
			{carCode:"��D39561<br/>�ѵ���װ��",location:"λ��",morning:"",hour6:"��ó���ڣ�#���#��40GP����-��Ͷ�ϳ�->װ-������ʯ����ͷ����ҵ��(������˿����ɡ)->ж-�º�����ͷ",hour7:"",hour8:"",hour9:"",hour10:"",hour11:"",hour12:"",hour13:"",hour14:"",hour15:"",hour16:"��ó���ڣ�#���#��40GP����-������ͷ->ж-˼�������԰���ڹ���·56��101",hour17:"",hour18:"",hour19:"",night:""},
			{carCode:"��D55092<br/>������",location:"λ��",morning:"",hour6:"",hour7:"",hour8:"��ó��#���#��20GP����-���������->װ-���غ���->ж-����AAAA",hour9:"",hour10:"",hour11:"",hour12:"",hour13:"",hour14:"",hour15:"",hour16:"",hour17:"",hour18:"",hour19:"",night:""},
			{carCode:"",location:"",morning:"",hour6:"",hour7:"",hour8:"��ó��#���#��20GP����-���������->װ-���غ���->ж-����BBBB",hour9:"",hour10:"",hour11:"",hour12:"",hour13:"",hour14:"",hour15:"",hour16:"",hour17:"",hour18:"",hour19:"",night:""},
			{carCode:"��DB0017<br/>����ж��",location:"λ��",morning:"",hour6:"",hour7:"��ó���ڣ�#���#��40GP����-��Ͷ�ϳ�->װ-XXX->ж-�º�����ͷ",hour8:"",hour9:"",hour10:"",hour11:"��ó���ڣ�#���#��40GP����-��Ͷ�ϳ�->װ-XXX->ж-�º�����ͷ",hour12:"",hour13:"",hour14:"",hour15:"",hour16:"��ó���ڣ�#���#��40GP����-��Ͷ�ϳ�->װ-XXX->ж-�º�����ͷ",hour17:"",hour18:"",hour19:"",night:""},
			{carCode:"��DB0025<br/>����",location:"",morning:"",hour6:"",hour7:"",hour8:"",hour9:"",hour10:"",hour11:"",hour12:"",hour13:"",hour14:"",hour15:"",hour16:"",hour17:"",hour18:"",hour19:"",night:""},
			{carCode:"��D55627<br/>����",location:"",morning:"",hour6:"",hour7:"",hour8:"",hour9:"",hour10:"",hour11:"",hour12:"",hour13:"",hour14:"",hour15:"",hour16:"",hour17:"",hour18:"",hour19:"",night:""},
			{carCode:"��D57525<br/>����",location:"",morning:"",hour6:"",hour7:"",hour8:"",hour9:"",hour10:"",hour11:"",hour12:"",hour13:"",hour14:"",hour15:"",hour16:"",hour17:"",hour18:"",hour19:"",night:""},
			{carCode:"��D57526<br/>����",location:"",morning:"",hour6:"",hour7:"",hour8:"",hour9:"",hour10:"",hour11:"",hour12:"",hour13:"",hour14:"",hour15:"",hour16:"",hour17:"",hour18:"",hour19:"",night:""},
			{carCode:"��D57500<br/>����",location:"",morning:"",hour6:"",hour7:"",hour8:"",hour9:"",hour10:"",hour11:"",hour12:"",hour13:"",hour14:"",hour15:"",hour16:"",hour17:"",hour18:"",hour19:"",night:""},
			{carCode:"��D57586<br/>����",location:"",morning:"",hour6:"",hour7:"",hour8:"",hour9:"",hour10:"",hour11:"",hour12:"",hour13:"",hour14:"",hour15:"",hour16:"",hour17:"",hour18:"",hour19:"",night:""},
			{carCode:"��D57506<br/>����",location:"",morning:"",hour6:"",hour7:"",hour8:"",hour9:"",hour10:"",hour11:"",hour12:"",hour13:"",hour14:"",hour15:"",hour16:"",hour17:"",hour18:"",hour19:"",night:""},
			{carCode:"��D57536<br/>����",location:"",morning:"",hour6:"",hour7:"",hour8:"",hour9:"",hour10:"",hour11:"",hour12:"",hour13:"",hour14:"",hour15:"",hour16:"",hour17:"",hour18:"",hour19:"",night:""},
			{carCode:"��D57576<br/>����",location:"",morning:"",hour6:"",hour7:"",hour8:"",hour9:"",hour10:"",hour11:"",hour12:"",hour13:"",hour14:"",hour15:"",hour16:"",hour17:"",hour18:"",hour19:"",night:""},
			{carCode:"��D57550<br/>����",location:"",morning:"",hour6:"",hour7:"",hour8:"",hour9:"",hour10:"",hour11:"",hour12:"",hour13:"",hour14:"",hour15:"",hour16:"",hour17:"",hour18:"",hour19:"",night:""},
			{carCode:"��D57596<br/>����",location:"",morning:"",hour6:"",hour7:"",hour8:"",hour9:"",hour10:"",hour11:"",hour12:"",hour13:"",hour14:"",hour15:"",hour16:"",hour17:"",hour18:"",hour19:"",night:""},
			{carCode:"��D58556<br/>����",location:"",morning:"",hour6:"",hour7:"",hour8:"",hour9:"",hour10:"",hour11:"",hour12:"",hour13:"",hour14:"",hour15:"",hour16:"",hour17:"",hour18:"",hour19:"",night:""},
			{carCode:"",location:"",morning:"",hour6:"",hour7:"",hour8:"",hour9:"",hour10:"",hour11:"",hour12:"",hour13:"",hour14:"",hour15:"",hour16:"",hour17:"",hour18:"",hour19:"",night:""},
			{carCode:"",location:"",morning:"",hour6:"",hour7:"",hour8:"",hour9:"",hour10:"",hour11:"",hour12:"",hour13:"",hour14:"",hour15:"",hour16:"",hour17:"",hour18:"",hour19:"",night:""},
			{carCode:"",location:"",morning:"",hour6:"",hour7:"",hour8:"",hour9:"",hour10:"",hour11:"",hour12:"",hour13:"",hour14:"",hour15:"",hour16:"",hour17:"",hour18:"",hour19:"",night:""},
			{carCode:"",location:"",morning:"",hour6:"",hour7:"",hour8:"",hour9:"",hour10:"",hour11:"",hour12:"",hour13:"",hour14:"",hour15:"",hour16:"",hour17:"",hour18:"",hour19:"",night:""}
			];
	for(var i=0;i<=mydata.length;i++)
		jQuery("#sending-cars-1").jqGrid('addRowData',i+1,mydata[i]);
});
