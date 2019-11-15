function maskingout(loadingImage){
	var msk = "<div id='maskingLayer'><iframe id='fLoading' name='fLoading' src='' width='99%' height='99%'></iframe></div>";
	$(msk).appendTo(document.body);
	msk = "<table border='0' height='100%' width='100%'><tr><td align='center'>" +
				"<img border='0' src='" + loadingImage + "'>" +
				"</td></tr></table>";	
	var fLoading = window.frames["fLoading"];
	fLoading.document.open();
	fLoading.document.write(msk);
	fLoading.document.close();	
}

function show_mask(){
	/*window.top.*/$("#maskingLayer").css("display","block").css("z-index", 1002); 
	//maskingLayer.style.display = "block";
}

function show_mask_mobile(){
	$("#maskingLayer").css("display","block").css("z-index", 1002).css("position","absolute").css("height",$(window).height()).css("width",$(window).width()); 
}

function hide_mask(){
	/*window.top.*/$("#maskingLayer").css("display","none");
	//maskingLayer.style.display = "none";
	//$("#maskingLayer").hide("fast");
}

function createXMLDOM(){
 	try {
 		return new ActiveXObject("MSXML2.DOMDocument");
	} 
  catch(e){
  	return null;
  }
}

function checkTags(oItem){
	try{
		var tagName = oItem.tagName.toLowerCase();//alert(oItem.id);
		if(tagName != "input" && tagName != "select"){return false;}    		
		if(tagName == "select"){return true;}
		var tp = oItem.type.toLowerCase();
		if(tp=="text"||tp=="password"||tp=="hidden"){return true;}
		if(tp=="radio"||tp=="checkbox"){return (oItem.checked ? true : false);}
		return false;
	}
  catch(e){
		alert("[" + e.name + "]" + e.message);
		return false;
	}
}

function doPostEnd(){
	hide_mask();
}

function getPostDataserialize(aForm){
	return $(aForm).serialize();
}

function getPostDataJSON(aForm){
	var o = {};
	$(":input[id]", aForm).each(function(i){
		if(checkTags(this)){
			o[this.id] = this.value;
		}
	});	
	return JSON.stringify(o);
}

function getPostDataXML(aForm){
	var xmlDoc = createXMLDOM();
	xmlDoc.async = false;
	xmlDoc.loadXML('<?xml version="1.0" encoding="UTF-8"?><request/>');
	var xmlRoot = xmlDoc.documentElement;
	var xmlNode, nn;
	try{
		$(":input[id]", aForm).each(function(i){
			if(checkTags(this)){
				nn = this.name; 
				if(nn == "") nn = this.id;
				if(nn == "") return;				
				xmlNode = xmlDoc.createNode(1, nn, "");
				xmlNode.text = this.value;
				xmlRoot.appendChild(xmlNode);
			}
		});			
		return xmlDoc.xml;
	}
	catch(e){
		alert("[" + e.name + "]" + e.message);
	}
}

function doRequest(aFrm, fnSuccessHandler, fnCompleteHandler){
	var _url = aFrm.action;
	try{
		$.ajax({
			type: "POST",
			url: _url,			
			data:getPostDataserialize(aFrm),
			dataType:"json",
			beforeSend:function(){
				show_mask();						
			},
			success: function(data){
				try{
					fnSuccessHandler(data);
					if(fnCompleteHandler != null) {
						fnCompleteHandler();
					}
				}
				finally{
					doPostEnd();
				}
			},
			error:function(o, msg){
				try{				
					alert("AJAX Error:" + msg);
					if(fnCompleteHandler != null) fnCompleteHandler();
				}
				finally{
					doPostEnd();
				}
			}
		});		
	}
	catch(e){
		alert("AJAX doRequest:" + e.message);
		if(fnCompleteHandler != null) fnCompleteHandler();
	}
}

function xmlToJson(obj, dom){
  try{
    obj.result = dom.selectSingleNode("/response/result").text;
    obj.msg = dom.selectSingleNode("/response/msg").text;
    //判断无返回内容时退出
    if(obj.result == 0){return false;}
    //有效，继续获取其它信息
    var nodes = dom.selectNodes("/response/rows/row");
    var i,j;    
    for(i = 0; i< nodes.length; i++){
      node = nodes[i];
      var arr = new Array();
      for(j = 0; j < node.attributes.length; j++)
        arr[node.attributes[j].name] = node.attributes[j].value;
      obj.Items[i] = arr;
    }
  } 
  catch(e){
    alert("[" + e.name + "]" + e.message);
  }
}