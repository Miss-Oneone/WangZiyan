 <%@ page contentType="text/html;charset=UTF-8"%>
    <%@ include file="/WEB-INF/views/include/taglib.jsp"%>
    <html>
    <head>
        <meta name="decorator" content="default_zg"/>
        <title>打印预览</title>
        <style type="text/css">
            body{
                box-sizing: border-box;
                height:100%;
                padding:16px;
                overflow: hidden;
            }
            .btns-content{
                padding-bottom:16px;
            }
        iframe{
            width:100%;
            height:90%;
        }

            #btnPrint{
                width:180px;
            }
    </style>
<script>
$(document).ready(function(){
$("#btnPrint").click(function(){
    var urlArr = "${PdfUrl}".split("orderNos=");
    var orderNos = urlArr.length > 1 ? urlArr[1] : '';
    if(orderNos){
        $.ajax({
            type: "POST",
            url: "${ctxZG}/printIframePDF/addPrintNumber",
            data:{
                "orderNos":orderNos
            },
            dataType: "json",
            success: function(json) {
                silentPrint("${PdfUrl}");
            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                console.log("联系管理员！");
                $.jBox.closeTip();
                $.jBox.error(XMLHttpRequest.status + ":" + XMLHttpRequest.statusText);
            }
        });
    }

});

});
</script>
</head>
<body>
    <div class="btns-content">
        <button class="btn btn-warning" id="btnPrint">打印</button>
    </div>
    <iframe src="${PdfUrl}" frameborder="0"></iframe>
</body>
</html>