
function printMould(data,id,printFlag){
	LODOP = getLodop(document.getElementById('LODOP2'), document.getElementById('LODOP_EM2'));
	initItem();
	displayDesign(data,id,printFlag);
}

function displayDesign(data,id,printFlag) {
	$.ajax({
		type : "post",
		url : "/eclp_wms/a/print/print/getScript",
		data : {"id" : id},
		async : false,
		success : function(result) {
			print(result, data);				
		}
	});

	//打印
    if(strPrFlag == "1"){
        LODOP.PRINT();      
    }else if(strPrFlag == "2"){
        LODOP.PREVIEW();   	
    }else if(strPrFlag == "3"){
    	LODOP.PRINT_DESIGN();
    }
};

function initItem() {
	$.ajax({
		type : "post",
		url : "/eclp_wms/a/print/print/getVarList",
		async : false,
		success : function(result) {
			var json = eval(result);
			for (var i = 0; i < json.length; i++) {
				varMap["%" + json[i].dispName + "%"] = json[i].name;
			}
		}
	});
}

function print(script, data) {
	for (var key in varMap) {
		//script = script.replace(new RegExp('"' + key + '"', "g"), varMap[key]);
		script = script.replace(new RegExp(key, "g"), "\"+" + varMap[key] + "+\"");
	}
	eval(script);
}


















