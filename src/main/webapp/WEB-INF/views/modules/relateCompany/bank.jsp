
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<meta name="decorator" content="default"/>
	<%@ include file="/WEB-INF/views/modules/relateCompany/bankJs.jsp"%>
	<style type="text/css">
		#flag{
			position: absolute;
			left:75%;
			top: 117px;
			color: red;
			white-space: normal;
		}
	</style>
</head>
<body>
<!-- 挡板效果 -->
<div id="over" class="over"></div>
<div id="layout" class="layout"><img src="${ctx}/static/sunsail/images/loading_072.gif" /></div>
<!-- 挡板效果 -->
<div class="content-button">
	<input id="return" class="btn btn-primary" type="button" style="background-color: #3bb4f2" value="返回">
	<input id="save" class="btn btn-primary" type="button" value="保存">
</div>
<div id="selectCondition">
	<div class="content-head">
		<form id="searchForm"  method="post">
			<div class="row cl">
				<!--时间-->
				<div class="col-4">
					<tags:label key="往来单位编码"/>
				</div>
				<div class="col-3">
					<tags:text id="relatedCompyCode" name="relatedCompyCode" value="${relatedCompyCode}" readonly="true"></tags:text>
				</div>
			</div>
			<div class="row cl">
				<!--时间-->
				<div class="col-4">
					<tags:label key="账户名称" required="true"/>
				</div>
				<div class="col-3">
					<tags:text id="relatedAccountName" name="relatedAccountName" value="${relatedAccountName}" maxlength="120"></tags:text>
				</div>
			</div>
			<div class="row cl">
				<div class="col-4">
					<tags:label key="账户号码" required="true"/>
				</div>
				<div class="col-3">
					<tags:text id="relatedAccountNo" name="relatedAccountNo" value="${relatedAccountNo}"  maxlength="30"></tags:text>
				</div>
			</div>
			<div class="row cl">
				<div class="col-4">
					<tags:label key="开户行" />
				</div>
				<div class="col-3">
					<tags:text id="relatedAccountBank" name="relatedAccountBank" value="${relatedAccountBank}" maxlength="120"></tags:text>
				</div>
			</div>
		</form>
		<div id="flag">

		</div>
	</div>
</div>
</div>
</body>

</html>