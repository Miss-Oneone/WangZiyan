
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <meta name="decorator" content="default"/>
    <%@ include file="/WEB-INF/views/modules/yard/heapContnJs.jsp"%>
    <link href="${ctxStatic}/sunsail/lib/layui/css/layui.css" rel="stylesheet" type="text/css"/>
    <style type="text/css">
        .item-title {
            height: 30px;
            text-align: center;
            padding: 5px;
            font-size: 24px;
            background-color: #358aed;
            color: white;
        }
        .item-title > div[heap-title] {
            display: inline-block;
            position: absolute;
            left: 240px;
        }
        .item-title > div[heap-type] {
            display: inline-block;
            position: absolute;
            right: 30px;
        }
        .heap-types {
            display: inline-block;
            position: absolute;
            right: 30px;
            top: 44px;
            border: none;
            width: 130px;
            text-align: left;
            box-shadow: 0 4px 5px rgba(0, 0, 0, .15);
            z-index: 10001;
            background-color: white;
            color: grey;
            /*height: 38px;*/
            display: none;
        }
        .heap-types .layui-input-block {
            margin-left: 5px!important;
        }
        .heap-types .layui-btn {
            background-color: #358aed;
            margin-left: 0px;
            border-radius: 0px;
        }
        .heap-types .btn-group {
            /*float: right;*/
        }
        .item-box {
            border-bottom: 1px solid #dddddd;
            padding: 8px 20px 8px 20px;
        }
        .item-box i {
            font-size: 30px;
            color: #333;
        }
        .item-box i:hover {
            color: #3bb4f2;
        }
        div[btn] {text-align: center}
        div[btn]:hover {
            background-color: #eee;
        }
        .item-input {
            border: none;
            width: 100%;
            background-color: #f8f8f8;
            font-size: 14px;
        }
        .item-input.main {
            font-size: 28px;
        }
        .layui-carousel-ind ul {
            position: relative;
            bottom: 60px;
        }
        .footer-btn {
            width: 100%;
            height: 50px;
            position: absolute;
            bottom: 0px;
            z-index: 9999;
            box-shadow:0 0px 6px rgba(193, 193, 193, 0.8);
        }
        .footer-btn button {
            width: 50%;
            float: left;
            height: 100%;
            border: none;
            background-color: white;
        }
        .footer-btn button[main] {
            background-color: #358aed;
            color: white;
        }
        .contnNoOptions{
            width: 198px;
            max-height: 250px;
            border: 1px solid #CCC6C6;
            background: white;
            position: absolute;
            top: 32px;
            z-index: 99999;
            box-shadow: 0 4px 5px rgba(0, 0, 0, .15);
            overflow-y: auto;
            display: none;
        }
        .contnNoOptions p {
            padding-left: 10px;
            margin-bottom: 0px;
            padding-bottom: 3px;
            padding-top: 3px;
        }
        .contnNoOptions p:hover {
            background: #0B61A4;
            color: white;
        }
        .i-show {
            display: inline;
        }
        .i-hide {
            display: none;
        }
        .mask {
            background-color: grey;
            opacity: 0.4;
            position: absolute;
            top:0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: 10000;
            display: none;
        }
        #heap-chose {
            position: absolute;
            z-index: 10000;
            right: 40px;
            font-size: 18px;
            height: 40px;
            line-height: 40px;
            color: white;
        }
        .heap-types .layui-form-item {
            margin-bottom: 0px!important;
        }
        .heap-types-sel {
            width: 100px;
            border: none;
        }
    </style>
</head>
<body>
    <div class="heap-types">
        <form class="layui-form" action="">
            <div class="layui-form-item" types>
                <div class="layui-input-block">
                    <c:forEach items="${heapTypes}" var="heapType">
                        <input type="radio" name="heapType" value="${heapType.value}" title="${heapType.label}"><br>
                    </c:forEach>
                </div>
                <div class="btn-group">
                    <button class="layui-btn" style="float: left;" lay-submit lay-filter="heapTypeSubmit">确定</button>
                    <button class="layui-btn" style="float: right" lay-submit lay-filter="heapTypeCancel">返回</button>
                </div>
            </div>
        </form>
    </div>
    <div id="heap-chose" onclick="openHeapType()" title="点击设置堆类型" heap-type>test</div>
    <div class="mask"></div>
    <div class="layui-carousel" id="container" lay-filter="target">
        <div carousel-item>
            <c:forEach var="heapContnCol" items="${heapContns}" varStatus="pi">
                <div>
                    <div class="item-title">
                        <div heap-title>${heapContnCol.title}</div>
                    </div>
                    <div class="item-list">
                        <c:forEach var="item" items="${heapContnCol.heapContns}" varStatus="i">
                            <div class="item-box">
                                <div class="row cl">
                                    <div class="col-2" style="font-size: 28px">0${item.floor}</div>
                                    <div class="col-5">
                                        <input id="${item.heapContnNo}" value="${item.contnNo}" onkeyup="changeContnNo(this, ${pi.index}, ${i.index})" onblur="closeContnNoOptions(this, ${pi.index}, ${i.index})" placeholder="空" class="item-input main" type="text">
                                        <div id="contnNoOptions-${item.heapContnNo}" class="contnNoOptions">
                                        </div>
                                    </div>
                                    <%--<div btn class="col-1" onclick="editModal(${i.index})"><i class="Hui-iconfont">&#xe692;</i></div>--%>
                                    <div id="del${item.heapContnNo}" btn class="col-1 ${item.contnNo != '' && item.contnNo != null ? "i-show" : "i-hide"}" onclick="del(${pi.index}, ${i.index})"><i class="Hui-iconfont">&#xe609;</i></div>
                                    <div id="move${item.heapContnNo}" btn class="col-1 ${item.contnNo != '' && item.contnNo != null ? "i-show" : "i-hide"}" onclick="move(${pi.index}, ${i.index})"><i class="Hui-iconfont">&#xe644;</i></div>
                                    <div id="up${item.heapContnNo}" btn class="col-1 ${item.contnNo != '' && item.contnNo != null && i.index != 0 ? "i-show" : "i-hide"}" onclick="up(${pi.index}, ${i.index})"><i class="Hui-iconfont">&#xe6d6;</i></div>
                                    <div id="down${item.heapContnNo}" btn class="col-1 ${item.contnNo != '' && item.contnNo != null && i.index != heapContnCol.heapContns.size()-1 ? "i-show" : "i-hide"}" onclick="down(${pi.index}, ${i.index})"><i class="Hui-iconfont">&#xe6d5;</i></div>
                                </div>
                                <div class="row cl">
                                    <div class="col-2">&nbsp;</div>
                                    <div class="col-10">
                                        <div class="col-8">
                                        <input id="r${item.heapContnNo}" value="${item.remarks}" onblur="changeRemarks(this, ${pi.index}, ${i.index})" placeholder="可填写备注" class="item-input" type="text">
                                        </div>
                                        <div class="col-4">
                                            <select id="heap-c-t-${item.heapContnNo}" class="heap-types-sel" onchange="changeHeapContnType(this, ${pi.index}, ${i.index})">
                                                <option value="">箱类型</option>
                                                <c:forEach items="${heapTypes}" var="heapType">
                                                    <option value="${heapType.value}" ${item.heapContnType == heapType.value ? 'selected' : ''}>${heapType.label}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
    <div class="footer-btn">
        <button main onclick="save()">确 定</button>
        <button onclick="cancel()">关 闭</button>
    </div>
</body>