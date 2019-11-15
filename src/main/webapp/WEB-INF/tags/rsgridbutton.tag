<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag trimDirectiveWhitespaces="true" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ attribute name="id" type="java.lang.String" required="true" description="ID"%>
<%@ attribute name="key" type="java.lang.String" required="true" description="消息ID"%>
<%@ attribute name="targetID" type="java.lang.String" required="true" description="资源唯一标示符"%>
<%@ attribute name="cssClass" type="java.lang.String" required="false" description="css样式"%>
<%@ attribute name="cssStyle" type="java.lang.String" required="false" description="css样式"%>
<%@ attribute name="disabled" type="java.lang.String" required="false" description="是否禁用"%>
<%@ attribute name="visible" type="java.lang.String" required="false" description="是否可见"%>
<%@ attribute name="onclick" type="java.lang.String" required="false" description="点击事件"%>
<span class="gridBtnSpan ${not empty visible and visible eq 'false' ? 'hide' : ''}"><button id="${id}" class="btn ${empty cssClass ? 'btn-primary' : cssClass}" style="${empty cssStyle ? '' : cssStyle}" ${empty disabled or disabled eq 'false' ? '' : 'disabled=\"disabled\"'} onclick="${not empty onclick ? onclick : ''}"><tags:resourceMsg key="${key}" targetID="${targetID}"/></button></span>