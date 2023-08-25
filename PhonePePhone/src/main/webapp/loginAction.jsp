<%@page import = "project.Connection_Provider"%>
<%@page import = "java.sql.*"%>
<%
String email = request.getParameter("email");
String password = request.getParameter("password");
if("admin@gmail.com".equals(email) && "admin".equals(password))
{
	session.setAttribute("email", email);
	response.sendRedirect("admin.jsp");
}
else
{
	boolean b = false;
	try
	{
		Connection con = Connection_Provider.getCon();
		Statement stmt = con.createStatement();
		ResultSet rs = stmt.executeQuery("select * from signupdetails.details where email='"+email+"' and password='"+password+"' ");
		while(rs.next())
		{
			b=true;
			session.setAttribute("email", email);
			
		}
		if(b)
		{
			response.sendRedirect("index.jsp");
		}else{
			response.sendRedirect("loginjsp.jsp?msg=notexist");
		}
	}catch(Exception e)
	{
		e.printStackTrace();
		response.sendRedirect("loginjsp.jsp?msg=invalid");
	}
}
%>