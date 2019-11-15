<%@ tag language="java" pageEncoding="UTF-8" %>
<%@ tag trimDirectiveWhitespaces="true" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<%@ attribute name="orderId" type="java.lang.String" required="false" description="订单Id" %>
<%@ attribute name="id" type="java.lang.String" required="true" description="Id" %>
<style>
    .orderDetailBody{
        min-width:450px;
    }

    .orderDetailBody .main{
        position: relative;
        padding:16px;
        border-bottom:1px solid #D5D5D5;
        padding-bottom:6px;
    }
    .orderDetailBody .main .menu-btn{
        position: absolute;
        top:0;
        left:0;
        width:20px;
        height:16px;
        display: inline-block;
        line-height: 16px;
        text-align: center;
        border-right:1px solid #D5D5D5;
        border-bottom:1px solid #D5D5D5;
    }
    .orderDetailBody .main [class^="col-"]{
        height: 25px;
        line-height:25px;
        font-size: 0;
        margin-bottom: 10px;
        white-space:nowrap;
    }
    .orderDetailBody .main [class^="col-"].zh-address-main,
    .orderDetailBody .main [class^="col-"].remark-main{
        height:50px;
    }
    .orderDetailBody .main [class^="col-"] span{
        font-size: 12px;
    }
    .orderDetailBody .main [class^="col-"] .mine-label{
        width:50px;
        display: inline-block;
        vertical-align: top;
    }
    .orderDetailBody .main [class^="col-"] .mine-label-long{
        display: inline-block;
        vertical-align: top;
        padding-right: 10px;
    }
    .orderDetailBody .main [class^="col-"] .mine-label.zh-address + .border,
    .orderDetailBody .main [class^="col-"] .mine-label.remark + .border,
    .orderDetailBody .main [class^="col-"] .mine-label + .freight{
        width:calc(100% - 50px);
        padding:0;
    }
    .orderDetailBody .main [class^="col-"] .mine-label + .freight{
        display: inline-block;
        font-size: 0;
        height: 23px;
        line-height: 23px;
        border-left:1px solid #D5D5D5;
    }

    .orderDetailBody .main [class^="col-"] .mine-label + .freight .border{
        width:25%;
        padding:0;
        margin:0;
        box-sizing: border-box;
        border-right:1px solid #D5D5D5;
    }
    .orderDetailBody .main [class^="col-"] .mine-label.remark + .border{
        height:50px;
        overflow : hidden;
        text-overflow: ellipsis;
        /*display: -webkit-box;*/
        -webkit-line-clamp: 2;
        -webkit-box-orient: vertical;
    }
    .orderDetailBody .main [class^="col-"] .zh-address-info{
        display: inline-block;
        margin-left:50px;
        margin-top: -1px;
    }
    .orderDetailBody .main [class^="col-"] .zh-address-info span{
        vertical-align: middle;
    }
    .border{
        display: inline-block;
        border:1px solid #d5d5d5;
        height:23px;
        line-height:23px;
        padding-right:10px;
        vertical-align: middle;
        min-width:30px;
    }
    .border + .border{
        margin-left:-1px;
    }
</style>
<div class="orderDetailBody" id="orderDetailModal_${id}">
    <div class="main row clearfix">
        <span class="menu-btn">-</span>
        <div class="col-4">
            <span class="mine-label cus-name">托运人</span>
            <span class="border"></span>
        </div>
        <div class="col-7 col-offset-1">
            <span class="mine-label order-name">下单人</span>
            <span class="border"></span>
            <span class="border"></span>
            <span class="border"></span>
        </div>
        <div class="col-4">
            <span class="mine-label bl-no">提单号</span>
            <span class="border"></span>
        </div>
        <div class="col-7 col-offset-1">
            <span class="mine-label case-no">箱号</span>
            <span class="border"></span>
            <span class="border"></span>
        </div>
        <div class="col-4">
            <span class="mine-label product-name">品名</span>
            <span class="border"></span>
        </div>
        <div class="col-7 col-offset-1">
            <span class="mine-label seal-no">封签号</span>
            <span class="border"></span>
        </div>
        <div class="col-4">
            <span class="mine-label tx-address">提箱地</span>
            <span class="border"></span>
        </div>
        <div class="col-4 col-offset-1">
            <span class="mine-label hx-address">还箱地</span>
            <span class="border"></span>
        </div>
        <div class="col-2 bins-type">
            <span class="border"></span>
            <span class="border"></span>
        </div>
        <div class="col-12 zh-address-main">
            <span class="mine-label zh-address">装货地</span>
            <span class="border"></span>
            <div class="zh-address-info col-">
                <span class="border"></span>
                <span class="border"></span>
                <span class="border"></span>
                <span class="border"></span>
            </div>
        </div>
        <div class="col-5">
            <span class="mine-label exp-send-day">到场</span>
            <span class="border"></span>
        </div>
        <div class="col-6 col-offset-1">
            <span class="mine-label-long">客户要求时间</span>
            <span class="border"></span>
        </div>
        <div class="col-12 remark-main">
            <span class="mine-label remark">备注</span>
            <span class="border"></span>
        </div>

    </div>
    <div class="main row clearfix">
        <span class="menu-btn">-</span>
        <div class="col-12">
            <span class="mine-label">运费</span>
            <div class="freight freight-first">
                <span class="border"></span>
                <span class="border"></span>
                <span class="border"></span>
                <span class="border">guanxiren </span>
            </div>
        </div>
        <div class="col-12 re-freight-main">
            <span class="mine-label">改门点</span>
            <div class="freight re-freight">
                <span class="border"></span>
                <span class="border"></span>
                <span class="border"></span>
                <span class="border">guanxiren </span>
            </div>
        </div>
    </div>
    <div class="main row clearfix">
        <span class="menu-btn">-</span>
        <div class="col-4">
            <span class="mine-label ship-owner">船东</span>
            <span class="border"></span>
        </div>
        <div class="col-4">
            <span class="mine-label contn-owner">箱主</span>
            <span class="border"></span>
        </div>
        <div class="col-4">
            <span class="mine-label ship-agent">船代</span>
            <span class="border"></span>
        </div>
        <div class="col-6">
            <%--<span class="mine-label ship-name">船名航次</span>--%>
            <span class="mine-label ship-name">航次</span>
            <span class="border"></span>
            <span class="border"></span>
        </div>
        <div class="col-5">
            <span class="mine-label ship-date">船期</span>
            <span class="border"></span>
        </div>
    </div>
</div>
<script>
    $(".menu-btn").on('click',function(){
        if($(this).text()=='+'){
            $(this).text('-');
            $(this).siblings().show();
        }else{
            $(this).text('+');
            $(this).siblings().hide();
        }
    });

    function initOrderDetail${id}(orderId){
        var content = $("#orderDetailModal_${id}");
        content.hide();
//        return false;
        $.ajax({
            url: '${ctx}/newDispatchSearch/getNoDispatchingOrderInfoFromOrderId',
            type: 'POST',
            data: {
                orderId:orderId
            },
            async: true,
            cache: false,
            success: function (data) {
                data = JSON.parse(data);
                if(data.length>0){
                    data = data[0];
                    $("#orderDetailModal_${id} .cus-name + .border").text(data.compyName);
                    $("#orderDetailModal_${id} .order-name + .border").text(data.compyName);
                    $("#orderDetailModal_${id} .order-name + .border + .border").text(data.cusTel);
                    $("#orderDetailModal_${id} .bl-no + .border").text(data.businessNo1);
                    $("#orderDetailModal_${id} .case-no + .border").text(data.caseNo);
                    $("#orderDetailModal_${id} .case-no + .border + .border").text(data.caseType);
                    $("#orderDetailModal_${id} .product-name + .border").text(data.productName||'无');
                    $("#orderDetailModal_${id} .seal-no + .border").text(data.sealNo||'无');
                    $("#orderDetailModal_${id} .tx-address + .border").text(data.TXAddressName);
                    $("#orderDetailModal_${id} .hx-address + .border").text(data.HXAddressName);
                    $("#orderDetailModal_${id} .zh-address + .border").text(data.ZHAddress1);
                    $("#orderDetailModal_${id} .bins-type .border:nth-of-type(1)").text(data.binsTypeName);
                    $("#orderDetailModal_${id} .bins-type .border:nth-of-type(1) + .border").text(data.ioTypeName);
                    $("#orderDetailModal_${id} .zh-address-info .border:nth-of-type(1)").text(data.ZHContactor1||data.ZHContactor2||data.ZHContactor3);
                    $("#orderDetailModal_${id} .zh-address-info .border:nth-of-type(1) + .border").text(data.ZHPhone1);
                    $("#orderDetailModal_${id} .zh-address-info .border:nth-of-type(1) + .border + .border").text(data.ZHPhone2);
                    $("#orderDetailModal_${id} .zh-address-info .border:nth-of-type(1) + .border + .border + .border").text(data.ZHPhone3);
                    $("#orderDetailModal_${id} .exp-send-day + .border").text(getTime(data.expSendDay));
                    $("#orderDetailModal_${id} .remark + .border").text(data.ordRemark);
                    $("#orderDetailModal_${id} .freight-first .border:nth-of-type(1)").text(data.contaRegionName);
                    $("#orderDetailModal_${id} .freight-first .border:nth-of-type(1) + .border").text(data.contaAddrsName);
                    $("#orderDetailModal_${id} .freight-first .border:nth-of-type(1) + .border +.border").text(data.price);
                    $("#orderDetailModal_${id} .freight-first .border:nth-of-type(1) + .border +.border + .border").text(data.payConpyContactor);
                    //有修改门点才展示
                    if(data.reContaAddrsCode){
                        $("#orderDetailModal_${id} .re-freight .border:nth-of-type(1)").text(data.reContaRegionName);
                        $("#orderDetailModal_${id} .re-freight .border:nth-of-type(1) + .border").text(data.reContaAddrsName);
                        $("#orderDetailModal_${id} .re-freight .border:nth-of-type(1) + .border +.border").text(data.rePrice);
                    }
                    $("#orderDetailModal_${id} .ship-owner + .border").text(data.shipOwnerName);
                    $("#orderDetailModal_${id} .contn-owner + .border").text(data.contnOwnerName);
                    $("#orderDetailModal_${id} .ship-agent + .border").text(data.shipAgentName);
                    $("#orderDetailModal_${id} .ship-name + .border").text(data.shipName);
                    $("#orderDetailModal_${id} .ship-name + .border + .border").text(data.voyage);
                    $("#orderDetailModal_${id} .ship-name + .border + .border").text(data.voyage);
                    $("#orderDetailModal_${id} .ship-date + .border").text(getTime(data.shipDate));
                }
                content.show();
            }
        });
    }
    initOrderDetail${id}('${orderId}');

    //将日期格式化为xxxx-xx-xx;
    function getTime(time){
        if(time && typeof time == "object" && time.time){
            time = time.time;
        }else{
            return;
        }
        var t = new Date(time);
        var m;
        if(t.getMonth() + 1<10){
            m = '0' + (t.getMonth() + 1);
        }else{
            m = (t.getMonth() + 1);
        }
        var d;
        if(t.getDate()<10){
            d = '0' + t.getDate();
        }else{
            d = t.getDate();
        }
        var hh;
        if(t.getHours()<10){
            hh = '0' + t.getHours();
        }else{
            hh =t.getHours();
        }
        var mm;
        if(t.getMinutes()<10){
            mm = '0' + t.getMinutes();
        }else{
            mm = t.getMinutes();
        }
        var dateStr;
        dateStr = t.getFullYear() + '-' + m + '-' + d + ' ' + hh + ':' + mm;

        return dateStr;
    }

</script>
