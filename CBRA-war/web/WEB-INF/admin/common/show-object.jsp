<%@page import="net.sf.json.JsonConfig"%>
<%@page import="net.sf.json.JSONSerializer"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="com.boan.common.json.CalendarJsonValueProcessor"%>
<%
	response.addHeader( "Cache-Control", "no-store,no-cache,must-revalidate" );
	response.addHeader( "Cache-Control", "post-check=0,pre-check=0" );
	response.addHeader( "Expires", "0" );
	response.addHeader( "Pragma", "no-cache" );
	request.setCharacterEncoding( "utf-8" );
	response.setCharacterEncoding( "utf-8" );

	
	Object list = ( Object ) request.getAttribute( "object" );
	String format = (String) request.getAttribute( "format" );
	//获取请求参数
	StringBuffer sb = new StringBuffer();
	if (list != null) {
		CalendarJsonValueProcessor processor = new CalendarJsonValueProcessor("yyyy-MM-dd");
		JsonConfig jsonConfig = new JsonConfig();
		jsonConfig.registerJsonValueProcessor(Calendar.class, processor);
		sb.append(JSONSerializer.toJSON(list, jsonConfig ).toString());
	} else {
		sb.append("{}");
	}
	response.getWriter().write(sb.toString(  ));
%>