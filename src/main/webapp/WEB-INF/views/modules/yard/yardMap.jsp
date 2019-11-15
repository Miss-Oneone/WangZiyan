
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<meta name="decorator" content="default"/>
	<%@ include file="/WEB-INF/views/modules/yard/yardMapJs.jsp"%>
	<link href="${ctxStatic}/sunsail/lib/layui/css/layui.css" rel="stylesheet" type="text/css"/>
	<style type="text/css">
		body {
			overflow: hidden;
		}
		#dragWrapper {
			/*background-color: #ededed!important;*/
		}
		.content-button {
			position: fixed;
			top: 0px;
			left: 0px;
			z-index: 999;
			width: 100%;
			background-color: rgba(255, 255, 255, 0.4);
		}

		.header.header-ios {
			height: 0px;
			background-color: rgba(255, 255, 255, 1);
			position: relative;
		}
		#s-box {
			text-align: center;
			clear: both;
		}
		.s-bar {
		//width: 250px;
			width:90%;
			height: 50px;
			border-radius: 2px;
		//border: 1px solid #ddd;
			border: none;
			margin: 20px calc(5% + 0px);
			display: inline-block;
			float: left;
			padding: 10px 50px;
			box-shadow:0 0px 6px rgba(193, 193, 193, 0.8);
		}
		.s-bar-btn {
			width: 80px;
			height: 36px;
			border-radius: 5px;
			display: inline-block;
			margin: 20px 0;
			float: left;
		}
		.back-icon {
			width: 50px;
			height: 50px;
			position: relative;
			top: -62px;
			left: 5%;
			font-size: 28px;
			color: #404040;
		}
		.clear-icon {
			width: 50px;
			height: 50px;
			position: absolute;
			top: 32px;
			right: 5%;
			font-size: 22px;
			color: #dad8d8;
		}
		#s-option {
			display: none;
			transform: translate3d(0px, -2000px, 0);
			padding: 0 calc(5% + 0px);;
			/*.list-ios {*/
			/*width:100%;*/
			/*height: 1000px;*/
			/*padding-bottom: 500px;*/
			/*float: left;*/
			/*box-shadow:0 0px 6px rgba(193, 193, 193, 0.8);*/
			/*overflow-y: auto;*/
			/*}*/
			/*.list-ios > .item-block:first-child {*/
			/*border-top-left-radius: 2px;*/
			/*border-top-right-radius: 2px;*/
			/*}*/

		}

		.option-item {
			padding-left: 15px;
		}
		p[main] {
			font-size: 15px;
			color: #2d2d2d;
		}
		p[desc] {
			font-size: 14px;
		}
		.option-icon {
			padding-top: 10px;
		}
		ion-icon {
			font-size: 16px;
		}
		.content {
			background: white;
		}
		#dragWrapper{
			background: white;
			width: calc(100vw - 0px);
			height: calc(100vh - 0px);
			position: relative;
		}
		#drag {
			touch-action: auto;
			height: 3685px;
			width: 4252px;
			position: absolute;
			left: 0;
			top: 0;
			/*transform: translate3d(-1420px, -975px, 0px) scale(0.5);*/
			background-image: url('${ctxStatic}/sunsail/images/yard/yard_bg.jpg');
			background-size: cover;
		}

		.item {
			position: absolute;
			width: 80px; height: 40px;
			border: 1px solid #8bc34a;
			background-color: #8bc34a;
		}
		.pos-heavy {
			border: 1px solid #f55a4b;
			background-color: #f55a4b;
		}
		.transf {
			transform-origin: 0% 0%;
			transform: rotate(90deg) translate3d(0px, -40px, 0);
		}
		.stock {
			width: 100%; height: 100%; font-size: 24px; text-align: center; color: white;
		}
		.no {
			font-size: 21px; text-align: center;
			position: absolute;
			border: 1px solid #757575;
			background-color: white;
		}
		.no.no-vertical {
			width: 42px;
			min-height: 28px;
			line-height: 22px;
		}

		.mask {
			width: 100%;
			height: 100%;
			opacity: 0.8;
			position: fixed;
			top: 0;
			left: 0;
			background: white;
			z-index: 2;
		}
		.modal-mask {
			width: 100%;
			height: 100%;
			opacity: 0.4;
			position: fixed;
			top: 0;
			left: 0;
			background: #000;
			z-index: 11;
		}
		.zoom-btn {
			position: fixed;
			bottom: 100px;
			right: 20px;
		}
		.bar-buttons.bar-buttons-ios {
			margin: 0;
			padding: 0;
			box-shadow:0 0px 6px rgba(193, 193, 193, 0.8);
			border-radius: 5px;
		}
		.button[] {
			display: block;
			background: white;
			color: #2d2d2d;
			margin: 0;
			width: 40px;
			height: 40px;
		}
		.button[refresh] {
			margin-bottom: 10px;
			color: #2d2d2d;
		}

		.zoom-btn-left {
			position: fixed;
			bottom: 100px;
			left: 20px;
		}
		.bar-buttons.bar-buttons-ios {
			margin: 0;
			padding: 0;
			box-shadow:0 0px 6px rgba(193, 193, 193, 0.8);
			border-radius: 5px;
		}
		.button[] {
			display: block;
			background: white;
			color: #2d2d2d;
			margin: 0;
			width: 40px;
			height: 40px;
		}

		.contn-position {
			position: absolute;
			top: 0px;
			left: 0px;
			font-size: 30px;
			color: #f54336;
			display: none;
		}

		.ion-buttons {
			margin: 0;
			padding: 0;
			-webkit-box-shadow: 0 0px 6px rgba(193, 193, 193, 0.8);
			border-radius: 5px;
			z-index: 99;
			background-color: rgba(255, 255, 255, 0.1);
		}
		.ion-button {
			display: block;
			width: 40px;
			height: 40px;
			background-color: white;
			border: 1px solid white;
			border-radius: 3px;
		}
		.ion-button[margin] {
			box-shadow: 0 0px 6px rgba(193, 193, 193, 0.8);
			margin-bottom: 5px;
		}
		.ion-button > i {
			font-size: 28px;
		}
		.ion-button[disabled] {
			opacity: 0.6;
		}
		.ion-button i:hover {
			color: #3bb4f2;
		}

		.search-bar {
			position: fixed;
			top:30px;
			left: 80px;
			z-index: 999;
		}
		.search-bar input {
			background-color: white!important;
			box-shadow:0 3px 0px rgba(193, 193, 193, 0.4);
			border: none;
			height: 38px;
			padding-left: 8px;
			width: 300px;
		}
		.search-bar button[end] {
			background-color: #358aed!important;
			box-shadow:0 3px 0px rgba(193, 193, 193, 0.4);
			position: absolute;
			right: -50px;
			top: 0px;
			height: 38px;
			width: 50px;
			border: 1px solid #358aed;
			color: white;
			padding-left: 0px;
		}
		.search-bar button[start] {
			background-color: #fff!important;
			position: absolute;
			top: 0px;
			height: 38px;
			width: 50px;
			border: 1px solid #fff;
			color: gray;
			left: -50px;
			box-shadow:0 3px 0px rgba(193, 193, 193, 0.4);
		}
		.search-bar button[action] {
			background-color: #358aed!important;
			box-shadow: 0 3px 0px rgba(193, 193, 193, 0.4);
			position: absolute;
			right: -135px;
			top: 0px;
			height: 38px;
			width: 84px;
			border: 1px solid #358aed;
			color: white;
		}
		.search-bar button[one] {
			right: -221px;
			text-align: center;
			padding: 0;
		}
		.search-bar button[two] {
			right: -306px;
			text-align: center;
			padding: 0;
		}
		.search-bar i {
			font-size: 25px;
		}
		.contnNoOptions{
			width: 308px;
			max-height: 250px;
			border: 1px solid #CCC6C6;
			background: white;
			position: absolute;
			top: 40px;
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
			background: #eeeeee;
			color: white;
		}
		.heap-type-010 {
			border: 1px solid #f55a4b;
			background-color: #f55a4b;
		}
		.heap-type-020 {
			border: 1px solid #8bc34a;
			background-color: #8bc34a;
		}
		.heap-type-030 {
			border: 1px solid #488aff;
			background-color: #488aff;
		}
		.heap-type-040 {
			border: 1px solid #ffd693;
			background-color: #ffd693;
		}
		.total-info {
			position: absolute;
			top: 10px;
			z-index: 1000;
			right: 20px;
			font-size: 20px;
			color: red;
		}
		.heap-types-tip {
			position: absolute;
			top: 88px;
			z-index: 1000;
			left: 5px;
			font-size: 12px;
			color: #1a1a1a;
			background-color: rgba(255, 255, 255, 0.5);
			padding: 5px;
		}
		.heap-type-tip {
			color: white!important;
		}

		.heap-types {
			display: inline-block;
			position: absolute;
			right: 65px;
			bottom: 27px;
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
		.heap-types .layui-form-item {
			margin-bottom: 0px!important;
		}
		#heap-types-btn:hover {
			color: #3bb4f2;
		}
	</style>
	<script type="text/javascript" src="http://hammerjs.github.io/dist/hammer.min.js"></script>
</head>
<body>
<!-- 挡板效果 -->
<div id="over" class="over"></div>
<div id="layout" class="layout"><img src="${ctx}/static/sunsail/images/loading_072.gif" /></div>
<!-- 挡板效果 -->
<div class="search-bar">
	<input type="text" id="contnNo" onkeyup="inputContnNo(this)" onblur="closeContnNoOptions(this)" class="layui-input" placeholder="箱号" autocomplete="off">
	<button end onclick="search()" value=""><i class="Hui-iconfont">&#xe683;</i></button>
	<button action type="button" class="layui-btn" id="importPlan"><i class="layui-icon">&#xe67c;</i>导入</button>
	<button action one type="button" class="layui-btn" id="importedPlan">已导计划</button>
	<button action two type="button" class="layui-btn" id="planList">计划列表</button>
	<div id="contnNoOptions" class="contnNoOptions">
	</div>
</div>
<%--<div class="total-info">柜量统计：<span id="totalHeapContns"></span></div>--%>
<div class="heap-types-tip">
	<div style="margin-bottom: 5px">箱类型</div>
	<c:forEach items="${heapTypes}" var="heapType">
		<div><div class="heap-type-tip" style="min-width:62px;display: inline-block;background-color: ${heapType.data}" value="${heapType.value}" title="${heapType.label}">${heapType.label}</div><span style="padding-left: 5px">${heapType.count}</span></div>
	</c:forEach>
	<div style="margin-top: 5px">柜量统计：<span id="totalHeapContns" style="padding-left: 7px; color: red"></span></div>
</div>
<div id="dragWrapper">
	<div id="drag" (pinchend)="pinchend($event)">
		<c:forEach var="item" items="${heaps}">
			<div>
				<c:if test="${item.inclination=='' || item.inclination == null}">
					<div class="item transf"  id="${item.heapNo}" title="${item.stock}" onclick="choseContn('${item.heapNo}', '${item.stock}')"
						 style="top: ${item.y}px;left:${item.x}px;background-color:${item.style};border:1px solid ${item.style}">
						<div class="stock">${item.stock}</div>
					</div>
					<div id="code-${item.heapNo}" class="no no-vertical" style="top: ${item.y + 88}px;left:${item.x}px;">
						<c:if test="${item.heapNo.length() == 4}">
							<span>${item.heapNo.substring(0,2)}<br>${item.heapNo.substring(2)}</span>
						</c:if>
						<c:if test="${item.heapNo.length() < 4}">
							<span>${item.heapNo}</span>
						</c:if>
					</div>
				</c:if>
				<c:if test="${item.inclination != '' && item.inclination != null}">
					<div class="item"  title="${item.stock}" id="${item.heapNo}" onclick="choseContn('${item.heapNo}', '${item.stock}')"
						 style="top: ${item.y}px;left:${item.x}px;background-color:${item.style};border:1px solid ${item.style}">
						<div class="stock">${item.stock}</div>
					</div>
					<div id="code-${item.heapNo}" class="no" style="top: ${item.y}px;left:${item.x + 88}px">${item.heapNo}</div>
				</c:if>
			</div>

		</c:forEach>
	</div>
	<i id="pos" class="Hui-iconfont contn-position">&#xe671;</i>
</div>

<div class="heap-types">
	<form class="layui-form" action="">
		<div class="layui-form-item" types>
			<div class="layui-input-block">
				<c:forEach items="${heapTypes}" var="heapType">
					<input type="radio" name="heapType" value="${heapType.value}" title="${heapType.label}"><br>
				</c:forEach>
				<input type="radio" name="heapType" value="" title="全部">
			</div>
			<div class="btn-group">
				<button class="layui-btn" style="float: left;" lay-submit lay-filter="heapTypeSubmit">查询</button>
				<button class="layui-btn" style="float: right" lay-submit lay-filter="heapTypeCancel">返回</button>
			</div>
		</div>
	</form>
</div>

<div class="zoom-btn">
	<div class="ion-buttons">
		<%--<button class="ion-button" margin onclick="create()"><i class="Hui-iconfont">&#xe6df;</i></button>--%>
		<button id="heap-types-btn" title="箱类型" class="ion-button" margin onclick="openHeapType()">全部</button>
		<button class="ion-button" title="刷新" margin onclick="reloadYard()"><i class="Hui-iconfont">&#xe68f;</i></button>
		<button class="ion-button" title="定位" margin onclick="center()"><i class="Hui-iconfont">&#xe6c9;</i></button>
	</div>
	<div class="ion-buttons">
		<button id="scaleAdd" title="放大" class="ion-button" onclick="scaleAdd()"><i class="Hui-iconfont">&#xe600;</i></button>
		<button id="scaleDel" title="缩小" class="ion-button"  onclick="scaleDel()"><i class="Hui-iconfont">&#xe6a1;</i></button>
	</div>
</div>

<div class="zoom-btn-left">
	<ion-buttons>
		<button ion-button  onclick="setting()"><i name="md-person"></i></button>
	</ion-buttons>
</div>
</body>

</html>