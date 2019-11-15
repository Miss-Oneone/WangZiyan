<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="fns" uri="/WEB-INF/tlds/fns.tld" %>
<%@ attribute name="key" type="java.lang.String" required="true" description="I18N Key"%>
<%@ attribute name="targetID" type="java.lang.String" required="true" description="资源唯一标示符"%>
${fns:getRsMsg(key,targetID)}
