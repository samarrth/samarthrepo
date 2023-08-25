<%@page import="javax.lang.model.element.QualifiedNameable"%>
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
	String email = session.getAttribute("email").toString();
	String id = request.getParameter("id");
	String incdec = request.getParameter("quantity");
	int price = 0;
	int total = 0;
	int quantity = 0;
	int final_total = 0;
	{
		try
		{
			Connection con = Connection_Provider.getCon();
			Statement stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery("select * from cartdetails.details where email = '" + email + "' and productid = '"+id+"'");
			while(rs.next())
			{
				price = rs.getInt(3);
				total = rs.getInt(5);
				quantity = rs.getInt(2);
				System.out.print(quantity);
			}
			if(quantity==1 && incdec.equals("dec"))
			{
				System.out.print(quantity);
				response.sendRedirect("cart.jsp?msg=notPossible");
			}
			else if(quantity!=1 && incdec.equals("dec"))
			{
				System.out.print(quantity);
				total = total - price;
				quantity = quantity -1;
				stmt.executeUpdate("update cartdetails.details set total='" + total + "',quantity='"+quantity+"' where email='"+email+"' and productid = '"+id+"'");
				response.sendRedirect("cart.jsp?msg=dec");
			}
			else
			{
				System.out.print(quantity);
				total = total + price;
				quantity = quantity + 1;
				stmt.executeUpdate("update cartdetails.details set total='" + total + "',quantity='"+quantity+"' where email='"+email+"' and productid = '"+id+"'");
				response.sendRedirect("cart.jsp?msg=inc");
			}
			
		}catch(Exception e)
		{
			e.printStackTrace();
		}
	}
%>
</body>
</html>