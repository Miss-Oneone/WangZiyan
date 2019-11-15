<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag trimDirectiveWhitespaces="true" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ attribute name="id" type="java.lang.String" required="true" description="ID"%>
<%@ attribute name="name" type="java.lang.String" required="false" description="名称"%>
<%@ attribute name="key" type="java.lang.String" required="false" description="消息ID"%>
<%@ attribute name="width" type="java.lang.String" required="false" description="宽度"%>
<%@ attribute name="multiple" type="java.lang.String" required="false" description="是否多选"%>
<input id="upload${id}" name="upload${empty pageScope.name ? pageScope.id : pageScope.name}" class="input-text upload-url" type="text" style="width:${empty pageScope.width ? '200' : pageScope.width}px" readonly><a href="javascript:void();" class="btn btn-primary upload-btn"><tags:msg key="${empty key ? 'btn_selectFile' : key}"/></a>
<input type="file" ${empty multiple or multiple eq 'false' ? '' : 'multiple'} id="${id}" name="${empty pageScope.name ? pageScope.id : pageScope.name}" class="input-file">
