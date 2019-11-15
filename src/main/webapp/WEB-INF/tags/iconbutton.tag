<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ attribute name="id" type="java.lang.String" required="true" description="ID"%>
<%@ attribute name="name" type="java.lang.String" required="false" description="名称"%>
<%@ attribute name="iconId" type="java.lang.String" required="false" description="图标ID"%>
<%@ attribute name="iconName" type="java.lang.String" required="false" description="图标名称"%>
<%@ attribute name="key" type="java.lang.String" required="true" description="消息ID"%>
<%@ attribute name="onclick" type="java.lang.String" required="false" description="点击事件"%>
<%@ attribute name="cssClass" type="java.lang.String" required="false" description="css样式"%>
<%@ attribute name="cssStyle" type="java.lang.String" required="false" description="css样式"%>
<%@ attribute name="disabled" type="java.lang.String" required="false" description="是否禁用"%>
<button id="${id}" name="${name}" class="btn ${empty cssClass ? 'btn-primary' : cssClass}" style="${empty cssStyle ? '' : cssStyle}" ${empty disabled or disabled eq 'false' ? '' : 'disabled=\"disabled\"'} onclick="return false;"><i class="Hui-iconfont ${iconName}">${empty iconId ? "": "&#" + iconId}</i> <tags:msg key="${key}"/></button>
