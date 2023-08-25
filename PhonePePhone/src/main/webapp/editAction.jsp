<%@page import = "project.Connection_Provider"%>
<%@page import = "java.sql.*"%>
<%
	String id = request.getParameter("id");
	String name = request.getParameter("pname");
	String details = request.getParameter("pdetails");
	String price = request.getParameter("pprice");
	String type = request.getParameter("ptype");
	
	try
	{
		Connection con = Connection_Provider.getCon();
		Statement stmt = con.createStatement();
		stmt.executeUpdate("update productdetails.details set name='"+name+"',details='" +details+"',price='"+price+"',type='"+type+"',where id = '" +id +"'");
		response.sendRedirect("product.jsp?msg=done");
	}catch(Exception e)
	{
		e.printStackTrace();
	}
%>