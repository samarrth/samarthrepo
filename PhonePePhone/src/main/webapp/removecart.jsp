<%@page import="java.sql.PreparedStatement"%>
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
		String email = session.getAttribute("email").toString();
		System.out.print("try catch get excecuted");
		int productid = Integer.parseInt(request.getParameter("id"));
		System.out.print("deleted");
		Connection con = Connection_Provider.getCon();
		PreparedStatement pstmt = con.prepareStatement("Delete from cartdetails.details where productid = ? and email = ?");
		pstmt.setInt(1, productid);
		pstmt.setString(2, email);
		pstmt.executeUpdate();
		response.sendRedirect("cart.jsp?msg=deleted");
		pstmt.close();
		con.close();
	%>
		
	<%}catch(Exception e)
	{
		response.sendRedirect("cart.jsp?msg=error");
		e.printStackTrace();
	}

%>
</body>
</html>