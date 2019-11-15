<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<html>
<head>
	<meta name="decorator" content="default"/>
	<%@ include file="/WEB-INF/views/modules/mst/pricecontract/importPriceJs.jsp"%>
	<style type="text/css">
		.upload-url {
			display: inline-block !important;
			width: 200px !important;
		}
	</style>
</head>
<body>
<div>&nbsp</div>
<!-- 挡板效果 -->
<div id="over" class="over"></div>
<div id="layout" class="layout"><img src="${ctx}/static/sunsail/images/loading_072.gif" /></div>
<form id="importForm" class="form-horizontal">
	<div class="row cl">
		<div class="col-1">&nbsp;</div>
		<div class="col-10">
			<span class="btn-upload form-group">
				<input class="input-text upload-url" type="text" name="uploadfile-2" id="uploadfile-2" readonly="">
				<a href="javascript:void(0);" class="btn btn-primary upload-btn"><i class="Hui-iconfont"></i> 浏览文件</a>
				<input type="file" name="file" class="input-file" accept="application/vnd.ms-excel">
			</span>
			<p style="margin-bottom: 2px">
				<span style="color: blue">
					注：请确保导入的文件是根据模板进行编辑的，<a href="${ctxZG}/priceContract/exportPriceTemp"><span style="color: blue"><u>点击下载模板</u></span></a>
				</span>
			</p>
		</div>
	</div>
	<br>
	<div class="row cl">
		<div class="col-2">&nbsp;</div>
		<div class="col-2">
			<input id="import" class="btn btn-warning size-M" type="button" value="确认导入" />
		</div>
		<div class="col-4">&nbsp</div>
		<div class="col-2" style="text-align: center;">
			<input id="cancel" class="btn btn-danger size-M" type="button" value="取消"/>
		</div>
	</div>
</form>
</body>
</html>