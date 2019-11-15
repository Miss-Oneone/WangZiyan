<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag trimDirectiveWhitespaces="true" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ attribute name="key" type="java.lang.String" required="true" description="I18N Key"%>
<%@ attribute name="targetID" type="java.lang.String" required="true" description="资源唯一标示符"%>
<%@ attribute name="required" type="java.lang.String" required="false" description="是否必填"%>
<%@ attribute name="delimiter" type="java.lang.String" required="false" description="是否显示符号(冒号)"%>
<%@ attribute name="labelfor" type="java.lang.String" required="false" description="标签显示对象"%>
<%@ attribute name="cssClass" type="java.lang.String" required="false" description="css样式"%>
<%@ attribute name="cssStyle" type="java.lang.String" required="false" description="css样式"%>
<label class="${cssClass}" for="${not empty labelfor ? labelfor : ''}" title="${fns:getRsMsg(key,targetID)}">${not empty required && required eq 'true' ? '<span style=\"color: red\">*</span>&nbsp;' : ''}<tags:resourceMsg key="${key}" targetID="${targetID}"/></label>
${(empty delimiter || delimiter eq 'true') && not empty key ? ': ' : ''}
