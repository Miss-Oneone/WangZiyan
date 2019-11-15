<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag trimDirectiveWhitespaces="true" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ attribute name="id" type="java.lang.String" required="false" description="ID"%>
<%@ attribute name="key" type="java.lang.String" required="false" description="消息ID"%>
<%@ attribute name="visible" type="java.lang.String" required="false" description="是否可见"%>
<button type="submit" class="btn btn-success ${not empty visible and visible eq 'false' ? 'hide' : ''}" id="${empty pageScope.id ? 'btnSearch' : pageScope.id}"><i class="Hui-iconfont">&#xe665;</i> <tags:msg key="${empty key ? 'btn_query' : key}"/></button>
