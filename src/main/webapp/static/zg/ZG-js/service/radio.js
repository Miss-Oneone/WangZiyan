function check(param){
	if(param == 'single'){
		$("#loading").removeAttr("disabled");
		$("#charge").removeAttr("disabled");
		$("#transFrom").attr("disabled","true");
		$("#transTo").attr("disabled","true");
	}else{
		$("#loading").attr("disabled","true");
		$("#charge").attr("disabled","true");
		$("#transFrom").removeAttr("disabled");
		$("#transTo").removeAttr("disabled");
	}
}