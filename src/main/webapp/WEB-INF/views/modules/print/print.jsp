<%@ page contentType="text/html;charset=UTF-8" %>
    <%@ include file="/WEB-INF/views/include/taglib.jsp"%>
    <%@ include file="/WEB-INF/views/include/head.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>另存为</title>
<script>
$(document).ready(function(){
$("#btnExport").click(function(){
	$.jBox.confirm("确认要导出订单明细吗？","系统提示",function(v,h,f){
        if(v=="ok"){
        	var sub = document.getElementById("btnExport2");
        	if(/msie/i.test(navigator.userAgent)){
        		sub.click();
        	}else{
        		var e = document.createEvent("MouseEvent");
        		e.initEvent('click', false, false);
        		sub.dispatchEvent(e);
        	}
        }
        return true;
    },{buttonsFocus:1});
	top.$('.jbox-body .jbox-icon').css('top','55px');
});
});
</script>
</head>
<body>
    <div>
        <form action="javascript:0">
            <table border="1" cellpadding="0" cellspacing="0">
                <tr>
                    <td >订单号</td>
                </tr>
                 <tr>
                    <td >M0001</td>
                </tr>
            </table>
            <div>
                <button id="btnExport">另存为</button>
                <a href="${ctxZG}/print/export?priceContractNo=N0001" style="display:none" id="btnExport2">另存为</a>
            </div>
        </form>
    </div>
</body>
</html>