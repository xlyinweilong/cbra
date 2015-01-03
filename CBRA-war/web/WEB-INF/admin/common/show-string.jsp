<%@ page language="java" pageEncoding="UTF-8"%>
<%
	response.addHeader( "Cache-Control", "no-store,no-cache,must-revalidate" );
	response.addHeader( "Cache-Control", "post-check=0,pre-check=0" );
	response.addHeader( "Expires", "0" );
	response.addHeader( "Pragma", "no-cache" );
	response.setCharacterEncoding( "utf-8" );
	request.setCharacterEncoding( "utf-8" );
	if(request.getAttribute( "info" )!=null){
		response.getWriter().write(request.getAttribute( "info" ).toString());
	}else{
		response.getWriter().write("{}");
	}
%>