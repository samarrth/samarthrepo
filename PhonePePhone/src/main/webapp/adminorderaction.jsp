<%@page import="java.sql.PreparedStatement"%>
<%@page import="project.Connection_Provider"%>
<%@page import="java.sql.Connection"%>
<%
	String email = request.getParameter("email");
	String status = request.getParameter("status");
	String orderid = request.getParameter("id");
	try
	{
		Connection con = Connection_Provider.getCon();
		if("Cancelled".equals(status))
		{
			String sourcePage = request.getParameter("sourcePage");
			String deliverydate = "cancel";
			PreparedStatement pstmt = con.prepareStatement("update orderdetails.details set status = ?, deliverydate= ? where orderid = ? and email = ? and status = 'bill'");
			pstmt.setString(1, status);
			pstmt.setString(2, deliverydate);
			pstmt.setString(3, orderid);
			pstmt.setString(4, email);
			pstmt.executeUpdate();
			response.sendRedirect(sourcePage);
		}
		if("Delivered".equals(status))
		{
			
			PreparedStatement pstmt = con.prepareStatement("update orderdetails.details set status = ?, deliverydate= now() where orderid = ? and email = ? and status = 'bill'");
			pstmt.setString(1, status);
			pstmt.setString(2, orderid);
			pstmt.setString(3, email);
			pstmt.executeUpdate();
			response.sendRedirect("deliveredorder.jsp");
		}
		System.out.print(status);
		
		
	}catch(Exception e)
	{
		e.printStackTrace();
	}
%>