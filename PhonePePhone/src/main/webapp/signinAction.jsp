<%@page import = "project.Connection_Provider"%>
<%@page import = "java.sql.*"%>
<%
String email = request.getParameter("email");
String password = request.getParameter("password");
String conpass = request.getParameter("conpass");
String question = request.getParameter("question");
String answer = request.getParameter("Answer");
boolean b = false;
try
{
	Connection con = Connection_Provider.getCon();
	PreparedStatement pstmt = con.prepareStatement("select * from signupdetails.details where email = ? and questions = ? and answer = ?");
	pstmt.setString(1, email);
	pstmt.setString(2, question);
	pstmt.setString(3, answer);
	ResultSet rs = pstmt.executeQuery();
	
	while(rs.next())
	{
		
		if(password.equals(conpass))
		{
			b=true;
			pstmt = con.prepareStatement("update signupdetails.details set password=? where email=?");
			pstmt.setString(1, password);
			pstmt.setString(2,email);
			pstmt.executeUpdate();
			response.sendRedirect("signin.jsp?msg=done");
		}

	}
	if(b==false)
	{
		response.sendRedirect("signin.jsp?msg=invalid");
	}
}catch(Exception e)
{
	e.printStackTrace();
	
}
%>
