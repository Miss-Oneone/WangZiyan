function ifContainer(param){
	if(param == 'yes'){
		$("#container").removeAttr("style");
		$("#unContainer").css("display",'none');
	}else{
		$("#unContainer").removeAttr("style");
		$("#container").css("display",'none');
	}
}