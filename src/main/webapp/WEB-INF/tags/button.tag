<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag trimDirectiveWhitespaces="true" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ attribute name="id" type="java.lang.String" required="true" description="ID"%>
<%@ attribute name="key" type="java.lang.String" required="true" description="消息ID"%>
<%@ attribute name="iconValue" type="java.lang.String" required="false" description="消息ID"%>
<%@ attribute name="cssClass" type="java.lang.String" required="false" description="css样式"%>
<%@ attribute name="cssStyle" type="java.lang.String" required="false" description="css样式"%>
<%@ attribute name="disabled" type="java.lang.String" required="false" description="是否禁用"%>
<%@ attribute name="visible" type="java.lang.String" required="false" description="是否可见"%>
<%@ attribute name="onclick" type="java.lang.String" required="false" description="点击事件"%>
<%@ attribute name="type" type="java.lang.String" required="false" description="按钮类型"%>
<button id="${id}" ${not empty type  ? 'type=' : ''}${not empty type  ? type : ''}  class="btn ${empty cssClass ? 'btn-primary' : cssClass} ${not empty visible and visible eq 'false' ? 'hide' : ''}" style="${empty cssStyle ? '' : cssStyle}" ${empty disabled or disabled eq 'false' ? '' : 'disabled=\"disabled\"'} onclick="${not empty onclick ? onclick : ''}"><i class="Hui-iconfont">${iconValue}</i><tags:msg key="${key}"/></button>
