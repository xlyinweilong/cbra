<%@page import="net.sf.json.JsonConfig"%>
<%@page import="net.sf.json.JSONSerializer"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="com.boan.common.json.CalendarJsonValueProcessor"%>
<%@page import="com.boan.common.json.JsonValueInvisibleFilter"%>
<%
	response.addHeader( "Cache-Control", "no-store,no-cache,must-revalidate" );
	response.addHeader( "Cache-Control", "post-check=0,pre-check=0" );
	response.addHeader( "Expires", "0" );
	response.addHeader( "Pragma", "no-cache" );
	request.setCharacterEncoding( "utf-8" );
	response.setCharacterEncoding( "utf-8" );

	Map list = ( Map ) request.getAttribute( "map" );

	String result = "{}";

	if( list != null && list.size() > 0 )
	{
		CalendarJsonValueProcessor processor = new CalendarJsonValueProcessor();
		JsonConfig jsonConfig = new JsonConfig();
		jsonConfig.registerJsonValueProcessor(Calendar.class, processor);
		jsonConfig.setJsonPropertyFilter( new JsonValueInvisibleFilter("none"));
		result = JSONSerializer.toJSON(list, jsonConfig ).toString();
	}
	response.getWriter().write( result);
%>