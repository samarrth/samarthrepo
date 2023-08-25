<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="project.Connection_Provider"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
	
	try
	{
		
		String id = request.getParameter("id");
		System.out.print("deleted");
		Connection con = Connection_Provider.getCon();
		PreparedStatement pstmt = con.prepareStatement("Delete from productdetails.details where id = ?");
		pstmt.setString(1, id);
		pstmt.executeUpdate();
		response.sendRedirect("adminproduct.jsp?msg=deleted");
		pstmt.close();
		con.close();
	%>
		
	<%}catch(Exception e)
	{
		response.sendRedirect("adminproduct.jsp?msg=error");
		e.printStackTrace();
	}

%>
</body>
</html>