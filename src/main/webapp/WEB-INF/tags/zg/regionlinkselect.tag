<%@ tag language="java" pageEncoding="UTF-8" %>
<%@ tag trimDirectiveWhitespaces="true" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<%@ attribute name="path" type="java.lang.String" required="true" description="路径"%>
<%@ attribute name="name" type="java.lang.String" required="false" description="名称" %>
<%@ attribute name="width" type="java.lang.String" required="false" description="宽度" %>
<%@ attribute name="localData" type="java.lang.String" required="false" description="下拉选项数据(JSON格式)" %>
<%@ attribute name="required" type="java.lang.String" required="false" description="是否必输" %>
<%@ attribute name="disabled" type="java.lang.String" required="false" description="是否可编辑" %>
<%@ attribute name="onchange" type="java.lang.String" required="false" description="值变更事件" %>
<%@ attribute name="cssClass" type="java.lang.String" required="false" description="样式" %>
<%@ attribute name="isShowZxdAddress" type="java.lang.String" required="false" description="是否显示五级地址" %>

<form:select path="${path}Province" cssClass="district"
			 onchange="changeAddrs('${path}', 1)"
			 disabled="${empty disabled or disabled eq 'false' ? false : true}">
	<form:option value="" label="省"/>
	<form:options  itemValue="code" itemLabel="name"/>
</form:select>
<form:select path="${path}City" cssClass="district"
			 onchange="changeAddrs('${path}', 2)"
			 disabled="${empty disabled or disabled eq 'false' ? false : true}">
	<form:option value="" label="市"/>
	<form:options itemValue="code" itemLabel="name"/>
</form:select>
<form:select path="${path}District" cssClass="district"
			 onchange="changeAddrs('${path}', 3)"
			 disabled="${empty disabled or disabled eq 'false' ? false : true}">
	<form:option value="" label="区/县"/>
	<form:options  itemValue="code" itemLabel="name"/>
</form:select>
<form:select path="${path}County" cssClass="district"
			 onchange="changeAddrs('${path}', 4)"
			 disabled="${empty disabled or disabled eq 'false' ? false : true}">
	<form:option value="" label="乡/镇"/>
	<form:options itemValue="code" itemLabel="name"/>
</form:select>
<c:if test="${empty isShowZxdAddress ? true : false}">
<form:select path="${path}ZxdAddrs" cssClass="zxd-select ${cssClass}"
			 onchange="choseZxdAddrs('${path}')"
			 disabled="${empty disabled or disabled eq 'false' ? false : true}">
	<form:option value="" label="地点"/>
	<form:options itemValue="code" itemLabel="name"/>
</form:select>
</c:if>
<script type="application/javascript">
    $(".district").chosen({allow_single_deselect: true, no_results_text: "未找到此选项！", width: "80px"});
    $(".zxd-select").chosen({allow_single_deselect: true, no_results_text: "未找到此选项！", width: "150px"});
</script>



