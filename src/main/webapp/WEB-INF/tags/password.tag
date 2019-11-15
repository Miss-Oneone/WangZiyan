<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ attribute name="id" type="java.lang.String" required="true" description="ID"%>
<%@ attribute name="name" type="java.lang.String" required="false" description="名称"%>
<%@ attribute name="value" type="java.lang.String" required="false" description="值"%>
<%@ attribute name="maxlength" type="java.lang.String" required="false" description="最大长度"%>
<%@ attribute name="cssClass" type="java.lang.String" required="false" description="css样式"%>
<%@ attribute name="cssStyle" type="java.lang.String" required="false" description="css样式"%>
<%@ attribute name="required" type="java.lang.String" required="false" description="是否必输"%>
<%@ attribute name="disabled" type="java.lang.String" required="false" description="是否禁用"%>
<%@ attribute name="readonly" type="java.lang.String" required="false" description="是否只读"%>
<%@ attribute name="onblur" type="java.lang.String" required="false" description="光标移开事件"%>
<%@ attribute name="onfocus" type="java.lang.String" required="false" description="光标聚焦事件"%>
<%@ attribute name="onchange" type="java.lang.String" required="false" description="值变更事件"%>
<input type="password" id="${id}" name="${empty pageScope.name ? pageScope.id : pageScope.name}" class="input-text form-text ${cssClass}" 
	maxlength="${empty pageScope.maxlength ? 20 : pageScope.maxlength}"  style="${cssStyle}" value="${value}"
	${empty disabled or disabled eq 'false' ? '' : 'disabled=\"disabled\"'}
	${empty readonly or readonly eq 'false' ? '' : 'readonly=\"readonly\"'}
	${empty required or required eq 'false' ? '' : 'required=\"required\"'}
	onblur="${onblur}" onchange="${onchange}" onfocus="${onfocus}"/>
