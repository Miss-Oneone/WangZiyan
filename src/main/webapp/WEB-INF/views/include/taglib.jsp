<%@ taglib prefix="shiro" uri="/WEB-INF/tlds/shiros.tld" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fns" uri="/WEB-INF/tlds/fns.tld" %>
<%@ taglib prefix="zgfns" uri="/WEB-INF/tlds/zgfns.tld" %>
<%@ taglib prefix="expression" uri="/WEB-INF/tlds/expression.tld" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="zgtags" tagdir="/WEB-INF/tags/zg" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="ctxZG" value="${pageContext.request.contextPath}${zgfns:getAdminPath()}"/>
<c:set var="ctxStatic" value="${pageContext.request.contextPath}/static"/>
<c:set var="ctxStaticZG" value="${pageContext.request.contextPath}/static/zg"/>
