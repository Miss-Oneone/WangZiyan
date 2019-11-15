
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <meta name="decorator" content="default"/>
    <%@ include file="/WEB-INF/views/modules/yard/heapContnMoveJs.jsp"%>
    <link href="${ctxStatic}/sunsail/lib/layui/css/layui.css" rel="stylesheet" type="text/css"/>
    <link href="${ctxStatic}/sunsail/lib/layui/lay/mymodules/cascader.css" rel="stylesheet" type="text/css"/>
    <style type="text/css">
        body {
            background-color: rgba(255, 255, 255, 0)!important;
        }
        .layui-form-item {
            text-align: center;
            position: relative;
            top:100px;
            left: 50px;
        }
        input {
            background-color: white!important;
            box-shadow:0 0px 6px rgba(193, 193, 193, 0.8);
        }
        input[end] {
            background-color: #358aed!important;
            position: absolute;
            right: -50px;
            top: 0px;
            height: 38px;
            width: 50px;
            border: 1px solid #358aed;
            color: white;
        }
        input[start] {
            background-color: #fff!important;
            position: absolute;
            top: 0px;
            height: 38px;
            width: 50px;
             border: 1px solid #fff;
            color: gray;
            right: -100px;
        }
    </style>
</head>
<body>
<div class="layui-form-item">
    <%--<label class="layui-form-label">选择框</label>--%>
    <div class="layui-input-block">
        <input type="text" id="heapContnNo" class="layui-input" placeholder="点击选择位置" readonly="readonly">
        <input end type="button" onclick="move()" value="确 定">
        <input start type="button" onclick="back()" value="返 回">
    </div>
    <tags:hidden id="contnNo" value="${contnNo}"></tags:hidden>
</div>
</body>
</html>
