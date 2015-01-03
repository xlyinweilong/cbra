<%@page import="net.sf.json.JsonConfig"%>
<%@page import="net.sf.json.JSONSerializer"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.boan.common.json.CalendarJsonValueProcessor"%>
<%@page import="com.boan.common.json.JsonDateValueProcessor"%>
<%
	response.addHeader( "Cache-Control", "no-store,no-cache,must-revalidate" );
	response.addHeader( "Cache-Control", "post-check=0,pre-check=0" );
	response.addHeader( "Expires", "0" );
	response.addHeader( "Pragma", "no-cache" );
	request.setCharacterEncoding( "utf-8" );
	response.setCharacterEncoding( "utf-8" );

	
	List list = ( List ) request.getAttribute( "list" );
	String jsonRootName =  (String) request.getAttribute( "jsonRootName" );
	//获取请求参数
	StringBuffer sb = new StringBuffer();
	if (list != null && list.size() > 0) {
		CalendarJsonValueProcessor processor = new CalendarJsonValueProcessor("yyyy-MM-dd");
		JsonConfig jsonConfig = new JsonConfig();
		jsonConfig.registerJsonValueProcessor(Date.class, new JsonDateValueProcessor());
		sb.append("{\""+ jsonRootName +"\":" + JSONSerializer.toJSON(list, jsonConfig ).toString());
		sb.append("}");
	} else {
		sb.append("{"+ jsonRootName +":[]}");
	}
	response.getWriter().write(sb.toString(  ));
%>