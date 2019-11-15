<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag trimDirectiveWhitespaces="true" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ attribute name="id" type="java.lang.String" required="true" description="ID"%>
<%@ attribute name="name" type="java.lang.String" required="false" description="名称"%>
<%@ attribute name="value" type="java.lang.String" required="false" description="值"%>
<%@ attribute name="maxlength" type="java.lang.String" required="false" description="最大长度"%>
<%@ attribute name="rows" type="java.lang.String" required="false" description="显示行数"%>
<%@ attribute name="cols" type="java.lang.String" required="false" description="显示列数"%>
<%@ attribute name="cssClass" type="java.lang.String" required="false" description="css样式"%>
<%@ attribute name="cssStyle" type="java.lang.String" required="false" description="css样式"%>
<%@ attribute name="disabled" type="java.lang.String" required="false" description="是否禁用"%>
<%@ attribute name="readonly" type="java.lang.String" required="false" description="是否只读"%>
<%@ attribute name="cssStyleSecond" type="java.lang.String" required="false" description="css样式"%>
<textarea id="${id}" name="${empty pageScope.name ? pageScope.id : pageScope.name}" htmlEscape="false" maxlength="${empty pageScope.maxlength ? 200 : pageScope.maxlength}"
	rows="${empty pageScope.rows ? 3 : pageScope.rows}" cols="${empty pageScope.cols ? 30 : pageScope.cols}"
	class="${cssClass}" style="${cssStyle};${not empty readonly and readonly eq true ? 'background-color:#eee' : ''}"
	<c:if test="${not empty disabled and disabled eq true}">disabled="disabled"</c:if>
	<c:if test="${not empty readonly and readonly eq true}">readonly="readonly"</c:if>
	onkeyup="textarealength(this, ${empty pageScope.maxlength ? 200 : pageScope.maxlength})">${pageScope.value}</textarea>
<p class="textarea-numberbar" style="${cssStyleSecond}"><em class="textarea-length">0</em>/${empty pageScope.maxlength ? 200 : pageScope.maxlength}</p>