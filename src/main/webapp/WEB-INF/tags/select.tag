<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ attribute name="id" type="java.lang.String" required="true" description="ID"%>
<%@ attribute name="key" type="java.lang.String" required="false" description="消息ID"%>
<%@ attribute name="name" type="java.lang.String" required="false" description="名称"%>
<%@ attribute name="funName" type="java.lang.String" required="true" description="java方法名"%>
<%@ attribute name="parameter" type="java.lang.String" required="false" description="参数"%>
<%@ attribute name="value" type="java.lang.String" required="false" description="选取值"%>
<%@ attribute name="required" type="java.lang.String" required="false" description="是否必输"%>
<%@ attribute name="readonly" type="java.lang.String" required="false" description="是否只读"%>
<%@ attribute name="cssClass" type="java.lang.String" required="false" description="样式css"%>
<%@ attribute name="cssStyle" type="java.lang.String" required="false" description="样式css"%>
<%@ attribute name="width" type="java.lang.String" required="false" description="下拉宽度"%>
<%@ attribute name="disabled" type="java.lang.String" required="false" description="是否禁用"%>
<%@ attribute name="onchange" type="java.lang.String" required="false" description="值变更事件"%>
<span class="select-box ${cssClass}" style = "${cssStyle} width:${empty width ? '70%': width}" >
    <select class="select ${cssClass}" size="1" id="${id}" name="${empty name ? id : name}" 
            ${empty required or required eq 'false' ? '' : 'required=\"required\"'} 
            ${empty disabled or disabled eq 'false' ? '' : 'disabled=\"disabled\"'}
            style = "${cssStyle}" onchange="${onchange}"
            >
    </select>
</span>

<script type="text/javascript">
$(document).ready(function() {
    var funName="${funName}"
    var readonly = "${readonly}"
    var parameter = "${parameter}"
    var required = "${required}"
    var optionList = "${fns:getOptionList(funName,parameter)}"
	var realvalue = "${value}"
  	var objs = eval("("+optionList+")");
    if ($("#${id}").find("option").length == 0){
	    var size = objs.length;
	    if(required!="true"){
		    $("#${id}").append("<option value=''></option>" )
	    }
		for(i=0;i<size;i++){
		    obj = objs[i];
			for(var j in obj){
				var key = j;
				var value = obj[j];
				if(key==realvalue){
				    $("#${id}").append("<option selected value='"+key+"'>"+value+"</option>" )
				}else{
					$("#${id}").append("<option value='"+key+"'>"+value+"</option>" )
				}
			}
		}
    }
    if(readonly=="true"){
		$("#${id}").attr("onmousemove","this.setCapture();")
		$("#${id}").attr("onmouseout","this.releaseCapture();")
		$("#${id}").attr("onmousemove","this.blur();")
	    $("#${id}").parent().css("background-color","#eee")
	    $("#${id}").css("background-color","#eee")
	
	}
    if('${onchange}'){
    	$("#${id}").trigger("change");
    }
});
</script>
