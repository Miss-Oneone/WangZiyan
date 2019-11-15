
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<meta name="decorator" content="default"/>
	<%@ include file="/WEB-INF/views/modules/relateCompany/psnJs.jsp"%>
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
					<tags:label key="姓名" required="true" />
				</div>
				<div class="col-3">
					<tags:text id="relatedPsnName" name="relatedPsnName" value="${relatedPsnName}"></tags:text>
				</div>
			</div>
			<div class="row cl">
				<div class="col-4">
					<tags:label key="职位" />
				</div>
				<div class="col-3">
					<tags:text id="relatedPsnPosition" name="relatedPsnPosition" value="${relatedPsnPosition}"></tags:text>
				</div>
			</div>
			<div class="row cl">
				<div class="col-4">
					<tags:label key="电话号码1" />
				</div>
				<div class="col-3">
					<tags:text id="relatedPsnTel1" name="relatedPsnTel1" value="${relatedPsnTel1}"></tags:text>
				</div>
			</div>
				<div class="row cl">
					<div class="col-4">
						<tags:label key="电话号码2" />
					</div>
					<div class="col-3">
						<tags:text id="relatedPsnTel2" name="relatedPsnTel2" value="${relatedPsnTel2}"></tags:text>
					</div>
				</div>
				<div class="row cl">
					<div class="col-4">
						<tags:label key="电话号码3" />
					</div>
					<div class="col-3">
						<tags:text id="relatedPsnTel3" name="relatedPsnTel3" value="${relatedPsnTel3}"></tags:text>
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