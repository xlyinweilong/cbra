<%@ page language="java" pageEncoding="UTF-8"%>
<%
	response.addHeader( "Cache-Control", "no-store,no-cache,must-revalidate" );
	response.addHeader( "Cache-Control", "post-check=0,pre-check=0" );
	response.addHeader( "Expires", "0" );
	response.addHeader( "Pragma", "no-cache" );
	request.setCharacterEncoding( "utf-8" );
	response.setCharacterEncoding( "utf-8" );
	String message = ( String ) request.getAttribute( "message" );
	String id = ( String ) request.getAttribute( "id" );
	//获取请求参数
	StringBuffer sb = new StringBuffer();
	sb.append("{");
	sb.append("\"status\":\"" + message+"\"");
	if(id != null && id.length() > 0)
	{
		sb.append(",\"id\":\"" + id+"\"");
	}
	sb.append("}");
	response.getWriter().write(sb.toString(  ));
%>