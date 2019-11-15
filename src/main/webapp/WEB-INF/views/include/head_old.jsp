<%@ page contentType="text/html;charset=UTF-8" %><meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<meta http-equiv="Cache-Control" content="no-store" /><meta http-equiv="Pragma" content="no-cache" /><meta http-equiv="Expires" content="0" />
<meta name="author" content="http://thinkgem.iteye.com"/><meta http-equiv="X-UA-Compatible" content="IE=7,IE=9,IE=10" />
<script src="${ctxStaticZG}/jquery/jquery-1.9.1.min.js" type="text/javascript"></script>
<script src="${ctxStaticZG}/jquery/jquery-ui-1.9.2.custom.min.js" type="text/javascript"></script>
<link href="${ctxStaticZG}/jquery/jquery-ui-1.9.2.custom.css" type="text/css" rel="stylesheet" />
<script src="${ctxStaticZG}/jquery/jquery-migrate-1.1.1.min.js" type="text/javascript"></script>
<link href="${ctxStaticZG}/jquery-validation/1.11.1/jquery.validate.css" type="text/css" rel="stylesheet" />
<script src="${ctxStaticZG}/jquery-validation/1.11.1/jquery.validate.js" type="text/javascript"></script>
<script src="${ctxStaticZG}/jquery-validation/1.11.1/jquery.validate.method.min.js" type="text/javascript"></script>
<link href="${ctxStaticZG}/bootstrap/2.3.1/css_${not empty cookie.theme.value ? cookie.theme.value:'default'}/bootstrap.min.css" type="text/css" rel="stylesheet" />
<script src="${ctxStaticZG}/bootstrap/2.3.1/js/bootstrap.min.js" type="text/javascript"></script>
<!--[if lte IE 6]><link href="${ctxStaticZG}/bootstrap/bsie/css/bootstrap-ie6.min.css" type="text/css" rel="stylesheet" />
<script src="${ctxStaticZG}/bootstrap/bsie/js/bootstrap-ie.min.js" type="text/javascript"></script><![endif]-->
<!-- Le HTML5 shim, for IE6-8 support of HTML5 elements -->
<!--[if lt IE 9]> <script src="${ctxStaticZG}/common/html5.js"></script><![endif]-->
<script src="${ctxStaticZG}/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script src="${ctxStaticZG}/common/mustache.min.js" type="text/javascript"></script>
<script src="${ctxStaticZG}/list/list.min.js" type="text/javascript"></script>
<script src="${ctxStaticZG}/select2/select2.js" type="text/javascript"></script>
<script src="${ctxStaticZG}/select2/select2_locale_zh-CN.js" type="text/javascript"></script>
<link href="${ctxStaticZG}/select2/select2.css" type="text/css" rel="stylesheet" />
<link href="${ctxStaticZG}/x-editable/css/bootstrap-editable.css" type="text/css" rel="stylesheet" />
<script src="${ctxStaticZG}/x-editable/js/bootstrap-editable.js" type="text/javascript"></script>
<link href="${ctxStaticZG}/fancyBox/source/jquery.fancybox.css" type="text/css" rel="stylesheet" />
<script src="${ctxStaticZG}/fancyBox/source/jquery.fancybox.js" type="text/javascript"></script>
<link href="${ctxStaticZG}/common/jeesite.css" type="text/css" rel="stylesheet" />
<script src="${ctxStaticZG}/common/jeesite.js" type="text/javascript"></script>
<%--
    引入DataTables控件
--%>
<link href="${ctxStaticZG}/datatables/css/jquery.dataTables.css" rel="stylesheet" type="text/css" media="screen"/>
<script src="${ctxStaticZG}/datatables/js/jquery.dataTables.js" type="text/javascript"></script>

<%-- 添加 jqGrid --%>
<script src="${ctxStaticZG}/jqGrid/ui.multiselect.js" type="text/javascript"></script>
<script src="${ctxStaticZG}/jqGrid/jquery.jqGrid.js" type="text/javascript"></script>
<script src="${ctxStaticZG}/jqGrid/grid.locale-cn.js" type="text/javascript"></script>
<script src="${ctxStaticZG}/jqGrid/grid.postext.js" type="text/javascript"></script>
<script src="${ctxStaticZG}/jqGrid/x-theme-default.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" media="screen" href="${ctxStaticZG}/jqGrid/ui.jqgrid.css" />
<link rel="stylesheet" type="text/css" media="screen" href="${ctxStaticZG}/jqGrid/ui.multiselect.css" />
<link rel="stylesheet" type="text/css" media="screen" href="${ctxStaticZG}/jqGrid/x-theme-default.css" />

<script type="text/javascript" src="${ctxStaticZG}/jqGrid/jquery-ui-timepicker-addon.js"></script>
<script type="text/javascript" src="${ctxStaticZG}/jqGrid/x-common.js"></script>
<script type="text/javascript" src="${ctxStaticZG}/jqGrid/x-ajax.jquery.js"></script>
<script type="text/javascript" src="${ctxStaticZG}/jqGrid/x-webx.jquery.js"></script>
<link rel="stylesheet" type="text/css" href="${ctxStaticZG}/jqGrid/app-custom.css"/>

<link href="${ctxStaticZG}/jquery-jbox/2.3/Skins/Bootstrap/jbox.css" rel="stylesheet" />
<script src="${ctxStaticZG}/jquery-jbox/2.3/jquery.jBox-2.3.min.js" type="text/javascript"></script>
<script src="${ctxStaticZG}/jquery-jbox/2.3/i18n/jquery.jBox-zh-CN.min.js" type="text/javascript"></script>

<script type="text/javascript" src="${ctxStaticZG}/jquery/layout/jquery.layout-latest.js"></script>
<link rel="stylesheet" type="text/css" href="${ctxStaticZG}/jquery/layout/layout-default-latest.css"/>
<%--
  OMS项目css
 --%>
<link href="${ctxStaticZG}/common/oms-common.css" rel="stylesheet" type="text/css" media="screen"/>
<script src="${ctxStaticZG}/common/oms-common.js" type="text/javascript"></script>

<script src="${ctxStaticZG}/ip-common/js/ip-js-common.js" type="text/javascript"></script>
<%--
    项目公共JS
--%>
<script type="text/javascript">
var ctx = "${ctx}";
var ctxStatic = "${ctxStaticZG}";
var pageSizeStr = "${pageSize}";
</script>
<link href="${ctxStaticZG}/common/pjcommon.css" rel="stylesheet" type="text/css" media="screen"/>
<script src="${ctxStaticZG}/common/pjcommon.js" type="text/javascript"></script>
<link rel="shortcut icon" href="${ctxStaticZG}/favicon.ico">

<!-- 遮罩层 -->
<style type="text/css">
#fullbg
{
	position:absolute;
	filter:alpha(opacity=50);
	-moz-opacity:0.5;
	-phtml-opacity:0.5;
	opacity:0.5;
	z-index:998;
	background-color:#F8F8FF;
	display:none;
}
</style>
<div id="fullbg"></div>
