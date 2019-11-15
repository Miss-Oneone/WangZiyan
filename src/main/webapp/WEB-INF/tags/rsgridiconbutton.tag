<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag trimDirectiveWhitespaces="true" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ attribute name="id" type="java.lang.String" required="true" description="ID"%>
<%@ attribute name="key" type="java.lang.String" required="true" description="I18N Key"%>
<%@ attribute name="targetID" type="java.lang.String" required="true" description="资源唯一标示符"%>
<%@ attribute name="iconId" type="java.lang.String" required="true" description="图标ID"%>
<%@ attribute name="cssClass" type="java.lang.String" required="false" description="css样式"%>
<%@ attribute name="cssStyle" type="java.lang.String" required="false" description="css样式"%>
<%@ attribute name="disabled" type="java.lang.String" required="false" description="是否禁用"%>
<%@ attribute name="visible" type="java.lang.String" required="false" description="是否可见"%>
<span class="gridBtnSpan ${not empty visible and visible eq 'false' ? 'hide' : ''}"><button id="${id}" class="btn ${empty cssClass ? 'btn-primary' : cssClass}" style="${empty cssStyle ? '' : cssStyle}" ${empty disabled or disabled eq 'false' ? '' : 'disabled=\"disabled\"'}><i class="Hui-iconfont">&#${iconId};</i><tags:resourceMsg key="${key}" targetID="${targetID}"/></button></span>
