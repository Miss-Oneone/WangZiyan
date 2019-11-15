
var arrowSelector = "#arrow";

$(document).ready(function(e) {
	getMenus();
	$("#collapseBtn").click(function() {
		doCollapse();
	});
	
	$("#expandBtn").click(function() {
		doExpand();
	});
});
function doCollapse(){
	var treeObj = $.fn.zTree.getZTreeObj("tree");
	treeObj.expandAll(false);
}
function doExpand(){
	var treeObj = $.fn.zTree.getZTreeObj("tree");
	treeObj.expandAll(true);
}
/**
 * @since
 * @author liuweile
 */
var LEVEL_MAP_PRO_NUM = 0 ;
var CON_URL_WEB_PAGE = '/webpage/menu/';
var MENU_ROWS = '';
function getMenus(){
	
	$.ajax({
		type: "post",
		async:false,
		contentType : "application/json; charset=UTF-8",
		dataType: "json",
		cache:false,
		url:SUNSAIL.RUNTIME.CONTEXT_PATH +"/sys/menu/list?isShow=1",
		beforeSend: function(XMLHttpRequest){
			//ShowLoading();
		},
		//data:data,
		success: function(data, textStatus)
		{
			if(data)
			{
				if(data.rows){
					MENU_ROWS = data.rows;
					//循环得到level 为key,value为同级别菜单数组的MAP
					var leverMap =  arrayToLevelMap(MENU_ROWS);
					if(1 in leverMap )
					{
						var mainMenuArray = leverMap['1'];
						var mainMenuLen = mainMenuArray.length;
						
						LEVEL_MAP_PRO_NUM = Object.getOwnPropertyNames(leverMap).length;
						// 2.算出一级菜单的子菜单
						var suMenuArray = new Array();
						var menuObj ='';
						for(var k=0;k < mainMenuLen; k++)
						{
							menuObj = mainMenuArray[k];
							//1.算出一级菜单节点的子节点数组
							setNodeSubChildrens(leverMap, menuObj,1);
							//2.算出一级菜单节点的整棵树
							setNodeThree(leverMap,menuObj,1);
							
						}
					}
					console.log(leverMap);
					var t = $("#tree");
				    t = $.fn.zTree.init(t, setting, leverMap['1']);
				   // t.selectNode(t.getNodeByParam("menuId", data.rows[0].menuId),true);
				    var nodes = t.getNodes();   
				    t.expandNode(nodes[0], true);   
				}
			}
		},
		
		complete: function(XMLHttpRequest, textStatus){
			//HideLoading();
		},
		error: function(jqXHR, textStatus, errorThrown) {
			
		}
	});
}
var zTree;
var demoIframe;
var setting = {
    view: {
        dblClickExpand: false,
        showLine: false,
        selectedMulti: false,
        showIcon:false,
        fontCss: getFont
    },
    data: {
	    simpleData: {
			enable:true,
			idKey: "menuId",  //更换属性，默认id
			pIdKey: "parentId",
			rootPId: ""
		}
    },
    callback: {
        beforeClick: function(treeId, treeNode) {
            var zTree = $.fn.zTree.getZTreeObj("tree");
            if ( !treeNode.isLeaf) {
            	//将文字颜色变成绿色
            	//zTreeBeforeExpand(treeId, treeNode);
                zTree.expandNode(treeNode);
                return false;
            } else {
                return true;
            }
        },
    	onClick:function(event, treeId, treeNode) {
    		var url = "";
            var zTree = $.fn.zTree.getZTreeObj("tree");
            if (treeNode.isParent) {
                zTree.expandNode(treeNode);
            } else {
            	switch(true){
					case treeNode.menuType ==='L':
						url = SUNSAIL.RUNTIME.CONTEXT_PATH +treeNode.objectId;
						break;
					case treeNode.menuType ==='P':
						url = SUNSAIL.RUNTIME.CONTEXT_PATH +CON_URL_WEB_PAGE+treeNode.objectId;
						break;
					default:
						url = SUNSAIL.RUNTIME.CONTEXT_PATH +CON_URL_WEB_PAGE+treeNode.objectId;
						break;
            	}
            	addTabs(treeNode.name,url);

            	// 触发arrow的click事件，将菜单隐藏
                if ($(arrowSelector)) {
                    $(arrowSelector).trigger('click');
                }
            }
        }
        //onExpand: zTreeOnExpand,
        //beforeExpand: zTreeBeforeExpand
    }
};
function getFont(treeId, node) { 
	if(node.isLeaf){
		node.font={'color':'#2B4DB3'};
	}
    return node.font ? node.font : {};  
}  
function zTreeBeforeExpand(treeId, treeNode) {
	console.log(treeNode);
	var zTree = $.fn.zTree.getZTreeObj("tree");
	var node = zTree.getNodeByParam("menuId", treeNode.menuId);
    var list = treeNode.children;
    for(var i in  list){
    	var nodeTmp = list[i];
    	if(nodeTmp.isLeaf){
    		nodeTmp.font={'color':'#2B4DB3'};
    	}
    }
    return true;
};
function zTreeOnExpand(event, treeId, treeNode) {
    console.log(treeNode);
    treeNode.font={'color':'red'};
};
function arrayToLevelMap(rows){//循环得到level 为key,value为同级别菜单数组的MAP
	var leverMap = {};
	var rowSize= rows.length;
	var level='';
	var temArray='';
	for(var i=0;i<rowSize;i++){	
		level = rows[i].level;
		if(!(level in leverMap)){
			leverMap[level] = new Array();
			temArray = leverMap[level];
			temArray.push(rows[i]);
		}else{
			temArray = leverMap[level];
			temArray.push(rows[i]);
		}
	}
	return leverMap;
}

function setNodeSubChildrens(levelMap,node,curNodelevel)
{
	var subNodelevel = curNodelevel+1;
	if(subNodelevel in levelMap ) { // map中有node子菜单
		var itemId = node.menuId;
		var subMenuLevelArray = levelMap[subNodelevel];
		var parentId ='';
		var len = subMenuLevelArray.length;
		var temArray = '';	//临时数组
		for(var u=0;u<len;u++)
		{
			parentId = subMenuLevelArray[u].parentId;
			if(itemId === parentId) //判断是否是node节点的子节点
			{
				
				if(!('children' in node)){ //node 若无children属性
					node['children'] = new Array();
					temArray =node['children'];
					temArray.push(subMenuLevelArray[u]);
				}else{
					temArray = node['children'];
					temArray.push(subMenuLevelArray[u]);
				}
			}
			
		}
	}
	
}


/**
 * 得到某一节点的树
 * @param leverMap
 * @param currentNodeObj
 * @param nodeLevel 当前节点菜单级别
 */
function setNodeThree(leverMap,currentNodeObj,nodeLevel){
	if('children' in currentNodeObj)
	{
		var  curNodeChildrens = currentNodeObj['children'];
		var subObj='';
		var len=curNodeChildrens.length;
		for(var i=0;i<len;i++)
		{
			subObj = curNodeChildrens[i];
			setNodeSubChildrens(leverMap,subObj ,nodeLevel+1);
			if(nodeLevel <  (LEVEL_MAP_PRO_NUM-2)){//递归终止条件：nodeLevel小于菜单级别数-2，由于可以基本形成3个级别的树，所以
				setNodeThree(leverMap,subObj,nodeLevel+1)
			}
		}
	}
}
