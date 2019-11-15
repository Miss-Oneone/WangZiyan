<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="fns" uri="/WEB-INF/tlds/fns.tld" %>
<%@ attribute name="key" type="java.lang.String" required="true" description="I18N Key"%>
<%@ attribute name="arg0" type="java.lang.String" required="false" description="参数0"%>
<%@ attribute name="arg1" type="java.lang.String" required="false" description="参数1"%>
<%@ attribute name="arg2" type="java.lang.String" required="false" description="参数2"%>
<%@ attribute name="arg3" type="java.lang.String" required="false" description="参数3"%>
<%@ attribute name="arg4" type="java.lang.String" required="false" description="参数4"%>
${fns:getGlobalMsg(key,arg0,arg1,arg2,arg3,arg4)}
